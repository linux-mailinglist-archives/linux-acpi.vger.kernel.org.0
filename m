Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE3C455981
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 11:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343536AbhKRLAP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 06:00:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343537AbhKRLAJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Nov 2021 06:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637233029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kEXkaqnseiRSxk6sHUeLgYQzWrA/YwA2fFhvHazT8TQ=;
        b=G/hH2It4Tjz6UTvOpTQlF8z1sUuwU7exUCFniLo/F5Ot4SD8zvy4qx625d9QGJjTsImgoH
        pK2ME2sslWkI3raShb8SraoF4VMbu1lZ22MT38iAgreTsPdLZhO188isQRTwsAYo0NEOCv
        105rOY/EBrdg1icm84+9I+zSDhcb1FU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-Xv64LDDlMpmXdzPdpU1USA-1; Thu, 18 Nov 2021 05:57:04 -0500
X-MC-Unique: Xv64LDDlMpmXdzPdpU1USA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 169CA8799EB;
        Thu, 18 Nov 2021 10:57:03 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.195.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 820FB5F4ED;
        Thu, 18 Nov 2021 10:57:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v2 3/3] pinctrl: cherryview: Ignore INT33FF UID 5 ACPI device
Date:   Thu, 18 Nov 2021 11:56:50 +0100
Message-Id: <20211118105650.207638-3-hdegoede@redhat.com>
In-Reply-To: <20211118105650.207638-1-hdegoede@redhat.com>
References: <20211118105650.207638-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Add Mika's Acked-by
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index da68f8a849ab..487e343b68e1 100644
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

