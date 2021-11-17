Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31244550F6
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 00:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbhKQXTW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 18:19:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233853AbhKQXTV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Nov 2021 18:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637190982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H1hRnJjfJYX6TbUmpyiufvx6VLTDYF5oxuthPIfdRZE=;
        b=e7gMwUAEjFfqVbfbQqUVwcSujPuXpCsjlRLJfvQmn1Qrf2kK9zDEW9tA6Sa/PuTm4x/iBW
        d+0Y2EbJFlm6JvMRG7iOY6t4Fvqz/l0vk4qLsCHJOCITZoaAUt3lgdgmhOoU/mPyBA0ebB
        yuku+gLAX6wW1nBt1g4bmQjTQhDtTkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-LO-7zDWdNJqDawIPCCwM4A-1; Wed, 17 Nov 2021 18:16:18 -0500
X-MC-Unique: LO-7zDWdNJqDawIPCCwM4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BF5D1023F4E;
        Wed, 17 Nov 2021 23:16:17 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E6671017CE4;
        Wed, 17 Nov 2021 23:16:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 1/3] pinctrl: cherryview: Don't use pin/offset 0 to mark an interrupt-line as unused
Date:   Thu, 18 Nov 2021 00:16:12 +0100
Message-Id: <20211117231614.758362-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

offset/pin 0 is a perfectly valid offset, so stop using it to have
the special meaning of interrupt-line not used in the intr_lines.

Instead introduce a new special INTR_LINE_UNUSED value which is never
a valid offset and use that to indicate unused interrupt-lines.

Cc: Yauhen Kharuzhy <jekhor@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 980099028cf8..a46f9e5a4748 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -73,6 +73,8 @@ struct intel_pad_context {
 	u32 padctrl1;
 };
 
+#define INTR_LINE_UNUSED		U32_MAX
+
 /**
  * struct intel_community_context - community context for Cherryview
  * @intr_lines: Mapping between 16 HW interrupt wires and GPIO offset (in GPIO number space)
@@ -812,7 +814,7 @@ static int chv_gpio_request_enable(struct pinctrl_dev *pctldev,
 		/* Reset the interrupt mapping */
 		for (i = 0; i < ARRAY_SIZE(cctx->intr_lines); i++) {
 			if (cctx->intr_lines[i] == offset) {
-				cctx->intr_lines[i] = 0;
+				cctx->intr_lines[i] = INTR_LINE_UNUSED;
 				break;
 			}
 		}
@@ -1319,7 +1321,7 @@ static unsigned chv_gpio_irq_startup(struct irq_data *d)
 		else
 			handler = handle_edge_irq;
 
-		if (!cctx->intr_lines[intsel]) {
+		if (cctx->intr_lines[intsel] == INTR_LINE_UNUSED) {
 			irq_set_handler_locked(d, handler);
 			cctx->intr_lines[intsel] = pin;
 		}
@@ -1412,6 +1414,12 @@ static void chv_gpio_irq_handler(struct irq_desc *desc)
 		unsigned int offset;
 
 		offset = cctx->intr_lines[intr_line];
+		if (offset == INTR_LINE_UNUSED) {
+			dev_err(pctrl->dev, "Interrupt on unused interrupt line %u\n",
+				intr_line);
+			continue;
+		}
+
 		generic_handle_domain_irq(gc->irq.domain, offset);
 	}
 
@@ -1620,9 +1628,10 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 	struct intel_community *community;
 	struct device *dev = &pdev->dev;
 	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct intel_community_context *cctx;
 	struct intel_pinctrl *pctrl;
 	acpi_status status;
-	int ret, irq;
+	int i, ret, irq;
 
 	soc_data = intel_pinctrl_get_soc_data(pdev);
 	if (IS_ERR(soc_data))
@@ -1663,6 +1672,10 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 	if (!pctrl->context.communities)
 		return -ENOMEM;
 
+	cctx = &pctrl->context.communities[0];
+	for (i = 0; i < ARRAY_SIZE(cctx->intr_lines); i++)
+		cctx->intr_lines[i] = INTR_LINE_UNUSED;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
-- 
2.31.1

