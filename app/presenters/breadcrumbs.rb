module Breadcrumbs
  def breadcrumbs
    [
      {
        title: "Home",
        url: "/",
      },
      {
        title: finder_name,
        url: finder_path,
      },
    ]
  end
end
