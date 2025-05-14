Return-Path: <linux-acpi+bounces-13711-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB461AB629C
	for <lists+linux-acpi@lfdr.de>; Wed, 14 May 2025 07:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459AE189EE77
	for <lists+linux-acpi@lfdr.de>; Wed, 14 May 2025 05:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133991F8BD6;
	Wed, 14 May 2025 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Zuw+pKv4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2641F8AD3
	for <linux-acpi@vger.kernel.org>; Wed, 14 May 2025 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202262; cv=none; b=dKoi/WNC5yuV2vkS8ebxRvrnn95o3k/LYeCiYx8VFnx6thySPLCMvok9IsszRG0SBllrDkm9LLmiMlFI3NxLF70YjuP1KZN09Il561X/HL2lsZ+MiBDh3p2+YhLvvkVjVVQEpY/loiZmkexUX5GZF266zb9r4VJYfy/5goC2byg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202262; c=relaxed/simple;
	bh=P/M7n4SDTSF4DDX2hlMecwto868uMFq8eIhCBjXO3DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gz1xPOU04hU51lEviH+I2YvDsFH4JbRAfxeOFqjRzzpk8AZLiD8h6nH2R4UMhpiGChrXaScLDCUyf9SeAWBnTRS4DaAsVJB+u+j6KKQf/Msu3ZCYoR3kEtXF5CZe1uY/JsVmdzik7ALpzTZrX5Spiat7urVSHdLVsAvd1BNr7HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Zuw+pKv4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af91fc1fa90so5346912a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 13 May 2025 22:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1747202259; x=1747807059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3mv/YR2xZRmrbZBh7XLVUMsC3Lat0ehLZET0BefXjE=;
        b=Zuw+pKv4Ly8gLlgsHojqbhZk6mDL8LdP0XjifOF8Y25uh/hE1ZBtxMS5NdY3HCarkf
         HI5ZRg91KmhA+MiOktgVqTrFXE7nOYKMkDGyLmum7cQ5U4MVwopeSIQdsoGjZdWtOHw4
         4t7HG0NPkYoEatVy69ocGwtpxQ0R1rbr+F6rWv2a3/iX+dLyG556oCkBS1NcU89OIsIx
         pZSTu8+2daOkn0jnA+yG/YoYReYndzfQDDx6aMCNuoOFLK/AyB1SZGK5dTfClO50JN8W
         lVieOVpx07VlriUE0aXg1qM/zE0nRq8RT+62qi8c2VwhYj0u2Lhqt4wc3/5HtBa0Uan7
         3zBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747202259; x=1747807059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3mv/YR2xZRmrbZBh7XLVUMsC3Lat0ehLZET0BefXjE=;
        b=tbbZupuafd08rb2Yin4u9VALISVQ8kusxB7I2b6lBlAhFD7csWvjL6DUPLc0m0Hkje
         vKw/6lNP5K+bxYc+Ar/9rWFWs4YHPu7B0QIqxBKt71/qRgFV6wGha+krfmImGG9Jjkm0
         IXP6TAbNavHrXhRWCqWfPyoFqimPLvupe6thF54mz15csvkWsVNsFslw0cf++kVO4zeX
         o17xXbx4x78Z+/o394HyeAhyYeghotFrnViZEg+CIr4U4qeZ6Nb/65bion60zfFAkWu0
         h6ninK4c/nFLWAZYktJtx/VK06o24mHgR1RKVmBz9Bf5FCGjppnWI2pRaw9LEb/FTlTg
         GEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPQGxbPWIQuiRZ5H7NiwywmQv6ppbNQlZ4z6OWgHYwt7EQyEt0T430W05Abts3UOvrDXYy5uP+0Cb3@vger.kernel.org
X-Gm-Message-State: AOJu0YxOOJJeXZ2k79Ba/0jbk9CFUpAIkLuFT9/xraE2nqbJow/CNayv
	pzMPBKc5/HXtmravViz2uc8wCtzEM9SgeqmN1/kMo7VbXJbtl43qfxMBf1XxJA0=
X-Gm-Gg: ASbGnctOMXTAhdHh7R0dqkO0RDFTfsMtfgV8kb6R74wQaNd3LvHAjDpCOtha5FSNGIl
	vZZHr90HpHD16N70MpejOPpsPWfg/PVqDoqMisflWFD+HQJqi0yVC7rKAUsB0JFx6cbxGrdD4Ob
	rM5iIxHy4j7xlqOFiTh0qU2Fer5vigBki6MePl40Gnd/kzQLHRhq02UFa1xfOErtAN2/BisMIBw
	T0wLGvbm40Q6dKyM8L1q4e17b908dG9u30D3oGEpwApvAnVKaAd2WPazwvvhSvLYgtoBEz04eAu
	/jy+mxYk/Ief+pbw2Z48h+9JEyJIQHAMFoy8obdAPFUF/o8/YgD1X3OTiRCS9A==
