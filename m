Return-Path: <linux-acpi+bounces-19508-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30310CB0227
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 15:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5142301A733
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 14:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15B12882CD;
	Tue,  9 Dec 2025 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILjQx6kJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77224466D;
	Tue,  9 Dec 2025 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288844; cv=none; b=Smmo6XcrVDCSfjgMbsXS/YelXEaVKpu1wBtaGSDpqQmSfVqoTvSy3qjrqQnw8QoIKcNe59wtkaqsbKUxqbnOtYd21FAmPYLHXLkiy7Zjcy/0Vpb1+F4U5rnsB2FQ4cp7dair5cRrxDJETmXjnwshiFF18G0s4EnqAcEiBIPyseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288844; c=relaxed/simple;
	bh=RNvC67Ot9vfiYXe9xfu/wIhG+y/Luusb8b5f71EZDYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oETIPdNPbQuGDDfz1JRs0UIW28Jg7q8iNdH5KKPKnP0/xlAsvilipYSvezocTGi1kbVzY1rwDsDE35HifansAtKk3n1rYlu30Ailicu2Z3B2exIDGLWO/Sr5YVVXTG9B1vTM+ZjkttJU+dkMAz0hIvnkqyPBgXdrAri2s+7YbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILjQx6kJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E9BC4AF0B;
	Tue,  9 Dec 2025 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765288844;
	bh=RNvC67Ot9vfiYXe9xfu/wIhG+y/Luusb8b5f71EZDYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ILjQx6kJ4qSk1+UFkOWHApVU1Exoez8mnURKZFwtsyHKjLdyHzwUJ3IlpjqHAwFeK
	 kAJh1Z0tz5r/++fYQ9sa0jh/p+XSnLhVgfBBy+OyPSUFVB/ImjlB3TPfSNeELul/7Y
	 aJ7C0eIQQVSrEXa4ub/XmWW/Ml/mouFF0RuLyFLqSsb162E0s2WnPNrNBZTRe+lAMx
	 PU4yfUMJNkeATRmZwHNgb6ZXn9eY74gsRpRtCip6+K1WuqXLmiA7B5x2slD6cteC/8
	 vvGzrnRxT1Vmfe8zKIH+7z/N+CvTmfvIq+t78sFDUeUFhc+Yy+rOI7NXpp9IHHwH+q
	 tC5+PW+zQ3KZA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 09/10] ACPI: battery: Reduce code duplication related to cleanup
Date: Tue, 09 Dec 2025 14:58:32 +0100
Message-ID: <47721451.fMDQidcC6G@rafael.j.wysocki>
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

Notice that sysfs_battery_cleanup() calls sysfs_remove_battery() under
battery->update_lock which is also done in acpi_battery_remove(), so
adjust the latter to use it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/battery.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1279,9 +1279,7 @@ static void acpi_battery_remove(struct a
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
 
-	guard(mutex)(&battery->update_lock);
-
-	sysfs_remove_battery(battery);
+	sysfs_battery_cleanup(battery);
 }
 
 /* this is needed to learn about changes made in suspended state */




