Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4C5FB38F
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Oct 2022 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJKNkk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Oct 2022 09:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJKNkj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Oct 2022 09:40:39 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EECA4E624
        for <linux-acpi@vger.kernel.org>; Tue, 11 Oct 2022 06:40:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id j26so1407944ljg.13
        for <linux-acpi@vger.kernel.org>; Tue, 11 Oct 2022 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhGp51RBe4fqMSvTml1WIDMEO/sRwuyLq3HralMhRbg=;
        b=Rjwx3dCjZzMQOkF+3+pAChU+JJ5efJ/+/phh6XP2fRmBVrEeNyh5p3fI+WkXv0cZC4
         oPduY+gvNSczpjkhpNAkhDgQsVXoRFVwL5V4MSQ84vQRiSe1gKD9xdCFJOpKfixYBn2T
         7Q7Q3Wv1mq7icBK+Upu0aSUfqsovB9fXuN9cmV+VRIs5AIQvBMlj4NsLdPKxUvhtzhXt
         9ZRfTzTCW1GVUuLzUjGHgYkhyL59fQZg3hgFo30QqnONN37nejZYJrzBtBYJH7OlrFIP
         Qdh+ZZNglBrVCJOQqKYtdh//F0657HDBUwhWXqlBEXL3/GlYUbN3vZcGDPPgYHwpIhBy
         X2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AhGp51RBe4fqMSvTml1WIDMEO/sRwuyLq3HralMhRbg=;
        b=RdftsRwuYHuIJpiECeiRxhERWzzV+Zhh04u9qt7YGgsazjOLEyGGn2Jvq3I6UaChPA
         k9Vcrv1LEWIE42Zr8cu3fkFlydE7qBv1aiBhvljglBXeAVAy1Dezj6rHs/hdd0zI3/T3
         YCumUDCOckzOuBdie4t2a67q5iNTgZMnvbjppuMKXZ0+/sUNsd8l5iAftKbZ4WtDJrJz
         4dymdtQ0nl0FqVxnaflAJtTg4cPKCgLl3hg1dNEkM/MZi5+wadJLlGkDiQKfaxR7n9Vs
         1QGKpU4f7thZRJz7A1zveEVYFJqzydpGA8YtWWbVx07TYV/YMEO/UDq8q+z+36ZhPY19
         bpyw==
X-Gm-Message-State: ACrzQf2OLu1FwLNfw+nHNdjJE4nMwZFFWxv1TMre/ISjNvIR4JVRd8qd
        kkuD9uY977WuQBS1O4BhBz5c9Fg9xnHfozqK
X-Google-Smtp-Source: AMsMyM5qSz3EVbg1KsZCD3BhuhAZTk9IRRFbxYrCjI8qEqS/5ak+uBeOBkwu3uuyY+C8E0HPm0A82g==
X-Received: by 2002:a05:651c:178e:b0:25a:4357:49cd with SMTP id bn14-20020a05651c178e00b0025a435749cdmr9214002ljb.123.1665495633050;
        Tue, 11 Oct 2022 06:40:33 -0700 (PDT)
Received: from [192.168.0.199] (89-70-237-140.dynamic.chello.pl. [89.70.237.140])
        by smtp.gmail.com with ESMTPSA id c13-20020a19760d000000b00492f1b2ac0bsm1874054lff.101.2022.10.11.06.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 06:40:32 -0700 (PDT)
Message-ID: <b6256631-d4d3-9805-bd36-e8e8f7e42dba@semihalf.com>
Date:   Tue, 11 Oct 2022 15:40:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
From:   =?UTF-8?Q?Marek_Ma=c5=9blanka?= <mm@semihalf.com>
Subject: [PATCH v2] ACPI: Wait for ACPI IRQ to be processed before disable GPE
To:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, devel@acpica.org,
        upstream@semihalf.com, mm@semihalf.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On the wake-up, the ACPI GPE that are marked as a wakeup source are
turned off. Before turning off, the kernel waits for the currently
processing IRQ to finish and assumes that this is an ACPI interrupt that
triggered wake-up. In the case the first interrupt after wake-up is not
an ACPI interrupt, this might cause the ACPI GPE not to be processed
because it will be disabled.

The patch makes sure that an ACPI interrupt is processed before
disabling GPE that are wakeup sources.

This patch fix the issue that is seen on low-end Chromebooks with two
cores CPU when HPET IRQ is triggered while resuming the device and is
processed before the ACPI GPE interrupt on the same CPU core.

