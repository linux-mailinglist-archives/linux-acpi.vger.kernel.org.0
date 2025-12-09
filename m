Return-Path: <linux-acpi+bounces-19515-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C49CB025D
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 15:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F709301778B
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 14:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A51D2D7DD5;
	Tue,  9 Dec 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeL75Qal"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8B2D7D2F;
	Tue,  9 Dec 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288875; cv=none; b=kzGfa2rNW8amz6dqd4yEDNk/qHFDcizePIDEGj2obJ7hdJuxePKhTyKnRpkeJWXRZYqCdc/CNhDFV5kzE86Hwir9Hn1RyZ/VdWPF9fSooWUIwd95i6SwcGNrDmf3UwBSh4tQGjaYo6bYQyaxXpMknfVb6+7o52lJXydaOxgIvMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288875; c=relaxed/simple;
	bh=cA1k0ZgxLBdb4xdZVxc9tFf/9+gu4EaouVVW56rw7Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyYSMW/TVtqfmMeVxCRV8b4G39u4EnRPhd58hoAJDg3R8WAw9pGwhyejJ8ZDunQJCntr3ShotdI4PlSJHldAkmHQv+cnL9wirC/O7gUm4Lbm3/X9n+89vx3S6qrtWRRe+F6GLBBQ6lsvraS9geCdn8ezHIPD3wOQ5+ooFG3qte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeL75Qal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3979C4CEF5;
	Tue,  9 Dec 2025 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765288874;
	bh=cA1k0ZgxLBdb4xdZVxc9tFf/9+gu4EaouVVW56rw7Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HeL75QalhHQahfGEACBqrAKe6kLoRPEkbuwYCjnEeZqDhsvb3h5LL5nLWsbPLT3s5
	 g9qQz/832Amj4QKWSkeXiYLgHhhUjpIKZmozkgq8XTdHC0ZFgM7RIB4hnYCS7Qwl8n
	 Kh328K5b0qD3Ckt5tALAqKKbGB1c75icTeHCGsGtv96J64kxaYXlNIaUwEqiaow/4a
	 j1kME37Mfd+FlgRT+U9PmuWzzBFNTQdEVhczxVsopafrecKAFCF3nY381S6sFo7uzJ
	 PQIKsotCINGbWHOgF6sn8GMP06hjHyHK2iJRgs7p+UTCgqaeto0NmyRaXP5aozsST5
	 fRCiIDOmqU6Lw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 02/10] ACPI: scan: Reduce code duplication related to fixed event
 devices
Date: Tue, 09 Dec 2025 14:53:09 +0100
Message-ID: <6119210.MhkbZ0Pkbq@rafael.j.wysocki>
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

Move duplicate fixed event device registration code
from acpi_bus_scan_fixed() into a new function called
acpi_bus_add_fixed_device_object() and make acpi_bus_scan_fixed()
invoke that function as needed.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2647,37 +2647,29 @@ int acpi_bus_register_early_device(int t
 }
 EXPORT_SYMBOL_GPL(acpi_bus_register_early_device);
 
-static void acpi_bus_scan_fixed(void)
+static void acpi_bus_add_fixed_device_object(enum acpi_bus_device_type type)
 {
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_POWER_BUTTON)) {
-		struct acpi_device *adev = NULL;
+	struct acpi_device *adev = NULL;
 
-		acpi_add_single_object(&adev, NULL, ACPI_BUS_TYPE_POWER_BUTTON,
-				       false);
-		if (adev) {
-			adev->flags.match_driver = true;
-			if (device_attach(&adev->dev) >= 0)
-				device_init_wakeup(&adev->dev, true);
-			else
-				dev_dbg(&adev->dev, "No driver\n");
+	acpi_add_single_object(&adev, NULL, type, false);
+	if (adev) {
+		adev->flags.match_driver = true;
+		if (device_attach(&adev->dev) >= 0)
+			device_init_wakeup(&adev->dev, true);
+		else
+			dev_dbg(&adev->dev, "No driver\n");
 
-			acpi_default_enumeration(adev);
-		}
+		acpi_default_enumeration(adev);
 	}
+}
 
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_SLEEP_BUTTON)) {
-		struct acpi_device *adev = NULL;
-
-		acpi_add_single_object(&adev, NULL, ACPI_BUS_TYPE_SLEEP_BUTTON,
-				       false);
-		if (adev) {
-			adev->flags.match_driver = true;
-			if (device_attach(&adev->dev) < 0)
-				dev_dbg(&adev->dev, "No driver\n");
+static void acpi_bus_scan_fixed(void)
+{
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_POWER_BUTTON))
+		acpi_bus_add_fixed_device_object(ACPI_BUS_TYPE_POWER_BUTTON);
 
-			acpi_default_enumeration(adev);
-		}
-	}
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_SLEEP_BUTTON))
+		acpi_bus_add_fixed_device_object(ACPI_BUS_TYPE_SLEEP_BUTTON);
 }
 
 static void __init acpi_get_spcr_uart_addr(void)




