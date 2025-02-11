Return-Path: <linux-acpi+bounces-10990-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD51A300E2
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 02:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B1B7A1CBA
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 01:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685FD267B8F;
	Tue, 11 Feb 2025 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZREVKlx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19B267B8B;
	Tue, 11 Feb 2025 01:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237561; cv=none; b=mGeICUTQRkRVjl3qafrGFYMDahbiEoeMN8qKbgGbsk4J+EIHn/9lPzCqGk+JrtWgXJtJ+WOnvUZ+7zEj3UFbizDcxvhlkseM0OCyN50KRrQPsgUV+RYSOIbASO9sSQNl1iuFS+dQRtvmRrwXsTGxqqO2kKTLpNV3WbhEuIyaMgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237561; c=relaxed/simple;
	bh=prVPRtBjWN0+3HJwNcgtYcpqvfJXFB+/CbjAL6ebzmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eekPTeUdR815W6D6VuSjqgz5wUmFQG56/f0DDL3LqIC3iV48olh25hiUXe8CElV9ck8JEGQOj2ZkSD0hWejIWls7MqJ+QXXxPnF7MaCQBYWgTZp39Hqm0rf4KagmQDEsFfgAOT2StOp11cFAFkuWXWdke5lT2wwFFEeEsIv1TOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZREVKlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7C2C4CED1;
	Tue, 11 Feb 2025 01:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237560;
	bh=prVPRtBjWN0+3HJwNcgtYcpqvfJXFB+/CbjAL6ebzmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZREVKlxCMeYFMI19zhSe+RdLK+qs/H6FZjB/+nAneo7XKqTwEEHZS52b69vPYb9l
	 9dZm2aCmoyLvowVePExpTt7rbiLBLGp6boEgnvgoj/NE8NmnUJ/P5Dm842hfZ+m9eT
	 W8FW+ok6KYAdbpCHNFm0yNRnQ+92c8gmAhrgmOK7v9XaK3mj6SAn4z+dq8X1GfhkhP
	 /A+ibMmU0j4mF3jf2/0kNnfGU7ih3eyQ6qkWEXygE0vDQl0ceB/D38ouGvFra6dqFn
	 vHF6oCTgN7vx1G5M/ZFA/9XDCUSu0Nl8K3OyiebI8ACOSIOqPkz32ap5vzGCObwDgl
	 VkQZPrqBKrE9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gannon Kolding <gannon.kolding@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 7/9] ACPI: resource: IRQ override for Eluktronics MECH-17
Date: Mon, 10 Feb 2025 20:32:28 -0500
Message-Id: <20250211013230.4098681-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013230.4098681-1-sashal@kernel.org>
References: <20250211013230.4098681-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
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
index 56bbdd2f9a40d..0735ad7f01e22 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -556,6 +556,12 @@ static const struct dmi_system_id maingear_laptop[] = {
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


