Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47DF21CA5D
	for <lists+linux-acpi@lfdr.de>; Sun, 12 Jul 2020 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgGLQnp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 12 Jul 2020 12:43:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:15526 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbgGLQnp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 12 Jul 2020 12:43:45 -0400
IronPort-SDR: wrvkP22BaAFlbIzTHjxq2MqkFeF1SwWH2xFR7tN0wsakY6EABL+SgcXQHDuxJLncIV1VLIdcIF
 N1rQP70+nWbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="128568289"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="128568289"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:37 -0700
IronPort-SDR: FKCZjifO981uKLGhA9hxcXNYYBfoLKrw8xMkVkVqXi2iigRW7uxYdErS/0fGfvHQBk2uRpsZn2
 P92mp18k+vzA==
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="281166970"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:37 -0700
Subject: [PATCH v2 14/22] device-dax: Kill dax_kmem_res
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     David Hildenbrand <david@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        peterz@infradead.org, ard.biesheuvel@linaro.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, hch@lst.de, joao.m.martins@oracle.com
Date:   Sun, 12 Jul 2020 09:27:21 -0700
Message-ID: <159457124129.754248.10028584123818131641.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Several related issues around this unneeded attribute:

- The dax_kmem_res property allows the kmem driver to stash the adjusted
  resource range that was used for the hotplug operation, but that can be
  recalculated from the original base range.

- kmem is using an open coded release_resource() + kfree() when an
  idiomatic release_mem_region() is sufficient.

- The driver managed resource need only manage the busy flag. Other flags
  are of no concern to the kmem driver. In fact if kmem inherits some
  memory range that add_memory_driver_managed() rejects that is a
  memory-hotplug-core policy that the driver is in no position to
  override.

- The implementation trusts that failed remove_memory() results in the
  entire resource range remaining pinned busy. The driver need not make
  that layering violation assumption and just maintain the busy state in
  its local resource.

- The "Hot-remove not yet implemented." comment is stale since hotremove
  support is now included.

