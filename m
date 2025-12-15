Return-Path: <linux-acpi+bounces-19580-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D75D9CBED79
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 17:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AD7D3002D2E
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 16:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FB833557B;
	Mon, 15 Dec 2025 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3cyEhOV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E4F335572;
	Mon, 15 Dec 2025 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807457; cv=none; b=fHoT6Dh0R/E5mbwUq3Xa4tjFkYNfxjLFWP/9j6r7futAQTdpQHwbqFeu4R7im5AxUQ+wXNzEUjiae1woq/BvYE8T0odPXJsxVD6L50UcAIl24jQR12MT9tGwmHgETfpsBwhJ6m2jsZadQ0LjASt0FjqYHO8eD7sWwmnJxt12D3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807457; c=relaxed/simple;
	bh=pA8cyJxGyMjsthMWw5zIiQgeBUOOkAp+EkqNp6CjU9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzbs02FYtba+6zXgoG4s2wCIoxeBQbUW2pY5XNK8iSOL+pQvx4SG0rkkYIPoXE9bJ1kleR/Xqp6N4SyiLOR8lI2Who1LvVrfJbWsbLIuUMtOHeltiu+szkumiRIxDXA3pLhqcfHIzrhWdPBue+lSuAaDZdg8PkCVwUqKpzOF7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3cyEhOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8488BC4CEF5;
	Mon, 15 Dec 2025 14:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807457;
	bh=pA8cyJxGyMjsthMWw5zIiQgeBUOOkAp+EkqNp6CjU9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3cyEhOV1sLpvUwlFVHI88iuxh+zDqiFIj7AIBkcbnvOTKWYwEASt4vT1ggFteuqp
	 kEcrAFeWWYeVdDBQEb/AHrF+qNyWV9DcMeXEQBckl2WyI+Sf+eqgYeCwTg4FoSWpRz
	 7Tn7yuF9amfwKlOZqiPDbWXKuSrcDNxiJTMjOkUMXVl1pNn3a0NDFXlEMoVS2ZmAPF
	 po44tmzBkK5ZpOGEJn/ylNcXLTBF/scsoYhwxuaonqWMhO47/UA5yzZLbSIn4ycD8x
	 RT5ewADgE2Dk8B6Hljk9aXEHbapgf+2T61cfST+6x6f56TdAWnQjjNbJSIbYvMnlr3
	 sM0/Z4oZ0pxpg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v2 06/10] ACPI: scan: Do not bind ACPI drivers to fixed event buttons
Date: Mon, 15 Dec 2025 15:00:01 +0100
Message-ID: <2213073.OBFZWjSADL@rafael.j.wysocki>
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

Both ACPI button drivers have been converted to platform ones, so there
is no reason to attempt to bind an ACPI driver to a struct acpi_device
representing a fixed event device button.

Update the relevant code accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/acpi/scan.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2759,15 +2759,8 @@ static void acpi_bus_add_fixed_device_ob
 	struct acpi_device *adev = NULL;
 
 	acpi_add_single_object(&adev, NULL, type, false);
-	if (adev) {
-		adev->flags.match_driver = true;
-		if (device_attach(&adev->dev) >= 0)
-			device_init_wakeup(&adev->dev, true);
-		else
-			dev_dbg(&adev->dev, "No driver\n");
-
+	if (adev)
 		acpi_default_enumeration(adev);
-	}
 }
 
 static void acpi_bus_scan_fixed(void)




