Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD3AAFFB10
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2019 18:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfKQR7C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Nov 2019 12:59:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:25873 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfKQR7C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 17 Nov 2019 12:59:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:01 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400"; 
   d="scan'208";a="208876218"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:01 -0800
Subject: [PATCH v2 02/18] libnvdimm: Move region attribute group definition
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 17 Nov 2019 09:44:45 -0800
Message-ID: <157401268506.43284.15446878125298907341.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation for moving region attributes from device attribute groups
to the region device-type, reorder the declaration so that it can be
referenced by the device-type definition without forward declarations.
No functional changes are intended to result from this change.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/157309900624.1582359.6929998072035982264.stgit@dwillia2-desk3.amr.corp.intel.com
---
 drivers/nvdimm/region_devs.c |  208 +++++++++++++++++++++---------------------
 1 file changed, 104 insertions(+), 104 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ef423ba1a711..e89f2eb3678c 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -140,36 +140,6 @@ static void nd_region_release(struct device *dev)
 		kfree(nd_region);
 }
 
-static struct device_type nd_blk_device_type = {
-	.name = "nd_blk",
-	.release = nd_region_release,
-};
-
-static struct device_type nd_pmem_device_type = {
-	.name = "nd_pmem",
-	.release = nd_region_release,
-};
-
-static struct device_type nd_volatile_device_type = {
-	.name = "nd_volatile",
-	.release = nd_region_release,
-};
-
-bool is_nd_pmem(struct device *dev)
-{
-	return dev ? dev->type == &nd_pmem_device_type : false;
-}
-
-bool is_nd_blk(struct device *dev)
-{
-	return dev ? dev->type == &nd_blk_device_type : false;
-}
-
-bool is_nd_volatile(struct device *dev)
-{
-	return dev ? dev->type == &nd_volatile_device_type : false;
-}
-
 struct nd_region *to_nd_region(struct device *dev)
 {
 	struct nd_region *nd_region = container_of(dev, struct nd_region, dev);
@@ -674,80 +644,6 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 	return 0;
 }
 
-struct attribute_group nd_region_attribute_group = {
-	.attrs = nd_region_attributes,
-	.is_visible = region_visible,
-};
-EXPORT_SYMBOL_GPL(nd_region_attribute_group);
-
-u64 nd_region_interleave_set_cookie(struct nd_region *nd_region,
-		struct nd_namespace_index *nsindex)
-{
-	struct nd_interleave_set *nd_set = nd_region->nd_set;
-
-	if (!nd_set)
-		return 0;
-
-	if (nsindex && __le16_to_cpu(nsindex->major) == 1
-			&& __le16_to_cpu(nsindex->minor) == 1)
-		return nd_set->cookie1;
-	return nd_set->cookie2;
-}
-
-u64 nd_region_interleave_set_altcookie(struct nd_region *nd_region)
-{
-	struct nd_interleave_set *nd_set = nd_region->nd_set;
-
-	if (nd_set)
-		return nd_set->altcookie;
-	return 0;
-}
-
-void nd_mapping_free_labels(struct nd_mapping *nd_mapping)
-{
-	struct nd_label_ent *label_ent, *e;
-
-	lockdep_assert_held(&nd_mapping->lock);
-	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
-		list_del(&label_ent->list);
-		kfree(label_ent);
-	}
-}
-
-/*
- * When a namespace is activated create new seeds for the next
- * namespace, or namespace-personality to be configured.
- */
-void nd_region_advance_seeds(struct nd_region *nd_region, struct device *dev)
-{
-	nvdimm_bus_lock(dev);
-	if (nd_region->ns_seed == dev) {
-		nd_region_create_ns_seed(nd_region);
-	} else if (is_nd_btt(dev)) {
-		struct nd_btt *nd_btt = to_nd_btt(dev);
-
-		if (nd_region->btt_seed == dev)
-			nd_region_create_btt_seed(nd_region);
-		if (nd_region->ns_seed == &nd_btt->ndns->dev)
-			nd_region_create_ns_seed(nd_region);
-	} else if (is_nd_pfn(dev)) {
-		struct nd_pfn *nd_pfn = to_nd_pfn(dev);
-
-		if (nd_region->pfn_seed == dev)
-			nd_region_create_pfn_seed(nd_region);
-		if (nd_region->ns_seed == &nd_pfn->ndns->dev)
-			nd_region_create_ns_seed(nd_region);
-	} else if (is_nd_dax(dev)) {
-		struct nd_dax *nd_dax = to_nd_dax(dev);
-
-		if (nd_region->dax_seed == dev)
-			nd_region_create_dax_seed(nd_region);
-		if (nd_region->ns_seed == &nd_dax->nd_pfn.ndns->dev)
-			nd_region_create_ns_seed(nd_region);
-	}
-	nvdimm_bus_unlock(dev);
-}
-
 static ssize_t mappingN(struct device *dev, char *buf, int n)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
