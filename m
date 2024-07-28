Return-Path: <linux-acpi+bounces-7094-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD29293E23B
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 03:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C11C1F21B88
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 01:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A44B18D4C7;
	Sun, 28 Jul 2024 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWuJOZDU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2159518D4C0;
	Sun, 28 Jul 2024 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127786; cv=none; b=hW9mV9OtTzWzqbMFwRrGzzVi+97fepV13CvSg6/3U/BNecZO2mLQ6hwIrNFl6qEq2+y70xKKJxekU3xUsr7A2bRV2h3OX+gFetHg+djnD2Y+QuClAWVTJwEzMub1hzuv+L37/B2cEpHc4sFmw4fYvhUJgpYXkU41zYoSq2g43jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127786; c=relaxed/simple;
	bh=dfL6nUd736Ko8yqvhWSOiVZCukQeod2Sl5vpCm0HrFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmI9XIE39/BUXUeVbIEujd22fH0mAtZCDeImDQjtDRvRyzjFca9zzAx9pwIg8HC2jMbq1lM8NFZythSFE+F5qTw9hXrUxx2AVt0ANA77OCE+rAGzo6CpJdtPZL99tzCNNcKXMVgkKWMuvY45cMu8GZ2QhO9mJ6XhZJYhlJDn6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWuJOZDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F083CC4AF07;
	Sun, 28 Jul 2024 00:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127786;
	bh=dfL6nUd736Ko8yqvhWSOiVZCukQeod2Sl5vpCm0HrFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hWuJOZDUP9ROkOorSCefX3VrnQ5DOFZy9YpmBhuWFQ4v+bkOen9dOPAnuAPu/fEIE
	 +ig5VVT15e3wEDkEMhgTDKgMJ0oFoLOUsHO4kQlwj5GI39dNPrCWUbogRXsI4MTwB+
	 a6CD7YRy2OJMc5MF0duX3xp5JIu0TE4GTBecRsUu1frMqTsUfNWcDak/yIwUGTlQWi
	 XKWTj8V3vAixggi00m1uZw926lgDo/oqd4tagyuHTmTJZTq5xhHesZ1F1uFrsw89r3
	 SuBJs84S86+ZOFUz2jYYXPkLpXzBQW5QoG9pPKKMlZsyw4lm9ZXYquDEI/wByaEWNz
	 K3HHnv/KcSWZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tamim Khan <tamim@fusetak.com>,
	Lefteris <eleftherios.giapitzakis@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 7/9] ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MU
Date: Sat, 27 Jul 2024 20:49:27 -0400
Message-ID: <20240728004934.1706375-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004934.1706375-1-sashal@kernel.org>
References: <20240728004934.1706375-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Tamim Khan <tamim@fusetak.com>

[ Upstream commit dc41751f9e07889d078e3f06adb6e892c80b7c10 ]

Like various other Asus laptops, the Asus Vivobook Pro N6506MV has a
DSDT table that describes IRQ 1 as ActiveLow while the kernel is overriding
it to Edge_High. This prevents the internal keyboard from working. This patch
prevents this issue by adding this laptop to the override table that prevents
the kernel from overriding this IRQ

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218954
Tested-by: Lefteris <eleftherios.giapitzakis@gmail.com>
Signed-off-by: Tamim Khan <tamim@fusetak.com>
Link: https://patch.msgid.link/20240702125918.34683-1-tamim@fusetak.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b5bf8b81a050a..b3ae5f9ac5510 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -524,6 +524,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "N6506MV"),
 		},
 	},
+	{
+		/* Asus Vivobook Pro N6506MU */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "N6506MU"),
+		},
+	},
 	{
 		/* LG Electronics 17U70P */
 		.matches = {
-- 
2.43.0


