Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03431FFB0D
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2019 18:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfKQR65 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Nov 2019 12:58:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:25556 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfKQR65 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 17 Nov 2019 12:58:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:58:56 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400"; 
   d="scan'208";a="195907098"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:58:55 -0800
Subject: [PATCH v2 01/18] libnvdimm: Move attribute groups to device type
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 17 Nov 2019 09:44:39 -0800
Message-ID: <157401267992.43284.6498006162999013782.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Statically initialize the attribute groups for each libnvdimm
device_type. This is a preparation step for removing unnecessary exports
of attributes that can be included in the device_type by default.

Also take the opportunity to mark 'struct device_type' instances const.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/157309900111.1582359.2445687530383470348.stgit@dwillia2-desk3.amr.corp.intel.com
---
 drivers/nvdimm/btt_devs.c       |   24 +++++++-------
 drivers/nvdimm/dax_devs.c       |   27 ++++++---------
 drivers/nvdimm/namespace_devs.c |   68 +++++++++++++++++++++------------------
 drivers/nvdimm/nd.h             |    2 +
 drivers/nvdimm/pfn_devs.c       |   28 ++++++++--------
 5 files changed, 73 insertions(+), 76 deletions(-)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 3508a79110c7..05feb97e11ce 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -25,17 +25,6 @@ static void nd_btt_release(struct device *dev)
 	kfree(nd_btt);
 }
 
-static struct device_type nd_btt_device_type = {
-	.name = "nd_btt",
-	.release = nd_btt_release,
-};
-
-bool is_nd_btt(struct device *dev)
-{
-	return dev->type == &nd_btt_device_type;
-}
-EXPORT_SYMBOL(is_nd_btt);
-
 struct nd_btt *to_nd_btt(struct device *dev)
 {
 	struct nd_btt *nd_btt = container_of(dev, struct nd_btt, dev);
@@ -178,6 +167,18 @@ static const struct attribute_group *nd_btt_attribute_groups[] = {
 	NULL,
 };
 
+static const struct device_type nd_btt_device_type = {
+	.name = "nd_btt",
+	.release = nd_btt_release,
+	.groups = nd_btt_attribute_groups,
+};
+
+bool is_nd_btt(struct device *dev)
+{
+	return dev->type == &nd_btt_device_type;
+}
+EXPORT_SYMBOL(is_nd_btt);
+
 static struct device *__nd_btt_create(struct nd_region *nd_region,
 		unsigned long lbasize, u8 *uuid,
 		struct nd_namespace_common *ndns)
@@ -204,7 +205,6 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 	dev_set_name(dev, "btt%d.%d", nd_region->id, nd_btt->id);
 	dev->parent = &nd_region->dev;
 	dev->type = &nd_btt_device_type;
-	dev->groups = nd_btt_attribute_groups;
 	device_initialize(&nd_btt->dev);
 	if (ndns && !__nd_attach_ndns(&nd_btt->dev, ndns, &nd_btt->ndns)) {
 		dev_dbg(&ndns->dev, "failed, already claimed by %s\n",
diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
index 6d22b0f83b3b..99965077bac4 100644
--- a/drivers/nvdimm/dax_devs.c
+++ b/drivers/nvdimm/dax_devs.c
@@ -23,17 +23,6 @@ static void nd_dax_release(struct device *dev)
 	kfree(nd_dax);
 }
 
-static struct device_type nd_dax_device_type = {
-	.name = "nd_dax",
-	.release = nd_dax_release,
-};
-
-bool is_nd_dax(struct device *dev)
-{
-	return dev ? dev->type == &nd_dax_device_type : false;
-}
-EXPORT_SYMBOL(is_nd_dax);
-
 struct nd_dax *to_nd_dax(struct device *dev)
 {
 	struct nd_dax *nd_dax = container_of(dev, struct nd_dax, nd_pfn.dev);
@@ -43,13 +32,18 @@ struct nd_dax *to_nd_dax(struct device *dev)
 }
 EXPORT_SYMBOL(to_nd_dax);
 
-static const struct attribute_group *nd_dax_attribute_groups[] = {
-	&nd_pfn_attribute_group,
-	&nd_device_attribute_group,
-	&nd_numa_attribute_group,
-	NULL,
+static const struct device_type nd_dax_device_type = {
+	.name = "nd_dax",
+	.release = nd_dax_release,
+	.groups = nd_pfn_attribute_groups,
 };
 
+bool is_nd_dax(struct device *dev)
+{
+	return dev ? dev->type == &nd_dax_device_type : false;
+}
+EXPORT_SYMBOL(is_nd_dax);
+
 static struct nd_dax *nd_dax_alloc(struct nd_region *nd_region)
 {
 	struct nd_pfn *nd_pfn;
@@ -69,7 +63,6 @@ static struct nd_dax *nd_dax_alloc(struct nd_region *nd_region)
 
 	dev = &nd_pfn->dev;
 	dev_set_name(dev, "dax%d.%d", nd_region->id, nd_pfn->id);
-	dev->groups = nd_dax_attribute_groups;
 	dev->type = &nd_dax_device_type;
 	dev->parent = &nd_region->dev;
 
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index c90664387ee5..05d99a8b3175 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -44,35 +44,9 @@ static void namespace_blk_release(struct device *dev)
 	kfree(nsblk);
 }
 
-static const struct device_type namespace_io_device_type = {
-	.name = "nd_namespace_io",
-	.release = namespace_io_release,
-};
-
-static const struct device_type namespace_pmem_device_type = {
-	.name = "nd_namespace_pmem",
-	.release = namespace_pmem_release,
-};
-
-static const struct device_type namespace_blk_device_type = {
-	.name = "nd_namespace_blk",
-	.release = namespace_blk_release,
-};
-
-static bool is_namespace_pmem(const struct device *dev)
-{
-	return dev ? dev->type == &namespace_pmem_device_type : false;
-}
-
-static bool is_namespace_blk(const struct device *dev)
-{
-	return dev ? dev->type == &namespace_blk_device_type : false;
-}
-
-static bool is_namespace_io(const struct device *dev)
-{
-	return dev ? dev->type == &namespace_io_device_type : false;
-}
+static bool is_namespace_pmem(const struct device *dev);
+static bool is_namespace_blk(const struct device *dev);
+static bool is_namespace_io(const struct device *dev);
 
 static int is_uuid_busy(struct device *dev, void *data)
 {
@@ -1680,6 +1654,39 @@ static const struct attribute_group *nd_namespace_attribute_groups[] = {
 	NULL,
 };
 
+static const struct device_type namespace_io_device_type = {
+	.name = "nd_namespace_io",
+	.release = namespace_io_release,
+	.groups = nd_namespace_attribute_groups,
+};
+
+static const struct device_type namespace_pmem_device_type = {
+	.name = "nd_namespace_pmem",
+	.release = namespace_pmem_release,
+	.groups = nd_namespace_attribute_groups,
+};
+
+static const struct device_type namespace_blk_device_type = {
+	.name = "nd_namespace_blk",
+	.release = namespace_blk_release,
+	.groups = nd_namespace_attribute_groups,
+};
+
+static bool is_namespace_pmem(const struct device *dev)
+{
+	return dev ? dev->type == &namespace_pmem_device_type : false;
+}
+
+static bool is_namespace_blk(const struct device *dev)
+{
+	return dev ? dev->type == &namespace_blk_device_type : false;
+}
+
+static bool is_namespace_io(const struct device *dev)
+{
+	return dev ? dev->type == &namespace_io_device_type : false;
+}
+
 struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 {
 	struct nd_btt *nd_btt = is_nd_btt(dev) ? to_nd_btt(dev) : NULL;
@@ -2095,7 +2102,6 @@ static struct device *nd_namespace_blk_create(struct nd_region *nd_region)
 	}
 	dev_set_name(dev, "namespace%d.%d", nd_region->id, nsblk->id);
 	dev->parent = &nd_region->dev;
-	dev->groups = nd_namespace_attribute_groups;
 
 	return &nsblk->common.dev;
 }
@@ -2126,7 +2132,6 @@ static struct device *nd_namespace_pmem_create(struct nd_region *nd_region)
 		return NULL;
 	}
 	dev_set_name(dev, "namespace%d.%d", nd_region->id, nspm->id);
-	dev->groups = nd_namespace_attribute_groups;
 	nd_namespace_pmem_set_resource(nd_region, nspm, 0);
 
 	return dev;
@@ -2625,7 +2630,6 @@ int nd_region_register_namespaces(struct nd_region *nd_region, int *err)
 		if (id < 0)
 			break;
 		dev_set_name(dev, "namespace%d.%d", nd_region->id, id);
-		dev->groups = nd_namespace_attribute_groups;
 		nd_device_register(dev);
 	}
 	if (i)
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index a9f338d01a55..d83dd34cd169 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -302,7 +302,7 @@ struct device *nd_pfn_create(struct nd_region *nd_region);
 struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
 		struct nd_namespace_common *ndns);
 int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig);
