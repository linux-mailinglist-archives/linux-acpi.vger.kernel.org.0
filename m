Return-Path: <linux-acpi+bounces-20311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C24CD1EE10
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9814130AEE02
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E50E39A808;
	Wed, 14 Jan 2026 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp1g4DVs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5939903E;
	Wed, 14 Jan 2026 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394555; cv=none; b=cINps+30boHUIlO/HPG0Vbm/YSGg69wtJkF5p76g5x9kMlHnaBkXwh2IF0i1cMqroO/tLDRZlT54DpA5e8YTcFbQjNAp/OLCOlJyCQUM3prADnqtfkxJ63gpshD7DlRW3fYV5jHvmTLMzBSNqRGnvdlGlXcDBVxvoG/UV8LmNdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394555; c=relaxed/simple;
	bh=oifnIdgpltIk5WhKX2cgCCu1LgAV5qUFS5G3RgRQtFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+S05g0WMhW+XXyDGo3+1igO/UXoE/v/Z5VRyI3BdOUK15HvYkP/SBp0q6a3rnXjrUXWqJ/7K5ae5RKKn0eUqHaRh5P+c94v9mKWt1XVcYqsLBIxDT3wkedygg/aj14MvrU864BDtwgYD68htvvWYp02kXjFHro+itOQtd8pgGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp1g4DVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03031C4CEF7;
	Wed, 14 Jan 2026 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394555;
	bh=oifnIdgpltIk5WhKX2cgCCu1LgAV5qUFS5G3RgRQtFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dp1g4DVsGA3QqXjf2U7R5woGsIAGrUZxWj2ue0jHIsRcyO8Y4sC4ltRIBS+KfqnMf
	 tLr/3/ttAZ1shuE2qQYuBUPppLJ1npN8a7E5M6x6cEwsWvBtzNoquK1JcKuk9QEr/5
	 Bs39aSUinj9QCp+cYu4injMlwhbtf2jjFcPb/fxltzYaKSioUGWCwgcOCZNCd3Gu4u
	 cTqHqP7nDhyljaBEDU0AzlMtDclHSkRxC1MHCN3T3IJy+2G8mLyCq9aV8T+GdWaGOo
	 kFRauMuuIYwArtKTEkH99+l+8L3X0DsUd2OXGdo/OOhbo9wfXSufOkg7MdEF2/IMVT
	 Rw6qGPfuFIusw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 06/26] ACPICA: Add KEYP table definition
Date: Wed, 14 Jan 2026 13:21:05 +0100
Message-ID: <3401908.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12822121.O9o76ZdvQC@rafael.j.wysocki>
References: <12822121.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Dave Jiang <dave.jiang@intel.com>

Software uses this table to discover the base address of the Key
Configuration Unit (KCU) register block associated with each IDE capable
host bridge.

[1]: Root Complex IDE Key Configuration Unit Software Programming Guide
     https://cdrdv2.intel.com/v1/dl/getContent/732838

Link: https://github.com/acpica/acpica/commit/af970172e2dd
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 59 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index f726bce3eb84..4040e4df051b 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -32,6 +32,7 @@
 #define ACPI_SIG_ERDT           "ERDT"	/* Enhanced Resource Director Technology */
 #define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
+#define ACPI_SIG_KEYP           "KEYP"	/* Key Programming Interface for IDE */
 #define ACPI_SIG_LPIT           "LPIT"	/* Low Power Idle Table */
 #define ACPI_SIG_MADT           "APIC"	/* Multiple APIC Description Table */
 #define ACPI_SIG_MCFG           "MCFG"	/* PCI Memory Mapped Configuration table */
@@ -1065,6 +1066,64 @@ struct acpi_ivrs_memory {
 	u64 memory_length;
 };
 
+/*******************************************************************************
+ *
+ * KEYP - Key Programming Interface for Root Complex Integrity and Data
+ *        Encryption (IDE)
+ *        Version 1
+ *
+ * Conforms to "Key Programming Interface for Root Complex Integrity and Data
+ * Encryption (IDE)" document. See under ACPI-Related Documents.
+ *
+ ******************************************************************************/
+struct acpi_table_keyp {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 reserved;
+};
+
+/* KEYP common subtable header */
+
+struct acpi_keyp_common_header {
+	u8 type;
+	u8 reserved;
+	u16 length;
+};
+
+/* Values for Type field above */
+
+enum acpi_keyp_type {
+	ACPI_KEYP_TYPE_CONFIG_UNIT = 0,
+};
+
+/* Root Port Information Structure */
+
+struct acpi_keyp_rp_info {
+	u16 segment;
+	u8 bus;
+	u8 devfn;
+};
+
+/* Key Configuration Unit Structure */
+
+struct acpi_keyp_config_unit {
+	struct acpi_keyp_common_header header;
+	u8 protocol_type;
+	u8 version;
+	u8 root_port_count;
+	u8 flags;
+	u64 register_base_address;
+	struct acpi_keyp_rp_info rp_info[];
+};
+
+enum acpi_keyp_protocol_type {
+	ACPI_KEYP_PROTO_TYPE_INVALID = 0,
+	ACPI_KEYP_PROTO_TYPE_PCIE,
+	ACPI_KEYP_PROTO_TYPE_CXL,
+	ACPI_KEYP_PROTO_TYPE_RESERVED
+};
+
+#define ACPI_KEYP_F_TVM_USABLE      (1)
+
 /*******************************************************************************
  *
  * LPIT - Low Power Idle Table
-- 
2.51.0





