Return-Path: <linux-acpi+bounces-8139-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E12A96B290
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 09:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D561C2143D
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 07:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEBE1487C0;
	Wed,  4 Sep 2024 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="L7hFAaWN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11C83CA3;
	Wed,  4 Sep 2024 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433991; cv=none; b=VHLKzmDqMFeP1bWG2V/noF5cjpA89fuqq6Mp2JIDzWW3WvvZnv46LQ4kx52XW8EWj6dQr4AlRsvM0OKxkMS8zyi+7/bvC0MyparO2QGMfVj6yyyGtmdr0hJZvsR6dLqdGN4zxs3yc4FOezyM/TJc+/KoP5gQIvqivs0XKhis2L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433991; c=relaxed/simple;
	bh=5k0BoqRQGceC6Q94sFXBaBULbzuT+NUhzfZtoBIIH/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rycYyXrXY5Yg5Odn0XWk21Hds7FQ1+WV7kqtvlF/FOHZUswAeiOccaRTf0mOfgvJ2fpNeKMlIyEILyOL7JuN6pCzfOKNcV1ye7/5wk2olwEOW+Xkv3OPTvYSyoHnX7+ilRuZ9spL9YmFmbCU36snQTCDLuYXklVBpjXfeoHRzds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=L7hFAaWN; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725433984;
	bh=5k0BoqRQGceC6Q94sFXBaBULbzuT+NUhzfZtoBIIH/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L7hFAaWNOCftx0YW4JerPT+NZEiwGafmK+4cuSFdDCuFOOQTv6vdnTVueLzl9kLYs
	 LvccBRa0AvsMf2FYazn0/BEMGfVwWs4E6t+tUCEScHyP1IJvKhk+cT7u37yAd3Vumb
	 oAC/BuQZ338SMcftLAMey/QzDPK+ucjMw+yGzZsg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Sep 2024 09:12:53 +0200
Subject: [PATCH 2/5] ACPI: battery: allocate driver data through devm_ APIs
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-acpi-battery-cleanups-v1-2-a3bf74f22d40@weissschuh.net>
References: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
In-Reply-To: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725433984; l=1138;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5k0BoqRQGceC6Q94sFXBaBULbzuT+NUhzfZtoBIIH/Q=;
 b=3OwIEqPims6Mr504oojSJWG0Mwmqilqur1OrslBquJzPGX//GfM3vsuvu3lNERZOuNPdv2q6Y
 IsXLxqd82wYCs6CLydk1vkk0EeZ/cvTbFoUIb/XSDHNSa6HohQWTx6e
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Simplify the cleanup logic a bit.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/battery.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 677618eb38bf..a778bf6a6c4e 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1215,7 +1215,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (device->dep_unmet)
 		return -EPROBE_DEFER;
 
-	battery = kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
+	battery = devm_kzalloc(&device->dev, sizeof(*battery), GFP_KERNEL);
 	if (!battery)
 		return -ENOMEM;
 	battery->device = device;
@@ -1255,7 +1255,6 @@ static int acpi_battery_add(struct acpi_device *device)
 	sysfs_remove_battery(battery);
 	mutex_destroy(&battery->lock);
 	mutex_destroy(&battery->sysfs_lock);
-	kfree(battery);
 
 	return result;
 }
@@ -1278,7 +1277,6 @@ static void acpi_battery_remove(struct acpi_device *device)
 
 	mutex_destroy(&battery->lock);
 	mutex_destroy(&battery->sysfs_lock);
-	kfree(battery);
 }
 
 #ifdef CONFIG_PM_SLEEP

-- 
2.46.0


