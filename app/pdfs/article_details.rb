class ArticleDetails < Prawn::Document
  def initialize(article)
    super()
    @article = article
    document_name
    line_items
  end

  def document_name
    text "#{@article.article_name}", size: 20, align: :center
    image "#{@article.image.url}"
  end

  def line_items
    move_down 10
    task_details
  end

  def task_details
    text "#{@article.description}"
  end
end