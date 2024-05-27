Return-Path: <linux-acpi+bounces-6000-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6C98D03E7
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 16:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A21B23032
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF00190667;
	Mon, 27 May 2024 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEQ2q4+v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD516C861;
	Mon, 27 May 2024 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819378; cv=none; b=X+ttLvDglVoDy7OeBW0D8MoIRTVa/a0zRu4ezFj64mb2l7Q7UGpk0GXLjKF2gPO3Q9KCEz/jcltaqnQdPlkGYOitXI7jH3G5pE4Rmh+ZgVLi5XWsHjTgrhlj4GsoxQ4Y+5oDx1Chpsdc5lscHUVC1YkDbFwdeaQGn5AfTEi6CN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819378; c=relaxed/simple;
	bh=r1ZavXw/PgJLOPqEk12b3H0V3a/cJBxHeS5bWGKmWFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QntX4WVEffwSgVGdq0g6IjFOYgy5nDYCnpbv2LcLFoZx81tEVjnGgxYtt1HcEu/VVoiR4ZjzptVeFfCohkQb7ytOOC/KdQ3rZNM5ChUYq5OzlF0MxBo1ssgC077ULR+D+em+cncdauo5dxNsw89FC2qs+n2RD/ie9Qrp+FBceok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEQ2q4+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB89C32789;
	Mon, 27 May 2024 14:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819377;
	bh=r1ZavXw/PgJLOPqEk12b3H0V3a/cJBxHeS5bWGKmWFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LEQ2q4+vqu63jG9FFDbSToBGHBjLhR9K0MZ36uIwSk/mYo/mgHnpvYY0JOpK+kN+C
	 k87qDetc74ScsmzCAnp0w1ZbCJ8kFF9TZAtskhmLCMTQBx0PbcdRYMHCtCzEMxvlWb
	 Xh3uNssdDGYDRNeD8yFkuXN2G31q+Ef8TPJXhByCDkohb4rvuoXuM7nz63W/11op1R
	 ErJZn1NKB8WH5pUgQr2y7Jfs1rBXOMNLRevlsbL7qCLEgybjjsWcMqNRt83fwgTaRV
	 mzvdAyISmII2fES5v/20WInmmPczk7P7QP/RGJySjB86DszWGXgd1/WQ4AIu9vVKXz
	 I+CM3I+K62CiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	raag.jadav@intel.com,
	mika.westerberg@linux.intel.com,
	michal.wilczynski@intel.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/21] ACPI: x86: Add PNP_UART1_SKIP quirk for Lenovo Blade2 tablets
Date: Mon, 27 May 2024 10:15:18 -0400
Message-ID: <20240527141551.3853516-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141551.3853516-1-sashal@kernel.org>
References: <20240527141551.3853516-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit d8f20383a2fc3a3844b08a4999cf0e81164a0e56 ]

The x86 Android tablets on which quirks to skip looking for a matching
UartSerialBus resource and instead unconditionally create a serial bus
device (serdev) are necessary there are 2 sorts of serialports:

ACPI enumerated highspeed designware UARTs, these are the ones which
typcially need to be skipped since they need a serdev for the attached
BT HCI.

A PNP enumerated UART which is part of the PCU. So far the existing
quirks have ignored this. But on the Lenovo Yoga Tablet 2 Pro 1380
models this is used for a custom fastcharging protocol. There is
a Micro USB switch which can switch the USB data lines to this uart
and then a 600 baud protocol is used to configure the charger for
a voltage higher then 5V.

Add a new ACPI_QUIRK_PNP_UART1_SKIP quirk type and set this for
the existing entry for the Lenovo Yoga Tablet 2 830 / 1050 models.
Note this will lead to unnecessarily also creating a serdev for
the PCU UART on the 830 / 1050 which don't need this, but the UART
is not used otherwise there so that is not a problem.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index c708524576df4..f8cdc234cbc3f 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -261,9 +261,10 @@ bool force_storage_d3(void)
 #define ACPI_QUIRK_SKIP_I2C_CLIENTS				BIT(0)
 #define ACPI_QUIRK_UART1_SKIP					BIT(1)
 #define ACPI_QUIRK_UART1_TTY_UART2_SKIP				BIT(2)
-#define ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY			BIT(3)
-#define ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY			BIT(4)
-#define ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS			BIT(5)
+#define ACPI_QUIRK_PNP_UART1_SKIP				BIT(3)
+#define ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY			BIT(4)
+#define ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY			BIT(5)
+#define ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS			BIT(6)
 
 static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 	/*
@@ -343,6 +344,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "BLADE_21"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_PNP_UART1_SKIP |
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
 	},
 	{
@@ -441,14 +443,18 @@ static int acpi_dmi_skip_serdev_enumeration(struct device *controller_parent, bo
 	if (ret)
 		return 0;
 
-	/* to not match on PNP enumerated debug UARTs */
-	if (!dev_is_platform(controller_parent))
-		return 0;
-
 	dmi_id = dmi_first_match(acpi_quirk_skip_dmi_ids);
 	if (dmi_id)
 		quirks = (unsigned long)dmi_id->driver_data;
 
+	if (!dev_is_platform(controller_parent)) {
+		/* PNP enumerated UARTs */
+		if ((quirks & ACPI_QUIRK_PNP_UART1_SKIP) && uid == 1)
+			*skip = true;
+
+		return 0;
+	}
+
 	if ((quirks & ACPI_QUIRK_UART1_SKIP) && uid == 1)
 		*skip = true;
 
-- 
2.43.0


