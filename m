Return-Path: <linux-acpi+bounces-12588-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2807EA77C56
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 15:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADCC16C761
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 13:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60B31F09B7;
	Tue,  1 Apr 2025 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gro+UBvC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18951F930
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514756; cv=none; b=MEwcIeeTIMeCsbboExFEqmhBcjuVlPX8ud9A9ARqDf/6ZHVA6DHFNoeKRpwwyy8GLTHYHrKQsbYCDuBCAEkpqrVtgXDR0Wce7GgRo1Ah9sO85wmExzEA3CXPHaCd8pyJt3O+6ipefJlfuiRWcCQKyR3sRspyDZD8nzayE1qD0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514756; c=relaxed/simple;
	bh=XR/ECso9SGodXTwdmnRTCXyCx5Qcm80exBN/a/bft5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oy/WVcAULnGI2Q9/eSC2X2YqEokZYjKVYuS3A56HjFQfhDFKFTkngF6Gn5I1P4WBoNSuNkp40MwwrZ3tHR55PpOB6pUMpSuelmT+7a6KC6pX0YAgiCDVWF3gum/LR3L8jaqIlb5ZwDnV1BcifqBMj+2F3qKXNf7YxWThkq5P7kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gro+UBvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4844AC4CEE4;
	Tue,  1 Apr 2025 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743514755;
	bh=XR/ECso9SGodXTwdmnRTCXyCx5Qcm80exBN/a/bft5Q=;
	h=From:To:Cc:Subject:Date:From;
	b=gro+UBvCP/rVZjIAyYA5WG7Y3ytjlheN4v39Yplq5auHcHwmAJ+5n9aFB96FwLu2t
	 nHbLf7j7SKYSVsVPfJuSG1FsOG8n8ag/NpWTV/Mr/ZAA+Wm9XX8K0D7rYRD79c5FYs
	 esI36OWwptB0Gy3hjzoxMNGO4OzTaaofg+7la2XOPdQ4r8VT7AYaCMjEvBTTTQou+8
	 uEPKzm2/HoiCCKAadySDzd7bCXy/7sca/xVZ5yDbR0szIBoewQO1kxLFWgS4YBb5/e
	 okGAALtStV/puxmkCjsiftJ61KlNBKW3DniqkBOHU0vbhEZP9wCGOmr10Y9jXsZIhl
	 ODbtV0MPL1Ebw==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org
Cc: Xino JS1 Ni <nijs1@lenovo.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
Date: Tue,  1 Apr 2025 08:38:51 -0500
Message-ID: <20250401133858.1892077-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When AC adapter is unplugged or plugged in EC wakes from
HW sleep but APU doesn't enter back into HW sleep.

The reason this happens is that when APU exits HW sleep the power rails
the EC controls will power up the TCON.  The TCON has a GPIO that will
be toggled during this time.  The GPIO is not marked as a wakeup source,
however GPIO controller still has an unserviced interrupt. Unserviced
interrupts will block entering HW sleep again. Clearing the GPIO doesn't
help as the TCON continues to assert it until it's been initialized by
i2c-hid.

Fixing this would require TCON F/W changes and it's already broken
in the wild on production hardware.

To avoid triggering this issue add a quirk to avoid letting EC wake
up system at all.  The power button still works properly on this system.

Cc: Xino JS1 Ni <nijs1@lenovo.com>
Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
Link: https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 Add more tags
 Fix a typo and grammar in commit
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
2.43.0


