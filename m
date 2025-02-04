Return-Path: <linux-acpi+bounces-10883-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C268A26953
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 02:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BFD3A4582
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 01:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B96014F9FB;
	Tue,  4 Feb 2025 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZDW6PaZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB8A13D8B1;
	Tue,  4 Feb 2025 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631802; cv=none; b=HUyPQRe2jHR5OcfS3jE9L0AcDcQsQXYCx25tax5aePzQfSGYY20Y9EuHKQA3/p5UCDCBEXgtVFmqcBtX5Hf+7wEuP9+IFRoJIkC4DC7q8+d/PXJ6+ct7nAXbaxldagvD/di0DIpf3Qq5mXHJq+vzI5uS/0mjfvxdyxbKwdy0Ym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631802; c=relaxed/simple;
	bh=LMgaSDmx6EN1XI6CionK2vcw/4u08QZJ+v6t3LrXwAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4nbLTCB9AI38MMXyffVOTS0ULmeb1xtcssGknxJzWxLFzjfivhlBFRbUPkd8mcVGsYxDNTHC8Ddu22Jr48f1AyrJywtMP/LQHnhKwYixO3rPuUh9R0fNyhqVe9x6ZzD/Y5z9js01wKKzXHSyoDRvWI+/M6xRkgdaDqETEy6Lwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZDW6PaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102AAC4CEE5;
	Tue,  4 Feb 2025 01:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738631802;
	bh=LMgaSDmx6EN1XI6CionK2vcw/4u08QZJ+v6t3LrXwAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZDW6PaZM/ud7nM5CrhfqDYp8wBHJ/g2zvm1jIwjxtegw4uITvHjRcHpp4krQjqbh
	 LvbOv07QLRRW8yM1LfN+SMwQe0ied0Lup2GUTADxOHlrjwdkoh1GGqhN1DpxLvQZ5X
	 pA5hiTWQpuF368bEq02avMZD3wNCuBp+0c63YztgP91W1ecF30Y++AKsRTnq2Aob9J
	 x2wAKgVyRx8lGDT/f35MfQlDrl3/g3a4RPkfSFseK79kwj/WWjDcontqi9R2gS1OCZ
	 liP75WSsihIXER95+miCcsaWFKOUksUsNqV3YPgviHTULbwCS2oYFPmS42gueyXSF9
	 65VmsWQY4z/1Q==
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
Subject: [PATCH AUTOSEL 6.13 5/5] ACPI: x86: Add skip i2c clients quirk for Vexia EDU ATLA 10 tablet 5V
Date: Mon,  3 Feb 2025 20:16:27 -0500
Message-Id: <20250204011627.2206261-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250204011627.2206261-1-sashal@kernel.org>
References: <20250204011627.2206261-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.1
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
index cb45ef5240dab..068c1612660bc 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -407,6 +407,19 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
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


