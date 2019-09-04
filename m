Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77809A8DAD
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 21:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbfIDR02 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 13:26:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47042 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731786AbfIDR01 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Sep 2019 13:26:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id t1so1613962plq.13;
        Wed, 04 Sep 2019 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NuMWLdxdTve81PAnnbAvwVvQsKEmdWC7pj6E9m+nSP4=;
        b=BmmsvbJ6Qv7vfjRvpYLHkjG0kiY5mMSgxQukgWkOSzMSeBvn8YDNSEjcujYWhI60Gs
         6E95DZsyvOIZf0VLmhK40xyw2tc+1Oi4FwkxrRX7NGHvLw6ggTpYaXauZavCskJx8t1N
         HExbwZX1mNiKGNpc6qViiZFrlIbO0jFyyFO6YwJmmA8Y4FfniEi4vEFGjLpbJIyAlSwh
         2675NY6cHVPI+NLBRHVXCLMcoxnuV7dH5dOv10afScLs1IjcQmiDt2x9itJ4YZ3J8ISZ
         fDNBqLEVxzeJwxeJ6Fjx5DoUCu5CH9K87NeM33q1eNNc3wGulPay+Htr4P6fP2EZVaS5
         iI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NuMWLdxdTve81PAnnbAvwVvQsKEmdWC7pj6E9m+nSP4=;
        b=NC7GVaDNFBO6Em/8vMVsXNSLMIEOeN6COcYh/jjmq87NJPWYcH/9WIN8MmxE+K24FW
         mPgjPISga10bSzx2KAavKqtpchyYNeKxfj92KFNIMrD9lv58rIBs/c7xFQxf8YGoaTrz
         qku4AdNxOPh8A3oGFqeKzs3S1Oef9d0Lgm/4RdaEuB2T3cPAOU48Au6c3MU8EfkkzeXr
         YR3mMt4GnsG+HUu7aegnL9kYodf27wo70T/6UyLbaG5TkvKKoMHrfQkrVlrKBPQGKJjL
         o92RB8d0RBkxZb1+WEcWSbgB/uGTd8n+D01LJethN726OsH5KuzJZ6xatDVx2MRfQf8d
         Nw6A==
X-Gm-Message-State: APjAAAV/qqDcJCkU8zP+15e5CaFjFkGc9fYRPHP7fsAcyxscl8Iz8ir+
        Og4huksVGSUsBAz7ytf5RfQ=
X-Google-Smtp-Source: APXvYqwPu9jzMxirXHDPc1lLcXxJHBScXiZql5wpzn4nUl6tw3CIq+FIa+XrOYeqZAMc2S7/nbA1ww==
X-Received: by 2002:a17:902:141:: with SMTP id 59mr42716384plb.324.1567617986782;
        Wed, 04 Sep 2019 10:26:26 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e189sm28365199pgc.15.2019.09.04.10.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 10:26:26 -0700 (PDT)
Date:   Wed, 4 Sep 2019 10:26:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpiolib: acpi: make acpi_can_fallback_to_crs() static
Message-ID: <20190904172624.GA76617@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It is not used outside gpiolib-acpi.c module, so there is no need to
export it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-acpi.c | 19 ++++++++++---------
 drivers/gpio/gpiolib-acpi.h |  8 --------
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index fdee8afa5339..2b6fdc9947f7 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -728,6 +728,16 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 	return ret ? ERR_PTR(ret) : lookup.desc;
 }
 
+static bool acpi_can_fallback_to_crs(struct acpi_device *adev,
+				     const char *con_id)
+{
+	/* Never allow fallback if the device has properties */
+	if (acpi_dev_has_props(adev) || adev->driver_gpios)
+		return false;
+
+	return con_id == NULL;
+}
+
 struct gpio_desc *acpi_find_gpio(struct device *dev,
 				 const char *con_id,
 				 unsigned int idx,
@@ -1264,15 +1274,6 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
 	return count ? count : -ENOENT;
 }
 
-bool acpi_can_fallback_to_crs(struct acpi_device *adev, const char *con_id)
-{
-	/* Never allow fallback if the device has properties */
-	if (acpi_dev_has_props(adev) || adev->driver_gpios)
-		return false;
-
-	return con_id == NULL;
-}
-
 /* Run deferred acpi_gpiochip_request_irqs() */
 static int acpi_gpio_handle_deferred_request_irqs(void)
 {
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index d7241b432b8b..1c6d65cf0629 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -52,8 +52,6 @@ struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
 				      struct acpi_gpio_info *info);
 
 int acpi_gpio_count(struct device *dev, const char *con_id);
-
-bool acpi_can_fallback_to_crs(struct acpi_device *adev, const char *con_id);
 #else
 static inline void acpi_gpiochip_add(struct gpio_chip *chip) { }
 static inline void acpi_gpiochip_remove(struct gpio_chip *chip) { }
@@ -93,12 +91,6 @@ static inline int acpi_gpio_count(struct device *dev, const char *con_id)
 {
 	return -ENODEV;
 }
-
-static inline bool acpi_can_fallback_to_crs(struct acpi_device *adev,
-					    const char *con_id)
-{
-	return false;
-}
 #endif
 
 #endif /* GPIOLIB_ACPI_H */
-- 
2.23.0.187.g17f5b7556c-goog


-- 
Dmitry
