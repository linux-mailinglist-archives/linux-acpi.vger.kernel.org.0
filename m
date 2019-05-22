Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B2826271
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2019 12:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfEVKvY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 May 2019 06:51:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:32515 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbfEVKvW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 May 2019 06:51:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 03:51:22 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2019 03:51:20 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 03/16] software node: Add support for static node descriptors
Date:   Wed, 22 May 2019 13:51:00 +0300
Message-Id: <20190522105113.11153-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
References: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Until now the software nodes could only be created
dynamically with fwnode_create_software_node() function.
This introduces struct software_node data structure, which
makes it possible to describe the software nodes also
statically.

The statically described software nodes can be registered
with a new function fwnode_register_software_node(). This
also adds a helper fwnode_register_software_nodes()
which makes it possible to register an array of struct
software_nodes, i.e. multiple nodes at the same time.

There is no difference between statically described and
dynamically allocated software nodes. Even the registration
does not differ, except that during node creation the device
properties are only copied if the node is created
dynamically. With statically described nodes, the property
entries in the descriptor (struct software_node) are
assigned directly to the new software node that is being
created without any copies.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c    | 256 +++++++++++++++++++++++++++++----------
 include/linux/property.h |  19 +++
 2 files changed, 212 insertions(+), 63 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 7b321bf8424c..ef1a48fec718 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -11,25 +11,25 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 
-struct software_node {
+struct swnode {
 	int id;
 	struct kobject kobj;
 	struct fwnode_handle fwnode;
+	const struct software_node *node;
 
 	/* hierarchy */
 	struct ida child_ids;
 	struct list_head entry;
 	struct list_head children;
-	struct software_node *parent;
+	struct swnode *parent;
 
-	/* properties */
-	const struct property_entry *properties;
+	unsigned int allocated:1;
 };
 
 static DEFINE_IDA(swnode_root_ids);
 static struct kset *swnode_kset;
 
-#define kobj_to_swnode(_kobj_) container_of(_kobj_, struct software_node, kobj)
+#define kobj_to_swnode(_kobj_) container_of(_kobj_, struct swnode, kobj)
 
 static const struct fwnode_operations software_node_ops;
 
@@ -37,17 +37,56 @@ bool is_software_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &software_node_ops;
 }
+EXPORT_SYMBOL_GPL(is_software_node);
 
-#define to_software_node(__fwnode)					\
+#define to_swnode(__fwnode)						\
 	({								\
-		typeof(__fwnode) __to_software_node_fwnode = __fwnode;	\
+		typeof(__fwnode) __to_swnode_fwnode = __fwnode;		\
 									\
-		is_software_node(__to_software_node_fwnode) ?		\
-			container_of(__to_software_node_fwnode,		\
-				     struct software_node, fwnode) :	\
-			NULL;						\
+		is_software_node(__to_swnode_fwnode) ?			\
+			container_of(__to_swnode_fwnode,		\
+				     struct swnode, fwnode) : NULL;	\
 	})
 
+static struct swnode *
+software_node_to_swnode(const struct software_node *node)
+{
+	struct swnode *swnode;
+	struct kobject *k;
+
+	if (!node)
+		return NULL;
+
+	spin_lock(&swnode_kset->list_lock);
+
+	list_for_each_entry(k, &swnode_kset->list, entry) {
+		swnode = kobj_to_swnode(k);
+		if (swnode->node == node)
+			break;
+		swnode = NULL;
+	}
+
+	spin_unlock(&swnode_kset->list_lock);
+
+	return swnode;
+}
+
+const struct software_node *to_software_node(struct fwnode_handle *fwnode)
+{
+	struct swnode *swnode = to_swnode(fwnode);
+
+	return swnode ? swnode->node : NULL;
+}
+EXPORT_SYMBOL_GPL(to_software_node);
+
+struct fwnode_handle *software_node_fwnode(const struct software_node *node)
+{
+	struct swnode *swnode = software_node_to_swnode(node);
+
+	return swnode ? &swnode->fwnode : NULL;
+}
+EXPORT_SYMBOL_GPL(software_node_fwnode);
+
 /* -------------------------------------------------------------------------- */
 /* property_entry processing */
 
