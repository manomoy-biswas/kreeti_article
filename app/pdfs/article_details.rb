class ArticleDetails < Prawn::Document
  def initialize(article)
    super()
    @article = article
    document_name
    line_items
  end

  def document_name
    text "#{@article.article_name}", size: 20, align: :center
    text "by #{@article.user.name}, #{DateTime.parse(@article.updated_at.to_s).strftime("%d %b,%Y %I:%M %p")}", size: 8, align: :center, color: "afaeae";
    image "#{@article.image.path}", width: 540, height:375
  end

  def line_items
    move_down 10
    task_details
  end

  def task_details
    text "#{@article.description}"
  end
end