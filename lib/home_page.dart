import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List position = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int turns = 0;
  bool xTurns = true;
  int indexx = 0;

  void setX(int index) {
    if(xTurns&&position[index]==''){
      setState(() {
        position[index] = 'X';
      });
      indexx = index;
      turns++;
    }
    xTurns = !xTurns;
    setWinningLogic();
  }

  void setO(int index) {
    if(!xTurns&&position[index]==''){
      setState(() {
        position[index] = '0';
      });
      indexx = index;
      turns++;
    }
    xTurns = !xTurns;
    setWinningLogic();
  }

  void incrementScore(int index){
    if(position[index]=='X'){
      setState(() {
        xScore++;
      });
    }else{
      setState(() {
        oScore++;
      });
    }
  }

  void reset(){
    setState(() {
      position =  ['', '', '', '', '', '', '', '', ''];
    });
    turns = 0;
    xTurns = true;
  }

  void setWinningLogic(){
    if(position[0]!=''&&position[0]==position[1]&&position[1]==position[2]){
          showWinnerAlertDialog();
    }
    else if(position[3]!=''&&position[3]==position[4]&&position[4]==position[5]){
          showWinnerAlertDialog();
    }
    else if(position[6]!=''&&position[6]==position[7]&&position[7]==position[8]){
          showWinnerAlertDialog();
    }
    else if(position[0]!=''&&position[0]==position[4]&&position[4]==position[8]){
          showWinnerAlertDialog();
    }
    else if(position[2]!=''&&position[2]==position[4]&&position[4]==position[6]){
          showWinnerAlertDialog();
    }
    else if(position[0]!=''&&position[0]==position[3]&&position[3]==position[6]){
      showWinnerAlertDialog();
    }
    else if(position[1]!=''&&position[1]==position[4]&&position[4]==position[7]){
      showWinnerAlertDialog();
    }
    else if(position[2]!=''&&position[2]==position[5]&&position[5]==position[8]){
      showWinnerAlertDialog();
    }
    else if(turns==9){
      Alert(
        context: context,
        type: AlertType.info,
        title: "RESULT",
        desc: "OOPS!! It's Draw",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              reset();
            },
            width: 120,
          )
        ],
      ).show();
    }
  }

  String selectPlayer(){
    if(position[indexx]=='X'){
      return 'Player X';
    }else{
      return 'Player 0';
    }
  }

  void showWinnerAlertDialog(){
    String winner = selectPlayer();
    Alert(
      context: context,
      type: AlertType.success,
      title: "RESULT",
      desc: "Congratulations! $winner is Winner",
      buttons: [
        DialogButton(
          child: Text(
            "Thanks",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            incrementScore(indexx);
            reset();
          },
          width: 120,
        )
      ],
    ).show();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 2.0,
          ),
          Text(
            'ScoreBoard',
            style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 30,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic),
          ),
          Expanded(
            flex: 0,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Player 0',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '${oScore.toString()}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Player X',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '${xScore.toString()}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    if (turns % 2 != 0) {
                      setO(index);
                    } else {
                      setX(index);
                    }
                  },
                  child: Card(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${position[index]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 80.0,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  xScore = 0;
                  oScore = 0;
                });
              },
              child: Text(
                'RESET GAME',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
