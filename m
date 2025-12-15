Return-Path: <linux-acpi+bounces-19578-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 479B2CBE38D
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 15:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A9DF304B97C
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59176335071;
	Mon, 15 Dec 2025 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYrG7WeG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D94B335067;
	Mon, 15 Dec 2025 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807452; cv=none; b=uraYbtGIsEcPpoPtRIOC/3BYt8Zv9X0hZfl0ZCRub2POjHLZUkwYA8KlX2TyyJLHCWPd/asHMRx0hmqmqWiO6OlJulqIZj+254ZSH+pFYarGLYnNGBauo50XlFyMhabSjNCHiEWY3AM89NVO8RqAqiOAGkgvHZqLgED2xdepsGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807452; c=relaxed/simple;
	bh=N1r2pocbdy2XGiuHK87va7mABtHkyVjSHcjeMoz1v2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1tRWe5eORDLsEwvwpfWbpi5f6gQyue1QqiOg7w17R4auIT4vW4jlyvAktp9Q+YGMo92s4G15DA1/7AFFMtKCc94yqFwXOMe0OiEuuEzjmZdfq95bd/WTyHkZYE0g6Yheln225lS6f/bbloURFyuUIA29UPEDJcwXUQwwyRsbUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYrG7WeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F749C4CEFB;
	Mon, 15 Dec 2025 14:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807451;
	bh=N1r2pocbdy2XGiuHK87va7mABtHkyVjSHcjeMoz1v2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYrG7WeG2zLA+QoKkFKU/Pgv9DbZT4WSbVStIJ9KpNJRjBlU3pCFGwYeSVVK47Vis
	 dLqODlHpgbD2PwJAe+ny0qfWA2gp70QxhSMpTUF4zwtMQFlyv/Dj5kyQ0WbVKq5Zta
	 q76omXPhwVCg0CVI56yIElldVFXgZgys3qUTt2ZhJlECX3CoVQxmNleP/9gzkToArI
	 szzZgTAPLWvJypB/ewmRXDbhqPT4YLPbZdF7le3Vnou8fEZSCCwv3U0Fqf8JsMsmYU
	 Su9icnTk6HcCaV6RQC2nzVsdd18sELFxM9tmTF2PTkedNbjBzP1g7UpEMza3YqxEJo
	 VuVCjbN0hTGIQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v2 08/10] ACPI: battery: Adjust event notification routine
Date: Mon, 15 Dec 2025 15:01:53 +0100
Message-ID: <4344406.1IzOArtZ34@rafael.j.wysocki>
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

Adjust acpi_battery_notify() to cast its "data" argument to a struct
acpi_battery pointer istead of a struct acpi_device one, which allows
the use of acpi_driver_data() to be limited and will facilitate
subsequent changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/acpi/battery.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1054,8 +1054,8 @@ static void acpi_battery_refresh(struct
 /* Driver Interface */
 static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct acpi_battery *battery = acpi_driver_data(device);
+	struct acpi_battery *battery = data;
+	struct acpi_device *device = battery->device;
 	struct power_supply *old;
 
 	if (!battery)
@@ -1249,7 +1249,7 @@ static int acpi_battery_add(struct acpi_
 	device_init_wakeup(&device->dev, 1);
 
 	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
-						 acpi_battery_notify, device);
+						 acpi_battery_notify, battery);
 	if (result)
 		goto fail_pm;
 




