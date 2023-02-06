Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382E268B391
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 02:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBFBEI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Feb 2023 20:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBFBEH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2023 20:04:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034B8A53;
        Sun,  5 Feb 2023 17:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675645446; x=1707181446;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hrvnto86ChTGsi4fHJ4Lqo9DG2au7l7fsMPus7NStq0=;
  b=GK1gs7gjNinPobEQFOc3k1Nm8HHd2JJM9E/4bB4HdriIxfEMKG5XNFt4
   Jd5gEST7yqgEKCU9g485QmHjb1eas/X6CWWiF5J3NKnaaQCQ6Y0Usl0tH
   5Jxi0PPg6cdsoLbfgzzLaWATrN8ECoQ8FpYmIqw26RJjxotTkde0r6sEu
   JDf59wAnKEN9RTg3MmJZaKr7n5oYDm+Khup3md3v11wwwjcp6n7sO4dTd
   h2AGgKld6nS6NzNNLBqKLsmE5jpj7Qjwg0tdkFQvfRrdmFsKiG9UjglUx
   prwWkl53zzNWPOhyljA7QUOC3JSDkk1lx1AhNnLbaYpAHvjzovuJo/qNG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="309442702"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309442702"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:04:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="775006766"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="775006766"
Received: from mkrysak-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.255.187])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:04:05 -0800
Subject: [PATCH 17/18] dax: Assign RAM regions to memory-hotplug by default
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 05 Feb 2023 17:04:05 -0800
Message-ID: <167564544513.847146.4645646177864365755.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The default mode for device-dax instances is backwards for RAM-regions
as evidenced by the fact that it tends to catch end users by surprise.
"Where is my memory?". Recall that platforms are increasingly shipping
with performance-differentiated memory pools beyond typical DRAM and
NUMA effects. This includes HBM (high-bandwidth-memory) and CXL (dynamic
interleave, varied media types, and future fabric attached
possibilities).

For this reason the EFI_MEMORY_SP (EFI Special Purpose Memory => Linux
'Soft Reserved') attribute is expected to be applied to all memory-pools
that are not the general purpose pool. This designation gives an
Operating System a chance to defer usage of a memory pool until later in
the boot process where its performance properties can be interrogated
and administrator policy can be applied.

'Soft Reserved' memory can be anything from too limited and precious to
be part of the general purpose pool (HBM), too slow to host hot kernel
data structures (some PMEM media), or anything in between. However, in
the absence of an explicit policy, the memory should at least be made
usable by default. The current device-dax default hides all
non-general-purpose memory behind a device interface.

The expectation is that the distribution of users that want the memory
online by default vs device-dedicated-access by default follows the
Pareto principle. A small number of enlightened users may want to do
userspace memory management through a device, but general users just
want the kernel to make the memory available with an option to get more
advanced later.

Arrange for all device-dax instances not backed by PMEM to default to
attaching to the dax_kmem driver. From there the baseline memory hotplug
policy (CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE / memhp_default_state=)
gates whether the memory comes online or stays offline. Where, if it
stays offline, it can be reliably converted back to device-mode where it
can be partitioned, or fronted by a userspace allocator.

So, if someone wants device-dax instances for their 'Soft Reserved'
memory:

1/ Build a kernel with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n or boot
   with memhp_default_state=offline, or roll the dice and hope that the
   kernel has not pinned a page in that memory before step 2.

2/ Write a udev rule to convert the target dax device(s) from
   'system-ram' mode to 'devdax' mode:

   daxctl reconfigure-device $dax -m devdax -f

Cc: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/Kconfig     |    2 +-
 drivers/dax/bus.c       |   53 ++++++++++++++++++++---------------------------
 drivers/dax/bus.h       |   12 +++++++++--
 drivers/dax/device.c    |    3 +--
 drivers/dax/hmem/hmem.c |   12 ++++++++++-
 drivers/dax/kmem.c      |    1 +
 6 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index d13c889c2a64..1163eb62e5f6 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -50,7 +50,7 @@ config DEV_DAX_HMEM_DEVICES
 	def_bool y
 
 config DEV_DAX_KMEM
-	tristate "KMEM DAX: volatile-use of persistent memory"
+	tristate "KMEM DAX: map dax-devices as System-RAM"
 	default DEV_DAX
 	depends on DEV_DAX
 	depends on MEMORY_HOTPLUG # for add_memory() and friends
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1dad813ee4a6..012d576004e9 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -56,6 +56,25 @@ static int dax_match_id(struct dax_device_driver *dax_drv, struct device *dev)
 	return match;
 }
 