X-Google-Smtp-Source: AGHT+IHE6ExFWnu/zrAvRfvX4AYC0RkEswg44e9W2VNDqbKcdiZ15MPr+ykcmRts8B4KvtHH+QD0iA==
X-Received: by 2002:a17:903:41c5:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-231980d04a3mr31983045ad.19.1747202259577;
        Tue, 13 May 2025 22:57:39 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c2dsm91721615ad.135.2025.05.13.22.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 22:57:39 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	acpica-devel@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 1/4] ACPICA: actbl2: Add definitions for RIMT
Date: Wed, 14 May 2025 11:27:20 +0530
Message-ID: <20250514055723.1328557-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514055723.1328557-1-sunilvl@ventanamicro.com>
References: <20250514055723.1328557-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPICA commit 73c32bc89cad64ab19c1231a202361e917e6823c

RISC-V IO Mapping Table (RIMT) is a new static table defined for RISC-V
to communicate IOMMU information to the OS. The specification for RIMT
is available at [1]. Add structure definitions for RIMT.

[1] - https://github.com/riscv-non-isa/riscv-acpi-rimt

Link: https://github.com/acpica/acpica/commit/73c32bc8
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 include/acpi/actbl2.h | 83 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2e917a8f8bca..99ea8bfe47de 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -50,6 +50,7 @@
 #define ACPI_SIG_RAS2           "RAS2"	/* RAS2 Feature table */
 #define ACPI_SIG_RGRT           "RGRT"	/* Regulatory Graphics Resource Table */
 #define ACPI_SIG_RHCT           "RHCT"	/* RISC-V Hart Capabilities Table */
+#define ACPI_SIG_RIMT           "RIMT"	/* RISC-V IO Mapping Table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
@@ -3002,6 +3003,88 @@ struct acpi_rhct_hart_info {
 	u32 uid;		/* ACPI processor UID */
 };
 
+/*******************************************************************************
+ *
+ * RIMT - RISC-V IO Remapping Table
+ *
+ * https://github.com/riscv-non-isa/riscv-acpi-rimt
+ *
+ ******************************************************************************/
+
+struct acpi_table_rimt {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 num_nodes;		/* Number of RIMT Nodes */
+	u32 node_offset;	/* Offset to RIMT Node Array */
+	u32 reserved;
+};
+
+struct acpi_rimt_node {
+	u8 type;
+	u8 revision;
+	u16 length;
+	u16 reserved;
+	u16 id;
+	char node_data[];
+};
+
+enum acpi_rimt_node_type {
+	ACPI_RIMT_NODE_TYPE_IOMMU = 0x0,
+	ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX = 0x1,
+	ACPI_RIMT_NODE_TYPE_PLAT_DEVICE = 0x2,
+};
+
+struct acpi_rimt_iommu {
+	u8 hardware_id[8];	/* Hardware ID */
+	u64 base_address;	/* Base Address */
+	u32 flags;		/* Flags */
+	u32 proximity_domain;	/* Proximity Domain */
+	u16 pcie_segment_number;	/* PCIe Segment number */
+	u16 pcie_bdf;		/* PCIe B/D/F */
+	u16 num_interrupt_wires;	/* Number of interrupt wires */
+	u16 interrupt_wire_offset;	/* Interrupt wire array offset */
+	u64 interrupt_wire[];	/* Interrupt wire array */
+};
+
+/* IOMMU Node Flags */
+#define ACPI_RIMT_IOMMU_FLAGS_PCIE      (1)
+#define ACPI_RIMT_IOMMU_FLAGS_PXM_VALID (1 << 1)
+
+/* Interrupt Wire Structure */
+struct acpi_rimt_iommu_wire_gsi {
+	u32 irq_num;		/* Interrupt Number */
+	u32 flags;		/* Flags */
+};
+
+/* Interrupt Wire Flags */
+#define ACPI_RIMT_GSI_LEVEL_TRIGGERRED  (1)
+#define ACPI_RIMT_GSI_ACTIVE_HIGH       (1 << 1)
+
+struct acpi_rimt_id_mapping {
+	u32 source_id_base;	/* Source ID Base */
+	u32 num_ids;		/* Number of IDs */
+	u32 dest_id_base;	/* Destination Device ID Base */
+	u32 dest_offset;	/* Destination IOMMU Offset */
+	u32 flags;		/* Flags */
+};
+
+struct acpi_rimt_pcie_rc {
+	u32 flags;		/* Flags */
+	u16 reserved;		/* Reserved */
+	u16 pcie_segment_number;	/* PCIe Segment number */
+	u16 id_mapping_offset;	/* ID mapping array offset */
+	u16 num_id_mappings;	/* Number of ID mappings */
+};
+
+/* PCIe Root Complex Node Flags */
+#define ACPI_RIMT_PCIE_ATS_SUPPORTED   (1)
+#define ACPI_RIMT_PCIE_PRI_SUPPORTED   (1 << 1)
+
+struct acpi_rimt_platform_device {
+	u16 id_mapping_offset;	/* ID Mapping array offset */
+	u16 num_id_mappings;	/* Number of ID mappings */
+	char device_name[];	/* Device Object Name */
+};
+
 /*******************************************************************************
  *
  * SBST - Smart Battery Specification Table
-- 
2.43.0


