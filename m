Return-Path: <linux-acpi+bounces-15482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAF6B19516
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 22:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EE21890065
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 20:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730FF1F5821;
	Sun,  3 Aug 2025 20:04:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26C5173;
	Sun,  3 Aug 2025 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.82.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754251448; cv=none; b=i8QKklzjctomLnQ8cOvaEv076PC0iV1V7yqsnMZOFqVF4dLl+1/mjTZfuktX4zijN3v3y33oSz9eCrcxznAuoWXkmNlvtWw2RMCwTWLAM+PFueS2EkxaFkdSgL3pOKehZC2Wu1Zr8IjOYw88As3S+cOKZ8wZ0TCQaBE+x2iTyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754251448; c=relaxed/simple;
	bh=rhGlweNzP000hWH7t8pE2TgvpLoIWDrUYP0Xjk71t78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGSLTOZF9HpYh1ol6GbViysk3/v/A3sjTQ5lD6DtNoHpIuRIBGg/PKQNrvdiJ7DHrhPmVtl6HI14UIHPNFLOic88OSjHCVVeZ6tnFftsCWPVeZASYCWSzdZIm2/xXjPlHFtglrF0XUgiw7DD+6Vy9FFfi/VapLUf7qK7GvyaJis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=vps-ovh.mhejs.net; arc=none smtp.client-ip=145.239.82.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1uieDx-00000000Mun-2Im5;
	Sun, 03 Aug 2025 21:18:25 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] ACPI: PM: Add power resource init function
Date: Sun,  3 Aug 2025 21:18:11 +0200
Message-ID: <b173a6987f0b35597fd82400cb28f289786e03d0.1754243159.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754243159.git.mail@maciej.szmigiero.name>
References: <cover.1754243159.git.mail@maciej.szmigiero.name>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: mhej@vps-ovh.mhejs.net

This way DMI based quirk matching and quirk flag initialization can be done
just once - in the newly introduced acpi_power_resources_init() function,
which is similar to existing acpi_*_init() functions.

Convert the single already existing DMI match-based quirk in this ACPI
power resource handler ("leave unused power resources on" quirk) to such
one-time initialization in acpi_power_resources_init() function instead of
re-running that DMI match each time acpi_turn_off_unused_power_resources()
gets called.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/acpi/internal.h |  1 +
 drivers/acpi/power.c    | 10 +++++++++-
 drivers/acpi/scan.c     |  1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index e2781864fdce..63354972ab0b 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -140,6 +140,7 @@ int __acpi_device_uevent_modalias(const struct acpi_device *adev,
 /* --------------------------------------------------------------------------
                                   Power Resource
    -------------------------------------------------------------------------- */
+void acpi_power_resources_init(void);
 void acpi_power_resources_list_free(struct list_head *list);
 int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
 				 struct list_head *list);
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index b7243d7563b1..cd9380b1f951 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -63,6 +63,8 @@ struct acpi_power_resource_entry {
 	struct acpi_power_resource *resource;
 };
 
+static bool unused_power_resources_quirk;
+
 static LIST_HEAD(acpi_power_resource_list);
 static DEFINE_MUTEX(power_resource_list_lock);
 
@@ -1046,7 +1048,7 @@ void acpi_turn_off_unused_power_resources(void)
 {
 	struct acpi_power_resource *resource;
 
-	if (dmi_check_system(dmi_leave_unused_power_resources_on))
+	if (unused_power_resources_quirk)
 		return;
 
 	mutex_lock(&power_resource_list_lock);
@@ -1065,3 +1067,9 @@ void acpi_turn_off_unused_power_resources(void)
 
 	mutex_unlock(&power_resource_list_lock);
 }
+
+void __init acpi_power_resources_init(void)
+{
+	unused_power_resources_quirk =
+		dmi_check_system(dmi_leave_unused_power_resources_on);
+}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..bb74e7834435 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2702,6 +2702,7 @@ void __init acpi_scan_init(void)
 	acpi_memory_hotplug_init();
 	acpi_watchdog_init();
 	acpi_pnp_init();
+	acpi_power_resources_init();
 	acpi_int340x_thermal_init();
 	acpi_init_lpit();
 

