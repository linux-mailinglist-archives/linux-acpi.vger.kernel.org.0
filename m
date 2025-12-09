Return-Path: <linux-acpi+bounces-19510-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B73CB023C
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 15:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2141330202FB
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 14:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A8D2C08C4;
	Tue,  9 Dec 2025 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BABQ3aFG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255E627FD54;
	Tue,  9 Dec 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288853; cv=none; b=vAnGWQpJ9anpf2BNih89BCq+asmTORh259HLG5LgCMqPoI9fDp2K+Hm8NQiPJgfeSC/32n6iwg0ZNncv59v3C4uHEfHUU8pX7eSSNKuDSvPvoim0JvQN31SfOddV4cRN0oz7mDqQa0XndhN8kD6AO94GTJbgeQ/M8YZe7xP7v2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288853; c=relaxed/simple;
	bh=3703QhYtIpCzHyGxmzxkvuMzPg+4PJNUfbVV56/WJDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7IOFNk+94tK5xtjJMmIozXlwrvgnQ8srOAIAUm2/Pn908RE2LesfJllYUBUFP19IZutZ4N9zJPggxMeHD4Wu9dV2d3fOjNb9mrmVVUotPEah8Gs0ywwTIX4Q9VkXlylVfJUDnRVDhxEeYuEpofRnR8blFKI842eSuAYuT7g8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BABQ3aFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D4FC19422;
	Tue,  9 Dec 2025 14:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765288852;
	bh=3703QhYtIpCzHyGxmzxkvuMzPg+4PJNUfbVV56/WJDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BABQ3aFGR8qiBGsSoCqe+Y3A9/amtaNUAxWbxz0M+K7EH8EeE6/WFehmNq4vahDn1
	 td8lWK9cH0vmxD/Os79Mh3kVCn+9y/oYirSYFgAo6n+KT4NchshiarNWduaq5MLIDV
	 VSGcWPC4r8eEzD98KMzsuzwQZjtfm3a2peYVsicnqmR+Q8z+AhMnDOwB8RKHFITALZ
	 Sdk9vcsqsVFKdGpR0URcWkl/ABj47f0wDQv1k0XhPR5TlHOvFq3NuwFvbS+5f0q558
	 mQ2IukmQZvbOcthn/2ONqMILvV1PfoxrQDb99xQfCfmHgccaaR9gXjnaTkwgRu9/91
	 ODUcZDMvl/3iw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 07/10] ACPI: scan: Do not mark button ACPI devices as
 wakeup-capable
Date: Tue, 09 Dec 2025 14:56:48 +0100
Message-ID: <3735183.R56niFO833@rafael.j.wysocki>
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
 




