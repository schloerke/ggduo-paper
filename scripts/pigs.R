
data(pigs)

pigs_dt <- pigs[-(2:3)] # remove year and quarter
pigs_dt$profit_group <- as.numeric(pigs_dt$profit > mean(pigs_dt$profit))

qplot(
  time, value,
  data = reshape::melt.data.frame(pigs_dt, "time"),
  geom = c("smooth", "point")
) +
  facet_grid(variable ~ ., scales = "free_y")

profit_groups <- c(
  "1" = "high",
  "0" = "low"
)
pigs_dt$profit_group <- factor(
  profit_groups[as.character(pigs_dt$profit_group)],
  levels = unname(profit_groups),
  ordered = TRUE
)
pigs_mapping <- aes(color = profit_group)
pigs_types <- list(
  comboHorizontal = wrap(ggally_facethist, binwidth = 1)
)

pm <- ggts(
  pigs_dt, pigs_mapping,
  1, 2:7,
  types = pigs_types,
  legend = c(6,1),
  columnLabelsY = c(
    "number of\nfirst birth sows",
    "sell price over\nfeed cost",
    "sell count over\nheard size",
    "meat head count",
    "breading\nheard size",
    "profit\ngroup"
  ),
  showStrips = FALSE
) +
  labs(fill = "profit group") +
  theme(
    legend.position = "bottom",
    strip.background = element_rect(
      fill = "transparent", color = "grey80"
    )
  )
ggsave("../imgs/pigs.png", pm, height = 6, width = 8)
