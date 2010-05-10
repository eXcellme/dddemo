/**
 * Tree组件
 * 
 * @author tony.tan
 * @date 2010-04-12
 * @version 1.0-SNAPSHOT
 */
(function() {
	$.uiwidget = $.uiwidget || {};
	$.uiwidget.Tree = function(a, b) {
		$.extend(this, b);
		this.el = $(a);
		this.init();
		if (this.autoRender) {
			this.render();
		}
	};
	$.uiwidget.Tree.prototype = {
		autoExpandRoot : true,
		autoRender : true,
		showIcons : true,
		loadParas : {},
		cache : false,
		init : function() {
			var c = this;
			$.each( [ 'beforeLoad', 'afterLoad' ], function(a, b) {
				if (c[b])
					c.bind(b, c[b])
			})
		},
		expandAll : function() {
			this.getContainerNode().expand(true)
		},
		collapseAll : function() {
			for ( var a = 0; a < this.getContainerNode().childNodes.length; a++) {
				this.getContainerNode().childNodes[a].collapse(true)
			}
		},
		expandRoot : function() {
			for ( var a = 0; a < this.getContainerNode().childNodes.length; a++) {
				this.getContainerNode().childNodes[a].expand()
			}
		},
		setLoadParas : function(a) {
			for ( var b in a) {
				if (a[b]) {
					this.loadParas[b] = a[b]
				}
			}
		},
		loadData : function(b) {
			this.loadParas = {};
			if (b) {
				if (b.data.id)
					this.setLoadParas({
						id : b.data.id
					});
				this.triggerHandler('beforeLoad', [ b, this ])
			}
			var c = this;
			$.ajax({
						async : false,
						cache : this.cache,
						dataType : 'json',
						type : 'POST',
						url : this.url,
						data : this.loadParas,
						timeout : this.timeout || 60000,
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						success : function(a) {
							c.data = a || {}
						}
					});
			if (b)
				this.triggerHandler('afterLoad', [ b, this ])
		},
		render : function() {
			this.wraper = $( [ '<div class="tree" ',this.height ? 'style="height:' + this.height + 'px" ' : '','></div>' ].join(''));
			this.el.append(this.wraper);
			this.containerNode = new $.uiwidget.TreeNode( {
				el : this.wraper,
				indent : [],
				tree : this,
				isContainer : true,
				data : {
					children : this.data
				}
			});
			if (!this.data && this.url)
				this.loadData(this.containerNode);
			this.containerNode.renderNode(this.data);
			if (this.autoExpandRoot)
				this.expandRoot();
			this.containerNode.expand();
			this.addTreeNodeEvent()
		},
		addTreeNodeEvent : function() {
			var d = this;
			this.el.dblclick(function(a) {
				var b = $(a.target);
				if (b.is('.tree-node-text') || b.is('.tree-node-icon')) {
					var c = b.parent().getTreeNode();
					c.toggle();
					d.triggerHandler('nodeDblclick', [ c ])
				}
			}).click(function(a) {
				var b = $(a.target);
				if (b.is('.tree-node-text') || b.is('.tree-node-icon')) {
					var c = b.parent().getTreeNode();
					c.select(true);
					d.triggerHandler('nodeClick', [ c ])
				} else if (b.is('.tree-expand-icon')) {
					var c = b.parent().getTreeNode();
					c.toggle()
				} else if (b.is('.tree-node-checkbox')) {
					var c = b.parent().getTreeNode();
					c.data.checked = b[0].checked;
					d.triggerHandler('checkchange', [ c, b[0].checked ])
				}
			}).bind('contextmenu', function(a) {
				var b = $(a.target);
				if (b.is('.tree-node-text') || b.is('.tree-node-icon')) {
					a.preventDefault();
					var c = b.parent().getTreeNode();
					d.triggerHandler('treeContextMenu', [ d, c ], a);
					d.handlerContextMenu(c, a)
				}
			})
		},
		getCheckedNode : function() {
			return $(':checkbox:checked', this.container).map(function() {
				return $(this).parent().getTreeNode()
			})
		},
		getSelectedNode : function() {
			return $('span.tree-node-selected', this.container).parent()
					.getTreeNode()
		},
		getRootNode : function() {
			return this.containerNode.childNodes
		},
		getContainerNode : function() {
			return this.containerNode
		},
		reload : function(a) {
			this.getContainerNode().reload(a)
		},
		getContextMenu : function() {
			if (!this.cMenu) {
				if ($.menu) {
					this.cMenu = $.menu( {
						items : this.contextMenu
					})
				}
			}
			return this.cMenu
		},
		addContextMenuItem : function(a) {
			return this.getContextMenu().addMenuItem(a)
		},
		handlerContextMenu : function(a, b) {
			b.preventDefault();
			var c = this.getContextMenu();
			if (c.size() > 1) {
				a.select(false);
				c.showAt(b.pageX, b.pageY)
			}
		},
		getData : function() {
			return this.data
		},
		bind : function(a, b, c) {
			a = a.toLowerCase();
			if (typeof b == 'object')
				return this.el.bind(a, b, c);
			else
				return this.el.bind(a, b)
		},
		trigger : function(a, b) {
			return this.el.trigger(a, b)
		},
		triggerHandler : function(a, b, c) {
			a = a.toLowerCase();
			if (c) {
				if (this.el[0]) {
					var d = c;
					d.type = a;
					d.triggerTarget = d.target;
					d.stopPropagation();
					$.event.trigger(d, b, this.el[0], false);
					return d.result
				}
			} else {
				return this.el.triggerHandler(a, b)
			}
		}
	};
	$.uiwidget.TreeNode = function(a) {
		$.extend(this, a);
		this.init()
	};
	$.uiwidget.TreeNode.prototype = {
		isRendered : false,
		firstChild : null,
		lastChild : null,
		previousSibling : null,
		nextSibling : null,
		expandIcon : null,
		ct : null,
		indent : null,
		init : function() {
			this.showIcons = this.showIcons || this.tree.showIcons;
			this.hrefTarget = this.hrefTarget
					|| (this.data && this.data.hrefTarget)
					|| this.tree.hrefTarget;
			this.childNodes = [];
			this.leaf = this.data && this.data.leaf;
			this.expanded = false;
			this.ajaxLoadPage = this.tree.ajaxLoadPage
		},
		render : function() {
			var a = this.data;
			var b = [
					'<div class="tree-node" title="',
					a.title,
					'"><span class="tree-indent"></span><button class="tree-expand-icon" type="button"/>' ];
			if (a.children || !this.isLeaf()) {
				if (this.showIcons)
					b.push('<button  class="tree-node-icon tree-node-folder ',
							this.isContainer ? ' tree-node-root' : '',
							'" type="button"></button>')
			} else {
				if (this.showIcons)
					b.push('<button class="tree-node-icon tree-node-leaf" type="button"></button>')
			}
			if (a.checked == 'false' || a.checked == false)
				b.push('<input class="tree-node-checkbox" type="checkbox"></input>');
			else if (a.checked == 'true' || a.checked == true)
				b.push('<input class="tree-node-checkbox" type="checkbox" checked="true"></input>');
			b.push('<span class="tree-node-text" href="', a.href, '" target="',this.hrefTarget, '" hidefocus="on">', a.text,'</span></div>');
			this.el = $(b.join(''));
			this.el.data('treeNode', this);
			this.expandIcon = this.el.children(':button.tree-expand-icon');
			this.indent = this.el.children('.tree-indent');
			this.folder = this.el.children(':button.tree-node-folder');
			this.isRendered = true;
			if (this.data.disabled) {
				this.disable()
			}
			this.renderIndent()
		},
		renderIndent : function(a) {
			var b = [];
			var c = this.parentNode;
			while (c) {
				if (!c.isContainer) {
					if (c.isLast()) {
						b.unshift('<button class="tree-blank" type="button"/>')
					} else {
						b.unshift('<button class="tree-blank tree-line" type="button"/>')
					}
				}
				c = c.parentNode
			}
			this.indent.html(b.join(''));
			this.updateExpandIcon();
			var d = this.childNodes;
			if (a === true && this.ct != null) {
				for ( var e = 0, f = d.length; e < f; e++) {
					d[e].renderIndent(a)
				}
			}
		},
		updateExpandIcon : function() {
			if (this.isRendered) {
				var a = [ 'tree-expand-icon' ];
				var b = [];
				if (this.isLast()) {
					b.push('tree-elbow-end')
				} else {
					b.push('tree-elbow')
				}
				if (!this.isLeaf()) {
					if (this.expanded)
						b.push('-minus');
					else
						b.push('-plus')
				}
				a.push(b.join(''));
				this.expandIcon[0].className = a.join(' ')
			}
		},
		renderNode : function(a) {
			if (a) {
				for ( var b = 0, c = a.length; b < c; b++) {
					var d = new $.uiwidget.TreeNode( {
						data : a[b],
						tree : this.tree
					});
					if (b == 0) {
						this.setFirstChild(d)
					}
					if (b == (c - 1)) {
						this.setLastChild(d)
					}
					this.fastAppendChild(d)
				}
			}
		},
		fastAppendChild : function(a) {
			this.leaf = false;
			var b = this.childNodes.length;
			a.parentNode = this;
			var c = this.childNodes[b - 1];
			if (c) {
				a.previousSibling = c;
				c.nextSibling = a
			} else {
				a.previousSibling = null
			}
			a.nextSibling = null;
			if (!a.isRendered) {
				a.render()
			}
			if (!this.ct || this.ct.length == 0) {
				this.ct = $('<div class="tree-node-ct"></div>');
				if (this.isContainer)
					this.el.append(this.ct);
				else
					this.el.after(this.ct)
			}
			this.ct.append(a.el);
			this.childNodes.push(a);
			return a
		},
		appendChild : function(a) {
			if (!a.render) {
				this.appendChild(new $.uiwidget.TreeNode( {
					data : a,
					tree : this.tree
				}));
				return
			}
			this.leaf = false;
			var b = this.childNodes.length;
			if (b == 0) {
				this.setFirstChild(a)
			}
			a.parentNode = this;
			var c = this.childNodes[b - 1];
			if (c) {
				a.previousSibling = c;
				c.nextSibling = a
			} else {
				a.previousSibling = null
			}
			a.nextSibling = null;
			this.setLastChild(a);
			if (!a.isRendered) {
				a.render()
			}
			if (this.isContainer) {
				this.el.append(a.el)
			} else {
				if (!this.ct || this.ct.length == 0) {
					this.ct = $('<div class="tree-node-ct"></div>');
					this.el.after(this.ct)
				}
				this.ct.append(a.el)
			}
			this.childNodes.push(a);
			return a
		},
		setFirstChild : function(a) {
			var b = this.firstChild;
			this.firstChild = a;
			if (b && b.isRendered && a != b) {
				b.renderIndent(true)
			}
			if (this.isRendered) {
				this.renderIndent(true)
			}
		},
		setLastChild : function(a) {
			var b = this.lastChild;
			this.lastChild = a;
			if (b && b.isRendered && a != b) {
				b.renderIndent(true)
			}
			if (this.isRendered) {
				this.renderIndent(true)
			}
		},
		removeChild : function(a) {
			var b = $.inArray(a, this.childNodes);
			if (b == -1) {
				return false
			}
			this.childNodes.splice(b, 1);
			if (a.previousSibling) {
				a.previousSibling.nextSibling = a.nextSibling
			}
			if (a.nextSibling) {
				a.nextSibling.previousSibling = a.previousSibling
			}
			if (this.firstChild == a) {
				this.setFirstChild(a.nextSibling)
			}
			if (this.lastChild == a) {
				this.setLastChild(a.previousSibling)
			}
			a.parentNode = null;
			a.previousSibling = null;
			a.nextSibling = null;
			if (a.ct)
				a.ct.remove();
			a.el.remove();
			if (this.childNodes.length < 1) {
				this.collapse();
				this.leaf = true
			}
			this.updateExpandIcon();
			return a
		},
		isLast : function() {
			return (!this.parentNode ? true : this.parentNode.lastChild == this)
		},
		isLeaf : function() {
			return this.leaf
		},
		setText : function(a) {
			this.data.text = a;
			this.el.children('span.tree-node-text').text(a)
		},
		getText : function() {
			return this.el.children('span.tree-node-text').text()
		},
		select : function(a) {
			if (this.data.disabled)
				return;
			this.tree.el.find('span.tree-node-selected').removeClass(
					'tree-node-selected');
			var b = this.el.find('span.tree-node-text').addClass(
					'tree-node-selected').attr('href');
			if (a && b && b.length > 0) {
				if (this.ajaxLoadPage) {
					if ($.fn.page)
						$(this.hrefTarget).page(b);
					else
						alert("can't not found $(..).page")
				} else {
					if (typeof this.hrefTarget == 'string') {
						window.frames[this.hrefTarget].location = b
					} else {
						this.hrefTarget.location = b
					}
				}
			}
		},
		unselect : function() {
			this.el.find('span.tree-node-selected').removeClass(
					'tree-node-selected')
		},
		isSelected : function() {
			return this.el.find('span.tree-node-selected').length > 0
		},
		toggle : function() {
			if (this.expanded) {
				this.collapse()
			} else {
				this.expand()
			}
		},
		renderChildren : function() {
			var a;
			if (!this.isLeaf()) {
				if (this.data.children) {
					a = this.data.children
				} else if (this.tree.url) {
					this.tree.loadData(this);
					a = this.tree.data
				}
				if (!a)
					return;
				this.renderNode(a)
			}
			return this.ct
		},
		expand : function(a) {
			var b = this.el;
			if (!this.ct || this.ct.length == 0) {
				this.ct = this.renderChildren()
			}
			if (this.ct && this.ct.length > 0) {
				this.ct.show()
			}
			this.expanded = true;
			this.updateExpandIcon();
			if (this.showIcons && this.folder)
				this.folder.addClass('tree-node-folderopen');
			if (a) {
				for ( var c = 0; c < this.childNodes.length; c++) {
					this.childNodes[c].expand(a)
				}
			}
		},
		collapse : function(a) {
			var b = this.el;
			if (this.ct && this.ct.length > 0) {
				this.ct.hide()
			}
			this.expanded = false;
			this.updateExpandIcon();
			if (this.showIcons && this.folder)
				this.folder.removeClass('tree-node-folderopen');
			if (a) {
				for ( var c = 0; c < this.childNodes.length; c++) {
					this.childNodes[c].collapse(a)
				}
			}
		},
		reload : function(a) {
			if (this.ct) {
				this.ct.remove();
				delete this.ct;
				this.expanded = false;
				this.childNodes = []
			}
			this.expand();
			if (a)
				a(this)
		},
		remove : function() {
			this.parentNode.removeChild(this)
		},
		enable : function() {
			this.data.disabled = false;
			this.el.removeClass('tree-node-disabled');
			this.el.find('.tree-node-checkbox').attr('disabled', false)
		},
		disable : function() {
			this.unselect();
			this.data.disabled = true;
			this.el.addClass('tree-node-disabled');
			this.el.find('.tree-node-checkbox').attr('disabled', true)
		},
		getData : function() {
			return this.data
		},
		checkChange : function(a, b) {
			this.el.find('.tree-node-checkbox').attr('checked', a);
			this.data.checked = a;
			if (b === true)
				this.tree.triggerHandler('checkchange', [ this, a ])
		},
		cascade : function(a) {
			if (a(this) === false)
				return;
			var b = this.childNodes;
			for ( var c = 0, d = b.length; c < d; c++) {
				b[c].cascade(a)
			}
		},
		eachChild : function(a) {
			var b = this.childNodes;
			for ( var c = 0, d = b.length; c < d; c++) {
				if (a(b[c]) === false)
					break
			}
		},
		bind : function(a, b, c) {
			if (typeof b == 'object')
				return this.el.bind(a, b, c);
			else
				return this.el.bind(a, b)
		},
		trigger : function(a, b) {
			return this.el.trigger(a, b)
		},
		triggerHandler : function(a, b) {
			return this.el.triggerHandler(a, b)
		}
	};
	$.fn.ajaxTree = function(a) {
		return new $.uiwidget.Tree(this, a)
	};
	$.fn.getTreeNode = function() {
		return $(this).data('treeNode')
	}
})(jQuery);