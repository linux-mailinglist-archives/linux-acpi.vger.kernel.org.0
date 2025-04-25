Return-Path: <linux-acpi+bounces-13290-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B11AA9D1BB
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B8D9C6CAC
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59D224258;
	Fri, 25 Apr 2025 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="qSVWdVaT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D8B221DB3;
	Fri, 25 Apr 2025 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609667; cv=none; b=WZMfYW85kPVfr9d13hesu/OZXENN3XQqNsv0CgG2J7zcasIWxUY8OUnJXxm7IQR7i9eerCEcLILx8AvXk+ObcLw1n8ieWC+VCEqUoR/JyEswK4aE4+Ii6FCQlEMFWVMeCQ4cp2OvBULQvR3iJYqfo9ynCdkI6ROqHFZpGMdE4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609667; c=relaxed/simple;
	bh=FN3hnqGPY4LFNhdmVYAu29GDjXUqmmCaeDcPGNySkCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj5DiIdeTk+aANcx+D6BBB+/cBot77MTpYRVd1ET8cwqR8rGoMnCpnsf/60hgNF+Hwgf3ZFZfdZfhjypr+hsReEMADjQv35AFsV+194QsRPE7nyLby1JckBpqWmupVl+Fh9iGGSHooMsrE7LEPir4UGPsArRZ8/sJGxn4CWo1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=qSVWdVaT; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id BD2DE664A8B;
	Fri, 25 Apr 2025 21:34:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609661;
	bh=FN3hnqGPY4LFNhdmVYAu29GDjXUqmmCaeDcPGNySkCY=;
	h=From:Subject:Date;
	b=qSVWdVaTLE23iBep5drLDDLsvXrxRBZZD/0ub6cOaa2ssK768NearTmQgBdUvHcv5
	 bzR6sxUp1hbHDh3k6uhC1dZJucq4gfmiv6TFWyj9mgF/UhF51VVRAnDeafPRNWVNXe
	 w9i+It1Hq3NME+c0DRaVTdygAKHemCAjK6J3EVLxCN9xZeh2e9xPGOq6ZRujN8NVs9
	 wlMuyCWOyR2W38vj9dZupmsJAR8OE6t1h3SFyeW6P2bEfHJqQS/EErITubAIotXeDp
	 qRSkdd1oZdkdkQqs1yQghbxpANWfKsHqUR3/Ubq81i+Xea5ryrxzQDV3Zk6lvDRscz
	 q/xSLBldNtQhw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 08/19] ACPICA: MRRM: Some cleanups
Date: Fri, 25 Apr 2025 21:25:23 +0200
Message-ID: <2018955.PYKUYFuaPT@rjwysocki.net>
In-Reply-To: <12671029.O9o76ZdvQC@rjwysocki.net>
References: <12671029.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Tony Luck <tony.luck@intel.com>

ACPICA commit 022e2e4169841f429dbda677a4780830bf4c2177

 1) Added source specification to MRRM table comment in actbl2.h

 2) Shorten typedef from ACPI_TABLE_MRRM_MEM_RANGE_ENTRY to
    struct acpi_mrrm_mem_range_entry

 3) Add new typedefs to source/tools/acpisrc/astable.c

 4) Fix cut and paste errors in acpi_dm_table_info_mrrm0[] definition

 5) Fix indent and source code style errors in actbl2.h

 6) The base/length fields in the memory range structure are system
    memory addresses, not "MMIO". Update the acpi_dm_table_info_mrrm0[]
    strings.

 7) Add main/sub table comments to acpi_dm_dump_mrrm() and dt_compile_mrrm()

Link: https://github.com/acpica/acpica/commit/022e2e41
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 0ae9d9915d58..274b3b85b6d7 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1741,6 +1741,8 @@ struct acpi_msct_proximity {
 /*******************************************************************************
  *
  * MRRM - Memory Range and Region Mapping (MRRM) table
+ * Conforms to "Intel Resource Director Technology Architecture Specification"
+ * Version 1.1, January 2025
  *
  ******************************************************************************/
 
@@ -1756,13 +1758,13 @@ struct acpi_table_mrrm {
 #define ACPI_MRRM_FLAGS_REGION_ASSIGNMENT_OS    (1<<0)
 
 /*******************************************************************************
- *
- * Memory Range entry - Memory Range entry in MRRM table
- *
- ******************************************************************************/
+	*
+	* Memory Range entry - Memory Range entry in MRRM table
+	*
+	******************************************************************************/
 
-struct acpi_table_mrrm_mem_range_entry {
-	ACPI_SUBTABLE_HEADER_16 header;
+struct acpi_mrrm_mem_range_entry {
+	struct acpi_subtable_header_16 header;
 	u32 reserved0;		/* Reserved */
 	u64 addr_base;		/* Base addr of the mem range */
 	u64 addr_len;		/* Length of the mem range */
-- 
2.43.0





