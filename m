Return-Path: <linux-acpi+bounces-6002-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6128D0460
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 16:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C151F21103
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100A216E866;
	Mon, 27 May 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exZVWsAE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7016DEDD;
	Mon, 27 May 2024 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819522; cv=none; b=mGCumTWstePviHavAKcaBQvBW0Uy/NM/J3pS77MfdF/+cQ6VcMJp7Hr4FGakBQ0v/H7zcNlXgeyDijgULlCvPfgDvCeGz2EtZlGxDAwacoP9fxiBFYUSIa+1Q7uc1IjzBqcEyHNV+dNt5nw3hsCxsFhpUOhzLuZPPCZbrHLsH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819522; c=relaxed/simple;
	bh=fIgHyz1SU66HH2/03OqanKPPWhz+SgylrApj4NM5RgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQbOdhn7UMLevBaklTPjy8IuR+GVj19aeX+ctieDuErx9gTXuzu2M+XlznOkQmicfrbu+AWAvIyO1BQFGIhFDlmHtZ+e9mILQtv1WXitgYSLQtZgj4qJXCSjYGlxaguUK7EY7z5nbyf2TkS2ER4HML5dJdJZXeBNwOaD77y9c6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exZVWsAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1AEC2BBFC;
	Mon, 27 May 2024 14:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819522;
	bh=fIgHyz1SU66HH2/03OqanKPPWhz+SgylrApj4NM5RgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=exZVWsAEXppUXnJCnyBHKuS3ljc7BZsv9hZn5VPLYPN+mrUTUb15F3xB9Rleol+OK
	 sYqwAIl5oxfN67ACMBPeDTBuZvLV/yBW1u+p+efzzJo/qQNpuSfcLFXJ5vO/YFEjuL
	 5RswrxbhisSRuNwpQdUNKv3r38ynspYd/CvgVHnoVYj3OUEHXN22cQn6UgQsU/sucP
	 IxWBV8AkC/yliDOnpazJm4MnOAjPEzQnWLliLnkEsOYVUY7qx+NBpiMOqSn90jUiC+
	 DV2PY8JgTxqPlOCqBpXjq6Bu0aP6fBXN00p43xxY6Ienimj5PD3Vc09paQcseOAoLg
	 623CfKuUNAIrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 11/13] ACPI: video: Add backlight=native quirk for Lenovo Slim 7 16ARH7
Date: Mon, 27 May 2024 10:18:05 -0400
Message-ID: <20240527141819.3854376-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141819.3854376-1-sashal@kernel.org>
References: <20240527141819.3854376-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
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
index a5cb9e1d48bcc..338e1f44906a9 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -341,6 +341,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
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


