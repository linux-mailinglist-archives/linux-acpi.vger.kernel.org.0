Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6071F6FC6A1
	for <lists+linux-acpi@lfdr.de>; Tue,  9 May 2023 14:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjEIMl6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 May 2023 08:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbjEIMlw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 May 2023 08:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF075469A
        for <linux-acpi@vger.kernel.org>; Tue,  9 May 2023 05:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683636066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=prSuF/n0nTP4tVpfw0zJu4M+wYcRmV3FnA5TUKxAW+8=;
        b=QqBbxb0EuUSH8G0lPKYVL4Ac9xf6ybkU6li0SqpLi/EPw846M8VIfGtUzkkISqiHjvo7j2
        yUKi2C5vpa5/5i27ZjZaEPRhKfbQONEDkOVnu54t+9XBIGLSo7curi2MgRYqAeVjvzp4dv
        UDD22XmLliAb5oHo6m80uAsNvGtEuLU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-iAu6zzJ-PXqd4oZ46V5HQA-1; Tue, 09 May 2023 08:41:02 -0400
X-MC-Unique: iAu6zzJ-PXqd4oZ46V5HQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21004100F653;
        Tue,  9 May 2023 12:41:02 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21BD440C6E67;
        Tue,  9 May 2023 12:41:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] ACPI: LPSS: Add pwm_lookup_table entry for second PWM on CHT/BSW devices
Date:   Tue,  9 May 2023 14:41:00 +0200
Message-Id: <20230509124100.288814-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

BSW PWM2 is used for backlight control for fixed (etched into the glass)
touch controls on some models.

Add an entry for the second PWM controller to bsw_pwm_lookup,
so that drivers can use pwm_get() to get a reference to it.

These touch-controls have specialized drivers which bind to different
devices on different models, so the consumer-device-name in the lookup
table entry is set to NULL, so that only con-id matching is used.

The con-id is set to "pwm_soc_lpss_2" which describes the PWM controller
rather than the usual approach of describing its function.
The specialized (model specific) drivers which need access to the PWM
controller know they need the "pwm_soc_lpss_2" con-id.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- 2 spelling fixes in commit msg (Andy)
- Add Andy's Reviewed-by + Uwe's Acked-by
---
 drivers/acpi/acpi_lpss.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 77186f084d3a..539e700de4d2 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -201,11 +201,19 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
 	writel(0, pdata->mmio_base + LPSS_I2C_ENABLE);
 }
 
-/* BSW PWM used for backlight control by the i915 driver */
+/*
+ * BSW PWM1 is used for backlight control by the i915 driver
+ * BSW PWM2 is used for backlight control for fixed (etched into the glass)
+ * touch controls on some models. These touch-controls have specialized
+ * drivers which know they need the "pwm_soc_lpss_2" con-id.
+ */
 static struct pwm_lookup bsw_pwm_lookup[] = {
 	PWM_LOOKUP_WITH_MODULE("80862288:00", 0, "0000:00:02.0",
 			       "pwm_soc_backlight", 0, PWM_POLARITY_NORMAL,
 			       "pwm-lpss-platform"),
+	PWM_LOOKUP_WITH_MODULE("80862289:00", 0, NULL,
+			       "pwm_soc_lpss_2", 0, PWM_POLARITY_NORMAL,
+			       "pwm-lpss-platform"),
 };
 
 static void bsw_pwm_setup(struct lpss_private_data *pdata)
-- 
2.40.1

