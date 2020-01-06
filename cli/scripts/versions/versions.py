import sqlite3, sys

## init global vars
COLS=4
cat = ""
cat_desc = ""
image_file = ""
component = ""
project = ""
release_name = ""
version = ""
source_url = ""
project_url = ""
platform = ""
rel_day = ""
rel_month = ""
proj_desc = ""
version = ""


def print_top():
  print('<table border=0 bgcolor=red cellpadding=3>')
  print('  <tr><td width=1000><img src=img/bigArmLogo.png /></td>')

  print('    <td>To install on EL8 or Amazon Linux 2 from the command line:')
  print('<pre> ' + \
    'python3 -c "$(curl -fsSL https://dockpg-download.s3.amazonaws.com/REPO/install.py)"' + \
    '</pre></td>')
  print('  </tr>')
  print('</table>')

  print('\n<table border=0 cellpadding=3>')


def get_columns(d):
  global cat, cat_desc, image_file, component, project, release_name
  global version, source_url, project_url, platform, rel_date, rel_month
  global rel_day, stage, proj_desc, version

  cat = str(d[0])
  cat_desc = str(d[1])
  image_file = str(d[2])
  component = str(d[3])
  project = str(d[4])
  release_name = str(d[5])
  version = str(d[6])
  source_url = str(d[7])
  project_url = str(d[8])

  platform = str(d[9])
  if platform == "":
    platform = "amd, arm"

  rel_date = str(d[10])
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
  if rel_day[1:1] == "0":
    rel_day = rel_day[2:]

  stage = str(d[11])
  proj_desc = str(d[12])

  if version[-2] == "-":
     version = version[:-2]


def print_row_header():
  print("<tr><td colspan=" + str(COLS * 2) + ">&nbsp;<br><font size=+2><b><u>" + \
    cat_desc + ":</u></b></font></td></tr>")


######################################
#   MAINLINE
######################################
con = sqlite3.connect("local.db")
c = con.cursor()

sql = "SELECT cat, cat_desc, image_file, component, project, release_name, \n" + \
      "       version, sources_url, project_url, platform, release_date, \n" + \
      "       stage, proj_desc \n" + \
      "  FROM v_versions \n" + \
      " WHERE is_current = 1 AND cat > 0 \n" + \
      "ORDER BY cat, project, release_name"

c.execute(sql)
data = c.fetchall()

i = 0
col = 0
old_cat_desc = ""
print_top()

for d in data:
  i = i + 1

  get_columns(d)

  if (old_cat_desc != cat_desc):
    print_row_header()
    col = 1

  if col == 1:
    print("<tr>")

  print("  <td width=60>&nbsp;<img src=img/" + image_file + " height=50 width=50 /></td>")
  print("  <td width=300><a href=" + project_url + ">" + release_name + \
             "</a>&nbsp;&nbsp;<a href=" + source_url + ">v" + version + \
             "</a>&nbsp;&nbsp;<font color=red size=-2>" + rel_month + " " + rel_day + \
             "</font>&nbsp;&nbsp;<font size=-2>[" + platform + "]</font><br>" + \
             "<i>" + proj_desc + "</i></td>")

  if col == COLS:
    print("</tr>")
    col = 1
  else:
    col = col + 1

  old_cat_desc = cat_desc

print("</table>")
sys.exit(0)


