local findTexFile = function()
  local result = {}
  -- local cwDir = vim.fn.getcwd()
  local cwDir = vim.fn.expand("%:p:h")
  local latexFilePath = vim.fn.glob(cwDir .. "/*.tex")
  -- splited path
  local sp = vim.fn.split(latexFilePath,"/")
  return sp[#sp]
end
return {
  s("tex", {
    t({ "default: build" }),
    t({ "", "", "build:" }),
    t({ "", "\tpdflatex " }), f(findTexFile, {}, {}),
    t({ "", "\tbiber " }), f(findTexFile, {}, {}),
    t({ "", "", "clean:" }),
    t({ "", "\t-rm *.aux " }),
    t({ "", "\t-rm *.log " }),
    t({ "", "\t-rm *.lof " }),
    t({ "", "\t-rm *.bbl " }),
    t({ "", "\t-rm *.blg " }),
    t({ "", "\t-rm *.lot " }),
    t({ "", "\t-rm *.out " }),
    t({ "", "\t-rm *.toc " }),
    t({ "", "\t-rm *.bcf " }),
    t({ "", "\t-rm *.run.xml " }),
  }),
}

-- default: build

-- build:
-- 	pdflatex mydocument.tex
-- 	biber mydocument
-- 	pdflatex mydocument.tex
-- 	pdflatex mydocument.tex

-- clean:
-- 	-rm *.aux
-- 	-rm *.log
-- 	-rm *.lof
-- 	-rm *.bbl
-- 	-rm *.blg
-- 	-rm *.lot
-- 	-rm *.out
-- 	-rm *.toc
-- 	-rm *.bcf
-- 	-rm *.run.xml
-- 	-rm *.blx.bib
