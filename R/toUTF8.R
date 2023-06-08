toUTF8 <- function (x, from = "WINDOWS-1252") 
{
  fromto(x, from, "UTF-8")
}

fromto <- function (x, from, to)
{
  if (is.list(x)) {
    xattr <- attributes(x)
    x <- lapply(x, fromto, from, to)
    attributes(x) <- xattr
  } else {
    if (is.factor(x)) {
      levels(x) <- iconv(levels(x), from, to, sub = "byte")
    } else {
      if (is.character(x))
        x <- iconv(x, from, to, sub = "byte")
    }
    lb <- attr(x, "label")
    if (length(lb) > 0) {
      attr(x, "label") <- iconv(attr(x, "label"), from, to, sub = "byte")
    }
  }
  x
}