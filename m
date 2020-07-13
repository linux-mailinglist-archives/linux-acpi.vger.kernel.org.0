Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7A21CA58
	for <lists+linux-acpi@lfdr.de>; Sun, 12 Jul 2020 18:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgGLQnp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 12 Jul 2020 12:43:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:25474 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbgGLQno (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 12 Jul 2020 12:43:44 -0400
IronPort-SDR: KMPYeUKtHFYAKLUrIbt9xJPKF8Wfl0/WaykA+G3fkipmI5bXJOlQSq4Fi8pTaurDL/nFhGpjqy
 p2h3WGi8EV5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="233371305"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="233371305"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:42 -0700
IronPort-SDR: 3uipVmAk9PU+Q+7vguNjQs3QdcDZp331HJQU5aM1Xoj2ISVhguDxtaDNb8AmparkWyFHHX2w6i
 Z3kSn0nyNdNQ==
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="484764280"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:42 -0700
Subject: [PATCH v2 15/22] device-dax: Add an allocation interface for
 device-dax instances
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>, peterz@infradead.org,
        dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, hch@lst.de, joao.m.martins@oracle.com
Date:   Sun, 12 Jul 2020 09:27:26 -0700
Message-ID: <159457124643.754248.13763635444220228706.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation for a facility that enables dax regions to be
sub-divided, introduce infrastructure to track and allocate region
capacity.

The new dax_region/available_size attribute is only enabled for volatile
hmem devices, not pmem devices that are defined by nvdimm namespace
boundaries. This is per Jeff's feedback the last time dynamic device-dax
capacity allocation support was discussed.

Link: https://lore.kernel.org/linux-nvdimm/x49shpp3zn8.fsf@segfault.boston.devel.redhat.com
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c         |  120 +++++++++++++++++++++++++++++++++++++++++----
 drivers/dax/bus.h         |    7 ++-
 drivers/dax/dax-private.h |    2 -
 drivers/dax/hmem/hmem.c   |    7 +--
 drivers/dax/pmem/core.c   |    8 +--
 5 files changed, 121 insertions(+), 23 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 96bd64ba95a5..0a48ce378686 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -130,6 +130,11 @@ ATTRIBUTE_GROUPS(dax_drv);
 
 static int dax_bus_match(struct device *dev, struct device_driver *drv);
 
+static bool is_static(struct dax_region *dax_region)
+{
+	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) != 0;
+}
+
 static struct bus_type dax_bus_type = {
 	.name = "dax",
 	.uevent = dax_bus_uevent,
@@ -185,7 +190,48 @@ static ssize_t align_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(align);
 
+#define for_each_dax_region_resource(dax_region, res) \
+	for (res = (dax_region)->res.child; res; res = res->sibling)
+
+static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
+{
+	resource_size_t size = resource_size(&dax_region->res);
+	struct resource *res;
+
+	device_lock_assert(dax_region->dev);
+
+	for_each_dax_region_resource(dax_region, res)
+		size -= resource_size(res);
+	return size;
+}
+
+static ssize_t available_size_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dax_region *dax_region = dev_get_drvdata(dev);
+	unsigned long long size;
+
+	device_lock(dev);
+	size = dax_region_avail_size(dax_region);
+	device_unlock(dev);
+
+	return sprintf(buf, "%llu\n", size);
+}
+static DEVICE_ATTR_RO(available_size);
+
+static umode_t dax_region_visible(struct kobject *kobj, struct attribute *a,
+		int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct dax_region *dax_region = dev_get_drvdata(dev);
+
+	if (is_static(dax_region) && a == &dev_attr_available_size.attr)
+		return 0;
+	return a->mode;
+}
+
 static struct attribute *dax_region_attributes[] = {
+	&dev_attr_available_size.attr,
 	&dev_attr_region_size.attr,
 	&dev_attr_align.attr,
 	&dev_attr_id.attr,
@@ -195,6 +241,7 @@ static struct attribute *dax_region_attributes[] = {
 static const struct attribute_group dax_region_attribute_group = {
 	.name = "dax_region",
 	.attrs = dax_region_attributes,
+	.is_visible = dax_region_visible,
 };
 
 static const struct attribute_group *dax_region_attribute_groups[] = {
@@ -226,7 +273,8 @@ static void dax_region_unregister(void *region)
 }
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct resource *res, int target_node, unsigned int align)
+		struct resource *res, int target_node, unsigned int align,
+		unsigned long flags)
 {
 	struct dax_region *dax_region;
 
@@ -249,12 +297,17 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		return NULL;
 
 	dev_set_drvdata(parent, dax_region);
-	memcpy(&dax_region->res, res, sizeof(*res));
 	kref_init(&dax_region->kref);
 	dax_region->id = region_id;
 	dax_region->align = align;
 	dax_region->dev = parent;
 	dax_region->target_node = target_node;
+	dax_region->res = (struct resource) {
+		.start = res->start,
+		.end = res->end,
+		.flags = IORESOURCE_MEM | flags,
+	};
+
 	if (sysfs_create_groups(&parent->kobj, dax_region_attribute_groups)) {
 		kfree(dax_region);
 		return NULL;
@@ -267,6 +320,32 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 }
 EXPORT_SYMBOL_GPL(alloc_dax_region);
 
+static int alloc_dev_dax_range(struct dev_dax *dev_dax, resource_size_t size)
+{
+	struct dax_region *dax_region = dev_dax->region;
+	struct resource *res = &dax_region->res;
+	struct device *dev = &dev_dax->dev;
+	struct resource *alloc;
+
+	device_lock_assert(dax_region->dev);
+
+	/* TODO: handle multiple allocations per region */
+	if (res->child)
+		return -ENOMEM;
+
+	alloc = __request_region(res, res->start, size, dev_name(dev), 0);
+
+	if (!alloc)
+		return -ENOMEM;
+
+	dev_dax->range = (struct range) {
+		.start = alloc->start,
+		.end = alloc->end,
+	};
+
+	return 0;
+}
+
 static ssize_t size_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -361,6 +440,15 @@ void kill_dev_dax(struct dev_dax *dev_dax)
 }
 EXPORT_SYMBOL_GPL(kill_dev_dax);
 
