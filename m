Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80E44550FA
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 00:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbhKQXTZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 18:19:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241521AbhKQXTZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Nov 2021 18:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637190985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4L6fYkm3itlF64N4oeIyQNxJtyJbr/iAzdlnWwlNS3w=;
        b=C5s2HC1VN8ceXXzIU4WxAFUlpQpeBp1xhfcAw0K0aM+u9bbsp896D0tFZE11ncLAgHUf4d
        GCugkpZJd6oB6GznCX5FcDwtHKcoSA6847tk643PJAq9A2JtNDjeb9MafpcRksO0aPmU6b
        C1HRK+dsiCsPPJSdSjMzdsMTqGNZeZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-9UyRdRXPM3G1EqI8qLDZvA-1; Wed, 17 Nov 2021 18:16:22 -0500
X-MC-Unique: 9UyRdRXPM3G1EqI8qLDZvA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76F4A100C660;
        Wed, 17 Nov 2021 23:16:21 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05D2B10023B8;
        Wed, 17 Nov 2021 23:16:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 3/3] pinctrl: cherryview: Ignore INT33FF UID 5 ACPI device
Date:   Thu, 18 Nov 2021 00:16:14 +0100
Message-Id: <20211117231614.758362-3-hdegoede@redhat.com>
In-Reply-To: <20211117231614.758362-1-hdegoede@redhat.com>
References: <20211117231614.758362-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Many Cherry Trail DSDTs have an extra INT33FF device with UID 5,
the intel_pinctrl_get_soc_data() call will fail for this extra
unknown UID, leading to the following error in dmesg:

 cherryview-pinctrl: probe of INT33FF:04 failed with error -61

Add a check for this extra UID and return -ENODEV for it to
silence this false-positive error message.

Cc: Yauhen Kharuzhy <jekhor@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 491b234812cd..ca6fe6115ecb 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1686,6 +1686,10 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 	acpi_status status;
 	int i, ret, irq;
 
+	/* Cherry Trail DSDTs have an extra INT33FF device with UID 5, ignore */
+	if (!strcmp(adev->pnp.unique_id, "5"))
+		return -ENODEV;
+
 	soc_data = intel_pinctrl_get_soc_data(pdev);
 	if (IS_ERR(soc_data))
 		return PTR_ERR(soc_data);
-- 
2.31.1

