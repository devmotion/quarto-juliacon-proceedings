if quarto.doc.is_format('latex') then
    return {
        {
            -- Save metadata in paper.yml
            Meta = function(meta)
                -- Save metadata in paper.yml
                fho, err = io.open("paper.yml", "w")

                -- Write title
                local title = meta['title']
                if title ~= nil then
                    fho:write("title: \"", pandoc.utils.stringify(title), "\"\n")
                end

                -- Write keywords
                local keywords = meta['keywords']
                if keywords ~= nil then
                    fho:write("keywords:\n")
                    for _, keyword in pairs(keywords) do
                        fho:write("  - ", pandoc.utils.stringify(keyword), "\n")
                    end
                end

                -- Write authors
                local authors = meta['by-author']
                if authors ~= nil then
                    fho:write("authors:\n")
                    for _, author in pairs(authors) do
                        -- name
                        local name = pandoc.utils.stringify(author.name.literal)
                        fho:write(" - name: ", name)

                        -- orcid ID
                        local orcid = author['orcid']
                        if orcid ~= nil then
                            local o = pandoc.utils.stringify(orcid)
                            fho:write("\\texorpdfstring{~\\mbox{\\orcidlink{", o, "}}}{}\n")
                            fho:write("   orcid: ", o)
                        end
                        fho:write("\n")

                        local affiliations = author['affiliations']
                        if affiliations ~= nil then
                            fho:write("   affiliation: ")
                            for i, affiliation in ipairs(affiliations) do
                                if i > 1 then
                                    fho:write(",")
                                end
                                fho:write(pandoc.utils.stringify(affiliation.number))
                            end
                            fho:write("\n")
                        end
                    end
                end

                -- Write affiliations
                local affiliations = meta['by-affiliation']
                if affiliations ~= nil then
                    fho:write("affiliations:\n")
                    for _, affiliation in pairs(affiliations) do
                        local name = affiliation['name']
                        fho:write("  - name: \"", pandoc.utils.stringify(name), "\"\n")
                        fho:write("    index: ", affiliation['number'], "\n")
                    end
                end

                -- Write date
                local date = meta['date']
                if date == nil then
                    date = os.date("%e %B %Y")
                end
                fho:write("date: ", pandoc.utils.stringify(date), "\n")

                -- Write bibliography
                local bib = meta['bibliography']
                if bib ~= nil then
                    fho:write("bibliography: \"")
                    for i, bibfile in ipairs(bib) do
                        if i > 1 then
                            fho:write(",")
                        end
                        fho:write(pandoc.utils.stringify(bibfile))
                    end
                    fho:write("\"")
                end

                fho:close()
            end
        },
        {
            CodeBlock = function(el)
                local classes = el.classes
                -- Ensure that ```julia ... ``` code blocks are written as
                -- \begin{lstlisting}[language=julia] ... \end{lstlisting}
                -- Ref: https://github.com/jgm/pandoc/issues/4116
                if classes ~= nil and classes:includes("julia") then
                    return pandoc.RawBlock("latex",
                        "\n\\begin{lstlisting}[language=julia]\n" .. el.text .. "\n\\end{lstlisting}\n")
                end
                return el
            end
        }
    }
end
