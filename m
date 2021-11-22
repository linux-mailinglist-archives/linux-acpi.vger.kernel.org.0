Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1258E45939D
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Nov 2021 18:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbhKVRIu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Nov 2021 12:08:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231714AbhKVRIu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Nov 2021 12:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637600743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2ukrTxTbV3vcB1W1+ia1P+/e64NdyX9idMx1Os0IgA=;
        b=ISGEr4dctOP3yYPm10q4wIvAilMFD11FM1OG/tUr75n/HlF3biSfWac3lcjNSsSZf9/o8s
        mOFM66LqMAvLVGu/VizYKa3MTREhq+1I+9p2ZAvAqvLAP7bVlhLAWsr4PKleAIPaS9GJr/
        /3qcP0e37ZsBFrlsd6axQJAYfjhKshk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-otUqlhM0POK-pNjeTS7m_g-1; Mon, 22 Nov 2021 12:05:41 -0500
X-MC-Unique: otUqlhM0POK-pNjeTS7m_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E14387D548;
        Mon, 22 Nov 2021 17:05:40 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7F835D6D5;
        Mon, 22 Nov 2021 17:05:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v2 1/7] ACPI / x86: Drop PWM2 device on Lenovo Yoga Book from always present table
Date:   Mon, 22 Nov 2021 18:05:30 +0100
Message-Id: <20211122170536.7725-2-hdegoede@redhat.com>
In-Reply-To: <20211122170536.7725-1-hdegoede@redhat.com>
References: <20211122170536.7725-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It turns out that there is a WMI object which controls the PWM2 device
used for the keyboard backlight and that WMI object also provides some
other useful functionality.

The upcoming lenovo-yogabook-wmi driver will offer both backlight
control and the other functionality, so there no longer is a need
to have the lpss-pwm driver binding to PWM2 for backlight control;
and this is now actually undesirable because this will cause both
the WMI code and the lpss-pwm driver to poke at the same PWM
controller.

Drop the always-present quirk for the PWM2 ACPI-device, so that the
 lpss-pwm controller will no longer bind to it.

Cc: Yauhen Kharuzhy <jekhor@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Change the wording so that this is not seen as something to
  backport to the stable-series (note backporting won't cause
  issues but it is not really necessary)
---
 drivers/acpi/x86/utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index f22f23933063..3bcac98f6eca 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -54,10 +54,6 @@ static const struct always_present_id always_present_ids[] = {
 	ENTRY("80860F09", "1", X86_MATCH(ATOM_SILVERMONT), {}),
 	ENTRY("80862288", "1", X86_MATCH(ATOM_AIRMONT), {}),
 
-	/* Lenovo Yoga Book uses PWM2 for keyboard backlight control */
-	ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
-			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
-		}),
 	/*
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
 	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
-- 
2.33.1

