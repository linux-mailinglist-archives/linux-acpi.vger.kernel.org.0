Return-Path: <linux-acpi+bounces-13700-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AF3AB512B
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 12:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5EA27B7422
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8AA247289;
	Tue, 13 May 2025 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bURta7dw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE78C246333;
	Tue, 13 May 2025 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130724; cv=none; b=itlKAUlIRhm6ZphtOiacGBtQr5IGwoohE8n2w9ymXwN8VS1iC0tf7430dfH327WVd4EB1/DAyEWq4S8vxg3sBKA56K3bju7jfElrehKIw2grocL3smN2ILho2GLPkQZ6oELNbO9oJeu0EHeqBtYeNEUa3MoUcHA46yx7cr8R4wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130724; c=relaxed/simple;
	bh=/PUL0rayWpEiH3KCXBxM94icahCpf+pQGWXm2QnC4SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZPXpX/rC1Z3JEv0flSOK/cw3GIK3zz2HnnTK5E0YhKWqqLHSPat2CLOrnWB4Q3c9Am6Zq1rlbMUIOB2LiFkzzlTo+RkPzfopW9aJsmj/7SJZiqhMJujHGTw+N29uw67BEUSM859Z4DUapJ28fEDqt1N6zD5DjFUdUtvN7by0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bURta7dw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747130723; x=1778666723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/PUL0rayWpEiH3KCXBxM94icahCpf+pQGWXm2QnC4SI=;
  b=bURta7dwZUTlGtuAtCfkn+TovdeWDk1vusAUi1u89AYZBma3WidlmRQW
   Ru4/nuQaDKQY/rwJaHshzJTJn1uX9myyU4x+Qd/JRJiAdxQAVGHY75c7T
   2Jq0sNZhP8b2+fofRj8ZG7gRzSBPn9ySMo4zzeGF2nPeiKygEP4kaAppw
   DqGE0JIkt1/A3JhNehyDHvMLnWVd8H+06nrExHfs6VZKgxFAxwOYGlxUW
   2mmH3jMFQr9rLPkCasjdx3qyYCmo4Gq0YnA+3R2NNEKun9SQs9jUEHsMy
   Vibvss8zZyI9Bt5fFiyKdXifVw8K2AhaQdZHCal40iXdyPyej++IqIyvr
   g==;
X-CSE-ConnectionGUID: SPdtaOttR9OJqovwA+8j2Q==
X-CSE-MsgGUID: AcU5rMqwRUiuSumwngFSAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59639141"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="59639141"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:05:20 -0700
X-CSE-ConnectionGUID: H62cjObGRCusekgBDnSYig==
X-CSE-MsgGUID: rTjrE5UORoW4+wxWFN7y2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="137521341"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 13 May 2025 03:05:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E73A835F; Tue, 13 May 2025 13:05:15 +0300 (EEST)
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
Subject: [PATCH v1 2/4] gpiolib: acpi: Handle deferred list via new API
Date: Tue, 13 May 2025 13:00:32 +0300
Message-ID: <20250513100514.2492545-3-andriy.shevchenko@linux.intel.com>
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

Introduce a new API and handle deferred list via it which moves
towards isolating the GPIO ACPI and quirk APIs. It will helps
splitting them completely in the next changes.

No functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 52 +++++++++++++++++++++++--------------
 drivers/gpio/gpiolib-acpi.h |  5 ++++
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index fb573b5f0ba1..ac5f8ec6e72b 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -350,6 +350,27 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 	return desc;
 }
 
+bool acpi_gpio_add_to_deferred_list(struct list_head *list)
+{
+	bool defer;
+
+	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
+	defer = !acpi_gpio_deferred_req_irqs_done;
+	if (defer)
+		list_add(list, &acpi_gpio_deferred_req_irqs_list);
+	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
+
+	return defer;
+}
+
+void acpi_gpio_remove_from_deferred_list(struct list_head *list)
+{
+	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
+	if (!list_empty(list))
+		list_del_init(list);
+	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
+}
+
 bool acpi_gpio_in_ignore_list(enum acpi_gpio_ignore_list list, const char *controller_in,
 			      unsigned int pin_in)
 {
@@ -536,7 +557,6 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip *chip)
 	struct acpi_gpio_chip *acpi_gpio;
 	acpi_handle handle;
 	acpi_status status;
-	bool defer;
 
 	if (!chip->parent || !chip->to_irq)
 		return;
@@ -555,14 +575,7 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip *chip)
 	acpi_walk_resources(handle, METHOD_NAME__AEI,
 			    acpi_gpiochip_alloc_event, acpi_gpio);
 
-	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
-	defer = !acpi_gpio_deferred_req_irqs_done;
-	if (defer)
-		list_add(&acpi_gpio->deferred_req_irqs_list_entry,
-			 &acpi_gpio_deferred_req_irqs_list);
-	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
-
-	if (defer)
+	if (acpi_gpio_add_to_deferred_list(&acpi_gpio->deferred_req_irqs_list_entry))
 		return;
 
 	acpi_gpiochip_request_irqs(acpi_gpio);
@@ -594,10 +607,7 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
 	if (ACPI_FAILURE(status))
 		return;
 
-	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
-	if (!list_empty(&acpi_gpio->deferred_req_irqs_list_entry))
-		list_del_init(&acpi_gpio->deferred_req_irqs_list_entry);
-	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
+	acpi_gpio_remove_from_deferred_list(&acpi_gpio->deferred_req_irqs_list_entry);
 
 	list_for_each_entry_safe_reverse(event, ep, &acpi_gpio->events, node) {
 		if (event->irq_requested) {
@@ -615,6 +625,14 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
 }
 EXPORT_SYMBOL_GPL(acpi_gpiochip_free_interrupts);
 
+void __init acpi_gpio_process_deferred_list(struct list_head *list)
+{
+	struct acpi_gpio_chip *acpi_gpio, *tmp;
+
+	list_for_each_entry_safe(acpi_gpio, tmp, list, deferred_req_irqs_list_entry)
+		acpi_gpiochip_request_irqs(acpi_gpio);
+}
+
 int acpi_dev_add_driver_gpios(struct acpi_device *adev,
 			      const struct acpi_gpio_mapping *gpios)
 {
@@ -1503,14 +1521,8 @@ int acpi_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 /* Run deferred acpi_gpiochip_request_irqs() */
 static int __init acpi_gpio_handle_deferred_request_irqs(void)
 {
-	struct acpi_gpio_chip *acpi_gpio, *tmp;
-
 	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
-	list_for_each_entry_safe(acpi_gpio, tmp,
-				 &acpi_gpio_deferred_req_irqs_list,
-				 deferred_req_irqs_list_entry)
-		acpi_gpiochip_request_irqs(acpi_gpio);
-
+	acpi_gpio_process_deferred_list(&acpi_gpio_deferred_req_irqs_list);
 	acpi_gpio_deferred_req_irqs_done = true;
 	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
 
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index ef0b1a3c85d7..8249977e6140 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -58,6 +58,11 @@ static inline int acpi_gpio_count(const struct fwnode_handle *fwnode,
 }
 #endif
 
+void acpi_gpio_process_deferred_list(struct list_head *list);
+
+bool acpi_gpio_add_to_deferred_list(struct list_head *list);
+void acpi_gpio_remove_from_deferred_list(struct list_head *list);
+
 enum acpi_gpio_ignore_list {
 	ACPI_GPIO_IGNORE_WAKE,
 	ACPI_GPIO_IGNORE_INTERRUPT,
-- 
2.47.2


