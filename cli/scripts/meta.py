from __future__ import print_function, division

import sys, os, sqlite3, json
from semantic_version import Version
import api, util
import datetime
import mistune


def is_any_autostart():
  try:
    c = con.cursor()
    sql = "SELECT count(*) FROM components WHERE autostart = 'on'"
    c.execute(sql)
    data = c.fetchone()
    if data[0] > 0:
      return True
  except Exception as e:
    fatal_error(e, sql, "meta.is_any_autostart()")

  return False


def create_cluster(p_cluster, p_num_nodes, p_comp, p_first_port_num):
  port_num = p_first_port_num
  for i in range[p_first_port_num, (p_first_port_num + p_num_nodes)]:
    put_cluster(p_cluster, i, p_comp, port_num, 'not initialized', False)
    port_num = port_num + 1
   

def delete_cluster(p_cluster):
  try:
    c = con.cursor()
    sql = "DELETE FROM clusters WHERE cluster = ?"   
    c.execute(sql, [p_comp])
    con.commit()
    c.close()
  except Exception as e:
    fatal_error(e, sql, "meta.delete_cluster()")
  return


def insert_cluster(p_cluster, p_node_num, p_comp, p_port, p_stat):
  try:
    sql = "INSERT INTO clusters \n" + \
          "  (cluster, node_number, component, port, status) \n" + \
          "VALUES \n" + \
          "  (?, ?, ?, ?, ?)"
    c.execute(sql, [p_cluster, p_node_num, p_comp, p_port, p_stat])
    con.commit()
    c.close()
  except Exception as e:
    fatal_error(e, sql, "meta.put_clusters()")
  return


def put_components(p_comp, p_proj, p_ver, p_plat, p_port, p_stat,
                      p_autos, p_datadir, p_logdir, p_svcname, p_svcuser):
  try:
    c = con.cursor()
    sql = "DELETE FROM components WHERE component = ?"
    c.execute(sql, [p_comp])
    sql = "INSERT INTO components \n" + \
          "  (component, project, version, platform, port, status, \n" + \
          "   autostart, datadir, logdir, svcname, svcuser) \n" + \
          "VALUES \n" + \
          "  (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    c.execute(sql, [p_comp, p_proj, p_ver, p_plat, p_port, p_stat,
                    p_autos, p_datadir, p_logdir, p_svcname, p_svcuser])
    con.commit()
    c.close()
  except Exception as e:
    fatal_error(e, sql, "meta.put_components()")
  return


def get_extension_parent(ext_comp):
  ndx = ext_comp.index("-pg")
  return(ext_comp[(ndx + 1):])


def is_extension(ext_comp):
  try:
    c = con.cursor()
    sql = "SELECT c.component,c.project,p.category " + \
          "  FROM projects p,components c " + \
          " WHERE c.component='" + ext_comp + "' " + \
          "   AND c.project=p.project " + \
          "   AND p.is_extension = 1"
    c.execute(sql)
    data = c.fetchone()
    if not data:
      return False
  except Exception as e:
    fatal_error(e,sql,"meta.is_extension()")
  return True


def get_available_component_list():
  try:
    c = con.cursor()
    sql = "SELECT v.component FROM versions v WHERE v.is_current = 1 \n" + \
          "   AND " + util.like_pf("v.platform")
    c.execute(sql)
    t_comp = c.fetchall()
    r_comp = []
    for comp in t_comp:
      r_comp.append(str(comp[0]))
  except Exception as e:
    fatal_error(e,sql,"meta.get_available_component_list()")
  return  r_comp


def get_all_components_list(p_component=None, p_version=None, p_platform=None):
  try:
    c = con.cursor()
    sql = "SELECT v.component, v.version, v.platform" + \
          "  FROM versions v "
    if p_version is None:
      sql = sql + " WHERE v.is_current = 1 "
    elif p_version=="all":
      sql = sql + " WHERE v.is_current >= 0 "

    if (p_platform is None):
      sql = sql + " AND " + util.like_pf("v.platform") + " "
    if p_component:
      sql = sql + " AND v.component = '" + p_component + "'"
    if p_version and p_version!="all":
      sql = sql + " AND v.version = '" + p_version + "'"

    c.execute(sql)
    t_comp = c.fetchall()
    r_comp = []
    for comp in t_comp:
      if p_platform=="all":
        if comp[2]:
          platforms = comp[2].split(',')
          for p in platforms:
            comp_dict = {}
            comp_dict['component']= str(comp[0])
            version = str(comp[1]) + "-" + p.strip()
            comp_dict['version']= version
            r_comp.append(comp_dict)
        else:
          comp_dict = {}
          comp_dict['component']= str(comp[0])
          version = str(comp[1])
          if comp[2]:
            if p_platform is None:
              version = str(comp[1]) + "-" + util.get_pf()
            else:
              version = str(comp[1]) + "-" + p_platform
          comp_dict['version']= version
          r_comp.append(comp_dict)
      else:
        comp_dict = {}
        comp_dict['component']= str(comp[0])
        version = str(comp[1])
        if comp[2]:
          if p_platform is None:
            version = str(comp[1]) + "-" + util.get_pf()
          else:
            version = str(comp[1]) + "-" + p_platform
        comp_dict['version']= version
        r_comp.append(comp_dict)
  except Exception as e:
    fatal_error(e,sql,"meta.get_all_components_list()")
  return  r_comp


