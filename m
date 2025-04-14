Return-Path: <linux-acpi+bounces-13015-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB34A88315
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 15:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B1A3B9888
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 13:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76289296D25;
	Mon, 14 Apr 2025 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbwcYbcw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38027E1D7;
	Mon, 14 Apr 2025 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637346; cv=none; b=ONkr2UkLGZLZXhJJiJLJUKWVX5lDmppI5Dis7JsbmMRebvD2QgFeRH8ojj5gbZfByVNGI1hJb2NKLqFHHEYHMYbVqLYLHn4FYs+/gDRcCHTs4SbLfUEriC4WDIdeY7GwABbXP64gL5bbHhAYmEAkJvN0i8oSggKFVp0L0C7xENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637346; c=relaxed/simple;
	bh=MUoHO6xTlOphEBjyq/fAO4kvHVZoPm1G4R+C3nskCfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2bgumaHlls0iHChqHbeL0mjCgPWIxoUisnv/ANFzUFiSFVYUHkkuXwEJLqYRAK6nf3m2u1VCv6NrGYPxxga7Rmf6Rkd+YrUZ5xLFrIQvqSQwk2T6f/ig5DPy1vpXe7msHm4R4meLKduQFTLbiB6r6lGnO6psBuakWJaon6V4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbwcYbcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BA0C4CEE2;
	Mon, 14 Apr 2025 13:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637345;
	bh=MUoHO6xTlOphEBjyq/fAO4kvHVZoPm1G4R+C3nskCfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbwcYbcwkm4KRI0OyJBFMY+JjIKWEa7Gkm5ae7/D8oKgNIKNPDBxrCPwYoHTy9U9d
	 /YVxD4vKtZxrjvXIbvU3DqbZPi574g305HkMKV4Fmv1XLPbOhr/t4GyyRqmzCEP8xw
	 VaiJPjs/Zf5VNKnmTPluW2BEVpcqxuoX9ala4XMiJ6iJelIbvawlm+SYxmb8UdPihH
	 0lscavCvRir2307x1y6Nt5r8cjvqxf0Wh7qNffCfZxbNBdmRsorQ3mcHFHfGi/92xY
	 t7Pvf90nX+t0ux3xxZfQOJK9ytlN9vodrluEh1uritKFCAGp/9u4SGAKdcYKcjnBVj
	 IGDMHoereOsJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 08/30] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
Date: Mon, 14 Apr 2025 09:28:25 -0400
Message-Id: <20250414132848.679855-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132848.679855-1-sashal@kernel.org>
References: <20250414132848.679855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.23
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit b988685388effd648150aab272533f833a2a70f0 ]

When AC adapter is unplugged or plugged in EC wakes from HW sleep but
APU doesn't enter back into HW sleep.

The reason this happens is that, when the APU exits HW sleep, the power
rails controlled by the EC will power up the TCON.  The TCON has a GPIO
that will be toggled at this time.  The GPIO is not marked as a wakeup
source, but the GPIO controller still has an unserviced interrupt.
Unserviced interrupts will block entering HW sleep again. Clearing the
GPIO doesn't help as the TCON continues to assert it until it's been
initialized by i2c-hid.

Fixing this would require TCON F/W changes and it's already broken in
the wild on production hardware.

To avoid triggering this issue add a quirk to avoid letting EC wake
up system at all.  The power button still works properly on this system.

Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
Link: https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20250401133858.1892077-1-superm1@kernel.org
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 25399f6dde7e2..e614e4bef9ea1 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
 		},
 	},
+	/*
+	 * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up from EC
+	 * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
+		}
+	},
 	{ },
 };
 
-- 
2.39.5


