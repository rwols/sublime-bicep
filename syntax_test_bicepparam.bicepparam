// SYNTAX TEST "Packages/Bicep/Bicepparam.sublime-syntax"

// USING STATEMENTS

using 'main.bicep'
//^^^ keyword.declaration.bicepparam
//    ^^^^^^^^^^^^ string

using none
//^^^ keyword.declaration.bicepparam
//    ^^^^ constant.language.bicepparam

// COMMENTS

var myVar = 'hi!' // this is a comment
//                ^^^^^^^^^^^^^^^^^^^^ comment.line

/* this
is a
multi line comment */
// <- comment.block

// UNTYPED PARAMETERS

param storageName = 'MyStorageAccount'
//^^^ keyword.declaration.bicep
//    ^^^^^^^^^^^ variable.parameter.bicep
//                ^ keyword.operator.assignment.bicep
//                  ^^^^^^^^^^^^^^^^^^ string

param intFromEnvironmentVariables = int(readEnvironmentVariable('intEnvVariableName'))
//^^^ keyword.declaration.bicep
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^ variable.parameter.bicep
//                                ^ keyword.operator.assignment.bicep
//                                  ^^^ variable.function
//                                      ^^^^^^^^^^^^^^^^^^^^^^^ variable.function
//                                                              ^^^^^^^^^^^^^^^^^^^ string

// UNTYPED VARIABLES

var storagePrefix = 'myStorage'
//^ keyword.declaration.bicep
//  ^^^^^^^^^^^^^ variable.other.readwrite.bicep
//                ^ keyword.operator.assignment.bicep
//                  ^^^^^^^^^^^ string

// VARIABLE WITH OBJECT VALUE

var testSettings = {
//^ keyword.declaration.bicep
//  ^^^^^^^^^^^^ variable.other.readwrite.bicep
//               ^ keyword.operator.assignment.bicep
//                 ^ punctuation.section
  instanceSize: 'Small'
  //          ^ punctuation.separator
  //            ^^^^^^^ string
  instanceCount: 1
  //           ^ punctuation.separator
  //             ^ constant.numeric
  environmentSettings: testSettings
  //                 ^ punctuation.separator
  //                   ^^^^^^^^^^^^ variable.other
}


// PARAMETER WITH STRING INTERPOLATION

param primaryStorageName = '${storagePrefix}Primary'
//^^^ keyword.declaration.bicep
//    ^^^^^^^^^^^^^^^^^^ variable.parameter.bicep
//                       ^ keyword.operator.assignment.bicep
//                         ^ string
//                          ^^^^^^^^^^^^^^^^ meta.interpolation
//                                          ^^^^^^^^ string

// PARAMETERS WITH VARIOUS TYPES


param exampleString = 'test string'
//                    ^^^^^^^^^^^^^ string

param intValue = 2 + 2
//^^^ keyword.declaration.bicep
//    ^^^^^^^^ variable.parameter.bicep
//             ^ keyword.operator.assignment.bicep
//               ^ constant.numeric
//                 ^ keyword.operator.arithmetic
//                   ^ constant.numeric

param exampleBool = true
//                  ^^^^ constant.language

param exampleArray = [
//                   ^ punctuation.section
  'value 1'
  //^^^^^^^ string
  'value 2'
  //^^^^^^^ string
]
// <- punctuation.section

param exampleObject = {
//                    ^ punctuation.section
  property1: 'value 1'
  //       ^ punctuation.separator
  //         ^^^^^^^^^ string
  property2: 'value 2'
  //       ^ punctuation.separator
  //         ^^^^^^^^^ string
}

// MULTI-LINE STRINGS

var myVar = '''hello!'''
//          ^^^^^^^^^^^^ string

var myVar2 = '''
//           ^^^ string
hello!'''
// <- string
//^^^^^^^ string

var myVar3 = '''
hello!
// <- string
'''
// <- string
//^ string
