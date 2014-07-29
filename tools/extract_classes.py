#!/usr/bin/env python
# ----------------------------------------------------------------------- #
import os
#import shutil
import argparse
import xml.dom.minidom
import re
import pprint
import sys

# TODO: get namespace prefixes from root element
xs_prefix = 'xs:'
aae_prefix = 'aae:'

# ASSUMPTION:
# 1) any elements from XMLSchema are using 'xs' as namespace prefix
# 2) any definded types are referenced using 'aae' prefix
# 3) the complex types defining the for 4 node categories are:
master_types = {
    'MachineAttributes': 'Machine',
    'ResourceAttributes': 'Resource',
    'SoftwareAttributes': 'Software',
    'ApplicationAttributes': 'Application'
}
    

# ----------------------------------------------------------------------- #
# functions
# ----------------------------------------------------------------------- #

def extract_from_xml(cfg, data_hash):
    dom = xml.dom.minidom.parse(cfg.schema_file)
    root = dom.getElementsByTagName(xs_prefix+"schema")
    #pp = pprint.PrettyPrinter(indent=4)
    if root:
        # temporary data structures:
        el_data = {}
        ct_data = {}
        for child in root[0].childNodes:
            if child.nodeType == child.ELEMENT_NODE \
                    and child.tagName == xs_prefix+'element':
                el_name = child.getAttribute("name")
                parsed_data = parse_element_data(child)
                if parsed_data:
                    #print "FOUND EL: [%s]" % el_name
                    el_data[el_name] = parsed_data
                    #pp.pprint(parsed_data)
            if child.nodeType == child.ELEMENT_NODE \
                    and child.tagName == xs_prefix+'complexType':
                ct_name = child.getAttribute("name")
                parsed_data = parse_complex_type(child)
                if parsed_data and parsed_data.has_key("TYPE"):
                    #print "FOUND CT: [%s]" % ct_name
                    ct_data[ct_name] = parsed_data
                    #pp.pprint(parsed_data)
        # post process phase II:
        for el_name in el_data.keys():
            if not el_data[el_name].has_key("TYPE"):
                if ct_data.has_key(el_data[el_name]["_base"]):
                    data = ct_data[el_data[el_name]["_base"]]
                    for attr in data.keys():
                        if not attr.startswith('_'):
                            el_data[el_name][attr] = data[attr]
            #print "POSTPROCESSED: [%s]" % el_name
            #pp.pprint(el_data[el_name])
        # prepare man structure of data hash
        data_hash['Machine'] = { 'elements' : {} }
        data_hash['Software'] = { 'types' : {} ,
                                  'elements' : {} }
        data_hash['Resource'] = { 'types' : {} ,
                                  'elements' : {} }
        data_hash['Application'] = { 'types' : {} ,
                                  'elements' : {} }
        for el_name in el_data.keys():
            data_hash[el_data[el_name]["TYPE"]]['elements'][el_name] = \
                el_data[el_name]
        for ct_name in ct_data.keys():
            data_hash[ct_data[ct_name]["TYPE"]]['types'][ct_name] = \
                ct_data[ct_name]
    else:
        # TODO: throw exception
        print "NO ROOT ELEMENT FOUND"
    return


def parse_element_data(node):
    parsed_data = {}
    if node.nodeType != node.ELEMENT_NODE \
            or node.tagName != xs_prefix+'element':
        return
    # search for base type
    ext_els = node.getElementsByTagName(xs_prefix+"extension")
    if ext_els == None or ext_els.length == 0:
        return
    ext_el = ext_els[0]
    base_name = strip_aae_prefix(ext_el.getAttribute("base"))
    parsed_data["_base"] = base_name
    # and dig for fixed attributes
    for child in ext_el.childNodes:
        if child.nodeType == child.ELEMENT_NODE \
                and child.tagName == xs_prefix+'attribute':
            fixed = child.getAttribute("fixed")
            if fixed == None:
                return
            parsed_data["_fixed"] = {}
            parsed_data["_fixed"]["name"] = child.getAttribute("name")
            parsed_data["_fixed"]["type"] = strip_aae_prefix(child.getAttribute("type"))
            parsed_data["_fixed"]["value"] = fixed
    # dig for documentation
    parsed_data["_doc"] = []
    for doc_el in node.getElementsByTagName(xs_prefix+"documentation"):
        lang = doc_el.getAttribute("xml:lang")
        if lang == None or lang == "" or lang == "en":
            parsed_data["_doc"].append(getXMLText(doc_el))
    # post process phase I
    if master_types.has_key(parsed_data["_base"]):
        parsed_data["TYPE"] = master_types[parsed_data["_base"]]
    parsed_data[parsed_data["_fixed"]["type"]] = parsed_data["_fixed"]["value"]
    return parsed_data

