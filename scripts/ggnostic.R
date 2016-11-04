

data(flea)

flea_model <- step(lm(head ~ ., data = flea), trace = FALSE)
# summary(flea_model)

pm <- ggnostic(flea_model)
ggsave("../imgs/ggnostic_plain.png", pm, height = 6, width = 8)

pm <- ggnostic(
  flea_model,
  mapping = aes(color = species),
  columnsY = c(".fitted", ".resid", ".std.resid", ".hat", ".cooksd"),
  combo = list(
    .fitted = wrap(ggally_box_no_facet, outlier.shape = 21),
    .resid = wrap(ggally_nostic_resid, outlier.shape = 21),
    .std.resid = wrap(ggally_nostic_std_resid, outlier.shape = 21),
    .hat = wrap(ggally_nostic_hat, outlier.shape = 21),
    .cooksd = wrap(ggally_nostic_cooksd, outlier.shape = 21)
  )
)
ggsave("../imgs/ggnostic_complex.png", pm, height = 6, width = 8)
