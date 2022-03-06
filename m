Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263CA4CEAF7
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Mar 2022 12:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiCFLTP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Mar 2022 06:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCFLTP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Mar 2022 06:19:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCC938192
        for <linux-acpi@vger.kernel.org>; Sun,  6 Mar 2022 03:18:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4C63B80E92
        for <linux-acpi@vger.kernel.org>; Sun,  6 Mar 2022 11:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98840C340EE;
        Sun,  6 Mar 2022 11:18:17 +0000 (UTC)
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
Subject: [PATCH V2 2/2] ACPICA: Events: Support fixed pcie wake event
Date:   Sun,  6 Mar 2022 19:18:38 +0800
Message-Id: <20220306111838.810959-3-chenhuacai@loongson.cn>
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
index 5efa3d8e483e..fe677b5b31fe 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -311,6 +311,18 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
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
index 69e89d572b9e..5a5bdcfc38c3 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -719,7 +719,8 @@ typedef u32 acpi_event_type;
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

