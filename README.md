The Pencil Durability Kata simulates a pencil with the ability to write, erase, and edit text.  It also includes degradation for the pencil and the eraser, as well as the ability to sharpen the pencil. 
This kata was developed using test-driven development.  The kata is written in the Ruby language and tested using RSPEC (RSPEC “examples” are the tests).  All of the examples are run from the terminal. 

If ruby is not installed, this is where the download is located: https://www.ruby-lang.org/en/downloads/
If the RSPEC gem is not installed, run the following command from the terminal: gem install rspec

To run the examples, go to the parent directory in the terminal (pencil_durabilty) and run the following (rspec command + the path of the specs): rspec spec/

There are two spec files in this kata(within the spec directory).  If you would like to run them individually, use the following command command for the specific group of examples:
pencil_spec:  rspec spec/specs/pencil_spec.rb
eraser_spec:  rspec spec/specs/eraser_spec.rb
