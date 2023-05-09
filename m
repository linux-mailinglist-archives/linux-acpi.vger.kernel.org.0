Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533656FC56E
	for <lists+linux-acpi@lfdr.de>; Tue,  9 May 2023 13:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjEILx2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 May 2023 07:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbjEILxY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 May 2023 07:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5560E35A7
        for <linux-acpi@vger.kernel.org>; Tue,  9 May 2023 04:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683633152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=od9tEIXoSxx1AeYS05aKY5nQvu2WgONDHutn+REaWws=;
        b=Av+ZF0ikB7OJJsoJcoCEtgvFbxKCY1Md8vZQagR3Hw5l+WPW2MKkHu77uDEyVxn31B/7m/
        7G1DALbrLH2omwgV5aQEamnBZmgvuhsPSs61M8AtnefBnqnMbNKfCIDczIr0pKd8Jrs5rJ
        JESVUzBzRjR8UGnC12D1f2cON61MHgA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-yc3RDGNCMFiy_HmZNZmBnA-1; Tue, 09 May 2023 07:52:28 -0400
X-MC-Unique: yc3RDGNCMFiy_HmZNZmBnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E0331C08793;
        Tue,  9 May 2023 11:52:28 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92D5A14171BC;
        Tue,  9 May 2023 11:52:27 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] ACPI: LPSS: Add pwm_lookup_table entry for second PWM on CHT/BSW devices
Date:   Tue,  9 May 2023 13:52:26 +0200
Message-Id: <20230509115226.287318-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

BSW PWM2 is used for backlight control for fixed (etched into the glass)
touch controls on some models.

Add an entry for the second PWM controller to bsw_pwm_lookup,
so that drivers can use pwm_get() to get a referene to it.

These touch-controls have specialized drivers which bind to different
devices on different models, so the consumer-device-name in the lookup
table entry is set to NULL, so that only con-id matching is used.

The con-id is set to "pwm_soc_lpss_2" which describes the PWM controller
rather then the usual approach of describing its function.
The specialized (model specific) drivers which need access to the PWM
controller know they need the "pwm_soc_lpss_2" con-id.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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

