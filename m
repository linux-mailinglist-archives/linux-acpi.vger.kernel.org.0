Return-Path: <linux-acpi+bounces-2952-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16237832E17
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 18:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0F0287F79
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 17:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57E255E4E;
	Fri, 19 Jan 2024 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZtqPHma"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B704C3D4;
	Fri, 19 Jan 2024 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685067; cv=none; b=jPw7Pafkd2mwY9pcW7TxsU7p39wooB6FgT6LmSJHRNhihzw57mXEkrzZXADdwPtWXrNLBc9rJTKAPTBSXWVv6c7EdmZhIl0WtoTk6iri7O+7Q1duHwXyJbdnco8v5+DEQWLoy7PEDQEWqxCW9QDou3qDGUcky0JsVRDclR31UTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685067; c=relaxed/simple;
	bh=5z0cWx88F8feYRKWq/CowEUdRDN88aHLKkrVHbnqnJ0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsH37jOJxscA6iNjz+PqrwlcLL68tf18j1T/+PBq3tjRBSgaLuBrKHI2KlSGXrOwSkKBl5IQFEoZvSY/1ejSee0BHjBfm3N3JlqbRAysQVnbvBZxj+gGznI+nd48/P1M0bcyncrrxFvDNsgKyHRo+mfzsuZS6q4FqgbS4dPMihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZtqPHma; arc=none smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705685066; x=1737221066;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5z0cWx88F8feYRKWq/CowEUdRDN88aHLKkrVHbnqnJ0=;
  b=DZtqPHma/B1dbhHuGtOnuXZSAMU4g3/M/4lFpqJS1+Uo8ixvR6tb5N0T
   95VppmnqWL6gHmRvi3SeF3u+0F1D91mtScNqXUwzs1USmOafOQmSkzod+
   fRUYQlt5JQVYUVoV3dliTHjqFkswmtlAk/kZIiyir1Q3yyaejEY7uFzJE
   vRqYrVnValIQoxuuJvUqVXeLtDmmgesB9ujW83wyASa62eUa26k968X3J
   NOjG/TEQ/mK5QGVXe9KL5YqAmbMsMPf2lmvK2U+zxEX1vgwVz4v2wc1tO
   VeRCvuYBuy5r+Z3S0/S8rCrb4hvSTakoEpdb/8lW9dlhwc+1yFaGn0jAU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="486944542"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="486944542"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:24:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="819117785"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="819117785"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.161.22])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:24:04 -0800
Subject: [PATCH v4 10/11] cxl: Add memory hotplug notifier for cxl region
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Huang,
 Ying" <ying.huang@intel.com>, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net, brice.goglin@gmail.com,
 nifan.cxl@gmail.com, rafael@kernel.org, gregkh@linuxfoundation.org
Date: Fri, 19 Jan 2024 10:24:04 -0700
Message-ID: <170568504418.1008395.721034168814753057.stgit@djiang5-mobl3>
In-Reply-To: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
References: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
v4:
- Update access_coordinates via HMAT_REPORING code and let hmat_callback()
  notifier to expose the new numbers to sysfs.
- Introduce CXL_CALLBACK_PRI and remove HMAT language (Dan)
---
 drivers/acpi/numa/hmat.c  |   36 ++++++++++++++++++++++
 drivers/cxl/core/cdat.c   |    6 ++++
 drivers/cxl/core/core.h   |    3 ++
 drivers/cxl/core/region.c |   75 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |    3 ++
 include/linux/acpi.h      |    9 +++++
 include/linux/memory.h    |    1 +
 7 files changed, 133 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 5be79896bd08..dc75a3355164 100644
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
@@ -699,6 +729,12 @@ static void hmat_update_target_attrs(struct memory_target *target,
 	u32 best = 0;
 	int i;
 
+	/*
+	 * Don't update if an external agent has changed the data.
+	 */
+	if (target->ext_updated)
+		return;
+
 	/* Don't update for generic port if there's no device handle */
 	if ((access == NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL ||
 	     access == NODE_ACCESS_CLASS_GENPORT_SINK_CPU) &&
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 7acb5837afad..3556c897ece4 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -620,3 +620,9 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
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
index 978d1707964a..ae1f34e1cd05 100644
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
@@ -156,12 +157,22 @@ static const struct attribute_group cxl_region_access0_coordinate_group = {
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
@@ -3066,6 +3077,65 @@ static int is_system_ram(struct resource *res, void *arg)
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
+	struct cxl_region *cxlr = data;
+
+	unregister_memory_notifier(&cxlr->memory_notifier);
+}
+
 static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
@@ -3091,6 +3161,11 @@ static int cxl_region_probe(struct device *dev)
 		goto out;
 	}
 
+	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
+	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
+	register_memory_notifier(&cxlr->memory_notifier);
+	rc = devm_add_action_or_reset(&cxlr->dev, remove_coord_notifier, cxlr);
+
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f6637fa33113..556348c8835e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -6,6 +6,7 @@
 
 #include <linux/libnvdimm.h>
 #include <linux/bitfield.h>
+#include <linux/notifier.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/node.h>
@@ -520,6 +521,7 @@ struct cxl_region_params {
  * @flags: Region state flags
  * @params: active + config params for the region
  * @coord: QoS access coordinates for the region
+ * @memory_notifier: notifier for setting the access coordinates to node
  */
 struct cxl_region {
 	struct device dev;
@@ -531,6 +533,7 @@ struct cxl_region {
 	unsigned long flags;
 	struct cxl_region_params params;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
+	struct notifier_block memory_notifier;
 };
 
 struct cxl_nvdimm_bridge {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 8b0761c682f9..1c664948b2ae 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -427,12 +427,21 @@ extern bool acpi_osi_is_win8(void);
 
 #ifdef CONFIG_ACPI_HMAT
 int acpi_get_genport_coordinates(u32 uid, struct access_coordinate *coord);
+int hmat_update_target_coordinates(int nid, struct access_coordinate *coord,
+				   enum access_coordinate_class access);
 #else
 static inline int acpi_get_genport_coordinates(u32 uid,
 					       struct access_coordinate *coord)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int hmat_update_target_coordinates(int nid,
+						 struct access_coordinate *coord,
+						 enum access_coordinate_class access)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #ifdef CONFIG_ACPI_NUMA
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