@@ -433,7 +472,7 @@ EXPORT_SYMBOL_GPL(property_entries_free);
 
 static struct fwnode_handle *software_node_get(struct fwnode_handle *fwnode)
 {
-	struct software_node *swnode = to_software_node(fwnode);
+	struct swnode *swnode = to_swnode(fwnode);
 
 	kobject_get(&swnode->kobj);
 
@@ -442,7 +481,7 @@ static struct fwnode_handle *software_node_get(struct fwnode_handle *fwnode)
 
 static void software_node_put(struct fwnode_handle *fwnode)
 {
-	struct software_node *swnode = to_software_node(fwnode);
+	struct swnode *swnode = to_swnode(fwnode);
 
 	kobject_put(&swnode->kobj);
 }
@@ -450,8 +489,9 @@ static void software_node_put(struct fwnode_handle *fwnode)
 static bool software_node_property_present(const struct fwnode_handle *fwnode,
 					   const char *propname)
 {
-	return !!property_entry_get(to_software_node(fwnode)->properties,
-				    propname);
+	struct swnode *swnode = to_swnode(fwnode);
+
+	return !!property_entry_get(swnode->node->properties, propname);
 }
 
 static int software_node_read_int_array(const struct fwnode_handle *fwnode,
@@ -459,9 +499,9 @@ static int software_node_read_int_array(const struct fwnode_handle *fwnode,
 					unsigned int elem_size, void *val,
 					size_t nval)
 {
-	struct software_node *swnode = to_software_node(fwnode);
+	struct swnode *swnode = to_swnode(fwnode);
 
-	return property_entry_read_int_array(swnode->properties, propname,
+	return property_entry_read_int_array(swnode->node->properties, propname,
 					     elem_size, val, nval);
 }
 
@@ -469,27 +509,26 @@ static int software_node_read_string_array(const struct fwnode_handle *fwnode,
 					   const char *propname,
 					   const char **val, size_t nval)
 {
-	struct software_node *swnode = to_software_node(fwnode);
+	struct swnode *swnode = to_swnode(fwnode);
 
-	return property_entry_read_string_array(swnode->properties, propname,
-						val, nval);
+	return property_entry_read_string_array(swnode->node->properties,
+						propname, val, nval);
 }
 
 static struct fwnode_handle *
 software_node_get_parent(const struct fwnode_handle *fwnode)
 {
-	struct software_node *swnode = to_software_node(fwnode);
+	struct swnode *swnode = to_swnode(fwnode);
 
-	return swnode ? (swnode->parent ? &swnode->parent->fwnode : NULL) :
-			NULL;
+	return swnode ? (swnode->parent ? &swnode->parent->fwnode : NULL) : NULL;
 }
 
 static struct fwnode_handle *
 software_node_get_next_child(const struct fwnode_handle *fwnode,
 			     struct fwnode_handle *child)
 {
-	struct software_node *p = to_software_node(fwnode);
-	struct software_node *c = to_software_node(child);
+	struct swnode *p = to_swnode(fwnode);
+	struct swnode *c = to_swnode(child);
 
 	if (!p || list_empty(&p->children) ||
 	    (c && list_is_last(&c->entry, &p->children)))
@@ -498,7 +537,7 @@ software_node_get_next_child(const struct fwnode_handle *fwnode,
 	if (c)
 		c = list_next_entry(c, entry);
 	else
-		c = list_first_entry(&p->children, struct software_node, entry);
+		c = list_first_entry(&p->children, struct swnode, entry);
 	return &c->fwnode;
 }
 
@@ -506,15 +545,15 @@ static struct fwnode_handle *
 software_node_get_named_child_node(const struct fwnode_handle *fwnode,
 				   const char *childname)
 {
-	struct software_node *swnode = to_software_node(fwnode);
+	struct swnode *swnode = to_swnode(fwnode);
 	const struct property_entry *prop;
-	struct software_node *child;
+	struct swnode *child;
 
 	if (!swnode || list_empty(&swnode->children))
 		return NULL;
 
 	list_for_each_entry(child, &swnode->children, entry) {
-		prop = property_entry_get(child->properties, "name");
+		prop = property_entry_get(child->node->properties, "name");
 		if (!prop)
 			continue;
 		if (!strcmp(childname, prop->value.str)) {
@@ -539,7 +578,7 @@ static const struct fwnode_operations software_node_ops = {
 /* -------------------------------------------------------------------------- */
 
 static int
-software_node_register_properties(struct software_node *swnode,
+software_node_register_properties(struct software_node *node,
 				  const struct property_entry *properties)
 {
 	struct property_entry *props;
@@ -548,17 +587,20 @@ software_node_register_properties(struct software_node *swnode,
 	if (IS_ERR(props))
 		return PTR_ERR(props);
 
-	swnode->properties = props;
+	node->properties = props;
 
 	return 0;
 }
 
 static void software_node_release(struct kobject *kobj)
 {
-	struct software_node *swnode = kobj_to_swnode(kobj);
+	struct swnode *swnode = kobj_to_swnode(kobj);
 
+	if (swnode->allocated) {
+		property_entries_free(swnode->node->properties);
+		kfree(swnode->node);
+	}
 	ida_destroy(&swnode->child_ids);
-	property_entries_free(swnode->properties);
 	kfree(swnode);
 }
 
@@ -567,66 +609,154 @@ static struct kobj_type software_node_type = {
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
-struct fwnode_handle *
-fwnode_create_software_node(const struct property_entry *properties,
-			    const struct fwnode_handle *parent)
+static struct fwnode_handle *
+swnode_register(const struct software_node *node, struct swnode *parent,
+		unsigned int allocated)
 {
-	struct software_node *p = NULL;
-	struct software_node *swnode;
+	struct swnode *swnode;
 	int ret;
 
-	if (parent) {
-		if (IS_ERR(parent))
-			return ERR_CAST(parent);
-		if (!is_software_node(parent))
-			return ERR_PTR(-EINVAL);
-		p = to_software_node(parent);
-	}
-
 	swnode = kzalloc(sizeof(*swnode), GFP_KERNEL);
-	if (!swnode)
-		return ERR_PTR(-ENOMEM);
+	if (!swnode) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
 
-	ret = ida_simple_get(p ? &p->child_ids : &swnode_root_ids, 0, 0,
-			     GFP_KERNEL);
+	ret = ida_simple_get(parent ? &parent->child_ids : &swnode_root_ids,
+			     0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		kfree(swnode);
-		return ERR_PTR(ret);
+		goto out_err;
 	}
 
 	swnode->id = ret;
+	swnode->node = node;
+	swnode->parent = parent;
+	swnode->allocated = allocated;
 	swnode->kobj.kset = swnode_kset;
 	swnode->fwnode.ops = &software_node_ops;
 
 	ida_init(&swnode->child_ids);
 	INIT_LIST_HEAD(&swnode->entry);
 	INIT_LIST_HEAD(&swnode->children);
-	swnode->parent = p;
 
-	ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
-				   p ? &p->kobj : NULL, "node%d", swnode->id);
+	if (node->name)
+		ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
+					   parent ? &parent->kobj : NULL,
+					   "%s", node->name);
+	else
+		ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
+					   parent ? &parent->kobj : NULL,
+					   "node%d", swnode->id);
 	if (ret) {
 		kobject_put(&swnode->kobj);
 		return ERR_PTR(ret);
 	}
 
-	ret = software_node_register_properties(swnode, properties);
+	if (parent)
+		list_add_tail(&swnode->entry, &parent->children);
+
+	kobject_uevent(&swnode->kobj, KOBJ_ADD);
+	return &swnode->fwnode;
+
+out_err:
+	if (allocated)
+		property_entries_free(node->properties);
+	return ERR_PTR(ret);
+}
+
+/**
+ * software_node_register_nodes - Register an array of software nodes
+ * @nodes: Zero terminated array of software nodes to be registered
+ *
+ * Register multiple software nodes at once.
+ */
+int software_node_register_nodes(const struct software_node *nodes)
+{
+	int ret;
+	int i;
+
+	for (i = 0; nodes[i].name; i++) {
+		ret = software_node_register(&nodes[i]);
+		if (ret) {
+			software_node_unregister_nodes(nodes);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(software_node_register_nodes);
+
+/**
+ * software_node_unregister_nodes - Unregister an array of software nodes
+ * @nodes: Zero terminated array of software nodes to be unregistered
+ *
+ * Unregister multiple software nodes at once.
+ */
+void software_node_unregister_nodes(const struct software_node *nodes)
+{
+	struct swnode *swnode;
+	int i;
+
+	for (i = 0; nodes[i].name; i++) {
+		swnode = software_node_to_swnode(&nodes[i]);
+		if (swnode)
+			fwnode_remove_software_node(&swnode->fwnode);
+	}
+}
+EXPORT_SYMBOL_GPL(software_node_unregister_nodes);
+
+/**
+ * software_node_register - Register static software node
+ * @node: The software node to be registered
+ */
+int software_node_register(const struct software_node *node)
+{
+	struct swnode *parent = software_node_to_swnode(node->parent);
+
+	if (software_node_to_swnode(node))
+		return -EEXIST;
+
+	return PTR_ERR_OR_ZERO(swnode_register(node, parent, 0));
+}
+EXPORT_SYMBOL_GPL(software_node_register);
+
+struct fwnode_handle *
+fwnode_create_software_node(const struct property_entry *properties,
+			    const struct fwnode_handle *parent)
+{
+	struct software_node *node;
+	struct swnode *p = NULL;
+	int ret;
+
+	if (parent) {
+		if (IS_ERR(parent))
+			return ERR_CAST(parent);
+		if (!is_software_node(parent))
+			return ERR_PTR(-EINVAL);
+		p = to_swnode(parent);
+	}
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return ERR_PTR(-ENOMEM);
+
+	ret = software_node_register_properties(node, properties);
 	if (ret) {
-		kobject_put(&swnode->kobj);
+		kfree(node);
 		return ERR_PTR(ret);
 	}
 
-	if (p)
-		list_add_tail(&swnode->entry, &p->children);
+	node->parent = p ? p->node : NULL;
 
-	kobject_uevent(&swnode->kobj, KOBJ_ADD);
-	return &swnode->fwnode;
+	return swnode_register(node, p, 1);
 }
 EXPORT_SYMBOL_GPL(fwnode_create_software_node);
 
 void fwnode_remove_software_node(struct fwnode_handle *fwnode)
 {
-	struct software_node *swnode = to_software_node(fwnode);
+	struct swnode *swnode = to_swnode(fwnode);
 
 	if (!swnode)
 		return;
@@ -645,7 +775,7 @@ EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
 int software_node_notify(struct device *dev, unsigned long action)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
-	struct software_node *swnode;
+	struct swnode *swnode;
 	int ret;
 
 	if (!fwnode)
@@ -656,7 +786,7 @@ int software_node_notify(struct device *dev, unsigned long action)
 	if (!is_software_node(fwnode))
 		return 0;
 
-	swnode = to_software_node(fwnode);
+	swnode = to_swnode(fwnode);
 
 	switch (action) {
 	case KOBJ_ADD:
diff --git a/include/linux/property.h b/include/linux/property.h
index a29369c89e6e..a3813ded52ea 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -332,7 +332,26 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 /* -------------------------------------------------------------------------- */
 /* Software fwnode support - when HW description is incomplete or missing */
 
+/**
+ * struct software_node - Software node description
+ * @name: Name of the software node
+ * @parent: Parent of the software node
+ * @properties: Array of device properties
+ */
+struct software_node {
+	const char *name;
+	const struct software_node *parent;
+	const struct property_entry *properties;
+};
+
 bool is_software_node(const struct fwnode_handle *fwnode);
+const struct software_node *to_software_node(struct fwnode_handle *fwnode);
+struct fwnode_handle *software_node_fwnode(const struct software_node *node);
+
+int software_node_register_nodes(const struct software_node *nodes);
+void software_node_unregister_nodes(const struct software_node *nodes);
+
+int software_node_register(const struct software_node *node);
 
 int software_node_notify(struct device *dev, unsigned long action);
 
-- 
2.20.1

