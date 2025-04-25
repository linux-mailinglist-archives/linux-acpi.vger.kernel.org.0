Return-Path: <linux-acpi+bounces-13287-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84551A9D1B2
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15A6C7AF845
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C364D221FC2;
	Fri, 25 Apr 2025 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="FbztuFDs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B621E08D;
	Fri, 25 Apr 2025 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609665; cv=none; b=RyFhXqt2czjauVTsT6uUG/j5jAdvaWmP+VcxAFlZlcRAB2CMtbpBZyS1djFREnsqTYI/CIHsx0rIA9pIicxBy/BVOiZhlQkAjvul7c0/y4ZY/8KrIgJw0fDkjxh5nyl0yk65YcZZFttK4LZVh5yUsFs69hNFHX9xpJToCBd3+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609665; c=relaxed/simple;
	bh=hqtJr8+mT8Zz8ZDa1vDTxS94/n4yDl8s7QStI+V417w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrdNuC8hrwcfhjVRs/J04CV6qvlrOjlmDS+7vkEMqiBmZbBDJaBhdyock6ZOdWKPtf3IvMib2oxsiD0fHbfMUE3MKzc6a/LqA8d3TCpH8+JB5sMATNWJrBBSycUy3GNeV8d05pljQxWUsQGpMfWMXBRQV0cwPg9fh76CN7FkpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=FbztuFDs; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DDC376646B5;
	Fri, 25 Apr 2025 21:34:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609658;
	bh=hqtJr8+mT8Zz8ZDa1vDTxS94/n4yDl8s7QStI+V417w=;
	h=From:Subject:Date;
	b=FbztuFDs5ftm4CRlXhuVQ9MUQsQqSe6ddPW7523aFBQF0WTiQl5BWd80SEctjEWV+
	 x1tyA5uZst3xEQB+FwYglDPXl0+iA2dgbNcf7E+CW8LFDWlvijAD7eaZdpHeXhhGsQ
	 ONNlX+VhKofL5HTOSdXG+gkHWTPskMWHHvD5+G0ozb6wOfJwdXApZtBTPTRacfO0R2
	 yqp77gpu6rDi0Cwc2RgKyNGTu+x637yVeXxr++HbWppM+c3sj8t1LUTjjAK1wN3Ez2
	 Kftl4FeiLSb6OmNicGTx6VxaT5PsBf7/oNWcH+bcoDcFIKrbiIOikTVDzW/GFupdng
	 0Srxv4959fI3A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 11/19] ACPICA: actbl2.h: ERDT: Add typedef and other  definitions
Date: Fri, 25 Apr 2025 21:27:24 +0200
Message-ID: <3296755.5fSG56mABF@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnheptefhgffgueeileffleffieeuvefgtdetheeiheelveehtdfhveeggedtkeelgeehnecuffhomhgrihhnpehinhhtvghlrdgtohhmpdhgihhthhhusgdrtghomhenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Tony Luck <tony.luck@intel.com>

ACPICA commit dddd9270531d74af523afa68515d8aae6a18bbe0

The ERDT table (and its many subtables) enumerate capabilities
and methods for Intel Resource Director Technology to monitor
and control L3 cache allocation and memory bandwidth by CPU
cores and IO devices.

Structure defined in the Intel Resource Director Technology (RDT)
Architecture specification downloadable from www.intel.com/sdm

Link: https://github.com/acpica/acpica/commit/dddd9270
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 190 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2c07b097ef9f..ccbf543bceeb 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -29,6 +29,7 @@
 #define ACPI_SIG_BDAT           "BDAT"	/* BIOS Data ACPI Table */
 #define ACPI_SIG_CCEL           "CCEL"	/* CC Event Log Table */
 #define ACPI_SIG_CDAT           "CDAT"	/* Coherent Device Attribute Table */
+#define ACPI_SIG_ERDT           "ERDT"	/* Enhanced Resource Director Technology */
 #define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
 #define ACPI_SIG_LPIT           "LPIT"	/* Low Power Idle Table */
@@ -450,6 +451,195 @@ struct acpi_table_ccel {
 	u64 log_area_start_address;
 };
 
