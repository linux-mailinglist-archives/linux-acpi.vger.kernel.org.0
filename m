Return-Path: <linux-acpi+bounces-5993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7387F8D02FD
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 16:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00780298871
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 14:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C20516C6BF;
	Mon, 27 May 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKUeMDBv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DD16C6B8;
	Mon, 27 May 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819160; cv=none; b=GgTcabS6Tdv5CZtqXhbP3a4yjGDBMXZNe6tpKLANqKOGCl8Pi6sHlh8N65cKvJcML551yn4n2TIUcVP/hPpdm2KB0ZP74RLbOvpwqQb2gjtTW0sLv+QMSLEtpfbcUYCkXkYvFkDWliHvp6vo80Z5zN0xNE2KBLhPShmWp4hQAMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819160; c=relaxed/simple;
	bh=CC57b3RNdaw70ZZMkiT21xfz8/rst6uOEpvBqRnIc5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYINkx+Ecrd8bUEVPfmh8sEUR205mgHaQn6a/qer+bK4XvWOXcmoOiE8xVCm1PyZg2LlI219dENG4kXybszQSqBL1fg9vakyBn8CIFbEDTw024kgaE0Fkidbv5QWfjp8oKXxvVuB7+tVcKc7nV/OMWH50Dv9WF82n6wk0HrQEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKUeMDBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947F6C2BBFC;
	Mon, 27 May 2024 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819160;
	bh=CC57b3RNdaw70ZZMkiT21xfz8/rst6uOEpvBqRnIc5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKUeMDBvheiqJCxwwTIgrpSoYvE7RSldyiBxXgitGhI6Sudu61Nhl29NOnVw5k4UX
	 Ki3K9bq5YDzy84TTeXLIL4DCNM4wOOpf8py3M0q5c64ZIGNbf5gUKmoKs+pN+/BRsY
	 sOht7c2TSWbLWnjdk0Wf5n52hhFpbTTouUar0Ncn/0fXKUmdrpch/rPhDfD4yEdqtJ
	 NW71aMbs8EqzFBmZqT1XTQQOXQlpTSdUpPvF4Tvcr2zRZbaLIyqR/xMezln22i7pu6
	 ojdrIDWNTX/vUxRDO3QftDzOL1vPuXaKlm9Sdo+RNJ2BNhhud8m5+nXIJC7McRcGEl
	 j6OW8UbA75UaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guenter Schafranek <gschafra@web.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 14/35] ACPI: resource: Do IRQ override on GMxBGxx (XMG APEX 17 M23)
Date: Mon, 27 May 2024 10:11:19 -0400
Message-ID: <20240527141214.3844331-14-sashal@kernel.org>
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
index 59423fe9d0f29..c9af5d2f4d2d7 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -533,6 +533,12 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
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


