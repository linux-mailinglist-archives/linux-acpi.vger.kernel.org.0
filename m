Return-Path: <linux-acpi+bounces-9930-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4647D9E48D0
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 00:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0FE1656FE
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 23:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621C4202C4A;
	Wed,  4 Dec 2024 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlWk10LZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3664F202C42;
	Wed,  4 Dec 2024 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354751; cv=none; b=D/HjV//DH08Lczk3fCgNZthr2zILxogAKENOcO8tG69viIQkMlCXsV2hp5lB394BZKP2NPkNuFocMLyx4q6/oyF/zB9Id3/YjJzHjTPindl47BmXtycEYSeoesVrQcMhTVG9J23J2iHbykIoulcAel9YSmTmvSraJCaU3rExpcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354751; c=relaxed/simple;
	bh=wbjW7TOQmKldoUx4QDOmlk5/g8UbrlxTasBuZO5Qin8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dy8wU5/nnM9vwBd2loE8JWc2MoQa0bhFJWHT+CMv+1W4Z48u5zyFGN/oBdf8yFbQt2qNOSIPijSFMjCwooBIaL0CgGTGf7ODLUCQE8xiYS7/y/oobM1TwhnbF35vMV7XVQkupj0rw6q1V3weTq5RW++QPWVeCV8F4kp99TvnvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlWk10LZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116DFC4CECD;
	Wed,  4 Dec 2024 23:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354751;
	bh=wbjW7TOQmKldoUx4QDOmlk5/g8UbrlxTasBuZO5Qin8=;
	h=From:To:Cc:Subject:Date:From;
	b=UlWk10LZegEB7z+MLLS+QxwfL1BwquwZmksaRRn0FpdL7snUZHqdeusY0GL5Y6OFe
	 qWb2XqPx0pX6BMX0rWOdNLdtqchwrmZ+xjoRiv6wP2zin5KunhHjn0mxkeUolXL3Bw
	 pGDUGIN02HKiwjJxDFMKiR7kHs6Q4Cz5etbNvLOqsJFBLROQgQKUl37gDVaORgeRyZ
	 Wn0AOSCkOHxuxB3Mx+abALd9KDpWJZZqd2ZvakCCB5C1T92K4QowM+Q7Yd38gLhIYW
	 PbsJeX/I0+bpYweMc0+p12tMMCuNQRriORc6FBUZKGPDUuiw1VAdFaNIJZw7JN7fk4
	 8ynIzl/0MT8Sg==
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
Subject: [PATCH AUTOSEL 6.11 1/3] ACPI: x86: Add skip i2c clients quirk for Acer Iconia One 8 A1-840
Date: Wed,  4 Dec 2024 17:14:23 -0500
Message-ID: <20241204221431.2247102-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index ab2b5fa83e1ff..24af6a10cc5fc 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -307,6 +307,18 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
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
@@ -412,6 +424,7 @@ static const struct acpi_device_id i2c_acpi_known_good_ids[] = {
 	{ "10EC5640", 0 }, /* RealTek ALC5640 audio codec */
 	{ "10EC5651", 0 }, /* RealTek ALC5651 audio codec */
 	{ "INT33F4", 0 },  /* X-Powers AXP288 PMIC */
+	{ "INT33F5", 0 },  /* TI Dollar Cove PMIC */
 	{ "INT33FD", 0 },  /* Intel Crystal Cove PMIC */
 	{ "INT34D3", 0 },  /* Intel Whiskey Cove PMIC */
 	{ "NPCE69A", 0 },  /* Asus Transformer keyboard dock */
-- 
2.43.0


