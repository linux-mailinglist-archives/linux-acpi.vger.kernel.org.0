Return-Path: <linux-acpi+bounces-6480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E568290CBEA
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 14:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049F11C23D5E
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DB01514DD;
	Tue, 18 Jun 2024 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTe1w6Ad"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE751534E9;
	Tue, 18 Jun 2024 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714195; cv=none; b=CuYH57mXZZ1BNFz0EgE4X/K9VwTVoo8gZrOBSKbsAZkrTS+3PTTy1RknVOXwsNdRht3SR27ghNFwBv+RnaBnLuHe9PZUkcE+u+oajgq1lIwhuXz690aeXohizxICURO2jTAZ5S/gh91zfvNUaUt6EezoCxLtF/PueO5F0bYMRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714195; c=relaxed/simple;
	bh=oeoJwNKvryvK/Lmdw9qzBXq4NmsphNr/T/hF0R+fjTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEdQY73qEX33Gwxd1WryGQnfmQbm97lyEBWaJA61XPjY7B+tZibaLIo826ATL86/oPf+fT6Lx0JP4QTfj1/qDxiY7C6PylVyBAFyHo8HjgTbjvxmE9Dt1uVZC6i4H9DikpAfh/ZRQNLmWe5TvULbecMVxR9XHiQhfAoXy+c6mlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTe1w6Ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A14C32786;
	Tue, 18 Jun 2024 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714195;
	bh=oeoJwNKvryvK/Lmdw9qzBXq4NmsphNr/T/hF0R+fjTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTe1w6Ad9pk3uSb96uxUuCgBhCsqd8grx7+cj7CYJDscx7S4/cd5Eu19WZtl2MWj+
	 o0ix9iHTr7zywgDQntXsnb2Y5x3A/5GFqXEYntsBVKWUwsThf0gHeKssFkLYxPAwxv
	 FAuK1814KGNfnjVd+XgrFkj/d9CNIl4yOpviPDlPOKV3rEXLB5dP6TW29h2wIT4C0p
	 KeU3RAxjL7t2TVbfl0ctwpIuoyl2WoYfYkr6HnihNeVRe1GIDyn7NfQStpfTf4052R
	 7gxvyr0Pw+zDdH/tFERuVF/xWP+Hn151KXaSA5ApWvyZzBl5sR0Vwks7oqQdtvGg/s
	 QHQA+yY0gvsaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Rajas Paranjpe <paranjperajas@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 13/44] ACPI: AC: Properly notify powermanagement core about changes
Date: Tue, 18 Jun 2024 08:34:54 -0400
Message-ID: <20240618123611.3301370-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit ac62f52138f752d6c74adc6321e4996d84caf5bb ]

The powermanagement core does various actions when a powersupply changes.
It calls into notifiers, LED triggers, other power supplies and emits an uevent.

To make sure that all these actions happen properly call power_supply_changed().

Reported-by: Rajas Paranjpe <paranjperajas@gmail.com>
Closes: https://github.com/MrChromebox/firmware/issues/420#issuecomment-2132251318
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ac.c  | 4 ++--
 drivers/acpi/sbs.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 2d4a35e6dd18d..09a87fa222c78 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -145,7 +145,7 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 						  dev_name(&adev->dev), event,
 						  (u32) ac->state);
 		acpi_notifier_call_chain(adev, event, (u32) ac->state);
-		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
+		power_supply_changed(ac->charger);
 	}
 }
 
@@ -268,7 +268,7 @@ static int acpi_ac_resume(struct device *dev)
 	if (acpi_ac_get_state(ac))
 		return 0;
 	if (old_state != ac->state)
-		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
+		power_supply_changed(ac->charger);
 
 	return 0;
 }
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 94e3c000df2e1..dc8164b182dcc 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -610,7 +610,7 @@ static void acpi_sbs_callback(void *context)
 	if (sbs->charger_exists) {
 		acpi_ac_get_present(sbs);
 		if (sbs->charger_present != saved_charger_state)
-			kobject_uevent(&sbs->charger->dev.kobj, KOBJ_CHANGE);
+			power_supply_changed(sbs->charger);
 	}
 
 	if (sbs->manager_present) {
@@ -622,7 +622,7 @@ static void acpi_sbs_callback(void *context)
 			acpi_battery_read(bat);
 			if (saved_battery_state == bat->present)
 				continue;
-			kobject_uevent(&bat->bat->dev.kobj, KOBJ_CHANGE);
+			power_supply_changed(bat->bat);
 		}
 	}
 }
-- 
2.43.0