def update_component_version(p_app, p_version):
  try: 
    c = con.cursor()
    update_date=datetime.datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')
    sql = "UPDATE components SET version = ?,install_dt = ? WHERE component = ?"
    c.execute(sql, [p_version,update_date, p_app])
    con.commit()
    c.close()
  except Exception as e:
    fatal_error(e,sql,"meta.update_component_version()")

  return


## Get Component Version & Platform ########################################
def get_ver_plat(p_comp):
  try:
    c = con.cursor()
    sql = "SELECT version, platform FROM components WHERE component = ?"
    c.execute(sql,[p_comp])
    data = c.fetchone()
    if data is None:
      return "-1"
  except Exception as e:
    fatal_error(e,sql,"meta.get_ver_plat()")
  version = str(data[0])
  platform = str(data[1])
  if platform == "":
    return(version)
  return(version + "-" + platform)


## Get latest current version & platform ###################################
def get_latest_ver_plat(p_comp, p_new_ver=""):
  try: 
    c = con.cursor()
    sql = "SELECT version, platform, is_current, release_date \n" + \
          "  FROM versions \n" + \
          " WHERE component = ? \n" + \
          "   AND " + util.like_pf("platform") + "\n" + \
          "ORDER BY 3 DESC, 4 DESC"
    c.execute(sql,[p_comp])
    data = c.fetchone()
    if data is None:
      return "-1"
  except Exception as e:
    fatal_error(e,sql,"meta.get_latest_ver_plat()")
  if p_new_ver == "":
    version = str(data[0])
  else:
    version = p_new_ver
  platform = str(data[1])
  pf = util.get_pf()
  if platform == "":
    ver_plat = version
  else:
    if pf in platform:
      ver_plat = version + "-" + pf
    else:
      ver_plat = version + "-amd"
  return(ver_plat)


## Get platform specific version for component ###############################
def get_platform_specific_version(p_comp, p_ver):
  try:
    c = con.cursor()
    sql = "SELECT version, platform FROM versions " + \
          " WHERE component = ? " + \
          "   AND " + util.like_pf("platform") + \
          "   AND version = ?"
    c.execute(sql,[p_comp,p_ver])
    data = c.fetchone()
    if data is None:
      return "-1"
  except Exception as e:
    fatal__error(e,sql,"meta.get_platform_specific_version()")
  version = str(data[0])
  platform = str(data[1])
  if platform == "":
    return(version)
  return(version + "-" + util.get_pf())


