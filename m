Return-Path: <linux-acpi+bounces-19512-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A70CB0275
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 15:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B3F13035881
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E0E2BDC01;
	Tue,  9 Dec 2025 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edGi/giR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580B326CE04;
	Tue,  9 Dec 2025 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288862; cv=none; b=sjc5qswJAGI5OVPbsaHOkEb18BwnvWsLZKNzm1hdjaTSRlypPwKpzCS/qJDdSkJAbuarTlrZFUvdXq7S4nHPOTW0I9uayMRgeXDq6bIA9Uk5Htin/wNs85IJ9ny4rc09hGWQKwKeaDiW4EJ9MXLcfXQdpLQSOoMTlIZrsvmaK/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288862; c=relaxed/simple;
	bh=qm2y1m6xP8LoGLSwQeqts2s8oWJdEsfT9ZkJ1Mex+6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTu84fwoybnbgEcBYK7XGWi77MLGI4Oij8I7QgJUbczepCbrGrew4dKbMoUp8nVhKYgKMqUTPKDZ1DIKhNvOJzbmyUXzsZ9sHefoEmAVqfG/AlReWCnUtVQEvbquOM7LIgZjRyQgzwc/Qk8K3VC4oho7vrtXh9sbja1/MhfOgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edGi/giR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BF4C113D0;
	Tue,  9 Dec 2025 14:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765288862;
	bh=qm2y1m6xP8LoGLSwQeqts2s8oWJdEsfT9ZkJ1Mex+6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=edGi/giRMvYXHL+ibSFhOvBRpoYbRiLWM5fdZQ4jEg2mk53CTg8Y4YirBfuup0jfL
	 lLl7aITuyueHqiuCFayv6uBOJXIhd6f6KkW7qP6qYiTA87kSCfrFSpo++wHUaFn3se
	 4QW8hR+wNnl07gqd4Qg6uuQSkQiKLtLdu6cdXYAoCMOoK97uNTTeGzlWEjTjW0n/RI
	 +gf07eiurW/undvMJ5f2J0c/CMqYRLaMeM16kYhEJfH0YIijv7V7tx9o4rns/aC7Aa
	 LSovEkDx50xU9ho2yvuV12ojNy02lcfxRIxZPnaHPok9vJ1J7bl8R6Nle9gIMcjMf/
	 XSOi3OgDsZDiA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 05/10] ACPI: tiny-power-button: Convert the driver to a platform
 one
Date: Tue, 09 Dec 2025 14:55:12 +0100
Message-ID: <24192980.6Emhk5qWAg@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2339822.iZASKD2KPV@rafael.j.wysocki>
References: <2339822.iZASKD2KPV@rafael.j.wysocki>
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




