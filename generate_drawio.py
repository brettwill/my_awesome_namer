import xml.etree.ElementTree as ET

# Group definitions: id -> (x, y, width, height)
groups = {
    'Flutter_App': (20, 20, 280, 200),
    'UI_Screens': (320, 20, 400, 400),
    'Business_Layer': (20, 240, 280, 180),
    'Data_Layer': (320, 440, 400, 220),
    'Models': (740, 20, 220, 140)
}

# Nodes: id -> (group_id, x, y)
nodes = {
    'Main': ('Flutter_App', 20, 20),
    'DogHumanMatchApp': ('Flutter_App', 20, 60),
    'Router': ('Flutter_App', 20, 100),

    'LoginScreen': ('UI_Screens', 20, 20),
    'HundeSuchePage': ('UI_Screens', 20, 60),
    'DogListScreen': ('UI_Screens', 40, 100),
    'DogForm': ('UI_Screens', 60, 140),
    'HomePage': ('UI_Screens', 20, 180),
    'FavoritesPage': ('UI_Screens', 40, 220),
    'DogNutritionPage': ('UI_Screens', 40, 260),
    'DogSchoolPage': ('UI_Screens', 40, 300),
    'Catalog': ('UI_Screens', 20, 340),
    'CartScreen': ('UI_Screens', 40, 380),
    'ContactPage': ('UI_Screens', 220, 20),
    'UploadImageScreen': ('UI_Screens', 220, 60),

    'DogProvider': ('Business_Layer', 20, 20),
    'ContactController': ('Business_Layer', 20, 60),
    'LoginController': ('Business_Layer', 160, 20),

    'DogService': ('Data_Layer', 20, 20),
    'ContactRepository': ('Data_Layer', 20, 60),
    'SupabaseTables': ('Data_Layer', 220, 20),
    'SupabaseContacts': ('Data_Layer', 220, 60),
    'SupabaseStorage': ('Data_Layer', 220, 100),
    'ImageUploader': ('Data_Layer', 20, 100),
    'SupabaseClient': ('Data_Layer', 220, 140),

    'DogProfile': ('Models', 20, 20),
    'Dog': ('Models', 20, 60),
    'CartModel': ('Models', 20, 100),
    'CatalogModel': ('Models', 120, 100)
}

# Edges: (source, target)
edges = [
    ('Main', 'SupabaseClient'),
    ('Main', 'DogProvider'),
    ('Main', 'DogHumanMatchApp'),
    ('DogHumanMatchApp', 'Router'),
    ('Router', 'LoginScreen'),
    ('Router', 'HundeSuchePage'),
    ('Router', 'HomePage'),
    ('Router', 'Catalog'),
    ('LoginScreen', 'LoginController'),
    ('HundeSuchePage', 'DogListScreen'),
    ('DogListScreen', 'DogService'),
    ('DogListScreen', 'DogForm'),
    ('DogForm', 'DogProvider'),
    ('HomePage', 'FavoritesPage'),
    ('HomePage', 'DogNutritionPage'),
    ('HomePage', 'DogSchoolPage'),
    ('Catalog', 'CartScreen'),
    ('ContactPage', 'ContactController'),
    ('UploadImageScreen', 'ImageUploader'),
    ('DogProvider', 'DogService'),
    ('ContactController', 'ContactRepository'),
    ('LoginController', 'DogService'),
    ('DogService', 'SupabaseTables'),
    ('ContactRepository', 'SupabaseContacts'),
    ('ImageUploader', 'SupabaseStorage'),
    ('DogService', 'DogProfile'),
    ('DogService', 'Dog'),
    ('CartScreen', 'CartModel'),
    ('CartModel', 'CatalogModel')
]

def create_diagram():
    root = ET.Element('mxfile', host='app.diagrams.net')
    diagram = ET.SubElement(root, 'diagram', name='Complex Stack')
    model = ET.SubElement(diagram, 'mxGraphModel', dx='1280', dy='720', grid='1', gridSize='10', guides='1', tooltips='1', connect='1', arrows='1', fold='1', page='1', pageScale='1', pageWidth='850', pageHeight='1100', math='0', shadow='0')
    rt = ET.SubElement(model, 'root')
    ET.SubElement(rt, 'mxCell', id='0')
    ET.SubElement(rt, 'mxCell', id='1', parent='0')

    # Add groups
    for gid, (x, y, w, h) in groups.items():
        cell = ET.SubElement(rt, 'mxCell', id=gid, value=gid.replace('_', ' '), style='swimlane;html=1;', parent='1', vertex='1')
        geom = ET.SubElement(cell, 'mxGeometry', x=str(x), y=str(y), width=str(w), height=str(h))
        geom.set('as', 'geometry')

    # Add nodes
    for nid, (gid, x, y) in nodes.items():
        cell = ET.SubElement(rt, 'mxCell', id=nid, value=nid, style='rounded=0;whiteSpace=wrap;html=1;', parent=gid, vertex='1')
        geom = ET.SubElement(cell, 'mxGeometry', x=str(x), y=str(y), width='120', height='30')
        geom.set('as', 'geometry')

    # Add edges
    for i, (src, tgt) in enumerate(edges, start=1):
        cell = ET.SubElement(rt, 'mxCell', id='e%d' % i, edge='1', parent='1', source=src, target=tgt, style='orthogonalEdgeStyle;rounded=0;jettySize=auto;html=1;')
        geom = ET.SubElement(cell, 'mxGeometry', relative='1')
        geom.set('as', 'geometry')

    ET.indent(root, space="  ")
    return ET.tostring(root, encoding='utf-8')

if __name__ == '__main__':
    xml = create_diagram()
    with open('docs/complex_stack.drawio', 'wb') as f:
        f.write(xml)
