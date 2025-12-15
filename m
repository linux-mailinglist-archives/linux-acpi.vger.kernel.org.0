Return-Path: <linux-acpi+bounces-19579-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F41B5CBECB3
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 16:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CA0C305B90B
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332AC335546;
	Mon, 15 Dec 2025 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHv6KtNd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0805133509B;
	Mon, 15 Dec 2025 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807455; cv=none; b=a39UP4s9bUvrRCRpiFzNut6+h6mWPF+2IwtXRcwPDtmO7d80pi80n+o78sakIv/wUTOvV6zAQrq0dBJFNi+ZzqXoV6YL/gMswE/P/dEmpngGOMBtpadwN8Nu+gutcf6GkPIJX9P0b7thNeMoVdlgQWQpMxRm6zcNRbLz+IinPR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807455; c=relaxed/simple;
	bh=zyIu2O5DApBLBGi5U9UWuOX5VMmYTIhrwv6Kh5/hPMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brWOviBUgcoKK1wZ7yzg2PQl1KV67Is4FFf1M3XjU2P+ofu1sZVMG8D8BB+zjie+PmnlV9W24g9mLJpRBRxF3fohgT1CiT4dNUAr3YeDENq/GE5relZG7ID/7caXjlH01y6yIf5VGJqqo7CyL8r6okPPltceGvYZOZYKMgVPgpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHv6KtNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910A1C4CEFB;
	Mon, 15 Dec 2025 14:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807454;
	bh=zyIu2O5DApBLBGi5U9UWuOX5VMmYTIhrwv6Kh5/hPMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHv6KtNdvXpJxzWJ8Er0BHUcGS3wx8k4ZwZ6gyBZ+yfUn+E/abuaN2iVHWCopBnc9
	 kPBvI57T8p9JVPlL670mJqc43+K8R8GKPmsvG51VhAIGlTRrhC6Sm3LuFPP3Ez1RoU
	 TyBjRi+QY2aux7l1cF3g1bXny9npIHYGQP14lNxrUa8RYUlVAkp6D8hWvCpTBzJ4By
	 b0g/DJIMe/mszSRhZT27CQmt+UxFC0OYiNpHthOCBrDUHHMb8DhJrfqice0QR8rdwp
	 zHFdgEHnIoC3GPt7SQaC+MOlHgWwkowTcnWRPM1xUUG6UT5auriMsq5sgSKMqUoaHW
	 sk1M/heREmdcg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v2 07/10] ACPI: scan: Do not mark button ACPI devices as
 wakeup-capable
Date: Mon, 15 Dec 2025 15:00:57 +0100
Message-ID: <2891119.BEx9A2HvPv@rafael.j.wysocki>
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

It is generally questionable to mark struct acpi_device "devices" as
wakeup-capable because they represent firmware entities that by
themselves have no wakeup capabilities.

It was done for struct acpi_device "devices" corresponding to buttons
because the ACPI button driver was binding to them directly, but now
that corresponding platform devices are created for the buttons and
they are marked as wakeup-capable by the ACPI button driver, there is
no reason to continue doing it.

Update acpi_wakeup_gpe_init() accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/acpi/scan.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1022,7 +1022,6 @@ static bool acpi_wakeup_gpe_init(struct
 		    wakeup->sleep_state == ACPI_STATE_S5)
 			wakeup->sleep_state = ACPI_STATE_S4;
 		acpi_mark_gpe_for_wake(wakeup->gpe_device, wakeup->gpe_number);
-		device_set_wakeup_capable(&device->dev, true);
 		return true;
 	}
 




