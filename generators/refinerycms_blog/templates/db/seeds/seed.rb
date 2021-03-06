User.find(:all).each do |user|
  user.plugins.create(:name => "<%= singular_name %>",
                      :position => (user.plugins.maximum(:position) || -1) +1)
end

page = Page.create(
  :title => "Blog",
  :link_url => "/blog",
  :deletable => false,
  :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
  :menu_match => "^/blogs?(\/|\/.+?|)$"
)

RefinerySetting.find_or_set(:default_page_parts, %w(Body Side\ Body)).each do |default_page_part|
  page.parts.create(:title => default_page_part, :body => nil)
end
