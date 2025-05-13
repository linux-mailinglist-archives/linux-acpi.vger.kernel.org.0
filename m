Return-Path: <linux-acpi+bounces-13699-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72116AB50FC
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 12:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0901894C75
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 10:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE09246788;
	Tue, 13 May 2025 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpqwBDHz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DFD2459EA;
	Tue, 13 May 2025 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130724; cv=none; b=tvqMo2X5eLlm0Xor79Tx7YqsYd+1KOvd5ynfii+bjXEy7Hjz3hc+eHTJ12AeYDX1C78C+9/2U+1g3VCH8X0Tb7zR1YW2jxVkUpZ44ZMqPmU6u5FtXXtjY1LLcfHLRcjd6EzACDIYavpz9N7G8ENZynwTRjF00gQnh9hfT1o8Ip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130724; c=relaxed/simple;
	bh=iTca+j4Ek6Iyl7/PVriO9+MvieJVUXzt2WyyEQegAUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpdSYr7PVAh0N9HPubxO/BeFmh1vQixPm2TKtoJfBv73Q17QPBWozVOcY1FSRODU0HsU/ps+vl8dFBx2EijkzmnGxm5B8qzxdyPs/a9nGSqdIhJc8VnCp1NbwGKM7Ai47Sb97LhO3euueaDnZq/cuDdaPvWFk87yz+t7WfDdnms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UpqwBDHz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747130722; x=1778666722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iTca+j4Ek6Iyl7/PVriO9+MvieJVUXzt2WyyEQegAUY=;
  b=UpqwBDHzVlKjJZCodKFu3JGw8AVjekvStKnzLu/rl8jml755N7nytWih
   Ux5lrjt/eoMhX0GyQX6Ttolr6Y02J8excoCWBM0QuQhAORZpgDX6SEJXi
   Ohkj1p0PQOooEztI7iTOxIvf7m2fTgKmNKdWuJ1aNMw6rVLy5xX4RLqFn
   ooFs53QAUELvBPxuCWWckDylyQTRkZS9qyz80uOzmoz6EcAJaV9tg+I/b
   49j8jp3jHvE5NYJYqxj9q4gFCAG7fjwvhFjTrsKPCi1fUqq5YChOUlq8v
   OxQ06FGXoatgKeUbfHnWk0EvdhcWt1LUHAZT5LP4dOohxPXbeqSwYn68j
   A==;
X-CSE-ConnectionGUID: ZWuQNZE7Q9CVBsfWrZgf0w==
X-CSE-MsgGUID: NNSa02zDSN+NzMALkK3f6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59639136"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="59639136"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:05:20 -0700
X-CSE-ConnectionGUID: DJyUL+ozSpuWuzSHmniqqQ==
X-CSE-MsgGUID: /5vEov6jSIisYlkDunIwvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="137521339"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 13 May 2025 03:05:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F1D473F4; Tue, 13 May 2025 13:05:15 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 3/4] gpiolib: acpi: Add acpi_gpio_need_run_edge_events_on_boot() getter
Date: Tue, 13 May 2025 13:00:33 +0300
Message-ID: <20250513100514.2492545-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
References: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add acpi_gpio_need_run_edge_events_on_boot() getter which moves
towards isolating the GPIO ACPI and quirk APIs. It will helps
splitting them completely in the next changes.

No functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 7 ++++++-
 drivers/gpio/gpiolib-acpi.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index ac5f8ec6e72b..609e3a7f9636 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -268,7 +268,7 @@ static void acpi_gpiochip_request_irq(struct acpi_gpio_chip *acpi_gpio,
 	event->irq_requested = true;
 
 	/* Make sure we trigger the initial state of edge-triggered IRQs */
-	if (run_edge_events_on_boot &&
+	if (acpi_gpio_need_run_edge_events_on_boot() &&
 	    (event->irqflags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))) {
 		value = gpiod_get_raw_value_cansleep(event->desc);
 		if (((event->irqflags & IRQF_TRIGGER_RISING) && value == 1) ||
@@ -371,6 +371,11 @@ void acpi_gpio_remove_from_deferred_list(struct list_head *list)
 	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
 }
 
+int acpi_gpio_need_run_edge_events_on_boot(void)
+{
+	return run_edge_events_on_boot;
+}
+
 bool acpi_gpio_in_ignore_list(enum acpi_gpio_ignore_list list, const char *controller_in,
 			      unsigned int pin_in)
 {
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 8249977e6140..a90267470a4e 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -63,6 +63,8 @@ void acpi_gpio_process_deferred_list(struct list_head *list);
 bool acpi_gpio_add_to_deferred_list(struct list_head *list);
 void acpi_gpio_remove_from_deferred_list(struct list_head *list);
 
+int acpi_gpio_need_run_edge_events_on_boot(void);
+
 enum acpi_gpio_ignore_list {
 	ACPI_GPIO_IGNORE_WAKE,
 	ACPI_GPIO_IGNORE_INTERRUPT,
-- 
2.47.2


