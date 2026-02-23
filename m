Return-Path: <linux-acpi+bounces-21090-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAzkEWTAnGmgKAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21090-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 22:02:28 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C07717D51A
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 22:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CB1D31123AF
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04C37E313;
	Mon, 23 Feb 2026 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uwjhvzfh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D353793DF;
	Mon, 23 Feb 2026 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879473; cv=none; b=QFF1PA40nGXNxoYu8vGWkpdXAtBF9n25Yv00U+jshcVvVJEGx2YZ8IyKHXdnBMotG9doREQM5gWZUV9Gguh80zOujfh/GIKbUeKO3VCqoSZWqUwWB4Y2zV2oJ8Wsa8e+e4WIRkLEqWItCysM1/rVXs5dlzpzpytWoRhIIMfdK1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879473; c=relaxed/simple;
	bh=yOA9/XoSliMWNDOOTgdllDVYF/k5+8IX95ojbWvVOu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fh8Dr0bRPrvpFh84wnXZ+S9yFf2js6Wl58Fx3qAs0MzxD2HxIrGZkWGNmc+HjloGMpzHRYJ+iQtjMoxQIrO7zNULsWneoFbNGuJyqY8Q8dIp5m7e+N6w2m+rhHlL/u1MRELjDAkdbZXfdh7RNxVMnxi+25p/9SPXSaCUj5I1TSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uwjhvzfh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771879463; x=1803415463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOA9/XoSliMWNDOOTgdllDVYF/k5+8IX95ojbWvVOu0=;
  b=UwjhvzfhEpa20QIWwZw2/vbraynbEqcXjfzv69r47nYKcawLf4ItXVfk
   WomcKbJu5M/4BsI3nzMjXTSbLGY8JX2Z7a3AcXw7HlhnOApDDYZxFVTck
   fw6Y1t5R4kH8oCqzqR3xieEz1QSqfHAx2QxYbTcy7lDZPUFYk6wLvoc+h
   mkGlPgoCrMAWI9X49xWU43tdVqruDHMnoPgAfZoaBCV5u0GXEES1Jj6o0
   G2mtDwhrM1U86qHLDzf09nwzojMjSrpqxYrn4yjiqiEcQEBUJbQwF7j6O
   vJW2FfPBnkWOl7JI4zxXlL1Mk9pIDis/MNycQCGTEJp5cq0mva2wkMOqv
   w==;
X-CSE-ConnectionGUID: K/KyzbrzSFWhtbI85K102w==
X-CSE-MsgGUID: uvs1gvhbSh+4VBRclk5+5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="84248987"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="84248987"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 12:44:22 -0800
X-CSE-ConnectionGUID: jJuhtN2kRnWXbRAOZLQIOw==
X-CSE-MsgGUID: 2aO/rK0+Q++GVPNfoQOOrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="213571105"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 23 Feb 2026 12:44:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 317B698; Mon, 23 Feb 2026 21:44:18 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 1/3] driver core: Split device data types to device/types.h
Date: Mon, 23 Feb 2026 21:30:30 +0100
Message-ID: <20260223204412.3298508-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21090-lists,linux-acpi=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 6C07717D51A
X-Rspamd-Action: no action

device.h is a huge header which is hard to follow and easy to miss
something. Improve that by splitting device data types to device/types.h.

In particular this helps to speedup the build of the code that includes
device.h solely for a device data types.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/device.h       | 395 +--------------------------------
 include/linux/device/types.h | 415 +++++++++++++++++++++++++++++++++++
 2 files changed, 416 insertions(+), 394 deletions(-)
 create mode 100644 include/linux/device/types.h

diff --git a/include/linux/device.h b/include/linux/device.h
index 0be95294b6e6..8c85ee363567 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -30,22 +30,15 @@
 #include <linux/device/class.h>
 #include <linux/device/devres.h>
 #include <linux/device/driver.h>
+#include <linux/device/types.h>
 #include <linux/cleanup.h>
-#include <asm/device.h>
 
-struct device;
-struct device_private;
 struct device_driver;
-struct driver_private;
 struct module;
 struct class;
 struct subsys_private;
 struct device_node;
 struct fwnode_handle;
