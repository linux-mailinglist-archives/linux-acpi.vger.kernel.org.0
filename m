Return-Path: <linux-acpi+bounces-18475-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F129FC2E603
	for <lists+linux-acpi@lfdr.de>; Tue, 04 Nov 2025 00:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CD3E4E9179
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 23:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7D62FE56E;
	Mon,  3 Nov 2025 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVTAqsao"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B62FC037;
	Mon,  3 Nov 2025 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211161; cv=none; b=Cxh4Db9q7pZx6bkWBQ/9VAVsiE1lyLwiqM+RSg/STKBQ48ft8gaYmfVJ6yshgAznK6A4zT3pZ394Xpyh77ilyObK84GkazWlRZG7Rn1bi33YLqaubKSu8GjDenCZoVstJLCUUtVZBNuBZ1Cht9DVjPKdh6f+7gX0tcVCcU9mgIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211161; c=relaxed/simple;
	bh=yqb+lQ7fKBLnHXkoJuuGAgVYHvCIKuQEhXrNGYrB9IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGQHOAhxDQIpo2vVWsmVsMr+d9QJPgC0AA8nmrSOtcZRMRs2IVsir1Ty2iMJNXliAMdrOIrXEg/zRBOsRU18p+rZpq+akQKEONQrGcAVxJB+bc9PoJs5TEvkQIe86Q7zt9SDi9zcgFXCBAHklw1sao1QBKPJvfDotaByVb+ImMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVTAqsao; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762211160; x=1793747160;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yqb+lQ7fKBLnHXkoJuuGAgVYHvCIKuQEhXrNGYrB9IQ=;
  b=LVTAqsao9ajKVVNZ7dcg2fy4Uiq9pbAHUyIEFtyvDw82M4SgjdT+zyj9
   6ZbYCvAE2gz0oK8DtjGPZyvlyRQ5QiaLOjSUaqhjSKreXWUcy3VkNlLW1
   Ra/vmr6cBdVIfFmhsLFN2gKgiJk25Uab4GrmI45PH3M9atSH/LmBIAaZw
   hMXELlSgosO8N4qAscj+fq+TGN8akslzw30VH5sLmvbO02FUy2sZd7bXv
   J7X2dcfzRKRCtp+e/DblML2SFkkQEGopjIjuIfm/6mSVVvtvKx8v4+Srq
   gDrMNj3CESqMXaHOn8NR20eXE9riFjCq+d3AA9otY8xgDvle/F6V/ff9/
   A==;
X-CSE-ConnectionGUID: eJLAM3ZnR/mfYbj5aTY7cg==
X-CSE-MsgGUID: 0kSpcl8lT964shIKWAO4dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63310419"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="63310419"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:06:00 -0800
X-CSE-ConnectionGUID: 337uyCQTSwC3PM+2sEsCjQ==
X-CSE-MsgGUID: zykQcdenQZibtJp7SI+qFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="191340930"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.221.2])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:05:59 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Andi Kleen <andi.kleen@intel.com>
Subject: [PATCH] ACPI: APEI: GHES: Improve ghes_notify_nmi() status check
Date: Mon,  3 Nov 2025 15:05:47 -0800
Message-ID: <20251103230547.8715-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ghes_notify_nmi() is called for every NMI and must check whether the NMI was
generated because an error was signalled by platform firmware.

This check is very expensive as for each registered GHES NMI source it reads
from the acpi generic address attached to this error source to get the physical
address of the acpi_hest_generic_status block.  It then checks the "block_status"
to see if an error was logged.

The ACPI/APEI code must create virtual mappings for each of those physical
addresses, and tear them down afterwards. On an Icelake system this takes around
15,000 TSC cycles. Enough to disturb efforts to profile system performance.

If that were not bad enough, there are some atomic accesses in the code path
that will cause cache line bounces between CPUs. A problem that gets worse as
the core count increases.

But BIOS changes neither the acpi generic address nor the physical address of
the acpi_hest_generic_status block. So this walk can be done once when the NMI is
registered to save the virtual address (unmapping if the NMI is ever unregistered).
The "block_status" can be checked directly in the NMI handler. This can be done
without any atomic accesses.

Resulting time to check that there is not an error record is around 900 cycles.

Reported-by: Andi Kleen <andi.kleen@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>

---
N.B. I only talked to an Intel BIOS expert about this. GHES code is shared by
other architectures, so it would be wise to get confirmation on whether this
assumption applies to all, or is Intel (or X86) specific.
---
 include/acpi/ghes.h      |  1 +
 drivers/acpi/apei/ghes.c | 39 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index ebd21b05fe6e..58655d313a1f 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -29,6 +29,7 @@ struct ghes {
 	};
 	struct device *dev;
 	struct list_head elist;
+	void __iomem *error_status_vaddr;
 };
 
 struct ghes_estatus_node {
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 97ee19f2cae0..62713b612865 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1425,7 +1425,21 @@ static LIST_HEAD(ghes_nmi);
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
 	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_nmi);
+	bool active_error = false;
 	int ret = NMI_DONE;
+	struct ghes *ghes;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
+		if (ghes->error_status_vaddr && readl(ghes->error_status_vaddr)) {
+			active_error = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	if (!active_error)
+		return ret;
 
 	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
 		return ret;
@@ -1439,13 +1453,26 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 	return ret;
 }
 
-static void ghes_nmi_add(struct ghes *ghes)
+static int ghes_nmi_add(struct ghes *ghes)
 {
+	struct acpi_hest_generic *g = ghes->generic;
+	u64 paddr;
+	int rc;
+
+	rc = apei_read(&paddr, &g->error_status_address);
+	if (rc)
+		return rc;
+	ghes->error_status_vaddr = acpi_os_ioremap(paddr, sizeof(ghes->estatus->block_status));
+	if (!ghes->error_status_vaddr)
+		return AE_BAD_ADDRESS;
+
 	mutex_lock(&ghes_list_mutex);
 	if (list_empty(&ghes_nmi))
 		register_nmi_handler(NMI_LOCAL, ghes_notify_nmi, 0, "ghes");
 	list_add_rcu(&ghes->list, &ghes_nmi);
 	mutex_unlock(&ghes_list_mutex);
+
+	return 0;
 }
 
 static void ghes_nmi_remove(struct ghes *ghes)
@@ -1455,6 +1482,10 @@ static void ghes_nmi_remove(struct ghes *ghes)
 	if (list_empty(&ghes_nmi))
 		unregister_nmi_handler(NMI_LOCAL, "ghes");
 	mutex_unlock(&ghes_list_mutex);
+
+	if (ghes->error_status_vaddr)
+		iounmap(ghes->error_status_vaddr);
+
 	/*
 	 * To synchronize with NMI handler, ghes can only be
 	 * freed after NMI handler finishes.
@@ -1462,7 +1493,7 @@ static void ghes_nmi_remove(struct ghes *ghes)
 	synchronize_rcu();
 }
 #else /* CONFIG_HAVE_ACPI_APEI_NMI */
-static inline void ghes_nmi_add(struct ghes *ghes) { }
+static inline int ghes_nmi_add(struct ghes *ghes) { return -EINVAL; }
 static inline void ghes_nmi_remove(struct ghes *ghes) { }
 #endif /* CONFIG_HAVE_ACPI_APEI_NMI */
 
@@ -1630,7 +1661,9 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		ghes_sea_add(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_NMI:
-		ghes_nmi_add(ghes);
+		rc = ghes_nmi_add(ghes);
+		if (rc)
+			goto err;
 		break;
 	case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
 		rc = apei_sdei_register_ghes(ghes);
-- 
2.51.0


