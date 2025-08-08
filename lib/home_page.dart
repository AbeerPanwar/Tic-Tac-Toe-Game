import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TicTacToeHomePagState extends StatefulWidget {
  const TicTacToeHomePagState({super.key});

  @override
  State<TicTacToeHomePagState> createState() => _TicTacToeHomePagStateState();
}

class _TicTacToeHomePagStateState extends State<TicTacToeHomePagState> {

  bool isTurnO = true;
  bool isWinnerFound = false;
  List<String> displaySign = ['','','','','','','','','',];
  String result = '';
  int oScore = 0;
  int xScore = 0;
  int boxesFilled = 0;
  int attempts = 0;

  static const maxSeconds = 20;
  int time = maxSeconds;
  Timer? timer;

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (_){
      setState(() {
        if(time > 0){
          time--;
        }else{
          stopTimer();
        }
      });
    });
  }

  void stopTimer(){
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => time = maxSeconds;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade500,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Player O',
                        style: GoogleFonts.chewy(textStyle: TextStyle(fontSize: 34,color: Colors.yellow.shade600)),
                      ),
                      Text(
                        oScore.toString(),
                        style: GoogleFonts.chewy(textStyle: TextStyle(fontSize: 28,color: Colors.yellow.shade600)),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Player X',
                        style: GoogleFonts.chewy(textStyle: TextStyle(fontSize: 34,color: Colors.yellow.shade600)),
                      ),
                      Text(
                        xScore.toString(),
                        style: GoogleFonts.chewy(textStyle: TextStyle(fontSize: 28,color: Colors.yellow.shade600))
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    onTap: () {
                      isWinnerFound? (){} : _tapped(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade700,
                          borderRadius: BorderRadius.circular(16),
                          border: BoxBorder.all(
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                        child: Text(
                          displaySign[index],
                          style: GoogleFonts.knewave(
                            textStyle: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: displaySign[index] == 'X'? Colors.blue.shade800 : Colors.red.shade700,
                            ),
                          ),
                        ),
                      ),
                    ) ,
                  );
                }
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    result , 
                    style: GoogleFonts.chewy(textStyle: TextStyle(fontSize: 40, color: Colors.yellow.shade600)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildTimer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index){
    final isRunning = timer == null? false : timer!.isActive;

    if(isRunning){
      setState(() {
        if(isTurnO && displaySign[index] == ''){
          displaySign[index] = 'O';
          boxesFilled++;
        }else if ( !isTurnO && displaySign[index] == '') {
          displaySign[index] = 'X';
          boxesFilled++;
        }
        isTurnO = !isTurnO;
        _checkWinner();
      });
    }
    
  }

  void _checkWinner(){
    
    // check 1st row
    if(displaySign[0] == displaySign[1] &&
       displaySign[0] == displaySign[2] &&
       displaySign[0] != ''){
      setState(() {
          result = 'Player ${displaySign[0]} Wins !';
          _updateScore(displaySign[0]);
          stopTimer();
      });
    }

    // check 2nd row
    if(displaySign[3] == displaySign[4] &&
       displaySign[3] == displaySign[5] &&
       displaySign[3] != ''){
      setState(() {
          result = 'Player ${displaySign[3]} Wins !';
          _updateScore(displaySign[3]);
          stopTimer();
      });
    }

    // check 3rd row
    if(displaySign[6] == displaySign[7] &&
       displaySign[6] == displaySign[8] &&
       displaySign[6] != ''){
      setState(() {
          result = 'Player ${displaySign[6]} Wins !';
          _updateScore(displaySign[6]);
          stopTimer();
      });
    }

    // check 1st column
    if(displaySign[0] == displaySign[3] &&
       displaySign[0] == displaySign[6] &&
       displaySign[0] != ''){
      setState(() {
          result = 'Player ${displaySign[0]} Wins !';
          _updateScore(displaySign[0]);
          stopTimer();
      });
    }

    // check 2nd column
    if(displaySign[1] == displaySign[4] &&
       displaySign[1] == displaySign[7] &&
       displaySign[1] != ''){
      setState(() {
          result = 'Player ${displaySign[1]} Wins !';
          _updateScore(displaySign[1]);
          stopTimer();
      });
    }

    // check 3rd column
    if(displaySign[2] == displaySign[5] &&
       displaySign[2] == displaySign[8] &&
       displaySign[2] != ''){
      setState(() {
          result = 'Player ${displaySign[2]} Wins !';
          _updateScore(displaySign[2]);
          stopTimer();
      });
    }

    // check right diagnol
    if(displaySign[2] == displaySign[4] &&
       displaySign[2] == displaySign[6] &&
       displaySign[2] != ''){
      setState(() {
          result = 'Player ${displaySign[2]} Wins !';
          _updateScore(displaySign[2]);
          stopTimer();
      });
    }

    // check left diagnol
    if(displaySign[0] == displaySign[4] &&
       displaySign[0] == displaySign[8] &&
       displaySign[0] != ''){
      setState(() {
          result = 'Player ${displaySign[0]} Wins !';
          _updateScore(displaySign[0]);
          stopTimer();
      });
    }

    if(!isWinnerFound && boxesFilled == 9){
      setState(() {
        result = 'Nobody Wins !';
        stopTimer();
      });
    }
  }

  void _updateScore(String winner){
    if(winner == 'O'){
      oScore++;
    }else if(winner == 'X'){
      xScore++;
    }
    isWinnerFound = true;
  }

  void _clearBoard(){
    setState(() {
      for(int i = 0; i < 9; i++){
        displaySign[i] = '';
      }
      result = '';
    });
    boxesFilled = 0;
    isWinnerFound = false;
  }

  Widget _buildTimer() {
    final isRunning = timer == null? false : timer!.isActive;

    return isRunning ? SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1-time/maxSeconds,
            valueColor: AlwaysStoppedAnimation(Colors.black87),
            strokeWidth: 8,
            backgroundColor: Colors.yellow.shade700,
          ),
          Center(
            child: Text(
              '$time',
              style: GoogleFonts.chewy(textStyle: TextStyle(fontSize: 35,color: Colors.black)),
            ),
          )
        ],
      ),
    ) : 
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow.shade700,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      ),
      onPressed:(){ 
        startTimer();
        _clearBoard();
        attempts++;
      }, 
      child: Text(
        attempts == 0? 'Start' : 'Play Again !',
        style: GoogleFonts.chewy(textStyle: TextStyle(fontSize: 22, color: Colors.black)),
      ),
    );
  }
}