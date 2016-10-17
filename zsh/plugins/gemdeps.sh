function gemdeps {
  gem_name="/\A$1\z/"
  gem dependency --both $gem_name
}
