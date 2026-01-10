Return-Path: <linux-acpi+bounces-20144-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC629D0D5C9
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 12:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FE5D3003B27
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EEF33F371;
	Sat, 10 Jan 2026 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLJIr2JZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E17310762;
	Sat, 10 Jan 2026 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768046330; cv=none; b=HluwWSs2J+nKl/C6QGsoSdiBOYVwNGNDX8rV10VO9/PsV/+XB4a99iLOKVCtORRjqsWA69IO7Tu26BU1niz89UG4ssRnhaA9r6TNDLdZYCnTgBJ7uwQ/09l90viJJ/TA7EcAA84kFrI+EwKEvgbcs0txrGtAxSNzKEeak49f/4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768046330; c=relaxed/simple;
	bh=cDKburHHJtcE54YX1NChvSfqyVoBDDQUKJ34gVOO9D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=th6MzHwSLvyS2jjQuuQVtdmy2/bGN2kZg3hooCioc40KstPiCPtj3GZxjj/uZA0vMactewO2hHEeTjksJlNI/G4VPupjoZG3oMAICx1lwiizYb6aIeotG8QpdO2zYZvoEzG4Rr/+r/e3Fiw5+aZ/OHmdMBA77nFcqAF+te5qhRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLJIr2JZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACD4C4CEF1;
	Sat, 10 Jan 2026 11:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768046330;
	bh=cDKburHHJtcE54YX1NChvSfqyVoBDDQUKJ34gVOO9D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLJIr2JZXeKD2xQEGkh+tei1lVgDfHuHwNi1VtM3ikiJKyPnh8JRZ9zYYgdukYMnT
	 4CLWqq7jrF6TBAjWo0Hla9Y0PPU+tzxUtdA7kq0qeupu7p98DnIAse2/Q3G0Hn7s9q
	 ZfpiAM30CHhnxTTQsR0SQJTkGdjFHFXsEVOyXzLQS4nXCoqJ/9SI/evLL+FxLY7bw3
	 e8zWBVFKqT8XJBp5+AjEljalzdxk1d3zmSxVBGj/3JdVb+cG0jmg4wkPPmMWhHKSVb
	 hcVVLJ0ccitEwAY6gFTBA8BXeQPAVA8vsgFgne1gMAENu3msj67AqmXo56TzRAMTBv
	 LVsK1AyLlnIdA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Todd Brandt <todd.e.brandt@linux.intel.com>,
 Xi Pardee <xi.pardee@linux.intel.com>
Subject: [PATCH v1 2/2] ACPI: scan: Use acpi_setup_gpe_for_wake() for buttons
Date: Sat, 10 Jan 2026 12:58:38 +0100
Message-ID: <2259694.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4715380.LvFx2qVVIh@rafael.j.wysocki>
References: <4715380.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After starting to use platform devices for representing buttons
enumerated via ACPI, acpi_mark_gpe_for_wake() is insufficient for
preparing their GPEs to wake up the system from sleep because it
does not change the "dispatch type" of the given GPE to
ACPI_GPE_DISPATCH_NOTIFY.  Subsequently, this causes acpi_enable_gpe()
in __acpi_device_wakeup_enable() to fail and system suspend transitions
to be aborted.

Address this by updating acpi_wakeup_gpe_init() to use
acpi_setup_gpe_for_wake() for buttons like for any other devices.

This allows acpi_setup_gpe_for_wake() to be simplified further because
buttons are not a special case in it any more, so do that as well.

Fixes: 52d864019636 ("ACPI: button: Convert the driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -999,15 +999,11 @@ static int acpi_bus_extract_wakeup_devic
 	return err;
 }
 
-/* Do not use a button for S5 wakeup */
-#define ACPI_AVOID_WAKE_FROM_S5		BIT(0)
-
 static bool acpi_wakeup_gpe_init(struct acpi_device *device)
 {
 	static const struct acpi_device_id button_device_ids[] = {
-		{"PNP0C0C", 0},				/* Power button */
-		{"PNP0C0D", ACPI_AVOID_WAKE_FROM_S5},	/* Lid */
-		{"PNP0C0E", ACPI_AVOID_WAKE_FROM_S5},	/* Sleep button */
+		{"PNP0C0D", 0},	/* Lid */
+		{"PNP0C0E", 0},	/* Sleep button */
 		{"", 0},
 	};
 	struct acpi_device_wakeup *wakeup = &device->wakeup;
@@ -1016,15 +1012,9 @@ static bool acpi_wakeup_gpe_init(struct
 
 	wakeup->flags.notifier_present = 0;
 
-	/* Power button, Lid switch always enable wakeup */
 	match = acpi_match_acpi_device(button_device_ids, device);
-	if (match) {
-		if ((match->driver_data & ACPI_AVOID_WAKE_FROM_S5) &&
-		    wakeup->sleep_state == ACPI_STATE_S5)
-			wakeup->sleep_state = ACPI_STATE_S4;
-		acpi_mark_gpe_for_wake(wakeup->gpe_device, wakeup->gpe_number);
-		return true;
-	}
+	if (match && wakeup->sleep_state == ACPI_STATE_S5)
+		wakeup->sleep_state = ACPI_STATE_S4;
 
 	status = acpi_setup_gpe_for_wake(device->handle, wakeup->gpe_device,
 					 wakeup->gpe_number);




