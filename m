Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9CE235012
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Aug 2020 05:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgHADnQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 23:43:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:8430 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbgHADnM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jul 2020 23:43:12 -0400
IronPort-SDR: Mo1AEipH/blch6RF6xW0BSrHAOcSYPP/fR5KpET5Sfj1yfn6P5Yp7gnCQvlXKjYlSdiAC/53dY
 1jcpZtYeouJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="170007872"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="scan'208";a="170007872"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 20:43:04 -0700
IronPort-SDR: 7E5hiQGXi1wg7EzVW7KVmRjtJGsT/WH6Qn3d6tP1m9+AyPi7IGh5IurEx3OmHrEN/Oipchjjza
 Knee+U7QbJ1w==
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="scan'208";a="273435046"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 20:43:03 -0700
Subject: [PATCH v3 19/23] device-dax: Introduce 'mapping' devices
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>, peterz@infradead.org,
        dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org,
        vishal.l.verma@intel.com, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, joao.m.martins@oracle.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Date:   Fri, 31 Jul 2020 20:26:45 -0700
Message-ID: <159625240523.3040297.5572845408401158731.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In support of interrogating the physical address layout of a device with
dis-contiguous ranges, introduce a sysfs directory with 'start', 'end',
and 'page_offset' attributes. The alternative is trying to parse
/proc/iomem, and that file will not reflect the extent layout until the
device is enabled.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c         |  191 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dax/dax-private.h |   14 +++
 2 files changed, 203 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index f342e36c69a1..ffb27964deb2 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -579,6 +579,167 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 }
 EXPORT_SYMBOL_GPL(alloc_dax_region);
 
+static void dax_mapping_release(struct device *dev)
+{
+	struct dax_mapping *mapping = to_dax_mapping(dev);
+	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
+
+	ida_free(&dev_dax->ida, mapping->id);
+	kfree(mapping);
+}
+
+static void unregister_dax_mapping(void *data)
+{
+	struct device *dev = data;
+	struct dax_mapping *mapping = to_dax_mapping(dev);
+	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
+	struct dax_region *dax_region = dev_dax->region;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	device_lock_assert(dax_region->dev);
+
+	dev_dax->ranges[mapping->range_id].mapping = NULL;
+	mapping->range_id = -1;
+
+	device_del(dev);
+	put_device(dev);
+}
+
+static struct dev_dax_range *get_dax_range(struct device *dev)
+{
+	struct dax_mapping *mapping = to_dax_mapping(dev);
+	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
+	struct dax_region *dax_region = dev_dax->region;
+
+	device_lock(dax_region->dev);
+	if (mapping->range_id < 0) {
+		device_unlock(dax_region->dev);
+		return NULL;
+	}
+
+	return &dev_dax->ranges[mapping->range_id];
+}
+
+static void put_dax_range(struct dev_dax_range *dax_range)
+{
+	struct dax_mapping *mapping = dax_range->mapping;
+	struct dev_dax *dev_dax = to_dev_dax(mapping->dev.parent);
+	struct dax_region *dax_region = dev_dax->region;
+
+	device_unlock(dax_region->dev);
+}
+
+static ssize_t start_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dev_dax_range *dax_range;
+	ssize_t rc;
+
+	dax_range = get_dax_range(dev);
+	if (!dax_range)
+		return -ENXIO;
+	rc = sprintf(buf, "%#llx\n", dax_range->range.start);
+	put_dax_range(dax_range);
+
+	return rc;
+}
+static DEVICE_ATTR(start, 0400, start_show, NULL);
+
+static ssize_t end_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dev_dax_range *dax_range;
+	ssize_t rc;
+
+	dax_range = get_dax_range(dev);
+	if (!dax_range)
+		return -ENXIO;
+	rc = sprintf(buf, "%#llx\n", dax_range->range.end);
+	put_dax_range(dax_range);
+
+	return rc;
+}
+static DEVICE_ATTR(end, 0400, end_show, NULL);
+
+static ssize_t pgoff_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dev_dax_range *dax_range;
+	ssize_t rc;
+
+	dax_range = get_dax_range(dev);
+	if (!dax_range)
+		return -ENXIO;
+	rc = sprintf(buf, "%#lx\n", dax_range->pgoff);
+	put_dax_range(dax_range);
+
+	return rc;
+}
+static DEVICE_ATTR(page_offset, 0400, pgoff_show, NULL);
+
+static struct attribute *dax_mapping_attributes[] = {
+	&dev_attr_start.attr,
+	&dev_attr_end.attr,
+	&dev_attr_page_offset.attr,
+	NULL,
+};
+
+static const struct attribute_group dax_mapping_attribute_group = {
+	.attrs = dax_mapping_attributes,
+};
+
+static const struct attribute_group *dax_mapping_attribute_groups[] = {
+	&dax_mapping_attribute_group,
+	NULL,
+};
+
+static struct device_type dax_mapping_type = {
+	.release = dax_mapping_release,
+	.groups = dax_mapping_attribute_groups,
+};
+
+static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
+{
+	struct dax_region *dax_region = dev_dax->region;
+	struct dax_mapping *mapping;
+	struct device *dev;
+	int rc;
+
+	device_lock_assert(dax_region->dev);
+
+	if (dev_WARN_ONCE(&dev_dax->dev, !dax_region->dev->driver,
+				"region disabled\n"))
+		return -ENXIO;
+
+	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
+	if (!mapping)
+		return -ENOMEM;
+	mapping->range_id = range_id;
+	mapping->id = ida_alloc(&dev_dax->ida, GFP_KERNEL);
+	if (mapping->id < 0) {
+		kfree(mapping);
+		return -ENOMEM;
+	}
+	dev_dax->ranges[range_id].mapping = mapping;
+	dev = &mapping->dev;
+	device_initialize(dev);
+	dev->parent = &dev_dax->dev;
+	dev->type = &dax_mapping_type;
+	dev_set_name(dev, "mapping%d", mapping->id);
+	rc = device_add(dev);
+	if (rc) {
+		put_device(dev);
+		return rc;
+	}
+
+	rc = devm_add_action_or_reset(dax_region->dev, unregister_dax_mapping,
+			dev);
+	if (rc)
+		return rc;
+	return 0;
+}
+
 static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		resource_size_t size)
 {
@@ -588,7 +749,7 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 	struct dev_dax_range *ranges;
 	unsigned long pgoff = 0;
 	struct resource *alloc;
-	int i;
+	int i, rc;
 
 	device_lock_assert(dax_region->dev);
 
@@ -630,6 +791,22 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 
 	dev_dbg(dev, "alloc range[%d]: %pa:%pa\n", dev_dax->nr_range - 1,
 			&alloc->start, &alloc->end);
+	/*
+	 * A dev_dax instance must be registered before mapping device
+	 * children can be added. Defer to devm_create_dev_dax() to add
+	 * the initial mapping device.
+	 */
+	if (!device_is_registered(&dev_dax->dev))
+		return 0;
+
+	rc = devm_register_dax_mapping(dev_dax, dev_dax->nr_range - 1);
+	if (rc) {
+		dev_dbg(dev, "delete range[%d]: %pa:%pa\n", dev_dax->nr_range - 1,
+				&alloc->start, &alloc->end);
+		dev_dax->nr_range--;
+		__release_region(res, alloc->start, resource_size(alloc));
+		return rc;
+	}
 
 	return 0;
 }
