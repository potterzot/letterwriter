LetterWriter
============

A make and rmarkdown framework for generating letters in markdown and converting using pandoc.

Requirements
------------

This framework requires:

-   R and rmarkdown
-   make
-   pandoc

Installation
------------

Just clone this repository and you're ready to go.

Usage
-----

It may be best to begin by editing [contacts.csv](contacts.csv). From there, generating a blank letter template is as simple as running `./gen_letter.R <name>` from your terminal. This generates a letter in markdown format in the `letters` directory. Letters can be converted to pdf by typing `make` in the root directory of the repository. To summarize, the workflow is something like

    1. `./gen_letter.R "Nicholas Potter" # "letters/Nicholas_Potter_<date>.md" is generated
    2. edit the markdown file with your favorite editor
    3. `make` #compiles any new markdown files in the letters directory
    4. print and mail

If the name is not in `contacts.csv`, the letter is still generated, but the other fields will not replaced.

Contributions
-------------

Contributions are more than welcome! Please just fork the repository and then submit a pull request.
