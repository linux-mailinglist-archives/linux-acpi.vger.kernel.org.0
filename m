Return-Path: <linux-acpi+bounces-8140-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7AB96B294
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 09:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0305281ADE
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC106153BF0;
	Wed,  4 Sep 2024 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Gy97Wmbd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6C14831E;
	Wed,  4 Sep 2024 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433993; cv=none; b=kVaJOOMAf238IzOc6fwkq6kjfkMPhLq6G75IIPkZ91YQQ5Laank2MVXkRqd7+FvtFORAN9GQhTtbpJG6DpojLqcbsaHM7JZMKrx/a+guiZ7lBxVkOPz1Gl8ZXhzdmlAxiLwNI5ZtGIkZHljtAr12a7ALOBkUgudHxX0jeTIcLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433993; c=relaxed/simple;
	bh=iidNbhVu9dGaX9vvLnlzhXLhakvIQbqR4E89Zx6qqiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ftP7cz5y/Bmyawv75f6bmF7iPt09+rYMjCMLEBR8K7CYXcZTCDF9+dn4ozGBf2ayw2clGb+QBeKgM+/TrnDy1l9BQJtMYwbUkI1TEJjBzivuLectsxtT5XPECvgN9FxFho33gxGEt/OG9G8niL4B81uxrbwJuzw66rWHShQ37nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Gy97Wmbd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725433984;
	bh=iidNbhVu9dGaX9vvLnlzhXLhakvIQbqR4E89Zx6qqiw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gy97WmbdUGElt/MXyov6S7aJ497tLRKJYxLsMSG933t+uIS/luPBApz4axlyzs5HF
	 jm8f7fbSnvsJqDBxe9lMIdF1fce3qW4UJUBbIUrjHIU6Qa5dQinNtMGMretzM9qNIh
	 9/T7zgjGNtMqXRazSMzmURKJnCK3Le8qqQtkDjqk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Sep 2024 09:12:54 +0200
Subject: [PATCH 3/5] ACPI: battery: initialize mutexes through devm_ APIs
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-acpi-battery-cleanups-v1-3-a3bf74f22d40@weissschuh.net>
References: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
In-Reply-To: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725433984; l=1468;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iidNbhVu9dGaX9vvLnlzhXLhakvIQbqR4E89Zx6qqiw=;
 b=6jatBtz7LB/NNCd63oh4MIxWG+ziT6GhhTJ8cyWPxddrGz4HLd6tEECn4bzLm3FXqYHJoj89Q
 6fKaSg1vDPXA4azW52X1E31H98T9PpjN9G0oZExIyLR2OxYnW4AolKz
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Simplify the cleanup logic a bit.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/battery.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index a778bf6a6c4e..da50ca8df007 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1222,8 +1222,8 @@ static int acpi_battery_add(struct acpi_device *device)
 	strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 	device->driver_data = battery;
-	mutex_init(&battery->lock);
-	mutex_init(&battery->sysfs_lock);
+	devm_mutex_init(&device->dev, &battery->lock);
+	devm_mutex_init(&device->dev, &battery->sysfs_lock);
 	if (acpi_has_method(battery->device->handle, "_BIX"))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 
@@ -1253,8 +1253,6 @@ static int acpi_battery_add(struct acpi_device *device)
 	unregister_pm_notifier(&battery->pm_nb);
 fail:
 	sysfs_remove_battery(battery);
-	mutex_destroy(&battery->lock);
-	mutex_destroy(&battery->sysfs_lock);
 
 	return result;
 }
@@ -1274,9 +1272,6 @@ static void acpi_battery_remove(struct acpi_device *device)
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
 	sysfs_remove_battery(battery);
-
-	mutex_destroy(&battery->lock);
-	mutex_destroy(&battery->sysfs_lock);
 }
 
 #ifdef CONFIG_PM_SLEEP

-- 
2.46.0


