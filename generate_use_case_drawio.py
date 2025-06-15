import xml.etree.ElementTree as ET

# Group definitions: id -> (x, y, width, height)
groups = {
    'Use_Cases': (20, 20, 300, 260)
}

# Nodes: id -> (group_id, x, y, text)
use_cases = [
    'Browse and filter dog profiles',
    'View dogs with pagination and select favorites',
    'Add or update a dog profile (admin)',
    'Assign or remove dogs for a user',
    'Register a user with tier codes (admin/basic)',
    'Authenticate users',
    'Upload images to Supabase',
    'Submit contact requests',
    'Retrieve dog data and manage user-dog assignments'
]

nodes = {}
y = 20
for i, uc in enumerate(use_cases):
    nodes[f'UC{i+1}'] = ('Use_Cases', 20, y, uc)
    y += 30


def create_diagram():
    root = ET.Element('mxfile', host='app.diagrams.net')
    diagram = ET.SubElement(root, 'diagram', name='Use Cases')
    model = ET.SubElement(diagram, 'mxGraphModel', dx='1280', dy='720', grid='1',
                           gridSize='10', guides='1', tooltips='1', connect='1',
                           arrows='1', fold='1', page='1', pageScale='1',
                           pageWidth='850', pageHeight='1100', math='0', shadow='0')
    rt = ET.SubElement(model, 'root')
    ET.SubElement(rt, 'mxCell', id='0')
    ET.SubElement(rt, 'mxCell', id='1', parent='0')

    # Add groups
    for gid, (x, y, w, h) in groups.items():
        cell = ET.SubElement(rt, 'mxCell', id=gid, value=gid.replace('_', ' '),
                              style='swimlane;html=1;', parent='1', vertex='1')
        geom = ET.SubElement(cell, 'mxGeometry', x=str(x), y=str(y),
                              width=str(w), height=str(h))
        geom.set('as', 'geometry')

    # Add nodes
    for nid, (gid, x, y, text) in nodes.items():
        cell = ET.SubElement(rt, 'mxCell', id=nid, value=text,
                              style='rounded=0;whiteSpace=wrap;html=1;',
                              parent=gid, vertex='1')
        geom = ET.SubElement(cell, 'mxGeometry', x=str(x), y=str(y),
                              width='260', height='30')
        geom.set('as', 'geometry')

    ET.indent(root, space="  ")
    return ET.tostring(root, encoding='utf-8')

if __name__ == '__main__':
    xml = create_diagram()
    with open('docs/use_cases.drawio', 'wb') as f:
        f.write(xml)
