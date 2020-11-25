# AnimatedFAB

## Description:
### A Gmail like FloatingActionButton which expands when the user scrolls up.

![Fab1](./fab2.gif) ![Fab2](./fab.gif)

## Usage:
### In your scaffold:
    floatingActionButton: AnimatedFAB(
        scrollController: scrollController,
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        text: 'Add',
        maxWidth: 50,
        backgroundColor: Colors.teal,
        onTap: () {
          print("tapped");
        },
        // textStyle: whatever
        // contentPaddingFactor: whatever
      ),

### Make sure a valid scroll controller is provided.

## Add to your project
### In your pubspec.yaml
    dependencies:
      flutter:
        sdk: flutter

      animated_fab:
        git: 
          url: https://github.com/simrat39/animated_fab
