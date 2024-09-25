Return-Path: <linux-acpi+bounces-8402-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B001B985C51
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 14:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EBF287E69
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 12:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EDE1CDFA4;
	Wed, 25 Sep 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trhY/+AB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733E1CDA3B;
	Wed, 25 Sep 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265554; cv=none; b=nIKJ1WTUMGP8YHmJpOYmg/7OsmIDd5XGk9qxqkspk9Up/rPX+dA1mz8gwxVNGD8MEWydVQ4hYVDTWLEkbwS60iKn8Q2Z+WTcH4gAO+pdyL9PDIq0PF7sUD7VgcJDrxCrh2/kWkLb+JW5uVqhj57ZzuwhDeikH0Sg90lIjmOsigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265554; c=relaxed/simple;
	bh=qpxkqniFqsfE95JUiw6oouGT8Ul4rggjTRmcJRWXDBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYrjBGVWSJwL0f1lCpJIVPOq+lAFMLT2gVkaL2JW1NDZiyXdPfdtptkkbOGpXsM70789RA8GQnUW/WDHTh2I3tO6Dcf+1p8/cjIn4AFfbeZ69yedzErC/qvxOJp+RvmaKZMAyeeLQBWE/CXytSkG+FhvG8XRLGqQOgBkY/k5sgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trhY/+AB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E2BC4CECD;
	Wed, 25 Sep 2024 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265554;
	bh=qpxkqniFqsfE95JUiw6oouGT8Ul4rggjTRmcJRWXDBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=trhY/+AB04GoXJVm8Whl9cSGAZKuPitnPjcbS7YfG7H7Xum/ejZWa72YBHby0VtHb
	 ZCVZx3zbFh/CRCc4TWymrebZOtbsxOOVPY803RG0G7eHTzvLvBnu5ZIt1A/e9Pkk0g
	 MSflWjXUoyopu2XliNCcMQQDuXxxuxXm+2RTGxlMv8kir0+njSQoQar0CVhdobYyF+
	 RaLGOgZIaLS++yR7VOrjO8ivyt39JG4Nn8oaBjb9HSwDIjylVU4YTElIw4qXWIz0Of
	 zMCgOtv2dLDjIeBri/MrQ5ht+7I9aAGJ+FA/dmzfYQB6ITKfId89Z2wyWbUZ9vnN0l
	 OuFLGqZWJRcjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tamim Khan <tamim@fusetak.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 020/197] ACPI: resource: Skip IRQ override on Asus Vivobook Go E1404GAB
Date: Wed, 25 Sep 2024 07:50:39 -0400
Message-ID: <20240925115823.1303019-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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


