Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FA726273
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2019 12:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfEVKv1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 May 2019 06:51:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:32515 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbfEVKv0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 May 2019 06:51:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 03:51:26 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2019 03:51:24 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 05/16] software node: Add software_node_get_reference_args()
Date:   Wed, 22 May 2019 13:51:02 +0300
Message-Id: <20190522105113.11153-6-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
References: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This makes it possible to support drivers that use
fwnode_property_get_reference_args() function.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c    | 47 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h | 28 ++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 2d925fc2255f..e7b3aa3bd55a 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -560,6 +560,52 @@ software_node_get_named_child_node(const struct fwnode_handle *fwnode,
 	return NULL;
 }
 
+static int
+software_node_get_reference_args(const struct fwnode_handle *fwnode,
+				 const char *propname, const char *nargs_prop,
+				 unsigned int nargs, unsigned int index,
+				 struct fwnode_reference_args *args)
+{
+	struct swnode *swnode = to_swnode(fwnode);
+	const struct software_node_reference *ref;
+	const struct property_entry *prop;
+	struct fwnode_handle *refnode;
+	int i;
+
+	if (!swnode || !swnode->node->references)
+		return -ENOENT;
+
+	for (ref = swnode->node->references; ref->name; ref++)
+		if (!strcmp(ref->name, propname))
+			break;
+
+	if (!ref->name || index > (ref->nrefs - 1))
+		return -ENOENT;
+
+	refnode = software_node_fwnode(ref->refs[index].node);
+	if (!refnode)
+		return -ENOENT;
+
+	if (nargs_prop) {
+		prop = property_entry_get(swnode->node->properties, nargs_prop);
+		if (!prop)
+			return -EINVAL;
+
+		nargs = prop->value.u32_data;
+	}
+
+	if (nargs > NR_FWNODE_REFERENCE_ARGS)
+		return -EINVAL;
+
+	args->fwnode = software_node_get(refnode);
+	args->nargs = nargs;
+
+	for (i = 0; i < nargs; i++)
+		args->args[i] = ref->refs[index].args[i];
+
+	return 0;
+}
+
 static const struct fwnode_operations software_node_ops = {
 	.get = software_node_get,
 	.put = software_node_put,
@@ -569,6 +615,7 @@ static const struct fwnode_operations software_node_ops = {
 	.get_parent = software_node_get_parent,
 	.get_next_child_node = software_node_get_next_child,
 	.get_named_child_node = software_node_get_named_child_node,
+	.get_reference_args = software_node_get_reference_args
 };
 
 /* -------------------------------------------------------------------------- */
diff --git a/include/linux/property.h b/include/linux/property.h
index a3813ded52ea..abcde2f236a0 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -332,16 +332,44 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 /* -------------------------------------------------------------------------- */
 /* Software fwnode support - when HW description is incomplete or missing */
 
+struct software_node;
+
+/**
+ * struct software_node_ref_args - Reference with additional arguments
+ * @node: Reference to a software node
+ * @nargs: Number of elements in @args array
+ * @args: Integer arguments
+ */
+struct software_node_ref_args {
+	const struct software_node *node;
+	unsigned int nargs;
+	u64 args[NR_FWNODE_REFERENCE_ARGS];
+};
+
+/**
+ * struct software_node_reference - Named software node reference property
+ * @name: Name of the property
+ * @nrefs: Number of elements in @refs array
+ * @refs: Array of references with optional arguments
+ */
+struct software_node_reference {
+	const char *name;
+	unsigned int nrefs;
+	const struct software_node_ref_args *refs;
+};
+
 /**
  * struct software_node - Software node description
  * @name: Name of the software node
  * @parent: Parent of the software node
  * @properties: Array of device properties
+ * @references: Array of software node reference properties
  */
 struct software_node {
 	const char *name;
 	const struct software_node *parent;
 	const struct property_entry *properties;
+	const struct software_node_reference *references;
 };
 
 bool is_software_node(const struct fwnode_handle *fwnode);
-- 
2.20.1

