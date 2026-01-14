Return-Path: <linux-acpi+bounces-20309-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DECD1EDB9
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20151302B8DB
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75233399A71;
	Wed, 14 Jan 2026 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv4zcA7o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3B399A59;
	Wed, 14 Jan 2026 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394549; cv=none; b=eUfoK9XQAi+xm05kkMGbQV6izuByBB39d9/yMyU/kzuVuPaNwpL3K4x3GUlempZs4C8IYtZ0Nez3XPz9e4pwLCBRENWcldgSuQfz5TUqbVwmu7rAFLvHzQoQy4qe21YgFYo58qMshFj39r+cxLI9yYoZ+dlHfnqraapXRmftbmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394549; c=relaxed/simple;
	bh=xI8jSJuS7WLQILU0hgQPK3upi4T/SluamvPCusD92zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GeBgg/K582vzCIWeoKEkPAdRFWuRtKSldrsYHxezRqeB8KKhFfrAmzSJ+wvSZPWiQ0dx+YIt1QgtvVNf4NqTnT2b4r51zicaXpJJsYRMnECZxjtKxbqmkxEjU1OV4ot8dcwJXF/5H339gLdljn1GA9/20T+wp9vY7dxJgaqiA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv4zcA7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10571C4CEF7;
	Wed, 14 Jan 2026 12:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394549;
	bh=xI8jSJuS7WLQILU0hgQPK3upi4T/SluamvPCusD92zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gv4zcA7oZxfEvd4s4VwwzodCRy+7BPn/GdiPYnWu0v8Z1SSbCfrF1ioMusR5C8J0q
	 SjNxO9HpxRH2tHv43fNsnuPStyW1relGjmJ3hM0VncbhqnIWTrOirDclxavEduzIos
	 ruECdOY1t7Rz868AE8K+grxV/EEbohNetk1kK0txByt/sZYto/8DqGH/7nuSxOnqnm
	 m0LIJDLe3ncyd5Ws2E23jPgjP6tg4vl2Y+korjuCIQp9XNMfDEO8GEU462GWWdFMKV
	 GNPSjwhicUGwlfkKooW5YsRkWs6M/nisDmeSq/edSILt3Lqh+oTV0oHKejJ3UHXHre
	 8CxV5P7keIGGg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 08/26] ACPICA: iASL: Add definitions for the IOVT table
Date: Wed, 14 Jan 2026 13:22:50 +0100
Message-ID: <2031013.PYKUYFuaPT@rafael.j.wysocki>
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

From: Xianglai Li <lixianglai@loongson.cn>

Add definitions for the IOVT table and its subtables.

Link: https://github.com/acpica/acpica/commit/14c0def532ac
Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 68 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 4040e4df051b..617be4bd3d4a 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -31,6 +31,7 @@
 #define ACPI_SIG_CDAT           "CDAT"	/* Coherent Device Attribute Table */
 #define ACPI_SIG_ERDT           "ERDT"	/* Enhanced Resource Director Technology */
 #define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
+#define ACPI_SIG_IOVT           "IOVT"	/* I/O Virtualization Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
 #define ACPI_SIG_KEYP           "KEYP"	/* Key Programming Interface for IDE */
 #define ACPI_SIG_LPIT           "LPIT"	/* Low Power Idle Table */
@@ -859,6 +860,73 @@ struct acpi_iort_rmr_desc {
 	u32 reserved;
 };
 
+/*******************************************************************************
+ *
+ * IOVT - I/O Virtualization Table
+ *
+ * Conforms to "LoongArch I/O Virtualization Table",
+ *        Version 0.1, October 2024
+ *
+ ******************************************************************************/
+
+struct acpi_table_iovt {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u16 iommu_count;
+	u16 iommu_offset;
+	u8 reserved[8];
+};
+
+/* IOVT subtable header */
+
+struct acpi_iovt_header {
+	u16 type;
+	u16 length;
+};
+
+/* Values for Type field above */
+
+enum acpi_iovt_iommu_type {
+	ACPI_IOVT_IOMMU_V1 = 0x00,
+	ACPI_IOVT_IOMMU_RESERVED = 0x01	/* 1 and greater are reserved */
+};
+
+/* IOVT subtables */
+
+struct acpi_iovt_iommu {
+	struct acpi_iovt_header header;
+	u32 flags;
+	u16 segment;
+	u16 phy_width;		/* Physical Address Width */
+	u16 virt_width;		/* Virtual Address Width */
+	u16 max_page_level;
+	u64 page_size;
+	u32 device_id;
+	u64 base_address;
+	u32 address_space_size;
+	u8 interrupt_type;
+	u8 reserved[3];
+	u32 gsi_number;
+	u32 proximity_domain;
+	u32 max_device_num;
+	u32 device_entry_num;
+	u32 device_entry_offset;
+};
+
+struct acpi_iovt_device_entry {
+	u8 type;
+	u8 length;
+	u8 flags;
+	u8 reserved[3];
+	u16 device_id;
+};
+
+enum acpi_iovt_device_entry_type {
+	ACPI_IOVT_DEVICE_ENTRY_SINGLE = 0x00,
+	ACPI_IOVT_DEVICE_ENTRY_START = 0x01,
+	ACPI_IOVT_DEVICE_ENTRY_END = 0x02,
+	ACPI_IOVT_DEVICE_ENTRY_RESERVED = 0x03	/* 3 and greater are reserved */
+};
+
 /*******************************************************************************
  *
  * IVRS - I/O Virtualization Reporting Structure
-- 
2.51.0





