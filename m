Return-Path: <linux-acpi+bounces-6451-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D46590AF42
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 15:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C28288D62
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 13:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05E419EEAF;
	Mon, 17 Jun 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMz0sBN2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66C119FA99;
	Mon, 17 Jun 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630470; cv=none; b=SwujxhTkNsmwd+MGSbO/WScR2Hs1ZkURXcT09iBqHlzxCQGlVI5ln1SELAvKIrI54vMlBfp6Z6WY28J+V4OhF5l18DDyNs6Pn7o+/Sk+154xBFwhvFUE+gEmMqpaSJkIu8G7XtwV9Q8GB3+5TfcQ520uHJK3kaRnhUqK5fzHIr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630470; c=relaxed/simple;
	bh=oeoJwNKvryvK/Lmdw9qzBXq4NmsphNr/T/hF0R+fjTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0ODZ4p0TGTjdK10hRTNiwd6EL1pdGPHkg/n4UOmfqOGV8Deqrs/RxW/zg//7/0kYIVXZ/GVzfwaDDm+5L8jbU04DPiyIClBzxiU4fTjkf0z3mfwWnTAGwNAWirsRoCqu8cTW8YAQd7IIvCqEQdJjtJMoS1Uh9SfGnrRWydHUD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMz0sBN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C370C4AF49;
	Mon, 17 Jun 2024 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630470;
	bh=oeoJwNKvryvK/Lmdw9qzBXq4NmsphNr/T/hF0R+fjTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EMz0sBN2Sfd355NB7vWdZnfKVhY/CnUMIpVEZ7bCLwHnS4wu3+Iuerf4hlJgoD1Ox
	 FhnadA8g+b4f82/cen23meO+7ymgC7KwruxQqfhbXaSwXIoUVc+UiLd/NOHRA9ZS6E
	 uNLOf4/UZQwHuMuV4EEIFAF2PlBZJf2wCH9WPKyGyqDoul2ddimod5dUAL7n+0GbjF
	 YkLbKO60zxirQCa2dyleribnluKcDJA+30GEQL2b0UZ7P10BLCGJljQDaDcRYlXIyW
	 UZtjSej+122kCYQHU6C3d7tUs89IDh1gXs8vYF50AD4nLHLjtLt42aWTBWpvu2yBEA
	 51nwyZuyX09ZQ==
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
Date: Mon, 17 Jun 2024 09:19:26 -0400
Message-ID: <20240617132046.2587008-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
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


