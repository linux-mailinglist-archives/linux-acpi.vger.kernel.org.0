Return-Path: <linux-acpi+bounces-9773-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20B29D6F0A
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Nov 2024 13:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860BD1608E7
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Nov 2024 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D121E104A;
	Sun, 24 Nov 2024 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX2mO73I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2B1E103B;
	Sun, 24 Nov 2024 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452354; cv=none; b=qfcTsOq90RugRg7MVdBAWa9AHoPyWSckkRQUv4WK+9T4iIR2OAzI+XeGam3jrDM0r3gtq3oeu1ArODbkbWzgAsZErFkuhaDqL8foyC1NuBZrtZTxuyLT9GxzU+6m5/UOd9SxR6RUzUSOi3J31A4BJp/JxW24KiG3Rlx8UllP/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452354; c=relaxed/simple;
	bh=keFLMy8dXblm7eF3VshvoKpwvmyXhUkAAPQjdHHEDH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeIQ7SOfjIfbkhOIZE4jy50GsJSXHOyGkCAV0WV7F/pS4fvwZaSm/qe8lc1LiJwaJl26lS0sGJkV7+25v9hGRwJHzu1zpTaj51Wnt/eYHDbTisN55KAjNeox9iTLTeE04N2gw59tBQSwSnBNOBCsIEThaz+SeIjcoPcieeh73WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX2mO73I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5EBC4CECC;
	Sun, 24 Nov 2024 12:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452353;
	bh=keFLMy8dXblm7eF3VshvoKpwvmyXhUkAAPQjdHHEDH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EX2mO73Ic6lzMBMoF5fBHh3icwg6HS7lecrUaYZNJq9bdRSzvF2mIllV3Opfs1+dO
	 hd5RPBCG5yAe0zE5zS8LmBdIUQbMwdaV+tIvtaW8P1x2QjvUlqPvp10t6exh9m4wFD
	 SlIK9skxLLg2clSkCs7s1KDgLdIB9099TIYloCWuzXbp7v2rhGSWdWxcIgRls9yHjI
	 UPPN4Kp27ltRq1tVLg363T7cOYNMGEqDVjuLvKV4R64uS/BoY9+fx945I3UbN5d1CR
	 CIWxXOldxuX9mxmhVw7wQIERQLXBkrCZ5SN0ZRhXjkAA/s2bjAPuWWZCAgga9WjXsI
	 bLlhkSyMorKBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	mario.limonciello@amd.com,
	tony.luck@intel.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 3/3] ACPI: x86: Make UART skip quirks work on PCI UARTs without an UID
Date: Sun, 24 Nov 2024 07:45:45 -0500
Message-ID: <20241124124547.3337766-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124547.3337766-1-sashal@kernel.org>
References: <20241124124547.3337766-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 7f261203d7c2e0c06e668b25dfaaee091a79ab25 ]

The Vexia EDU ATLA 10 tablet (9V version) which shipped with Android 4.2
as factory OS has the usual broken DSDT issues for x86 Android tablets.

On top of that this tablet is special because all its LPSS island
peripherals are enumerated as PCI devices rather then as ACPI devices as
they typically are.

For the x86-android-tablets kmod to be able to instantiate a serdev client
for the Bluetooth HCI on this tablet, an ACPI_QUIRK_UART1_SKIP quirk is
necessary.

Modify acpi_dmi_skip_serdev_enumeration() to work with PCI enumerated
UARTs without an UID, such as the UARTs on this tablet.

Also make acpi_dmi_skip_serdev_enumeration() exit early if there are no
quirks, since there is nothing to do then.

And add the necessary quirks for the Vexia EDU ATLA 10 tablet.

This should compile with CONFIG_PCI being unset without issues because
dev_is_pci() is defined as "(false)" then.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20241109215936.83004-1-hdegoede@redhat.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 47 +++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index e035cec614dc8..33d200cfc2fe1 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -12,6 +12,7 @@
 
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
@@ -384,6 +385,19 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
 	},
+	{
+		/* Vexia Edu Atla 10 tablet 9V version */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
+			/* Above strings are too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
+		},
+		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_UART1_SKIP |
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
+					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
+	},
 	{
 		/* Whitelabel (sold as various brands) TM800A550L */
 		.matches = {
@@ -432,18 +446,35 @@ static int acpi_dmi_skip_serdev_enumeration(struct device *controller_parent, bo
 	struct acpi_device *adev = ACPI_COMPANION(controller_parent);
 	const struct dmi_system_id *dmi_id;
 	long quirks = 0;
-	u64 uid;
-	int ret;
+	u64 uid = 0;
 
-	ret = acpi_dev_uid_to_integer(adev, &uid);
-	if (ret)
+	dmi_id = dmi_first_match(acpi_quirk_skip_dmi_ids);
+	if (!dmi_id)
 		return 0;
 
-	dmi_id = dmi_first_match(acpi_quirk_skip_dmi_ids);
-	if (dmi_id)
-		quirks = (unsigned long)dmi_id->driver_data;
+	quirks = (unsigned long)dmi_id->driver_data;
+
+	/* uid is left at 0 on errors and 0 is not a valid UART UID */
+	acpi_dev_uid_to_integer(adev, &uid);
+
+	/* For PCI UARTs without an UID */
+	if (!uid && dev_is_pci(controller_parent)) {
+		struct pci_dev *pdev = to_pci_dev(controller_parent);
+
+		/*
+		 * Devfn values for PCI UARTs on Bay Trail SoCs, which are
+		 * the only devices where this fallback is necessary.
+		 */
+		if (pdev->devfn == PCI_DEVFN(0x1e, 3))
+			uid = 1;
+		else if (pdev->devfn == PCI_DEVFN(0x1e, 4))
+			uid = 2;
+	}
+
+	if (!uid)
+		return 0;
 
-	if (!dev_is_platform(controller_parent)) {
+	if (!dev_is_platform(controller_parent) && !dev_is_pci(controller_parent)) {
 		/* PNP enumerated UARTs */
 		if ((quirks & ACPI_QUIRK_PNP_UART1_SKIP) && uid == 1)
 			*skip = true;
-- 
2.43.0


