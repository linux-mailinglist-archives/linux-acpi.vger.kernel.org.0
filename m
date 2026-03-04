Return-Path: <linux-acpi+bounces-21357-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EGvOUulqGkYwQAAu9opvQ
	(envelope-from <linux-acpi+bounces-21357-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 22:34:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AB520803D
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 22:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 618BD300C334
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 21:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AF637186A;
	Wed,  4 Mar 2026 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9EaJNER"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C226347FFB;
	Wed,  4 Mar 2026 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660040; cv=none; b=eHp2Mk4+b1Nxh43y1KaBhrpVig8biN8VkaClTzIE2V8Tkd7Pe1O///U+AgqSEfG/dAomxmPZ42Oar4FUFUd47+F7tp3HJUasFab8i2mM9EI679qBL5eU31PUmD/82/wlR9bF8eKmTRGKh8/sR4ubRDuxYOM6ORB5ii5I8gMH6lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660040; c=relaxed/simple;
	bh=ItTdTZld/qLvHPCP1fFcWCP0cgyeAufCqeGF3cWaN0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WxAThCtg0+ZY3el7tQ80Kbp1vK2fXJlg/bCfRflmONSQn61+7PcDmbl/V6TVKcwCIIfVjR7QaTZEndW3FbFuYCA1pEHk1BhqX5Gyrfp0TQ85FptrkVsjMs/+3SG502CDD2EEqF3vS1Lh2Wf5JXveu22c8GiXVN6te6NNfkuyN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9EaJNER; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772660037; x=1804196037;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ItTdTZld/qLvHPCP1fFcWCP0cgyeAufCqeGF3cWaN0c=;
  b=D9EaJNERehxOqqywHwaHbcHBS1ByIPuyIAQG4IDHMBxekQy48I2VRlLh
   1AUjc0c11czlbC91yt1T/NuYrWZhe35YjGGJ8e6HzgzL1BvusVqoArv1n
   6OvLSzV3MGJyrkv/fmW4ggjzB8ssvq9LPobw4EoMNmjjGtwT0VdHctHlm
   nwIs7TMgrvD35rKS5gBGSK1zbjUfdm1hvjp6eLX5KSuD331Bw7mQddkK0
   ZxN4ZXmJ3e9aRKk3XVnFtsueUvG4tGemDHIUimAHkaBS/gnhWKMjPDRaV
   CiAfC9UvEUafUFf/vJedC7wbwwQm4+bF1MlhANHM8+BUIVTZdSI7kodwe
   A==;
X-CSE-ConnectionGUID: xM3BIQ2oTtu5Fx9a9SOKGw==
X-CSE-MsgGUID: 09hX3H1xRM6Zid3WstOdCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="85205699"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="85205699"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 13:33:56 -0800
X-CSE-ConnectionGUID: j5OSuaFwQOGtfm4nZ6GHeg==
X-CSE-MsgGUID: fdkELOFhQ7K43QGoMRIECw==
X-ExtLoop1: 1
Received: from khuang2-desk.gar.corp.intel.com ([10.124.220.189])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 13:33:52 -0800
From: Kai Huang <kai.huang@intel.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	alison.schofield@intel.com
Cc: akpm@linux-foundation.org,
	nunodasneves@linux.microsoft.com,
	xueshuai@linux.alibaba.com,
	thorsten.blum@linux.dev,
	gourry@gourry.net,
	wangyuquan1236@phytium.com.cn,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai Huang <kai.huang@intel.com>
Subject: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Date: Thu,  5 Mar 2026 10:33:42 +1300
Message-ID: <20260304213342.5776-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40AB520803D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21357-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On CXL platforms, the Static Resource Affinity Table (SRAT) may not
cover memory affinity information for all the CXL memory regions.  Since
each CXL memory region is enumerated via a CXL Fixed Memory Window
Structure (CFMWS), during early boot the kernel parses the CFMWS tables
to find all CXL memory regions and sets a NUMA node for each of them.
This memory affinity information of CXL memory regions is later used by
the CXL ACPI driver.

The CFMWS table doesn't provide the memory affinity information either.
Currently the kernel assigns a 'faked' NUMA node for each CXL memory
region, starting from the next node of the highest node that is
enumerated via the SRAT.  This can potentially increase the maximum NUMA
node ID of the platform ('nr_node_ids') a lot.  E.g., on a GNR platform
with 4 NUMA nodes and 18 CFMWS tables, this bumps the 'nr_node_ids' to
22.

Increasing the 'nr_node_ids' has side effects.  For instance, it is
widely used by the kernel for "highest possible NUMA node" based memory
allocations.  It also impacts userspace ABIs, e.g., some NUMA memory
related system calls such as 'get_mempolicy' which requires 'maxnode'
not being smaller than the 'nr_node_ids'.

Currently parsing CFMWS tables and assigning faked NUMA node at boot is
done unconditionally.  However, if the CXL ACPI driver is not enabled,
there will be no user of such memory affinity information of CXL memory
regions.

Change to only parsing the CFMWS tables at boot when CXL_ACPI is enabled
in Kconfig to avoid the unnecessary cost of bumping up 'nr_node_ids'.

E.g., on the aforementioned GNR platform, the "Slab" in /proc/meminfo is
reduced with this change (when CXL_ACPI is off):

	w/ this change		w/o

Slab	900488 kB		923660 kB

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 drivers/acpi/numa/srat.c | 45 +++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index aa87ee1583a4..c008fe1f15f7 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -425,6 +425,7 @@ acpi_parse_memory_affinity(union acpi_subtable_headers *header,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_CXL_ACPI)
 static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 				   void *arg, const unsigned long table_end)
 {
@@ -476,6 +477,31 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	return 0;
 }
 
