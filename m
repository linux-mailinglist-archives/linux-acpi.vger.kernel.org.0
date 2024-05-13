Return-Path: <linux-acpi+bounces-5785-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2858C3CD3
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 10:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C961F21AEF
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 08:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5FB146D51;
	Mon, 13 May 2024 08:04:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE977E777;
	Mon, 13 May 2024 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587442; cv=none; b=aiZy4gOd4ywOKHEce4DBqivO/2K3q64wirBnm5AzKjNB2n3mbPJ1XeGf2nMyhxdD6+KThxKAxw1TRuo+HQY6qklYQfLnKfAXlrt9+f2ybz1SHdcT/m5V36JQQnN0n4D2pd2lHlkEk6ew6gALf2acpUoCCBUwuLDGxkQVnBiClOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587442; c=relaxed/simple;
	bh=fN65sI7/R50fanyXFbOo8aZsXNpfT1Dm6SRRmg2Km1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kfwwuhkCVNFLNoftdQymrdkChWKWYfxD1ebycoPAQN3tOXjCftQq39qPZdd/yiEHxnvvPXfzD+e39uVnTaixI4qlV7LGC+qis/JmmFZHNIcVY5kFSf3iFuDuv2I0KI2bb0IK1dvCyDMiR9E8ik3K7+5152Xe2rhsNzrDF62Z5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VdBk25BW5z1RJHb;
	Mon, 13 May 2024 16:00:26 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (unknown [7.193.23.29])
	by mail.maildlp.com (Postfix) with ESMTPS id EA83E14011B;
	Mon, 13 May 2024 16:03:47 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 16:03:47 +0800
From: Devyn Liu <liudingyuan@huawei.com>
To: <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <f.fangjian@huawei.com>, <linux-gpio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mika.westerberg@linux.intel.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-acpi@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
	<yisen.zhuang@huawei.com>, <kong.kongxinwei@hisilicon.com>,
	<liudingyuan@huawei.com>
Subject: [PATCH] gpiolib: acpi: Fix failed in acpi_gpiochip_find() by adding parent node match
Date: Mon, 13 May 2024 15:59:01 +0800
Message-ID: <20240513075901.2030293-1-liudingyuan@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600002.china.huawei.com (7.193.23.29)

Previous patch modified the standard used by acpi_gpiochip_find()
to match device nodes. Using the device node set in gc->gpiodev->d-
ev instead of gc->parent.

However, there is a situation in gpio-dwapb where the GPIO device
driver will set gc->fwnode for each port corresponding to a child
node under a GPIO device, so gc->gpiodev->dev will be assigned the
value of each child node in gpiochip_add_data().

gpio-dwapb.c:
128,31 static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
			       struct dwapb_port_property *pp,
			       unsigned int offs);
port->gc.fwnode = pp->fwnode;

693,39 static int dwapb_gpio_probe;
err = dwapb_gpio_add_port(gpio, &pdata->properties[i], i);

When other drivers request GPIO pin resources through the GPIO device
node provided by ACPI (corresponding to the parent node), the change
of the matching object to gc->gpiodev->dev in acpi_gpiochip_find()
only allows finding the value of each port (child node), resulting
in a failed request.

Reapply the condition of using gc->parent for match in acpi_gpio-
chip_find() in the code can compatible with the problem of gpio-dwapb,
and will not affect the two cases mentioned in the patch:
1. There is no setting for gc->fwnode.
2. The case that depends on using gc->fwnode for match.

Fixes: 5062e4c14b75 ("gpiolib: acpi: use the fwnode in acpi_gpiochip_find()")
Fixes: 067dbc1ea5ce ("gpiolib: acpi: Don't use GPIO chip fwnode in acpi_gpiochip_find()")
Signed-off-by: Devyn Liu <liudingyuan@huawei.com>
---
 drivers/gpio/gpiolib-acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 7f140df40f35..6078fea3e021 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -128,7 +128,8 @@ static bool acpi_gpio_deferred_req_irqs_done;
 
 static int acpi_gpiochip_find(struct gpio_chip *gc, const void *data)
 {
-	return device_match_acpi_handle(&gc->gpiodev->dev, data);
+	return device_match_acpi_handle(&gc->gpiodev->dev, data) ||
+		(gc->parent && device_match_acpi_handle(gc->parent, data));
 }
 
 /**
-- 
2.30.0


