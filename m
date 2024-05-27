Return-Path: <linux-acpi+bounces-5994-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AAC8D031D
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 16:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4951C222B8
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E491616E891;
	Mon, 27 May 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOJvvCWI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9E16E88B;
	Mon, 27 May 2024 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819183; cv=none; b=PxRwg1z1Xk+Mv+UQC1v8Nu/HOj61Hacm2CIKGT+SI2niTf8FQllBHl4KHzHxeV/n07EwG1ZKeCnAC6w9oKya1N7LjP3lY7BGWDhMzu2sDvGww4mlZpXepTwNqTDjPkIsw0ZO6QxD757/bDbmH201iqDXFBGSTJBEFYGGN2nPXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819183; c=relaxed/simple;
	bh=nnl7uwuBL13OQe7+PdCqXTtXDYutmJcyZLZkPj744Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnSjgNviC9dyZH/krVsE+1AbCgpBTuymUQ6DmyosZomxELguYZOI5wjz72RWl+zJDjGUJh6t9/OvG63xzx6YkSEYiA1MW2Q/lcfNgwMnEKyG/HKY64JoICZ2TxaVGvdM+XZvz+LAzW9YRoUbBJXxC7JxfxhWd5FAATJKjDCQ1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOJvvCWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B4BC4AF07;
	Mon, 27 May 2024 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819182;
	bh=nnl7uwuBL13OQe7+PdCqXTtXDYutmJcyZLZkPj744Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VOJvvCWIMgQCgCKMHL8CtuDdd2tLZYVRwlcmSSiL1N7aIOuw8qCE6ummivSZmi3zv
	 tx0nOUUuuBOSm8G3GhlsQnbp+rY4qvsr2GqiWpY66PhANtj8b4h3n+a6HBUET37mG9
	 haB5PPCIll3phHaa9V8zLk30m9sCJAeY1b9xqF4cE4k5pqtLHmggEbgcTDP/RtUTjh
	 r7idI13FXL1tmbGCr8Cmi0AkJBkQi5Rv+9I3qPgUPwxtO3lQH7PiP+Nq0r7WtAv3OH
	 SwOQ1c2jlPMM9GmqwfBveuBvVJQuaB1bZrYUcl76clBKm1ZFTdCJjQqcAJEKtGE+9j
	 6+XvBrcnZjKoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tamim Khan <tamim@fusetak.com>,
	Gianni <gianni.casagrande.mail@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 24/35] ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MV
Date: Mon, 27 May 2024 10:11:29 -0400
Message-ID: <20240527141214.3844331-24-sashal@kernel.org>
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

From: Tamim Khan <tamim@fusetak.com>

[ Upstream commit 7c52c7071bd403acee8cb0064627d46c6c2a1ea3 ]

Like various other Asus Vivobook and Expertbook laptops, the Asus
Vivobook Pro N6506MV has a DSDT table that describes IRQ 1 as ActiveLow
while the kernel is overriding it to Edge_High. This prevents the internal
keyboard from working. This patch prevents this issue by adding this laptop
to the override table that prevents the kernel from overriding this IRQ

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218745
Tested-by: Gianni <gianni.casagrande.mail@gmail.com>
Signed-off-by: Tamim Khan <tamim@fusetak.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index c9af5d2f4d2d7..553b043809ad5 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -517,6 +517,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "E1504GAB"),
 		},
 	},
+	{
+		/* Asus Vivobook Pro N6506MV */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "N6506MV"),
+		},
+	},
 	{
 		/* LG Electronics 17U70P */
 		.matches = {
-- 
2.43.0


