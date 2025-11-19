Return-Path: <linux-acpi+bounces-19047-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DB5C6C3F6
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 02:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78BAF4E5896
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 01:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BAE22DFA4;
	Wed, 19 Nov 2025 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvTa9Qsl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C333702FB;
	Wed, 19 Nov 2025 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763515642; cv=none; b=B2GEPzz8xGvWUq3Bfs9KjJY/QKoXLIoRqvAgfLi7FOEU6qbGw8Dc4SB3XxJ+wrD+VDbLxppH3T3YxplkceUc9P9d6ToTnwbJETKfrNJqSGwoQckMECGQUbxDiUft/MgozM554b7FjX+XBaiwwaNMTGxwQOhJRQVQV9B5c8/9XWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763515642; c=relaxed/simple;
	bh=2CClMEmP/Cw1IcOHS33O8LYqfja9xn4f1ovoIFYv4yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K00kD4B72uNSzlY9xT9DP8NME17oCTx3AanEcrQjDSzvT4JHxdHrrTz5Brn+pZE0GhCqKMARF1csffWeq9QbTjXbgOG1xUl+uNxbzPTzsHxY3Q78F4o4nZuEKb4IQsEgUNJ6tygKi/xN1Usv9Ds3ce5j2brpli4sSHQSeKmX/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvTa9Qsl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763515640; x=1795051640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2CClMEmP/Cw1IcOHS33O8LYqfja9xn4f1ovoIFYv4yg=;
  b=cvTa9Qsl3BXsFYwhslwzQRvdnZ9WGuhztAb/iii4FpEkPFwhTpj7S8sP
   5jnwQ7UKPazJrDpzh8yKwrJQrSmIG+LZVoDVHuZgTgKuHZYS55iMqOXqb
   BLGFZzJKma3/3TlbqhKrT1AoYLEBpbE29yDZry0PVaAJ6F7Teeu6xHsiQ
   h+pWA9C1bl32kFpxCccQRBPy3iQAC3K//hL7JyXeLhov0G5WpNybD7Rce
   wfm/8uiOTB/JQulqMMWhRtAEKZxovdJaMqKToTx1P4H8T6vxAr3SKRSXo
   k6ma8qsDKpbS+ssZCB3ly0IPM1azpPAA3VOn8LoNYrI56V6bF8J19ZtPq
   A==;
X-CSE-ConnectionGUID: ZBn0RkKpRGGGcAbkgSnoVQ==
X-CSE-MsgGUID: BS5HHlSTQ/GVGWWVL9pilw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65448904"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65448904"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 17:27:19 -0800
X-CSE-ConnectionGUID: y3Z60DCsRzyYVa253N6FEQ==
X-CSE-MsgGUID: 9LrS2Ee6RpmyGK07Ew5q+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190716999"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.221.33])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 17:27:18 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: bp@alien8.de,
	guohanjun@huawei.com,
	lenb@kernel.org,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	yi1.lai@intel.com,
	zaidal@os.amperecomputing.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH] ACPI: APEI: EINJ: Fix EINJV2 initialization and injection
Date: Tue, 18 Nov 2025 17:27:12 -0800
Message-ID: <20251119012712.178715-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI 6.6 specification for EINJV2 appends an extra structure to
the end of the existing struct set_error_type_with_address.

Several issues showed up in testing.

1) Initialization was broken by an earlier fix[1] since is_v2 is only set
   while performing an injection, not during initialization.

2) A buggy BIOS provided invalid "revision" and "length" for the extension
   structure. Add several sanity checks.

3) When injecting legacy error types on an EINJV2 capable system don't
   copy the component arrays.

Fixes: 6c7058514991 ("ACPI: APEI: EINJ: Check if user asked for EINJV2 injection") # [1]
Fixes: b47610296d17 ("ACPI: APEI: EINJ: Enable EINJv2 error injections")
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/einj-core.c | 64 ++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 3c87953dbd19..305c240a303f 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -182,6 +182,7 @@ bool einj_initialized __ro_after_init;
 
 static void __iomem *einj_param;
 static u32 v5param_size;
+static u32 v66param_size;
 static bool is_v2;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
@@ -283,6 +284,24 @@ static void check_vendor_extension(u64 paddr,
 	acpi_os_unmap_iomem(p, sizeof(v));
 }
 
