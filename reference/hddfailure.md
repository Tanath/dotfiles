Blackblaze
==========

For the last few years we've used the following five SMART stats as a means of helping determine if a drive is going to fail.

| Attribute	 |	Description                   |
|----------------|------------------------------------| 
| SMART 5	 |	Reallocated Sectors Count     |
| SMART 187	 |	Reported Uncorrectable Errors |
| SMART 188	 |	Command Timeout               |
| SMART 197	 |	Current Pending Sector Count  |
| SMART 198	 |	Uncorrectable Sector Count    |

When the RAW value for one of these five attributes is greater than zero, we have a reason to investigate.
* Operational drives with one or more of our five SMART stats greater than zero – 4.2%
* Failed drives with one or more of our five SMART stats greater than zero – 76.7%

Power cycles are most strongly correlated with failure.
