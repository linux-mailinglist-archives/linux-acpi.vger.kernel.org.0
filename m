Return-Path: <linux-acpi+bounces-15707-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA73B26D72
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 19:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022B5AA29D9
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 17:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B54221B9FE;
	Thu, 14 Aug 2025 17:17:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4DF1C5499;
	Thu, 14 Aug 2025 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191863; cv=none; b=nyQkOHF6pI/XKeJruGFozJ6cuwiMUQTzOR5HEowXVoWPS+diUuFegFH0PCiWl8tvr6Mng8zJ0qkJo/5fjrJyAwIz/DaOXYbJcmob1pkXTM1pJjnsdedz5H2cl9iiP0KkALxzj945txXUCy6+KfeXXiZ2WHAJNzjkAuZ5Hj0JKR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191863; c=relaxed/simple;
	bh=8Fv0jTNPXa1am1ZiEmH7TvohV9ZapJgMNHCYMNK3g34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbhYfJaMk2IpeStQHYgZwaIuM6JCcQCa/l0ISkjVVt5CWIqUogxU8MFNKwMItxZq72uRLKwqrs1EuURfVq5B97qUkrJj/S0iVEfaHf+pI+6OkJd54j0w9anXx6k72kPOukIPNyq//ov/yGBfI+HMhwYUFgBNs6aqrHgGyhJHCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E458EC4CEED;
	Thu, 14 Aug 2025 17:17:41 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	marc.herbert@linux.intel.com,
	akpm@linux-foundation.org,
	david@redhat.com
Subject: [PATCH 3/4] cxl, acpi/hmat: Update CXL access coordinates directly instead of through HMAT
Date: Thu, 14 Aug 2025 10:16:49 -0700
Message-ID: <20250814171650.3002930-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814171650.3002930-1-dave.jiang@intel.com>
References: <20250814171650.3002930-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of CXL memory hotplug notifier gets called
before the HMAT memory hotplug notifier. The CXL driver calculates the
access coordinates (bandwidth and latency values) for the CXL end to
end path (i.e. CPU to endpoint). When the CXL region is onlined, the CXL
memory hotplug notifier writes the access coordinates to the HMAT target
structs. Then the HMAT memory hotplug notifier is called and it creates
the access coordinates for the node sysfs attributes.

The original intent of the 'ext_updated' flag in HMAT handling code was to
stop HMAT memory hotplug callback from clobbering the access coordinates
after CXL has injected its calculated coordinates and replaced the generic
target access coordinates provided by the HMAT table in the HMAT target
structs. However the flag is hacky at best and blocks the updates from
other CXL regions that are onlined in the same node later on. Remove the
'ext_updated' flag usage and just update the access coordinates for the
nodes directly without touching HMAT target data.

The hotplug memory callback ordering is changed. Instead of changing CXL,
move HMAT back so there's room for the levels rather than have CXL share
the same level as SLAB_CALLBACK_PRI. The change will resulting in the CXL
callback to be executed after the HMAT callback.

With the change, the CXL hotplug memory notifier runs after the HMAT
callback. The HMAT callback will create the node sysfs attributes for
access coordinates. The CXL callback will write the access coordinates to
the now created node sysfs attributes directly and will not pollute the
HMAT target values.

Fixes: debdce20c4f2 ("cxl/region: Deal with numa nodes not enumerated by SRAT")
Tested-by: Marc Herbert <marc.herbert@linux.intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c  |  6 ------
 drivers/cxl/core/cdat.c   |  5 -----
 drivers/cxl/core/core.h   |  1 -
 drivers/cxl/core/region.c | 10 ++--------
 include/linux/memory.h    |  2 +-
 5 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 4958301f5417..5d32490dc4ab 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -74,7 +74,6 @@ struct memory_target {
 	struct node_cache_attrs cache_attrs;
 	u8 gen_port_device_handle[ACPI_SRAT_DEVICE_HANDLE_SIZE];
 	bool registered;
-	bool ext_updated;	/* externally updated */
 };
 
 struct memory_initiator {
@@ -391,7 +390,6 @@ int hmat_update_target_coordinates(int nid, struct access_coordinate *coord,
 				  coord->read_bandwidth, access);
 	hmat_update_target_access(target, ACPI_HMAT_WRITE_BANDWIDTH,
 				  coord->write_bandwidth, access);
-	target->ext_updated = true;
 
 	return 0;
 }
@@ -773,10 +771,6 @@ static void hmat_update_target_attrs(struct memory_target *target,
 	u32 best = 0;
 	int i;
 
-	/* Don't update if an external agent has changed the data.  */
-	if (target->ext_updated)
-		return;
-
 	/* Don't update for generic port if there's no device handle */
 	if ((access == NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL ||
 	     access == NODE_ACCESS_CLASS_GENPORT_SINK_CPU) &&
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index c0af645425f4..c891fd618cfd 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -1081,8 +1081,3 @@ int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
 {
 	return hmat_update_target_coordinates(nid, &cxlr->coord[access], access);
 }
-
-bool cxl_need_node_perf_attrs_update(int nid)
-{
-	return !acpi_node_backed_by_real_pxm(nid);
-}
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 2669f251d677..a253d308f3c9 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -139,7 +139,6 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
 				       enum access_coordinate_class access);
-bool cxl_need_node_perf_attrs_update(int nid);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 71cc42d05248..1580e19f13a5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2442,14 +2442,8 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
 
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
 		if (cxlr->coord[i].read_bandwidth) {
-			rc = 0;
-			if (cxl_need_node_perf_attrs_update(nid))
-				node_set_perf_attrs(nid, &cxlr->coord[i], i);
-			else
-				rc = cxl_update_hmat_access_coordinates(nid, cxlr, i);
-
-			if (rc == 0)
-				cset++;
+			node_update_perf_attrs(nid, &cxlr->coord[i], i);
+			cset++;
 		}
 	}
 
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 02314723e5bd..b41872c478e3 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -120,8 +120,8 @@ struct mem_section;
  */
 #define DEFAULT_CALLBACK_PRI	0
 #define SLAB_CALLBACK_PRI	1
-#define HMAT_CALLBACK_PRI	2
 #define CXL_CALLBACK_PRI	5
+#define HMAT_CALLBACK_PRI	6
 #define MM_COMPUTE_BATCH_PRI	10
 #define CPUSET_CALLBACK_PRI	10
 #define MEMTIER_HOTPLUG_PRI	100
-- 
2.50.1


