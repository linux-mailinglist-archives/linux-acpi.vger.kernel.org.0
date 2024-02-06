Return-Path: <linux-acpi+bounces-3270-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7AE84C012
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 23:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D771F236E8
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 22:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0211C2BC;
	Tue,  6 Feb 2024 22:30:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321291C2AD;
	Tue,  6 Feb 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258627; cv=none; b=rFE49HiU632QhRGP+/mUOoExgI3qwIkj9Sf9xZKi1/ev8GsrPLppg4R7rWmtKI96f3BooOgjgrnwZPE0nl3MrALBMjefMZuVFt/mSatLSPyqNck6RSIYHMKLFAM4pyo0GIwN7X4rn7RgL1UhIMIO4/YdLJ+TIqWYq2WrIFha8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258627; c=relaxed/simple;
	bh=DGPDegLT9DLc9uqawQeJnyfnCckwZFgC0fnYz+6AJww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPEnPicFAvZ08q7qEJy6ZC7lNzzWFt0D4DXv+V3PBWYQirE91AC0YX8kZmZnQebXQvlUwCvTKTzEoGxnuobE8G1XsqQ8vHGRGQB69YmOHT101Eahm5kSCo+vDmEFE/y2gTdenQfob0bpe6amxS6uK6Ohmft7E+MLLHOIuSp/3Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA285C433F1;
	Tue,  6 Feb 2024 22:30:26 +0000 (UTC)
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
	gregkh@linuxfoundation.org
Subject: [PATCH v5 12/12] cxl/region: Deal with numa nodes not enumarated by SRAT
Date: Tue,  6 Feb 2024 15:28:40 -0700
Message-ID: <20240206222951.1833098-13-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206222951.1833098-1-dave.jiang@intel.com>
References: <20240206222951.1833098-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the numa nodes that are not created by SRAT, no memory_target is
allocated and is not managed by the HMAT_REPORTING code. Therefore
hmat_callback() memory hotplug notifier will exit early on those NUMA
nodes. The CXL memory hotplug notifier will need to call
node_set_perf_attrs() directly in order to setup the access sysfs
attributes.

In acpi_numa_init(), the last proximity domain (pxm) id created by SRAT is
stored. Add a helper function acpi_node_backed_by_real_pxm() in order to
check if a NUMA node id is defined by SRAT or created by CFMWS.

node_set_perf_attrs() symbol is exported to allow update of perf attribs
for a node. The sysfs path of
/sys/devices/system/node/nodeX/access0/initiators/* is created by
ndoe_set_perf_attrs() for the various attributes where nodeX is matched
to the NUMA node of the CXL region.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5:
- Fix ARM compile of missing prototype (0day)
---
 drivers/acpi/numa/srat.c  | 11 +++++++++++
 drivers/base/node.c       |  1 +
 drivers/cxl/core/cdat.c   |  5 +++++
 drivers/cxl/core/core.h   |  1 +
 drivers/cxl/core/region.c |  7 ++++++-
 include/linux/acpi.h      |  9 +++++++++
 6 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 0214518fc582..e45e64993c50 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -29,6 +29,8 @@ static int node_to_pxm_map[MAX_NUMNODES]
 unsigned char acpi_srat_revision __initdata;
 static int acpi_numa __initdata;
 
+static int last_real_pxm;
+
 void __init disable_srat(void)
 {
 	acpi_numa = -1;
@@ -536,6 +538,7 @@ int __init acpi_numa_init(void)
 		if (node_to_pxm_map[i] > fake_pxm)
 			fake_pxm = node_to_pxm_map[i];
 	}
+	last_real_pxm = fake_pxm;
 	fake_pxm++;
 	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
 			      &fake_pxm);
@@ -547,6 +550,14 @@ int __init acpi_numa_init(void)
 	return 0;
 }
 
+bool acpi_node_backed_by_real_pxm(int nid)
+{
+	int pxm = node_to_pxm(nid);
+
+	return pxm <= last_real_pxm;
+}
+EXPORT_SYMBOL_GPL(acpi_node_backed_by_real_pxm);
+
 static int acpi_get_pxm(acpi_handle h)
 {
 	unsigned long long pxm;
diff --git a/drivers/base/node.c b/drivers/base/node.c
index a73b0c9a401a..eb72580288e6 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
 		}
 	}
 }
+EXPORT_SYMBOL_GPL(node_set_perf_attrs);
 
 /**
  * struct node_cache_info - Internal tracking for memory node caches
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 20fb8318dfcc..c012c7304164 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -586,3 +586,8 @@ int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
 {
 	return hmat_update_target_coordinates(nid, &cxlr->coord[access], access);
 }
+
+bool cxl_need_node_perf_attrs_update(int nid)
+{
+	return !acpi_node_backed_by_real_pxm(nid);
+}
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index e19800a7ce06..bc5a95665aa0 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -92,5 +92,6 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
 
 int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
 				       enum access_coordinate_class access);
+bool cxl_need_node_perf_attrs_update(int nid);
 
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 19e419f18472..db51e35cb44f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3084,7 +3084,12 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
 
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
 		if (cxlr->coord[i].read_bandwidth) {
-			rc = cxl_update_hmat_access_coordinates(nid, cxlr, i);
+			rc = 0;
+			if (cxl_need_node_perf_attrs_update(nid))
+				node_set_perf_attrs(nid, &cxlr->coord[i], i);
+			else
+				rc = cxl_update_hmat_access_coordinates(nid, cxlr, i);
+
 			if (rc == 0)
 				cset++;
 		}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c84c2f34b8ee..2a7c4b90d589 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1559,4 +1559,13 @@ static inline int hmat_update_target_coordinates(int nid,
 }
 #endif
 
+#ifdef CONFIG_ACPI_NUMA
+bool acpi_node_backed_by_real_pxm(int nid);
+#else
+static inline bool acpi_node_backed_by_real_pxm(int nid)
+{
+	return false;
+}
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
-- 
2.43.0


