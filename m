Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3117A5AFBC5
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Sep 2022 07:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIGFbf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Sep 2022 01:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGFbb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Sep 2022 01:31:31 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A39876BB
        for <linux-acpi@vger.kernel.org>; Tue,  6 Sep 2022 22:31:30 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v6so1268361ljj.0
        for <linux-acpi@vger.kernel.org>; Tue, 06 Sep 2022 22:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=ZjVLhNvDXo6WI35H+KkR+Le+8uveENo6nxqRMEKq6ns=;
        b=MJBd0QCZpSpLCn7sWYP5HNdeII5/0oIQNKEa6KCxeZv+lUltsWzAE/v5IlsBQUVs6Q
         ieR1cnK0HdJ4HzPFxztubIBCFrLJ02ymjwtVm8Mx+geYQ9rMAmEkyippWH6j7PkRGeE2
         rmQhPwj68LDygpIAlLCSAxefzGnkkyvoClOQpb858Dj4HN5Zrnw3II/hJzBpi7/DYrzB
         izIx3Tfo1Hf+G7jXc0v8fYG3NjcScIUIz2SmZo3fdlwr4LCgQzT0nkvyHyCsTwB0ZtNK
         mNloScDbYz2GqGmx/DxXEwcn3tAccTv37BAY4jrDGg8EG44PFFpcNvNA8t9vG8xBSBIZ
         3/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=ZjVLhNvDXo6WI35H+KkR+Le+8uveENo6nxqRMEKq6ns=;
        b=3fJxM7HQeA0CL9SWCUPnO19CKHW+UjsO/lRQJYeGbs0qcNplTeg+nXcQRfsuaIdqf4
         zbKlwpsqp40SBrpzOj+MrTnYU50fKJAOt5VWs8KUyxJM/TX31ofc0uq52qjaOSs5ng22
         ZnLx+jbqGOt19seElGBrGJ6Ypxz+nh+6gNPcxtPL+WPtQTYFezGuvsgrk8K4pCl9wkmc
         SAFiMIxuqzPDOzlmELn/grCnkUjxXnTBZdt7SPVEACFEmNBFJutM8P8vXKJZTBCM2xwM
         oZZP89do2JIUp0FjolBRSl8Bi8tIhzvQWGbKlYFQmdlAwnjOoBTJucKz5YythhmwUlyN
         8v5A==
X-Gm-Message-State: ACgBeo3ks9NA8me+a1xZC3+NUVCUeRtlJA8zPnsA1WNdWiFwuMvfOKNB
        UmCERzsSFSWbQceP01JjJUXKhHWI9kiYIQ==
X-Google-Smtp-Source: AA6agR7IGvio+Va2MhQ8Qi39oxC5KKDfxsJmUIUOs9nx6YimKuoNRwTUaqBS4mAauKgiUVXG4JGZ2A==
X-Received: by 2002:a2e:9098:0:b0:263:da35:4f59 with SMTP id l24-20020a2e9098000000b00263da354f59mr440513ljg.100.1662528688875;
        Tue, 06 Sep 2022 22:31:28 -0700 (PDT)
Received: from [192.168.0.199] (89-71-81-118.dynamic.chello.pl. [89.71.81.118])
        by smtp.gmail.com with ESMTPSA id k1-20020a2ea261000000b0025e4ab170e0sm2379173ljm.3.2022.09.06.22.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 22:31:28 -0700 (PDT)
Message-ID: <de1cf16c-54cb-316b-3fcb-2520e6bb152f@semihalf.com>
Date:   Wed, 7 Sep 2022 07:31:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   =?UTF-8?Q?Marek_Ma=c5=9blanka?= <mm@semihalf.com>
Subject: [PATCH] ACPI: Wait for ACPI IRQ to be processed before disable GPE
To:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, devel@acpica.org,
        upstream@semihalf.com, mm@semihalf.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/acpi/internal.h |  2 ++
 drivers/acpi/osl.c      | 18 ++++++++++++++++++
 drivers/acpi/sleep.c    |  6 ++++++
 include/linux/acpi.h    |  2 ++
 4 files changed, 28 insertions(+)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 219c02df9a08..e4df1bf2963b 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -251,6 +251,8 @@ static inline bool force_storage_d3(void)
 }
 #endif
 
+extern bool acpi_resume_gpe_irq_handled;
+
 /*--------------------------------------------------------------------------
 				Device properties
   -------------------------------------------------------------------------- */
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3269a888fb7a..ea587ac4c68a 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -42,6 +42,8 @@
 #define _COMPONENT		ACPI_OS_SERVICES
 ACPI_MODULE_NAME("osl");
 
+#define ACPI_WAIT_FOR_RESUME_GPE_IRQ_MS 500
+
 struct acpi_os_dpc {
 	acpi_osd_exec_callback function;
 	void *context;
@@ -69,6 +71,8 @@ static struct workqueue_struct *kacpi_hotplug_wq;
 static bool acpi_os_initialized;
 unsigned int acpi_sci_irq = INVALID_ACPI_IRQ;
 bool acpi_permanent_mmap = false;
+bool acpi_resume_gpe_irq_handled;
+static DECLARE_WAIT_QUEUE_HEAD(acpi_irq_after_suspend_wait);
 
 /*
  * This list of permanent mappings is for memory that may be accessed from
@@ -549,6 +553,10 @@ static irqreturn_t acpi_irq(int irq, void *dev_id)
 	handled = (*acpi_irq_handler) (acpi_irq_context);
 
 	if (handled) {
+		if (acpi_s2idle_wakeup()) {
+			acpi_resume_gpe_irq_handled = true;
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
+					 acpi_resume_gpe_irq_handled,
+					 wait_ms);
+	return timeout;
+}
+EXPORT_SYMBOL(acpi_wait_for_resume_gpe_irq);
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index ad4b2987b3d6..6ddf28067687 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -721,6 +721,7 @@ int acpi_s2idle_prepare(void)
 	acpi_os_wait_events_complete();
 
 	s2idle_wakeup = true;
+	acpi_resume_gpe_irq_handled = false;
 	return 0;
 }
 
@@ -789,6 +790,7 @@ bool acpi_s2idle_wake(void)
 
 void acpi_s2idle_restore(void)
 {
+	int timeout;
 	/*
 	 * Drain pending events before restoring the working-state configuration
 	 * of GPEs.
@@ -797,6 +799,10 @@ void acpi_s2idle_restore(void)
 	acpi_ec_flush_work(); /* flush the EC driver's workqueues */
 	acpi_os_wait_events_complete(); /* synchronize Notify handling */
 
+	timeout = acpi_wait_for_resume_gpe_irq();
+	if (timeout == 0)
+		pr_warn("Failed to wait for ACPI interrupt after resume");
+
 	s2idle_wakeup = false;
 
 	acpi_enable_all_runtime_gpes();
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ed4aa395cc49..ef2ab7990f1c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1475,4 +1475,6 @@ static inline void acpi_device_notify(struct device *dev) { }
 static inline void acpi_device_notify_remove(struct device *dev) { }
 #endif
 
+int acpi_wait_for_resume_gpe_irq(void);
+
 #endif	/*_LINUX_ACPI_H*/
-- 
2.37.2.789.g6183377224-goog
