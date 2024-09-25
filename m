Return-Path: <linux-acpi+bounces-8392-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 511DA985864
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 13:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5C61F22298
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 11:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FF318CC17;
	Wed, 25 Sep 2024 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O98+yD24"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F918C912;
	Wed, 25 Sep 2024 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264254; cv=none; b=a6ETU1uKIbSGSuFoslZ+veY2K5d7m8c3EW71r91DfK3JKKI1jTnuF+V7fpfQzCBt71wcolNf0sz7JaQyZ9XDzcf0GTMqOqldJ0fejfzwH8y2jtmu+D1mDiIymnQ6mfZhOPljugGANBEykO+a2LjLCND8V+CvE6LTWYzajAk14OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264254; c=relaxed/simple;
	bh=qpxkqniFqsfE95JUiw6oouGT8Ul4rggjTRmcJRWXDBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQk3081LZBXS/Koj3RTkbpPuJjY2dM2nRS1Y/HlfJAYNrjtcntYni82ezdXMlCXaAqT5SCthdp3KXAKBdRGG1K+z6FtWo9HRlXJDKltbq1wFQLxr9CREr68N38BbzgEp3a6L4L1CsCoND+NvcLoGwA9ZPtj92UQ2LZ4dHl5u5ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O98+yD24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80B1C4CECD;
	Wed, 25 Sep 2024 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264253;
	bh=qpxkqniFqsfE95JUiw6oouGT8Ul4rggjTRmcJRWXDBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O98+yD24PtMyM53aCr7fY6MBdTbsA4M5iTWtJ1YIpQWswKYYI3DfQV9zOiW/1Sro9
	 yjJ4ZiTjfzkKx/GN8P6UhP+7QW22914oKo47orrDKC85qmHVPAs45C4YmiO//mqjxx
	 IpYIXeFWR1R4ij9zMm7bPNlrJLn4KEYqX/ODTvlAgw+C2NuP14ir8Jzr3BLaBDfTIY
	 9monHS5ty2ynP6EnepocTGCBxwAZPuKr9g4Ts6r7PCc6WvukQ5y8gmeCMHrfJV8y1r
	 dbafXRNFy1ulOy/QphZK6wtAKAGHaW6q+1CwNCkUJjot0tcCC7NjMQGwy6UWj5Sl7E
	 KNJYhj+4HdseA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tamim Khan <tamim@fusetak.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 023/244] ACPI: resource: Skip IRQ override on Asus Vivobook Go E1404GAB
Date: Wed, 25 Sep 2024 07:24:04 -0400
Message-ID: <20240925113641.1297102-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Tamim Khan <tamim@fusetak.com>

[ Upstream commit 49e9cc315604972cc14868cb67831e3e8c3f1470 ]

Like other Asus Vivobooks, the Asus Vivobook Go E1404GAB has a DSDT
that describes IRQ 1 as ActiveLow, while the kernel overrides to Edge_High.

This override prevents the internal keyboard from working.

Fix the problem by adding this laptop to the table that prevents the kernel
from overriding the IRQ.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219212
Signed-off-by: Tamim Khan <tamim@fusetak.com>
Link: https://patch.msgid.link/20240903014317.38858-1-tamim@fusetak.com
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index df5d5a554b388..c65c72c515e67 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -503,6 +503,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2502FBA"),
 		},
 	},
+	{
+		/* Asus Vivobook Go E1404GAB */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "E1404GAB"),
+		},
+	},
 	{
 		/* Asus Vivobook E1504GA */
 		.matches = {
-- 
2.43.0


