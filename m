Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8931459719
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Nov 2021 23:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbhKVWHi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Nov 2021 17:07:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239811AbhKVWH3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Nov 2021 17:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637618662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w49jLD38zCoiAPB/lUQar9BOasBp1RO2RflvcTlpBzA=;
        b=g/wOrVYF2Bgwkj4wTY65wN5j+RYysGsyX+bTYeeNqYidLOguZXnRQoJlNLaiLwxp1R50bE
        oN2D/lVOgRN4Fl9QAYMHcc9hXcAm5QQlx2zpMXlCAecGviPlTKNDwSMjGRTk7iFA3i0DXq
        6cfynNx6apeTC5WQhEn2XmhmJWQrmGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-sm4snIgdOnmsChTmQayzuw-1; Mon, 22 Nov 2021 17:04:21 -0500
X-MC-Unique: sm4snIgdOnmsChTmQayzuw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BBC110144E0;
        Mon, 22 Nov 2021 22:04:18 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24B3818432;
        Mon, 22 Nov 2021 22:04:16 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] gpiolib: acpi: Do not set the IRQ type if the IRQ is already in use
Date:   Mon, 22 Nov 2021 23:04:16 +0100
Message-Id: <20211122220416.11241-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If the IRQ is already in use, then acpi_dev_gpio_irq_get_by() really
should not change the type underneath the current owner.

I specifically hit an issue with this an a Chuwi Hi8 Super (CWI509) Bay
Trail tablet, when the Boot OS selection in the BIOS is set to Android.
In this case _STA for a MAX17047 ACPI I2C device wrongly returns 0xf and
the _CRS resources for this device include a GpioInt pointing to a GPIO
already in use by an _AEI handler, with a different type then specified
in the _CRS for the MAX17047 device. Leading to the acpi_dev_gpio_irq_get()
call done by the i2c-core-acpi.c code changing the type breaking the
_AEI handler.

Now this clearly is a bug in the DSDT of this tablet (in Android mode),
but in general calling irq_set_irq_type() on an IRQ which already is
in use seems like a bad idea.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 985e8589c58b..24cd86bf2c4c 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1056,8 +1056,12 @@ int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int ind
 			irq_flags = acpi_dev_get_irq_type(info.triggering,
 							  info.polarity);
 
-			/* Set type if specified and different than the current one */
-			if (irq_flags != IRQ_TYPE_NONE &&
+			/*
+			 * If the IRQ is not already in use then set type
+			 * if specified and different than the current one.
+			 */
+			if (can_request_irq(irq, irq_flags) &&
+			    irq_flags != IRQ_TYPE_NONE &&
 			    irq_flags != irq_get_trigger_type(irq))
 				irq_set_irq_type(irq, irq_flags);
 
-- 
2.33.1

