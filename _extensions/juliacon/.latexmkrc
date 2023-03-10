$pdf_mode = 1;

sub build_header {
  system("ruby ./prep.rb")
}

build_header()
