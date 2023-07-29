Deploy Module {
  By PSGalleryModule {
    FromSource Build\SbModuleBuilder
    To PSGallery
    WithOptions @{
      ApiKey = $PSGallery
    }
  }
}