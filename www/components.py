import sqlite3, sys, pgsql

ALL_PLATFORMS = "arm, amd, osx"
isSHOW_COMP_PLAT = "Y"
isSHOW_DESCRIPTION = "Y"
BR = "<br>"
WIDTH = 900
COL_SIZE = 300
NUM_COLS = 3
FONT_SIZE = 3
IMG_SIZE = 35
BORDER=0

if NUM_COLS == 1:
  BR = "&nbsp;"
  FONT_SIZE = 4
  COLS_SIZE = 600
  IMG_SIZE = 35
  BORDER=1


def print_top():
  pgsql.print_header(WIDTH)

  print("\n<p>")

  print('<table width=' + str(WIDTH) + ' border=' + str(BORDER) + ' bgcolor=whitesmoke cellpadding=1>')
  print("<tr><td colspan=3><font size=+2>&nbsp;<br><b><u>Components</u></b></font></td></tr>")

 
def print_bottom():
  print('\n</td></tr></table></center><br>\n')
  pgsql.print_footer()


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
  if ((platform == "")):
    platform = "[" + ALL_PLATFORMS + "]"
  else:
    platform = "[" + platform + "]"

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
  print("<tr><td colspan=" + str(NUM_COLS * 2) + "><br><font size=+1><b>" + \
    cat_desc + "</b></font></td></tr>")


def print_row_detail(pCol, pBR):
  global proj_desc, component

  platd = ""
  if isSHOW_COMP_PLAT == "Y":
    platd = BR + component + " " + platform + " " + stage

  year_day = int(rel_date[:6])
  months_old = 202001 - year_day
  if months_old < 99:
    rel_yy_display = ""
  else:
    rel_yy_display = "-" + rel_yy

  if rel_date == '19700101':
    rel_date_display = ""
  else:
    rel_date_display = rel_day + "-" + rel_month + rel_yy_display

  if isSHOW_DESCRIPTION == "N" or component[0:3] in ("pg9", "pg1"):
    proj_desc = ""

  print("  <td width=" + str(IMG_SIZE) + ">&nbsp;<img src=img/" + image_file + \
    " height=" + str(IMG_SIZE) + " width=" + str(IMG_SIZE) + " /></td>")
  print("  <td width=" +str( COL_SIZE) + ">&nbsp;<br><font size=" + str(FONT_SIZE) + \
    "><a href=" + project_url + ">" + release_name + \
    "</a>&nbsp;&nbsp;<a href=" + source_url + ">v" + version + \
    "</a>&nbsp;<font color=red size=-1><sup>" + \
    rel_date_display +"</sup></font>" + \
    platd + pBR + "<i>" + proj_desc + "</font></i></td>")

  if pCol == NUM_COLS:
    print("</tr>")
    if NUM_COLS != 1:
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
skip_next = False

for d in data:
  if i == 0:
    old_d = d
    i = 1
    continue

  if skip_next == True:
    old_d = d
    skip_next = False
    continue

  i = i + 1
  
  get_columns(old_d)

  next_comp = str(d[3])                                                         
  next_proj = str(d[4])
  next_rel  = str(d[5])                                                         
  next_ver  = str(d[6]).replace("-1", "")

  if ((next_proj == project) and 
      (next_rel == release_name) and 
      (next_ver == version)):
    ##print("DEBUG: combine these two components: " + component + ", " + next_comp)
    skip_next = True
    component = component + "," + next_comp[-2:]


  if (old_cat_desc != cat_desc):
    print_row_header(BR)
    col = 1

  if col == 1:
    print("<tr>")


  print_row_detail(col, BR)

  if col == NUM_COLS:
    col = 1
  else:
    col = col + 1

  old_cat_desc = cat_desc
  old_d = d

get_columns(d)
print_row_detail(col, BR)

print_bottom()
sys.exit(0)


