Return-Path: <linux-acpi+bounces-6001-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 552B48D08F5
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 18:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76D0CB2B65B
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842A01C0DD3;
	Mon, 27 May 2024 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so0qNQDe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1321C0DCE;
	Mon, 27 May 2024 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819407; cv=none; b=WjFvw4EAyTedPcISXLw94k4m6wkasQ/2TDkEYMhgO5X+OOPVGTbvniif1oZijZMdV4hWlNlcVo8d/z1LOngIMVdlO89cYxyV67tT4XNXZ70DgB8RaXAv+LMjScU3K+c3oOZf4XVnuJM28BnH2NxbEbhdguRbrhKmtys6RtrA8AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819407; c=relaxed/simple;
	bh=194iDOSz5/fl5Of3QLCu1RQMKF0u9wdBEdM7bhOex0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCZ8gqh4Bhd+GrLkXWSx6mgPYw2WhHTzGVQQMjCJrfYExpNiPa4qtklTsC9eHpYBa69jsBxPx9L53acF72KwdH9YBIDbt9G4YZEHv6dQNtC6nVa2NhAs77vdVadcWBS1ZifTm8OGR47Z5452wFChtNF1tYWqyB2XeUZOucNaYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so0qNQDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EC4C32781;
	Mon, 27 May 2024 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819407;
	bh=194iDOSz5/fl5Of3QLCu1RQMKF0u9wdBEdM7bhOex0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=so0qNQDeRBSLPGz6sYKT578IhLwNqnSJ5mLjm+rn18r+6No0Bj8Teb08I5ZgtK519
	 ea3TtKo7bRlxW8LANG/yvIMAYbPRkn+8YZTfLHwm2mpxOMRpSZ+Znc9xoEwCOdiNOV
	 L3sWM5DiPBnrltFD23qbhqXYoX3tkqp6PGVMwdKs2zqgeEMbtnhJiJW1lu60ciKi+m
	 09pRY+wWiG8T0nRc0Qk/8XNoK+JcIY+ecqa7SrfcgKT4GwI7hc8PjZxfPSseTAYuvE
	 AZ1S1ZSCqB79w19w7qlvONypy8yu578enS4T8SgoFBBmsrEirp64jzd0gB3ILcT7XH
	 ANSG1a/G1zRig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/21] ACPI: video: Add backlight=native quirk for Lenovo Slim 7 16ARH7
Date: Mon, 27 May 2024 10:15:30 -0400
Message-ID: <20240527141551.3853516-19-sashal@kernel.org>
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
index 31205fee59d4a..16ab2d9ef67f3 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -505,6 +505,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
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


