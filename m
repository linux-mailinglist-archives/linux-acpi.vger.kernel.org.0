Return-Path: <linux-acpi+bounces-9932-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601B09E48DD
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 00:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C04318812D2
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 23:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A82066D3;
	Wed,  4 Dec 2024 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZK2vEKs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50718202C35;
	Wed,  4 Dec 2024 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354767; cv=none; b=BLBBiTKo51r+d6jtmltpdk0DpRMOT2Gpq/niT850y+DTZh3GY0y5TwJ/umSSv9hmhOpfJL9QutMVVUjgaEXJzJ1cs8rRXtG84zJOJXU0kzX4QlzAdCfcUz1gk6zrLTxgChJp5pve5POGWnBAaTLcIlKzXlAsqNea9RSOWul+EBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354767; c=relaxed/simple;
	bh=gprUZ0/ApwnNfyPVB8OTQESZC7OYFeLCjA1Mz1mNCeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B3dfTWRzyi5eVWXwbwn3D+gLx2KuunjoDBqJwaAFhPtwaP5K/Ldvs6HHzykKhBm4Ex2x8rq9CP0YxEbZcTYU+20R09PWo50E9p5GDwdW98cv8E0WKT83PXvbeICdyuNcjwftIdrR9nQvrf4ju6VAt5frGn3gU+0pIV+TGLZizSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZK2vEKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FFAC4CED2;
	Wed,  4 Dec 2024 23:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354765;
	bh=gprUZ0/ApwnNfyPVB8OTQESZC7OYFeLCjA1Mz1mNCeQ=;
	h=From:To:Cc:Subject:Date:From;
	b=IZK2vEKsXIGJr2jT6ZRJk0YkidmPdl5nK2ie4VrGWaxp5W9B5fZzf6rVbyTF6Vivd
	 hZH6s8spnp0Ot+J/0vAL+xJ/9xoqQ78/aEGDwU5QLTNu4bgxPXDsUcyfa1U8FD9wAZ
	 Q7vDeUHRNGRab0Amw4SlpjWEf7e/0IGvLA/l5yNYygA2LgbvSQL3ywHte4MnjgnO63
	 6fwX7RfzjwRWIcdWewPp6ORJoZUDtnoDvleQvDiS62g7xzMU172z03HMJjYHFEtbu8
	 VK6K7hN79tNUJo70983xHrvCcxhQ48ZFa37y7jouM4C9dWLWCZqdczGJ5p06EJ/SeX
	 Sr4ropXmp4vyw==
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
Subject: [PATCH AUTOSEL 6.6 1/3] ACPI: x86: Add skip i2c clients quirk for Acer Iconia One 8 A1-840
Date: Wed,  4 Dec 2024 17:14:37 -0500
Message-ID: <20241204221445.2247192-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
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

[ Upstream commit 82f250ed1a1dcde0ad2a1513f85af7f9514635e8 ]

The Acer Iconia One 8 A1-840 (not to be confused with the A1-840FHD which
is a different model) ships with Android 4.4 as factory OS and has the
usual broken DSDT issues for x86 Android tablets.

Add quirks to skip ACPI I2C client enumeration and disable ACPI battery/AC
and ACPI GPIO event handlers.

Also add the "INT33F5" HID for the TI PMIC used on this tablet to the list
of HIDs for which not to skip i2c_client instantiation, since we do want
an ACPI instantiated i2c_client for the PMIC.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20241116095825.11660-1-hdegoede@redhat.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index e035cec614dc8..159ac2b19672d 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -299,6 +299,18 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
+	{
+		/* Acer Iconia One 8 A1-840 (non FHD version) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BayTrail"),
+			/* Above strings are too generic also match BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "04/01/2014"),
+		},
+		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
+					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
@@ -404,6 +416,7 @@ static const struct acpi_device_id i2c_acpi_known_good_ids[] = {
 	{ "10EC5640", 0 }, /* RealTek ALC5640 audio codec */
 	{ "10EC5651", 0 }, /* RealTek ALC5651 audio codec */
 	{ "INT33F4", 0 },  /* X-Powers AXP288 PMIC */
+	{ "INT33F5", 0 },  /* TI Dollar Cove PMIC */
 	{ "INT33FD", 0 },  /* Intel Crystal Cove PMIC */
 	{ "INT34D3", 0 },  /* Intel Whiskey Cove PMIC */
 	{ "NPCE69A", 0 },  /* Asus Transformer keyboard dock */
-- 
2.43.0


