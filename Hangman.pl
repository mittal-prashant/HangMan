#!/usr/bin/perl

package HangMan {

    # Array to store some random words, which are used the program for guessing
    @words = (
        "computer",      "radio",        "calculator",    "teacher",
        "bureau",        "police",       "geometry",      "president",
        "subject",       "country",      "enviroment",    "classroom",
        "animals",       "province",     "month",         "politics",
        "puzzle",        "instrument",   "kitchen",       "language",
        "vampire",       "ghost",        "solution",      "service",
        "software",      "virus25",      "security",      "phonenumber",
        "expert",        "website",      "agreement",     "support",
        "compatibility", "advanced",     "search",        "triathlon",
        "immediately",   "encyclopedia", "endurance",     "distance",
        "nature",        "history",      "organization",  "international",
        "championship",  "government",   "popularity",    "thousand",
        "feature",       "wetsuit",      "fitness",       "legendary",
        "variation",     "equal",        "approximately", "segment",
        "priority",      "physics",      "branche",       "science",
        "mathematics",   "lightning",    "dispersion",    "accelerator",
        "detector",      "terminology",  "design",        "operation",
        "foundation",    "application",  "prediction",    "reference",
        "measurement",   "concept",      "perspective",   "overview",
        "position",      "airplane",     "symmetry",      "dimension",
        "toxic",         "algebra",      "illustration",  "classic",
        "verification",  "citation",     "unusual",       "resource",
        "analysis",      "license",      "comedy",        "screenplay",
        "production",    "release",      "emphasis",      "director",
        "trademark",     "vehicle",      "aircraft",      "experiment"
    );

    # Stores all the parts that can be hung
    @all_parts = ( 'O', '|', '/', '\\', '/', '\\' );

    # Stores all the parts that has been hung
    @hanged_parts = ( ' ', ' ', ' ', ' ', ' ', ' ' );

    @word;         # Stores the random word chosen by the computer
    $win = 0;      # Stores the state of wining/losing of user, if 1 that means it has won, -1 means lost and 0 means the game is going on
    $guesses_left = 6;    # The number of wrong guesses you are allowed to make
    $guesses_made = 0;    # The number of correct letters you have guessed from the word
    @guesses;      # Stores all the guesses wrong/correct made so far
    @guessed_word; # Stores the state of word which has to be guesses and number of letters guessed
    $letter;       # Stores the letter entered by the user

    sub clear() {
        # Function to clear all the variables and intialize them back to initial states when game starts
        
        @word         = ();
        $win          = 0;
        $guesses_left = 6;
        $guesses_made = 0;
        @guesses      = ();
        @guessed_word = ();
        @hanged_parts = ( ' ', ' ', ' ', ' ', ' ', ' ' );
    }

    sub start {
        # Function called when every game starts
        
        # After every game calling the clear function
        clear();

        # Taking a random word from the array using rand function
        $word = uc @words[ rand( $#words + 1 ) ];

        # Making an array of uppercase letters of random word selected above
        @word = split( '', $word );

        # Making the guessed_word equals size of random word and replacing characters by _
        for ( $i = 0 ; $i < $#word + 1 ; $i++ ) {
            push @guessed_word, '_';
        }
        
        # Telling the user number of guesses he/she has
        print "\nYou Only Have 6 Guesses\n";

        # While $win is 0 that means game is going on
        while ( $win == 0 ) {
            # Calling the guess function until the word is guessed or chances left are 0
            guess();
        }

        if ( $win == 1 ) {
            # If $win is 1 that means user has won
            print "\nHurray! You Got It! It Was $word!\n";
        }
        else {
            # If $win is -1 that means user has lost
            
            # Printing the final state of hangman hung
            print "  _ _  \n |   | \n |   " . @hanged_parts[0] . " \n";
            print " |  "
              . @hanged_parts[2]
              . @hanged_parts[1]
              . @hanged_parts[3] . "\n";
            print " |   " . @hanged_parts[1] . "\n";
            print " |  "
              . @hanged_parts[4] . " "
              . @hanged_parts[5]
              . "\n_|_    \n";
            print "\nSo Sorry, You Struck Out.\n";
            print "\nThe Word Is $word\n";
        }
    }

    sub guess {
        # Function called to ask user to make a guess
        
        $input = 0;
        
        while ( $input == 0 ) {
            # While $input is 0 that means correct input hasn't been given
            
            # Calling display function to display state of word guessed so far and hangman
            display();

            # Taking input
            $letter = <STDIN>;
            $letter = uc substr( $letter, 0, 1 );

            if ( $letter eq "\n" || $letter eq " " ) {
                # If input is blank display the below message and ask for input again
                print "\nInput should be a single alpha-numeric character\n";
            }
            else {
                $input = 1;
            }
        }
        
        # Calling update function to update the word by letter guesses
        update();
    }

    sub display {
        # Function to display current state of hangman, word guessed so far, guesses made and chances left.

        print "  _ _  \n |   | \n |   " . @hanged_parts[0] . " \n";
        print " |  "
          . @hanged_parts[2]
          . @hanged_parts[1]
          . @hanged_parts[3]
          . "  Here Is Your Word : @guessed_word\n";
        print " |   "
          . @hanged_parts[1]
          . "   Guesses Made So Far : [@guesses]\n";
        print " |  "
          . @hanged_parts[4] . " "
          . @hanged_parts[5]
          . "\n_|_    \n";
        print "\nGuesses Left : $guesses_left\n";
        print "\nMake A Guess : ";
    }

    sub update {
        # Function to update the guessed word with the letter given as input

        for ( $i = 0 ; $i <= $#guesses ; $i++ ) {
            if ( $letter eq @guesses[$i] ) {
                # If letter is already guessed return and display the below message
                print "\nYou've Already Guessed This\n";
                return;
            }
        }
        
        $correct_guess = -1;
        for ( $i = 0 ; $i < $#word + 1 ; $i++ ) {
            if ( @word[$i] eq $letter ) {
                # If guessed letter is present in the word update guessed word by that letter everytime and increase count of correct guess made
                @guessed_word[$i] = $letter;
                $correct_guess = 1;
                $guesses_made++;
            }
        }

        # Pushing the guessed letter in the array which stores guessed letters
        push @guesses, $letter;

        if ( $correct_guess == 1 ) {
            # If letter is found in the word then it is a good guess
            print "\nGood Guess!\n";
        }
        else {
            # If letter is not found in the word then it is a bad guess
            print "\nWrong Guess!\n";
            
            # Hanging one more body part of hangman
            @hanged_parts[ 6 - $guesses_left ] = @all_parts[ 6 - $guesses_left ];

            # Decreasing the chances left
            $guesses_left--;
        }
        
        if ( $guesses_left == 0 ) {
            # If chances left are 0 that means user has not guessed the word and has lost the game
            $win = -1;
        }
        elsif ( $guesses_made == $#word + 1 ) {
            # If correct guesses made equals size of word that means user has guessed the word and has won the game
            $win = 1;
        }
    }
}

$play = 1;
print "\n||     HANGMAN GAME     ||\n";

while ( $play == 1 ) {
    # While $play is 1 that means we have to play a game

    # Initializing the variable $game to the class HangMan
    $game = HangMan;

    # Starting the game by calling the start function inside class HangMan
    $game->start;

    # After a game we update $play to 0
    $play = 0;

    # Asking the user if he/she wishes to play a new game
    print "\nIf You Wish To Play Another Game Press Y/y : ";
    $choice = <STDIN>;

    # Striping off all the extra characters other than the first one
    $choice = uc substr( $choice, 0, 1 );
    if ( $choice eq 'Y' ) {
        # If entered character is Y/y that means user wish to play a new game
        $play = 1;
    }
}
