Return-Path: <linux-acpi+bounces-8136-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED4D96B28A
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 09:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7DD2837D9
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 07:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215901474A7;
	Wed,  4 Sep 2024 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IScRhpdU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1BB146A7B;
	Wed,  4 Sep 2024 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433991; cv=none; b=rjZGnxJdTFnBCHF6mRZVlHYuI8OjyYxJ9TD006gI16m7OVmL9goRBazrF1RmhC2kTYcXycs27Lp+YU4p5mzTV8zFYfVJSBvlP0cd+Fxfk7czYDsvdueftO/sXLJ/JAb1EPfp3lqckjwLmiiChAl8Frr+WIdqVQOteXLpyf/RbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433991; c=relaxed/simple;
	bh=wQXxSCmkiFU6W3wml5qaESF/PpuUQynjgR0MHH9BQqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I8gRv8M1EWEGu6x8pHlcHPv7Pm4OIEZ1DXLmMg5coEIHl/CdxdZRDaFCSGE+vHZNgp0BcQ6gqGfwuSTJiAM+ZIPg8DjkLadswPhroIwQrhBG7K9oGKMzaq7CTEiMWobHun7CXij/tcAmUmOnHK5pC2Hx5MkO2g1SwJG1vPy4+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IScRhpdU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725433985;
	bh=wQXxSCmkiFU6W3wml5qaESF/PpuUQynjgR0MHH9BQqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IScRhpdUMdSYuhxrFcDgc31tTLS/2hCqPdKV8GDggsreCqLen1I27dxau8mahB8pw
	 u5YQaD583WgH8314m/ol/M22r6gCEM4oIURMsZ+jhc4mZWq/2eCjWaDAiNpTxdumjI
	 ZeKhF2n1PI9AECiIB/RvTv61LVM+iQf265OJjRRI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Sep 2024 09:12:56 +0200
Subject: [PATCH 5/5] ACPI: battery: install notify handler through ACPI
 core
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-acpi-battery-cleanups-v1-5-a3bf74f22d40@weissschuh.net>
References: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
In-Reply-To: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725433984; l=1982;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wQXxSCmkiFU6W3wml5qaESF/PpuUQynjgR0MHH9BQqs=;
 b=Gu1oTyUw6dW6jhbdERyp4pMp6ClyLdmCg7yYgA6t/OFkhX+YKdypTcRa80nnz0FhcN1L7mmT6
 7DEmGnqbdgKAhsn0UaVD3dZWMYz5UGW7ql0bfhaZxrJMJuXKZsahdbs
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The ACPI core can register the notify handler on its own,
simplifying error handling and cleanup.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/battery.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 4bd746f8c0ac..88899c417f15 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1060,9 +1060,8 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
 }
 
 /* Driver Interface */
-static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_battery_notify(struct acpi_device *device, u32 event)
 {
-	struct acpi_device *device = data;
 	struct acpi_battery *battery = acpi_driver_data(device);
 	struct power_supply *old;
 
@@ -1241,16 +1240,8 @@ static int acpi_battery_add(struct acpi_device *device)
 
 	device_init_wakeup(&device->dev, 1);
 
-	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
-						 acpi_battery_notify, device);
-	if (result)
-		goto fail_pm;
-
 	return 0;
 
-fail_pm:
-	device_init_wakeup(&device->dev, 0);
-	unregister_pm_notifier(&battery->pm_nb);
 fail:
 	sysfs_remove_battery(battery);
 
@@ -1266,9 +1257,6 @@ static void acpi_battery_remove(struct acpi_device *device)
 
 	battery = acpi_driver_data(device);
 
-	acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
-				       acpi_battery_notify);
-
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
 	sysfs_remove_battery(battery);
@@ -1297,9 +1285,11 @@ static struct acpi_driver acpi_battery_driver = {
 	.name = "battery",
 	.class = ACPI_BATTERY_CLASS,
 	.ids = battery_device_ids,
+	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = acpi_battery_add,
 		.remove = acpi_battery_remove,
+		.notify = acpi_battery_notify,
 		},
 	.drv.pm = pm_sleep_ptr(&acpi_battery_pm),
 };

-- 
2.46.0


