Return-Path: <linux-acpi+bounces-19584-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6256CBEC73
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 16:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A63D300118B
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77AF3375DD;
	Mon, 15 Dec 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g57ELkAA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6373375C2;
	Mon, 15 Dec 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807469; cv=none; b=S3udtz+4jGSHbOF/kikPWVTNKNgkXX+CN65Y2aY2t99doZNxHceCM95UxtiI7N/DnJtetGyeQq9Jly9Fwjsq7czkJ8Wn7lhjpw431qMAmdZthCD4w/6TBbcuAJO9ECu3k8DDpuRxXdS6q0hfY5QCoeErAu75JU6owLerrDLWn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807469; c=relaxed/simple;
	bh=KPj0VXGkCWozRW5mspd8XopJIttba3dVN3v2ct991KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPrPMg2dTfxu1R9k+NbWIy2ibdRSvab+0U8XyP+EinKJ28xFlVJeGANqqJJ9KWyZo2yv7H3sTORO8AlO6qkOa7wiyRBq3ZnqSZAvME/ePHIvSRyJbZo2+XuLzS4aq0nyb2ghECMQM5y19MTjJS8+e+ees5KJrY4EfFBi/xqIEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g57ELkAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E84EC4CEFB;
	Mon, 15 Dec 2025 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807469;
	bh=KPj0VXGkCWozRW5mspd8XopJIttba3dVN3v2ct991KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g57ELkAAxVthIfRQrgLDnCLvNWK8qfDHpdrZVTwHx5M/9FmGu9zdX869fWW0PUkY2
	 I9Lmfa8f0BKOiNujoV0LijeRy7+NcfiXNFNFpJ0UIBooLJdeUGKeM57Fh3zDmGv1aX
	 vNuoh4XHB7RV5ZUc4HgEqApaJ/Gx+7Yt3TAmmxVK4V8H4hMiFLbZSDB3B+zJYBXJCq
	 wVWkzc5ZMNSrwPylHWwYupiQip7/2n2yRPfGwBRasW9w4LEPcXD4YvPGWB9pVWDD+y
	 9lzgs3StPok4XYd3VRcqgsM8HHFHSiJhIZuLmxIcbonw8eVAQFDvdTO2siMh9YG2gX
	 KJUMGQI5CIQ2A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v2 02/10] ACPI: scan: Reduce code duplication related to fixed event
 devices
Date: Mon, 15 Dec 2025 14:54:17 +0100
Message-ID: <1916860.atdPhlSkOF@rafael.j.wysocki>
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

Move duplicate fixed event device registration code
from acpi_bus_scan_fixed() into a new function called
acpi_bus_add_fixed_device_object() and make acpi_bus_scan_fixed()
invoke that function as needed.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/acpi/scan.c |   42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2754,37 +2754,29 @@ int acpi_bus_register_early_device(int t
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




