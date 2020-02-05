import sqlite3, sys

isSHOW_COMP_PLAT = 'Y'
BR = "<br>"
WIDTH = 875
COL_SIZE = 265
NUM_COLS = 3
FONT_SIZE = 2
IMG_SIZE = 30
BORDER=0
SEP_WIDTH = NUM_COLS * (COL_SIZE + IMG_SIZE + 9)


def print_top():
  print('<center><table><tr><td> \n')

  print('<table height=100 width=' + str(WIDTH) + ' border=0 bgcolor=black cellpadding=5> \n' +
        '  <tr> \n' + \
        '    <td width=20%><img width=200 height=35 src=img/bigsql-banner.png /></td> \n' + \
        '    <td width=45%><font color=white> \n' + \
        'ARM & AMD binaries on Linux, OSX, and Windows</font>\n' + \
        '    </td>\n' + \
        '    <td width=35%><font size=-1 color=white>\n' + \
        'BUCKET=https://bigsql-apg.s3.amazonaws.com<br>\n' + \
        'INSTALLER=$BUCKET/REPO/install.py<br>\n' + \
        'python3 -c "$(curl -fsSL $INSTALLER)"</font>\n' + \
        '    </td>\n' + \
        '  </tr>\n' + \
        '</table>\n\n')

  print('<table border=' + str(BORDER) + ' bgcolor=white cellpadding=2>')

 
def print_bottom():
  print('    </td>\n  </tr>\n</table>\n</center>\n\n<br>\n')
  print('&copy; BigSQL 2015-2020, All rights reserved.')


def get_columns(d):
  global cat, cat_desc, image_file, component, project, release_name
  global version, source_url, project_url, platform, rel_date, rel_month
  global rel_day, rel_yy, stage, proj_desc, version

  cat = str(d[0])
  cat_desc = str(d[1])
  image_file = str(d[2])
  component = str(d[3])
  project = str(d[4])
  release_name = str(d[5])
  version = str(d[6]).replace("-1", "")
  source_url = str(d[7])
  project_url = str(d[8])

  platform = str(d[9])

  rel_date = str(d[10])
  rel_yy = rel_date[2:4]
  rel_month = rel_date[4:6]
  if rel_month == "01":
     rel_month = "Jan"
  elif rel_month == "02":
     rel_month = "Feb"
  elif rel_month == "03":
     rel_month = "Mar"
  elif rel_month == "04":
     rel_month = "Apr"
  elif rel_month == "05":
     rel_month = "May"
  elif rel_month == "06":
     rel_month = "Jun"
  elif rel_month == "07":
     rel_month = "Jul"
  elif rel_month == "08":
     rel_month = "Aug"
  elif rel_month == "09":
     rel_month = "Sep"
  elif rel_month == "10":
     rel_month = "Oct"
  elif rel_month == "11":
     rel_month = "Nov"
  elif rel_month == "12":
     rel_month = "Dec"

  rel_day = rel_date[6:]
  if rel_day[0:1] == "0":
    rel_day = rel_day[1]

  stage = ""
  stage = str(d[11])
  if stage == "prod":
    stage = ""
  else:
    stage = "--" + stage

  proj_desc = str(d[12])


def print_row_header(pBR):
  print("<tr><td colspan=" + str(NUM_COLS * 2) + ">" + pBR + "<b>" + \
    cat_desc + ":</b></td></tr>")


def print_row_detail(pCol, pBR):
  if rel_date == '19700101':
    rel_date_display = ""
  else:
    rel_date_display = rel_day + "-" + rel_month + rel_yy_display

  print("  <td>&nbsp;<img src=img/" + image_file + " height=" + \
    str(IMG_SIZE) + " width=" + str(IMG_SIZE) + " /></td>")
  print("  <td width=" +str( COL_SIZE) + "><font size=" + str(FONT_SIZE) + \
    "><a href=" + project_url + ">" + release_name + \
    "</a>&nbsp;&nbsp;<a href=" + source_url + ">v" + version + \
    "</a>&nbsp;<font color=red size=" + str(FONT_SIZE) + "><sup>" + \
    rel_date_display +"</sup></font>" + \
    platd + pBR + "<i>" + proj_desc + "</font></i></td>")

  if pCol == NUM_COLS:
    print("</tr>")
    print("<tr><td></td></tr>")

  return


##################################################################
#   MAINLINE
##################################################################
con = sqlite3.connect("local.db")
c = con.cursor()

sql = "SELECT cat, cat_desc, image_file, component, project, release_name, \n" + \
      "       version, sources_url, project_url, platform, release_date, \n" + \
      "       stage, proj_desc, sort_order \n" + \
      "  FROM v_versions \n" + \
      " WHERE is_current = 1 AND cat > 0 \n" + \
      "ORDER BY 1, 14"

c.execute(sql)
data = c.fetchall()

i = 0
old_cat_desc = ""
print_top()
col = 0

for d in data:
  i = i + 1

  get_columns(d)

  if (old_cat_desc != cat_desc):
    print_row_header(BR)
    col = 1

  if col == 1:
    print("<tr>")

  platd = ""
  if isSHOW_COMP_PLAT == "Y":
    platd = BR + component + " [" + platform + "] " + stage

  #print('DEBUG rel_date = ' + rel_date)
  year_day = int(rel_date[:6])
  #print('DEBUG year_day=' + str(year_day))
  months_old = 202001 - year_day
  #print('DEBUG months_old =' + str(months_old))
  if months_old < 99:
    rel_yy_display = ""
  else:
    rel_yy_display = "-" + rel_yy

  print_row_detail(col, BR)

  if col == NUM_COLS:
    col = 1
  else:
    col = col + 1

  old_cat_desc = cat_desc

print_bottom()
sys.exit(0)


