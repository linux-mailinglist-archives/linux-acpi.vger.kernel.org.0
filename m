Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5346A0758
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Feb 2023 12:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjBWL3L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Feb 2023 06:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjBWL3L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Feb 2023 06:29:11 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4529C16AD2;
        Thu, 23 Feb 2023 03:29:10 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id A001320B9C3E;
        Thu, 23 Feb 2023 03:29:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A001320B9C3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1677151749;
        bh=9hqMgwt+9rfgzKvMywqn/H23HiHnKG9S9L6A/+1pzh0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i29yH4QlMPKS4SW/ENT64Kq927tWbvAyF40myhCMlmODmtS0isu0yeES40Bk7yQln
         9LxjzA3AdY/HaT+O3RgUj41vJ6xOtsSIEM27c6bcB7L6PlsB3afNdTOcdj9p9aLOWQ
         8BrLEF6ElLVt6kJSJnJZL9WhCMwY6HoOCjAM91yg=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        lenb@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v7 1/5] drivers/clocksource/hyper-v: non ACPI support in hyperv clock
Date:   Thu, 23 Feb 2023 03:29:01 -0800
Message-Id: <1677151745-16521-2-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
References: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a placeholder function for the hv_setup_stimer0_irq API to accommodate
systems without ACPI support. Since this function is not utilized on
x86/x64 systems and non-ACPI support is only intended for x86/x64 systems,
a placeholder function is sufficient for now and can be improved upon if
necessary in the future.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index c0cef92b12b8..f32948c8a96f 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -49,7 +49,7 @@ static bool direct_mode_enabled;
 
 static int stimer0_irq = -1;
 static int stimer0_message_sint;
-static DEFINE_PER_CPU(long, stimer0_evt);
+static __maybe_unused DEFINE_PER_CPU(long, stimer0_evt);
 
 /*
  * Common code for stimer0 interrupts coming via Direct Mode or
@@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(hv_stimer0_isr);
  * stimer0 interrupt handler for architectures that support
  * per-cpu interrupts, which also implies Direct Mode.
  */
-static irqreturn_t hv_stimer0_percpu_isr(int irq, void *dev_id)
+static irqreturn_t __maybe_unused hv_stimer0_percpu_isr(int irq, void *dev_id)
 {
 	hv_stimer0_isr();
 	return IRQ_HANDLED;
@@ -196,6 +196,7 @@ void __weak hv_remove_stimer0_handler(void)
 {
 };
 
+#ifdef CONFIG_ACPI
 /* Called only on architectures with per-cpu IRQs (i.e., not x86/x64) */
 static int hv_setup_stimer0_irq(void)
 {
@@ -230,6 +231,16 @@ static void hv_remove_stimer0_irq(void)
 		stimer0_irq = -1;
 	}
 }
+#else
+static int hv_setup_stimer0_irq(void)
+{
+	return 0;
+}
+
+static void hv_remove_stimer0_irq(void)
+{
+}
+#endif
 
 /* hv_stimer_alloc - Global initialization of the clockevent and stimer0 */
 int hv_stimer_alloc(bool have_percpu_irqs)
-- 
2.34.1

