Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9BF3ED226
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 12:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhHPKl6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 06:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230250AbhHPKl5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Aug 2021 06:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629110486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V9lD4ZmCA2xeNbbRR9JsVRuBy+tH5ySdLMD/ECLgSTI=;
        b=TjlMHe2stdg1MTMTIgWJ09QPImNYoxH2SUPeH9ypRlOuHvMMEw1X7tgpZ0ORkr9JeYWgRB
        qkWwHddygZh5g/6Dt5OOD+OjaodMo3hWXOM4FcD5p6K9zIAnCG1VaX9LZi8ii1t/js8kMv
        l3nM/wuquVo567FEroReiZeUOMSeBxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-Jhr0IT9cMJGxc__N4WMSAQ-1; Mon, 16 Aug 2021 06:41:23 -0400
X-MC-Unique: Jhr0IT9cMJGxc__N4WMSAQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD5561853026;
        Mon, 16 Aug 2021 10:41:21 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.194.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A2D25D6A8;
        Mon, 16 Aug 2021 10:41:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH regression fix v2] gpiolib: acpi: Make set-debounce-timeout failures non fatal
Date:   Mon, 16 Aug 2021 12:41:19 +0200
Message-Id: <20210816104119.75019-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
made the gpiolib-acpi code call gpio_set_debounce_timeout() when requesting
GPIOs.

This in itself is fine, but it also made gpio_set_debounce_timeout()
errors fatal, causing the requesting of the GPIO to fail. This is causing
regressions. E.g. on a HP ElitePad 1000 G2 various _AEI specified GPIO
ACPI event sources specify a debouncy timeout of 20 ms, but the
pinctrl-baytrail.c only supports certain fixed values, the closest
ones being 12 or 24 ms and pinctrl-baytrail.c responds with -EINVAL
when specified a value which is not one of the fixed values.

This is causing the acpi_request_own_gpiod() call to fail for 3
ACPI event sources on the HP ElitePad 1000 G2, which in turn is causing
e.g. the battery charging vs discharging status to never get updated,
even though a charger has been plugged-in or unplugged.

Make gpio_set_debounce_timeout() errors non fatal, warning about the
failure instead, to fix this regression.

Note we should probably also fix various pinctrl drivers to just
pick the first bigger discrete value rather then returning -EINVAL but
this will need to be done on a per driver basis, where as this fix
at least gets us back to where things were before and thus restores
functionality on devices where this was lost due to
gpio_set_debounce_timeout() errors.

Fixes: 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
Depends-on: 2e2b496cebef ("gpiolib: acpi: Extract acpi_request_own_gpiod() helper")
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Fix typo in commit msg
-Add Mika's Reviewed-by
-Add Depends-on tag
---
 drivers/gpio/gpiolib-acpi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 411525ac4cc4..47712b6903b5 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -313,9 +313,11 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 
 	ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout);
 	if (ret)
-		gpiochip_free_own_desc(desc);
+		dev_warn(chip->parent,
+			 "Failed to set debounce-timeout for pin 0x%04X, err %d\n",
+			 pin, ret);
 
-	return ret ? ERR_PTR(ret) : desc;
+	return desc;
 }
 
 static bool acpi_gpio_in_ignore_list(const char *controller_in, int pin_in)
-- 
2.31.1