+static void free_dev_dax_range(struct dev_dax *dev_dax)
+{
+	struct dax_region *dax_region = dev_dax->region;
+	struct range *range = &dev_dax->range;
+
+	device_lock_assert(dax_region->dev);
+	__release_region(&dax_region->res, range->start, range_len(range));
+}
+
 static void dev_dax_release(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
@@ -385,6 +473,7 @@ static void unregister_dev_dax(void *dev)
 	dev_dbg(dev, "%s\n", __func__);
 
 	kill_dev_dax(dev_dax);
+	free_dev_dax_range(dev_dax);
 	device_del(dev);
 	put_device(dev);
 }
@@ -397,7 +486,7 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	struct dev_dax *dev_dax;
 	struct inode *inode;
 	struct device *dev;
-	int rc = -ENOMEM;
+	int rc;
 
 	if (data->id < 0)
 		return ERR_PTR(-EINVAL);
@@ -406,11 +495,25 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	if (!dev_dax)
 		return ERR_PTR(-ENOMEM);
 
+	dev_dax->region = dax_region;
+	dev = &dev_dax->dev;
+	device_initialize(dev);
+	dev_set_name(dev, "dax%d.%d", dax_region->id, data->id);
+
+	rc = alloc_dev_dax_range(dev_dax, data->size);
+	if (rc)
+		goto err_range;
+
 	if (data->pgmap) {
+		dev_WARN_ONCE(parent, !is_static(dax_region),
+			"custom dev_pagemap requires a static dax_region\n");
+
 		dev_dax->pgmap = kmemdup(data->pgmap,
 				sizeof(struct dev_pagemap), GFP_KERNEL);
-		if (!dev_dax->pgmap)
+		if (!dev_dax->pgmap) {
+			rc = -ENOMEM;
 			goto err_pgmap;
+		}
 	}
 
 	/*
@@ -427,12 +530,7 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	kill_dax(dax_dev);
 
 	/* from here on we're committed to teardown via dev_dax_release() */
