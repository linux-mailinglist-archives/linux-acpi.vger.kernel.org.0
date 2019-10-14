Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77EDED5DF6
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2019 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfJNI4Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Oct 2019 04:56:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39652 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730354AbfJNI4Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Oct 2019 04:56:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17so7716868plp.6
        for <linux-acpi@vger.kernel.org>; Mon, 14 Oct 2019 01:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mjLBr8oELyUqsjoedqTyyNbUv1Fj77cAeeFwghcrwAU=;
        b=bRssmxn8bccRGkxF1BKYSX94fMHi3AWGqieb0zJeosveqTUHj3z/pArGNtCA4q3E+P
         OUtbL6vgO7wEpzQdvXB90pvGS8ELTMchfXAvvVK5t/4RMjeMTlbjIks/Ja2JMQvPgGQU
         PY7tfxL1ENuMSLz+9VLVB8AV9BkzbWZ0XrWRL5OXTVRfFlubTAHT2DBXQDdw02nQ0xjf
         TJzddXuTkGt4yLAdSCvAsc4z9btK/e3NVAmzVHtf8tUEphTRa+zC1VDp9Kd12Fcvx4Sj
         vT6OlugMbievfsivODwwfX1Hhwv2n9KN8Ncz5DiIw8aYMySL1Q2cz+b/ouPDwbK/M+IN
         NzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjLBr8oELyUqsjoedqTyyNbUv1Fj77cAeeFwghcrwAU=;
        b=NC2krHGKl1xi7iuBQUnPOZlCsPTypWGoqJaNafCbTfJabP4Z1ealfkUgDjug5FzlKd
         3LciCTm8i0gqy4xviJH0sNsKhGgszXiLKOW3npVNlboNOBhpnil45U19vk+9b7felipc
         9R0w93PAztHGIKLQEAyMRYx62knUFYcE3koTkWm/9f/EHRDNQ4PHQtRmzqmkl8Jc/9ET
         fIfqak2eNbT3UbDy0XHDC2zlgTptdItIvQagUtLin2ZVz3fXq51vxCJ0QTodBW77G+Cj
         0S75REbt+6FYS/C7T8buc1oDTWtrMBSkolE4yv5SnefUIv2rdpXZXaXj1v+4xTZgC6ax
         u9jQ==
X-Gm-Message-State: APjAAAU/cGox/46Kp2DO1lSoUlJWt8nargbg4BwAlWEBO9gBWLsdE0TL
        qTeW3hH56xya9+bk3YrCCZJSNQ==
X-Google-Smtp-Source: APXvYqyGtYp9Iii+dPFhDm+i6Ch0XiDwrmwOi4hPfDw4wD9a4K4jtmK+eq5i+O8otcGIkGSnLl1/KQ==
X-Received: by 2002:a17:902:ab89:: with SMTP id f9mr28840115plr.295.1571043373909;
        Mon, 14 Oct 2019 01:56:13 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id d14sm29701957pfh.36.2019.10.14.01.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 01:56:13 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux@endlessm.com
Subject: [PATCH v2 2/2] ACPI: EC: add support for hardware-reduced systems
Date:   Mon, 14 Oct 2019 16:56:02 +0800
Message-Id: <20191014085602.10644-2-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014085602.10644-1-drake@endlessm.com>
References: <20191014085602.10644-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As defined in the ACPI spec section 12.11, ACPI hardware-reduced
platforms define the EC SCI interrupt as a GpioInt in the _CRS object.

This replaces the previous way of using a GPE for this interrupt;
GPE blocks are not available on reduced hardware platforms.

Add support for handling this interrupt as an EC event source, and
avoid GPE usage on reduced hardware platforms.

This enables the use of several media keys (e.g. screen brightness
up/down) on Asus UX434DA.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---

