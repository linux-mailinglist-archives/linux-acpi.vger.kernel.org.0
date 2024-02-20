Return-Path: <linux-acpi+bounces-3754-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E0185CBDD
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 00:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE851C21DBB
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 23:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F6F154BF8;
	Tue, 20 Feb 2024 23:14:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64E154BF7;
	Tue, 20 Feb 2024 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470874; cv=none; b=rxNUvdbL5FJDCrcFV8OgtVHLRwTSoDnoDcF1Vbac8+GunPEVt/8mn2dByGY37B/jtXX2INJ/BTdmZ4pZNRX1HSiyjfXoEv2+Jng1i676pZLdwFP+EbMdxQEgoCoLfuxGV/WbMDqyyr1hrut6J843qlJmzbJNvT62f1RD/LxQa7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470874; c=relaxed/simple;
	bh=xp0xHEHKigTXfAYOQrG808B6oCMSPNfK8vl8iQ/XxrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfK3lun+OK9itYpfvA/IdoHP/nxtJbIwnxd2QTNindhFC9q0X/3PiTDm9qIfRKomLfiGMtx3L0ViDYQ4oBfOkULRoFsAsZsPmdJ1wzwSRCtwD+CvI2xtoWWMjBUvtqUI6GDfOKqQTKAPtdMkz/OQfVlrCQ8e+0EszitzuLkExPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75E3C433C7;
	Tue, 20 Feb 2024 23:14:33 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>
Subject: [PATCH v6 11/12] cxl/region: Add memory hotplug notifier for cxl region
Date: Tue, 20 Feb 2024 16:12:40 -0700
Message-ID: <20240220231402.3156281-12-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220231402.3156281-1-dave.jiang@intel.com>
References: <20240220231402.3156281-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the CXL region is formed, the driver would computed the performance
data for the region. However this data is not available at the node data
collection that has been populated by the HMAT during kernel
initialization. Add a memory hotplug notifier to update the access
coordinates to the 'struct memory_target' context kept by the
HMAT_REPORTING code.

Add CXL_CALLBACK_PRI for a memory hotplug callback priority. Set the
priority number to be called before HMAT_CALLBACK_PRI. The CXL update must
happen before hmat_callback().

A new HMAT_REPORING helper hmat_update_target_coordinates() is added in
order to allow CXL to update the memory_target access coordinates.

A new ext_updated member is added to the memory_target to indicate that
the access coordinates within the memory_target has been updated by an
external agent such as CXL. This prevents data being overwritten by the
hmat_update_target_attrs() triggered by hmat_callback().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Pass in notifier ptr direct for removal. (Jonthan)
- Reduce comment to single line in hmat code. (Jonathan)
---
 drivers/acpi/numa/hmat.c  | 34 ++++++++++++++++++
 drivers/cxl/core/cdat.c   |  6 ++++
 drivers/cxl/core/core.h   |  3 ++
 drivers/cxl/core/region.c | 76 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  3 ++
 include/linux/acpi.h      | 12 +++++++
 include/linux/memory.h    |  1 +
 7 files changed, 135 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 75e9aac43228..2c8ccc91ebe6 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -74,6 +74,7 @@ struct memory_target {
 	struct node_cache_attrs cache_attrs;
 	u8 gen_port_device_handle[ACPI_SRAT_DEVICE_HANDLE_SIZE];
 	bool registered;
+	bool ext_updated;	/* externally updated */
 };
 
 struct memory_initiator {
@@ -328,6 +329,35 @@ static void hmat_update_target_access(struct memory_target *target,
 	}
 }
 
+int hmat_update_target_coordinates(int nid, struct access_coordinate *coord,
+				   enum access_coordinate_class access)
+{
+	struct memory_target *target;
+	int pxm;
+
+	if (nid == NUMA_NO_NODE)
+		return -EINVAL;
+
+	pxm = node_to_pxm(nid);
+	guard(mutex)(&target_lock);
+	target = find_mem_target(pxm);
+	if (!target)
+		return -ENODEV;
+
+	hmat_update_target_access(target, ACPI_HMAT_READ_LATENCY,
+				  coord->read_latency, access);
+	hmat_update_target_access(target, ACPI_HMAT_WRITE_LATENCY,
+				  coord->write_latency, access);
+	hmat_update_target_access(target, ACPI_HMAT_READ_BANDWIDTH,
+				  coord->read_bandwidth, access);
+	hmat_update_target_access(target, ACPI_HMAT_WRITE_BANDWIDTH,
+				  coord->write_bandwidth, access);
+	target->ext_updated = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hmat_update_target_coordinates);
+
 static __init void hmat_add_locality(struct acpi_hmat_locality *hmat_loc)
 {
 	struct memory_locality *loc;
@@ -699,6 +729,10 @@ static void hmat_update_target_attrs(struct memory_target *target,
 	u32 best = 0;
 	int i;
 
+	/* Don't update if an external agent has changed the data.  */
+	if (target->ext_updated)
+		return;
+
 	/* Don't update for generic port if there's no device handle */
 	if ((access == NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL ||
 	     access == NODE_ACCESS_CLASS_GENPORT_SINK_CPU) &&
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 40052666ebf1..ee1bc8fa396b 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -580,3 +580,9 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 			DIV_ROUND_UP(cxlr->coord[i].write_latency, 1000);
 	}
 }
+
+int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
+				       enum access_coordinate_class access)
+{
+	return hmat_update_target_coordinates(nid, &cxlr->coord[access], access);
+}
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3b64fb1b9ed0..e19800a7ce06 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -90,4 +90,7 @@ enum cxl_poison_trace_type {
 
 long cxl_pci_get_latency(struct pci_dev *pdev);
 
+int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
+				       enum access_coordinate_class access);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 61249a6b42c7..39f9a48ba640 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4,6 +4,7 @@
 #include <linux/genalloc.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/memory.h>
 #include <linux/slab.h>
 #include <linux/uuid.h>
 #include <linux/sort.h>
