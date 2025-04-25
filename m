Return-Path: <linux-acpi+bounces-13291-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A2BA9D1BC
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D0687B2D11
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE2722489F;
	Fri, 25 Apr 2025 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="hX9deHI/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E2B221DB5;
	Fri, 25 Apr 2025 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609667; cv=none; b=tGEnwDrEJ2U4vshSY5Ip33O8K2uslbuHL4rXqspA0Gv3THy8uO4PnQpu7aE9kPy/LyCbsoGi7zIKAt64NAM+n7I9ogn4h6zhqAJnmI7McEJSxn+auVM1rh/o6PX3XfCRP7xJCHXqyYTZLKecjQUhbKD2+MZr+ZpMLkkyvX0TtUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609667; c=relaxed/simple;
	bh=7jHb9f/VvfCt34IqH1owTNNrRCZ0eHag6Zrrj1QngmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9g4M/NNfedJjWvjIMSdWtEth0qEwaSof72VEY6f28HId5ciR62XC51+VtXBRyrcYytEQvxTk1gkGh+q3XaZUz0yJJC+TP/woFW62RfPf9o7IyIPLYMgWClf1/HPDqMjKgWw9dVC2ziFP8O0hyxuCJpddVR88HXxn8Oxp6YVC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=hX9deHI/; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AEBC2664A91;
	Fri, 25 Apr 2025 21:34:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609662;
	bh=7jHb9f/VvfCt34IqH1owTNNrRCZ0eHag6Zrrj1QngmY=;
	h=From:Subject:Date;
	b=hX9deHI/rIe3LL075In7O9eUTMcZFSfCG+gnMZi+u15cpl4j1XsEaKrYd4wuSPYkE
	 /NeSVbAmy8AKDnMpRoNXF6yXZhB5wmlrNO792eLmJV3kSGQwe+fS1RJwoftULHsR/d
	 ZVllhGHN5HcYJjBXIZ7mxUDEVtREIR5M2us6rJQrm5pTmElzxhKlkxZSOJi3C8xnSk
	 Nm2y+PseCz89qYv7MWgYoXmCRsIxcog7I0yUYqs3StKyfBvvteBRmuU9PKZnA8qkGZ
	 XoD7AURUJ8IjaDAmtnB0mrjldHwwy8MeRcBpvEKpGKLOYHmG57HUT7bGfS66dkFcGA
	 y4W4dKDVX20wA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 07/19] ACPICA: actbl2: Add definitions for RIMT
Date: Fri, 25 Apr 2025 21:24:41 +0200
Message-ID: <10665648.nUPlyArG6x@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Sunil V L <sunilvl@ventanamicro.com>

ACPICA commit 73c32bc89cad64ab19c1231a202361e917e6823c

RISC-V IO Mapping Table (RIMT) is a new static table defined for RISC-V
to communicate IOMMU information to the OS. The specification for RIMT
is available at [1]. Add structure definitions for RIMT.

[1] - https://github.com/riscv-non-isa/riscv-acpi-rimt

Link: https://github.com/acpica/acpica/commit/73c32bc8
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 83 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 4fd5e8b2e199..0ae9d9915d58 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -51,6 +51,7 @@
 #define ACPI_SIG_RAS2           "RAS2"	/* RAS2 Feature table */
 #define ACPI_SIG_RGRT           "RGRT"	/* Regulatory Graphics Resource Table */
 #define ACPI_SIG_RHCT           "RHCT"	/* RISC-V Hart Capabilities Table */
+#define ACPI_SIG_RIMT           "RIMT"	/* RISC-V IO Mapping Table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
@@ -3042,6 +3043,88 @@ struct acpi_rhct_hart_info {
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





