Return-Path: <linux-acpi+bounces-2340-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8893880F91A
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 22:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4585C281EA6
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 21:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6465163576;
	Tue, 12 Dec 2023 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCbsEDvs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBE7AD;
	Tue, 12 Dec 2023 13:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702416165; x=1733952165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kSQPBcRC7qiyHc9BBLXSnCeVZp/WbDJvRtGqOuMn0T0=;
  b=HCbsEDvsUnwkyuAyqqiaO5i+RheqKLg63SqAJzvvWs5b/oWjzJ3uQJzr
   U7cRA21iGEGEbse/Yx2em7SPmII7nV48gfQFFcnVWnq9kZYjfWS0OrPZl
   0y+IJcHHQct3IgYfMOUcpQYbCGi/OxS3LCx3Ryxi5Ywge2kA1cgtMXDhI
   yKt+DitqgCntcyACJqQw8dliRpkjECKhdRo6yJ8+MmKecECopd2qDteV6
   630iVayMmv0Vx8lEw2DxVDskN/OkOux8r0wHp72lRkv2b2lkU3eawTJbq
   l6E6R00govdti4l+76Mbu+TLHrx/WeU8mhb46ateDHg0x5QLEmFuoN0yY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2040514"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="2040514"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:22:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="17648342"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:22:45 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Erwin Tsaur <erwin.tsaur@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH] ACPI: extlog: Clear Extended Error Log status when RAS_CEC handled the error
Date: Tue, 12 Dec 2023 13:22:39 -0800
Message-ID: <20231212212239.8971-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When both CONFIG_RAS_CEC and CONFIG_ACPI_EXTLOG are enabled, Linux does
not clear the status word of the BIOS supplied error record for corrected
errors. This may prevent logging of subsequent uncorrected errors.

Fix by clearing the status.

Fixes: 23ba710a0864 ("x86/mce: Fix all mce notifiers to update the mce->kflags bitmask")
Reported-by: Erwin Tsaur <erwin.tsaur@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/acpi_extlog.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index e120a96e1eae..71e8d4e7a36c 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -145,9 +145,14 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	static u32 err_seq;
 
 	estatus = extlog_elog_entry_check(cpu, bank);
-	if (estatus == NULL || (mce->kflags & MCE_HANDLED_CEC))
+	if (!estatus)
 		return NOTIFY_DONE;
 
+	if (mce->kflags & MCE_HANDLED_CEC) {
+		estatus->block_status = 0;
+		return NOTIFY_DONE;
+	}
+
 	memcpy(elog_buf, (void *)estatus, ELOG_ENTRY_LEN);
 	/* clear record status to enable BIOS to update it again */
 	estatus->block_status = 0;
-- 
2.43.0