@@ -861,6 +757,110 @@ struct attribute_group nd_mapping_attribute_group = {
 };
 EXPORT_SYMBOL_GPL(nd_mapping_attribute_group);
 
+struct attribute_group nd_region_attribute_group = {
+	.attrs = nd_region_attributes,
+	.is_visible = region_visible,
+};
+EXPORT_SYMBOL_GPL(nd_region_attribute_group);
+
+static struct device_type nd_blk_device_type = {
+	.name = "nd_blk",
+	.release = nd_region_release,
+};
+
+static struct device_type nd_pmem_device_type = {
+	.name = "nd_pmem",
+	.release = nd_region_release,
+};
+
+static struct device_type nd_volatile_device_type = {
+	.name = "nd_volatile",
+	.release = nd_region_release,
+};
+
+bool is_nd_pmem(struct device *dev)
+{
+	return dev ? dev->type == &nd_pmem_device_type : false;
+}
+
+bool is_nd_blk(struct device *dev)
+{
+	return dev ? dev->type == &nd_blk_device_type : false;
+}
+
+bool is_nd_volatile(struct device *dev)
+{
+	return dev ? dev->type == &nd_volatile_device_type : false;
+}
+
+u64 nd_region_interleave_set_cookie(struct nd_region *nd_region,
+		struct nd_namespace_index *nsindex)
+{
+	struct nd_interleave_set *nd_set = nd_region->nd_set;
+
+	if (!nd_set)
+		return 0;
+
+	if (nsindex && __le16_to_cpu(nsindex->major) == 1
+			&& __le16_to_cpu(nsindex->minor) == 1)
+		return nd_set->cookie1;
+	return nd_set->cookie2;
+}
+
+u64 nd_region_interleave_set_altcookie(struct nd_region *nd_region)
+{
+	struct nd_interleave_set *nd_set = nd_region->nd_set;
+
+	if (nd_set)
+		return nd_set->altcookie;
+	return 0;
+}
+
+void nd_mapping_free_labels(struct nd_mapping *nd_mapping)
+{
+	struct nd_label_ent *label_ent, *e;
+
+	lockdep_assert_held(&nd_mapping->lock);
+	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
+		list_del(&label_ent->list);
+		kfree(label_ent);
+	}
+}
+
+/*
+ * When a namespace is activated create new seeds for the next
+ * namespace, or namespace-personality to be configured.
+ */
+void nd_region_advance_seeds(struct nd_region *nd_region, struct device *dev)
+{
+	nvdimm_bus_lock(dev);
+	if (nd_region->ns_seed == dev) {
+		nd_region_create_ns_seed(nd_region);
+	} else if (is_nd_btt(dev)) {
+		struct nd_btt *nd_btt = to_nd_btt(dev);
+
+		if (nd_region->btt_seed == dev)
+			nd_region_create_btt_seed(nd_region);
+		if (nd_region->ns_seed == &nd_btt->ndns->dev)
+			nd_region_create_ns_seed(nd_region);
+	} else if (is_nd_pfn(dev)) {
+		struct nd_pfn *nd_pfn = to_nd_pfn(dev);
+
+		if (nd_region->pfn_seed == dev)
+			nd_region_create_pfn_seed(nd_region);
+		if (nd_region->ns_seed == &nd_pfn->ndns->dev)
+			nd_region_create_ns_seed(nd_region);
+	} else if (is_nd_dax(dev)) {
+		struct nd_dax *nd_dax = to_nd_dax(dev);
+
+		if (nd_region->dax_seed == dev)
+			nd_region_create_dax_seed(nd_region);
+		if (nd_region->ns_seed == &nd_dax->nd_pfn.ndns->dev)
+			nd_region_create_ns_seed(nd_region);
+	}
+	nvdimm_bus_unlock(dev);
+}
+
 int nd_blk_region_init(struct nd_region *nd_region)
 {
 	struct device *dev = &nd_region->dev;

