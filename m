Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45753BBCF8
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jul 2021 14:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhGEMpT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jul 2021 08:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhGEMpT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jul 2021 08:45:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B40D613B1;
        Mon,  5 Jul 2021 12:42:39 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH 2/3] ACPICA: MADT: Add LoongArch APICs support
Date:   Mon,  5 Jul 2021 20:42:05 +0800
Message-Id: <20210705124206.1228958-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210705124206.1228958-1-chenhuacai@loongson.cn>
References: <20210705124206.1228958-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

LoongArch-specific interrupt controllers (similar to APIC) are added
in the next revision of ACPI Specification (current revision is 6.4),
which including CORE_PIC (CPUINTC), LIO_PIC (LIOINTC), EIO_PIC (EIOINTC),
HT_PIC (HTVECINTC), BIO_PIC (PCHINTC), LPC_PIC (PCHLPC) and MSI_PIC
(PCHMSI). This patch add their definition and handlings.

Reference: https://mantis.uefi.org/mantis/view.php?id=2203
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/acpi/tables.c |  10 ++++
 include/acpi/actbl2.h | 123 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index a37a1532a575..5943ae4f76bb 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -208,6 +208,16 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
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
index 2069ac38a4e2..fd6d0b440c4b 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -571,7 +571,14 @@ enum acpi_madt_type {
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
@@ -801,6 +808,120 @@ struct acpi_madt_multiproc_wakeup_mailbox {
 
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
+	u32 processor_id;
+	u32 core_id;
+	u32 flags;
+	u8 version;
+};
+
+/* Legacy I/O Interrupt Controller */
+
+struct acpi_madt_lio_pic {
+	struct acpi_subtable_header header;
+	u64 address;
+	u16 size;
+	u8 cascade[2];
+	u32 cascade_map[2];
+	u8 version;
+};
+
+/* Extend I/O Interrupt Controller */
+
+struct acpi_madt_eio_pic {
+	struct acpi_subtable_header header;
+	u8 cascade;
+	u8 version;
+};
+
+/* HT Interrupt Controller */
+
+struct acpi_madt_ht_pic {
+	struct acpi_subtable_header header;
+	u64 address;
+	u16 size;
+	u8 cascade[8];
+	u8 version;
+};
+
+/* Bridge I/O Interrupt Controller */
+
+struct acpi_madt_bio_pic {
+	struct acpi_subtable_header header;
+	u64 address;
+	u16 size;
+	u16 id;
+	u16 gsi_base;
+	u8 version;
+};
+
+/* MSI Interrupt Controller */
+
+struct acpi_madt_msi_pic {
+	struct acpi_subtable_header header;
+	u64 msg_address;
+	u32 start;
+	u32 count;
+	u8 version;
+};
+
+/* LPC Interrupt Controller */
+
+struct acpi_madt_lpc_pic {
+	struct acpi_subtable_header header;
+	u64 address;
+	u16 size;
+	u8 cascade;
+	u8 version;
+};
+
 /*
  * Common flags fields for MADT subtables
  */
-- 
2.27.0

