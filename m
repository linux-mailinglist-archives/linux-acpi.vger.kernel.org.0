Return-Path: <linux-acpi+bounces-19511-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 95164CB028A
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 15:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A7E8301977D
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C674A2989BF;
	Tue,  9 Dec 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYqmPoBQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB6288C34;
	Tue,  9 Dec 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288858; cv=none; b=cPwRToixwkpWVsF0iLauBLqLaN1XMOsIYOYtrh8CwZ1wN7H39st807nwI9tcn1bAFH6qxL+E0IVx5+IgltHQW3kgxOc3yHSCDNTbB0lmfIjoR787DOdDkbvfxukaWwFMzlbkXfYU004Q0zDOmu7GCXXhHhLlsm44DiV1tW+9c34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288858; c=relaxed/simple;
	bh=9MYPvycO72qiUjiHEBTYvwZbNGMr66KlQdcFJE8oal0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzfOjeiWOuWvj17YUDHAyJ15ghtP6IDmkAReBlCKBsfVDuCkBSeL5Il62wONQAz2PHnI5mulctiebUMCSbBZsEBYf5nPjCpMU5Bjn6J9QzmY+fRDW1bSs6Me1iWYAFvmihVh/6reTnKIwGHVJlT8SSrvtKpNDqye7snqUWMPjaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYqmPoBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8B6C113D0;
	Tue,  9 Dec 2025 14:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765288858;
	bh=9MYPvycO72qiUjiHEBTYvwZbNGMr66KlQdcFJE8oal0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYqmPoBQiO5tpaEGzyC5In3Xa4ZA5uCvDli7CHqtTT1oaagqVTBjZaIdBdmnl1Bn7
	 EiJA1TJTzZxi/go1MvLb7dSyOK7Egkp03IrwcqR7Zxra6al/rG0vYbWOpyC45ZbPPd
	 y5uSRkbVZ3NUW7zf1vuboEaSbkd3cWuSMhfumhoEZTKKrmwUlDTReTnXMJiUlvkxUb
	 ul+jBs7BhD8BFtQb0PrSUiAUJAKBqceG4p+x0khWhH1yW+uAJuZKE8xTZDxsGSQFRH
	 aAFxD0qvYX4UohJFOL1x5Ty3vWMl/PNMwp+WPGfcniWYRRs7Eoi58TIq/YQzvdTp0u
	 D/ZQ/otBMGLgQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 06/10] ACPI: scan: Do not bind ACPI drivers to fixed event buttons
Date: Tue, 09 Dec 2025 14:56:06 +0100
Message-ID: <4480030.ejJDZkT8p0@rafael.j.wysocki>
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

Both ACPI button drivers have been converted to platform ones, so there
is no reason to attempt to bind an ACPI driver to a struct acpi_device
representing a fixed event device button.

Update the relevant code accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2652,15 +2652,8 @@ static void acpi_bus_add_fixed_device_ob
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




