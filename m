Return-Path: <linux-acpi+bounces-10885-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12EA26980
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 02:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008773A60FF
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 01:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B845212D93;
	Tue,  4 Feb 2025 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihAlvPwE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA24212B32;
	Tue,  4 Feb 2025 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631825; cv=none; b=q7Akf/8a2c6pxuLRz4IESjg6DDE/D4ykMDBTMR5duOKvbGXhXxNBYjlI4e52jPL0hjBqw3nc5sQDE0+0YOgWFk8Ur2EgGXtMA0orA6feeiiA6Aiwgeo9Xp+ru9OsGuNB8C+ErTF2E6XghAfZOKSBR5Oidc2tEAQEiAJrs3VhfYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631825; c=relaxed/simple;
	bh=sd2+t52y6ShnV/RE6H7CCAIDKuomPgdP25R1A2pvZLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQMHCBHiNkoScLHGcAyp9q5r9H2h19sp8SPtvtyCZHdOqkCmciSVTGBLWX3WCjEwtY7AAnqutBSv50t3lHh319tH2xk1sDOUVlWY/sJRV6w1W5hjwuqBNIOkMIvMa8MOw1HKfGZtCeNfQiAVnE5T9ySDVvPVLe+OsgwZCFJ26QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihAlvPwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281F9C4CEE7;
	Tue,  4 Feb 2025 01:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738631825;
	bh=sd2+t52y6ShnV/RE6H7CCAIDKuomPgdP25R1A2pvZLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihAlvPwEFHbBkJ5Ui/G8PXGymw6Onk+3+/QIQ1Uz+l6nhjjzfYm+ELN/qaw3+aJJz
	 OV3BfhKYEXIIXxdMI8Z4/KRFBwZ+9vxMrF2ZEcO1WtobyvGTh62OpO7wMBE7OQovVF
	 Ptyyg4gBaJxn+wK+w7em+AVx9NUFRgapBo5qmmVqAuf8NhMhQkSiPFSA2p+8HrsLaM
	 z0ScqKFSb3r/QVXTpTTBMpAF1YHa4edF+9gIGztgh/pTGB6Hh9/BM+ffLPuBIstjA0
	 a2J/5qMWmWV+I3OnBPCPcAXvudXO+9zHtFVnF/sB91pmmUVRAX1TSRqsWkRyBQ0ZkT
	 XO1CnddJffNZQ==
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
Subject: [PATCH AUTOSEL 6.6 3/3] ACPI: x86: Add skip i2c clients quirk for Vexia EDU ATLA 10 tablet 5V
Date: Mon,  3 Feb 2025 20:16:54 -0500
Message-Id: <20250204011654.2206481-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250204011654.2206481-1-sashal@kernel.org>
References: <20250204011654.2206481-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.75
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 8f62ca9c338aae4f73e9ce0221c3d4668359ddd8 ]

The Vexia EDU ATLA 10 tablet comes in 2 different versions with
significantly different mainboards. The only outward difference is that
the charging barrel on one is marked 5V and the other is marked 9V.

Both ship with Android 4.4 as factory OS and have the usual broken DSDT
issues for x86 Android tablets.

Add a quirk to skip ACPI I2C client enumeration for the 5V version to
complement the existing quirk for the 9V version.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20250123132202.18209-1-hdegoede@redhat.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index fdfc88e09986e..e894fdf6d5531 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -400,6 +400,19 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
 	},
+	{
+		/* Vexia Edu Atla 10 tablet 5V version */
+		.matches = {
+			/* Having all 3 of these not set is somewhat unique */
+			DMI_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_BOARD_NAME, "To be filled by O.E.M."),
+			/* Above strings are too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "05/14/2015"),
+		},
+		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
+	},
 	{
 		/* Vexia Edu Atla 10 tablet 9V version */
 		.matches = {
-- 
2.39.5


