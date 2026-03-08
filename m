Return-Path: <linux-acpi+bounces-21516-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIgBA/L2rWnH+AEAu9opvQ
	(envelope-from <linux-acpi+bounces-21516-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 08 Mar 2026 23:23:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A96A2326C3
	for <lists+linux-acpi@lfdr.de>; Sun, 08 Mar 2026 23:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C535C3011BF2
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Mar 2026 22:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B0F33345A;
	Sun,  8 Mar 2026 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTqknhCy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932FA3254B3;
	Sun,  8 Mar 2026 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773008610; cv=none; b=stEm8exYdo36K5FTiBEWyYqCpudpgjkZBHXRoC6QXlehoOsESwhCCb/UsvFawd0mHinyAGjpoimxaf0k6CkePGc2IshxOLsQ+RlSI5vS7OSWmvLgSPn4V77Wqwrg1HXdddrINfzyZDwZ+j1axdYOCcVE+DVKLLNzmZ6MmiKGoog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773008610; c=relaxed/simple;
	bh=gnF//M08SIC7eL1RTK/Glm1RPsIHHM2SY6h/IvvpRAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tw7aR7seJvbIIrBb7ze7d+kG7Cme1QxqN+a4Pf7o6U+/Az/wMi/OdTxrJhtXC9jA76WUeip2IjrDObmcOAbLVeQiI3AIao1afp+2j08t0L8eLKAUS8YY9trOuQSgcE94Ov5XtVzobcM66gBSzBiZ++YHl4HvpIcFoxgW7hzbXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTqknhCy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773008608; x=1804544608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gnF//M08SIC7eL1RTK/Glm1RPsIHHM2SY6h/IvvpRAc=;
  b=hTqknhCy1Fp0WFPPU/ehcuwQWJ9o0Jydp25CwVBF/q248mGNOr8VJllt
   d5pQuJ6dLRL0aSXnLjZnoPaaW+qB7Ru4ADfx6RERGBBjMhepfWg5GyoJV
   TNMnZWI1S9Zv0hm6z836O95W78kfcijYUdpJnUD3KwmNskETLilX+PPVO
   Os06fnd/MNihZNmTe/+/y1zdqU6Gn6CeCM87OVaLJ9RL8yLjviFJ7znrc
   1RBSHr3Kdw+Gu0boa5IkMqJR/7nJUG2KSwWpqWSQpuElcbSdPFRnGFWsV
   PBo0UaitEHiA7Xck7dMMC4EXlfidbs6JCGdNXpzcmy/s3e8VEL/Tknqob
   Q==;
X-CSE-ConnectionGUID: TH04yyk6SUCusTdRXbjSQw==
X-CSE-MsgGUID: 9dh+4zihSh6NeOyZLQQp3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84745098"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="84745098"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 15:23:27 -0700
X-CSE-ConnectionGUID: HL2O/xKqQGOCA3X1NWtN9w==
X-CSE-MsgGUID: AKTBekdyTgyIsRsACMUzow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219699674"
Received: from khuang2-desk.gar.corp.intel.com ([10.124.221.128])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 15:23:22 -0700
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
Subject: [PATCH v2] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Date: Mon,  9 Mar 2026 11:23:13 +1300
Message-ID: <20260308222313.14014-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5A96A2326C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21516-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
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

v1 -> v2:

 - Use Dan's suggestion to simplify the diff:

 https://lore.kernel.org/linux-cxl/69a8dc7ca72c2_2f4a10026@dwillia2-mobl4.notmuch/

Hi Alison, Gregory,

I didn't add your RB since the code now is different from that you
reviewed.  Appreciate if you can take a look again and provide the tag
if the patch looks good to you.

---
 drivers/acpi/numa/srat.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index aa87ee1583a4..62d4a8df0b8c 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -654,8 +654,11 @@ int __init acpi_numa_init(void)
 	}
 	last_real_pxm = fake_pxm;
 	fake_pxm++;
-	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
-			      &fake_pxm);
+
+	/* No need to expand numa nodes if CXL is disabled */
+	if (IS_ENABLED(CONFIG_CXL_ACPI))
+		acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
+				      &fake_pxm);
 
 	if (cnt < 0)
 		return cnt;

base-commit: 084f843093bee5563b179fd4b630122ba820e0c7
-- 
2.53.0


