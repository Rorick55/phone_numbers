
def return_page(page)
  return_page = 0
  if page.to_i <= 1
    return_page = 1
  else
    return_page = page.to_i - 1
  end
end
