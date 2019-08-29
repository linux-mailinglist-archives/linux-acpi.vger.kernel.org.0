Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B42AA167A
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2019 12:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfH2KoE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Aug 2019 06:44:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:65224 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfH2KoE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Aug 2019 06:44:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 03:44:03 -0700
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="175229030"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 03:44:00 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id D3AE5203A8;
        Thu, 29 Aug 2019 13:43:58 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i3HuL-0006Po-KE; Thu, 29 Aug 2019 13:44:01 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 03/10] device property: Add functions for accessing node's parents
Date:   Thu, 29 Aug 2019 13:44:01 +0300
Message-Id: <20190829104401.24183-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829101043.24963-4-sakari.ailus@linux.intel.com>
References: <20190829101043.24963-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add two convenience functions for accessing node's parents:

fwnode_count_parents() returns the number of parent nodes a given node
has. fwnode_get_nth_parent() returns node's parent at a given distance
from the node itself.

Also reorder fwnode_get_parent() in property.c according to the same order
as in property.h.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
since v3:

- Swap __fwnode and fwnode in fwnode_count_parents(). This way the
  user-visible argument remains "fwnode".

 drivers/base/property.c  | 60 +++++++++++++++++++++++++++++++++++-----
 include/linux/property.h |  3 ++
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 81bd01ed40427..d2461d79139f3 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -556,6 +556,19 @@ int device_add_properties(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(device_add_properties);
 
+/**
+ * fwnode_get_parent - Return parent firwmare node
+ * @fwnode: Firmware whose parent is retrieved
+ *
+ * Return parent firmware node of the given node if possible or %NULL if no
+ * parent was available.
+ */
+struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
+{
+	return fwnode_call_ptr_op(fwnode, get_parent);
+}
+EXPORT_SYMBOL_GPL(fwnode_get_parent);
+
 /**
  * fwnode_get_next_parent - Iterate to the node's parent
  * @fwnode: Firmware whose parent is retrieved
@@ -578,17 +591,50 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
 
 /**
- * fwnode_get_parent - Return parent firwmare node
- * @fwnode: Firmware whose parent is retrieved
+ * fwnode_count_parents - Return the number of parents a node has
+ * @fwnode: The node the parents of which are to be counted
  *
- * Return parent firmware node of the given node if possible or %NULL if no
- * parent was available.
+ * Returns the number of parents a node has.
  */
-struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
+unsigned int fwnode_count_parents(const struct fwnode_handle *fwnode)
 {
-	return fwnode_call_ptr_op(fwnode, get_parent);
+	struct fwnode_handle *__fwnode;
+	unsigned int count;
+
+	__fwnode = fwnode_get_parent(fwnode);
+
+	for (count = 0; __fwnode; count++)
+		__fwnode = fwnode_get_next_parent(__fwnode);
+
+	return count;
 }
-EXPORT_SYMBOL_GPL(fwnode_get_parent);
+EXPORT_SYMBOL_GPL(fwnode_count_parents);
+
+/**
+ * fwnode_get_nth_parent - Return an nth parent of a node
+ * @fwnode: The node the parent of which is requested
+ * @depth: Distance of the parent from the node
+ *
+ * Returns the nth parent of a node. If @depth is 0, the functionality is
+ * equivalent to fwnode_handle_get(). For @depth == 1, it is fwnode_get_parent()
+ * and so on.
+ *
+ * The caller is responsible for calling fwnode_handle_put() for the returned
+ * node.
+ */
+struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
+					    unsigned int depth)
+{
+	unsigned int i;
+
+	fwnode_handle_get(fwnode);
+
+	for (i = 0; i < depth && fwnode; i++)
+		fwnode = fwnode_get_next_parent(fwnode);
+
+	return fwnode;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
 
 /**
  * fwnode_get_next_child_node - Return the next child node handle for a node
diff --git a/include/linux/property.h b/include/linux/property.h
index 421c76e53708d..5450e7ec219ac 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -83,6 +83,9 @@ struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_parent(
 	struct fwnode_handle *fwnode);
+unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
+struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
+					    unsigned int depth);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_available_child_node(
-- 
2.20.1

