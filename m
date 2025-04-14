Return-Path: <linux-acpi+bounces-13013-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26AA882B1
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 15:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA713B2289
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 13:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5BB28BAA7;
	Mon, 14 Apr 2025 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B60uMRpz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0470F28A1DF;
	Mon, 14 Apr 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637273; cv=none; b=Plu5t6VrN2RI69JaToG6mZqgV5ET4iywGxZJFZgrbF41b2GAMlukGprSGOlxH/W3/tHh72d/w2QYXyBfKSv9Mtf8+tIDz5KmHtMol3FhqRDVBPEKKccyx2v6D+Q6tCDSHqcelP/+CTTQwVUbHvCniDZhHDVku7lo3xpLCNC2HXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637273; c=relaxed/simple;
	bh=vd38Ub6qMBE2CZLeOopnNEZkiCxPRlFQ9YDitJIBraU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QcFGMz4255d8f0DSBmmX+fKUYi8+Ne4RDNjxq4ObLadsuINCpQMYSs8wFCSopFhDL9qE2XNtVXD+l/mthXO7NRv9kmhHynSgxu3+4kg0J0S1+GiZL0GkTirtpEgy7XRaotEm828UEUx40oGhnZmS+URj+IQqGcOQaeB43ObzWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B60uMRpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF4DC4CEE2;
	Mon, 14 Apr 2025 13:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637272;
	bh=vd38Ub6qMBE2CZLeOopnNEZkiCxPRlFQ9YDitJIBraU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B60uMRpz4QuCjAbr1m+Pjn77/ri94swsDRXI8itQthuT9A78wVwzslvfAHYkxJyfQ
	 h7HVTVjSgQiB/Mo9FBnGX4MD5ctndihKiryR5teKZ18UEtVpLoaFmRUe0973o+xD6l
	 A2NPCChJCMCmijzWg9LXZhTWZ9CtZtPcMYWh9T6iYSsfArfFMc/DNn2qWMKvV8G+c9
	 Jl2w8PzFpTuEiWmz55WS9z3L2aV693mZBp5nhDx4kCcDqP4sScl1X5WFW291iyjqOs
	 ZjXZVL8uHlY/FJkZJ6z7oGTTGYBrEAzbPuGIcR2CSzUKifAI7ASqbvtkrUIxy3Odj5
	 sWg0A+w2hjk1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 11/34] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
Date: Mon, 14 Apr 2025 09:27:05 -0400
Message-Id: <20250414132729.679254-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
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


