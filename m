Return-Path: <linux-acpi+bounces-20303-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C75D1ED95
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 268C53024769
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B8F39A7F5;
	Wed, 14 Jan 2026 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0xVk4ey"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427E4399A7B;
	Wed, 14 Jan 2026 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394528; cv=none; b=pt+Wprn1SRu94JUgIAXq9vqsdlXVB5Y0W+tDta4kWmEWYkdN2V+mWsNPBBVSRPKuRCNb2TOIV+v8zkELUlxF4B8cJpAmNqg+hIuDLcJyKJkQFGFhq12lHuQ8+GzsedUhsiAH2zkQ6RMILaLPi3pVMjRlj0mttjLFtabgFIZ38jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394528; c=relaxed/simple;
	bh=ch9SmDFYbhXE7i0WPy/i0x2XqElwk5abmrOuLIyppBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHdzcUcDYU3fcVVN9bzDPgftvUtcpqCN17YcHlIXRRCxGwmCECzubzgKNWuh0bZ/hfrC8xh13Cgk9+EH0Iv/ElfcnGQDhlWQLDKRXOBI1tB0hFUTfMws5nP0rLvt3C6dGEd0mLDMCyw6EUW1g4NyFF2O3m/e6F3+sGBYlyqQDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0xVk4ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B06C19422;
	Wed, 14 Jan 2026 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394527;
	bh=ch9SmDFYbhXE7i0WPy/i0x2XqElwk5abmrOuLIyppBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0xVk4eyNGuJaQLv4lqt4HkYbHxH3M5sQEis3BxaYEZrKIdVE/AmDdpXkG21zW0xQ
	 E0FOvqRWRZNttS24LPSU6tNPDfW7OEwFsStman3fRgmwTy4uhPQvp4vpW5KAOT3gQC
	 53zlFLDZdzpEK1I7SlVsww+G1/L2hOwLxLPisM+QvzTrtCwW1/6JuYBUfCoOuXXQ0r
	 gMaSbzAN6Lo0QBd5m+5KQxrBiQL69QgTisYf2h1bCWzqwpKd1Nk3Yobhuaz156/SPQ
	 EiegNjoxYJ87jp50PZHo24c+13sXRkjqlVuyVIi6SH33eOjPqQAjJyYqqrIVJo1Hrw
	 TrISQklDHQIKA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 14/26] ACPICA: Add GICv5 MADT structures
Date: Wed, 14 Jan 2026 13:29:05 +0100
Message-ID: <1953107.CQOukoFCf9@rafael.j.wysocki>
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

From: Jose Marinho <jose.marinho@arm.com>

The GICv5 adds the following MADT structures:
 - IRS
 - ITS Config Frame
 - ITS Translate Frame

The ACPI spec ECR is at https://github.com/tianocore/edk2/issues/11148

Link: https://github.com/acpica/acpica/commit/69cca52ddf04
Signed-off-by: Jose Marinho <jose.marinho@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 49 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 15856ae8b1e1..05ce897f1eeb 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1294,7 +1294,10 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_IMSIC = 25,
 	ACPI_MADT_TYPE_APLIC = 26,
 	ACPI_MADT_TYPE_PLIC = 27,
-	ACPI_MADT_TYPE_RESERVED = 28,	/* 28 to 0x7F are reserved */
+	ACPI_MADT_TYPE_GICV5_IRS = 28,
+	ACPI_MADT_TYPE_GICV5_ITS = 29,
+	ACPI_MADT_TYPE_GICV5_ITS_TRANSLATE = 30,
+	ACPI_MADT_TYPE_RESERVED = 31,	/* 31 to 0x7F are reserved */
 	ACPI_MADT_TYPE_OEM_RESERVED = 0x80	/* 0x80 to 0xFF are reserved for OEM use */
 };
 
@@ -1416,7 +1419,7 @@ struct acpi_madt_local_x2apic_nmi {
 	u8 reserved[3];		/* reserved - must be zero */
 };
 
-/* 11: Generic interrupt - GICC (ACPI 5.0 + ACPI 6.0 + ACPI 6.3 + ACPI 6.5 changes) */
+/* 11: Generic interrupt - GICC (ACPI 5.0 + ACPI 6.0 + ACPI 6.3 + ACPI 6.5 + ACPI 6.7 changes) */
 
 struct acpi_madt_generic_interrupt {
 	struct acpi_subtable_header header;
@@ -1437,6 +1440,8 @@ struct acpi_madt_generic_interrupt {
 	u8 reserved2[1];
 	u16 spe_interrupt;	/* ACPI 6.3 */
 	u16 trbe_interrupt;	/* ACPI 6.5 */
+	u16 iaffid;		/* ACPI 6.7 */
+	u32 irs_id;
 };
 
 /* Masks for Flags field above */
@@ -1459,7 +1464,7 @@ struct acpi_madt_generic_distributor {
 	u8 reserved2[3];	/* reserved - must be zero */
 };
 
-/* Values for Version field above */
+/* Values for Version field above and Version field in acpi_madt_gicv5_irs */
 
 enum acpi_madt_gic_version {
 	ACPI_MADT_GIC_VERSION_NONE = 0,
@@ -1467,7 +1472,8 @@ enum acpi_madt_gic_version {
 	ACPI_MADT_GIC_VERSION_V2 = 2,
 	ACPI_MADT_GIC_VERSION_V3 = 3,
 	ACPI_MADT_GIC_VERSION_V4 = 4,
-	ACPI_MADT_GIC_VERSION_RESERVED = 5	/* 5 and greater are reserved */
+	ACPI_MADT_GIC_VERSION_V5 = 5,
+	ACPI_MADT_GIC_VERSION_RESERVED = 6	/* 6 and greater are reserved */
 };
 
 /* 13: Generic MSI Frame (ACPI 5.1) */
@@ -1738,6 +1744,41 @@ struct acpi_madt_plic {
 	u32 gsi_base;
 };
 
+/* 28: Arm GICv5 IRS (ACPI 6.7) */
+struct acpi_madt_gicv5_irs {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 reserved;
+	u32 irs_id;
+	u32 flags;
+	u32 reserved2;
+	u64 config_base_address;
+	u64 setlpi_base_address;
+};
+
+#define ACPI_MADT_IRS_NON_COHERENT      (1)
+
+/* 29: Arm GICv5 ITS Config Frame (ACPI 6.7) */
+struct acpi_madt_gicv5_translator {
+	struct acpi_subtable_header header;
+	u8 flags;
+	u8 reserved;		/* reserved - must be zero */
+	u32 translator_id;
+	u64 base_address;
+};
+
+#define ACPI_MADT_GICV5_ITS_NON_COHERENT      (1)
+
+/* 30: Arm GICv5 ITS Translate Frame (ACPI 6.7) */
+struct acpi_madt_gicv5_translate_frame {
+	struct acpi_subtable_header header;
+	u16 reserved;		/* reserved - must be zero */
+	u32 linked_translator_id;
+	u32 translate_frame_id;
+	u32 reserved2;
+	u64 base_address;
+};
+
 /* 80: OEM data */
 
 struct acpi_madt_oem_data {
-- 
2.51.0





