say "Import Turbo"
append_to_file "app/javascript/application.js", %(import "@hotwired/turbo-rails")

say "Pin Turbo"
run "importmap pin @hotwired/turbo-rails@7.1.1"