-extern struct attribute_group nd_pfn_attribute_group;
+extern const struct attribute_group *nd_pfn_attribute_groups[];
 #else
 static inline int nd_pfn_probe(struct device *dev,
 		struct nd_namespace_common *ndns)
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 3ca6c97cd14d..17ceac5b5313 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -26,17 +26,6 @@ static void nd_pfn_release(struct device *dev)
 	kfree(nd_pfn);
 }
 
-static struct device_type nd_pfn_device_type = {
-	.name = "nd_pfn",
-	.release = nd_pfn_release,
-};
-
-bool is_nd_pfn(struct device *dev)
-{
-	return dev ? dev->type == &nd_pfn_device_type : false;
-}
-EXPORT_SYMBOL(is_nd_pfn);
-
 struct nd_pfn *to_nd_pfn(struct device *dev)
 {
 	struct nd_pfn *nd_pfn = container_of(dev, struct nd_pfn, dev);
@@ -287,18 +276,30 @@ static umode_t pfn_visible(struct kobject *kobj, struct attribute *a, int n)
 	return a->mode;
 }
 
-struct attribute_group nd_pfn_attribute_group = {
+static struct attribute_group nd_pfn_attribute_group = {
 	.attrs = nd_pfn_attributes,
 	.is_visible = pfn_visible,
 };
 
-static const struct attribute_group *nd_pfn_attribute_groups[] = {
+const struct attribute_group *nd_pfn_attribute_groups[] = {
 	&nd_pfn_attribute_group,
 	&nd_device_attribute_group,
 	&nd_numa_attribute_group,
 	NULL,
 };
 
+static const struct device_type nd_pfn_device_type = {
+	.name = "nd_pfn",
+	.release = nd_pfn_release,
+	.groups = nd_pfn_attribute_groups,
+};
+
+bool is_nd_pfn(struct device *dev)
+{
+	return dev ? dev->type == &nd_pfn_device_type : false;
+}
+EXPORT_SYMBOL(is_nd_pfn);
+
 struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
 		struct nd_namespace_common *ndns)
 {
@@ -337,7 +338,6 @@ static struct nd_pfn *nd_pfn_alloc(struct nd_region *nd_region)
 
 	dev = &nd_pfn->dev;
 	dev_set_name(dev, "pfn%d.%d", nd_region->id, nd_pfn->id);
-	dev->groups = nd_pfn_attribute_groups;
 	dev->type = &nd_pfn_device_type;
 	dev->parent = &nd_region->dev;
 

