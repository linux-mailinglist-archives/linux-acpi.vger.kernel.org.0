Return-Path: <linux-acpi+bounces-5691-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D61AF8C0E5A
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 12:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C23B1F22D83
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 10:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523A512F592;
	Thu,  9 May 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="spXqQJwz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19B0322E;
	Thu,  9 May 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251541; cv=none; b=OGlYIp3pJffy0s2OMmrjDOK2r3Ii0Bb+LiH5M+FtSWTgiofXNalLhrSAhml0h5a65R0H2IRpciblF/3GXsrsJPt0oSlMP7/U99DvMG4tHqkUvMyfE4SLIWfOCxaRkKqsdCtwu5G+07J96RVZV3UbvM1D9zwUKDVOP2PQapjDU4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251541; c=relaxed/simple;
	bh=H4jv+yatmvGeN/CSJq1fPbVdsYylD8RmnOWtmlUY5/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PRJAd2A7j9Y7BD7jpPBNkvOuFK645yFCG+iMUwIAjnMi2ZAza5MomdL7CYAYfw5rKyDmcjSYt8T0ImbyGGyuN62L741DqpvEatYYyNubsl+NJGh5h1MlLmbYbWfDZVtqaGl6MttY1ivdJltZW2eA8aEs5v51+y5T50ubIgUv8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=spXqQJwz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715251538;
	bh=H4jv+yatmvGeN/CSJq1fPbVdsYylD8RmnOWtmlUY5/0=;
	h=From:To:Cc:Subject:Date:From;
	b=spXqQJwzPgT6PKGfRZ3JPDwsnYZrDTc2M/mgjBPLt9aU10aNYgviYt+22AqKaqmQD
	 F+YAeNAtbQ0AEP0dJXjENg9gTg2fkvwetFU4/EcB5mjR4m6Ia1ges/k8vTlbatKk7o
	 HY9MYC2xMoVrWzgqzVn65qgxuDpHRQuyzk5CDSvyBU7O/uOcyLOk2D9yHrR6dTMnFL
	 DfiZrcrGgcvgUc/MIiyeqYF8IiF8XL87ZoR83RtWKafnr5eid154IGOEZ8pXmydFr3
	 WFEhKdr4H+/PyGf1qBeBljiTpwjXCMcfGSK9N7iwZEedF3Pafz3XBt1RsyXQ+BWdli
	 P6k4I6WjEvV7Q==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6F56B3782172;
	Thu,  9 May 2024 10:45:37 +0000 (UTC)
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
	"kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH] gpiolib: acpi: Add ACPI device NULL check to acpi_can_fallback_to_crs()
Date: Thu,  9 May 2024 12:46:05 +0200
Message-Id: <20240509104605.538274-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check ACPI device for NULL inside acpi_can_fallback_to_crs(), so callers
won't need to.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Closes: https://lore.kernel.org/all/20240426154208.81894-1-laura.nao@collabora.com/
Fixes: 49c02f6e901c ("gpiolib: acpi: Move acpi_can_fallback_to_crs() out of __acpi_find_gpio()")

---
 drivers/gpio/gpiolib-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 553a5f94c00a..688aff6e51bc 100644
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
-- 
2.30.2


