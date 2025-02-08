Return-Path: <linux-acpi+bounces-10951-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13D3A2D741
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 17:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D439A3A74E2
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D481F30AB;
	Sat,  8 Feb 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtOJOJxW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9C51F30A7;
	Sat,  8 Feb 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739031744; cv=none; b=TRm00KOFv5L10D+W2l7zuM7dQ84PnXEmUuM4uiwWr8Hy82fANDkjaRRx0ivzJNjOegS7S/F2o7OBOWSBGwdYhksidTuDTWtDKjb2Tl3h7T/My1UZJPdxpwPryyJjOIH+MiybznFACPFlLLabGYcKKwI9cov/ETt6E26ymjbOYec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739031744; c=relaxed/simple;
	bh=2muv5zYZh0Q7pJ4CtFm/oFMjCjpUR5zI+SSHfjKgps8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxAEAP/lJbrFpp5IWclsOB2p8f8V/ht03DloOqHTUfrtDohSCinEPlhay3JYKT/+tzqfiEY9vOZzs3/TCGZkXdGpuvR8nKgpAEWAM+T3sNTzTpE/XLk70XOOprDls1crUVb1HbZqI1i0Xqs5Fcv5q5WvjAHwW5j+XS7BfS0vcHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtOJOJxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6404DC4CEDF;
	Sat,  8 Feb 2025 16:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739031744;
	bh=2muv5zYZh0Q7pJ4CtFm/oFMjCjpUR5zI+SSHfjKgps8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mtOJOJxWWiYxmz5hPJMGzmHOJTBEfymdb/XRRJCz405p9xuQrtStRa2wEd8pyqiGt
	 lNAqkQxhTFUOqhky6LhDIbDaFUf5+NdkC0i73QkThglGqTVawnURchxIT4BKgyzrc5
	 dsCLzy023SGFETefQeL6u5xjRNL8LOhYb/VH3Ypq4ASKL3PTOT66GRdxC3hfLm4duk
	 o3MOvCxi9JzvUDIYnKrIFiVChhooOdrpZbbNkEOwkmVvzJ22epO8gY9R7qjSzXL7rj
	 Da6SSWcPqcC0MFXeeAEIHNg7gSQ+RtJbsVDy2eqht7rsJxhIsz6r09uC8Erv68BcqE
	 IbshK2Rm4pZsw==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/4] ACPI: battery: Refactor wakeup reasons in acpi_battery_update()
Date: Sat,  8 Feb 2025 10:22:09 -0600
Message-ID: <20250208162210.3929473-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208162210.3929473-1-superm1@kernel.org>
References: <20250208162210.3929473-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Another reason to wake is to be introduced, so refactor the code
to make it easier to follow. Also introduce PM debug messages so
that it's more obvious when these wake events have occurred.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/battery.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index f21bfd02a26d1..72c8a509695e6 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -999,6 +999,22 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
 	}
 }
 
+static inline bool acpi_battery_should_wake(struct acpi_battery *battery)
+{
+	if (battery->state & ACPI_BATTERY_STATE_CRITICAL) {
+		pm_pr_dbg("Waking due critical battery level");
+		return true;
+	}
+
+	if (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
+	    battery->capacity_now <= battery->alarm) {
+		pm_pr_dbg("Waking due to battery alarm");
+		return true;
+	}
+
+	return false;
+}
+
 static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 {
 	int result = acpi_battery_get_status(battery);
@@ -1038,13 +1054,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 		return 0;
 	}
 
-	/*
-	 * Wakeup the system if battery is critical low
-	 * or lower than the alarm level
-	 */
-	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
-	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
-	     (battery->capacity_now <= battery->alarm)))
+	if (acpi_battery_should_wake(battery))
 		acpi_pm_wakeup_event(&battery->device->dev);
 
 	return result;
-- 
2.43.0


