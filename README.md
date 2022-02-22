There are 2 files : Hangman.pl and README.md

You can run the program using the command perl Hangman.pl in the terminal.

The Following Instructions Should Be Followed While Playing HANGMAN GAME (Running The Program) :

    A. Open the terminal in the directory 2020CSB1113 and Enter the command perl Hangman.pl to run the program.
    B. When it is asked by the program to make a guess, you have to guess only one letter.
    C. In case multiple letters are entered, only the first letter is considered and others stripped off automatically.
    D. Carefully read all the messages displayed by the program and input according to it.
    E. When asked for another game enter y/Y for another game and any other character for exiting it.

The class HangMan is created in the given code and inside it the functions/subroutines are defined to run it.

If you wish to add some more random words to the game, you can add those in the array @words in the code on line 6.

The start function is called to start the game, after that clear is called which clears previous game data.

The array @hanged_parts stores the parts that have been hung till now, with every wrong guess it is updated.

The word is chosen randomly from the list of words in the code.

The Input is taken by the function guess in the class HangMan : 

    - Input is expected to be a single aphanumeric character.
    - If it is not a single character and a lot of characters then the first letter is only considered and all others stripped off.
    - If the entered first character is a blank space or new line then the error is displayed.

After every guess the guessed word is updated or the chances decreased using update function :

    - If the guessed letter is already guessed then the message is displayed that it has already been guessed and function returns from there.
    - If not already guessed then it is pushed in the array @guesses and is checked whether it is present in the word or not.
    - If the letter is present in word then it is a good guess and is updated in @guessed_word and count of correct guesses ($guesses_made) is increased by 1.
    - Otherwise if it is not present in word then it is a bad guess and chances left ($guesses_left) is decreased by 1.
    - If the count of correct guesses become equal to size of word that means user has won and has guessed the word.
    - If the chances left are 0 that means the user has lost all the chances and didn't guess the word correct and hence lost the game.

$win represents the state of the game :

    - If it is 0 that means game is going on.
    - If it is 1 that means user has won.
    - If it is -1 that means user has lost.

The Function display is used to display the current state of HangMan, it uses the parts from array @hanged_parts to display the body parts hung.
