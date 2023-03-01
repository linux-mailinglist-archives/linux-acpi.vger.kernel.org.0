Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9484F6A6A64
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Mar 2023 11:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCAKFb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Mar 2023 05:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjCAKFa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2023 05:05:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233672ED64
        for <linux-acpi@vger.kernel.org>; Wed,  1 Mar 2023 02:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677665091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qvd/IRzAERBWQ+8laI+7cNKwHqXf3euTDXQ6uVD+r1E=;
        b=VcUOkqbQU6WpHi7sxXTY5BkabyQIqmVgfp1xVm5MO7JFaxtn8f7vCsxRzaze1ZcSE6HoDp
        Pc1eXhjs4B7HverKMfvLID/Zvf1FzShrG768VwMSHiMf78nrrtzMpTDRQxaeVa3RyzU0r1
        RXg+ooBveFT04R6oTu7p8bOagtQ0VZk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-OE3yC1oAObqfZbTOaTtp9g-1; Wed, 01 Mar 2023 05:04:48 -0500
X-MC-Unique: OE3yC1oAObqfZbTOaTtp9g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A39643C0DDB8;
        Wed,  1 Mar 2023 10:04:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA896C15BAD;
        Wed,  1 Mar 2023 10:04:46 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/3] ACPI: x86: Add skip i2c clients quirk for Acer Iconia One 7 B1-750
Date:   Wed,  1 Mar 2023 11:04:35 +0100
Message-Id: <20230301100436.132521-3-hdegoede@redhat.com>
In-Reply-To: <20230301100436.132521-1-hdegoede@redhat.com>
References: <20230301100436.132521-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Acer Iconia One 7 B1-750 is a x86 tablet which ships with Android x86
as factory OS. The Android x86 kernel fork ignores I2C devices described
in the DSDT, except for the PMIC and Audio codecs.

As usual the Acer Iconia One 7 B1-750's DSDT contains a bunch of extra I2C
devices which are not actually there, causing various resource conflicts.
Add an ACPI_QUIRK_SKIP_I2C_CLIENTS quirk for the Acer Iconia One 7 B1-750
to the acpi_quirk_skip_dmi_ids table to woraround this.

The DSDT also contains broken ACPI GPIO event handlers, disable those too.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 4a6f3a6726d0..644e2a7f4213 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -291,6 +291,16 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 	 *    need the x86-android-tablets module to properly work.
 	 */
 #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
+	{
+		/* Acer Iconia One 7 B1-750 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VESPA2"),
+		},
+		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
+					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-- 
2.39.1