@@ -698,11 +875,14 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 
 	for (i = dev_dax->nr_range - 1; i >= 0; i--) {
 		struct range *range = &dev_dax->ranges[i].range;
+		struct dax_mapping *mapping = dev_dax->ranges[i].mapping;
 		struct resource *adjust = NULL, *res;
 		resource_size_t shrink;
 
 		shrink = min(to_shrink, range_len(range));
 		if (shrink >= range_len(range)) {
+			devm_release_action(dax_region->dev,
+					unregister_dax_mapping, &mapping->dev);
 			__release_region(&dax_region->res, range->start,
 					range_len(range));
 			dev_dax->nr_range--;
@@ -1033,9 +1213,9 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	/* a device_dax instance is dead while the driver is not attached */
 	kill_dax(dax_dev);
 
-	/* from here on we're committed to teardown via dev_dax_release() */
 	dev_dax->dax_dev = dax_dev;
 	dev_dax->target_node = dax_region->target_node;
+	ida_init(&dev_dax->ida);
 	kref_get(&dax_region->kref);
 
 	inode = dax_inode(dax_dev);
@@ -1058,6 +1238,13 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	if (rc)
 		return ERR_PTR(rc);
 
+	/* register mapping device for the initial allocation range */
+	if (dev_dax->nr_range && range_len(&dev_dax->ranges[0].range)) {
+		rc = devm_register_dax_mapping(dev_dax, 0);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
 	return dev_dax;
 
 err_alloc_dax:
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index f863287107fd..13780f62b95e 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -40,6 +40,12 @@ struct dax_region {
 	struct device *youngest;
 };
 
+struct dax_mapping {
+	struct device dev;
+	int range_id;
+	int id;
+};
+
 /**
  * struct dev_dax - instance data for a subdivision of a dax region, and
  * data while the device is activated in the driver.
@@ -47,6 +53,7 @@ struct dax_region {
  * @dax_dev - core dax functionality
  * @target_node: effective numa node if dev_dax memory range is onlined
  * @id: ida allocated id
+ * @ida: mapping id allocator
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @nr_range: size of @ranges
@@ -57,12 +64,14 @@ struct dev_dax {
 	struct dax_device *dax_dev;
 	int target_node;
 	int id;
+	struct ida ida;
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	int nr_range;
 	struct dev_dax_range {
 		unsigned long pgoff;
 		struct range range;
+		struct dax_mapping *mapping;
 	} *ranges;
 };
 
@@ -70,4 +79,9 @@ static inline struct dev_dax *to_dev_dax(struct device *dev)
 {
 	return container_of(dev, struct dev_dax, dev);
 }
+
+static inline struct dax_mapping *to_dax_mapping(struct device *dev)
+{
+	return container_of(dev, struct dax_mapping, dev);
+}
 #endif

