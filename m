Return-Path: <linux-acpi+bounces-10991-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DFBA300F7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 02:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9021A188806A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 01:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57545269D15;
	Tue, 11 Feb 2025 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxmnRTKS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F7269D0D;
	Tue, 11 Feb 2025 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237578; cv=none; b=DAM481v/QCSZ0Hzzd9cEKWxj1KG8R47j6cLzcaXtERm8nX3L2SUmFuqfBcjnWcFpO7dMSmnn/biilrMOkMd6ZApfV0RyT6ZYEDR4dWmLx9bx7OaZc319T09rHOIND7deueXYpv7/uFaOhovjtrhJ1xGWiX8oO3Mx7uD3Ol8P/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237578; c=relaxed/simple;
	bh=m3GJJXP8FNH7u2BPU/JIM8+CTngl0O9mfKYjUVidAJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lwx4rJxbQDNZlDkBMVSonNkoBkcAGoTdIwc59Akxae9C218SHX5j5Bjb6TrGgFR6YbkhixNLI9XI2FKiWqnpdeVaUrQGmC9fUUExd4UnH7g5Qz56u3sw+DZRf4e0Dn+zY8nU42Tw6rcZWcnLneNagj/O9DnmU5OZuMRtjSdlNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxmnRTKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC0EC4CED1;
	Tue, 11 Feb 2025 01:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237578;
	bh=m3GJJXP8FNH7u2BPU/JIM8+CTngl0O9mfKYjUVidAJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxmnRTKSVAucON3KwQNjq6H2ic1UNVXbAqWTXfZ9xqBhSW4NHSXeoe9Sb/2UCjBcA
	 FIlOEXJ594abi4zr2JTy0nCYGafuC3qxQu5jgPBLaaHW7sEMbXo79vkuxXo/GldnoG
	 mn4Ydo4VUmxjNxeJH7ciVln7UCKXnQKHmZp+eVy4SKkzQclBG0S5aWJ7Mk6WMbe4wg
	 3tfqrEI1cOCSnpQjcg7jUj/GLC0ZC9TK8qEYXjJVhzJdIu0zZUZ84QmShKOyjQLQem
	 E3OInurIVpWIMLrj4PFGeWN38CaSMyMuUcXh/mlztjw1qglb6KE1jNnIRfbUwpXnYk
	 FYToMQ0pBuUDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gannon Kolding <gannon.kolding@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 6/8] ACPI: resource: IRQ override for Eluktronics MECH-17
Date: Mon, 10 Feb 2025 20:32:46 -0500
Message-Id: <20250211013248.4098848-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013248.4098848-1-sashal@kernel.org>
References: <20250211013248.4098848-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
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
index b00dad7ea8d40..532674936a0de 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -482,6 +482,12 @@ static const struct dmi_system_id asus_laptop[] = {
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


