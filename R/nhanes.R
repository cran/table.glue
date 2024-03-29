
#' NHANES blood pressure data
#'
#' @description The US National Health and Nutrition Examination Survey
#'   (NHANES) was designed to assess the health and nutritional status of the
#'   non-institutionalized US population and was conducted by the National
#'   Center for Health Statistics of the Centers for Disease Control and
#'   Prevention (1). Since 1999-2000, NHANES has been conducted in two-year
#'   cycles using a multistage probability sampling design to select
#'   participants. Each cycle is independent with different participants
#'   recruited.
#'
#' @source NHANES website, <https://www.cdc.gov/nchs/nhanes/index.htm>
#'
#' @format A data frame with columns:
#' \describe{
#' \item{exam}{NHANES exam: 2013-2014, 2015-2016, or 2017-2018}
#' \item{seqn}{survey participant identifier}
#' \item{psu}{primary sampling unit}
#' \item{strata}{survey strata}
#' \item{wts_mec_2yr}{2 year mobile examination weights}
#' \item{exam_status}{exam status. Participants either completed both the NHANES interview and exam or just the interview.}
#' \item{age}{participant's age, in years}
#' \item{sex}{participant's sex}
#' \item{race_ethnicity}{participant's race and ethnicity}
#' \item{education}{participant's education}
#' \item{pregnant}{pregancy status}
#' \item{bp_sys_mmhg}{participant's systolic blood pressure, mm Hg}
#' \item{bp_dia_mmhg}{participant's diastolic blood pressure, mm Hg}
#' \item{n_msr_sbp}{the number of valid systolic blood pressure readings}
#' \item{n_msr_dbp}{the number of valid diastolic blood pressure readings}
#' \item{bp_high_aware}{was participant ever told they had high blood pressure by a medical professional?}
#' \item{meds_bp}{is participant currently using medication to lower their blood pressure?}
#' }
#'
#' @note
#'
#' Blood pressure measurements
#'
#' The same protocol was followed to measure systolic and diastolic
#'   blood pressure (SBP and DBP) in each NHANES cycle. After survey
#'   participants had rested 5 minutes, their BP was measured by a
#'   trained physician using a mercury sphygmomanometer and an
#'   appropriately sized cuff. Three BP measurements were obtained at
#'   30 second intervals.
#'
#' @references
#'
#' 1. National health and nutrition examination survey homepage,
#'   available at https://www.cdc.gov/nchs/nhanes/index.htm.
#'   Accessed on 09/07/2020.
#'
#' @examples
#' nhanes
#'
"nhanes"
