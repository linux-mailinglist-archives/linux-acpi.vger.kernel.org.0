Return-Path: <linux-acpi+bounces-6388-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF369907D3C
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 22:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95879286223
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 20:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC1113A275;
	Thu, 13 Jun 2024 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qVIo4kfU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC612F37B;
	Thu, 13 Jun 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309737; cv=none; b=U6Qns5ywqYFbWxr2B3cpzqFaiNZmOqdHfmM3pIvFWKgRUcFO8RJOlvunYoiIukPIJBnwUf6ofeot0R44Th4YGZJc777kw4fjoe4ErmqVU5te3BIgKCg2wWKOR1kqHOcoebUU+Qg0Gxri3UCHbiOj/k0p5zPRYE655qno2Sfr8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309737; c=relaxed/simple;
	bh=V+7rNBrVBMiquqsDaHIG89BLDRn+4swfipLg+5xOqn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBhU4TwSc1w8wb6e35vcsTcvpiE6vuvjDWh6DgDZRZppqXFZ+qv4S+IWRj5P2FjUcxLfwPrDdsneINIJrmvijE9IVIR3KL3dzR4iBgUbEdsrvTT9IHmXg7HHGADVe2OkWN2JA+BBu3DiPl1VqiW1P1+FBFWJp5LmrTp3jyiGLos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qVIo4kfU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718309732;
	bh=V+7rNBrVBMiquqsDaHIG89BLDRn+4swfipLg+5xOqn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qVIo4kfU0Fsy9ywTFamSR9/eOzVb2gWHpVzthTCpEi1ZYrL6EhJ1Mb1degz7Iyp3U
	 cxSOxuAajCGTGoZ8Uwdtr57WjNn8uSXDF7EfThlkBuPywMqFp1l7/y00gMtdQP9oo4
	 0WWe84rX6FM56FK0Sfazv11vbqgklylm40zOJM60=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 13 Jun 2024 22:15:33 +0200
Subject: [PATCH 2/5] ACPI: sysfs: use device lifecycle for _STR result
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240613-acpi-sysfs-groups-v1-2-665e0deb052a@weissschuh.net>
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
In-Reply-To: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718309732; l=1932;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=V+7rNBrVBMiquqsDaHIG89BLDRn+4swfipLg+5xOqn0=;
 b=1FnIhB0nONyobBwXP9cfdPRxo46K7f9X4+4wRu9l3XogLAy9UzjQdGbX4CcS052uoU+rzXphK
 JU2Wf0F3gjSCfLsCKAWwGDc/a2qTC64v6VsRoIjKqDAiE5iyw24asNf
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The string assigned to dev->pnp.str effectively shares the lifetime of
the device. Use devm_-APIs to avoid a manual cleanup path.

This will be useful when the attributes themselves will be managed by
the device core.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/device_sysfs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 4bedbe8f57ed..d0ca159d93e1 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -494,7 +494,7 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(status);
 
-static const char *acpi_device_str(struct acpi_device *dev)
+static const char *devm_acpi_device_str(struct acpi_device *dev)
 {
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *str_obj;
@@ -522,7 +522,7 @@ static const char *acpi_device_str(struct acpi_device *dev)
 				 buf, sizeof(buf) - 1);
 	buf[result++] = '\0';
 
-	ret = kstrdup(buf, GFP_KERNEL);
+	ret = devm_kstrdup(&dev->dev, buf, GFP_KERNEL);
 	kfree(buffer.pointer);
 
 	return ret;
@@ -558,7 +558,7 @@ int acpi_device_setup_files(struct acpi_device *dev)
 	/*
 	 * If device has _STR, 'description' file is created
 	 */
-	dev->pnp.str = acpi_device_str(dev);
+	dev->pnp.str = devm_acpi_device_str(dev);
 	if (dev->pnp.str) {
 		result = device_create_file(&dev->dev, &dev_attr_description);
 		if (result)
@@ -632,10 +632,8 @@ void acpi_device_remove_files(struct acpi_device *dev)
 	/*
 	 * If device has _STR, remove 'description' file
 	 */
-	if (acpi_has_method(dev->handle, "_STR")) {
-		kfree(dev->pnp.str);
+	if (acpi_has_method(dev->handle, "_STR"))
 		device_remove_file(&dev->dev, &dev_attr_description);
-	}
 	/*
 	 * If device has _EJ0, remove 'eject' file.
 	 */

-- 
2.45.2