+/*******************************************************************************
+ *
+ * ERDT - Enhanced Resource Director Technology (ERDT) table
+ *
+ * Conforms to "Intel Resource Director Technology Architecture Specification"
+ * Version 1.1, January 2025
+ *
+ ******************************************************************************/
+
+struct acpi_table_erdt {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 max_clos;		/* Maximum classes of service */
+	u8 reserved[24];
+	u8 erdt_substructures[];
+};
+
+/* Values for subtable type in struct acpi_subtbl_hdr_16 */
+
+enum acpi_erdt_type {
+	ACPI_ERDT_TYPE_RMDD = 0,
+	ACPI_ERDT_TYPE_CACD = 1,
+	ACPI_ERDT_TYPE_DACD = 2,
+	ACPI_ERDT_TYPE_CMRC = 3,
+	ACPI_ERDT_TYPE_MMRC = 4,
+	ACPI_ERDT_TYPE_MARC = 5,
+	ACPI_ERDT_TYPE_CARC = 6,
+	ACPI_ERDT_TYPE_CMRD = 7,
+	ACPI_ERDT_TYPE_IBRD = 8,
+	ACPI_ERDT_TYPE_IBAD = 9,
+	ACPI_ERDT_TYPE_CARD = 10,
+	ACPI_ERDT_TYPE_RESERVED = 11	/* 11 and above are reserved */
+};
+
+/*
+ * ERDT Subtables, correspond to Type in struct acpi_subtbl_hdr_16
+ */
+
+/* 0: RMDD - Resource Management Domain Description */
+
+struct acpi_erdt_rmdd {
+	struct acpi_subtbl_hdr_16 header;
+	u16 flags;
+	u16 IO_l3_slices;	/* Number of slices in IO cache */
+	u8 IO_l3_sets;		/* Number of sets in IO cache */
+	u8 IO_l3_ways;		/* Number of ways in IO cache */
+	u64 reserved;
+	u16 domain_id;		/* Unique domain ID */
+	u32 max_rmid;		/* Maximun RMID supported */
+	u64 creg_base;		/* Control Register Base Address */
+	u16 creg_size;		/* Control Register Size (4K pages) */
+	u8 rmdd_structs[];
+};
+
+/* 1: CACD - CPU Agent Collection Description */
+
+struct acpi_erdt_cacd {
+	struct acpi_subtbl_hdr_16 header;
+	u16 reserved;
+	u16 domain_id;		/* Unique domain ID */
+	u32 X2APICIDS[];
+};
+
+/* 2: DACD - Device Agent Collection Description */
+
+struct acpi_erdt_dacd {
+	struct acpi_subtbl_hdr_16 header;
+	u16 reserved;
+	u16 domain_id;		/* Unique domain ID */
+	u8 dev_paths[];
+};
+
+struct acpi_erdt_dacd_dev_paths {
+	struct acpi_subtable_header header;
+	u16 segment;
+	u8 reserved;
+	u8 start_bus;
+	u8 path[];
+};
+
+/* 3: CMRC - Cache Monitoring Registers for CPU Agents */
+
+struct acpi_erdt_cmrc {
+	struct acpi_subtbl_hdr_16 header;
+	u32 reserved1;
+	u32 flags;
+	u8 index_fn;
+	u8 reserved2[11];
+	u64 cmt_reg_base;
+	u32 cmt_reg_size;
+	u16 clump_size;
+	u16 clump_stride;
+	u64 up_scale;
+};
+
+/* 4: MMRC - Memory-bandwidth Monitoring Registers for CPU Agents */
+
+struct acpi_erdt_mmrc {
+	struct acpi_subtbl_hdr_16 header;
+	u32 reserved1;
+	u32 flags;
+	u8 index_fn;
+	u8 reserved2[11];
+	u64 reg_base;
+	u32 reg_size;
+	u8 counter_width;
+	u64 up_scale;
+	u8 reserved3[7];
+	u32 corr_factor_list_len;
+	u32 corr_factor_list[];
+};
+
+/* 5: MARC - Memory-bandwidth Allocation Registers for CPU Agents */
+
+struct acpi_erdt_marc {
+	struct acpi_subtbl_hdr_16 header;
+	u16 reserved1;
+	u16 flags;
+	u8 index_fn;
+	u8 reserved2[7];
+	u64 reg_base_opt;
+	u64 reg_base_min;
+	u64 reg_base_max;
+	u32 mba_reg_size;
+	u32 mba_ctrl_range;
+};
+
+/* 6: CARC - Cache Allocation Registers for CPU Agents */
+
+struct acpi_erdt_carc {
+	struct acpi_subtbl_hdr_16 header;
+};
+
+/* 7: CMRD - Cache Monitoring Registers for Device Agents */
+
+struct acpi_erdt_cmrd {
+	struct acpi_subtbl_hdr_16 header;
+	u32 reserved1;
+	u32 flags;
+	u8 index_fn;
+	u8 reserved2[11];
+	u64 reg_base;
+	u32 reg_size;
+	u16 cmt_reg_off;
+	u16 cmt_clump_size;
+	u64 up_scale;
+};
+
+/* 8: IBRD - Cache Monitoring Registers for Device Agents */
+
+struct acpi_erdt_ibrd {
+	struct acpi_subtbl_hdr_16 header;
+	u32 reserved1;
+	u32 flags;
+	u8 index_fn;
+	u8 reserved2[11];
+	u64 reg_base;
+	u32 reg_size;
+	u16 total_bw_offset;
+	u16 Iomiss_bw_offset;
+	u16 total_bw_clump;
+	u16 Iomiss_bw_clump;
+	u8 reserved3[7];
+	u8 counter_width;
+	u64 up_scale;
+	u32 corr_factor_list_len;
+	u32 corr_factor_list[];
+};
+
+/* 9: IBAD - IO bandwidth Allocation Registers for device agents */
+
+struct acpi_erdt_ibad {
+	struct acpi_subtbl_hdr_16 header;
+};
+
+/* 10: CARD - IO bandwidth Allocation Registers for Device Agents */
+
+struct acpi_erdt_card {
+	struct acpi_subtbl_hdr_16 header;
+	u32 reserved1;
+	u32 flags;
+	u32 contention_mask;
+	u8 index_fn;
+	u8 reserved2[7];
+	u64 reg_base;
+	u32 reg_size;
+	u16 cat_reg_offset;
+	u16 cat_reg_block_size;
+};
+
 /*******************************************************************************
  *
  * IORT - IO Remapping Table
-- 
2.43.0