@@ -116,12 +117,22 @@ static const struct attribute_group cxl_region_access0_coordinate_group = {
 	.is_visible = cxl_region_access0_coordinate_visible,
 };
 
+static const struct attribute_group *get_cxl_region_access0_group(void)
+{
+	return &cxl_region_access0_coordinate_group;
+}
+
 static const struct attribute_group cxl_region_access1_coordinate_group = {
 	.name = "access1",
 	.attrs = access1_coordinate_attrs,
 	.is_visible = cxl_region_access1_coordinate_visible,
 };
 
+static const struct attribute_group *get_cxl_region_access1_group(void)
+{
+	return &cxl_region_access1_coordinate_group;
+}
+
 static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -3056,6 +3067,65 @@ static int is_system_ram(struct resource *res, void *arg)
 	return 1;
 }
 
+static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
+{
+	int cset = 0;
+	int rc;
+
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+		if (cxlr->coord[i].read_bandwidth) {
+			rc = cxl_update_hmat_access_coordinates(nid, cxlr, i);
+			if (rc == 0)
+				cset++;
+		}
+	}
+
+	if (!cset)
+		return false;
+
+	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_access0_group());
+	if (rc)
+		dev_dbg(&cxlr->dev, "Failed to update access0 group\n");
+
+	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_access1_group());
+	if (rc)
+		dev_dbg(&cxlr->dev, "Failed to update access1 group\n");
+
+	return true;
+}
+
+static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
+					  unsigned long action, void *arg)
+{
+	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
+					       memory_notifier);
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled = p->targets[0];
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct memory_notify *mnb = arg;
+	int nid = mnb->status_change_nid;
+	int region_nid;
+
+	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
+		return NOTIFY_DONE;
+
+	region_nid = phys_to_target_node(cxld->hpa_range.start);
+	if (nid != region_nid)
+		return NOTIFY_DONE;
+
+	if (!cxl_region_update_coordinates(cxlr, nid))
+		return NOTIFY_DONE;
+
+	return NOTIFY_OK;
+}
+
+static void remove_coord_notifier(void *data)
+{
+	struct notifier_block *memory_notifier = data;
+
+	unregister_memory_notifier(memory_notifier);
+}
+
 static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
@@ -3081,6 +3151,12 @@ static int cxl_region_probe(struct device *dev)
 		goto out;
 	}
 
+	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
+	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
+	register_memory_notifier(&cxlr->memory_notifier);
+	rc = devm_add_action_or_reset(&cxlr->dev, remove_coord_notifier,
+				      &cxlr->memory_notifier);
+
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 95864ce7b394..534e25e2f0a4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -6,6 +6,7 @@
 
 #include <linux/libnvdimm.h>
 #include <linux/bitfield.h>
+#include <linux/notifier.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/node.h>
@@ -518,6 +519,7 @@ struct cxl_region_params {
  * @flags: Region state flags
  * @params: active + config params for the region
  * @coord: QoS access coordinates for the region
+ * @memory_notifier: notifier for setting the access coordinates to node
  */
 struct cxl_region {
 	struct device dev;
@@ -529,6 +531,7 @@ struct cxl_region {
 	unsigned long flags;
 	struct cxl_region_params params;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
+	struct notifier_block memory_notifier;
 };
 
 struct cxl_nvdimm_bridge {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b7165e52b3c6..c84c2f34b8ee 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1547,4 +1547,16 @@ static inline void acpi_use_parent_companion(struct device *dev)
 	ACPI_COMPANION_SET(dev, ACPI_COMPANION(dev->parent));
 }
 
+#ifdef CONFIG_ACPI_HMAT
+int hmat_update_target_coordinates(int nid, struct access_coordinate *coord,
+				   enum access_coordinate_class access);
+#else
+static inline int hmat_update_target_coordinates(int nid,
+						 struct access_coordinate *coord,
+						 enum access_coordinate_class access)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
diff --git a/include/linux/memory.h b/include/linux/memory.h
index f53cfdaaaa41..d8588256578a 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -114,6 +114,7 @@ struct mem_section;
 #define DEFAULT_CALLBACK_PRI	0
 #define SLAB_CALLBACK_PRI	1
 #define HMAT_CALLBACK_PRI	2
+#define CXL_CALLBACK_PRI	5
 #define MM_COMPUTE_BATCH_PRI	10
 #define CPUSET_CALLBACK_PRI	10
 #define MEMTIER_HOTPLUG_PRI	100
-- 
2.43.0


