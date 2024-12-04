Return-Path: <linux-acpi+bounces-9931-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910119E48CF
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 00:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5C3283F6C
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 23:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4529206F19;
	Wed,  4 Dec 2024 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbzxFlQO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A6202C42;
	Wed,  4 Dec 2024 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354754; cv=none; b=dBaFztmouGS+NxytPTK6dHlA4pWIQUNdD+PtYFlmvwyCdQMxPf4VVMbr2eAT37uhTAuSZtLroLabGWYGTy4u7mF8wwRSpiTVpdC7lVNNARYfvA4MO+w0EiQfSeGHAkH+9iCXJNmeaavvYRQ82tWU4p8FTzrbMPeqaYIT7LR5Pag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354754; c=relaxed/simple;
	bh=WLx6owURrXIc+ued+Mb0K+pNfMQl50KcyfY7X+K9Gno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoQ/KUZ79nY22EMPJAlnoMEMJGMRQqPx72srg2j2Jh1KvcZ/qh+xbRU1aV2V3nQhZHGrBq7l7q3zGgnbzZUxdF6/HSnBfbXmRGEVz8VrrcFlXuONRNrHsVpkSpoBaeJj55UaGsH/ltt7qZtaOJ25tzOn2geJ+NwquTLA7YW/3io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbzxFlQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C40C4CED6;
	Wed,  4 Dec 2024 23:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354754;
	bh=WLx6owURrXIc+ued+Mb0K+pNfMQl50KcyfY7X+K9Gno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbzxFlQOy6VeLODpHgcNPCshFV8RSzRRiv/VKqR0GHG6YeR8dLW7yC+sR9syehMkZ
	 ptfBG0Vm8fYq8kA7tAMTddz1PgEQEug9owRPIr38iNSgCQXBzCFWYwrTnlJG1tXFQ3
	 lR7dW/Qlj8D9wlfqAwx6XBme6GageyotfniSZaxk/sdjBk4K71x0m4+f9zRKMkQUE/
	 Co6siMwr7jf8ASaR5/IGV5PBsZeF7dH+ju784WT0UDTk1JGf1e5K04w88W/BQJ1uMt
	 Iyba+lFo0gAP6pZD4LN7ikx+1PQn50/cXOgAvLwgDDdPZjqZiamiSD+cCrgkk7ZDCq
	 AMZuwyfu41yrA==
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
Subject: [PATCH AUTOSEL 6.11 2/3] ACPI: x86: Clean up Asus entries in acpi_quirk_skip_dmi_ids[]
Date: Wed,  4 Dec 2024 17:14:24 -0500
Message-ID: <20241204221431.2247102-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221431.2247102-1-sashal@kernel.org>
References: <20241204221431.2247102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit bd8aa15848f5f21951cd0b0d01510b3ad1f777d4 ]

The Asus entries in the acpi_quirk_skip_dmi_ids[] table are the only
entries without a comment which model they apply to. Add these comments.

The Asus TF103C entry also is in the wrong place for what is supposed to
be an alphabetically sorted list. Move it up so that the list is properly
sorted and add a comment that the list is alphabetically sorted.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20241116095825.11660-2-hdegoede@redhat.com
[ rjw: Changelog and subject edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 24af6a10cc5fc..16560d2c9711e 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -295,6 +295,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 	/*
 	 * 2. Devices which also have the skip i2c/serdev quirks and which
 	 *    need the x86-android-tablets module to properly work.
+	 *    Sorted alphabetically.
 	 */
 #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
 	{
@@ -320,6 +321,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
 	{
+		/* Asus ME176C tablet */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ME176C"),
@@ -330,23 +332,24 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
 	{
-		/* Lenovo Yoga Book X90F/L */
+		/* Asus TF103C transformer 2-in-1 */
 		.matches = {
-			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TF103C"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
-					ACPI_QUIRK_UART1_SKIP |
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
 	{
+		/* Lenovo Yoga Book X90F/L */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TF103C"),
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_UART1_SKIP |
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
-- 
2.43.0