+static u32 einjv2_init(struct einjv2_extension_struct *e)
+{
+	if (e->revision != 1) {
+		pr_info("Unknown v2 extension revision %u\n", e->revision);
+		return 0;
+	}
+	if (e->length < sizeof(*e) || e->length > PAGE_SIZE) {
+		pr_info(FW_BUG "Bad1 v2 extension length %u\n", e->length);
+		return 0;
+	}
+	if ((e->length - sizeof(*e)) % sizeof(e->component_arr[0])) {
+		pr_info(FW_BUG "Bad2 v2 extension length %u\n", e->length);
+		return 0;
+	}
+
+	return (e->length - sizeof(*e)) / sizeof(e->component_arr[0]);
+}
+
 static void __iomem *einj_get_parameter_address(void)
 {
 	int i;
@@ -310,28 +329,21 @@ static void __iomem *einj_get_parameter_address(void)
 		v5param_size = sizeof(v5param);
 		p = acpi_os_map_iomem(pa_v5, sizeof(*p));
 		if (p) {
-			int offset, len;
-
 			memcpy_fromio(&v5param, p, v5param_size);
 			acpi5 = 1;
 			check_vendor_extension(pa_v5, &v5param);
-			if (is_v2 && available_error_type & ACPI65_EINJV2_SUPP) {
-				len = v5param.einjv2_struct.length;
-				offset = offsetof(struct einjv2_extension_struct, component_arr);
-				max_nr_components = (len - offset) /
-						sizeof(v5param.einjv2_struct.component_arr[0]);
-				/*
-				 * The first call to acpi_os_map_iomem above does not include the
-				 * component array, instead it is used to read and calculate maximum
-				 * number of components supported by the system. Below, the mapping
-				 * is expanded to include the component array.
-				 */
+			if (available_error_type & ACPI65_EINJV2_SUPP) {
+				struct einjv2_extension_struct *e;
+
+				e = &v5param.einjv2_struct;
+				max_nr_components = einjv2_init(e);
+
+				/* remap including einjv2_extension_struct */
 				acpi_os_unmap_iomem(p, v5param_size);
-				offset = offsetof(struct set_error_type_with_address, einjv2_struct);
-				v5param_size = offset + struct_size(&v5param.einjv2_struct,
-					component_arr, max_nr_components);
-				p = acpi_os_map_iomem(pa_v5, v5param_size);
+				v66param_size = v5param_size - sizeof(*e) + e->length;
+				p = acpi_os_map_iomem(pa_v5, v66param_size);
 			}
+
 			return p;
 		}
 	}
@@ -527,6 +539,7 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			       u64 param3, u64 param4)
 {
 	struct apei_exec_context ctx;
+	u32 param_size = is_v2 ? v66param_size : v5param_size;
 	u64 val, trigger_paddr, timeout = FIRMWARE_TIMEOUT;
 	int i, rc;
 
@@ -539,11 +552,11 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	if (acpi5) {
 		struct set_error_type_with_address *v5param;
 
-		v5param = kmalloc(v5param_size, GFP_KERNEL);
+		v5param = kmalloc(param_size, GFP_KERNEL);
 		if (!v5param)
 			return -ENOMEM;
 
-		memcpy_fromio(v5param, einj_param, v5param_size);
+		memcpy_fromio(v5param, einj_param, param_size);
 		v5param->type = type;
 		if (type & ACPI5_VENDOR_BIT) {
 			switch (vendor_flags) {
@@ -601,7 +614,7 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				break;
 			}
 		}
-		memcpy_toio(einj_param, v5param, v5param_size);
+		memcpy_toio(einj_param, v5param, param_size);
 		kfree(v5param);
 	} else {
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
@@ -1132,9 +1145,14 @@ static void einj_remove(struct faux_device *fdev)
 	struct apei_exec_context ctx;
 
 	if (einj_param) {
-		acpi_size size = (acpi5) ?
-			v5param_size :
-			sizeof(struct einj_parameter);
+		acpi_size size;
+
+		if (v66param_size)
+			size = v66param_size;
+		else if (acpi5)
+			size = v5param_size;
+		else
+			size = sizeof(struct einj_parameter);
 
 		acpi_os_unmap_iomem(einj_param, size);
 		if (vendor_errors.size)
-- 
2.51.1