def parse_complex_type(node):
    parsed_data = {}
    if node.nodeType != node.ELEMENT_NODE \
            or node.tagName != xs_prefix+'complexType':
        return
    # search for base type
    ext_els = node.getElementsByTagName(xs_prefix+"extension")
    if ext_els == None or ext_els.length == 0:
        return
    ext_el = ext_els[0]
    base_name = strip_aae_prefix(ext_el.getAttribute("base"))
    parsed_data["_base"] = base_name
    # and dig for fixed attributes
    for child in ext_el.childNodes:
        if child.nodeType == child.ELEMENT_NODE \
                and child.tagName == xs_prefix+'attribute':
            fixed = child.getAttribute("fixed")
            if fixed == None:
                return
            parsed_data["_fixed"] = {}
            parsed_data["_fixed"]["name"] = child.getAttribute("name")
            parsed_data["_fixed"]["type"] = strip_aae_prefix(child.getAttribute("type"))
            parsed_data["_fixed"]["value"] = fixed
    # dig for documentation
    parsed_data["_doc"] = []
    for doc_el in node.getElementsByTagName(xs_prefix+"documentation"):
        lang = doc_el.getAttribute("xml:lang")
        if lang == None or lang == "" or lang == "en":
            parsed_data["_doc"].append(getXMLText(doc_el))
    # post process phase I
    if master_types.has_key(parsed_data["_base"]):
        parsed_data["TYPE"] = master_types[parsed_data["_base"]]
        parsed_data[parsed_data["_fixed"]["type"]] = parsed_data["_fixed"]["value"]
    return parsed_data

def strip_aae_prefix(inStr):
    # strip 'aae:'
    outStr= re.sub(r'^'+aae_prefix, '', inStr)
    return outStr
    
# ----------------------------------------------------------------------- #
# helper functions for XHTML output
# ----------------------------------------------------------------------- #
def printHTMLHeader():
    print "<html><body>"

def printHTMLFooter():
    print "</body></html>"

def printHTMLTable3Col(data_hash, title, classkey, subclasskey):
    print "<h2>%s</h2>" % title
    print "<table><thead><tr><td>%s</td><td>%s</td><td>Description</td></tr></thead>" % (classkey, subclasskey)
    print "<tbody>"
    # here we do the data ordering
    a_classes = {}
    a_sub_classes = {}
    for el in data_hash.keys():
        a_class = data_hash[el][classkey]
        a_sub_class = data_hash[el][subclasskey]
        a_classes[a_class] = 0 # dummy value
        if not a_sub_classes.has_key(a_class):
            a_sub_classes[a_class] = []
        a_sub_classes[a_class].append(a_sub_class)
    # sort arrays...
    for cl in sorted(a_classes.keys()):
        for sub_cl in sorted(a_sub_classes[cl]):
            # here we use the fact that 'key' in data_hash equals sub_cl
            #print "DEBUG: title=[%s] cl=[%s] scl=[%s]" % (title, cl, sub_cl)
            if data_hash.has_key(sub_cl):
                print "<tr><td>%s</td><td>%s</td><td>%s</td></tr>" % (cl, sub_cl, "<br />".join(data_hash[sub_cl]['_doc']))
            else:
                sys.stderr.write("Error in Schema for "+subclasskey+ " \""+sub_cl+"\"\n") 
                
    print "</tbody></table>"

def printHTMLTable2Col(data_hash, title, classkey):
    print "<h2>%s</h2>" % title
    print "<table><thead><tr><td>%s</td><td>Description</td></tr></thead>" % (classkey)
    print "<tbody>"
    # here we do the data ordering
    a_classes = {}
    for el in data_hash.keys():
        a_class = data_hash[el][classkey]
        a_classes[a_class] = 0 # dummy value
    # sort arrays...
    for cl in sorted(a_classes.keys()):
        # here we use the fact that 'key' in data_hash equals sub_cl
        #print "DEBUG: title=[%s] cl=[%s] scl=[%s]" % (title, cl, sub_cl)
        if data_hash.has_key(cl):
            print "<tr><td>%s</td><td>%s</td></tr>" % (cl, "<br />".join(data_hash[cl]['_doc']))
        else:
            sys.stderr.write("Error in Schema for "+classkey+ " \""+cl+"\"\n") 
                
    print "</tbody></table>"



# ----------------------------------------------------------------------- #
# helper function:
# retrieve text from a XML node
# ----------------------------------------------------------------------- #
def getXMLText(node):
    rc = []
    for child in node.childNodes:
        if child.nodeType == child.TEXT_NODE:
            rc.append(child.data)
    return ''.join(rc)




# ----------------------------------------------------------------------- #
# main
# ----------------------------------------------------------------------- #

parser = argparse.ArgumentParser(description='')
parser.add_argument("-s", "--schema", dest="schema_file", help="path to MARS schema file", required=True)
args = parser.parse_args()

# main data structure
data = {}
# will contain:

extract_from_xml(args, data)

printHTMLHeader()
printHTMLTable3Col(data['Application']['elements'], 
                   "Application Node Classifications", 
                   "ApplicationClass",
                   "ApplicationSubClass" )
printHTMLTable2Col(data['Resource']['elements'], 
                   "Resource Node Classifications", 
                   "ResourceClass" )
printHTMLTable3Col(data['Software']['elements'], 
                   "Software Node Classifications", 
                   "SoftwareClass",
                   "SoftwareSubClass" )
printHTMLTable2Col(data['Machine']['elements'], 
                   "Machine Node Classifications", 
                   "MachineClass" )
printHTMLFooter()

# DEBUGGING OUTPUT
#pp = pprint.PrettyPrinter(indent=4)
#pp.pprint(data['Application']['types'])
#pp.pprint(data['Software']['elements'])