Notes:
    v2:
     - Split renames into a preceding patch
     - Tried to address feedback. It wasn't super easy, further comments
       are very welcome.

 drivers/acpi/ec.c       | 146 ++++++++++++++++++++++++++++++----------
 drivers/acpi/internal.h |   3 +-
 2 files changed, 114 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 97e08d0e3192..4b1a285c3c78 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -398,7 +398,7 @@ static void acpi_ec_submit_request(struct acpi_ec *ec)
 {
 	ec->reference_count++;
 	if (test_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags) &&
-	    ec->reference_count == 1)
+	    ec->gpe >= 0 && ec->reference_count == 1)
 		acpi_ec_enable_gpe(ec, true);
 }
 
@@ -408,7 +408,7 @@ static void acpi_ec_complete_request(struct acpi_ec *ec)
 
 	ec->reference_count--;
 	if (test_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags) &&
-	    ec->reference_count == 0)
+	    ec->gpe >= 0 && ec->reference_count == 0)
 		acpi_ec_disable_gpe(ec, true);
 	flushed = acpi_ec_flushed(ec);
 	if (flushed)
@@ -418,7 +418,10 @@ static void acpi_ec_complete_request(struct acpi_ec *ec)
 static void acpi_ec_mask_events(struct acpi_ec *ec)
 {
 	if (!test_bit(EC_FLAGS_EVENTS_MASKED, &ec->flags)) {
-		acpi_ec_disable_gpe(ec, false);
+		if (ec->gpe >= 0)
+			acpi_ec_disable_gpe(ec, false);
+		else
+			disable_irq_nosync(ec->irq);
 		ec_dbg_drv("Polling enabled");
 		set_bit(EC_FLAGS_EVENTS_MASKED, &ec->flags);
 	}
@@ -428,7 +431,10 @@ static void acpi_ec_unmask_events(struct acpi_ec *ec)
 {
 	if (test_bit(EC_FLAGS_EVENTS_MASKED, &ec->flags)) {
 		clear_bit(EC_FLAGS_EVENTS_MASKED, &ec->flags);
-		acpi_ec_enable_gpe(ec, false);
+		if (ec->gpe >= 0)
+			acpi_ec_enable_gpe(ec, false);
+		else
+			enable_irq(ec->irq);
 		ec_dbg_drv("Polling disabled");
 	}
 }
@@ -648,7 +654,8 @@ static void advance_transaction(struct acpi_ec *ec)
 	 * ensure a hardware STS 0->1 change after this clearing can always
 	 * trigger a GPE interrupt.
 	 */
-	acpi_ec_clear_gpe(ec);
+	if (ec->gpe >= 0)
+		acpi_ec_clear_gpe(ec);
 	status = acpi_ec_read_status(ec);
 	t = ec->curr;
 	/*
@@ -1275,18 +1282,28 @@ static void acpi_ec_event_handler(struct work_struct *work)
 	acpi_ec_check_event(ec);
 }
 
-static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
-	u32 gpe_number, void *data)
+static void acpi_ec_handle_interrupt(struct acpi_ec *ec)
 {
 	unsigned long flags;
-	struct acpi_ec *ec = data;
 
 	spin_lock_irqsave(&ec->lock, flags);
 	advance_transaction(ec);
 	spin_unlock_irqrestore(&ec->lock, flags);
+}
+
+static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
+			       u32 gpe_number, void *data)
+{
+	acpi_ec_handle_interrupt(data);
 	return ACPI_INTERRUPT_HANDLED;
 }
 
+static irqreturn_t acpi_ec_irq_handler(int irq, void *data)
+{
+	acpi_ec_handle_interrupt(data);
+	return IRQ_HANDLED;
+}
+
 /* --------------------------------------------------------------------------
  *                           Address Space Management
  * -------------------------------------------------------------------------- */
@@ -1359,6 +1376,8 @@ static struct acpi_ec *acpi_ec_alloc(void)
 	ec->timestamp = jiffies;
 	ec->busy_polling = true;
 	ec->polling_guard = 0;
+	ec->gpe = -1;
+	ec->irq = -1;
 	return ec;
 }
 
@@ -1406,9 +1425,12 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 		/* Get GPE bit assignment (EC events). */
 		/* TODO: Add support for _GPE returning a package */
 		status = acpi_evaluate_integer(handle, "_GPE", NULL, &tmp);