-struct iommu_group;
-struct dev_pin_info;
-struct dev_iommu;
-struct msi_device_data;
 
 /**
  * struct subsys_interface - interfaces to device functions
@@ -76,26 +69,6 @@ int subsys_system_register(const struct bus_type *subsys,
 int subsys_virtual_register(const struct bus_type *subsys,
 			    const struct attribute_group **groups);
 
-/*
- * The type of device, "struct device" is embedded in. A class
- * or bus can contain devices of different types
- * like "partitions" and "disks", "mouse" and "event".
- * This identifies the device type and carries type-specific
- * information, equivalent to the kobj_type of a kobject.
- * If "name" is specified, the uevent will contain it in
- * the DEVTYPE variable.
- */
-struct device_type {
-	const char *name;
-	const struct attribute_group **groups;
-	int (*uevent)(const struct device *dev, struct kobj_uevent_env *env);
-	char *(*devnode)(const struct device *dev, umode_t *mode,
-			 kuid_t *uid, kgid_t *gid);
-	void (*release)(struct device *dev);
-
-	const struct dev_pm_ops *pm;
-};
-
 /**
  * struct device_attribute - Interface for exporting device attributes.
  * @attr: sysfs attribute definition.
@@ -281,16 +254,6 @@ int __must_check device_create_bin_file(struct device *dev,
 void device_remove_bin_file(struct device *dev,
 			    const struct bin_attribute *attr);
 
-struct device_dma_parameters {
-	/*
-	 * a low level driver may set these to teach IOMMU code about
-	 * sg limitations.
-	 */
-	unsigned int max_segment_size;
-	unsigned int min_align_mask;
-	unsigned long segment_boundary_mask;
-};
-
 /**
  * enum device_link_state - Device link states.
  * @DL_STATE_NONE: The presence of the drivers is not being tracked.
@@ -333,344 +296,6 @@ enum device_link_state {
 #define DL_FLAG_INFERRED		BIT(8)
 #define DL_FLAG_CYCLE			BIT(9)
 
-/**
- * enum dl_dev_state - Device driver presence tracking information.
- * @DL_DEV_NO_DRIVER: There is no driver attached to the device.
- * @DL_DEV_PROBING: A driver is probing.
- * @DL_DEV_DRIVER_BOUND: The driver has been bound to the device.
- * @DL_DEV_UNBINDING: The driver is unbinding from the device.
- */
-enum dl_dev_state {
-	DL_DEV_NO_DRIVER = 0,
-	DL_DEV_PROBING,
-	DL_DEV_DRIVER_BOUND,
-	DL_DEV_UNBINDING,
-};
-
-/**
- * enum device_removable - Whether the device is removable. The criteria for a
- * device to be classified as removable is determined by its subsystem or bus.
- * @DEVICE_REMOVABLE_NOT_SUPPORTED: This attribute is not supported for this
- *				    device (default).
- * @DEVICE_REMOVABLE_UNKNOWN:  Device location is Unknown.
- * @DEVICE_FIXED: Device is not removable by the user.
- * @DEVICE_REMOVABLE: Device is removable by the user.
- */
-enum device_removable {
-	DEVICE_REMOVABLE_NOT_SUPPORTED = 0, /* must be 0 */
-	DEVICE_REMOVABLE_UNKNOWN,
-	DEVICE_FIXED,
-	DEVICE_REMOVABLE,
-};
-
-/**
- * struct dev_links_info - Device data related to device links.
- * @suppliers: List of links to supplier devices.
- * @consumers: List of links to consumer devices.
- * @defer_sync: Hook to global list of devices that have deferred sync_state.
- * @status: Driver status information.
- */
-struct dev_links_info {
-	struct list_head suppliers;
-	struct list_head consumers;
-	struct list_head defer_sync;
-	enum dl_dev_state status;
-};
-
-/**
- * struct dev_msi_info - Device data related to MSI
- * @domain:	The MSI interrupt domain associated to the device
- * @data:	Pointer to MSI device data
- */
-struct dev_msi_info {
-#ifdef CONFIG_GENERIC_MSI_IRQ
-	struct irq_domain	*domain;
-	struct msi_device_data	*data;
-#endif
-};
-
-/**
- * enum device_physical_location_panel - Describes which panel surface of the
- * system's housing the device connection point resides on.
- * @DEVICE_PANEL_TOP: Device connection point is on the top panel.
- * @DEVICE_PANEL_BOTTOM: Device connection point is on the bottom panel.
- * @DEVICE_PANEL_LEFT: Device connection point is on the left panel.
- * @DEVICE_PANEL_RIGHT: Device connection point is on the right panel.
- * @DEVICE_PANEL_FRONT: Device connection point is on the front panel.
- * @DEVICE_PANEL_BACK: Device connection point is on the back panel.
- * @DEVICE_PANEL_UNKNOWN: The panel with device connection point is unknown.
- */
-enum device_physical_location_panel {
-	DEVICE_PANEL_TOP,
-	DEVICE_PANEL_BOTTOM,
-	DEVICE_PANEL_LEFT,
-	DEVICE_PANEL_RIGHT,
-	DEVICE_PANEL_FRONT,
-	DEVICE_PANEL_BACK,
-	DEVICE_PANEL_UNKNOWN,
-};
-
-/**
- * enum device_physical_location_vertical_position - Describes vertical
- * position of the device connection point on the panel surface.
- * @DEVICE_VERT_POS_UPPER: Device connection point is at upper part of panel.
- * @DEVICE_VERT_POS_CENTER: Device connection point is at center part of panel.
- * @DEVICE_VERT_POS_LOWER: Device connection point is at lower part of panel.
- */
-enum device_physical_location_vertical_position {
-	DEVICE_VERT_POS_UPPER,
-	DEVICE_VERT_POS_CENTER,
-	DEVICE_VERT_POS_LOWER,
-};
-
-/**
- * enum device_physical_location_horizontal_position - Describes horizontal
- * position of the device connection point on the panel surface.
- * @DEVICE_HORI_POS_LEFT: Device connection point is at left part of panel.
- * @DEVICE_HORI_POS_CENTER: Device connection point is at center part of panel.
- * @DEVICE_HORI_POS_RIGHT: Device connection point is at right part of panel.
- */
-enum device_physical_location_horizontal_position {
-	DEVICE_HORI_POS_LEFT,
-	DEVICE_HORI_POS_CENTER,
-	DEVICE_HORI_POS_RIGHT,
-};
-
-/**
- * struct device_physical_location - Device data related to physical location
- * of the device connection point.
- * @panel: Panel surface of the system's housing that the device connection
- *         point resides on.
- * @vertical_position: Vertical position of the device connection point within
- *                     the panel.
- * @horizontal_position: Horizontal position of the device connection point
- *                       within the panel.
- * @dock: Set if the device connection point resides in a docking station or
- *        port replicator.
- * @lid: Set if this device connection point resides on the lid of laptop
- *       system.
- */
-struct device_physical_location {
-	enum device_physical_location_panel panel;
-	enum device_physical_location_vertical_position vertical_position;
-	enum device_physical_location_horizontal_position horizontal_position;
-	bool dock;
-	bool lid;
-};
-
-/**
- * struct device - The basic device structure
- * @parent:	The device's "parent" device, the device to which it is attached.
- * 		In most cases, a parent device is some sort of bus or host
- * 		controller. If parent is NULL, the device, is a top-level device,
- * 		which is not usually what you want.
- * @p:		Holds the private data of the driver core portions of the device.
- * 		See the comment of the struct device_private for detail.
- * @kobj:	A top-level, abstract class from which other classes are derived.
- * @init_name:	Initial name of the device.
- * @type:	The type of device.
- * 		This identifies the device type and carries type-specific
- * 		information.
- * @mutex:	Mutex to synchronize calls to its driver.
- * @bus:	Type of bus device is on.
- * @driver:	Which driver has allocated this
- * @platform_data: Platform data specific to the device.
- * 		Example: For devices on custom boards, as typical of embedded
- * 		and SOC based hardware, Linux often uses platform_data to point
- * 		to board-specific structures describing devices and how they
- * 		are wired.  That can include what ports are available, chip
- * 		variants, which GPIO pins act in what additional roles, and so
- * 		on.  This shrinks the "Board Support Packages" (BSPs) and
- * 		minimizes board-specific #ifdefs in drivers.
- * @driver_data: Private pointer for driver specific info.
- * @links:	Links to suppliers and consumers of this device.
- * @power:	For device power management.
- *		See Documentation/driver-api/pm/devices.rst for details.
- * @pm_domain:	Provide callbacks that are executed during system suspend,
- * 		hibernation, system resume and during runtime PM transitions
- * 		along with subsystem-level and driver-level callbacks.
- * @em_pd:	device's energy model performance domain
- * @pins:	For device pin management.
- *		See Documentation/driver-api/pin-control.rst for details.
- * @msi:	MSI related data
- * @numa_node:	NUMA node this device is close to.
- * @dma_ops:    DMA mapping operations for this device.
- * @dma_mask:	Dma mask (if dma'ble device).
- * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
- * 		hardware supports 64-bit addresses for consistent allocations
- * 		such descriptors.
- * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
- *		DMA limit than the device itself supports.
- * @dma_range_map: map for DMA memory ranges relative to that of RAM
- * @dma_parms:	A low level driver may set these to teach IOMMU code about
- * 		segment limitations.
- * @dma_pools:	Dma pools (if dma'ble device).
- * @dma_mem:	Internal for coherent mem override.
- * @cma_area:	Contiguous memory area for dma allocations
- * @dma_io_tlb_mem: Software IO TLB allocator.  Not for driver use.
- * @dma_io_tlb_pools:	List of transient swiotlb memory pools.
- * @dma_io_tlb_lock:	Protects changes to the list of active pools.
- * @dma_uses_io_tlb: %true if device has used the software IO TLB.
- * @archdata:	For arch-specific additions.
- * @of_node:	Associated device tree node.
- * @fwnode:	Associated device node supplied by platform firmware.
- * @devt:	For creating the sysfs "dev".
- * @id:		device instance
- * @devres_lock: Spinlock to protect the resource of the device.
- * @devres_head: The resources list of the device.
- * @class:	The class of the device.
- * @groups:	Optional attribute groups.
- * @release:	Callback to free the device after all references have
- * 		gone away. This should be set by the allocator of the
- * 		device (i.e. the bus driver that discovered the device).
- * @iommu_group: IOMMU group the device belongs to.
- * @iommu:	Per device generic IOMMU runtime data
- * @physical_location: Describes physical location of the device connection
- *		point in the system housing.
- * @removable:  Whether the device can be removed from the system. This
- *              should be set by the subsystem / bus driver that discovered
- *              the device.
- *
- * @offline_disabled: If set, the device is permanently online.
- * @offline:	Set after successful invocation of bus type's .offline().
- * @of_node_reused: Set if the device-tree node is shared with an ancestor
- *              device.
- * @state_synced: The hardware state of this device has been synced to match
- *		  the software state of this device by calling the driver/bus
- *		  sync_state() callback.
- * @can_match:	The device has matched with a driver at least once or it is in
- *		a bus (like AMBA) which can't check for matching drivers until
- *		other devices probe successfully.
- * @dma_coherent: this particular device is dma coherent, even if the
- *		architecture supports non-coherent devices.
- * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
- *		streaming DMA operations (->map_* / ->unmap_* / ->sync_*),
- *		and optionall (if the coherent mask is large enough) also
- *		for dma allocations.  This flag is managed by the dma ops
- *		instance from ->dma_supported.
- * @dma_skip_sync: DMA sync operations can be skipped for coherent buffers.
- * @dma_iommu: Device is using default IOMMU implementation for DMA and
- *		doesn't rely on dma_ops structure.
- *
- * At the lowest level, every device in a Linux system is represented by an
- * instance of struct device. The device structure contains the information
- * that the device model core needs to model the system. Most subsystems,
- * however, track additional information about the devices they host. As a
- * result, it is rare for devices to be represented by bare device structures;
- * instead, that structure, like kobject structures, is usually embedded within
- * a higher-level representation of the device.
- */
-struct device {
-	struct kobject kobj;
-	struct device		*parent;
-
-	struct device_private	*p;
-
-	const char		*init_name; /* initial name of the device */
-	const struct device_type *type;
-
-	const struct bus_type	*bus;	/* type of bus device is on */
-	struct device_driver *driver;	/* which driver has allocated this
-					   device */
-	void		*platform_data;	/* Platform specific data, device
-					   core doesn't touch it */
-	void		*driver_data;	/* Driver data, set and get with
-					   dev_set_drvdata/dev_get_drvdata */
-	struct mutex		mutex;	/* mutex to synchronize calls to
-					 * its driver.
-					 */
-
-	struct dev_links_info	links;
-	struct dev_pm_info	power;
-	struct dev_pm_domain	*pm_domain;
-
-#ifdef CONFIG_ENERGY_MODEL
-	struct em_perf_domain	*em_pd;
-#endif
-
-#ifdef CONFIG_PINCTRL
-	struct dev_pin_info	*pins;
-#endif
-	struct dev_msi_info	msi;
-#ifdef CONFIG_ARCH_HAS_DMA_OPS
-	const struct dma_map_ops *dma_ops;
-#endif
-	u64		*dma_mask;	/* dma mask (if dma'able device) */
-	u64		coherent_dma_mask;/* Like dma_mask, but for
-					     alloc_coherent mappings as
-					     not all hardware supports
-					     64 bit addresses for consistent
-					     allocations such descriptors. */
-	u64		bus_dma_limit;	/* upstream dma constraint */
-	const struct bus_dma_region *dma_range_map;
-
-	struct device_dma_parameters *dma_parms;
-
-	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
-
-#ifdef CONFIG_DMA_DECLARE_COHERENT
-	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
-					     override */
-#endif
-#ifdef CONFIG_DMA_CMA
-	struct cma *cma_area;		/* contiguous memory area for dma
-					   allocations */
-#endif
-#ifdef CONFIG_SWIOTLB
-	struct io_tlb_mem *dma_io_tlb_mem;
-#endif
-#ifdef CONFIG_SWIOTLB_DYNAMIC
-	struct list_head dma_io_tlb_pools;
-	spinlock_t dma_io_tlb_lock;
-	bool dma_uses_io_tlb;
-#endif
-	/* arch specific additions */
-	struct dev_archdata	archdata;
-
-	struct device_node	*of_node; /* associated device tree node */
-	struct fwnode_handle	*fwnode; /* firmware device node */
-
-#ifdef CONFIG_NUMA
-	int		numa_node;	/* NUMA node this device is close to */
-#endif
-	dev_t			devt;	/* dev_t, creates the sysfs "dev" */
-	u32			id;	/* device instance */
-
-	spinlock_t		devres_lock;
-	struct list_head	devres_head;
-
-	const struct class	*class;
-	const struct attribute_group **groups;	/* optional groups */
-
-	void	(*release)(struct device *dev);
-	struct iommu_group	*iommu_group;
-	struct dev_iommu	*iommu;
-
-	struct device_physical_location *physical_location;
-
-	enum device_removable	removable;
-
-	bool			offline_disabled:1;
-	bool			offline:1;
-	bool			of_node_reused:1;
-	bool			state_synced:1;
-	bool			can_match:1;
-#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
-    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
-    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
-	bool			dma_coherent:1;
-#endif
-#ifdef CONFIG_DMA_OPS_BYPASS
-	bool			dma_ops_bypass : 1;
-#endif
-#ifdef CONFIG_DMA_NEED_SYNC
-	bool			dma_skip_sync:1;
-#endif
-#ifdef CONFIG_IOMMU_DMA
-	bool			dma_iommu:1;
-#endif
-};
-
 /**
  * struct device_link - Device link representation.
  * @supplier: The device on the supplier end of the link.
@@ -699,8 +324,6 @@ struct device_link {
 	bool supplier_preactivated; /* Owned by consumer probe. */
 };
 
