Return-Path: <linux-acpi+bounces-10992-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ADDA3010F
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 02:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106EA162261
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 01:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D489026BD85;
	Tue, 11 Feb 2025 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UC7/TSSl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FC126AF1B;
	Tue, 11 Feb 2025 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237594; cv=none; b=Tt96JpVL9V7b1B6HeTBhpkaz5EJXRcGAvDBE98rdwVK1K/dcUbjJm8zuWtrgJrVhX92pNzucdYMgHklD9bK5zC6HWF84PkxCVsGTbi1Wp4uIXiTj7afR1NIKKwYQRZqX74kYEzzmqurnZp+l5ufA5MFTukUPF9bcR27P6M6ytX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237594; c=relaxed/simple;
	bh=E5LmpeFAtLI6LtdbB2tnrznp67tncjJzsmwwr77pD3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CU3VOTUz5oIIrEPpwRpVM5UNmOrgfL3Grl4sHzdlbczCP4ZQxYnPVfVm/lH8Stl2WQ2ywRiP3HRgbbTQI3tmPUkApbI+Izqj28wLeaTAvVotd4fwfKZeUWQwjfURmJo4rF0EgpjN3Cv0XQ3bhLvmvM+msgbXpJIaaujakUbOjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UC7/TSSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB67C4CED1;
	Tue, 11 Feb 2025 01:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237594;
	bh=E5LmpeFAtLI6LtdbB2tnrznp67tncjJzsmwwr77pD3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UC7/TSSlN0c587xPuI50aDJG/E3BjjSGgCbgrQJofn3Yc+HnQ5WMxQJuAJIXu2sJ5
	 w8Z/0eghsmUUaNpNtESKH0WnWhO5UoiQUOhavtykZW9ojCSF2huPR2K1sIVrn85dem
	 MGM8vKqAA6hqpYjh08ke9jnzpG+QfXqARezfjgG7qx2KZEp/FyvKhyTcF4mm0ojwAq
	 SxWtJSmFk4f3UWsTTvbt3kgqT9GVxGdVm5L9aUelGxFw+ushz8NWbgQhFYUDD5FG8s
	 z5rz9Fh4V4WuqfORSBqAMR6HQXxc2MSkax4E7ewjRdwdTNzI84pWxF4egfB7YsVDVF
	 cjGrDvKRvO5XQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gannon Kolding <gannon.kolding@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 6/6] ACPI: resource: IRQ override for Eluktronics MECH-17
Date: Mon, 10 Feb 2025 20:33:05 -0500
Message-Id: <20250211013305.4099014-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013305.4099014-1-sashal@kernel.org>
References: <20250211013305.4099014-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.290
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
index 2750518a5d5e1..11264bb4061e7 100644
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


