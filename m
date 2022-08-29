Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F1D5A4709
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Aug 2022 12:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiH2KV5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Aug 2022 06:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2KV5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Aug 2022 06:21:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C7C45981
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 03:21:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z20so7582641ljq.3
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 03:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=6I1BqOYVMOO9SZHVbCEJEdhVmTH6bYRSkaiIj2t2s3M=;
        b=FnBHSjDBWP/ew+2swiPkwSsdyzlb8BdicEjpgR0lGMqtnj0Fv2Dmdi9wwVrxtBemK5
         WR8v8W5J5cjU6m6BV3S2R6bF0uo1Vu8Wx0Zm+B/pM+1CJ6iraEGmGD8+ABoGWVPW1hqs
         5n5Eox0i/DlG6AagCkaFR5t1OJnBfugck8JiBAL+DDHZDR1HOvs4bbdW76EJ5yOYnWFk
         x4p50r+t5k6QdAV9VfiQ/3zO3SXUe+4m7kdwiwHCJ3x13zmOC/o3lVGbvVFmkUQssO5C
         rUnjaCuhm8YqtverPlkV+D9gcbChri6vILzat0GZorbikb/8jCKSy3tNYSoEL6tjj744
         ILFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=6I1BqOYVMOO9SZHVbCEJEdhVmTH6bYRSkaiIj2t2s3M=;
        b=421+5zPuHv7SbJA2F9zLzrd/MjM4Bb473s2lwyq8Cu5OCijCi0VfP2ZfnTavecn5Sr
         T0ktvdEgF28SyQaevBqIIfWtRuC5J8k0FS1uo+WArObmt85UgtDDmprumwUEURJMAd2O
         BQBCiiDOErtnjBPsZ9hCfFPHHur/xcPR0cN+ZNviz/SvgaB6DzhRSJTMRDFM1nujfza1
         F2oILq+aCXubc/lE4UhlIVjkcgE6Q7MIWP+9HFCVeG27jMMYURAyl3mL1gKyI9z2raZK
         Hy6V2k6VumLRPhQDnF0MUbQ9P43hYi7/UvZa/LGwWaNOKrXTKt38q2fkRAs5MX6Ayuet
         gL7w==
X-Gm-Message-State: ACgBeo0xCGJXAkVMqGE7zbH5kA4dSfkBR216H9qzMEx7Py1+HMsKv3vR
        J6eRVydiUOLWGztohrP8MiySv/kXG1ZRdpQH
X-Google-Smtp-Source: AA6agR4QzP3rW2cMCXlpfkUS4hwwhmcMzeowxYEYApFovazQ9ZNFA2wW2q2sN78XdcSm1jSJTUkG4Q==
X-Received: by 2002:a2e:a812:0:b0:261:8f2d:9530 with SMTP id l18-20020a2ea812000000b002618f2d9530mr5040381ljq.251.1661768513839;
        Mon, 29 Aug 2022 03:21:53 -0700 (PDT)
Received: from [10.77.100.217] ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id u9-20020a056512040900b0048a982ad0a8sm1241440lfk.23.2022.08.29.03.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 03:21:53 -0700 (PDT)
Message-ID: <1cf5ec82-0f1e-3bc7-4367-dcba1ee0f64d@semihalf.com>
Date:   Mon, 29 Aug 2022 12:21:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   =?UTF-8?Q?Marek_Ma=c5=9blanka?= <mm@semihalf.com>
Subject: [PATCH] ACPICA: Synchronize disabling wake mask and servicing wake-up
 IRQ
To:     linux-acpi@vger.kernel.org
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, upstream@semihalf.com, mm@semihalf.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The GPE interrupts that are the wake-up source are "turned off" by clear
the “enable_for_wake” flag when the kernel resumes (suspend_enter() ->
acpi_s2idle_restore() -> acpi_disable_wakeup_devices() ->
acpi_set_gpe_wake_mask()). On the resume path the kernel also resumes
the interrupts (suspend_enter() -> dpm_resume_noirq() -> resume_irqs())
which process the GPE interrupt that woke-up the kernel (... ->
acpi_irq() -> acpi_ev_sci_xrupt_handler() -> acpi_ev_gpe_detect() -> …).
The GPE interrupt routine stops in the acpi_ev_gpe_detect () function
when the "enable_for_wake" flag is cleared.

