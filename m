Return-Path: <linux-acpi+bounces-19516-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A86CB02DE
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 15:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D14330D03D8
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 14:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BDC2D0C66;
	Tue,  9 Dec 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5YFdSz5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD128299929;
	Tue,  9 Dec 2025 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288880; cv=none; b=DOH74xSU/j7T0ATsfp2bRQL+TH++nFdKixmIGv49fPBIv7x3QZt2THOhW7iArlhcS5oUK/WbwkpKZ79JXirPfiFPMoyONPXCIGZ8ZZxZLk+a+L6cdNmelCibRGKSVsm3eTgipPzSo1S3VFccEvERGNrtPkydiELnsKJqytREfd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288880; c=relaxed/simple;
	bh=DeNrsEjM+4Dqw1MVhTPxt9+4Xz2VQubDQpaGC0x20zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IF6GGA4CsP5uv08lQl2aKfEe/xdp6VpYyz1i/RZ7bbfq/i+irdnY2ymyMo2xkQQRPtEwEOz3h/YSm4spH8y/7BsrbYrYRi+1w+J4ICOmoQ+AetxYPu4gBV/iTx6VF9H+I66QSd+9raLE06Ptx+BuAJvdL5HaLWj701mg4an2Imw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5YFdSz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487D4C4CEF5;
	Tue,  9 Dec 2025 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765288879;
	bh=DeNrsEjM+4Dqw1MVhTPxt9+4Xz2VQubDQpaGC0x20zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5YFdSz5WIZCoPeZH2s7oVBPuOnZbUJYPJZ1+9zk/VZRGohzIBU+75rBc5siojuDd
	 q/zVXWNhi/nVM6AU3uCeKjqK8dSA1tMPqLZBw+H8uF0oQ4pkpP8+ui6D62iB033gS6
	 OAhUSqvPRyvod9uxZXVA+Ktbkh0tz7sZ/SGIQC+pdtxCe357wUFPALlmLmnAaeg9bL
	 gUOunYVemM64M7J8uAnd+IfC2AyLb5c4OAE9VK5T56How9/uFzRVA5JCEkpFkBfl+7
	 ndgUrUqFUXLOqVSld8IVu6GpqHbjv1A8SShNRx6QssV+ru5n8wxV1f0AhtgemTq17w
	 QIpk1k0/c6lvw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 01/10] ACPI: scan: Register platform devices for fixed event
 buttons
Date: Tue, 09 Dec 2025 14:53:02 +0100
Message-ID: <3322931.5fSG56mABF@rafael.j.wysocki>
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

On platforms using ACPI, power and sleep buttons may be so called "fixed
event devices" in which case they are hooked up directly to the Fixed
Events register in the platform via dedicated lines and there are no
corresponding device objects in the ACPI namespace.  Nevertheless, in
Linux they get corresponding struct acpi_device objects with special
device IDs, either LNXPWRBN or LNXSLPBN, which are then used for driver
binding in a ususal way.

However, the function creating those struct acpi_device objects for
"fixed event device" buttons, acpi_bus_scan_fixed(), does not register
platform devices for them, unlike the generic code handling device
enumeration based on the ACPI namespace.  Consequently, if an ACPI power
or sleep button is represented by a device object in the ACPI namespace,
it will get a corresponding platform device, but if it is a "fixed event
device", it will not get one, which is inconsistent and prevents the
ACPI power button driver from being converted into a platform driver.

For the sake of consistency and to allow the ACPI power button driver to
become a platform one going forward, modify acpi_bus_scan_fixed() to
register platform devices for "fixed event device" buttons and update
ACPI platform device registration code to work with non-device ACPI
object types, so it can handle the buttons in question.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_platform.c |   29 ++++++++++++++++-------------
 drivers/acpi/scan.c          |    4 ++++
 2 files changed, 20 insertions(+), 13 deletions(-)

--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -138,21 +138,24 @@ struct platform_device *acpi_create_plat
 	}
 
 	INIT_LIST_HEAD(&resource_list);
-	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
-	if (count < 0)
-		return NULL;
-	if (count > 0) {
-		resources = kcalloc(count, sizeof(*resources), GFP_KERNEL);
-		if (!resources) {
+	if (adev->device_type == ACPI_BUS_TYPE_DEVICE) {
+		count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+		if (count < 0)
+			return NULL;
+
+		if (count > 0) {
+			resources = kcalloc(count, sizeof(*resources), GFP_KERNEL);
+			if (!resources) {
+				acpi_dev_free_resource_list(&resource_list);
+				return ERR_PTR(-ENOMEM);
+			}
+			count = 0;
+			list_for_each_entry(rentry, &resource_list, node)
+				acpi_platform_fill_resource(adev, rentry->res,
+							    &resources[count++]);
+
 			acpi_dev_free_resource_list(&resource_list);
-			return ERR_PTR(-ENOMEM);
 		}
-		count = 0;
-		list_for_each_entry(rentry, &resource_list, node)
-			acpi_platform_fill_resource(adev, rentry->res,
-						    &resources[count++]);
-
-		acpi_dev_free_resource_list(&resource_list);
 	}
 
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2660,6 +2660,8 @@ static void acpi_bus_scan_fixed(void)
 				device_init_wakeup(&adev->dev, true);
 			else
 				dev_dbg(&adev->dev, "No driver\n");
+
+			acpi_default_enumeration(adev);
 		}
 	}
 
@@ -2672,6 +2674,8 @@ static void acpi_bus_scan_fixed(void)
 			adev->flags.match_driver = true;
 			if (device_attach(&adev->dev) < 0)
 				dev_dbg(&adev->dev, "No driver\n");
+
+			acpi_default_enumeration(adev);
 		}
 	}
 }




