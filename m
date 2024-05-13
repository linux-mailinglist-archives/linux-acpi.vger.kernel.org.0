Return-Path: <linux-acpi+bounces-5789-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 068068C3E6B
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 11:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5991F2234F
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 09:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCBD148854;
	Mon, 13 May 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="32l4m8S2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C12219E7;
	Mon, 13 May 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594142; cv=none; b=dJlT2mWjqi9IODM4yHqua5SQmbsZpWHOuT6uGWpauLv2u0YEcn14Mes04xdpAcarpxTLORVT8oo94hWCXjOFtnoCrPYcHuQe1OWXTl0YZYmn8rFjpl2n798O8mOWens2fJiEB5vmjdH0i5y8RNRdk8vcUjf5UQRd+VGWFtJMSuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594142; c=relaxed/simple;
	bh=AzFRCKPlN54IHQkn4IQjKlX2R9+TZTCVcPTOOYJgaeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ULnx42Q6Y0uOqo7Rg5/g/9EozWao7G9+Fz0xCJhS/0XZa7NNN1DAyYR4VCRPhEjl7Geuzj+irDVJQysQP7MiJSMy/eUCKe0JMOqP3o0YJtsXl80aT00lxzaqqYGClj9M8qm0v+CNcXNo9hMfaUSbZ1UzajZKaTjrttI6Jbx0/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=32l4m8S2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715594139;
	bh=AzFRCKPlN54IHQkn4IQjKlX2R9+TZTCVcPTOOYJgaeE=;
	h=From:To:Cc:Subject:Date:From;
	b=32l4m8S2naThXhPAWN6EXlSnoZ9zxuJOnqXFvJOcuUVH6He74yNjdFfVLx0Pn22tw
	 oZizhqojp9tqc7sXSdqYJPElxkyXz0xR/l9OveTN+uyK6YCW1wqitul+XibhXrGDFp
	 i+CrX1zaeblnSzMleXzhYT1zBZv/QtqVZbp9J3eKWvj+4i8sJpdbOhUcMdSNFj9NeQ
	 V65lZfYlEOy196vCV1e0jA+7q0gtvuku0qbcE/nahArFN5WfakJc9KZAIm1u637nnh
	 dVNVZZtz4gAUxkgOnZMeB6c4e5gN44GPu0tNYL6xQnLgtv/u7+raPKLWFae//rS7fE
	 JwsHKcu5aHTjQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1F2F3378212F;
	Mon, 13 May 2024 09:55:38 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Laura Nao <laura.nao@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH] gpiolib: acpi: Move ACPI device NULL check to acpi_can_fallback_to_crs()
Date: Mon, 13 May 2024 11:56:10 +0200
Message-Id: <20240513095610.216668-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the relocation of the function call outside of
__acpi_find_gpio(), move the ACPI device NULL check to
acpi_can_fallback_to_crs().

Signed-off-by: Laura Nao <laura.nao@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Closes: https://lore.kernel.org/all/20240426154208.81894-1-laura.nao@collabora.com/
Fixes: 49c02f6e901c ("gpiolib: acpi: Move acpi_can_fallback_to_crs() out of __acpi_find_gpio()")
---
v1: https://lore.kernel.org/all/20240509104605.538274-1-laura.nao@collabora.com/T/#u
---
 drivers/gpio/gpiolib-acpi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 553a5f94c00a..c7483cd800ee 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -939,7 +939,7 @@ static bool acpi_can_fallback_to_crs(struct acpi_device *adev,
 				     const char *con_id)
 {
 	/* Never allow fallback if the device has properties */
-	if (acpi_dev_has_props(adev) || adev->driver_gpios)
+	if (!adev || acpi_dev_has_props(adev) || adev->driver_gpios)
 		return false;
 
 	return con_id == NULL;
@@ -978,10 +978,10 @@ __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int
 	}
 
 	/* Then from plain _CRS GPIOs */
-	if (!adev || !can_fallback)
-		return ERR_PTR(-ENOENT);
+	if (can_fallback)
+		return acpi_get_gpiod_by_index(adev, NULL, idx, info);
 
-	return acpi_get_gpiod_by_index(adev, NULL, idx, info);
+	return ERR_PTR(-ENOENT);
 }
 
 struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
-- 
2.30.2


