Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771A245971B
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Nov 2021 23:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbhKVWHp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Nov 2021 17:07:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239829AbhKVWHi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Nov 2021 17:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637618670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=R0Wu/W/Wi5O+Hzu3YzLggiwAid8zZBDC6HkiLP7qREY=;
        b=H8X056qefWvvqalAvDAyArK1EWcPrtxW3QRmCPHMsvM3Jfkge96BXjvxBcJRJkEojci+D2
        BOgfmooAUelTwnvrKhyQ+4BVlkLjMbwWsKZa8CRlaKYetymLD3QVVMlq5xVA7nJkiigJzb
        5EbC3JPZuOe9AQwxcLr+R39Ews3xw+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-kKbqZmKsMSaLpCKi-qGp7g-1; Mon, 22 Nov 2021 17:04:27 -0500
X-MC-Unique: kKbqZmKsMSaLpCKi-qGp7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 159CC19251A0;
        Mon, 22 Nov 2021 22:04:26 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C32C07945B;
        Mon, 22 Nov 2021 22:04:24 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] pinctrl: baytrail: Set IRQCHIP_SET_TYPE_MASKED flag on the irqchip
Date:   Mon, 22 Nov 2021 23:04:23 +0100
Message-Id: <20211122220423.11256-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The byt_irq_type function ends with the IRQ masked, this means that calls
to irq_set_irq_type() while the IRQ is enabled end up masking it, which
is wrong. Add the IRQCHIP_SET_TYPE_MASKED flag to fix this.

This will make the IRQ core call mask() + unmask() on the IRQ around
a set_type() call when the IRQ is enabled at the type of the call.

Note in practice irq_set_irq_type() getting called while the IRQ is enabled
almost never happens. I hit this with a buggy DSDT where a wrongly active
(_STA returns 0xf) I2C ACPI devices point to an IRQ already in use by an
_AEI handler, leading to the irq_set_irq_type() call in
acpi_dev_gpio_irq_get_by() getting called while the IRQ is enabled.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 744ebe417bff..e3dd105e2f6e 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -1554,7 +1554,8 @@ static int byt_gpio_probe(struct intel_pinctrl *vg)
 		vg->irqchip.irq_mask = byt_irq_mask,
 		vg->irqchip.irq_unmask = byt_irq_unmask,
 		vg->irqchip.irq_set_type = byt_irq_type,
-		vg->irqchip.flags = IRQCHIP_SKIP_SET_WAKE,
+		vg->irqchip.flags = IRQCHIP_SKIP_SET_WAKE |
+				    IRQCHIP_SET_TYPE_MASKED,
 
 		girq = &gc->irq;
 		girq->chip = &vg->irqchip;
-- 
2.33.1

