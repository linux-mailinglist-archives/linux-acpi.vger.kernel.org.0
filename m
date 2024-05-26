Return-Path: <linux-acpi+bounces-5980-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135548CF62A
	for <lists+linux-acpi@lfdr.de>; Sun, 26 May 2024 23:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2251C212DA
	for <lists+linux-acpi@lfdr.de>; Sun, 26 May 2024 21:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2555C12AAE0;
	Sun, 26 May 2024 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uPCdcLmE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64101EB3F;
	Sun, 26 May 2024 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716759623; cv=none; b=MBdU1JOGAIdN2FVENIpeJKEMDy0ocpNt7pX1MMPQRRhXGRrTXoneqksPje1HLiXK52eCddWeZbxKeiuCaCNMn4GnqS47urPmn9TueDaLFMr3+AZzrHLlI0JKNJU6RMftPVr2Kteo0Jcf2aRM/Xspg1c8yrWRqP7ocsbmN/ALvN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716759623; c=relaxed/simple;
	bh=EQmU3js+i7J6XMtR1sPBepkOKA2uG18sojoN3Bu3988=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Wq3DHIV/XcmyjH0lQQS95y1p67vrdxPAEVmYczDsSeSVLvmJi1QND80bgp55MPKt+BVJu4Woe+75QkzzqEK4yYEANrUC9vY3bP2iiWOY9dhucdLJ56ehgHd0X66m023L5hz7D0xgRQnXFs4KLzQnKJRwirJtXkWeoQJVkMu9cWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uPCdcLmE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716759617;
	bh=EQmU3js+i7J6XMtR1sPBepkOKA2uG18sojoN3Bu3988=;
	h=From:Date:Subject:To:Cc:From;
	b=uPCdcLmERA64szIvlxaC24kOOSCTJL5W3sFcOEGDWtp41hfHsxnCjePoKUQGD8FkY
	 cOkyuVcJ8VpNz4vibF3nRIv8HMDTCA9uh4Fhi30bsNgQFezDvi3GIphMGLmhrPFccS
	 nu531i26iBay9aX8LMkN/oMu/yCQSSfkRHlKXWkQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 26 May 2024 23:40:01 +0200
Subject: [PATCH] ACPI: AC: Properly notify powermanagement core about
 changes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240526-acpi-ac-changed-v1-1-f4b5997753bb@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIADCsU2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyMz3cTkgkwgoQuRTdFNNLBINrM0MUxMNTVUAuoqKEpNy6wAmxgdW1s
 LAOi3GvxhAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Rajas Paranjpe <paranjperajas@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716759616; l=2189;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=EQmU3js+i7J6XMtR1sPBepkOKA2uG18sojoN3Bu3988=;
 b=j+GJCEXFVOvovJMdyQteps+Udm76p3T99Fm1QXOnLD7X1riMBs6SJH1l7KvCDX7QxLAIDjRtZ
 P6KCe0/kr+aAxkMNg3A5UGDV3056MpnEv+H/aXH/MS8qO809EDsziUX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The powermanagement core does various actions when a powersupply changes.
It calls into notifiers, LED triggers, other power supplies and emits an uevent.

To make sure that all these actions happen properly call power_supply_changed().

Reported-by: Rajas Paranjpe <paranjperajas@gmail.com>
Closes: https://github.com/MrChromebox/firmware/issues/420#issuecomment-2132251318
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/ac.c  | 4 ++--
 drivers/acpi/sbs.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 2d4a35e6dd18..09a87fa222c7 100644
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
index 94e3c000df2e..dc8164b182dc 100644
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

---
base-commit: 6fbf71854e2ddea7c99397772fbbb3783bfe15b5
change-id: 20240526-acpi-ac-changed-a08c6941ae51

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


