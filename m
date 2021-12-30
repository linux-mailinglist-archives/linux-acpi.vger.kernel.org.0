Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76D7481FF0
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Dec 2021 20:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240569AbhL3Tbd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Dec 2021 14:31:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240383AbhL3Tbc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Dec 2021 14:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640892691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cEYCOHUzO+sUqG1vdX8JI0pE9axR3wqTigOYYhbt83U=;
        b=Vr2jMVUEBbKsm4a7RsNwu6a4QHpAo/V9O7PdCkiA/Gz2SalRdB0iy+5+VQt+DuJl4lSwqM
        UXExKUDL0skRqLza0olM339REWKZALcWN6mmlKvbaGq/P5E+4FB4ompTrAi+ykioBaRc43
        My9/Tsrs5JPE+U3PUcAs17S81vr1dRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-KpwR73MJNZSyt3B6C1V-6Q-1; Thu, 30 Dec 2021 14:31:28 -0500
X-MC-Unique: KpwR73MJNZSyt3B6C1V-6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62FEB8042E1;
        Thu, 30 Dec 2021 19:31:27 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAD4D5F707;
        Thu, 30 Dec 2021 19:31:25 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/2] ACPI / x86: Skip ac and battery devices on x86 Android tablets with broken DSDTs
Date:   Thu, 30 Dec 2021 20:31:20 +0100
Message-Id: <20211230193120.589337-3-hdegoede@redhat.com>
In-Reply-To: <20211230193120.589337-1-hdegoede@redhat.com>
References: <20211230193120.589337-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sofar all of the tablets for which the skip i2c-client/serdev enumeration
quirks have been added also all have broken ACPI ac / battery devices
extend the existing quirks for these tablets to also skip the broken
ac / battery devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 5411f2f1254e..ffdeed5334d6 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -273,14 +273,16 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ME176C"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
-					ACPI_QUIRK_UART1_TTY_UART2_SKIP),
+					ACPI_QUIRK_UART1_TTY_UART2_SKIP |
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "TF103C"),
 		},
-		.driver_data = (void *)ACPI_QUIRK_SKIP_I2C_CLIENTS,
+		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
 	},
 	{
 		/* Whitelabel (sold as various brands) TM800A550L */
@@ -290,7 +292,8 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 			/* Above strings are too generic, also match on BIOS version */
 			DMI_MATCH(DMI_BIOS_VERSION, "ZY-8-BI-PX4S70VTR400-X423B-005-D"),
 		},
-		.driver_data = (void *)ACPI_QUIRK_SKIP_I2C_CLIENTS,
+		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
 	},
 #endif
 	{}
-- 
2.33.1