+static void __init acpi_numa_init_cxl(void)
+{
+	int i, fake_pxm;
+
+	/*
+	 * CXL Fixed Memory Window Structures (CFMWS) must be parsed
+	 * after the SRAT. Create NUMA Nodes for CXL memory ranges that
+	 * are defined in the CFMWS and not already defined in the SRAT.
+	 * Initialize a fake_pxm as the first available PXM to emulate.
+	 */
+
+	/* fake_pxm is the next unused PXM value after SRAT parsing */
+	for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
+		if (node_to_pxm_map[i] > fake_pxm)
+			fake_pxm = node_to_pxm_map[i];
+	}
+	last_real_pxm = fake_pxm;
+	fake_pxm++;
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
+			      &fake_pxm);
+}
+#else
+static void __init acpi_numa_init_cxl(void) {}
+#endif
+
 void __init __weak
 acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 {
@@ -602,7 +628,7 @@ acpi_table_parse_srat(enum acpi_srat_type id,
 
 int __init acpi_numa_init(void)
 {
-	int i, fake_pxm, cnt = 0;
+	int cnt = 0;
 
 	if (acpi_disabled)
 		return -EINVAL;
@@ -640,22 +666,7 @@ int __init acpi_numa_init(void)
 	/* SLIT: System Locality Information Table */
 	acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
 
-	/*
-	 * CXL Fixed Memory Window Structures (CFMWS) must be parsed
-	 * after the SRAT. Create NUMA Nodes for CXL memory ranges that
-	 * are defined in the CFMWS and not already defined in the SRAT.
-	 * Initialize a fake_pxm as the first available PXM to emulate.
-	 */
-
-	/* fake_pxm is the next unused PXM value after SRAT parsing */
-	for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
-		if (node_to_pxm_map[i] > fake_pxm)
-			fake_pxm = node_to_pxm_map[i];
-	}
-	last_real_pxm = fake_pxm;
-	fake_pxm++;
-	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
-			      &fake_pxm);
+	acpi_numa_init_cxl();
 
 	if (cnt < 0)
 		return cnt;

base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
-- 
2.53.0


