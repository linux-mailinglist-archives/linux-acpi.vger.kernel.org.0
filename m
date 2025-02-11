Return-Path: <linux-acpi+bounces-10986-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8736A30047
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 02:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBE3188554F
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 01:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE751EBFE1;
	Tue, 11 Feb 2025 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkojelER"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F21EBA14;
	Tue, 11 Feb 2025 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237436; cv=none; b=WkLTcKF2vMW4iS0fBjzlbf3OfB3nBdmtcGcoK3DI1J/xk3wrBzgZQBnaF4j2S6f2xZuVecBT61rLpTRrZSu7Y7DyWkfySACaXyLb3CGe7viCnhVMkfUAy0rzeBRC+uMQn/tHja64gdrktb91PO3N0C1yAJaoYmVIzMJVteH8A1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237436; c=relaxed/simple;
	bh=ySLUvMMBTHzlJLmqpRqysEHyKgwvuX6j+Zt4vOn+2mU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dv1gNxxxFr/3LNfhkzS18lPrC19y3Wf4y9XBScdE+ywaZzTW9ZC3xZPEVI3Q8TvFb9iuUs9NE/27wqSPgbQzOxTY+WbTfApWMObOsDZtJj1j/XrEE+muTbta5v3qZE8n1/ldmYR1yat0E0NxmXOjEeQ/tqYBQSD9DmQeq0ucRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkojelER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C82BC4CEE8;
	Tue, 11 Feb 2025 01:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237434;
	bh=ySLUvMMBTHzlJLmqpRqysEHyKgwvuX6j+Zt4vOn+2mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TkojelERE3v0qUXNhU8NCamODqmT/TCaUYb5zbgvNkcdjSlxdQ1RQ7QOIOFj40pfD
	 ToK0MIPZjmvspmZ/hgHuPxnEfgl0o8PnWsSD72+pS/NVwFEqzFBxRCwGenqxNdeze7
	 79ziU21Eqb4zKfUQ3W2mVa0lIRbZCL+SdUnXRbuwnlh++sDRvwU/BwR9qG56Bvj+jn
	 PY2iZf+UNbQtsEzuuMfhJvL9f+HRQqLiEFKHq59qjBxUakAPHtR3OnEHvai5Ie6X2p
	 GCYg4h/8qr/z1JmMuyiXZ3ZFQDAHSEBB24SNmxmbQZsAXjUyCWznubfu85//cwL3Q6
	 G1oIrOAy3+D3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gannon Kolding <gannon.kolding@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 17/21] ACPI: resource: IRQ override for Eluktronics MECH-17
Date: Mon, 10 Feb 2025 20:29:50 -0500
Message-Id: <20250211012954.4096433-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211012954.4096433-1-sashal@kernel.org>
References: <20250211012954.4096433-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.2
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


