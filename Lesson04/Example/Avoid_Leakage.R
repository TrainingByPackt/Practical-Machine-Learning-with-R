# Avoiding ID leakage
# NOTE: Can't be run as we don't actually have an ApplicantID column
data(GermanCredit)
partition(GermanCredit, p = c(0.6, 0.2),
          cat_col = "Class",
          id_col = "ApplicantID")
# With this, each applicant would have all their observations/rows
# in the same partition!
