## Module Test.Spec.Reporter.Xunit

#### `xunitReporter`

``` purescript
xunitReporter :: forall e. FilePath -> Reporter (fs :: FS, err :: EXCEPTION | e)
```

Outputs an XML file at the given path that can be consumed by Xunit
readers, e.g. the Jenkins plugin.


