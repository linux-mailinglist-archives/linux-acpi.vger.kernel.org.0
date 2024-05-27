Return-Path: <linux-acpi+bounces-5992-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD888D02F3
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 16:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A630029C4ED
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 14:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC66A16ABE7;
	Mon, 27 May 2024 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJXrm1Xz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B5115F32D;
	Mon, 27 May 2024 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819155; cv=none; b=jp4QRMCDP4fE3IxAQCz7vf3ttWLTSczez1sVhhPSjAKQsAV8BF27qRwVvR48PrfnNmMylkkQITmtdVC4FgsfpWaUEqVzX7MiDgDfYdmW4Vsm6PY490Ma9fZfOqcRnfZrYl1qlNoIFD8y+qJ2EYPG0oJxleKfjbe67QhF0fNZiUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819155; c=relaxed/simple;
	bh=jcxLBEiIRpPiWOvQGwWAAHgqianBSi95X9Ie1UAGN0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5ouAhu6ZhrGdZu+5sKGkVTZucdT5e+QqX7fflQ4+lt6BOw0fHJ2L8k1+CnH1MLwjMUAanXzJs/0DgUySdFOGQ/s3xJn+1NcdyUl4hUHWnYiDJQ524nbtU3ENrwqOIPirCtQ4igCK3rUOsAV8qHxWMOgo33f9A8gqBvGMrDCKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJXrm1Xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C460C2BBFC;
	Mon, 27 May 2024 14:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819155;
	bh=jcxLBEiIRpPiWOvQGwWAAHgqianBSi95X9Ie1UAGN0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJXrm1Xzfg2y9oa9xVJ+ZaMSDcQgXqGVJ9mKMMtI71zDPoXG0F0t+16nAaoi5Dgl7
	 65/aR1FChbGryZqjL7dTk5TjH+mdQZkxh8Pe2RbyjL9ukQG5nPQOaFkW8bxAgg8adh
	 1mHdvvHOx/v/MtaBk2sbtoPd/1A92B8JXGnYlA20qoJprTv5fKGQedg94OrhKYOcda
	 eMunHi2TsCK2YkPa6N5AZKO2KNnoY1U8HNBAUj6aJqIX7kcXQrrzlWqC24/aXN734C
	 4L9doO/QYRo70wedGaRNP0jIrVbNr3SJhu9aA5CP1wQ6MIty4XecvkzN/jHH7kwT4G
	 NSyNUiW4CF5Cg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	mika.westerberg@linux.intel.com,
	michal.wilczynski@intel.com,
	raag.jadav@intel.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 11/35] ACPI: x86: Add PNP_UART1_SKIP quirk for Lenovo Blade2 tablets
Date: Mon, 27 May 2024 10:11:16 -0400
Message-ID: <20240527141214.3844331-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141214.3844331-1-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
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
index 90c3d2eab9e99..e5612067ccac8 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -260,9 +260,10 @@ bool force_storage_d3(void)
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
@@ -342,6 +343,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "BLADE_21"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_PNP_UART1_SKIP |
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
 	},
 	{
@@ -440,14 +442,18 @@ static int acpi_dmi_skip_serdev_enumeration(struct device *controller_parent, bo
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


