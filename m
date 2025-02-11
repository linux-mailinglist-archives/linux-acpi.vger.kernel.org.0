Return-Path: <linux-acpi+bounces-10987-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC77A3007C
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 02:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939331887C7D
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 01:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC961F2B9B;
	Tue, 11 Feb 2025 01:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWKH8oMa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C259F1F2B95;
	Tue, 11 Feb 2025 01:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237483; cv=none; b=tuRJPVNzVKMv1mPd8hdBk1SE67ImkebvNyA41jS5LQMzUbabYo+O3ErULpzELmUx5Ai5n61ppPmDwQvcKaVKcmdCLIImIAipm6Mj9tVhvkvrOt4gKpbsIj75kSTguPHIS1KTOfWgM4ug73l4ezUqUXpJUvCFySBCgFyhhv7rlXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237483; c=relaxed/simple;
	bh=ySLUvMMBTHzlJLmqpRqysEHyKgwvuX6j+Zt4vOn+2mU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hm9vBau9kHCh9hzgPsUaAF5jOCTK1RmpV9551RvIKu+RFzXJ0dF7J4HbqW24I1kq6VU8k73x2pxUr6h7A4lrzfm6bGnmMGf2dhbt0LfQnJojdLIrVoAB7QeqwmCfDd9DGb4uCmeuvq4eegGLgREjigEQ551BKFkTRkuvU3zofNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWKH8oMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F6AC4CED1;
	Tue, 11 Feb 2025 01:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237483;
	bh=ySLUvMMBTHzlJLmqpRqysEHyKgwvuX6j+Zt4vOn+2mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWKH8oMatWOzlugut+56fh/2VxznLUrvN9cEw5+SBSTkxoHfad5qkmjqcvqpEcvbl
	 GPeOf1RvGKPJltx7s7CJ5sju0aD3wb1cBJhnM1lCMBC0LmoUHtNBeCCz0bIX2ww/K8
	 2YefgvP4XSeAHLg/c5aiGeEJUmqlr7f9m8KeD5k6KIQcWoW+nwZ8TX6Ybf4XcCesf2
	 O0uMXYJcjEQewl5m6djjgMcdHwI5yhnjOjskcB6SAHdX1xJukGvepDKtyBUOG+tv4R
	 OgcAw6vBdiVJBhTUwqCl0PHbUw5QSGY/NRUbbagjWRkEAad8gVLBvOYxFVPK1p3oAc
	 3edcrW0XHog5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gannon Kolding <gannon.kolding@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 15/19] ACPI: resource: IRQ override for Eluktronics MECH-17
Date: Mon, 10 Feb 2025 20:30:43 -0500
Message-Id: <20250211013047.4096767-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013047.4096767-1-sashal@kernel.org>
References: <20250211013047.4096767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
Content-Transfer-Encoding: 8bit

From: Gannon Kolding <gannon.kolding@gmail.com>

[ Upstream commit 607ab6f85f4194b644ea95ac5fe660ef575db3b4 ]

The Eluktronics MECH-17 (GM7RG7N) needs IRQ overriding for the
keyboard to work.

Adding a DMI_MATCH entry for this laptop model makes the internal
keyboard function normally.

Signed-off-by: Gannon Kolding <gannon.kolding@gmail.com>
Link: https://patch.msgid.link/20250127093902.328361-1-gannon.kolding@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 90aaec923889c..b4cd14e7fa76c 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -563,6 +563,12 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "RP-15"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Eluktronics Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "MECH-17"),
+		},
+	},
 	{
 		/* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
 		.matches = {
-- 
2.39.5


