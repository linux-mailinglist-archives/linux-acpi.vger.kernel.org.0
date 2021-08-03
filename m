Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7563E3DF46C
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Aug 2021 20:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbhHCSMm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Aug 2021 14:12:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62276 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbhHCSMk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Aug 2021 14:12:40 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 398553aa93f30c57; Tue, 3 Aug 2021 20:12:27 +0200
Received: from kreacher.localnet (89-64-81-181.dynamic.chello.pl [89.64.81.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 16E1166A020;
        Tue,  3 Aug 2021 20:12:27 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 1/7] ACPICA: iASL: Add support for the AEST table (data compiler)
Date:   Tue, 03 Aug 2021 20:07:53 +0200
Message-ID: <4345936.LvFx2qVVIh@kreacher>
In-Reply-To: <5748555.lOV4Wx5bFT@kreacher>
References: <5748555.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.181
X-CLIENT-HOSTNAME: 89-64-81-181.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggdduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegleefhfdvvedvieettdeitddvteeufeekgedtffelieeiteffiefhfedvlefgteenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhsthgrtghkohhvvghrfhhlohifrdgtohhmnecukfhppeekledrieegrdekuddrudekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrudekuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Includes support in the table compiler and the disassembler.

ACPICA commit e75074d84d1207339a048486c2d06ecb935d0092

Link: https://github.com/acpica/acpica/commit/e75074d8
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h |   1 +
 include/acpi/actbl2.h | 170 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index ef2872dea01c..a7ea179b2089 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -24,6 +24,7 @@
  * file. Useful because they make it more difficult to inadvertently type in
  * the wrong signature.
  */
+#define ACPI_SIG_AEST           "AEST"	/* Arm Error Source Table */
 #define ACPI_SIG_ASF            "ASF!"	/* Alert Standard Format table */
 #define ACPI_SIG_BERT           "BERT"	/* Boot Error Record Table */
 #define ACPI_SIG_BGRT           "BGRT"	/* Boot Graphics Resource Table */
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2069ac38a4e2..a47b32a5cbde 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -67,6 +67,176 @@
  * See http://stackoverflow.com/a/1053662/41661
  */
 
+/*******************************************************************************
+ *
+ * AEST - Arm Error Source Table
+ *
+ * Conforms to: ACPI for the Armv8 RAS Extensions 1.1 Platform Design Document
+ * September 2020.
+ *
+ ******************************************************************************/
+
+struct acpi_table_aest {
+	struct acpi_table_header header;
+	void *node_array[];
+};
+
+/* Common Subtable header - one per Node Structure (Subtable) */
+
+struct acpi_aest_hdr {
+	u8 type;
+	u16 length;
+	u8 reserved;
+	u32 node_specific_offset;
+	u32 node_interface_offset;
+	u32 node_interrupt_offset;
+	u32 node_interrupt_count;
+	u64 timestamp_rate;
+	u64 reserved1;
+	u64 error_injection_rate;
+};
+
+/* Values for Type above */
+
+#define ACPI_AEST_PROCESSOR_ERROR_NODE      0
+#define ACPI_AEST_MEMORY_ERROR_NODE         1
+#define ACPI_AEST_SMMU_ERROR_NODE           2
+#define ACPI_AEST_VENDOR_ERROR_NODE         3
+#define ACPI_AEST_GIC_ERROR_NODE            4
+#define ACPI_AEST_NODE_TYPE_RESERVED        5	/* 5 and above are reserved */
+
+/*
+ * AEST subtables (Error nodes)
+ */
+
+/* 0: Processor Error */
+
+typedef struct acpi_aest_processor {
+	u32 processor_id;
+	u8 resource_type;
+	u8 reserved;
+	u8 flags;
+	u8 revision;
+	u64 processor_affinity;
+
+} acpi_aest_processor;
+
+/* Values for resource_type above, related structs below */
+
+#define ACPI_AEST_CACHE_RESOURCE            0
+#define ACPI_AEST_TLB_RESOURCE              1
+#define ACPI_AEST_GENERIC_RESOURCE          2
+#define ACPI_AEST_RESOURCE_RESERVED         3	/* 3 and above are reserved */
+
+/* 0R: Processor Cache Resource Substructure */
+
+typedef struct acpi_aest_processor_cache {
+	u32 cache_reference;
+	u32 reserved;
+
+} acpi_aest_processor_cache;
+
+/* Values for cache_type above */
+
+#define ACPI_AEST_CACHE_DATA                0
+#define ACPI_AEST_CACHE_INSTRUCTION         1
+#define ACPI_AEST_CACHE_UNIFIED             2
+#define ACPI_AEST_CACHE_RESERVED            3	/* 3 and above are reserved */
+
+/* 1R: Processor TLB Resource Substructure */
+
+typedef struct acpi_aest_processor_tlb {
+	u32 tlb_level;
+	u32 reserved;
+
+} acpi_aest_processor_tlb;
+
+/* 2R: Processor Generic Resource Substructure */
+
+typedef struct acpi_aest_processor_generic {
+	u8 *resource;
+
+} acpi_aest_processor_generic;
+
+/* 1: Memory Error */
+
+typedef struct acpi_aest_memory {
+	u32 srat_proximity_domain;
+
+} acpi_aest_memory;
+
+/* 2: Smmu Error */
+
+typedef struct acpi_aest_smmu {
+	u32 iort_node_reference;
+	u32 subcomponent_reference;
+
+} acpi_aest_smmu;
+
+/* 3: Vendor Defined */
+
+typedef struct acpi_aest_vendor {
+	u32 acpi_hid;
+	u32 acpi_uid;
+	u8 vendor_specific_data[16];
+
+} acpi_aest_vendor;
+
+/* 4: Gic Error */
+
+typedef struct acpi_aest_gic {
+	u32 interface_type;
+	u32 instance_id;
+
+} acpi_aest_gic;
+
+/* Values for interface_type above */
+
+#define ACPI_AEST_GIC_CPU                   0
+#define ACPI_AEST_GIC_DISTRIBUTOR           1
+#define ACPI_AEST_GIC_REDISTRIBUTOR         2
+#define ACPI_AEST_GIC_ITS                   3
+#define ACPI_AEST_GIC_RESERVED              4	/* 4 and above are reserved */
+
+/* Node Interface Structure */
+
+typedef struct acpi_aest_node_interface {
+	u8 type;
+	u8 reserved[3];
+	u32 flags;
+	u64 address;
+	u32 error_record_index;
+	u32 error_record_count;
+	u64 error_record_implemented;
+	u64 error_status_reporting;
+	u64 addressing_mode;
+
+} acpi_aest_node_interface;
+
+/* Values for Type field above */
+
+#define ACPI_AEST_NODE_SYSTEM_REGISTER      0
+#define ACPI_AEST_NODE_MEMORY_MAPPED        1
+#define ACPI_AEST_XFACE_RESERVED            2	/* 2 and above are reserved */
+
+/* Node Interrupt Structure */
+
+typedef struct acpi_aest_node_interrupt {
+	u8 type;
+	u8 reserved[2];
+	u8 flags;
+	u32 gsiv;
+	u8 iort_id;
+	u8 reserved1[3];
+
+} acpi_aest_node_interrupt;
+
+/* Values for Type field above */
+
+#define ACPI_AEST_NODE_FAULT_HANDLING       0
+#define ACPI_AEST_NODE_ERROR_RECOVERY       1
+#define ACPI_AEST_XRUPT_RESERVED            2	/* 2 and above are reserved */
+
 /*******************************************************************************
  *
  * BDAT - BIOS Data ACPI Table
-- 
2.26.2




