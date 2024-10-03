# Scheduled Tasks Trackers and Documentation

**Note:** All cronjobs are currently running on AWS EC2 and need to be migrated to Google Cloud Run in the future.

## Table of Contents
- [Daily Jobs](#daily-jobs)
- [Weekly Jobs](#weekly-jobs)
- [Monthly Jobs](#monthly-jobs)
- [Quarterly Jobs](#quarterly-jobs)
- [Annual Jobs](#annual-jobs)
- [Migration Notes](#migration-notes)
- [Logging](#logging)

## Daily Jobs

### Print Franchisor Team Groups

**Status:** Running
**Schedule:** Daily
**Environments:**
- Australia (AU): 1:15 AM
- United States (US): 1:20 AM

**Purpose:** Exports Franchisor Team group members to Google Sheets for Zapier automations.

**Commands:**
```bash
# Australia
/home/ec2-user/bin/gamadv-xtd3/gam select au save && /home/ec2-user/bin/gamadv-xtd3/gam group [ft_group]@gjgardner.com.au print user fields primaryEmail givenName familyName issuspended false todrive tdtitle "GAM CRON - [ft_group] AU" tdsheet "ft_au" tdfileid 1bcj6XzwbXzaitgut3mbgAiug8VUPkftYW8hU6KF9h-k >> /home/ec2-user/gam-logs/[ft_group]_au.log 2>&1

# United States
/home/ec2-user/bin/gamadv-xtd3/gam select us save && /home/ec2-user/bin/gamadv-xtd3/gam group [ft_group]@gjgardner.com print user fields primaryEmail givenName familyName issuspended false todrive tdtitle "GAM CRON - [ft_group] US" tdsheet "ft_us" tdfileid 1KM4zectTT5iys1c2n_F0t_oiFiush96orHOZnYXdfWk >> /home/ec2-user/gam-logs/[ft_group]_us.log 2>&1
```

### Print Franchise Owner Groups

**Status:** Running
**Schedule:** Daily
**Environments:**
- United States (US): 1:25 AM
- Australia (AU): 1:30 AM

**Purpose:** Exports Franchise Owner group members to Google Sheets for Zapier automations.

**Commands:**
```bash
# United States
/home/ec2-user/bin/gamadv-xtd3/gam select us save && /home/ec2-user/bin/gamadv-xtd3/gam group [fo_group]@gjgardner.com print user fields primaryEmail givenName familyName issuspended false todrive tdtitle "GAM CRON - [fo_group] US" tdsheet "[fo_group] US" tdfileid 10pAwGBnFpx1lDrWCNcGj1U2Q_pwWPNIb63cpnZxfY94 >> /home/ec2-user/gam-logs/[fo_group]_us.log 2>&1

# Australia
/home/ec2-user/bin/gamadv-xtd3/gam select au save && /home/ec2-user/bin/gamadv-xtd3/gam group [fo_group]@gjgardner.com.au print user fields primaryEmail givenName familyName issuspended false todrive tdtitle "GAM CRON - [fo_group] AU" tdsheet "[fo_group] AU" tdfileid 1ezpey8xk-bFIPeA4dQsuVtjtWMYYFVIb-5NeXL07hUg >> /home/ec2-user/gam-logs/[fo_group]_au.log 2>&1
```

### Print Regional Franchise Owner Groups (Australia)

**Status:** Running
**Schedule:** Daily
**Environment:** Australia (AU)
**Regions:**
- Victas: 1:35 AM
- QLDNT: 1:40 AM
- SA: 1:45 AM
- NSWACT: 1:50 AM

**Purpose:** Exports regional Franchise Owner group members to Google Sheets.

**Commands:**
```bash
# Victas
/home/ec2-user/bin/gamadv-xtd3/gam select au save && /home/ec2-user/bin/gamadv-xtd3/gam group [fo_group]@gjgardner.com.au print user fields primaryEmail givenName familyName issuspended false todrive tdtitle "GAM CRON - [fo_group]" tdsheet "[fo_group]" tdfileid 18sPPrKjMiYcUshlc05T-IXFhNfWiSuKJQHOvuSbO7As >> /home/ec2-user/gam-logs/[fo_group].log 2>&1

# QLDNT
/home/ec2-user/bin/gamadv-xtd3/gam select au save && /home/ec2-user/bin/gamadv-xtd3/gam group [fo_group]@gjgardner.com.au print user fields primaryEmail givenName familyName issuspended false todrive tdtitle "GAM CRON - [fo_group]" tdsheet "[fo_group]" tdfileid 1eNm3gtieUePaLItrrw4AGDL0I3NW_-pzP4SjxEgJC6k >> /home/ec2-user/gam-logs/[fo_group].log 2>&1

# SA
/home/ec2-user/bin/gamadv-xtd3/gam select au save && /home/ec2-user/bin/gamadv-xtd3/gam group [fo_group]@gjgardner.com.au print user fields primaryEmail givenName familyName issuspended false todrive tdtitle "GAM CRON - [fo_group]" tdsheet "[fo_group]" tdfileid 1BzjEB6_m4__icPUq36cp6x-8Ika2dGte6_reQ2pTwlQ >> /home/ec2-user/gam-logs/[fo_group].log 2>&1

# NSWACT
/home/ec2-user/bin/gamadv-xtd3/gam select au save && /home/ec2-user/bin/gamadv-xtd3/gam group [fo_group]@gjgardner.com.au print user fields primaryEmail givenName familyName issuspended false todrive tdtitle "GAM CRON - [fo_group]" tdsheet "[fo_group]" tdfileid 1bD-_UhkckIltll6WlZ2hg8ZfGtLGi_Nv-fJ4Gb_X0Gc >> /home/ec2-user/gam-logs/[fo_group].log 2>&1
```

### Print All Staff Lists

**Status:** Running
**Schedule:** Daily
**Environments:**
- United States (US): 4:00 AM
- New Zealand (NZ): 4:10 AM
- Australia (AU): 4:20 AM

**Purpose:** Exports all staff members to Google Sheets for Zapier automations.

**Commands:**
```bash
# United States
/home/ec2-user/bin/gamadv-xtd3/gam select us save && /home/ec2-user/bin/gamadv-xtd3/gam print user fields primaryEmail givenName familyName issuspended false todrive tdtitle "GAM CRON - all_staff US" tdsheet "all_staff US" tdfileid 10pAwGBnFpx1lDrWCNcGj1U2Q_pwWPNIb63cpnZxfY94 >> /home/ec2-user/gam-logs/all_staff_us.log 2>&1

# New Zealand
/home/ec2-user/bin/gamadv-xtd3/gam select nz save && /home/ec2-user/bin/gamadv-xtd3/gam print user fields primaryEmail givenName familyName issuspended false todrive tdtitle "GAM CRON - all_staff NZ" tdsheet "all_staff NZ" tdfileid 17J-UhPfLJCsZ_sLg89ab91O6joH_3XazN-MpTooqqPQ >> /home/ec2-user/gam-logs/all_staff_nz.log 2>&1

# Australia
/home/ec2-user/bin/gamadv-xtd3/gam select au save && /home/ec2-user/bin/gamadv-xtd3/gam print user fields primaryEmail givenName familyName issuspended false todrive tdtitle "GAM CRON - all_staff AU" tdsheet "all_staff AU" tdfileid 11zkvqhK3cg9KGsolKg0xV-dvEupBfEkK17nEgZWPM2s >> /home/ec2-user/gam-logs/all_staff_au.log 2>&1
```

### Create Daily Backup of Crontab

**Status:** Not running (commented out)
**Schedule:** Daily at 3:00 AM
**Environment:** All

**Command:**
```bash
cd ~/gjg-gam-scripts/logs/ && crontab -l > crontab.txt | echo "`date` - Backup created" >> ~/gjg-gam-scripts/logs/backup.log 2>&1
```
**Purpose:** Creates a daily backup of the crontab file.

### Update Organizational Units from Groups

**Status:** Not running (commented out)
**Schedule:** Daily at 3:10 AM
**Environment:** All

**Command:**
```bash
cd ~/gjg-gam-scripts/ && ./UpdateOrgUnitFromGroups.sh >> ~/gjg-gam-scripts/logs/orgunit_update.log 2>&1
```
**Purpose:** Updates Organizational Units based on group memberships.

## Weekly Jobs

### Update GAMADV-XTD3

**Status:** Running
**Schedule:** Weekly on Sunday at 2:00 AM
**Environment:** All

**Command:**
```bash
bash <(curl -s -S -L https://raw.githubusercontent.com/taers232c/GAMADV-XTD3/master/src/gam-install.sh) -l
```
**Purpose:** Updates GAMADV-XTD3 to the latest version.

## Monthly Jobs

*No monthly jobs currently scheduled.*

## Quarterly Jobs

*No quarterly jobs currently scheduled.*

## Annual Jobs

*No annual jobs currently scheduled.*

## Migration Notes

1. When migrating to Google Cloud Run, consider using Cloud Scheduler for managing these jobs.
2. Ensure that all necessary permissions and service accounts are set up in Google Cloud.
3. Update file paths and environment-specific configurations during migration.
4. Test each job thoroughly after migration to ensure functionality in the new environment.
5. Consider containerizing scripts that these cronjobs run for better portability and consistency.

## Logging

Most jobs log their output to specific log files in the `/home/ec2-user/gam-logs/` directory. Ensure a similar logging mechanism is set up in the Google Cloud environment.