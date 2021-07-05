Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585673BBD50
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jul 2021 15:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhGENIJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jul 2021 09:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhGENII (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jul 2021 09:08:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4840F61474;
        Mon,  5 Jul 2021 13:05:29 +0000 (UTC)
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
Subject: [PATCH 3/3] ACPICA: Events: Support fixed pcie wake event
Date:   Mon,  5 Jul 2021 21:05:49 +0800
Message-Id: <20210705130549.1232418-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210705124206.1228958-1-chenhuacai@loongson.cn>
References: <20210705124206.1228958-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some chipsets (such as Loongson's LS7A) support fixed pcie wake event
which is defined in the PM1 block(related description can be found in
4.8.4.1.1 PM1 Status Registers, 4.8.4.2.1 PM1 Control Registers and
5.2.9 Fixed ACPI Description Table (FADT)), so we add code to handle it.

ACPI Spec 6.4 link:
https://uefi.org/specifications/ACPI/6.4/

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/acpi/acpica/evevent.c  | 17 +++++++++++------
 drivers/acpi/acpica/hwsleep.c  | 12 ++++++++++++
 drivers/acpi/acpica/utglobal.c |  4 ++++
 include/acpi/actypes.h         |  3 ++-
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index 35385148fedb..2340986de37b 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -140,9 +140,9 @@ static acpi_status acpi_ev_fixed_event_initialize(void)
 
 		if (acpi_gbl_fixed_event_info[i].enable_register_id != 0xFF) {
 			status =
-			    acpi_write_bit_register(acpi_gbl_fixed_event_info
-						    [i].enable_register_id,
-						    ACPI_DISABLE_EVENT);
+			    acpi_write_bit_register(acpi_gbl_fixed_event_info[i].enable_register_id,
+						    (i == ACPI_EVENT_PCIE_WAKE) ?
+						    ACPI_ENABLE_EVENT : ACPI_DISABLE_EVENT);
 			if (ACPI_FAILURE(status)) {
 				return (status);
 			}
@@ -185,6 +185,11 @@ u32 acpi_ev_fixed_event_detect(void)
 		return (int_status);
 	}
 
+	if (fixed_enable & ACPI_BITMASK_PCIEXP_WAKE_DISABLE)
+		fixed_enable &= ~ACPI_BITMASK_PCIEXP_WAKE_DISABLE;
+	else
+		fixed_enable |= ACPI_BITMASK_PCIEXP_WAKE_DISABLE;
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
 			  "Fixed Event Block: Enable %08X Status %08X\n",
 			  fixed_enable, fixed_status));
@@ -248,9 +253,9 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 	 * and disable the event to prevent further interrupts.
 	 */
 	if (!acpi_gbl_fixed_event_handlers[event].handler) {
-		(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
-					      enable_register_id,
-					      ACPI_DISABLE_EVENT);
+		(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].enable_register_id,
+					      event == ACPI_EVENT_PCIE_WAKE ?
+					      ACPI_ENABLE_EVENT : ACPI_DISABLE_EVENT);
 
 		ACPI_ERROR((AE_INFO,
 			    "No installed handler for fixed event - %s (%u), disabling",
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 14baa13bf848..7e7ea4c2e914 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -312,6 +312,18 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
 				    [ACPI_EVENT_SLEEP_BUTTON].
 				    status_register_id, ACPI_CLEAR_STATUS);
 
+	/* Enable pcie wake event if support */
+	if ((acpi_gbl_FADT.flags & ACPI_FADT_PCI_EXPRESS_WAKE)) {
+		(void)
+		acpi_write_bit_register(acpi_gbl_fixed_event_info
+				[ACPI_EVENT_PCIE_WAKE].
+				enable_register_id, ACPI_DISABLE_EVENT);
+		(void)
+		acpi_write_bit_register(acpi_gbl_fixed_event_info
+				[ACPI_EVENT_PCIE_WAKE].
+				status_register_id, ACPI_CLEAR_STATUS);
+	}
+
 	acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST, ACPI_SST_WORKING);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 59a48371a7bc..16f7a206fc6d 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -186,6 +186,10 @@ struct acpi_fixed_event_info acpi_gbl_fixed_event_info[ACPI_NUM_FIXED_EVENTS] =
 					ACPI_BITREG_RT_CLOCK_ENABLE,
 					ACPI_BITMASK_RT_CLOCK_STATUS,
 					ACPI_BITMASK_RT_CLOCK_ENABLE},
+	/* ACPI_EVENT_PCIE_WAKE	    */ {ACPI_BITREG_PCIEXP_WAKE_STATUS,
+					ACPI_BITREG_PCIEXP_WAKE_DISABLE,
+					ACPI_BITMASK_PCIEXP_WAKE_STATUS,
+					ACPI_BITMASK_PCIEXP_WAKE_DISABLE},
 };
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 92c71dfce0d5..0b6c72033487 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -714,7 +714,8 @@ typedef u32 acpi_event_type;
 #define ACPI_EVENT_POWER_BUTTON         2
 #define ACPI_EVENT_SLEEP_BUTTON         3
 #define ACPI_EVENT_RTC                  4
-#define ACPI_EVENT_MAX                  4
+#define ACPI_EVENT_PCIE_WAKE            5
+#define ACPI_EVENT_MAX                  5
 #define ACPI_NUM_FIXED_EVENTS           ACPI_EVENT_MAX + 1
 
 /*
-- 
2.27.0

