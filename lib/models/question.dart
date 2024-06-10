const List<Map<String, Object>> questions = [
  {
    'chapter': 'Functions',
    'questions': [
      {
        'questionText': "A function can have ____ inside the parenthesis",
        'answers': [
          {'text': 'loops', 'score': 0},
          {'text': 'Arguments/Parameters', 'score': 1}, 
          {'text': 'Braces', 'score': 0},
          {'text': 'types', 'score': 0},
        ],
      },
      {
        'questionText': "A function that returns a whole number starts with the word",
        'answers': [
          {'text': 'int', 'score': 1},
          {'text': 'void', 'score': 0},
          {'text': 'string', 'score': 0},
          {'text': '{}', 'score': 0},
        ],
      },
      {
        'questionText': "Fill in the blank to have this function work properly:\n _ function() {\n\nint a = 4;\nint b = 5;\n\ncout<<a*b;\n}",
        'answers': [
          {'text': 'String', 'score': 0},
          {'text': 'int', 'score': 0},
          {'text': 'void', 'score': 1},
          {'text': 'variable', 'score': 0},
        ]
      },
      {
        'questionText': "Fill in the blank to have this function work properly. \n _function (){ \n string greeting = 'Welcome to my game'; \n return greeting; } ",
        'answers': [
          {'text': 'String', 'score': 1},
          {'text': 'void', 'score': 0},
          {'text': 'int', 'score': 0},
          {'text': 'variable', 'score': 0},
        ]
      },
      {
        'questionText': "Select all of the types you may have for a function \n (I) string \n (II) bool \n (III) void \n (IV) variable \n (v) int",
        'answers': [
          {'text': '(I) & (II)', 'score': 0},
          {'text': '(I),(II), & (III)', 'score': 0},
          {'text': '(I),(II),(III), & (V)', 'score': 1},
          {'text': '(I),(III) & (V)', 'score': 0},
        ]
      },
      {
        'questionText': "What is the meaning of modular programming",
        'answers': [
          {'text': 'data type of the value that function returns to the part of the program that called it', 'score': 0},
          {'text': 'breaking a program up into smaller,manageable functions or modules', 'score': 1},
          {'text': 'one single program without breaking it into module', 'score': 0},
          {'text': 'none of the above', 'score': 0},
        ]
      },
      {
        'questionText': "it refers to the part of function heading that\n specifies an input for the function to perform its task",
        'answers': [
          {'text': 'global variable', 'score': 0},
          {'text': 'function arguments or function parameters', 'score': 1},
          {'text': 'function statements', 'score': 0},
          {'text': 'function heading', 'score': 0},
        ]
      },
      {
        'questionText': "This method copies the actual value of an\n argument into the formal parameter of the\nfunction.",
        'answers': [
          {'text': 'call by value', 'score': 1},
          {'text': 'call by pointer', 'score': 0},
          {'text': 'call by reference', 'score': 0},
        ]
      },
      {
        'questionText': "it is a type of variable that can only be used within a function",
        'answers': [
          {'text': 'local variable', 'score': 1},
          {'text': 'global variable', 'score': 0},
          {'text': 'parameter variables', 'score': 0},
          {'text': 'constant variable', 'score': 0},
        ]
      },
      {
        'questionText': "True or False. We can call functions inside of other functions.",
        'answers': [
          {'text': 'True', 'score': 1},
          {'text': 'False', 'score': 0},
        ]
      },
      {
        'questionText': "What will be the output of the following C++ code?",
        'answers': [
          {'text': '10', 'score': 0},
          {'text': '0', 'score': 0},
          {'text': 'Syntax Error', 'score': 1},
          {'text': 'Segmentation fault', 'score': 0},
        ],
        'image': 'assets/images/question1.jpg',
      },
      {
        'questionText': "Which variable retains its value in between function calls?",
        'answers': [
          {'text': 'static', 'score': 1},
          {'text': 'register', 'score': 0},
          {'text': 'auto', 'score': 0},
          {'text': 'global', 'score': 0},
        ]
      },
      {
        'questionText': "How many values can a C++ function return at a time?",
        'answers': [
          {'text': 'only one value', 'score': 1},
          {'text': 'maximum of 2 values', 'score': 0},
          {'text': 'maximum of 3 values', 'score': 0},
          {'text': 'maximum 8 values', 'score': 0},
        ]
      },
    ],
  },
  {
    'chapter': 'Pointers',
    'questions': [
      {
        'questionText': "What is a pointer?",
        'answers': [
          {'text': 'A variable that stores a memory address', 'score': 1},
          {'text': 'A function parameter', 'score': 0},
        ],
      },
      {
        'questionText': "What is the size of a pointer?",
        'answers': [
          {'text': 'Depends on the data type', 'score': 0},
          {'text': 'Depends on the system architecture', 'score': 1},
        ],
      },
      {
        'questionText': "What will be the output of this piece of code?",
        'answers': [
          {'text': '13', 'score': 1},
          {'text': '3', 'score': 0},
          {'text': 'Syntax Error', 'score': 0},
          {'text': 'none of the given options', 'score': 0},
        ],
        'image': 'assets/images/question2.jpg',
      },
      {
        'questionText': "What will be the output of this piece of code?",
        'answers': [
          {'text': '15', 'score': 0},
          {'text': '5', 'score': 1},
          {'text': '8', 'score': 0},
          {'text': 'This is too confusing', 'score': 0},
        ],
        'image': 'assets/images/question3.jpg',
      },
      {
        'questionText': "What will be the output of this piece of code?",
        'answers': [
          {'text': 'Value of constant pointer(const) cannot be changed', 'score': 0},
          {'text': 'Variable value cannot be used to initialize the pointer', 'score': 1},
          {'text': '12', 'score': 0},
          {'text': '24', 'score': 0},
        ],
        'image': 'assets/images/question4.jpg',
      },
      {
        'questionText': "A function may return a pointer but the programmer must ensure that the the pointer",
        'answers': [
          {'text': 'still points to a valid object after the function ends', 'score': 1},
          {'text': 'has not been assigned an address', 'score': 0},
          {'text': 'was received as a parameter by the function', 'score': 0},
          {'text': 'has not previously been returned by another function', 'score': 0},
        ],
      },
      {
        'questionText': "Use the DELETE operator only on pointers that were",
        'answers': [
          {'text': 'never used', 'score': 0},
          {'text': 'not correctly initialized', 'score': 0},
          {'text': 'created with the NEW operator', 'score': 1},
          {'text': 'dereferenced inappropriately', 'score': 0},
        ],
      },
      {
        'questionText': "Dynamic memory allocation occurs",
        'answers': [
          {'text': 'when a new variable is created by the compiler', 'score': 0},
          {'text': 'when a new variable is created at runtime', 'score': 1},
          {'text': 'when a pointer fails to dereference the right variable', 'score': 0},
          {'text': 'when a pointer is assigned an incorrect\naddress', 'score': 0},
        ],
      },
      {
        'questionText': "What will be the output of this piece of code?",
        'answers': [
          {'text': 'A random value such as the address of arr[1]', 'score': 1},
          {'text': '5', 'score': 0},
          {'text': '10', 'score': 0},
          {'text': '15', 'score': 0},
        ],
        'image': 'assets/images/question5.jpg',
      },
    ],
  },
  {
    'chapter': 'Arrays',
    'questions': [
      {
        'questionText': "Unlike regular variables, ______ can hold\nmultiple values.",
        'answers': [
          {'text': 'constant', 'score': 0},
          {'text': 'named constant', 'score': 0},
          {'text': 'array', 'score': 1},
          {'text': 'floats', 'score': 0},
        ],
      },
      {
        'questionText': "In an array, every element has the same",
        'answers': [
          {'text': 'Data type', 'score': 1},
          {'text': 'subscript', 'score': 0},
          {'text': 'memory location', 'score': 0},
          {'text': 'All of the above', 'score': 0},
        ],
      },
      {
        'questionText': "What is the last legal subscript that can be used\nwith the following array?\n\nint values[5];",
        'answers': [
          {'text': '0', 'score': 0},
          {'text': '5', 'score': 0},
          {'text': '6', 'score': 0},
          {'text': '4', 'score': 1},
        ],
      },
      {
        'questionText': "Given the following declaration, where is the value\n77 stored in the scores array?\nint scores[]={83,62,77,97,86}",
        'answers': [
          {'text': 'scores[0]', 'score': 0},
          {'text': 'scores[1]', 'score': 0},
          {'text': 'scores[2]', 'score': 1},
          {'text': 'scores[3]', 'score': 0},
        ],
      },
      {
        'questionText': "To pass an array as an argument to a function,\npass the _____ of the array.",
        'answers': [
          {'text': 'contents', 'score': 0},
          {'text': 'size,expressed as an integer', 'score': 0},
          {'text': 'name', 'score': 1},
          {'text': 'value of the first element', 'score': 0},
        ],
      },
      {
        'questionText': "What will the following code display?\nint numbers[5] = {99,87,66,55,101};\nfor (int i = 1; i<4; i++)\ncout << numbers[i] <<"";",
        'answers': [
          {'text': '99 87 66 55 101', 'score': 0},
          {'text': '87 66 55 101', 'score': 0},
          {'text': '87 66 55', 'score': 1},
          {'text': 'Nothing, This code has an error', 'score': 0},
        ],
      },
      {
        'questionText': "An array of string objects that will hold five names\nwould be declared with which of the following\nstatements?",
        'answers': [
          {'text': 'string names[5]', 'score': 1},
          {'text': 'string names(5)', 'score': 0},
          {'text': 'string names 5', 'score': 0},
          {'text': 'string[5] = names', 'score': 0},
        ],
      },
      {
        'questionText': "Given the following declaration, where is the value\n15 stored in the nums array?\nint nums[] = {83, 15, 57, 87, 80}",
        'answers': [
          {'text': 'nums[0]', 'score': 0},
          {'text': 'nums[1]', 'score': 1},
          {'text': 'nums[0]', 'score': 0},
          {'text': 'nums[0]', 'score': 0},
        ],
      },
      {
        'questionText': "An array of double objects that wull hold ten\nlengths would be declared with which of the\nfollowing statements?}",
        'answers': [
          {'text': 'double length[5]', 'score': 0},
          {'text': 'double length(10)', 'score': 0},
          {'text': 'double length[10]', 'score': 1},
          {'text': 'double length(9)', 'score': 0},
        ],
      },
      {
        'questionText': "What will the following code display?\nint numbers[5] = {66, 55, 101, 99, 87};\nfor (int i = 2; i<5; i++)\ncout << numbers[i] <<"";",
        'answers': [
          {'text': '87 101 99 87', 'score': 0},
          {'text': '101 99 87', 'score': 1},
          {'text': '66 101 87', 'score': 0},
          {'text': 'Nothing, This code has an error', 'score': 0},
        ],
      },
       {
        'questionText': "What is the last legal subscript (top index) that can\nbe used with the following array?\nint nums[10];",
        'answers': [
          {'text': '0', 'score': 0},
          {'text': '11', 'score': 0},
          {'text': '9', 'score': 1},
          {'text': '10', 'score': 0},
        ],
      },
    ],
  },
  { 
    'chapter': 'Looping',
    'questions': [
      {
        'questionText': "How many loops are there in C++",
        'answers': [
          {'text': '2', 'score': 0},
          {'text': '3', 'score': 1},
          {'text': '4', 'score': 0},
          {'text': '1', 'score': 0},
        ],
      },
      {
        'questionText': "What is current syntax of for loop?",
        'answers': [
          {'text': 'for(initialization;condition;increment/decerement)', 'score': 1},
          {'text': 'for(increment/decrement;initialization;condition)', 'score': 0},
          {'text': 'for(initialization,condition,increment/decrement)', 'score': 0},
          {'text': 'for(None of these)', 'score': 0},
        ],
      },
       {
        'questionText': "Which looping process checks the test\ncondition at the end of the loop?",
        'answers': [
          {'text': 'for', 'score': 0},
          {'text': 'while', 'score': 0},
          {'text': 'do-while', 'score': 1},
          {'text': 'no looping process checks the test condition at the end', 'score': 0},
        ],
      },
      {
        'questionText': "The statements i++; is equivalent to",
        'answers': [
          {'text': 'i = i + i;', 'score': 0},
          {'text': 'i = i + 1;', 'score': 1},
          {'text': 'i = i - 1;', 'score': 0},
          {'text': 'i--;', 'score': 0},
        ],
      },
        {
        'questionText': "What's wrong? for(int k = 2; k <= 12; k++)",
        'answers': [
          {'text': 'the increment should always be ++k', 'score': 0},
          {'text': 'the variable must be always be the letter i when\nusing a for loop', 'score': 0},
          {'text': 'there should be a semicolon at the end of the statements', 'score': 0},
          {'text': 'the commas should be semicolons', 'score': 1},
        ],
      },
       {
        'questionText': "using the break or continue statements with a loop\nviolates the single entry and single exit guidelines\nfor developing a loop.",
        'answers': [
          {'text': 'True', 'score': 1},
          {'text': 'False', 'score': 0},
        ],
      },
      {
        'questionText': "The first value printed will be",
        'answers': [
          {'text': '0', 'score': 1},
          {'text': '1', 'score': 0},
          {'text': '99', 'score': 0},
          {'text': '100', 'score': 0},
        ],
        'image': 'assets/images/question6.jpg',
      },
      {
        'questionText': "The last value printed will be",
        'answers': [
          {'text': '0', 'score': 0},
          {'text': '1', 'score': 0},
          {'text': '99', 'score': 1},
          {'text': '100', 'score': 0},
        ],
        'image': 'assets/images/question6.jpg',
      },
      {
        'questionText': "if the loop body was changed from count ++; to counter+=5\nHow many times would the loop body execute?",
        'answers': [
          {'text': '19', 'score': 0},
          {'text': '20', 'score': 1},
          {'text': '99', 'score': 0},
          {'text': '100', 'score': 0},
        ],
        'image': 'assets/images/question6.jpg',
      },
      {
        'questionText': "if you want a user to enter exactly 20 values, which\nloop would be the best to use?",
        'answers': [
          {'text': 'while', 'score': 0},
          {'text': 'switch', 'score': 0},
          {'text': 'for', 'score': 1},
          {'text': 'do-while', 'score': 0},
        ],
      },
      {
        'questionText': "How many times will the above loop display 'Hello World!'?",
        'answers': [
          {'text': '19', 'score': 0},
          {'text': '20', 'score': 1},
          {'text': '21', 'score': 0},
          {'text': 'an infinite number of times', 'score': 0},
        ],
        'image': 'assets/images/question7.jpg',
      },
    ],
  },
];