## get list of installed & available components ###############################
def get_list(p_isOLD, p_isExtensions, p_isJSON, p_isTEST, p_showLATEST, p_comp=None, p_relnotes=None, p_return=False):
  # r_sup_plat = util.like_pf("r.sup_plat")
  r_sup_plat = "1 = 1"

  if p_isOLD:
    exclude_comp = ""
  else:
    exclude_comp = " AND v.component NOT IN (SELECT component FROM components)"

  parent_comp_condition = ""
  installed_category_conditions = " AND p.category > 0 "
  available_category_conditions = " AND p.is_extension = 0"
  ext_component = ""

  if p_isExtensions:
    installed_category_conditions = " AND p.is_extension = 1"
    available_category_conditions = " AND p.is_extension = 1"
    if p_comp != "all":
      ext_component = " AND parent = '" + p_comp + "' "

  installed = \
    "SELECT p.category, g.description as category_desc, g.short_desc as short_cat_desc, \n" + \
    "       c.component, c.version, c.port, c.status, r.stage, \n" + \
    "       coalesce((select is_current from versions where c.component = component AND c.version = version),0), \n" + \
    "       c.datadir, p.is_extension, \n" + \
    "       coalesce((select parent from versions where c.component = component and c.version = version),'') as parent, \n" + \
    "       coalesce((select release_date from versions where c.component = component and c.version = version),'20200101'), \n" + \
    "       c.install_dt, r.disp_name, \n" + \
    "       coalesce((select release_date from versions where c.component = component and is_current = 1),'20200101') \n" + \
    "  FROM components c, releases r, projects p, categories g \n" + \
    " WHERE c.component = r.component AND r.project = p.project \n" + \
    "   AND p.category = g.category \n"  + \
    "   AND " + r_sup_plat + installed_category_conditions + ext_component

  available = \
    "SELECT c.category, c.description, c.short_desc as short_cat_desc, v.component, v.version, 0, 'NotInstalled', \n" + \
    "       r.stage, v.is_current, '', p.is_extension, v.parent as parent, v.release_date, '', \n" + \
    "       r.disp_name, \n" + \
    "       coalesce((select release_date from versions where v.component = component and is_current = 1),'20200101') \n" + \
    "  FROM versions v, releases r, projects p, categories c \n" + \
    " WHERE v.component = r.component AND r.project = p.project \n" + \
    "   AND p.category = c.category \n" + \
    "   AND " + util.like_pf("v.platform") + " \n" + \
    "   AND " + r_sup_plat + exclude_comp + available_category_conditions + ext_component

  extensions = \
    "SELECT c.category, c.description, c.short_desc as short_cat_desc, v.component, v.version, 0, 'NotInstalled', \n" + \
    "       r.stage, v.is_current, '', p.is_extension, v.parent as parent, v.release_date, '', \n" + \
    "       r.disp_name,  \n" + \
    "       coalesce((select release_date from versions where v.component = component and is_current = 1),'20200101') \n" + \
    "  FROM versions v, releases r, projects p, categories c \n" + \
    " WHERE v.component = r.component AND r.project = p.project \n" + \
    "   AND p.is_extension = 1 AND p.category = c.category \n" + \
    "   AND " + util.like_pf("v.platform") + " \n" + \
    "   AND v.parent in (select component from components) AND " + r_sup_plat + exclude_comp

  if p_isExtensions:
    sql = installed + "\n UNION \n" + available + "\n ORDER BY 1, 3, 4, 6"
  else:
    sql = installed + "\n UNION \n" + available + "\n UNION \n" + extensions + "\n ORDER BY 1, 3, 4, 6"

  try:
    c = con.cursor()
    c.execute(sql)
    data = c.fetchall()

    headers = ['Category','Component', 'Version', 'ReleaseDt', 'Stage', 'Status', 'Updates']
    keys    = ['short_cat_desc', 'component', 'version', 'release_date', 'stage', 'status', 'current_version']

    jsonList = []
    kount = 0
    previous_version = None
    previous_comp = None
    for row in data:
      compDict = {}
      kount = kount + 1

      category = str(row[0])
      category_desc = str(row[1])
      short_cat_desc = str(row[2])
      comp = str(row[3])
      version = str(row[4])
      port = str(row[5])

      if previous_comp and previous_version:
        if previous_comp == comp and previous_version == version:
          continue

      previous_version = version
      previous_comp = comp

      if str(row[6]) == "Enabled":
        status = "Installed"
      else:
        status = str(row[6])
      if status == "NotInstalled" and p_isJSON == False:
        status = ""

      stage = str(row[7])
      if stage in ("soon", "bring-own"):
        continue

      is_current = str(row[8])
      if is_current == "0" and status in ("", "NotInstalled"):
        if not p_isOLD:
          continue

      current_version = get_current_version(comp)
      is_update_available = 0
      cv = Version.coerce(current_version)
      iv = Version.coerce(version)
      if cv>iv:
        is_update_available = 1

      if is_update_available==0:
        updates = 0
        current_version = ""
      else:
        updates = 1

      if (port == "0") or (port == "1"):
        port = ""

      datadir = row[9]
      if row[9] is None:
        datadir = ""
      else:
        datadir = str(row[9]).strip()

      is_extension = row[10]

      parent = row[11]

      disp_name = row[14]

      release_desc = ''
      release_date = '1970-01-01'
      curr_rel_date = '1970-01-01'

      curr_rel_dt=str(row[15])
      rel_dt = str(row[12])
      if len(rel_dt) == 8:
        release_date = rel_dt[0:4] + "-" + rel_dt[4:6] + "-" + rel_dt[6:8]
        curr_rel_date = curr_rel_dt[0:4] + "-" + curr_rel_dt[4:6] + "-" + curr_rel_dt[6:8]


      compDict['is_new'] = 0

      try:
        rd = datetime.datetime.strptime(release_date, '%Y-%m-%d')
        today_date = datetime.datetime.today()
        date_diff = (today_date - rd).days

        if date_diff <= 30:
          compDict['is_new'] = 1
        if p_showLATEST and date_diff > 30:
          continue
      except Exception as e:
        pass

      if util.is_postgres(comp):
        if port > "" and status == "Installed" and datadir == "":
          status = "NotInitialized"
          port = ""

      ins_date = str(row[13])
      install_date=""
      compDict['is_updated'] = 0
      if ins_date:
        install_date = ins_date[0:4] + "-" + ins_date[5:7] + "-" + ins_date[8:10]

        try:
          insDate = datetime.datetime.strptime(install_date, '%Y-%m-%d')
          today_date = datetime.datetime.today()
          date_diff = (today_date - insDate).days
          if date_diff <= 30:
            compDict['is_updated'] = 1
        except Exception as e:
          pass

      if p_relnotes and p_isJSON:
        rel_version=version
        if current_version!="":
          rel_version=current_version
        rel_notes = str(util.get_relnotes(comp, rel_version))
        markdown_text = unicode(rel_notes,sys.getdefaultencoding(),errors='ignore').strip()
        html_text = mistune.markdown(markdown_text)
        compDict['rel_notes'] = html_text

      compDict['category'] = category
      compDict['category_desc'] = category_desc
      compDict['short_cat_desc'] = short_cat_desc
      compDict['component'] = comp
      compDict['version'] = version
      compDict['is_extension'] = is_extension
      compDict['disp_name'] = disp_name
      compDict['release_desc'] = release_desc
      compDict['port'] = port
      compDict['release_date'] = release_date
      compDict['install_date'] = install_date
      compDict['curr_release_date'] = curr_rel_date
      compDict['status'] = status
      compDict['stage'] = stage
      compDict['updates'] = updates
      compDict['is_current'] = is_current
      compDict['current_version'] = current_version
      compDict['parent'] = parent
      jsonList.append(compDict)

    if p_return:
      return jsonList

    if p_isJSON:
      print(json.dumps(jsonList, sort_keys=True, indent=2))
    else:
      if len(jsonList) >= 1:
        if p_showLATEST:
          print("New components released in the last 30 days.")
        print(api.format_data_to_table(jsonList, keys, headers))

  except Exception as e:
    fatal_error(e, sql, "meta.get_list()")
  sys.exit(0)    


