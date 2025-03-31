Return-Path: <linux-acpi+bounces-12571-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5094CA76F93
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 22:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E4F165EB3
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 20:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEB9216E23;
	Mon, 31 Mar 2025 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz7KwoKn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2818C011
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453891; cv=none; b=X4FQCJ4C4zy5ooFsMLEP/e/u5gSSw0vxAvWZZpijc7GWqCSYtCMINmedo7hlKdNXfRqZcwsoSdmdUO8fsWnNt6G/mi4m2s7HJlF+Dcpt7DHRAavXyEuF2YceXAs1/NsosAATX8U+OxyPpnzxsNw87YWkoB3ax2GCxEfirLa+AUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453891; c=relaxed/simple;
	bh=zXFBEefZOO/uZbeYWCOY1k4qwPwe9U/8UBuY46Xd/Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1fCD7MYDBUj2N223CCCkAqupwsjzWxATA/ko6cD4SXU2R+LeiMjA/yMz5lzLqxm8mIhkxj5ZdrihA7Kf6Vjkn0+4rU3slIHDa/tvk+n5IHezZCswgChxA+PdIZQFPwCF2b3l5W9/rZojC7iywT6P2RKPPXyxQWRocV1q0yGiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz7KwoKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161A7C4CEE3;
	Mon, 31 Mar 2025 20:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743453890;
	bh=zXFBEefZOO/uZbeYWCOY1k4qwPwe9U/8UBuY46Xd/Dw=;
	h=From:To:Cc:Subject:Date:From;
	b=pz7KwoKnrAefoBbOig2/5Ut98da5Z137HouQvybYvMJEd1tMWRN53kns57NBnVbO6
	 Pe7TePNvW4V1tVT5sb2WQPQx4lGn5cYXPwZCGHaSvLHHVaXHBPzxTp/Pf+jenDv9cz
	 MSsNcI7zPXiBlRpdv77wZROvsFwzbcg6gYvdTyYgUH+VOMhNQK4UnxY/iN3Szsrcyx
	 WRqDE1lyRZYxUj8s5BUj6A6GPifvFb19vhSH8ok3AlAJkvrVYHSUsKXXLWpD+meAhh
	 5IzPUXrV/WZdsdkfuA+KSW+9BNyYAfSpHRwDoACsd0wjEGNfBXv25pJiGX+GwiLtwk
	 EEbsJyuHxmOlg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org
Cc: Xino JS1 Ni <nijs1@lenovo.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
Date: Mon, 31 Mar 2025 15:44:00 -0500
Message-ID: <20250331204442.1727618-1-superm1@kernel.org>
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

The reason this hapens is that when APU exits HW sleep the power
rails the EC controls will power up the TCON.  The TCON has a
GPIO that will be toggled during this time.  The GPIO is not marked
as a wakeup source however GPIO controller still has an unserviced
interrupt and it will block entering HW sleep again. Clearing the
GPIO doesn't help, the TCON raises it again until it's been initialized
by i2c-hid.

Fixing this would require TCON F/W changes and it's already broken
in the wild on production hardware.

To avoid triggering this issue add a quirk to avoid letting EC wake
up system at all.  The power button still works properly on this system.

Cc: Xino JS1 Ni <nijs1@lenovo.com>
Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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


