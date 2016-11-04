

raw_dt <- read.csv("http://www.ats.ucla.edu/stat/data/mmreg.csv")
psych <- raw_dt
colnames(psych) <- c("Control", "Concept", "Motivation", "Read", "Write", "Math", "Science", "Sex")
mot_levels <- c("Low", "Under", "Above", "High")
psych <- data.frame(
  Motivation = factor(
    mot_levels[round(psych$Motivation * 3 + 1)],
    levels = mot_levels,
    ordered = TRUE
  ),
  Self.Concept = psych$Concept,
  Locus.of.Control = psych$Control,
  Read = psych$Read,
  Write = psych$Write,
  Math = psych$Math,
  Science = psych$Science,
  Sex = c("0" = "Male", "1" = "Female")[as.character(psych$Sex)]
)


pm <- ggduo(
  psych, 1:3, 4:8,
  mapping = aes(color = Sex),
  types = list(continuous = "smooth_lm"),
  title = "Between Academic and Psychological Variable Correlation",
  xlab = "Psychological",
  ylab = "Academic",
  showStrips = FALSE
)

ggsave("../imgs/cca.png", pm, width = 8, height = 6)
