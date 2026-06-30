from markdown_pdf import Section, MarkdownPdf

pdf = MarkdownPdf(toc_level=2)
with open('roteiro_apresentacao.md', 'r', encoding='utf-8') as f:
    content = f.read()
    
pdf.add_section(Section(content, toc=False))
pdf.save('roteiro_apresentacao.pdf')