## Check if component required for platform #########
def is_dependent_platform(p_comp):
  try:
    c = con.cursor()
    sql = "SELECT platform FROM versions WHERE component = ?"
    c.execute(sql,[p_comp])
    data = c.fetchone()
    if data is None:
      return False
  except Exception as e:
    fatal_error(e,sql,"meta.is_dependent_platform()")
  platform = str(data[0])
  if len(platform.strip()) == 0 or util.has_platform(platform) >= 0:
    return True
  return False


## get component version ############################
def get_version(p_comp):
  try:
    c = con.cursor()
    sql = "SELECT version FROM components WHERE component = ?"
    c.execute(sql,[p_comp])
    data = c.fetchone()
    if data is None:
      return ""
  except Exception as e:
    fatal_error(e,sql,"meta.get_version()")
  return str(data[0])


## Get Current Version ###################################################
def get_current_version(p_comp):
  try:
    c = con.cursor()
    sql = "SELECT version FROM versions WHERE component = ? AND is_current=1"
    c.execute(sql,[p_comp])
    data = c.fetchone()
    if data is None:
      sql = "SELECT version, release_date FROM versions WHERE component = ? ORDER BY 2 DESC"
      c.execute(sql,[p_comp])
      data = c.fetchone()
      if data is None:
        return ""
  except Exception as e:
    fatal_error(e,sql,"meta.get_current_version()")
  return str(data[0])


def get_dependent_components(p_comp):
  data = []
  sql = "SELECT c.component FROM projects p, components c \n" + \
        " WHERE p.project = c.project AND p.depends = \n" + \
        "   (SELECT project FROM releases \n" + \
        "     WHERE component = '" + p_comp + "')"
  try:
    c = con.cursor()
    c.execute(sql)
    data = c.fetchall()
  except Exception as e:
    fatal_error(e,sql,"meta.get_dependent_components()")
  return data


def get_component_list():
  try:
    c = con.cursor()
    sql = "SELECT component FROM components"
    c.execute(sql)
    t_comp = c.fetchall()
    r_comp = []
    for comp in t_comp:
      r_comp.append(str(comp[0]))
  except Exception as e:
    fatal_error(e,sql,"meta.get_component_list()")
  return r_comp;


def get_installed_extensions_list(parent_c):
  try:
    c = con.cursor()
    sql = "SELECT c.component FROM versions v ,components c " + \
          "WHERE v.component = c.component AND v.parent='" + parent_c + "'"
    c.execute(sql)
    t_comp = c.fetchall()
    r_comp = []
    for comp in t_comp:
      r_comp.append(str(comp[0]))
  except Exception as e:
    fatal_error(e,sql,"meta.get_installed_extensions_list()")
  return r_comp;


def fatal_error(err, sql, func):
  print("################################################")
  print("# FATAL Error in " + func)
  print("#    Message =  " + err.args[0])
  print("#  Statement = " + sql)
  print("################################################")
  sys.exit(1)


## MAINLINE ################################################################
con = sqlite3.connect(os.getenv("MY_HOME") + os.sep + "conf" + os.sep + "db_local.db", check_same_thread=False)
