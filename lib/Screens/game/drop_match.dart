import 'dart:math';

import 'package:dropmatchgame/Data/crud_helper.dart';
import 'package:dropmatchgame/Models/score_model.dart';
import 'package:dropmatchgame/Screens/game/settings.dart';
import 'package:dropmatchgame/Widgets/snackbar.dart';
import 'package:flutter/material.dart';

class DropMatch extends StatefulWidget {
  const DropMatch({super.key});

  @override
  State<DropMatch> createState() => _DropMatchState();
}

class _DropMatchState extends State<DropMatch> {
  final int gridSize = 6;
  late List<List<Color?>> grid;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.indigo,
  ];
  late Color currentColor;
  Random random = Random();

  int score = 0;

  @override
  void initState() {
    super.initState();
    resetGrid();

    /*randomly selects a color from the colors list and assigns it to the currentColor variable. This ensures that currentColor will be set to a different color each time this line is executed*/
    currentColor = colors[random.nextInt(colors.length)];
  }

  /*The resetGrid function creates a 2D list structure where each sublist represents 
  a row of the grid, and each element in the sublist (row) is null. 
  This effectively initializes or resets the grid to an empty state, 
  where no cells are occupied.*/
  void resetGrid() {
    //grid is assigned a new list using the List.generate method
    grid = List.generate(
      gridSize,
      (_) => List.generate(gridSize, (_) => null),
    );
    score = 0;
  }

  bool checkMatch() {
    // Check rows
    /*
    1. This loop iterates over each row in this grid.
    2. i is the loop variable representing the current row index.
    3. grid[i] accesses the current row.
    4. .every((color) => ...) is a method that checks if every element in the 
       the row satisfies the given condition.
    5. color != null ensures the cell is not empty
    6. color == grid[i][0] ensures that the color of the cell is the same as the 
       color of the first cell in the row
    */
    for (int i = 0; i < gridSize; i++) {
      if (grid[i].every((color) => color != null && color == grid[i][0])) {
        return true;
      }
    }

    // Check columns
    /* 
    1. This loop iterates over each column in this grid.
    2. j is the loop variable representing the current column index.
    3. columnMatch is a boolean variable that starts as true. 
       It will be used to track whether the current column has a match.
    4. firstColor is assigned the color of the first cell in the current column (grid[0][j]).
    5. "if (firstColor == null) continue;" If the first cell in the column is null, 
       the loop skips to the next column (continue).
    */
    for (int j = 0; j < gridSize; j++) {
      bool columnMatch = true;
      Color? firstColor = grid[0][j];
      if (firstColor == null) continue;
      /* 
      1. inner loop iterates over the remaining cell.
      2. It compares each cell in the column (grid[i][j]) to firstColor.
      3. If any cell in the column does not match firstColor, 
         columnMatch is set to false and the inner loop breaks (exits early).
      */
      for (int i = 1; i < gridSize; i++) {
        if (grid[i][j] != firstColor) {
          columnMatch = false;
          break;
        }
      }
      if (columnMatch) return true;
    }

    return false;
  }

  /* 
  1. The function takes two parameters, row and col, 
     which represent the coordinates of the cell where the color is being dropped.
  2. If cell is empty, it assigns the current color to that cell, and increases the
     score by 5. The currentColor resets immedietly
  3. The checkMatch function is called to determine if there is a match 
     (either a full row or column with the same color). If a match is found, 
     the score is increased by 10 points. A snackbar with the message "You Scored 🥳!" is shown.
     The grid is reset by calling resetGrid.
  4. If no match is found, the function checks if the grid is completely filled 
     (no null values left) using the every method on the grid.
  */
  void handleDrop(int row, int col) {
    final database = UserDBHelper();

    setState(() {
      if (grid[row][col] == null) {
        grid[row][col] = currentColor;
        score += 5;
        currentColor = colors[random.nextInt(colors.length)];

        if (checkMatch()) {
          score += 10;
          snackBar(context, "You Scored 🥳!");

          database.createScore(
            ScoreModel(id: Random().nextInt(1000), score: score),
          );

          resetGrid();
        } else if (grid.every((row) => row.every((color) => color != null))) {
          score -= 10;
          snackBar(context, "Game Over 😥!");

          database.createScore(
            ScoreModel(id: Random().nextInt(1000), score: score),
          );

          resetGrid();
        }
      }
    });
  }

  Widget buildGrid() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        gridSize,
        (row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              gridSize,
              (col) {
                return DragTarget<Color>(
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      width: 40,
                      height: 40,
                      color: grid[row][col] ?? Colors.grey[200],
                    );
                  },
                  onAcceptWithDetails: (_) => handleDrop(row, col),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildDraggableColor() {
    return Draggable<Color>(
      data: currentColor,
      feedback: buildColorBox(currentColor, true),
      childWhenDragging: buildColorBox(currentColor, false),
      child: buildColorBox(currentColor),
    );
  }

  Widget buildColorBox(Color color, [bool isDragging = false]) {
    return Container(
      width: 40,
      height: 40,
      color: isDragging ? color.withOpacity(0.5) : color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Drop Match Game'),
        actions: [
          IconButton(
            onPressed: () {
              var route = MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              );
              Navigator.push(context, route);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Score: $score',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 50),
            buildGrid(),
            const SizedBox(height: 50),
            buildDraggableColor(),
          ],
        ),
      ),
    );
  }
}
