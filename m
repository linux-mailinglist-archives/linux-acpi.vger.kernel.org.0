Return-Path: <linux-acpi+bounces-10884-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35530A26970
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 02:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58C33A4DAA
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 01:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74A71EEA4E;
	Tue,  4 Feb 2025 01:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad0V1omh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7234204C20;
	Tue,  4 Feb 2025 01:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631814; cv=none; b=NGR5TAsYBb7450fbsJ/IlKP2XEah+xL8aiTNz4hyUWCKfZYw5ahfrmdJtci4j1VE5rC78sylRfqs+7m5dCI7E45j98IghkMVh0xXziRr4RtzAB5TBW8e/qkuBOBFdTe4a7IClWORTz/gvKsfOnTdaVN2vZQa1ovgx7eI+DMYw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631814; c=relaxed/simple;
	bh=LMgaSDmx6EN1XI6CionK2vcw/4u08QZJ+v6t3LrXwAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwYsfxi0SRNHO3J6o0GFvehN5/KqTIfpynxiO5r7EMvm3umVkmOhuQUBcB36CB26c6s9jz2ZvD6ud1e2Nz3VVs9JC8Zo+ZseHXi7I9KrQwB8iK2nVhffRpqSaiPxSD9FqnSZQ0cs8k4XeaJL8Tq4GMVIUSK7UFr/OexBtfgvZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad0V1omh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13489C4CEE0;
	Tue,  4 Feb 2025 01:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738631814;
	bh=LMgaSDmx6EN1XI6CionK2vcw/4u08QZJ+v6t3LrXwAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ad0V1omhjFT0rJfHjodw2wuuAZEqw+pFIddvo7M1ruqefMuXrK1NZoRbfuzJtalrY
	 sV56Nk/L1NhZK+Lfh/A5NVtCTMP7T7sfwdIUAAdg4DYY7maHw8EKfHfRuQbqH11bQF
	 YZ9TIqhOfFCqecUMRiY0Npe4olNNkNduduIwqa+YRbde5eknzVp8s0EONKBVHCKO8Q
	 3DLB+KVaaxfHJ248Tv90YW6vJ59kF4YKmtc0bkwfkWzrWZlIaei5icA37FL9Ok8PIv
	 55Oma0XguEPkJXK8Sc13sLlyvAnNpRw6+qROg9SONsLdmKsCPoOof0pObQWHVJMsPO
	 uc6s7RwteC59Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	tony.luck@intel.com,
	mario.limonciello@amd.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 4/4] ACPI: x86: Add skip i2c clients quirk for Vexia EDU ATLA 10 tablet 5V
Date: Mon,  3 Feb 2025 20:16:42 -0500
Message-Id: <20250204011643.2206417-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250204011643.2206417-1-sashal@kernel.org>
References: <20250204011643.2206417-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.12
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


