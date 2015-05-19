# Module Documentation

## Module Data.XML.PrettyPrint

#### `Indent`

``` purescript
type Indent = Number
```


#### `CurrentIndent`

``` purescript
type CurrentIndent = Number
```


#### `PrinterState`

``` purescript
data PrinterState
  = PrinterState Indent CurrentIndent
```

The number of spaces in an indent and the current number of indents made.
`PrinterState 2 6` represents 12 spaces.

#### `Printer`

``` purescript
type Printer v = StateT PrinterState (Writer String) v
```


#### `indent`

``` purescript
indent :: Printer Unit
```


#### `dedent`

``` purescript
dedent :: Printer Unit
```


#### `indentSpaces`

``` purescript
indentSpaces :: Printer String
```


#### `appendLine`

``` purescript
appendLine :: String -> Printer Unit
```


#### `enclosed`

``` purescript
enclosed :: String -> String -> String -> String
```


#### `openTag`

``` purescript
openTag :: String -> [Attr] -> String
```


#### `closeTag`

``` purescript
closeTag :: String -> String
```


#### `escape`

``` purescript
escape :: String -> String
```


#### `printNode`

``` purescript
printNode :: Node -> Printer Unit
```


#### `showAttrs`

``` purescript
showAttrs :: [Attr] -> String
```


#### `printDocument`

``` purescript
printDocument :: Document -> Printer Unit
```


#### `print`

``` purescript
print :: Indent -> Document -> String
```



## Module Data.XML

#### `Version`

``` purescript
type Version = String
```

#### `Encoding`

``` purescript
type Encoding = String
```


#### `Document`

``` purescript
data Document
  = Document Version Encoding Node
```


#### `TagName`

``` purescript
type TagName = String
```


#### `Node`

``` purescript
data Node
  = Element TagName [Attr] [Node]
  | Text String
  | Comment String
```


#### `Attr`

``` purescript
data Attr
  = Attr String String
```



## Module Test.Spec.Reporter.Xunit

#### `xunitReporter`

``` purescript
xunitReporter :: forall e. FilePath -> Reporter (err :: Exception, fs :: FS | e)
```

Outputs an XML file at the given path that can be consumed by Xunit
readers, e.g. the Jenkins plugin.



