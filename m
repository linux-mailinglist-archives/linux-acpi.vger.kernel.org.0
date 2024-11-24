Return-Path: <linux-acpi+bounces-9772-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F379D6EF5
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Nov 2024 13:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F171280DFB
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Nov 2024 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCB01BC9F0;
	Sun, 24 Nov 2024 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dduuAefm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B71BC08B;
	Sun, 24 Nov 2024 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452345; cv=none; b=EXJo48vj/DW6X/aBCIfDTBL6Mpl9pUDBiKlE1axVeHs6HcPAKAT9xHu3Zl4y/3yPluz/4hyFZDvmr7HRLid/rzZGrvg6epswSHWzrpwbgvOs44y1FmWuFXbMIeRBPewZaH0vys9Eps/hfuVfra9KpQBMfJk6qy0iddJbj/Wv5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452345; c=relaxed/simple;
	bh=/nFO8R32GZihlJSRZT3Unc2C2wdWxLOR2hiL2PoYzD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gn6FoSYZ64wXU7dvJ78u8LM0eL2j6a9NQG/PQ24z5pEEDzz5M4sy+4aPxZ2LCqv7rZ/uvrX2y48VVp2QxXPgKorgDwvtlnFwNlopbCWExH990TOOJwuHQ4b9Xz/rlppYIuX+pyKkFdWmC++Jmv2MP2zK0Ycshwi4mA4WFD9wPuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dduuAefm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BC5C4CED6;
	Sun, 24 Nov 2024 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452344;
	bh=/nFO8R32GZihlJSRZT3Unc2C2wdWxLOR2hiL2PoYzD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dduuAefmF+JQWYlRPOULkNrdqmEJewQaCNumDy4vNrbReq65zUwZRyQDNLHUxbwEY
	 Dk7hRrIsGcfSDuRHa5qdzs0/LKii/zWtHAtiA4Plu9CZGki08zgsvO9EQ5uXwqc/11
	 84RekB6WmbABcqRxodUNcdOVU9Ldec/KDh/DFeq5fc/5qjwKvBBFbcmwYNS9A9R7Oc
	 nWxApNd7VExGfzVCw/9xMBO/HPTb+NKDAq87RAhAxQFbGjT7ow5lcJ9eMRIpm3mDrj
	 du8cabGDQc5piuVzk9gyC2zEGJzM89fGTJZ+fXJUuX0hWXpeQmIkifOsLDMprMsbkq
	 uHdb3Di0p2bRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan Denose <jdenose@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 6/6] ACPI: video: force native for Apple MacbookPro11,2 and Air7,2
Date: Sun, 24 Nov 2024 07:45:28 -0500
Message-ID: <20241124124532.3337626-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124532.3337626-1-sashal@kernel.org>
References: <20241124124532.3337626-1-sashal@kernel.org>
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

From: Jonathan Denose <jdenose@google.com>

[ Upstream commit 295991836b23c12ddb447f7f583a17fd3616ad7d ]

There is a bug in the Macbook Pro 11,2 and Air 7,2 firmware similar to
what is described in:

commit 7dc918daaf29 ("ACPI: video: force native for Apple MacbookPro9,2")

This bug causes their backlights not to come back after resume.

Add DMI quirks to select the working native Intel firmware interface
such that the backlght comes back on after resume.

Signed-off-by: Jonathan Denose <jdenose@google.com>
Link: https://patch.msgid.link/20241112222516.1.I7fa78e6acbbed56ed5677f5e2dacc098a269d955@changeid
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b05064578293f..fed3990bf6b1d 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -549,6 +549,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple MacBook Air 7,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir7,2"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Apple MacBook Air 9,1 */
@@ -565,6 +573,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro9,2"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple MacBook Pro 11,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro11,2"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,
-- 
2.43.0


