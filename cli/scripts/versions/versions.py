import sqlite3
con = sqlite3.connect("local.db")
c = con.cursor()

sql = "SELECT cat, cat_desc, image_file, component, project, release_name, \n" + \
      "       version, sources_url, project_url, platform, release_date, \n" + \
      "       stage, proj_desc \n" + \
      "  FROM v_versions \n" + \
      " WHERE is_current = 1 AND cat > 0 \n" + \
      "ORDER BY cat, project, release_name"
##      "   AND ((cat in (1,3, 4)) or ((cat = 2) and (component like '%pg11%'))) \n" + \

c.execute(sql)
data = c.fetchall()

print("<table border=0 cellpadding=2>")

i=0
for d in data:
  i = i+1
  if i == 1:
    old_cat_desc = str(d[1])

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


  if ((old_cat_desc <> cat_desc) or  (i == 1)):
    print("  <tr><td colspan=5>&nbsp;<br><font size=+2><b><u>" + cat_desc + ":</u></b></font></td></tr>")
  
  print("  <tr>")
  print("    <td width=63>&nbsp;&nbsp;&nbsp;<img src=img/" + image_file + " height=50 width=50 /></td>")
  print("    <td width=115><a href=" + project_url + ">" + release_name + "</a></td>")
  print("    <td width=100><a href=" + source_url + ">v" + version + \
          "</a>&nbsp;<font color=red size=-2>" + rel_month + " " + rel_day + "</font></td>")
  print("    <td>" + proj_desc + "</td>")

  print("  </tr>")

  old_cat_desc = cat_desc

print("</table>")

