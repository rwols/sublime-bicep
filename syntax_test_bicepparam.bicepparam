// SYNTAX TEST "Packages/Bicep/Bicepparam.sublime-syntax"

// USING STATEMENTS

using 'main.bicep'
//^^^ keyword.declaration.bicepparam
//    ^^^^^^^^^^^^ string

using './main.bicep'
//^^^ keyword.declaration.bicepparam
//    ^^^^^^^^^^^^^^ string

using 'ts:00000000-0000-0000-0000-000000000000/myResourceGroup/storageSpec:1.0'
//^^^ keyword.declaration.bicepparam
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ string

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

param storageName = toLower('MyStorageAccount')
//^^^ keyword.declaration.bicep
//    ^^^^^^^^^^^ variable.parameter.bicep
//                ^ keyword.operator.assignment.bicep
//                          ^^^^^^^^^^^^^^^^^ string

param intValue = 2 + 2
//^^^ keyword.declaration.bicep
//    ^^^^^^^^ variable.parameter.bicep
//             ^ keyword.operator.assignment.bicep
//               ^ constant.numeric
//                 ^ keyword.operator.arithmetic
//                   ^ constant.numeric

param intFromEnvironmentVariables = int(readEnvironmentVariable('intEnvVariableName'))
//^^^ keyword.declaration.bicep
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^ variable.parameter.bicep
//                                ^ keyword.operator.assignment.bicep
//                                  ^^^ variable.function
//                                                              ^^^^^^^^^^^^^^^^^^^ string

// UNTYPED VARIABLES

var storagePrefix = 'myStorage'
//^ keyword.declaration.bicep
//  ^^^^^^^^^^^^^ variable.other.readwrite.bicep
//                ^ keyword.operator.assignment.bicep
//                  ^^^^^^^^^^^ string

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
}

var prodSettings = {
  instanceSize: 'Large'
  //            ^^^^^^^ string
  instanceCount: 4
  //             ^ constant.numeric
}

// PARAMETER WITH OBJECT VALUE

param environmentSettings = {
//^^^ keyword.declaration.bicep
//    ^^^^^^^^^^^^^^^^^^^ variable.parameter.bicep
//                        ^ keyword.operator.assignment.bicep
  test: testSettings
  //  ^ punctuation.separator
  //    ^^^^^^^^^^^^ variable.other
  prod: prodSettings
  //  ^ punctuation.separator
  //    ^^^^^^^^^^^^ variable.other
}

// PARAMETER WITH STRING INTERPOLATION

param primaryStorageName = '${storagePrefix}Primary'
//^^^ keyword.declaration.bicep
//    ^^^^^^^^^^^^^^^^^^ variable.parameter.bicep
//                       ^ keyword.operator.assignment.bicep
//                         ^^ string
//                           ^^^^^^^^^^^^^^ meta.interpolation
//                                         ^^^^^^^^^ string

param secondaryStorageName = '${storagePrefix}Secondary'
//                           ^^ string
//                             ^^^^^^^^^^^^^^ meta.interpolation
//                                           ^^^^^^^^^^^ string

// PARAMETERS WITH VARIOUS TYPES

param exampleString = 'test string'
//                    ^^^^^^^^^^^^^ string

param exampleInt = 2 + 2
//                 ^ constant.numeric
//                   ^ keyword.operator.arithmetic
//                     ^ constant.numeric

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
