Return-Path: <linux-acpi+bounces-13017-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428DFA8832D
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 15:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FAD07A5A56
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 13:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B482F42;
	Mon, 14 Apr 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfh3YekZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804D1119A;
	Mon, 14 Apr 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637415; cv=none; b=iMBktN2V37B8ysUVCM/G3nyC30QYHZdOWlWwi0LlsYdz9/zub1plc7vJvnhRRSALUAUfv92HTNETzFZY4AZB1jTGc/C+ASGjdNuFGbS2uAjIrAGyeoipBKym/CBkAXkhe9FsdwrOGk4mVqlz2/H01esa8qUpniPY216369hxK7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637415; c=relaxed/simple;
	bh=SYEpCqJhf+qnXKLzcyZ8eL2uuTlvZ7stwYCoBtDne/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IOSi8zp9ZxJnWm/c2BoPAAdqhaXFqidQQ//9idsIg0Bm9dCjRcyU2H2zEocM6iIKaqgcuLvvaf6VO8Y42X3xr2DQmdsSBMbBOr4oI0vM1pS8M8A66fMGWBwiNU+6v/VNMDnkbVmRniNmbwcjRGli1wfCtmpbcX8iGJ9HbXuwitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfh3YekZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377A0C4CEEB;
	Mon, 14 Apr 2025 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637415;
	bh=SYEpCqJhf+qnXKLzcyZ8eL2uuTlvZ7stwYCoBtDne/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pfh3YekZmdOVUtbKJRKI/nHO+v46OrgMvc0vtmVSdF/K8/lzmplrWwlsGYF3kigKe
	 DzR//0fmsu+nBfwFln6jIJP0RwRpbh/baWUb42wxRIgsYK+GMhClwuk5ILtYM9ef9U
	 XyHGXjrwUsZouGLoK0rrZjYzTjNVBG9/HFnkQcJYNo0u2csX/R4zkwGy1+a3srByH2
	 Y3ju71tqF0eH/6zJMrA4YYNbL4HN/gypmjXJcGzv103235GEp7nOPb6xXJQRDW/Y1K
	 VRpZZRyWSUDi49y1mXJ46/2qV2KvKhsFougyswDczJ+FnHxFuG976UhEShYYPHDsHl
	 ORKNYMYBt1/lQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/24] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
Date: Mon, 14 Apr 2025 09:29:41 -0400
Message-Id: <20250414132957.680250-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
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
index 115994dfefec1..77d6af6115893 100644
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


