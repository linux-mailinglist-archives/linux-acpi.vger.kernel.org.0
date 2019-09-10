Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53EDFAE5F3
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2019 10:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfIJIri (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Sep 2019 04:47:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:17048 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387715AbfIJIrP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Sep 2019 04:47:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 01:47:14 -0700
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="175242535"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 01:47:11 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id B360520B52;
        Tue, 10 Sep 2019 11:47:05 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i7bnn-0004nc-DJ; Tue, 10 Sep 2019 11:47:07 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v6 06/12] device property: Add fwnode_get_name for returning the name of a node
Date:   Tue, 10 Sep 2019 11:47:01 +0300
Message-Id: <20190910084707.18380-7-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
References: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The fwnode framework did not have means to obtain the name of a node. Add
that now, in form of the fwnode_get_name() function and a corresponding
get_name fwnode op. OF and ACPI support is included.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Rob Herring <robh@kernel.org> (for OF)
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c  | 26 ++++++++++++++++++++++++++
 drivers/base/property.c  | 11 +++++++++++
 drivers/base/swnode.c    | 12 ++++++++++++
 drivers/of/property.c    |  6 ++++++
 include/linux/fwnode.h   |  2 ++
 include/linux/property.h |  1 +
 6 files changed, 58 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index ea3d700da3ca6..5a9397a390f41 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1311,6 +1311,31 @@ acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 						  args_count, args);
 }
 
+static const char *acpi_fwnode_get_name(const struct fwnode_handle *fwnode)
+{
+	const struct acpi_device *adev;
+	struct fwnode_handle *parent;
+
+	/* Is this the root node? */
+	parent = fwnode_get_parent(fwnode);
+	if (!parent)
+		return "\\";
+
+	fwnode_handle_put(parent);
+
+	if (is_acpi_data_node(fwnode)) {
+		const struct acpi_data_node *dn = to_acpi_data_node(fwnode);
+
+		return dn->name;
+	}
+
+	adev = to_acpi_device_node(fwnode);
+	if (WARN_ON(!adev))
+		return NULL;
+
+	return acpi_device_bid(adev);
+}
+
 static struct fwnode_handle *
 acpi_fwnode_get_parent(struct fwnode_handle *fwnode)
 {
@@ -1351,6 +1376,7 @@ acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 		.get_parent = acpi_node_get_parent,			\
 		.get_next_child_node = acpi_get_next_subnode,		\
 		.get_named_child_node = acpi_fwnode_get_named_child_node, \
+		.get_name = acpi_fwnode_get_name,			\
 		.get_reference_args = acpi_fwnode_get_reference_args,	\
 		.graph_get_next_endpoint =				\
 			acpi_graph_get_next_endpoint,			\
diff --git a/drivers/base/property.c b/drivers/base/property.c
index f2e555e68b56a..9b5ec88e72d8b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -556,6 +556,17 @@ int device_add_properties(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(device_add_properties);
 
+/**
+ * fwnode_get_name - Return the name of a node
+ * @fwnode: The firmware node
+ *
+ * Returns a pointer to the node name.
+ */
+const char *fwnode_get_name(const struct fwnode_handle *fwnode)
+{
+	return fwnode_call_ptr_op(fwnode, get_name);
+}
+
 /**
  * fwnode_get_parent - Return parent firwmare node
  * @fwnode: Firmware whose parent is retrieved
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 951e7efd47c23..ccbc3d9d6c5f5 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -515,6 +515,17 @@ static int software_node_read_string_array(const struct fwnode_handle *fwnode,
 						propname, val, nval);
 }
 
+static const char *
+software_node_get_name(const struct fwnode_handle *fwnode)
+{
+	const struct swnode *swnode = to_swnode(fwnode);
+
+	if (!swnode)
+		return "(null)";
+
+	return kobject_name(&swnode->kobj);
+}
+
 static struct fwnode_handle *
 software_node_get_parent(const struct fwnode_handle *fwnode)
 {
@@ -615,6 +626,7 @@ static const struct fwnode_operations software_node_ops = {
 	.property_present = software_node_property_present,
 	.property_read_int_array = software_node_read_int_array,
 	.property_read_string_array = software_node_read_string_array,
+	.get_name = software_node_get_name,
 	.get_parent = software_node_get_parent,
 	.get_next_child_node = software_node_get_next_child,
 	.get_named_child_node = software_node_get_named_child_node,
diff --git a/drivers/of/property.c b/drivers/of/property.c
index d7fa75e31f224..5bed634551ea6 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -872,6 +872,11 @@ of_fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
 		of_property_count_strings(node, propname);
 }
 
+static const char *of_fwnode_get_name(const struct fwnode_handle *fwnode)
+{
+	return kbasename(to_of_node(fwnode)->full_name);
+}
+
 static struct fwnode_handle *
 of_fwnode_get_parent(const struct fwnode_handle *fwnode)
 {
@@ -993,6 +998,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.property_present = of_fwnode_property_present,
 	.property_read_int_array = of_fwnode_property_read_int_array,
 	.property_read_string_array = of_fwnode_property_read_string_array,
+	.get_name = of_fwnode_get_name,
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
 	.get_named_child_node = of_fwnode_get_named_child_node,
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index a11c8c56c78b4..c331e0ef31e80 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -56,6 +56,7 @@ struct fwnode_reference_args {
  *				 otherwise.
  * @property_read_string_array: Read an array of string properties. Return zero
  *				on success, a negative error code otherwise.
+ * @get_name: Return the name of an fwnode.
  * @get_parent: Return the parent of an fwnode.
  * @get_next_child_node: Return the next child node in an iteration.
  * @get_named_child_node: Return a child node with a given name.
@@ -82,6 +83,7 @@ struct fwnode_operations {
 	(*property_read_string_array)(const struct fwnode_handle *fwnode_handle,
 				      const char *propname, const char **val,
 				      size_t nval);
+	const char *(*get_name)(const struct fwnode_handle *fwnode);
 	struct fwnode_handle *(*get_parent)(const struct fwnode_handle *fwnode);
 	struct fwnode_handle *
 	(*get_next_child_node)(const struct fwnode_handle *fwnode,
diff --git a/include/linux/property.h b/include/linux/property.h
index 5450e7ec219ac..ebc5e2016bb66 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -80,6 +80,7 @@ struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
 					    const char *name,
 					    unsigned int index);
 
+const char *fwnode_get_name(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_parent(
 	struct fwnode_handle *fwnode);
-- 
2.20.1