-		if (ACPI_FAILURE(status))
-			return status;
-		ec->gpe = tmp;
+		if (ACPI_SUCCESS(status))
+			ec->gpe = tmp;
+		/*
+		 * Errors are non-fatal, allowing for ACPI Reduced Hardware
+		 * platforms which use GpioInt instead of GPE.
+		 */
 	}
 	/* Use the global lock for all EC transactions? */
 	tmp = 0;
@@ -1418,12 +1440,57 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 	return AE_CTRL_TERMINATE;
 }
 
+static void install_gpe_event_handler(struct acpi_ec *ec)
+{
+	acpi_status status =
+		acpi_install_gpe_raw_handler(NULL, ec->gpe,
+					     ACPI_GPE_EDGE_TRIGGERED,
+					     &acpi_ec_gpe_handler,
+					     ec);
+	if (ACPI_SUCCESS(status)) {
+		/* This is not fatal as we can poll EC events */
+		set_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags);
+		acpi_ec_leave_noirq(ec);
+		if (test_bit(EC_FLAGS_STARTED, &ec->flags) &&
+		    ec->reference_count >= 1)
+			acpi_ec_enable_gpe(ec, true);
+	}
+}
+
+/* ACPI reduced hardware platforms use a GpioInt specified in _CRS. */
+static int install_gpio_irq_event_handler(struct acpi_ec *ec,
+					  struct acpi_device *device)
+{
+	int irq = acpi_dev_gpio_irq_get(device, 0);
+	int ret;
+
+	if (irq < 0)
+		return irq;
+
+	ret = request_irq(irq, acpi_ec_irq_handler, IRQF_SHARED,
+			  "ACPI EC", ec);
+
+	/*
+	 * Unlike the GPE case, we treat errors here as fatal, we'll only
+	 * implement GPIO polling if we find a case that needs it.
+	 */
+	if (ret < 0)
+		return ret;
+
+	ec->irq = irq;
+	set_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags);
+	acpi_ec_leave_noirq(ec);
+
+	return 0;
+}
+
 /*
  * Note: This function returns an error code only when the address space
  *       handler is not installed, which means "not able to handle
  *       transactions".
  */
-static int ec_install_handlers(struct acpi_ec *ec, bool handle_events)
+static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
+			       bool handle_events)
 {
 	acpi_status status;
 
@@ -1464,16 +1531,15 @@ static int ec_install_handlers(struct acpi_ec *ec, bool handle_events)
 		set_bit(EC_FLAGS_QUERY_METHODS_INSTALLED, &ec->flags);
 	}
 	if (!test_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags)) {
-		status = acpi_install_gpe_raw_handler(NULL, ec->gpe,
-					  ACPI_GPE_EDGE_TRIGGERED,
-					  &acpi_ec_gpe_handler, ec);
-		/* This is not fatal as we can poll EC events */
-		if (ACPI_SUCCESS(status)) {
-			set_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags);
-			acpi_ec_leave_noirq(ec);
-			if (test_bit(EC_FLAGS_STARTED, &ec->flags) &&
-			    ec->reference_count >= 1)
-				acpi_ec_enable_gpe(ec, true);
+		if (ec->gpe >= 0) {
+			install_gpe_event_handler(ec);
+		} else if (device) {
+			int ret = install_gpio_irq_event_handler(ec, device);
+
+			if (ret)
+				return ret;
+		} else { /* No GPE and no GpioInt? */
+			return -ENODEV;
 		}
 	}
 	/* EC is fully operational, allow queries */
@@ -1505,9 +1571,13 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 	acpi_ec_stop(ec, false);
 
 	if (test_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags)) {
-		if (ACPI_FAILURE(acpi_remove_gpe_handler(NULL, ec->gpe,
-					&acpi_ec_gpe_handler)))
+		if (ec->gpe >= 0 &&
+		    ACPI_FAILURE(acpi_remove_gpe_handler(NULL, ec->gpe,
+				 &acpi_ec_gpe_handler)))
 			pr_err("failed to remove gpe handler\n");
+		if (ec->irq >= 0)
+			free_irq(ec->irq, ec);
+
 		clear_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags);
 	}
 	if (test_bit(EC_FLAGS_QUERY_METHODS_INSTALLED, &ec->flags)) {
@@ -1516,11 +1586,12 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 	}
 }
 
