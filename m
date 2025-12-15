Return-Path: <linux-acpi+bounces-19581-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC26CBE36C
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 15:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25BF730022FA
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1220F335BBB;
	Mon, 15 Dec 2025 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vE6Dlzif"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5433556C;
	Mon, 15 Dec 2025 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807461; cv=none; b=jkoSj9Q6vSYWiLR0cj80eS+2weKURYH2+TJnhIXTs6ghiDi5LB2g6NmsWqo/wIJPwU3ngWLqufkdOBFZX6uuQgkWfy3ttKT9N29NPMVyeCdh8vpCx0u/0JLv4mkYMZg83NitoxmlvIXvKBXYuceZ2M07XxDKzH3682plvVBrwRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807461; c=relaxed/simple;
	bh=6vvbtUhyx+Vh39xk3H6F4iiMvieFsent7KLa+qxDcY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opC1fu6cNZjl+fRVtFgxZapTsLugZ3b1N9mj2NZWOGHSxqE0IvwG7SfGDkoQQ5ToOw+y0X+YoyuwtZJTIKVr1MqW/suyJGKc5sTfn24j17OkKfG7wkdJd8/Xq/ob7sbNKG9AASwkrvgRYvmKlaGnO9iiNzv8hucaMiJm/sIQ3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vE6Dlzif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AD6C16AAE;
	Mon, 15 Dec 2025 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807460;
	bh=6vvbtUhyx+Vh39xk3H6F4iiMvieFsent7KLa+qxDcY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vE6DlzifwZmzMb4xs9dw0ykAxqiRL+2H/di8enVz7Geo+HPKjJVJFGUiFRbq2vJhG
	 xc6a/koJaNrULcnYSMU9k3TxJExkIBjL0XbPL3zX8lYIrU3Ef3+aB1++j3HiYimmNd
	 jpYcoerCEH9YvHfbb9lZkTVhEQB9AyIiqS/0oHukMa2cOoXIExsChc59MlISDDtU7h
	 nvsX8m1THb3QniwEPqw6IRKoR483UM1NjaZx//DmItEZKbJicBJCuKq66TLwn9Vnd1
	 sxz3dSuYMB7qGR4OsJjhbHiRrxunBfRMA4QhP5qJWK+VKJ+niGWcQ1k+jnYBn/jU0r
	 33IQpcKEI/N3Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v2 05/10] ACPI: tiny-power-button: Convert the driver to a platform
 one
Date: Mon, 15 Dec 2025 14:59:00 +0100
Message-ID: <5629403.Sb9uPGUboI@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2685338.Lt9SDvczpP@rafael.j.wysocki>
References: <2685338.Lt9SDvczpP@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

While binding drivers directly to struct acpi_device objects allows
basic functionality to be provided, at least in the majority of cases,
there are some problems with it, related to general consistency, sysfs
layout, power management operation ordering, and code cleanliness.

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the ACPI tiny-power-button driver to a
platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/acpi/tiny-power-button.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

--- a/drivers/acpi/tiny-power-button.c
+++ b/drivers/acpi/tiny-power-button.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/sched/signal.h>
-#include <linux/acpi.h>
 #include <acpi/button.h>
 
 MODULE_AUTHOR("Josh Triplett");
@@ -35,8 +36,9 @@ static u32 acpi_tiny_power_button_event(
 	return ACPI_INTERRUPT_HANDLED;
 }
 
-static int acpi_tiny_power_button_add(struct acpi_device *device)
+static int acpi_tiny_power_button_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	acpi_status status;
 
 	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
@@ -55,8 +57,10 @@ static int acpi_tiny_power_button_add(st
 	return 0;
 }
 
-static void acpi_tiny_power_button_remove(struct acpi_device *device)
+static void acpi_tiny_power_button_remove(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+
 	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
 		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
 						acpi_tiny_power_button_event);
@@ -67,14 +71,13 @@ static void acpi_tiny_power_button_remov
 	acpi_os_wait_events_complete();
 }
 
-static struct acpi_driver acpi_tiny_power_button_driver = {
-	.name = "tiny-power-button",
-	.class = "tiny-power-button",
-	.ids = tiny_power_button_device_ids,
-	.ops = {
-		.add = acpi_tiny_power_button_add,
-		.remove = acpi_tiny_power_button_remove,
-	},
+static struct platform_driver acpi_tiny_power_button_driver = {
+	.probe = acpi_tiny_power_button_probe,
+	.remove = acpi_tiny_power_button_remove,
+	.driver = {
+		.name = "acpi-tiny-power-button",
+		.acpi_match_table = tiny_power_button_device_ids,
+ 	},
 };
 
-module_acpi_driver(acpi_tiny_power_button_driver);
+module_platform_driver(acpi_tiny_power_button_driver);




