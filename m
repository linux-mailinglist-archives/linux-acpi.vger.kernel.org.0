Return-Path: <linux-acpi+bounces-5998-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BB58D0390
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 16:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED68A1F2852A
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8DF17A93E;
	Mon, 27 May 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqBjSknK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9678617A939;
	Mon, 27 May 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819300; cv=none; b=SrxNPhf/jXggF6UDQlmU1YUf6tmd7FqTra+LNF3JErxCGsTs980tdvFj7UKNRWfe99EHshJO10J8Iby5rhJ608f3IdK9coKoHB6UIZccs3xrsaKzyUOD6IA75bU0kpZrztGxDwcqj2lZ9yNPwkTIM9/b+IBKIiuD1C+Iuzsmsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819300; c=relaxed/simple;
	bh=cLhICrdbp5aaQSTfBtBKseng0ctUkKo33QZ13YgWymk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iChlS1q74RJPCIXvzN3zxk4dzarKkMAs6lILQXlleH50eLFKkVpcBkG2Utp9nZYHARd9RHM8QmYd7OT2vVHuEBr66q2MIX8uiYZJtci1Qda4hxCvx2Q2CwvAZaNJ7VTQSj7Sj2yGBpdVpMUnjQByflJx++Sl59gPJyIKtn/8kxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqBjSknK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F932C32789;
	Mon, 27 May 2024 14:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819300;
	bh=cLhICrdbp5aaQSTfBtBKseng0ctUkKo33QZ13YgWymk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JqBjSknKt7uGYmLRmytX0dPY/uQ54XqVmBVA+8o/RVnSH3opFLKcjduCkghIOl1JE
	 CUrGZy/v4JrFa7cd/Nds+XxLpyZ2iDOnJnBSBeGs+F80RLoSZGCdpjeW+wi1dgv6AJ
	 /UUyPgXTSuMTCM/0t4BwNFSiYH/KalpkdH37rjm4jQQKOgSx02b18dviQMorpQgF4M
	 ni2GZw4EW51pKuxnVgEd0YQDMYMdqTmTAvvRbqikbiFJXpRxDuOCjW4CWN3BBKKtc4
	 q9u7HsVaLNyjs+RJ/30sJb5DRsKFLNJCHfQhtX6b2zNdMfp7AkhelCRxIa2l2/IKC3
	 vYylQCScdl7xg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tamim Khan <tamim@fusetak.com>,
	Gianni <gianni.casagrande.mail@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 20/30] ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MV
Date: Mon, 27 May 2024 10:13:29 -0400
Message-ID: <20240527141406.3852821-20-sashal@kernel.org>
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
index af0be48f70bfc..17a068442eecb 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -510,6 +510,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
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