As the interrupt servicing might work simultaneously on SMP, it’s
possible that the “enable_for_wake” flag can be cleared before the GPE
interrupt gets chances to be processed. It might happen when the CPU
processed other IRQ before the GPE IRQ that woke up the device.

This issue is seen on low-end Chromebooks with two cores CPU when HPET
IRQ is triggered while resuming the device and is processed before the
ACPI GPE interrupt on the same CPU core.

Before clear the enable_for_wake flag we need to make sure that the
specific wake-up GPE IRQ block was processed.

Signed-off-by: Marek Maslanka <mm@semihalf.com>
---
 drivers/acpi/acpica/aclocal.h |   3 +
 drivers/acpi/acpica/evgpe.c   |   8 +++
 drivers/acpi/acpica/evxfgpe.c | 123 ++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c           |   1 +
 drivers/acpi/wakeup.c         |   3 +
 include/acpi/acpixf.h         |   9 +++
 6 files changed, 147 insertions(+)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 901b1543b869..2925055e8546 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -10,6 +10,8 @@
 #ifndef __ACLOCAL_H__
 #define __ACLOCAL_H__
 
+#include <linux/wait.h>
+
 /* acpisrc:struct_defs -- for acpisrc conversion */
 
 #define ACPI_SERIALIZED                 0xFF
@@ -471,6 +473,7 @@ struct acpi_gpe_register_info {
 	u8 enable_for_run;	/* GPEs to keep enabled when running */
 	u8 mask_for_run;	/* GPEs to keep masked when running */
 	u8 enable_mask;		/* Current mask of enabled GPEs */
+	wait_queue_head_t wake_mask_wq;	/* Waitqueue to sync disabling wakeup mask bit */
 };
 
 /*
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index a6bb480d631c..3bfb08b5b0a9 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -355,6 +355,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list)
 	acpi_cpu_flags flags;
 	u32 i;
 	u32 j;
+	u8 gpe_can_wake;
 
 	ACPI_FUNCTION_NAME(ev_gpe_detect);
 
@@ -408,6 +409,8 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list)
 				continue;
 			}
 
+			gpe_can_wake = 0;
+
 			/* Now look at the individual GPEs in this byte register */
 
 			for (j = 0; j < ACPI_GPE_REGISTER_WIDTH; j++) {
@@ -420,6 +423,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list)
 						ACPI_GPE_REGISTER_WIDTH) + j];
 				gpe_number =
 				    j + gpe_register_info->base_gpe_number;
+				gpe_can_wake |= gpe_event_info->flags & ACPI_GPE_CAN_WAKE;
 				acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 				int_status |=
 				    acpi_ev_detect_gpe(gpe_device,
@@ -427,6 +431,10 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list)
 						       gpe_number);
 				flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 			}
+
+			/* Notify the wakeup GPE event has been processed */
+			if (gpe_register_info->enable_for_wake && gpe_can_wake)
+				wake_up(&gpe_register_info->wake_mask_wq);
 		}
 
 		gpe_block = gpe_block->next;
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 340947e412bb..16eac034abfa 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -17,6 +17,9 @@
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evxfgpe")
 
