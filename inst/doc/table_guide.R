## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, warning=FALSE-----------------------------------------------------

library(dplyr, warn.conflicts = FALSE)
library(tidyr)
library(gt)
library(table.glue)


## -----------------------------------------------------------------------------

starwars_smry <- na.omit(starwars) %>% 
  filter(eye_color %in% c('blue', 'brown', 'hazel')) %>% 
  group_by(sex, eye_color) %>% 
  summarize(
    across(
      c(height, mass),
      .fns = list(
        lwr = ~quantile(.x, probs = 0.25),
        est = ~quantile(.x, probs = 0.50),
        upr = ~quantile(.x, probs = 0.75)
      )
    )
  )


## -----------------------------------------------------------------------------

rspec <- round_spec() %>% 
  round_half_even() %>% 
  round_using_magnitude(breaks = c(1, 10, 100, Inf),
                        digits = c(2, 1,  1, 0))

names(rspec) <- paste('table.glue', names(rspec), sep = '.')

options(rspec)

starwars_tbl <- starwars_smry %>% 
  transmute(
    sex, 
    eye_color, 
    tbv_height = table_glue("{height_est} ({height_lwr} - {height_upr})"),
    tbv_mass = table_glue("{mass_est} ({mass_lwr} - {mass_upr})")
  )


## -----------------------------------------------------------------------------

starwars_tbl %>% 
  mutate(
    sex = recode(sex, 
                 'female' = 'Female characters', 
                 'male'   = 'Male characters'),
    eye_color = recode(eye_color, 
                       blue  = 'Blue',
                       brown = 'Brown',
                       hazel = 'Hazel')
  ) %>% 
  gt(groupname_col = 'sex',  rowname_col = 'eye_color') %>% 
  cols_label(tbv_height = 'Height, cm', tbv_mass = 'Mass, kg') %>% 
  cols_align('center') %>% 
  tab_stubhead(label = 'Eye color') %>% 
  tab_spanner(label = 'Median (25th, 75th percentile)',
              columns = starts_with('tbv')) %>% 
  tab_source_note(md('For more on these data, see `?dplyr::starwars`'))


## -----------------------------------------------------------------------------

starwars_inline_female_brown_height <- starwars_tbl %>% 
  filter(sex == 'female', eye_color == 'brown') %>% 
  pull(tbv_height)

starwars_inline_female_blue_height <- starwars_tbl %>% 
  filter(sex == 'female', eye_color == 'blue') %>% 
  pull(tbv_height)

starwars_inline_female_hazel_height <- starwars_tbl %>% 
  filter(sex == 'female', eye_color == 'hazel') %>% 
  pull(tbv_height)


## -----------------------------------------------------------------------------

starwars_inline <- starwars_tbl %>% 
  as_inline(tbl_variables = c("sex", "eye_color"),
            tbl_values = c("tbv_height", "tbv_mass"))

print(starwars_inline)


## -----------------------------------------------------------------------------
other_inline <- starwars_inline

## -----------------------------------------------------------------------------

inline = list(starwars = starwars_inline,
              other = other_inline)

# now you can access all your table data in one place. Happy writing!
inline$starwars$female$blue$tbv_height
inline$other$male$blue$tbv_height


