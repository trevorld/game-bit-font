desc "Build font files and copy to ~/.local/share/fonts"
task :default => "game-bit-duo.ttf"
task :default => "pdf/game-bit-private-use-area.pdf"
task :default => "pdf/game-bit-code-charts.pdf"
task :default => "README.html"

file "README.html" => "README.rst"
file "README.html" => "game-bit-duo.ttf"
file "README.html" do
  sh "rst2html README.rst README.html"
end

file "game-bit-duo.ttf" => "_targets.R"
file "game-bit-duo.ttf" => Rake::FileList["R/*.R"]
file "game-bit-duo.ttf" do
  sh "Rscript -e 'targets::tar_make()'"
  sh "cp game-bit-duo.ttf ~/.local/share/fonts/"
  sh "cp game-bit-mono.ttf ~/.local/share/fonts/"
end

file "pdf/game-bit-code-charts.pdf" => "game-bit-duo.ttf"
file "pdf/game-bit-code-charts.pdf" => "pdf/game-bit-code-charts.Rtex"
file "pdf/game-bit-code-charts.pdf" do
  Dir.chdir("pdf") do
    sh "Rscript -e 'knitr::knit(\"game-bit-code-charts.Rtex\", \"game-bit-code-charts.xelatex\")'"
    sh "xelatex game-bit-code-charts.xelatex"
    sh "xelatex game-bit-code-charts.xelatex"
  end
end

file "pdf/game-bit-private-use-area.pdf" => "game-bit-pua.csv"
file "pdf/game-bit-private-use-area.pdf" => "game-bit-duo.ttf"
file "pdf/game-bit-private-use-area.pdf" => "pdf/game-bit-private-use-area.Rtex"
file "pdf/game-bit-private-use-area.pdf" do
  Dir.chdir("pdf") do
    sh "Rscript -e 'knitr::knit(\"game-bit-private-use-area.Rtex\", \"game-bit-private-use-area.xelatex\")'"
    sh "xelatex game-bit-private-use-area.xelatex"
    sh "xelatex game-bit-private-use-area.xelatex"
  end
end

desc "Rsync fonts to trevor.l.davis.com/share/fonts"
task :deploy => :default
task :deploy do
  sh "cp game-bit-duo.ttf ../../websites/trevorldavis.com/content/share/fonts/"
  sh "cp game-bit-mono.ttf ../../websites/trevorldavis.com/content/share/fonts/"
  sh "cp pdf/game-bit-code-charts.pdf ../../websites/trevorldavis.com/content/share/fonts/"
  sh "cp pdf/game-bit-private-use-area.pdf ../../websites/trevorldavis.com/content/share/fonts/"
  Dir.chdir("../../websites/trevorldavis.com/") do
    sh "rake deploy"
  end
end
