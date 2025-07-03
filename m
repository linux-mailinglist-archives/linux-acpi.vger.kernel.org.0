Return-Path: <linux-acpi+bounces-14983-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4294AF81BA
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 22:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE848585385
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 20:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6929295D96;
	Thu,  3 Jul 2025 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJE+b2Kh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02C2AF19;
	Thu,  3 Jul 2025 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751573100; cv=none; b=mIO3ziheWly9K9GneSnou50DAjJcjb3O8blx+8Knn5acAxSaysJ/iH35ehHFkLwdauqWAZ//Tiw9EN6wDUZOmZFpCwajyNjpGBi7HOnpeu1mGSn40gtTS/XYkAnuiw4NyDA67rrL2vTYcrTS69Hxeem+mZ3GerbbXQDZNVVm9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751573100; c=relaxed/simple;
	bh=8A6zCExYZEP4rbE455FW7xjkVxsegH5EtKHYm6w345E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is+biXyoQSfNBWrjdp8KnfnRpyPtNgPeuGd34SFvSLljmCE7hSgoPn+I42gb3fxP8bD76UwjvTgPDEWNpMUuJaWNQF6/I+5xyLPM2eOuuIT/qAaVmqkYOWHvbsHSeBnP7mkFvIcXn1hPyaoMXZIKzfEzuEz9ygHymlHSdBkA6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJE+b2Kh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751573099; x=1783109099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8A6zCExYZEP4rbE455FW7xjkVxsegH5EtKHYm6w345E=;
  b=AJE+b2KhIKy/GwInEHpYgGdLl6T6NVywtoYLMzUxZXmlN6lj8doe4Aei
   LlQ02EXjHDfBk6KsL41grBgjR44+b0QtAj93I64uDwORgptbuRpx5PyxT
   /DKpeBT7xUfNjSVGUOgAP5KDY7aMTidjxW9TI7wJgnlsIZjWOTIHIXuXu
   mo4WKN3XB2sggcDG06NC9MRTeyBJpTMrCbfwmUbQIWsQBo07zO8Ab1qjG
   GM9O9zkeEcOfpixEKIVl7M589B9W4FwKBLtK6qjKbT8ih6NPltaKHCOGw
   K+bGINRkPxVGwNPkM1TlnpRFoOncXE4JqZDq/EKpU/RsbszDQAmFX2pfM
   g==;
X-CSE-ConnectionGUID: COtmvcTqROWgT8uYur0b9w==
X-CSE-MsgGUID: J7XJbWteRQKaEP8XdUJfIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53782341"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53782341"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 13:04:58 -0700
X-CSE-ConnectionGUID: QW2DgLdnRSm+onWsnwyHAg==
X-CSE-MsgGUID: 2Nrr+cFIQkW/VweNHvWriQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="158498950"
Received: from agluck-desk3.sc.intel.com ([172.25.103.51])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 13:04:57 -0700
From: Tony Luck <tony.luck@intel.com>
To: zaidal@os.amperecomputing.com
Cc: Jonathan.Cameron@huawei.com,
	benjamin.cheatham@amd.com,
	bp@alien8.de,
	dan.carpenter@linaro.org,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	gregkh@linuxfoundation.org,
	gustavoars@kernel.org,
	ira.weiny@intel.com,
	james.morse@arm.com,
	jonathanh@nvidia.com,
	kees@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	rafael@kernel.org,
	sthanneeru.opensrc@micron.com,
	sudeep.holla@arm.com,
	tony.luck@intel.com,
	viro@zeniv.linux.org.uk,
	Yi1 Lai <yi1.lai@intel.com>
Subject: [PATCH] ACPI: APEI: EINJ: Fix trigger actions
Date: Thu,  3 Jul 2025 13:04:21 -0700
Message-ID: <20250703200421.28012-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250617193026.637510-2-zaidal@os.amperecomputing.com>
References: <20250617193026.637510-2-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trigger events are in BIOS memory immediately following the
acpi_einj_trigger structure. These were not copied to regular
kernel memory for use by apei_exec_ctx_init() so injections in
"notrigger=0" mode failed with a message like this:

  APEI: Invalid action table, unknown instruction type: 123

Fix by allocating a "table_size" block of memory and copying the whole
table for use in the rest of the trigger flow.

Fixes: 1a35c88302a3 ("ACPI: APEI: EINJ: Fix kernel test sparse warnings")
Reported-by: Yi1 Lai <yi1.lai@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/einj-core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 3d37978418e8..bf8dc92a373a 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -394,6 +394,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 				u64 param1, u64 param2)
 {
 	struct acpi_einj_trigger trigger_tab;
+	struct acpi_einj_trigger *full_trigger_tab;
 	struct apei_exec_context trigger_ctx;
 	struct apei_resources trigger_resources;
 	struct acpi_whea_header *trigger_entry;
@@ -430,6 +431,9 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 
 	rc = -EIO;
 	table_size = trigger_tab.table_size;
+	full_trigger_tab = kmalloc(table_size, GFP_KERNEL);
+	if (!full_trigger_tab)
+		goto out_rel_header;
 	r = request_mem_region(trigger_paddr + sizeof(trigger_tab),
 			       table_size - sizeof(trigger_tab),
 			       "APEI EINJ Trigger Table");
@@ -437,7 +441,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger Table Entry\n",
 		       (unsigned long long)trigger_paddr + sizeof(trigger_tab),
 		       (unsigned long long)trigger_paddr + table_size - 1);
-		goto out_rel_header;
+		goto out_free_trigger_tab;
 	}
 	iounmap(p);
 	p = ioremap_cache(trigger_paddr, table_size);
@@ -445,9 +449,9 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 		pr_err("Failed to map trigger table!\n");
 		goto out_rel_entry;
 	}
-	memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
+	memcpy_fromio(full_trigger_tab, p, table_size);
 	trigger_entry = (struct acpi_whea_header *)
-		((char *)&trigger_tab + sizeof(struct acpi_einj_trigger));
+		((char *)full_trigger_tab + sizeof(struct acpi_einj_trigger));
 	apei_resources_init(&trigger_resources);
 	apei_exec_ctx_init(&trigger_ctx, einj_ins_type,
 			   ARRAY_SIZE(einj_ins_type),
@@ -469,7 +473,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 
 		apei_resources_init(&addr_resources);
 		trigger_param_region = einj_get_trigger_parameter_region(
-			&trigger_tab, param1, param2);
+			full_trigger_tab, param1, param2);
 		if (trigger_param_region) {
 			rc = apei_resources_add(&addr_resources,
 				trigger_param_region->address,
@@ -500,6 +504,8 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 out_rel_entry:
 	release_mem_region(trigger_paddr + sizeof(trigger_tab),
 			   table_size - sizeof(trigger_tab));
+out_free_trigger_tab:
+	kfree(full_trigger_tab);
 out_rel_header:
 	release_mem_region(trigger_paddr, sizeof(trigger_tab));
 out:
-- 
2.50.0


