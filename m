Return-Path: <linux-acpi+bounces-2953-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E5A832E18
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 18:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5424287EB2
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 17:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5D4C3D4;
	Fri, 19 Jan 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mgm3sz5P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5236B55E54;
	Fri, 19 Jan 2024 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685069; cv=none; b=Kuqypav+aNAD4s5b2f4Cl4UyI+w8dFoPJfmH/2qE2YBhtSXM0LFjurnOoM2ESv7noeBlAYXMiXY152Ip0P9TXAAWoR5oxe5ZsoG6ul6PtqFiMKiRYRTyem/mqDNx5WgYT1QJwc4p6Y3O/lp5D75YHXd4KGKt9KluKifjLoY04ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685069; c=relaxed/simple;
	bh=ZC76tTG5mUc2PJmiN9HO5AuiKUJLWVjcYohMkqWylx4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aap5nB5wnJTb1ckbAqQzYmD7bkM6nBUeK+YNPj6nA7Se09zvu3nAXb3FIjHi43RU3rR7mhzGMFJZ7wZbZrfNDds98JybmOE8THA6VqTcxwRlswT8c/vPapJN7xwfNCTHZQSMxqE8zy//9yiCiFG4io+LxGLmYuiTeJfl0QFR4so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mgm3sz5P; arc=none smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705685068; x=1737221068;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZC76tTG5mUc2PJmiN9HO5AuiKUJLWVjcYohMkqWylx4=;
  b=Mgm3sz5PS1OgrvsJZOmnPqzvLpyQ94amleNmb/TYMCwn2/WAvcgvpJ6e
   bRAOGaqS53Q3q7jcvIlA7S+e1TqPH8Sz1NRT22iOHNlcrlMcPa+4hFI8h
   q2Lk0WuyohLO8NWZCGQajCr5g7KfgVWe+UqI2/wz2xA1yoaohUdIufnaf
   LvP8wvi4dWAMBNx74nKutmHpJEXVM78ZZnhOCoAMXJ0HVy6G+JCBIArRT
   TnKCplN16dBwA3BjmvWbcdwDvlewUyLqEcfZo62Pj5QNHNkc9/JZOsH4Y
   Ae6TfeYd12Fz2FW/QEAtzwxk2uYuTCnDjigWHTHN7QEp99euXDRf3GJk1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="486944581"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="486944581"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:24:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="819117798"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="819117798"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.161.22])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:24:11 -0800
Subject: [PATCH v4 11/11] cxl: Deal with numa nodes not enumarated by SRAT
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net, brice.goglin@gmail.com,
 nifan.cxl@gmail.com, rafael@kernel.org, gregkh@linuxfoundation.org
Date: Fri, 19 Jan 2024 10:24:11 -0700
Message-ID: <170568505106.1008395.11049680010287891282.stgit@djiang5-mobl3>
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

For the numa nodes that are not created by SRAT, no memory_target is
allocated and is not managed by the HMAT_REPORTING code. Therefore
hmat_callback() memory hotplug notifier will exit early on those NUMA
nodes. The CXL memory hotplug notifier will need to call
node_set_perf_attrs() directly in order to setup the access sysfs
attributes.

In acpi_numa_init(), the last proximity domain (pxm) id created by SRAT is
stored. Add a helper function acpi_node_backed_by_real_pxm() in order to
check if a NUMA node id is defined by SRAT or created by CFMWS or some
other methods.

node_set_perf_attrs() symbol is exported to allow update of perf attribs
for a node. The sysfs path of
/sys/devices/system/node/nodeX/access0/initiators/* is created by
ndoe_set_perf_attrs() for the various attributes where nodeX is matched
to the NUMA node of the CXL region.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/srat.c  |   11 +++++++++++
 drivers/base/node.c       |    1 +
 drivers/cxl/core/cdat.c   |    5 +++++
 drivers/cxl/core/core.h   |    1 +
 drivers/cxl/core/region.c |    7 ++++++-
 include/linux/acpi.h      |    1 +
 6 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 12f330b0eac0..2f6f15b3891d 100644
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
index b4a449f07f2a..8d0b09769b77 100644
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
index 3556c897ece4..7d7163f999e8 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -626,3 +626,8 @@ int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
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
index ae1f34e1cd05..66f126067bda 100644
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
index 1c664948b2ae..3067c6aad431 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -447,6 +447,7 @@ static inline int hmat_update_target_coordinates(int nid,
 #ifdef CONFIG_ACPI_NUMA
 int acpi_map_pxm_to_node(int pxm);
 int acpi_get_node(acpi_handle handle);
+bool acpi_node_backed_by_real_pxm(int nid);
 
 /**
  * pxm_to_online_node - Map proximity ID to online node



