Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D99034B9D6
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Mar 2021 23:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhC0WUm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Mar 2021 18:20:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:65376 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhC0WUS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 Mar 2021 18:20:18 -0400
IronPort-SDR: oPHnaxeppvo/LCaOuep+NReZ/2+0pPgXRcHjXuo6PUVg56O30BymMWmtodsUtQi19wqy6paJBC
 YUhfYLhM+HTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9936"; a="190792951"
X-IronPort-AV: E=Sophos;i="5.81,284,1610438400"; 
   d="scan'208";a="190792951"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2021 15:20:17 -0700
IronPort-SDR: dupuPbrfXH4RC8cEJMOLs68HpZO6BskZtP3jLI8WbGP268LyMFnzosOdeUxY6lLtQeJHcBhuRc
 K3xDECKlStGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,284,1610438400"; 
   d="scan'208";a="526476385"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 27 Mar 2021 15:20:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E136A236; Sun, 28 Mar 2021 00:20:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v1 3/8] software node: Show properties and their values in sysfs
Date:   Sun, 28 Mar 2021 00:20:07 +0200
Message-Id: <20210327222012.54103-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It's very convenient to see what properties and their values
are currently being assigned in the registered software nodes.

Show properties and their values in sysfs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/swnode.c | 137 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 132 insertions(+), 5 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 19aa44bc2628..d7fe1a887d2d 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 
 struct swnode {
 	int id;
@@ -17,6 +18,10 @@ struct swnode {
 	struct fwnode_handle fwnode;
 	const struct software_node *node;
 
+	/* properties in sysfs */
+	struct kobj_attribute *property_attrs;
+	struct attribute_group property_group;
+
 	/* hierarchy */
 	struct ida child_ids;
 	struct list_head entry;
@@ -25,6 +30,7 @@ struct swnode {
 
 	unsigned int allocated:1;
 	unsigned int managed:1;
+	unsigned int properties:1;
 };
 
 static DEFINE_IDA(swnode_root_ids);
@@ -299,6 +305,18 @@ static int property_entry_copy_data(struct property_entry *dst,
 	return 0;
 }
 
+static int property_entries_count(const struct property_entry *properties)
+{
+	int n = 0;
+
+	if (properties) {
+		while (properties[n].name)
+			n++;
+	}
+
+	return n;
+}
+
 /**
  * property_entries_dup - duplicate array of properties
  * @properties: array of properties to copy
@@ -310,15 +328,13 @@ struct property_entry *
 property_entries_dup(const struct property_entry *properties)
 {
 	struct property_entry *p;
-	int i, n = 0;
+	int i, n;
 	int ret;
 
-	if (!properties)
+	n = property_entries_count(properties);
+	if (n == 0)
 		return NULL;
 
-	while (properties[n].name)
-		n++;
-
 	p = kcalloc(n + 1, sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
@@ -746,6 +762,108 @@ static void software_node_free(const struct software_node *node)
 	kfree(node);
 }
 
+static ssize_t
+swnode_property_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	struct swnode *swnode = kobj_to_swnode(kobj);
+	const struct property_entry *prop;
+	const void *pointer;
+	ssize_t len = 0;
+	int i;
+
+	prop = property_entry_get(swnode->node->properties, attr->attr.name);
+	if (!prop)
+		return -EINVAL;
+
+	/* We can't fail here, because it means boolean property */
+	pointer = property_get_pointer(prop);
+	if (!pointer)
+		return sysfs_emit(buf, "\n");
+
+	switch (prop->type) {
+	case DEV_PROP_U8:
+		for (i = 0; i < prop->length / sizeof(u8); i++)
+			len += sysfs_emit_at(buf, len, "%u,", ((u8 *)pointer)[i]);
+		break;
+	case DEV_PROP_U16:
+		for (i = 0; i < prop->length / sizeof(u16); i++)
+			len += sysfs_emit_at(buf, len, "%u,", ((u16 *)pointer)[i]);
+		break;
+	case DEV_PROP_U32:
+		for (i = 0; i < prop->length / sizeof(u32); i++)
+			len += sysfs_emit_at(buf, len, "%u,", ((u32 *)pointer)[i]);
+		break;
+	case DEV_PROP_U64:
+		for (i = 0; i < prop->length / sizeof(u64); i++)
+			len += sysfs_emit_at(buf, len, "%llu,", ((u64 *)pointer)[i]);
+		break;
+	case DEV_PROP_STRING:
+		for (i = 0; i < prop->length / sizeof(const char **); i++)
+			len += sysfs_emit_at(buf, len, "\"%s\",", ((const char **)pointer)[i]);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sysfs_emit_at(buf, len ? len - 1 : 0, "\n");
+	return len;
+}
+
+static int swnode_register_properties(struct swnode *swnode)
+{
+	const struct property_entry *props = swnode->node->properties;
+	struct attribute **group_attrs;
+	struct kobj_attribute *attrs;
+	int n;
+	int ret;
+
+	n = property_entries_count(props);
+	if (n == 0)
+		return 0;
+
+	group_attrs = kcalloc(n + 1, sizeof(*group_attrs), GFP_KERNEL);
+	if (!group_attrs)
+		return -ENOMEM;
+
+	attrs = kcalloc(n, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs) {
+		kfree(group_attrs);
+		return -ENOMEM;
+	}
+
+	while (n--) {
+		sysfs_attr_init(&attrs[n]);
+		attrs[n].attr.mode = 0444;
+		attrs[n].attr.name = props[n].name;
+		attrs[n].show = swnode_property_show;
+		group_attrs[n] = &attrs[n].attr;
+	}
+
+	swnode->property_group.name = "properties";
+	swnode->property_group.attrs = group_attrs;
+
+	ret = sysfs_create_group(&swnode->kobj, &swnode->property_group);
+	if (ret) {
+		kfree(attrs);
+		kfree(group_attrs);
+		return ret;
+	}
+
+	swnode->property_attrs = attrs;
+	swnode->properties = true;
+	return 0;
+}
+
+static void swnode_unregister_properties(struct swnode *swnode)
+{
+	/*
+	 * Nodes under sysfs are removed by __kobject_del(),
+	 * we don't need to call sysfs_remove_group() explicitly.
+	 */
+	kfree(swnode->property_group.attrs);
+	kfree(swnode->property_attrs);
+}
+
 static void software_node_release(struct kobject *kobj)
 {
 	struct swnode *swnode = kobj_to_swnode(kobj);
@@ -757,6 +875,9 @@ static void software_node_release(struct kobject *kobj)
 		ida_simple_remove(&swnode_root_ids, swnode->id);
 	}
 
+	if (swnode->properties)
+		swnode_unregister_properties(swnode);
+
 	if (swnode->allocated)
 		software_node_free(swnode->node);
 
@@ -810,6 +931,12 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 		return ERR_PTR(ret);
 	}
 
+	ret = swnode_register_properties(swnode);
+	if (ret) {
+		kobject_put(&swnode->kobj);
+		return ERR_PTR(ret);
+	}
+
 	/*
 	 * Assign the flag only in the successful case, so
 	 * the above kobject_put() won't mess up with properties.
-- 
2.30.2

