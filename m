Return-Path: <linux-acpi+bounces-9928-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565789E48C6
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 00:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A161880537
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 23:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4BB202C25;
	Wed,  4 Dec 2024 23:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxbhncEl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CFB1865FA;
	Wed,  4 Dec 2024 23:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354736; cv=none; b=iTVA2yY0kYubqFsk1EcLpYhk17/pwr7SpIzoAnGKHOlJ+VdySdXQTSYLH+7PUxINltVAyKyEvnyE4g9qo+ARfyIhtrjqdCkpf7+AjB9Gzcdta7F0qKlwU8rbL3YH2l6sc7tNtA29GWzcXQ1KsSxlg90vl5g3/HoLmc9IMNM35/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354736; c=relaxed/simple;
	bh=7CX7+RtquHhMLh8ioZMQQsMB5i0ZFJfkWzW81P3RcMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YP09GsYP9yvf19BDcGf3vugjbWatLhr456zC2/ueoZXo+05aDF1W4dUEODy6NCYi8yfOJ5OvDiHEpNIZK6Cj58T9zpFLZ0Z9iV2PdgijAS+Fi+6aN7SSFme15IwT0HejzvOWxycz+3vZHezpSmlSFfnz7SbNHpxmvm//3rakcSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxbhncEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6775DC4CECD;
	Wed,  4 Dec 2024 23:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354736;
	bh=7CX7+RtquHhMLh8ioZMQQsMB5i0ZFJfkWzW81P3RcMc=;
	h=From:To:Cc:Subject:Date:From;
	b=sxbhncElkfSOoTHOk53/dDwR8BNdY/QjfZr6Qnyw+58kN+pkiivRkWFoXVPniJnyu
	 j+qznVNq/oJkZsz4wSDIGNGmlLafu1ps3YKP2xcradTDgZ84guAEBqU+7TsCRsAec3
	 EgDxajCAjdXAz2THUxJq+CULaRIfopBF1XkcEyTVlAxDAK6qvkwA9DSuGOHP+7/KxA
	 53Hr/vGIIubSSem6Cz74KyCYZOYCqxqM8oZoBee4TqnG7RqOrLslxhaq6AKhnlvxGy
	 o0CU/NJKEOJbG5Hjof3nVkMXykxGJt5uUgVWZIi6gDgIDfft0EmEsYAVcX42ZH5DdP
	 O6ZxqX/gQiFXw==
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
Subject: [PATCH AUTOSEL 6.12 1/3] ACPI: x86: Add skip i2c clients quirk for Acer Iconia One 8 A1-840
Date: Wed,  4 Dec 2024 17:14:05 -0500
Message-ID: <20241204221416.2247010-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 6af546b21574f..6d185a369f068 100644
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
@@ -411,6 +423,7 @@ static const struct acpi_device_id i2c_acpi_known_good_ids[] = {
 	{ "10EC5640", 0 }, /* RealTek ALC5640 audio codec */
 	{ "10EC5651", 0 }, /* RealTek ALC5651 audio codec */
 	{ "INT33F4", 0 },  /* X-Powers AXP288 PMIC */
+	{ "INT33F5", 0 },  /* TI Dollar Cove PMIC */
 	{ "INT33FD", 0 },  /* Intel Crystal Cove PMIC */
 	{ "INT34D3", 0 },  /* Intel Whiskey Cove PMIC */
 	{ "NPCE69A", 0 },  /* Asus Transformer keyboard dock */
-- 
2.43.0