-static int acpi_ec_setup(struct acpi_ec *ec, bool handle_events)
+static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device,
+			 bool handle_events)
 {
 	int ret;
 
-	ret = ec_install_handlers(ec, handle_events);
+	ret = ec_install_handlers(ec, device, handle_events);
 	if (ret)
 		return ret;
 
@@ -1531,8 +1602,8 @@ static int acpi_ec_setup(struct acpi_ec *ec, bool handle_events)
 	}
 
 	acpi_handle_info(ec->handle,
-			 "GPE=0x%x, EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n",
-			 ec->gpe, ec->command_addr, ec->data_addr);
+			 "GPE=0x%x, IRQ=%d, EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n",
+			 ec->gpe, ec->irq, ec->command_addr, ec->data_addr);
 	return ret;
 }
 
@@ -1596,7 +1667,7 @@ static int acpi_ec_add(struct acpi_device *device)
 		}
 	}
 
-	ret = acpi_ec_setup(ec, true);
+	ret = acpi_ec_setup(ec, device, true);
 	if (ret)
 		goto err_query;
 
@@ -1716,7 +1787,7 @@ void __init acpi_ec_dsdt_probe(void)
 	 * At this point, the GPE is not fully initialized, so do not to
 	 * handle the events.
 	 */
-	ret = acpi_ec_setup(ec, false);
+	ret = acpi_ec_setup(ec, NULL, false);
 	if (ret) {
 		acpi_ec_free(ec);
 		return;
@@ -1889,14 +1960,21 @@ void __init acpi_ec_ecdt_probe(void)
 		ec->command_addr = ecdt_ptr->control.address;
 		ec->data_addr = ecdt_ptr->data.address;
 	}
-	ec->gpe = ecdt_ptr->gpe;
+
+	/*
+	 * Ignore the GPE value on Reduced Hardware platforms.
+	 * Some products have this set to an erroneous value.
+	 */
+	if (!acpi_gbl_reduced_hardware)
+		ec->gpe = ecdt_ptr->gpe;
+
 	ec->handle = ACPI_ROOT_OBJECT;
 
 	/*
 	 * At this point, the namespace is not initialized, so do not find
 	 * the namespace objects, or handle the events.
 	 */
-	ret = acpi_ec_setup(ec, false);
+	ret = acpi_ec_setup(ec, NULL, false);
 	if (ret) {
 		acpi_ec_free(ec);
 		return;
@@ -1928,7 +2006,7 @@ static int acpi_ec_suspend_noirq(struct device *dev)
 	 * masked at the low level without side effects.
 	 */
 	if (ec_no_wakeup && test_bit(EC_FLAGS_STARTED, &ec->flags) &&
-	    ec->reference_count >= 1)
+	    ec->gpe >= 0 && ec->reference_count >= 1)
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
 
 	acpi_ec_enter_noirq(ec);
@@ -1943,7 +2021,7 @@ static int acpi_ec_resume_noirq(struct device *dev)
 	acpi_ec_leave_noirq(ec);
 
 	if (ec_no_wakeup && test_bit(EC_FLAGS_STARTED, &ec->flags) &&
-	    ec->reference_count >= 1)
+	    ec->gpe >= 0 && ec->reference_count >= 1)
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);
 
 	return 0;
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index afe6636f9ad3..3616daec650b 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -165,7 +165,8 @@ static inline void acpi_early_processor_osc(void) {}
    -------------------------------------------------------------------------- */
 struct acpi_ec {
 	acpi_handle handle;
-	u32 gpe;
+	int gpe;
+	int irq;
 	unsigned long command_addr;
 	unsigned long data_addr;
 	bool global_lock;
-- 
2.20.1

