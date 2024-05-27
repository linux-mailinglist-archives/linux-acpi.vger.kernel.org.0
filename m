Return-Path: <linux-acpi+bounces-5995-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C518D0332
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 16:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91AF1F26917
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 14:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D316F827;
	Mon, 27 May 2024 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cggznKv3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6A16F820;
	Mon, 27 May 2024 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819198; cv=none; b=HFpNiIg8TWdSKGE+Ggb59tQ6IOssgi+eLEGL2Rcmn8BQq/ZAdFgmP0bj8Ph8+Qkzm18kzqnkQvchptd2CEzUWapj7tWRaQW5rzt8qIqqdzKM5rtTHa/yvzIsQXcLHb/o561peFfhEFpd7IPHtVVRLOQhF511Ur13kmbadTbIotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819198; c=relaxed/simple;
	bh=40t4tHjWFDuMpxRmW027bCl5BGzQoCTq6GRC2BpRg8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdcxqIoFNZ4S82hmEtmuzwHkz7AF765WhjejK6TUMiLG4NUbW6+QnEp9MQrqoEGSiz7llnWhrBJjXJwORtdngLMx+lXtNumIyl1tTy3E88U6RD7ktZh+ezR+YIRz8tEyqZgUxMYkWqqBwKGMPwR0ucA9PpjG7Adm3aJo9XB4B0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cggznKv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3800FC32789;
	Mon, 27 May 2024 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819198;
	bh=40t4tHjWFDuMpxRmW027bCl5BGzQoCTq6GRC2BpRg8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cggznKv3BjjeYoAJu0E7TrGOZqjw9nwGjsYPOfLvecsQSCGjkzSDs07uWzfJoHgLs
	 F7Nzc//mfb4HzTQIZzHLFd9DiaFVVcjhlURLBRy0i+40lvAUn8SbgY614J+/J12qEa
	 ZeaAKA5RIw7BWwuxCVgoLGev7LxRt7cY2L79d+KL7tFVhRpSNphZWeUh+n+L/Qxc/f
	 2o81L2fbgy6SCwUn/zwYv3MpzNIJjE4+T/OxD9AyLc4vORrrdAE63m5KS9BvhEWX91
	 6aqUB4AqF49CiNqJDlVYeUuUi4u/upw6a1ijjt+ByRyYN0ZB4CvOq8PaGLppc4ZGNL
	 YehhPfZQJzw3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 30/35] ACPI: video: Add backlight=native quirk for Lenovo Slim 7 16ARH7
Date: Mon, 27 May 2024 10:11:35 -0400
Message-ID: <20240527141214.3844331-30-sashal@kernel.org>
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


