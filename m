Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D991469AE63
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Feb 2023 15:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBQOwz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Feb 2023 09:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjBQOwy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Feb 2023 09:52:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB3E6D7A6
        for <linux-acpi@vger.kernel.org>; Fri, 17 Feb 2023 06:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676645528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qvd/IRzAERBWQ+8laI+7cNKwHqXf3euTDXQ6uVD+r1E=;
        b=L7Q5Rd+F2L4ljZevwXxf/cGA8dD/JyvKkLNLWC1OEV9MzA28hEpRPDucjoqgc2/dXwV2bL
        4ZUin+eBsME3B8bek8nEFKWvqE1OnQm3UPnB2SXeEeyFKgMGp4jmvyldvFnZpVBh0q7KYi
        WzEDFKzwTYmCCwI0HlAD8Sg+FLN0TXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-SVdT_KKMNBulOMrbDjs9jg-1; Fri, 17 Feb 2023 09:52:04 -0500
X-MC-Unique: SVdT_KKMNBulOMrbDjs9jg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2708C100F847;
        Fri, 17 Feb 2023 14:52:04 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C165492B00;
        Fri, 17 Feb 2023 14:52:03 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/3] ACPI: x86: Add skip i2c clients quirk for Acer Iconia One 7 B1-750
Date:   Fri, 17 Feb 2023 15:51:59 +0100
Message-Id: <20230217145200.31821-3-hdegoede@redhat.com>
In-Reply-To: <20230217145200.31821-1-hdegoede@redhat.com>
References: <20230217145200.31821-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