-	dev = &dev_dax->dev;
-	device_initialize(dev);
-
 	dev_dax->dax_dev = dax_dev;
-	dev_dax->region = dax_region;
-	dev_dax->range = data->range;
 	dev_dax->target_node = dax_region->target_node;
 	kref_get(&dax_region->kref);
 
@@ -444,7 +542,6 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 		dev->class = dax_class;
 	dev->parent = parent;
 	dev->type = &dev_dax_type;
-	dev_set_name(dev, "dax%d.%d", dax_region->id, data->id);
 
 	rc = device_add(dev);
 	if (rc) {
@@ -458,9 +555,12 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 		return ERR_PTR(rc);
 
 	return dev_dax;
+
 err_alloc_dax:
 	kfree(dev_dax->pgmap);
 err_pgmap:
+	free_dev_dax_range(dev_dax);
+err_range:
 	kfree(dev_dax);
 
 	return ERR_PTR(rc);
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 4aeb36da83a4..44592a8cac0f 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -10,8 +10,11 @@ struct resource;
 struct dax_device;
 struct dax_region;
 void dax_region_put(struct dax_region *dax_region);
+
+#define IORESOURCE_DAX_STATIC (1UL << 0)
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct resource *res, int target_node, unsigned int align);
+		struct resource *res, int target_node, unsigned int align,
+		unsigned long flags);
 
 enum dev_dax_subsys {
 	DEV_DAX_BUS = 0, /* zeroed dev_dax_data picks this by default */
@@ -22,7 +25,7 @@ struct dev_dax_data {
 	struct dax_region *dax_region;
 	struct dev_pagemap *pgmap;
 	enum dev_dax_subsys subsys;
-	struct range range;
+	resource_size_t size;
 	int id;
 };
 
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 12a2dbc43b40..99b1273bb232 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -22,7 +22,7 @@ void dax_bus_exit(void);
  * @kref: to pin while other agents have a need to do lookups
  * @dev: parent device backing this region
  * @align: allocation and mapping alignment for child dax devices
- * @res: physical address range of the region
+ * @res: resource tree to track instance allocations
  */
 struct dax_region {
 	int id;
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index af82d6ba820a..e7b64539e23e 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -20,17 +20,14 @@ static int dax_hmem_probe(struct platform_device *pdev)
 
 	mri = dev->platform_data;
 	dax_region = alloc_dax_region(dev, pdev->id, res, mri->target_node,
-			PMD_SIZE);
+			PMD_SIZE, 0);
 	if (!dax_region)
 		return -ENOMEM;
 
 	data = (struct dev_dax_data) {
 		.dax_region = dax_region,
 		.id = 0,
-		.range = {
-			.start = res->start,
-			.end = res->end,
-		},
+		.size = resource_size(res),
 	};
 	dev_dax = devm_create_dev_dax(&data);
 	if (IS_ERR(dev_dax))
diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index 4fa81d3d2f65..4fe700884338 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -54,7 +54,8 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	memcpy(&res, &pgmap.res, sizeof(res));
 	res.start += offset;
 	dax_region = alloc_dax_region(dev, region_id, &res,
-			nd_region->target_node, le32_to_cpu(pfn_sb->align));
+			nd_region->target_node, le32_to_cpu(pfn_sb->align),
+			IORESOURCE_DAX_STATIC);
 	if (!dax_region)
 		return ERR_PTR(-ENOMEM);
 
@@ -63,10 +64,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 		.id = id,
 		.pgmap = &pgmap,
 		.subsys = subsys,
-		.range = {
-			.start = res.start,
-			.end = res.end,
-		},
+		.size = resource_size(&res),
 	};
 	dev_dax = devm_create_dev_dax(&data);
 

