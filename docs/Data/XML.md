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
  = Element TagName (Array Attr) (Array Node)
  | Text String
  | Comment String
```

#### `Attr`

``` purescript
data Attr
  = Attr String String
```