Signed-off-by: Marek Maslanka <mm@semihalf.com>
---
Changes in v2:
  - Reduce wait time for first interrupt after the resume to 10ms
  - Wait for the first interrupt after the resume only if resume was caused
    by GPE interrupt.

 drivers/acpi/internal.h |  2 ++
 drivers/acpi/osl.c      | 18 ++++++++++++++++++
 drivers/acpi/sleep.c    |  8 ++++++++
 include/linux/acpi.h    |  2 ++
 4 files changed, 30 insertions(+)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 628bf8f18130..e8eccbb2950d 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -251,6 +251,8 @@ static inline bool force_storage_d3(void)
 }
 #endif
 
+extern bool acpi_wait_for_irq_handled;
+
 /*--------------------------------------------------------------------------
 				Device properties
   -------------------------------------------------------------------------- */
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3269a888fb7a..8222d78f5bc9 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -42,6 +42,8 @@
 #define _COMPONENT		ACPI_OS_SERVICES
 ACPI_MODULE_NAME("osl");
 
+#define ACPI_WAIT_FOR_RESUME_GPE_IRQ_MS 10
+
 struct acpi_os_dpc {
 	acpi_osd_exec_callback function;
 	void *context;
@@ -69,6 +71,8 @@ static struct workqueue_struct *kacpi_hotplug_wq;
 static bool acpi_os_initialized;
 unsigned int acpi_sci_irq = INVALID_ACPI_IRQ;
 bool acpi_permanent_mmap = false;
+bool acpi_wait_for_irq_handled;
+static DECLARE_WAIT_QUEUE_HEAD(acpi_irq_after_suspend_wait);
 
 /*
  * This list of permanent mappings is for memory that may be accessed from
@@ -549,6 +553,10 @@ static irqreturn_t acpi_irq(int irq, void *dev_id)
 	handled = (*acpi_irq_handler) (acpi_irq_context);
 
 	if (handled) {
+		if (acpi_wait_for_irq_handled && acpi_s2idle_wakeup()) {
+			acpi_wait_for_irq_handled = false;
+			wake_up(&acpi_irq_after_suspend_wait);
+		}
 		acpi_irq_handled++;
 		return IRQ_HANDLED;
 	} else {
@@ -1768,3 +1776,13 @@ acpi_status acpi_os_enter_sleep(u8 sleep_state,
 					       reg_a_value, reg_b_value);
 	return status;
 }
+
+int acpi_wait_for_resume_gpe_irq(void)
+{
+	int wait_ms = msecs_to_jiffies(ACPI_WAIT_FOR_RESUME_GPE_IRQ_MS);
+	int timeout = wait_event_timeout(acpi_irq_after_suspend_wait,
+					 !acpi_wait_for_irq_handled,
+					 wait_ms);
+	return timeout;
+}
+EXPORT_SYMBOL(acpi_wait_for_resume_gpe_irq);
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 2ad57b207c39..4d8a47b6c807 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -765,6 +765,7 @@ bool acpi_s2idle_wake(void)
 		 * SCI-related wakeup and dispatch the EC GPE.
 		 */
 		if (acpi_ec_dispatch_gpe()) {
+			acpi_wait_for_irq_handled = true;
 			pm_pr_dbg("ACPI non-EC GPE wakeup\n");
 			return true;
 		}
@@ -793,6 +794,7 @@ bool acpi_s2idle_wake(void)
 
 void acpi_s2idle_restore(void)
 {
+	int timeout;
 	/*
 	 * Drain pending events before restoring the working-state configuration
 	 * of GPEs.
@@ -801,6 +803,12 @@ void acpi_s2idle_restore(void)
 	acpi_ec_flush_work(); /* flush the EC driver's workqueues */
 	acpi_os_wait_events_complete(); /* synchronize Notify handling */
 
+	if (acpi_any_gpe_status_set(first_ec->gpe)) {
+		timeout = acpi_wait_for_resume_gpe_irq();
+		if (timeout == 0)
+			pr_warn("Failed to wait for ACPI interrupt after resume");
+	}
+
 	s2idle_wakeup = false;
 
 	acpi_enable_all_runtime_gpes();
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6f64b2f3dc54..4b71e890a15f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1474,4 +1474,6 @@ static inline void acpi_device_notify(struct device *dev) { }
 static inline void acpi_device_notify_remove(struct device *dev) { }
 #endif
 
+int acpi_wait_for_resume_gpe_irq(void);
+
 #endif	/*_LINUX_ACPI_H*/
-- 
2.38.0.rc1.362.ged0d419d3c-goog

