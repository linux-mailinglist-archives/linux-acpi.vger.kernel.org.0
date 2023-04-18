Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561506E5CA5
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Apr 2023 10:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjDRIzl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Apr 2023 04:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjDRIzk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2023 04:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ED17D91
        for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2023 01:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681808087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=17aqH1+HCJmGSkcNTIqJ1oqIL8eVz7Y1VAmURsLgMAo=;
        b=ge8ZvUl7lhdVv3Uv4V+STMcWEddcHEDjKIqi6VMP4s7dhIBFWj85FrdrVk4my6l2HD0u65
        aTodb2e9gqaekDBgiGWhzw8mt8+rtS3u1yaJ7AIZ/Cc0fd2LRmp68JYw2iERbwIlO7D35h
        PT6BDSWuv5wa3gJpj4mhbjQuVHBkwuQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-nLgouwwPNwauVUfUeX-pjw-1; Tue, 18 Apr 2023 04:54:44 -0400
X-MC-Unique: nLgouwwPNwauVUfUeX-pjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B736A88F4CF;
        Tue, 18 Apr 2023 08:54:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E14F52027044;
        Tue, 18 Apr 2023 08:54:42 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2] ACPI: LPSS: Add 80862289 ACPI _HID for second PWM controller on Cherry Trail
Date:   Tue, 18 Apr 2023 10:54:37 +0200
Message-Id: <20230418085437.4579-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On some Cherry Trail devices the second PWM controller uses
80862289 as ACPI _HID, rather then using 80862288 as is done
for both controllers on most models.

Add the missing 80862289 ACPI _HID, note this uses its own
lpss_device_desc, without ".setup = bsw_pwm_setup" so that
the pwm_lookup is not added for it.
On devices where both controllers use the 80862288 _HID bsw_pwm_setup()
does a UID check to avoid registering the lookup for the second
controller but that will not work here.

Adding the missing id fixes the second PWM controller no longer
working after the entire LPSS1 island has been in D3 at least
once, which causes the contents of the LPSS private registers
to get lost. Adding the _HID makes acpi_lpss restore these
when the controller moves from D3 to D0.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- s/HID/_HID/
- Add Mika's Reviewed-by
---
 drivers/acpi/acpi_lpss.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index f08ffa75f4a7..77186f084d3a 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -271,6 +271,12 @@ static const struct lpss_device_desc bsw_pwm_dev_desc = {
 	.resume_from_noirq = true,
 };
 
+static const struct lpss_device_desc bsw_pwm2_dev_desc = {
+	.flags = LPSS_SAVE_CTX_ONCE | LPSS_NO_D3_DELAY,
+	.prv_offset = 0x800,
+	.resume_from_noirq = true,
+};
+
 static const struct lpss_device_desc byt_uart_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
 	.clk_con_id = "baudclk",
@@ -368,6 +374,7 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	/* Braswell LPSS devices */
 	{ "80862286", LPSS_ADDR(lpss_dma_desc) },
 	{ "80862288", LPSS_ADDR(bsw_pwm_dev_desc) },
+	{ "80862289", LPSS_ADDR(bsw_pwm2_dev_desc) },
 	{ "8086228A", LPSS_ADDR(bsw_uart_dev_desc) },
 	{ "8086228E", LPSS_ADDR(bsw_spi_dev_desc) },
 	{ "808622C0", LPSS_ADDR(lpss_dma_desc) },
-- 
2.39.2