+/* How long to wait for the GPE status flag to be set */
+#define ACPI_WAIT_GPE_STATUS_FLAG_MS 500
+
 #if (!ACPI_REDUCED_HARDWARE)	/* Entire module */
 /*******************************************************************************
  *
@@ -242,6 +245,50 @@ acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action)
 
 ACPI_EXPORT_SYMBOL(acpi_set_gpe)
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_init_gpe_wake_wq
+ *
+ * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number          - GPE level within the GPE block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Init wake waitqueue for GPE.
+ *
+ ******************************************************************************/
+acpi_status acpi_init_gpe_wake_wq(acpi_handle gpe_device, u32 gpe_number)
+{
+	struct acpi_gpe_event_info *gpe_event_info;
+	struct acpi_gpe_register_info *gpe_register_info;
+	acpi_status status = AE_BAD_PARAMETER;
+	acpi_cpu_flags flags;
+
+	ACPI_FUNCTION_TRACE(acpi_init_gpe_wake_wq);
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Ensure that we have a valid GPE number */
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (gpe_event_info) {
+		gpe_register_info = gpe_event_info->register_info;
+		if (gpe_register_info) {
+			init_waitqueue_head(&gpe_register_info->wake_mask_wq);
+			status = AE_OK;
+		} else {
+			ACPI_WARNING((AE_INFO,
+				      "GPE 0x%x doesn't have a register info",
+				      gpe_number));
+			status = AE_NOT_EXIST;
+		}
+	}
+
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+ACPI_EXPORT_SYMBOL(acpi_init_gpe_wake_wq)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_mask_gpe
@@ -637,6 +684,82 @@ acpi_get_gpe_status(acpi_handle gpe_device,
 
 ACPI_EXPORT_SYMBOL(acpi_get_gpe_status)
 
+static u8
+acpi_is_gpe_status_set(acpi_handle gpe_device, u32 gpe_number)
+{
+	acpi_event_status event_status;
+
+	acpi_get_gpe_status(gpe_device, gpe_number, &event_status);
+	return event_status & ACPI_EVENT_FLAG_STATUS_SET;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_wait_for_gpe_status_flag
+ *
+ * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number          - GPE level within the GPE block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Wait for clear the status bit in wakeup mask
+ *
+ ******************************************************************************/
+acpi_status
+acpi_wait_for_gpe_status_flag(acpi_handle gpe_device, u32 gpe_number)
+{
+	acpi_status status = AE_OK;
+	struct acpi_gpe_event_info *gpe_event_info;
+	struct acpi_gpe_register_info *gpe_register_info;
+	acpi_cpu_flags flags;
+	int timeout;
+	int wait_ms;
+
+	ACPI_FUNCTION_TRACE(acpi_wait_for_gpe_status_flag);
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Ensure that we have a valid GPE number */
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	if (!(gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
+		status = AE_TYPE;
+		goto unlock_and_exit;
+	}
+
+	gpe_register_info = gpe_event_info->register_info;
+	if (!gpe_register_info) {
+		status = AE_NOT_EXIST;
+		goto unlock_and_exit;
+	}
+
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+
+	wait_ms = msecs_to_jiffies(ACPI_WAIT_GPE_STATUS_FLAG_MS);
+	timeout = wait_event_timeout(gpe_register_info->wake_mask_wq,
+				     !acpi_is_gpe_status_set(gpe_device,
+							     gpe_number),
+				     wait_ms);
+	if (timeout == 0) {
+		ACPI_WARNING((AE_INFO,
+			      "Time limit exceeded while waiting for GPE 0x%x status flag",
+			      gpe_number));
+		status = AE_TIME;
+	}
+
+	return_ACPI_STATUS(status);
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+ACPI_EXPORT_SYMBOL(acpi_wait_for_gpe_status_flag)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_gispatch_gpe
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 42cec8120f18..26ba59545ceb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -952,6 +952,7 @@ static bool acpi_wakeup_gpe_init(struct acpi_device *device)
 			if (wakeup->sleep_state == ACPI_STATE_S5)
 				wakeup->sleep_state = ACPI_STATE_S4;
 		}
+		acpi_init_gpe_wake_wq(wakeup->gpe_device, wakeup->gpe_number);
 		acpi_mark_gpe_for_wake(wakeup->gpe_device, wakeup->gpe_number);
 		device_set_wakeup_capable(&device->dev, true);
 		return true;
diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index b02bf770aead..044429e69f86 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -72,6 +72,9 @@ void acpi_disable_wakeup_devices(u8 sleep_state)
 			 || dev->wakeup.prepare_count))
 			continue;
 
+		acpi_wait_for_gpe_status_flag(dev->wakeup.gpe_device,
+					      dev->wakeup.gpe_number);
+
 		acpi_set_gpe_wake_mask(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
 				ACPI_GPE_DISABLE);
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 67c0b9e734b6..cc4b43caa872 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -728,6 +728,10 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_finish_gpe(acpi_handle gpe_device,
 						u32 gpe_number))
 
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_init_gpe_wake_wq(acpi_handle gpe_device,
+						u32 gpe_number))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_mask_gpe(acpi_handle gpe_device,
 					      u32 gpe_number, u8 is_masked))
@@ -741,6 +745,11 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 							parent_device,
 							acpi_handle gpe_device,
 							u32 gpe_number))
+
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				 acpi_wait_for_gpe_status_flag(acpi_handle gpe_device,
+							u32 gpe_number))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_set_gpe_wake_mask(acpi_handle gpe_device,
 							u32 gpe_number,
-- 
2.37.2.672.g94769d06f0-goog
