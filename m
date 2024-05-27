Return-Path: <linux-acpi+bounces-5997-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE098D040B
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 16:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3ECBB32241
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3076173357;
	Mon, 27 May 2024 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqw3RUZG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891F17334F;
	Mon, 27 May 2024 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819281; cv=none; b=OkMjpMw0oqhPEMHyFRgLS9hQfHf+TMv8bd4P3E75PNnLye8LiPlhwI0Sbax+mWj1hX10r1q1SyTKfg+FdZL6Dp3xyyZY2Ei5Pyu2GFfulRzL/MbdpPwa5dcQYK2GPFzILCiZhqj1Wlbe28a8cQgKMyqMeqPycixFH0Fpc7rE7Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819281; c=relaxed/simple;
	bh=M/nZ0YyY94qPXAQlyC2aotBSIzmrGXnI177lIdnsE5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0unaKOxhB45RquqRSbvGHWvudLCv1+QbNGGZ8R8dRYoEN/XImkrdT6cVaUV2UhU5WBSNa63yLlkwjpevw2OLBZh5s2Vp52JN+Jl/ESEu/PgB2Dvt9EboiJO8oBwScqbeN5xQBOolqaELP/y0kINvohRvM7inYhV4ktLYjTCQkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqw3RUZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE02DC2BBFC;
	Mon, 27 May 2024 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819281;
	bh=M/nZ0YyY94qPXAQlyC2aotBSIzmrGXnI177lIdnsE5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqw3RUZGW7ZQee/AopnMmCMkN4FO0sSL/Zah1zSPxeU9SsmoBSI3swk67bgk9mxID
	 PxryfrwR3aWJ3SCWrC5LlYD/xor1yKzFn1q4iEbkxkj9VAGc9mPr07hv9Sn0gEckKY
	 v4AbW/rLSSfb1V1DRqYkzdONtPjRfs+StYEaHPWdFz76DPb+Wo9ttC+pA7PpeZMBne
	 wxOf6cFxu/0gZ/YWrsHEAMQMmYt1xTpeirxnnetmBPa3pz7cinYraxoi/cXezuI2Lm
	 EujrEqdCPNNILpnCKCPGr8TzT0TR+xFLKIdQDSI/pZELwSORg2e6Sk74aGHyPkbC35
	 kwH4i77IV/6Uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guenter Schafranek <gschafra@web.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 12/30] ACPI: resource: Do IRQ override on GMxBGxx (XMG APEX 17 M23)
Date: Mon, 27 May 2024 10:13:21 -0400
Message-ID: <20240527141406.3852821-12-sashal@kernel.org>
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

From: Guenter Schafranek <gschafra@web.de>

[ Upstream commit 6eaf375a5a98642ba4c327f79673f4f308e0ac03 ]

The XM APEX 17 M23 (TongFang?) GMxBGxx (got using `sudo dmidecode -s
baseboard-product-name`) needs IRQ overriding for the keyboard to work.

Adding an entry for this laptop to the override_table makes the internal
keyboard functional [1].

Successfully tested with Arch Linux Kernel v6.8 under Manjaro Linux v23.1.4.

Link: https://www.reddit.com/r/XMG_gg/comments/15kd5pg/xmg_apex_17_m23_keyboard_not_working_on_linux/ # [1]
Signed-off-by: Guenter Schafranek <gschafra@web.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b5193049d7b1b..af0be48f70bfc 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -526,6 +526,12 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
  * to have a working keyboard.
  */
 static const struct dmi_system_id irq1_edge_low_force_override[] = {
+	{
+		/* XMG APEX 17 (M23) */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxBGxx"),
+		},
+	},
 	{
 		/* TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD */
 		.matches = {
-- 
2.43.0


