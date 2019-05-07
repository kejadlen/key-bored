workflow "Run tests" {
  resolves = ["docker://ruby"]
  on = "push"
}

action "ruby" {
  uses = "docker://ruby"
  runs = "bundle"
}

action "docker://ruby" {
  uses = "docker://ruby"
  needs = ["ruby"]
  runs = "rake test"
}
