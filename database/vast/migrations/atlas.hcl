env "local" {
  src = "file://database/vast/migrations/schema.hcl"
  dev = "docker://postgres/17/dev"
  migration {
    dir    = "file://database/vast/migrations/revisions"
    format = golang-migrate
  }
  format {
    migrate {
      diff = "{{ sql . \"  \" }}"
    }
  }
}