+static int dax_match_type(struct dax_device_driver *dax_drv, struct device *dev)
+{
+	enum dax_driver_type type = DAXDRV_DEVICE_TYPE;
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	if (dev_dax->region->res.flags & IORESOURCE_DAX_KMEM)
+		type = DAXDRV_KMEM_TYPE;
+
+	if (dax_drv->type == type)
+		return 1;
+
+	/* default to device mode if dax_kmem is disabled */
+	if (dax_drv->type == DAXDRV_DEVICE_TYPE &&
+	    !IS_ENABLED(CONFIG_DEV_DAX_KMEM))
+		return 1;
+
+	return 0;
+}
+
 enum id_action {
 	ID_REMOVE,
 	ID_ADD,
@@ -216,14 +235,9 @@ static int dax_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct dax_device_driver *dax_drv = to_dax_drv(drv);
 
-	/*
-	 * All but the 'device-dax' driver, which has 'match_always'
-	 * set, requires an exact id match.
-	 */
-	if (dax_drv->match_always)
+	if (dax_match_id(dax_drv, dev))
 		return 1;
-
-	return dax_match_id(dax_drv, dev);
+	return dax_match_type(dax_drv, dev);
 }
 
 /*
@@ -1413,13 +1427,10 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 }
 EXPORT_SYMBOL_GPL(devm_create_dev_dax);
 
-static int match_always_count;
-
 int __dax_driver_register(struct dax_device_driver *dax_drv,
 		struct module *module, const char *mod_name)
 {
 	struct device_driver *drv = &dax_drv->drv;
-	int rc = 0;
 
 	/*
 	 * dax_bus_probe() calls dax_drv->probe() unconditionally.
@@ -1434,26 +1445,7 @@ int __dax_driver_register(struct dax_device_driver *dax_drv,
 	drv->mod_name = mod_name;
 	drv->bus = &dax_bus_type;
 
-	/* there can only be one default driver */
-	mutex_lock(&dax_bus_lock);
-	match_always_count += dax_drv->match_always;
-	if (match_always_count > 1) {
-		match_always_count--;
-		WARN_ON(1);
-		rc = -EINVAL;
-	}
-	mutex_unlock(&dax_bus_lock);
-	if (rc)
-		return rc;
-
-	rc = driver_register(drv);
-	if (rc && dax_drv->match_always) {
-		mutex_lock(&dax_bus_lock);
-		match_always_count -= dax_drv->match_always;
-		mutex_unlock(&dax_bus_lock);
-	}
-
-	return rc;
+	return driver_register(drv);
 }
 EXPORT_SYMBOL_GPL(__dax_driver_register);
 
@@ -1463,7 +1455,6 @@ void dax_driver_unregister(struct dax_device_driver *dax_drv)
 	struct dax_id *dax_id, *_id;
 
 	mutex_lock(&dax_bus_lock);
-	match_always_count -= dax_drv->match_always;
 	list_for_each_entry_safe(dax_id, _id, &dax_drv->ids, list) {
 		list_del(&dax_id->list);
 		kfree(dax_id);
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index fbb940293d6d..8cd79ab34292 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -11,7 +11,10 @@ struct dax_device;
 struct dax_region;
 void dax_region_put(struct dax_region *dax_region);
 
-#define IORESOURCE_DAX_STATIC (1UL << 0)
+/* dax bus specific ioresource flags */
+#define IORESOURCE_DAX_STATIC BIT(0)
+#define IORESOURCE_DAX_KMEM BIT(1)
+
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct range *range, int target_node, unsigned int align,
 		unsigned long flags);
@@ -25,10 +28,15 @@ struct dev_dax_data {
 
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
 
+enum dax_driver_type {
+	DAXDRV_KMEM_TYPE,
+	DAXDRV_DEVICE_TYPE,
+};
+
 struct dax_device_driver {
 	struct device_driver drv;
 	struct list_head ids;
-	int match_always;
+	enum dax_driver_type type;
 	int (*probe)(struct dev_dax *dev);
 	void (*remove)(struct dev_dax *dev);
 };
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 5494d745ced5..ecdff79e31f2 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -475,8 +475,7 @@ EXPORT_SYMBOL_GPL(dev_dax_probe);
 
 static struct dax_device_driver device_dax_driver = {
 	.probe = dev_dax_probe,
-	/* all probe actions are unwound by devm, so .remove isn't necessary */
-	.match_always = 1,
+	.type = DAXDRV_DEVICE_TYPE,
 };
 
 static int __init dax_init(void)
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index e7bdff3132fa..5ec08f9f8a57 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -11,15 +11,25 @@ module_param_named(region_idle, region_idle, bool, 0644);
 
 static int dax_hmem_probe(struct platform_device *pdev)
 {
+	unsigned long flags = IORESOURCE_DAX_KMEM;
 	struct device *dev = &pdev->dev;
 	struct dax_region *dax_region;
 	struct memregion_info *mri;
 	struct dev_dax_data data;
 	struct dev_dax *dev_dax;
 
+	/*
+	 * @region_idle == true indicates that an administrative agent
+	 * wants to manipulate the range partitioning before the devices
+	 * are created, so do not send them to the dax_kmem driver by
+	 * default.
+	 */
+	if (region_idle)
+		flags = 0;
+
 	mri = dev->platform_data;
 	dax_region = alloc_dax_region(dev, pdev->id, &mri->range,
-				      mri->target_node, PMD_SIZE, 0);
+				      mri->target_node, PMD_SIZE, flags);
 	if (!dax_region)
 		return -ENOMEM;
 
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 4852a2dbdb27..918d01d3fbaa 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -239,6 +239,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 static struct dax_device_driver device_dax_kmem_driver = {
 	.probe = dev_dax_kmem_probe,
 	.remove = dev_dax_kmem_remove,
+	.type = DAXDRV_KMEM_TYPE,
 };
 
 static int __init dax_kmem_init(void)

