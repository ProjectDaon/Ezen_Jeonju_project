<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>제목 입력</title>
    <style>
        table {
            border-collapse: collapse;
            table-layout: fixed;
            width: 800px;
            font: normal 11px arial;
            border: 1px solid #aaa;
        }

        table thead th {
            background: #aaa;
            color: #fff;
            border: 1px solid #000;
            cursor: pointer;
        }

        table tbody td {
            text-indent: 5px;
            border: 1px solid #aaa;
        }

        .ghostTd {
            width: auto;
            height: auto;
            padding: 2px 8px;
            border: 1px solid #000;
            position: absolute;
            font: normal 10px arial;
            background: #eee;
        }

        .dragging {
            background: #eee;
            color: #000;
        }

        .hovering {
            background: #ccc;
            color: #555;
        }
    </style>
    <script>
        function dragTable(id) {
            this.draggedCell = null;
            this.ghostCreated = false;
            this.table = document.getElementById(id);
            this.tableRows = this.table.getElementsByTagName("tr");
            this.handler = this.table.getElementsByTagName("th").length > 0 ? this.table.getElementsByTagName("th") : this.table.tBodies[0].rows[0].getElementsByTagName("td");
            this.cells = this.table.getElementsByTagName("td");
            this.maxIndex = this.handler.length;
            this.x;
            this.y;
            this.oldIndex;
            this.newIndex;

            for (x = 0; x < this.handler.length; x++) {
                this.handler[x].dragObj = this;
                this.handler[x].onselectstart = function () { return false }
                this.handler[x].onmousedown = function (e) { this.dragObj.drag(this, e); return false }
                this.handler[x].onmouseover = function (e) { this.dragObj.dragEffect(this, e) }
                this.handler[x].onmouseout = function (e) { this.dragObj.dragEffect(this, e) }
                this.handler[x].onmouseup = function (e) { this.dragObj.dragEffect(this, e) }
            }

            for (x = 0; x < this.cells.length; x++) {
                this.cells[x].dragObj = this;
                this.cells[x].onmouseover = function (e) { this.dragObj.dragEffect(this, e) }
                this.cells[x].onmouseout = function (e) { this.dragObj.dragEffect(this, e) }
                this.cells[x].onmouseup = function (e) { this.dragObj.dragEffect(this, e) }
            }
        }

        dragTable.prototype.dragEffect = function (cell, e) {
            if (!e) e = window.event

            if (cell.cellIndex == this.oldIndex) return;
            else {
                if (this.draggedCell) {
                    e.type == "mouseover" ? this.handler[cell.cellIndex].className = "hovering" : this.handler[cell.cellIndex].className = "";
                }
            }
        }

        dragTable.prototype.drag = function (cell, e) {
            this.draggedCell = cell;
            this.draggedCell.className = "dragging";
            this.oldIndex = cell.cellIndex;
            this.createGhostTd(e);
            this.dragEngine(true);
        }

        dragTable.prototype.createGhostTd = function (e) {
            if (this.ghostCreated) return;
            if (!e) e = window.event
            this.x = e.pageX ? e.pageX : e.clientX + document.documentElement.scrollLeft
            this.y = e.pageY ? e.pageY : e.clientY + document.documentElement.scrollTop

            this.ghostTd = document.createElement("div")
            this.ghostTd.className = "ghostTd"
            this.ghostTd.style.top = this.y + 5 + "px"
            this.ghostTd.style.left = this.x + 10 + "px"
            this.ghostTd.innerHTML = this.handler[this.oldIndex].innerHTML
            document.getElementsByTagName("body")[0].appendChild(this.ghostTd)

            this.ghostCreated = true
        }

        dragTable.prototype.drop = function (dragObj, e) {
            if (!e) e = window.event
            e.targElm = e.target ? e.target : e.srcElement
            dragObj.dragEngine(false, dragObj)
            dragObj.ghostTd.parentNode.removeChild(dragObj.ghostTd)
            this.ghostCreated = false

            if (e.targElm.cellIndex !== undefined) {
                checkTable = e.targElm

                while (checkTable.tagName.toLowerCase() !== "table") {
                    if (checkTable.tagName.toLowerCase() == "html") break
                    checkTable = checkTable.parentNode
                }

                if (checkTable == this.table) {
                    this.newIndex = e.targElm.cellIndex
                }
            }

            if (this.draggedCell && this.newIndex !== undefined) {
                this.sortColumn(this.oldIndex, this.newIndex);
                this.draggedCell.className = "";
                this.draggedCell = null;
            }
        }

        dragTable.prototype.sortColumn = function (o, d) {
            if (d == null) return
            if (o == d) return

            for (x = 0; x < this.tableRows.length; x++) {
                var tr = this.tableRows[x];
                var cells = tr.cells;
                var draggedElement = tr.removeChild(cells[o]);

                if (d + 1 >= this.maxIndex) {
                    tr.appendChild(draggedElement);
                } else {
                    tr.insertBefore(draggedElement, cells[d]);
                }
            }
        }

        
        dragTable.prototype.dragEngine = function (boolean, dragObj) {
            var _this = this
            document.documentElement.onmouseup = boolean ? function (e) { _this.drop(_this, e) } : null
            document.documentElement.onmousemove = boolean ? function (e) { _this.getCoords(_this, e) } : null
        }

        dragTable.prototype.getCoords = function (dragObj, e) {
            if (!e) e = window.event
            dragObj.x = e.pageX ? e.pageX : e.clientX + document.documentElement.scrollLeft
            dragObj.y = e.pageY ? e.pageY : e.clientY + document.documentElement.scrollTop

            if (dragObj.ghostTd) {
                dragObj.ghostTd.style.top = dragObj.y + 5 + "px"
                dragObj.ghostTd.style.left = dragObj.x + 10 + "px"
            }
        }
    </script>

    <script>
        window.onload = function () {
            t1 = new dragTable('tableOne')
        }
    </script>

</head>
     
    <body>
     
    <table id="tableOne">
        <thead>
            <tr>
                <th>HEADER 1</th>
                <th>HEADER 2</th>
                <th>HEADER 3</th>
                <th>HEADER 4</th>

            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Dummy 11</td>
                <td>Dummy 21</td>
                <td>Dummy 31</td>
                <td>Dummy 41</td>

            </tr>
            <tr>
                <td>Dummy 12</td>
                <td>Dummy 22</td>
                <td>Dummy 32</td>
                <td>Dummy 42</td>


            </tr>
            <tr>
                <td>Dummy 13</td>
                <td>Dummy 23</td>
                <td>Dummy 33</td>
                <td>Dummy 43</td>
 
            </tr>
            <tr>
                <td>Dummy 14</td>
                <td>Dummy 24</td>
                <td>Dummy 34</td>
                <td>Dummy 44</td>

            </tr>
            <tr>

        </tbody>
    </table>

</body>

</html>