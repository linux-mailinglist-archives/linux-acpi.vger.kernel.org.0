Return-Path: <linux-acpi+bounces-5999-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238848D03A8
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 16:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28E22A5ADB
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BF5180A96;
	Mon, 27 May 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tua3JtTy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA32180A8B;
	Mon, 27 May 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819318; cv=none; b=cRQpXqVu+RaNUn5S9TAILKY9eFg6+7O2uscaQ5g+pzY4BodJ9JIdxV8WLUtR0+kXvoRhroDCNJKxTsd0uLL1DqXQ45/7l+upzUwQBrNi2e7m2VWpaTCpzYfhXbmCXG+AuEbIN9ufxRKJl0QPJpEf8hYGbRxb87rhF4I9qmeJKrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819318; c=relaxed/simple;
	bh=40t4tHjWFDuMpxRmW027bCl5BGzQoCTq6GRC2BpRg8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0AIaCShq1r0TPSqK2gzgZNmfMl4gMKqOpPcxL5bD+PDb2sqUqMFOAQlDu8qg524X5gWKoxVaEZqfxiWdkFJaaN+5UopR4PgaLy52OuJzgXZZDmgtO4lQxUOlcxVy3430m+0MhSsI85S/epG7J4uZg+U2WVAgVT2W5QC96pYmFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tua3JtTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EF1C4AF0A;
	Mon, 27 May 2024 14:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819317;
	bh=40t4tHjWFDuMpxRmW027bCl5BGzQoCTq6GRC2BpRg8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tua3JtTylt0nCWFisdjQYB2MgtgaqSBrL9wp/JVuJcwXxvYiMRL+2YxJIsVwSlh6S
	 X+6FC45bHl4djHV4HoS4Zgix7I6LtczP8UzQH1e8/FIv3Ib7LUM62Fx/iesSfMFAJa
	 x69kkwNuHhxbkWYYBl6A1HopCKNJmpjh6Q++9JK9sdDALEyNAeabQVxTxjKKLnTqh0
	 /wozJ/YYSHTgp7JKPTqBMw6hUeEkAzqN2kn9SraSzD6Wni5WFz3bs34ssS5X0th3rC
	 l7YCTeiX8PbjCc9T7coD9Rkwrs/HqKeXQ5vosraw2nS9XUvCI7p5e7t2CkidwHrWJR
	 bZ1PEVTDS0sLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 26/30] ACPI: video: Add backlight=native quirk for Lenovo Slim 7 16ARH7
Date: Mon, 27 May 2024 10:13:35 -0400
Message-ID: <20240527141406.3852821-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141406.3852821-1-sashal@kernel.org>
References: <20240527141406.3852821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit c901f63dc142c48326931f164f787dfff69273d9 ]

Lenovo Slim 7 16ARH7 is a machine with switchable graphics between AMD
and Nvidia, and the backlight can't be adjusted properly unless
acpi_backlight=native is passed.  Although nvidia-wmi-backlight is
present and loaded, this doesn't work as expected at all.

For making it working as default, add the corresponding quirk entry
with a DMI matching "LENOVO" "82UX".

Link: https://bugzilla.suse.com/show_bug.cgi?id=1217750
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 9fdcc620c6524..2cc3821b2b16e 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -497,6 +497,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "82BK"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Lenovo Slim 7 16ARH7 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "82UX"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Lenovo ThinkPad X131e (3371 AMD version) */
-- 
2.43.0