Cc: David Hildenbrand <david@redhat.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/dax-private.h |    3 -
 drivers/dax/kmem.c        |  123 +++++++++++++++++++++------------------------
 2 files changed, 58 insertions(+), 68 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 6779f683671d..12a2dbc43b40 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -42,8 +42,6 @@ struct dax_region {
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @range: resource range for the instance
- * @dax_mem_res: physical address range of hotadded DAX memory
- * @dax_mem_name: name for hotadded DAX memory via add_memory_driver_managed()
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -52,7 +50,6 @@ struct dev_dax {
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	struct range range;
-	struct resource *dax_kmem_res;
 };
 
 static inline u64 range_len(struct range *range)
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 5bb133df147d..77e25361fbeb 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -19,16 +19,24 @@ static const char *kmem_name;
 /* Set if any memory will remain added when the driver will be unloaded. */
 static bool any_hotremove_failed;
 
+static struct range dax_kmem_range(struct dev_dax *dev_dax)
+{
+	struct range range;
+
+	/* memory-block align the hotplug range */
+	range.start = ALIGN(dev_dax->range.start, memory_block_size_bytes());
+	range.end = ALIGN_DOWN(dev_dax->range.end + 1,
+			memory_block_size_bytes()) - 1;
+	return range;
+}
+
 int dev_dax_kmem_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
-	struct range *range = &dev_dax->range;
-	resource_size_t kmem_start;
-	resource_size_t kmem_size;
-	resource_size_t kmem_end;
-	struct resource *new_res;
-	const char *new_res_name;
-	int numa_node;
+	struct range range = dax_kmem_range(dev_dax);
+	int numa_node = dev_dax->target_node;
+	struct resource *res;
+	char *res_name;
 	int rc;
 
 	/*
@@ -37,109 +45,94 @@ int dev_dax_kmem_probe(struct device *dev)
 	 * could be mixed in a node with faster memory, causing
 	 * unavoidable performance issues.
 	 */
-	numa_node = dev_dax->target_node;
 	if (numa_node < 0) {
 		dev_warn(dev, "rejecting DAX region with invalid node: %d\n",
 				numa_node);
 		return -EINVAL;
 	}
 
-	/* Hotplug starting at the beginning of the next block: */
-	kmem_start = ALIGN(range->start, memory_block_size_bytes());
-
-	kmem_size = range_len(range);
-	/* Adjust the size down to compensate for moving up kmem_start: */
-	kmem_size -= kmem_start - range->start;
-	/* Align the size down to cover only complete blocks: */
-	kmem_size &= ~(memory_block_size_bytes() - 1);
-	kmem_end = kmem_start + kmem_size;
-
-	new_res_name = kstrdup(dev_name(dev), GFP_KERNEL);
-	if (!new_res_name)
+	res_name = kstrdup(dev_name(dev), GFP_KERNEL);
+	if (!res_name)
 		return -ENOMEM;
 
-	/* Region is permanently reserved if hotremove fails. */
-	new_res = request_mem_region(kmem_start, kmem_size, new_res_name);
-	if (!new_res) {
-		dev_warn(dev, "could not reserve region [%pa-%pa]\n",
-			 &kmem_start, &kmem_end);
-		kfree(new_res_name);
+	res = request_mem_region(range.start, range_len(&range), res_name);
+	if (!res) {
+		dev_warn(dev, "could not reserve region [%#llx-%#llx]\n",
+				range.start, range.end);
+		kfree(res_name);
 		return -EBUSY;
 	}
 
 	/*
-	 * Set flags appropriate for System RAM.  Leave ..._BUSY clear
-	 * so that add_memory() can add a child resource.  Do not
-	 * inherit flags from the parent since it may set new flags
-	 * unknown to us that will break add_memory() below.
+	 * Temporarily clear busy to allow add_memory_driver_managed()
+	 * to claim it.
 	 */
-	new_res->flags = IORESOURCE_SYSTEM_RAM;
+	res->flags &= ~IORESOURCE_BUSY;
 
 	/*
 	 * Ensure that future kexec'd kernels will not treat this as RAM
 	 * automatically.
 	 */
-	rc = add_memory_driver_managed(numa_node, new_res->start,
-				       resource_size(new_res), kmem_name);
+	rc = add_memory_driver_managed(numa_node, res->start,
+				       resource_size(res), kmem_name);
+
+	res->flags |= IORESOURCE_BUSY;
 	if (rc) {
-		release_resource(new_res);
-		kfree(new_res);
-		kfree(new_res_name);
+		release_mem_region(range.start, range_len(&range));
+		kfree(res_name);
 		return rc;
 	}
-	dev_dax->dax_kmem_res = new_res;
+
+	dev_set_drvdata(dev, res_name);
 
 	return 0;
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-static int dev_dax_kmem_remove(struct device *dev)
+static void dax_kmem_release(struct dev_dax *dev_dax)
 {
-	struct dev_dax *dev_dax = to_dev_dax(dev);
-	struct resource *res = dev_dax->dax_kmem_res;
-	resource_size_t kmem_start = res->start;
-	resource_size_t kmem_size = resource_size(res);
-	const char *res_name = res->name;
 	int rc;
+	struct device *dev = &dev_dax->dev;
+	const char *res_name = dev_get_drvdata(dev);
+	struct range range = dax_kmem_range(dev_dax);
 
 	/*
 	 * We have one shot for removing memory, if some memory blocks were not
 	 * offline prior to calling this function remove_memory() will fail, and
 	 * there is no way to hotremove this memory until reboot because device
-	 * unbind will succeed even if we return failure.
+	 * unbind will proceed regardless of the remove_memory result.
 	 */
-	rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
-	if (rc) {
-		any_hotremove_failed = true;
-		dev_err(dev,
-			"DAX region %pR cannot be hotremoved until the next reboot\n",
-			res);
-		return rc;
+	rc = remove_memory(dev_dax->target_node, range.start, range_len(&range));
+	if (rc == 0) {
+		release_mem_region(range.start, range_len(&range));
+		dev_set_drvdata(dev, NULL);
+		kfree(res_name);
+		return;
 	}
 
-	/* Release and free dax resources */
-	release_resource(res);
-	kfree(res);
-	kfree(res_name);
-	dev_dax->dax_kmem_res = NULL;
-
-	return 0;
+	any_hotremove_failed = true;
+	dev_err(dev, "%#llx-%#llx cannot be hotremoved until the next reboot\n",
+			range.start, range.end);
 }
 #else
-static int dev_dax_kmem_remove(struct device *dev)
+static void dax_kmem_release(struct dev_dax *dev_dax)
 {
 	/*
-	 * Without hotremove purposely leak the request_mem_region() for the
-	 * device-dax range and return '0' to ->remove() attempts. The removal
-	 * of the device from the driver always succeeds, but the region is
-	 * permanently pinned as reserved by the unreleased
-	 * request_mem_region().
+	 * Without hotremove purposely leak the request_mem_region() for
+	 * the device-dax range attempts. The removal of the device from
+	 * the driver always succeeds, but the region is permanently
+	 * pinned as reserved by the unreleased request_mem_region().
 	 */
 	any_hotremove_failed = true;
-	return 0;
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+static int dev_dax_kmem_remove(struct device *dev)
+{
+	dax_kmem_release(to_dev_dax(dev));
+	return 0;
+}
+
 static struct dax_device_driver device_dax_kmem_driver = {
 	.drv = {
 		.probe = dev_dax_kmem_probe,