-#define kobj_to_dev(__kobj)	container_of_const(__kobj, struct device, kobj)
-
 /**
  * device_iommu_mapped - Returns true when the device DMA is translated
  *			 by an IOMMU
@@ -761,22 +384,6 @@ static inline void set_dev_node(struct device *dev, int node)
 }
 #endif
 
-static inline struct irq_domain *dev_get_msi_domain(const struct device *dev)
-{
-#ifdef CONFIG_GENERIC_MSI_IRQ
-	return dev->msi.domain;
-#else
-	return NULL;
-#endif
-}
-
-static inline void dev_set_msi_domain(struct device *dev, struct irq_domain *d)
-{
-#ifdef CONFIG_GENERIC_MSI_IRQ
-	dev->msi.domain = d;
-#endif
-}
-
 static inline void *dev_get_drvdata(const struct device *dev)
 {
 	return dev->driver_data;
diff --git a/include/linux/device/types.h b/include/linux/device/types.h
new file mode 100644
index 000000000000..569a7f0613e6
--- /dev/null
+++ b/include/linux/device/types.h
@@ -0,0 +1,415 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DEVICE_TYPES_H_
+#define _DEVICE_TYPES_H_
+
+#include <linux/container_of.h>
+#include <linux/kobject.h>
+#include <linux/mutex_types.h>
+#include <linux/pm.h>
+#include <linux/spinlock_types.h>
+#include <linux/types.h>
+#include <linux/uidgid_types.h>
+
+#include <asm/device.h>
+
+/**
+ * enum device_physical_location_panel - Describes which panel surface of the
+ * system's housing the device connection point resides on.
+ * @DEVICE_PANEL_TOP: Device connection point is on the top panel.
+ * @DEVICE_PANEL_BOTTOM: Device connection point is on the bottom panel.
+ * @DEVICE_PANEL_LEFT: Device connection point is on the left panel.
+ * @DEVICE_PANEL_RIGHT: Device connection point is on the right panel.
+ * @DEVICE_PANEL_FRONT: Device connection point is on the front panel.
+ * @DEVICE_PANEL_BACK: Device connection point is on the back panel.
+ * @DEVICE_PANEL_UNKNOWN: The panel with device connection point is unknown.
+ */
+enum device_physical_location_panel {
+	DEVICE_PANEL_TOP,
+	DEVICE_PANEL_BOTTOM,
+	DEVICE_PANEL_LEFT,
+	DEVICE_PANEL_RIGHT,
+	DEVICE_PANEL_FRONT,
+	DEVICE_PANEL_BACK,
+	DEVICE_PANEL_UNKNOWN,
+};
+
+/**
+ * enum device_physical_location_vertical_position - Describes vertical
+ * position of the device connection point on the panel surface.
+ * @DEVICE_VERT_POS_UPPER: Device connection point is at upper part of panel.
+ * @DEVICE_VERT_POS_CENTER: Device connection point is at center part of panel.
+ * @DEVICE_VERT_POS_LOWER: Device connection point is at lower part of panel.
+ */
+enum device_physical_location_vertical_position {
+	DEVICE_VERT_POS_UPPER,
+	DEVICE_VERT_POS_CENTER,
+	DEVICE_VERT_POS_LOWER,
+};
+
+/**
+ * enum device_physical_location_horizontal_position - Describes horizontal
+ * position of the device connection point on the panel surface.
+ * @DEVICE_HORI_POS_LEFT: Device connection point is at left part of panel.
+ * @DEVICE_HORI_POS_CENTER: Device connection point is at center part of panel.
+ * @DEVICE_HORI_POS_RIGHT: Device connection point is at right part of panel.
+ */
+enum device_physical_location_horizontal_position {
+	DEVICE_HORI_POS_LEFT,
+	DEVICE_HORI_POS_CENTER,
+	DEVICE_HORI_POS_RIGHT,
+};
+
+/**
+ * struct device_physical_location - Device data related to physical location
+ * of the device connection point.
+ * @panel: Panel surface of the system's housing that the device connection
+ *         point resides on.
+ * @vertical_position: Vertical position of the device connection point within
+ *                     the panel.
+ * @horizontal_position: Horizontal position of the device connection point
+ *                       within the panel.
+ * @dock: Set if the device connection point resides in a docking station or
+ *        port replicator.
+ * @lid: Set if this device connection point resides on the lid of laptop
+ *       system.
+ */
+struct device_physical_location {
+	enum device_physical_location_panel panel;
+	enum device_physical_location_vertical_position vertical_position;
+	enum device_physical_location_horizontal_position horizontal_position;
+	bool dock;
+	bool lid;
+};
+
+/**
+ * enum dl_dev_state - Device driver presence tracking information.
+ * @DL_DEV_NO_DRIVER: There is no driver attached to the device.
+ * @DL_DEV_PROBING: A driver is probing.
+ * @DL_DEV_DRIVER_BOUND: The driver has been bound to the device.
+ * @DL_DEV_UNBINDING: The driver is unbinding from the device.
+ */
+enum dl_dev_state {
+	DL_DEV_NO_DRIVER = 0,
+	DL_DEV_PROBING,
+	DL_DEV_DRIVER_BOUND,
+	DL_DEV_UNBINDING,
+};
+
+/**
+ * struct dev_links_info - Device data related to device links.
+ * @suppliers: List of links to supplier devices.
+ * @consumers: List of links to consumer devices.
+ * @defer_sync: Hook to global list of devices that have deferred sync_state.
+ * @status: Driver status information.
+ */
+struct dev_links_info {
+	struct list_head suppliers;
+	struct list_head consumers;
+	struct list_head defer_sync;
+	enum dl_dev_state status;
+};
+
+struct irq_domain;
+struct msi_device_data;
+
+/**
+ * struct dev_msi_info - Device data related to MSI
+ * @domain: The MSI interrupt domain associated to the device
+ * @data: Pointer to MSI device data
+ */
+struct dev_msi_info {
+#ifdef CONFIG_GENERIC_MSI_IRQ
+	struct irq_domain	*domain;
+	struct msi_device_data	*data;
+#endif
+};
+
+struct device_dma_parameters {
+	/*
+	 * a low level driver may set these to teach IOMMU code about
+	 * sg limitations.
+	 */
+	unsigned int max_segment_size;
+	unsigned int min_align_mask;
+	unsigned long segment_boundary_mask;
+};
+
+/**
+ * enum device_removable - Whether the device is removable. The criteria for a
+ * device to be classified as removable is determined by its subsystem or bus.
+ * @DEVICE_REMOVABLE_NOT_SUPPORTED: This attribute is not supported for this
+ *				    device (default).
+ * @DEVICE_REMOVABLE_UNKNOWN:  Device location is Unknown.
+ * @DEVICE_FIXED: Device is not removable by the user.
+ * @DEVICE_REMOVABLE: Device is removable by the user.
+ */
+enum device_removable {
+	DEVICE_REMOVABLE_NOT_SUPPORTED = 0, /* must be 0 */
+	DEVICE_REMOVABLE_UNKNOWN,
+	DEVICE_FIXED,
+	DEVICE_REMOVABLE,
+};
+
+struct attribute_group;
+struct bus_dma_region;
+struct bus_type;
+struct class;
+struct cma;
+struct dev_iommu;
+struct dev_pin_info;
+struct device;
+struct device_driver;
+struct device_node;
+struct dma_coherent_mem;
+struct dma_map_ops;
+struct em_perf_domain;
+struct fwnode_handle;
+struct io_tlb_mem;
+struct iommu_group;
+
+/*
+ * The type of device, "struct device" is embedded in. A class
+ * or bus can contain devices of different types
+ * like "partitions" and "disks", "mouse" and "event".
+ * This identifies the device type and carries type-specific
+ * information, equivalent to the kobj_type of a kobject.
+ * If "name" is specified, the uevent will contain it in
+ * the DEVTYPE variable.
+ */
+struct device_type {
+	const char *name;
+	const struct attribute_group **groups;
+	int (*uevent)(const struct device *dev, struct kobj_uevent_env *env);
+	char *(*devnode)(const struct device *dev, umode_t *mode, kuid_t *uid, kgid_t *gid);
+	void (*release)(struct device *dev);
+
+	const struct dev_pm_ops *pm;
+};
+
+/**
+ * struct device - The basic device structure
+ * @parent:	The device's "parent" device, the device to which it is attached.
+ * 		In most cases, a parent device is some sort of bus or host
+ * 		controller. If parent is NULL, the device, is a top-level device,
+ * 		which is not usually what you want.
+ * @p:		Holds the private data of the driver core portions of the device.
+ * 		See the comment of the struct device_private for detail.
+ * @kobj:	A top-level, abstract class from which other classes are derived.
+ * @init_name:	Initial name of the device.
+ * @type:	The type of device.
+ * 		This identifies the device type and carries type-specific
+ * 		information.
+ * @mutex:	Mutex to synchronize calls to its driver.
+ * @bus:	Type of bus device is on.
+ * @driver:	Which driver has allocated this
+ * @platform_data: Platform data specific to the device.
+ * 		Example: For devices on custom boards, as typical of embedded
+ * 		and SOC based hardware, Linux often uses platform_data to point
+ * 		to board-specific structures describing devices and how they
+ * 		are wired.  That can include what ports are available, chip
+ * 		variants, which GPIO pins act in what additional roles, and so
+ * 		on.  This shrinks the "Board Support Packages" (BSPs) and
+ * 		minimizes board-specific #ifdefs in drivers.
+ * @driver_data: Private pointer for driver specific info.
+ * @links:	Links to suppliers and consumers of this device.
+ * @power:	For device power management.
+ *		See Documentation/driver-api/pm/devices.rst for details.
+ * @pm_domain:	Provide callbacks that are executed during system suspend,
+ * 		hibernation, system resume and during runtime PM transitions
+ * 		along with subsystem-level and driver-level callbacks.
+ * @em_pd:	device's energy model performance domain
+ * @pins:	For device pin management.
+ *		See Documentation/driver-api/pin-control.rst for details.
+ * @msi:	MSI related data
+ * @numa_node:	NUMA node this device is close to.
+ * @dma_ops:    DMA mapping operations for this device.
+ * @dma_mask:	Dma mask (if dma'ble device).
+ * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
+ * 		hardware supports 64-bit addresses for consistent allocations
+ * 		such descriptors.
+ * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
+ *		DMA limit than the device itself supports.
+ * @dma_range_map: map for DMA memory ranges relative to that of RAM
+ * @dma_parms:	A low level driver may set these to teach IOMMU code about
+ * 		segment limitations.
+ * @dma_pools:	Dma pools (if dma'ble device).
+ * @dma_mem:	Internal for coherent mem override.
+ * @cma_area:	Contiguous memory area for dma allocations
+ * @dma_io_tlb_mem: Software IO TLB allocator.  Not for driver use.
+ * @dma_io_tlb_pools:	List of transient swiotlb memory pools.
+ * @dma_io_tlb_lock:	Protects changes to the list of active pools.
+ * @dma_uses_io_tlb: %true if device has used the software IO TLB.
+ * @archdata:	For arch-specific additions.
+ * @of_node:	Associated device tree node.
+ * @fwnode:	Associated device node supplied by platform firmware.
+ * @devt:	For creating the sysfs "dev".
+ * @id:		device instance
+ * @devres_lock: Spinlock to protect the resource of the device.
+ * @devres_head: The resources list of the device.
+ * @class:	The class of the device.
+ * @groups:	Optional attribute groups.
+ * @release:	Callback to free the device after all references have
+ * 		gone away. This should be set by the allocator of the
+ * 		device (i.e. the bus driver that discovered the device).
+ * @iommu_group: IOMMU group the device belongs to.
+ * @iommu:	Per device generic IOMMU runtime data
+ * @physical_location: Describes physical location of the device connection
+ *		point in the system housing.
+ * @removable:  Whether the device can be removed from the system. This
+ *              should be set by the subsystem / bus driver that discovered
+ *              the device.
+ *
+ * @offline_disabled: If set, the device is permanently online.
+ * @offline:	Set after successful invocation of bus type's .offline().
+ * @of_node_reused: Set if the device-tree node is shared with an ancestor
+ *              device.
+ * @state_synced: The hardware state of this device has been synced to match
+ *		  the software state of this device by calling the driver/bus
+ *		  sync_state() callback.
+ * @can_match:	The device has matched with a driver at least once or it is in
+ *		a bus (like AMBA) which can't check for matching drivers until
+ *		other devices probe successfully.
+ * @dma_coherent: this particular device is dma coherent, even if the
+ *		architecture supports non-coherent devices.
+ * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
+ *		streaming DMA operations (->map_* / ->unmap_* / ->sync_*),
+ *		and optionall (if the coherent mask is large enough) also
+ *		for dma allocations.  This flag is managed by the dma ops
+ *		instance from ->dma_supported.
+ * @dma_skip_sync: DMA sync operations can be skipped for coherent buffers.
+ * @dma_iommu: Device is using default IOMMU implementation for DMA and
+ *		doesn't rely on dma_ops structure.
+ *
+ * At the lowest level, every device in a Linux system is represented by an
+ * instance of struct device. The device structure contains the information
+ * that the device model core needs to model the system. Most subsystems,
+ * however, track additional information about the devices they host. As a
+ * result, it is rare for devices to be represented by bare device structures;
+ * instead, that structure, like kobject structures, is usually embedded within
+ * a higher-level representation of the device.
+ */
+struct device {
+	struct kobject kobj;
+	struct device		*parent;
+
+	struct device_private	*p;
+
+	const char		*init_name; /* initial name of the device */
+	const struct device_type *type;
+
+	const struct bus_type	*bus;	/* type of bus device is on */
+	struct device_driver *driver;	/* which driver has allocated this device */
+	void		*platform_data;	/* Platform specific data, device
+					   core doesn't touch it */
+	void		*driver_data;	/* Driver data, set and get with
+					   dev_set_drvdata/dev_get_drvdata */
+	struct mutex		mutex;	/* mutex to synchronize calls to its driver */
+
+	struct dev_links_info	links;
+	struct dev_pm_info	power;
+	struct dev_pm_domain	*pm_domain;
+
+#ifdef CONFIG_ENERGY_MODEL
+	struct em_perf_domain	*em_pd;
+#endif
+
+#ifdef CONFIG_PINCTRL
+	struct dev_pin_info	*pins;
+#endif
+	struct dev_msi_info	msi;
+#ifdef CONFIG_ARCH_HAS_DMA_OPS
+	const struct dma_map_ops *dma_ops;
+#endif
+	u64		*dma_mask;	/* dma mask (if dma'able device) */
+	u64		coherent_dma_mask;/* Like dma_mask, but for
+					     alloc_coherent mappings as
+					     not all hardware supports
+					     64 bit addresses for consistent
+					     allocations such descriptors. */
+	u64		bus_dma_limit;	/* upstream dma constraint */
+	const struct bus_dma_region *dma_range_map;
+
+	struct device_dma_parameters *dma_parms;
+
+	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
+
+#ifdef CONFIG_DMA_DECLARE_COHERENT
+	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem override */
+#endif
+#ifdef CONFIG_DMA_CMA
+	struct cma *cma_area;		/* contiguous memory area for dma allocations */
+#endif
+#ifdef CONFIG_SWIOTLB
+	struct io_tlb_mem *dma_io_tlb_mem;
+#endif
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	struct list_head dma_io_tlb_pools;
+	spinlock_t dma_io_tlb_lock;
+	bool dma_uses_io_tlb;
+#endif
+	/* arch specific additions */
+	struct dev_archdata	archdata;
+
+	struct device_node	*of_node; /* associated device tree node */
+	struct fwnode_handle	*fwnode; /* firmware device node */
+
+#ifdef CONFIG_NUMA
+	int		numa_node;	/* NUMA node this device is close to */
+#endif
+	dev_t			devt;	/* dev_t, creates the sysfs "dev" */
+	u32			id;	/* device instance */
+
+	spinlock_t		devres_lock;
+	struct list_head	devres_head;
+
+	const struct class	*class;
+	const struct attribute_group **groups;	/* optional groups */
+
+	void	(*release)(struct device *dev);
+	struct iommu_group	*iommu_group;
+	struct dev_iommu	*iommu;
+
+	struct device_physical_location *physical_location;
+
+	enum device_removable	removable;
+
+	bool			offline_disabled:1;
+	bool			offline:1;
+	bool			of_node_reused:1;
+	bool			state_synced:1;
+	bool			can_match:1;
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+	bool			dma_coherent:1;
+#endif
+#ifdef CONFIG_DMA_OPS_BYPASS
+	bool			dma_ops_bypass : 1;
+#endif
+#ifdef CONFIG_DMA_NEED_SYNC
+	bool			dma_skip_sync:1;
+#endif
+#ifdef CONFIG_IOMMU_DMA
+	bool			dma_iommu:1;
+#endif
+};
+
+#define kobj_to_dev(__kobj)	container_of_const(__kobj, struct device, kobj)
+
+static inline struct irq_domain *dev_get_msi_domain(const struct device *dev)
+{
+#ifdef CONFIG_GENERIC_MSI_IRQ
+	return dev->msi.domain;
+#else
+	return NULL;
+#endif
+}
+
+static inline void dev_set_msi_domain(struct device *dev, struct irq_domain *d)
+{
+#ifdef CONFIG_GENERIC_MSI_IRQ
+	dev->msi.domain = d;
+#endif
+}
+
+#endif /* _DEVICE_TYPES_H_ */
-- 
2.50.1


