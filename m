Return-Path: <linux-acpi+bounces-13011-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFE1A8822D
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 15:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2481F17AD0F
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 13:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404BB253924;
	Mon, 14 Apr 2025 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AitgAOp3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB6E2522BA;
	Mon, 14 Apr 2025 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637195; cv=none; b=t8L8m3mdR08KJkXVBLg1+2WRYzASMdmLv0tzyo/KIW8hPbhHZ6I/Jri0vP3aVeicCYYq4DhbCrCxLURJuaf15gOAXewSYf2dLx3uR8ZBqv6bH2VPueKCI7NNc5Yp/U8Ed8xKEuB95KNjMkFSxwxf46XT4CGA0ISmTO8O4nHbEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637195; c=relaxed/simple;
	bh=vd38Ub6qMBE2CZLeOopnNEZkiCxPRlFQ9YDitJIBraU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhEEhL1PDyUcEBf6VlPtOqT5cVnaP+VJjiRAXfcLnEcOVtLlcRVcbsPZkAigTbdCiGhQtuEIcujWvCng2lbSo44j5hCD0471laMFFLDBQz3iwFmlEaxs/d3qixJsKnARVn4jKwIGQD8tkTzSRsuf+OWdiUnUoCw05vePie37NKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AitgAOp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3153FC4CEE2;
	Mon, 14 Apr 2025 13:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637194;
	bh=vd38Ub6qMBE2CZLeOopnNEZkiCxPRlFQ9YDitJIBraU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AitgAOp3KBDFc7bhKGCWn3dy7y/wFmRDO2RWT/x3Wxvm70qnG3amx6YNl6qSzmkJf
	 C9kYbvxNk1cR3TgSMAWP8XLZtszEhLXVvu2+YoFimd3WisHtYUJe+BL1RdNLe3FEIJ
	 GkG6uokU+8YmEeqE1bW5EoYoELpGoXgirmfygAJ/7C3GB8nEzEC75XjqRzhwgsV7bA
	 o/j1Y1UADl5a2IYD/ZPQKToKrDwR8OEjY5OoT2RJ0yzoCY7cEudsFMAr4pDjmsKiEw
	 7TWRaaJdloYvdsxbj+IeWWLWff/hFmTS0mIdHuEo9GUKGhzTM2kDLZXBjazfluOeFk
	 Ufwnn7+4GSb4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 11/34] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
Date: Mon, 14 Apr 2025 09:25:47 -0400
Message-Id: <20250414132610.677644-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
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
index 8db09d81918fb..3c5f34892734e 100644
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


