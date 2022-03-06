Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752274CEAF5
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Mar 2022 12:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiCFLSu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Mar 2022 06:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCFLSt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Mar 2022 06:18:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80C238192
        for <linux-acpi@vger.kernel.org>; Sun,  6 Mar 2022 03:17:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6420160AE4
        for <linux-acpi@vger.kernel.org>; Sun,  6 Mar 2022 11:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2955EC340EC;
        Sun,  6 Mar 2022 11:17:53 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH V2 1/2] ACPICA: MADT: Add LoongArch APICs support
Date:   Sun,  6 Mar 2022 19:18:37 +0800
Message-Id: <20220306111838.810959-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220306111838.810959-1-chenhuacai@loongson.cn>
References: <20220306111838.810959-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

LoongArch-specific interrupt controllers (similar to APIC) are added
in the next revision of ACPI Specification (current revision is 6.4),
which including CORE_PIC (CPUINTC), LIO_PIC (LIOINTC), EIO_PIC (EIOINTC),
HT_PIC (HTVECINTC), BIO_PIC (PCHINTC), LPC_PIC (PCHLPC) and MSI_PIC
(PCHMSI). This patch add their definition and handlings.

ACPI changes of LoongArch-specific interrupt controllers have already
been approved in the ECRs, and will be public in the next revision of
ACPI Specification.

Reference: https://mantis.uefi.org/mantis/view.php?id=2203
Reference: https://mantis.uefi.org/mantis/view.php?id=2313
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/acpi/tables.c |  10 ++++
 include/acpi/actbl2.h | 125 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 34600b5b9d8e..5c6599c35e35 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -210,6 +210,16 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_CORE_PIC:
+		{
+			struct acpi_madt_core_pic *p =
+			    (struct acpi_madt_core_pic *)header;
+			pr_debug("CORE PIC (processor_id[0x%02x] core_id[0x%02x] %s)\n",
+				 p->processor_id, p->core_id,
+				 (p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
 			header->type);
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 16847c8d9d5f..2419f9e397e2 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -762,7 +762,14 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR = 14,
 	ACPI_MADT_TYPE_GENERIC_TRANSLATOR = 15,
 	ACPI_MADT_TYPE_MULTIPROC_WAKEUP = 16,
-	ACPI_MADT_TYPE_RESERVED = 17	/* 17 and greater are reserved */
+	ACPI_MADT_TYPE_CORE_PIC = 17,
+	ACPI_MADT_TYPE_LIO_PIC = 18,
+	ACPI_MADT_TYPE_HT_PIC = 19,
+	ACPI_MADT_TYPE_EIO_PIC = 20,
+	ACPI_MADT_TYPE_MSI_PIC = 21,
+	ACPI_MADT_TYPE_BIO_PIC = 22,
+	ACPI_MADT_TYPE_LPC_PIC = 23,
+	ACPI_MADT_TYPE_RESERVED = 24	/* 24 and greater are reserved */
 };
 
 /*
@@ -992,6 +999,122 @@ struct acpi_madt_multiproc_wakeup_mailbox {
 
 #define ACPI_MP_WAKE_COMMAND_WAKEUP    1
 
+/* Values for Version field above */
+
+enum acpi_madt_core_pic_version {
+	ACPI_MADT_CORE_PIC_VERSION_NONE = 0,
+	ACPI_MADT_CORE_PIC_VERSION_V1 = 1,
+	ACPI_MADT_CORE_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_lio_pic_version {
+	ACPI_MADT_LIO_PIC_VERSION_NONE = 0,
+	ACPI_MADT_LIO_PIC_VERSION_V1 = 1,
+	ACPI_MADT_LIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_eio_pic_version {
+	ACPI_MADT_EIO_PIC_VERSION_NONE = 0,
+	ACPI_MADT_EIO_PIC_VERSION_V1 = 1,
+	ACPI_MADT_EIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_ht_pic_version {
+	ACPI_MADT_HT_PIC_VERSION_NONE = 0,
+	ACPI_MADT_HT_PIC_VERSION_V1 = 1,
+	ACPI_MADT_HT_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_bio_pic_version {
+	ACPI_MADT_BIO_PIC_VERSION_NONE = 0,
+	ACPI_MADT_BIO_PIC_VERSION_V1 = 1,
+	ACPI_MADT_BIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_msi_pic_version {
+	ACPI_MADT_MSI_PIC_VERSION_NONE = 0,
+	ACPI_MADT_MSI_PIC_VERSION_V1 = 1,
+	ACPI_MADT_MSI_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_lpc_pic_version {
+	ACPI_MADT_LPC_PIC_VERSION_NONE = 0,
+	ACPI_MADT_LPC_PIC_VERSION_V1 = 1,
+	ACPI_MADT_LPC_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+/* Core Interrupt Controller */
+
+struct acpi_madt_core_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u32 processor_id;
+	u32 core_id;
+	u32 flags;
+};
+
+/* Legacy I/O Interrupt Controller */
+
+struct acpi_madt_lio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade[2];
+	u32 cascade_map[2];
+};
+
+/* Extend I/O Interrupt Controller */
+
+struct acpi_madt_eio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 cascade;
+	u8 node;
+	u64 node_map;
+};
+
+/* HT Interrupt Controller */
+
+struct acpi_madt_ht_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade[8];
+};
+
+/* Bridge I/O Interrupt Controller */
+
+struct acpi_madt_bio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u16 id;
+	u16 gsi_base;
+};
+
+/* MSI Interrupt Controller */
+
+struct acpi_madt_msi_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 msg_address;
+	u32 start;
+	u32 count;
+};
+
+/* LPC Interrupt Controller */
+
+struct acpi_madt_lpc_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade;
+};
+
 /*
  * Common flags fields for MADT subtables
  */
-- 
2.27.0

