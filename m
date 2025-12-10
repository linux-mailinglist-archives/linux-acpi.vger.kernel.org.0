Return-Path: <linux-acpi+bounces-19534-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A325CB3317
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 15:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E2853086946
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BDD22B8CB;
	Wed, 10 Dec 2025 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+1H7TRp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B931E3DED;
	Wed, 10 Dec 2025 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377890; cv=none; b=sX5dYOeHToGUtyVjTgS+H0Ac6YAdrU2bC783DkqtL30Ums27a59aqFcuLF6ZLGB678h7FCygryc0TjF9vUZ4OaXSod0cnnNwOoXl4+3t5OBoIknPVp49BV5eJhTaBfvDPV34CJCplooUgeKq9w/EY7R/tBT0FOsvl+8fe6VXQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377890; c=relaxed/simple;
	bh=lclP0B6ekiVqLRJJeT9rJq0I81n72hlM4fGYO32JC9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ug2YB6X9Hi4ht/xZBnercf/PZNlWvOoEF3vFn1cHzgWLLfNK8B/G8ZpAeU8wtdhfQNjIu8EuT+tHCHYsg5TNzI0Qv5Nqht2R8bbp+P/Xe8ueJ+uZ6fS6DeMmZ0wuMMT0rSJLDKIRgPDbZ6vWfAdfgt9RoMOIYpUymp2kPbFX4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+1H7TRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9355DC4CEF1;
	Wed, 10 Dec 2025 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765377888;
	bh=lclP0B6ekiVqLRJJeT9rJq0I81n72hlM4fGYO32JC9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+1H7TRpNKqEgDbTaEoKXSUDGxSqTuEuJasRxfPqYBvNhbU52dPhDXLSAaNfmbh0D
	 uBXsAFrxunS4QY7Xqwic1hcTDNUvGoHzd0KioOu76i1BYsbd+b46zHldSygxnVJ+5C
	 f0T/HbjI5lj5CtOFdE9B85xIKnjziJGu/6OIz5heEEgOjKJhOSkh7QCoURZNjyBpjJ
	 WBagxBjCKpntjS+qKe3bYQsGAKIS2l1ccw8DUUWgO2QtxPlRBWGssuU8e2jilsp/31
	 vc+6qwDPzSZi6rcYmbK3/2oX2Y6uPKyL0DDJ+hwCEjOE1jE+T4HYox1rus8YyU5l6E
	 XYczsfi/pzVJw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1 4/4] ACPI: thermal: Rework system suspend and resume handling
Date: Wed, 10 Dec 2025 15:44:30 +0100
Message-ID: <3024049.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6222428.lOV4Wx5bFT@rafael.j.wysocki>
References: <6222428.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In the process of handling system resume, acpi_thermal_resume() attempts
to power up active cooling devices to guarantee that they will be
operational when the ACPI thermal check queued by it runs.  However,
the only kind of cooling devices that can be bound to ACPI thermal zones
is fans and they are already powered up by the ACPI fan driver resume,
which additionally takes "ACPI 4" fans that don't need to be powered
up into account.

For this reason, remove the part of acpi_thermal_resume() related to
fans and in order to ensure that it will run after powering up all fans,
rename it to acpi_thermal_complete() and point the .complete() driver
callback to it.  Analogously, rename acpi_thermal_suspend() to
acpi_thermal_prepare() and point the .prepare() driver callback to it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -911,37 +911,26 @@ static void acpi_thermal_remove(struct p
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int acpi_thermal_suspend(struct device *dev)
+static int acpi_thermal_prepare(struct device *dev)
 {
 	/* Make sure the previously queued thermal check work has been done */
 	flush_workqueue(acpi_thermal_pm_queue);
 	return 0;
 }
 
-static int acpi_thermal_resume(struct device *dev)
+static void acpi_thermal_complete(struct device *dev)
 {
-	struct acpi_thermal *tz = dev_get_drvdata(dev);
-	int i, j;
-
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		struct acpi_thermal_trip *acpi_trip = &tz->trips.active[i].trip;
-
-		if (!acpi_thermal_trip_valid(acpi_trip))
-			break;
-
-		for (j = 0; j < acpi_trip->devices.count; j++)
-			acpi_bus_update_power(acpi_trip->devices.handles[j], NULL);
-	}
-
-	acpi_queue_thermal_check(tz);
-
-	return AE_OK;
+	acpi_queue_thermal_check(dev_get_drvdata(dev));
 }
-#else
-#define acpi_thermal_suspend	NULL
-#define acpi_thermal_resume	NULL
-#endif
-static SIMPLE_DEV_PM_OPS(acpi_thermal_pm, acpi_thermal_suspend, acpi_thermal_resume);
+
+static const struct dev_pm_ops acpi_thermal_pm_ops = {
+	.prepare = acpi_thermal_prepare,
+	.complete = acpi_thermal_complete,
+};
+#define ACPI_THERMAL_PM	&acpi_thermal_pm_ops
+#else /* !CONFIG_PM_SLEEP */
+#define ACPI_THERMAL_PM	NULL
+#endif /* CONFIG_PM_SLEEP */
 
 static const struct acpi_device_id  thermal_device_ids[] = {
 	{ACPI_THERMAL_HID, 0},
@@ -955,7 +944,7 @@ static struct platform_driver acpi_therm
 	.driver = {
 		.name = "acpi-thermal",
 		.acpi_match_table = thermal_device_ids,
-		.pm = &acpi_thermal_pm,
+		.pm = ACPI_THERMAL_PM,
 	},
 };
 




