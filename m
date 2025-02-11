Return-Path: <linux-acpi+bounces-10988-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B0BA300A6
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 02:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040011883E27
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 01:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65101FBCA2;
	Tue, 11 Feb 2025 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/flqF05"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92DE1FAC4E;
	Tue, 11 Feb 2025 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237518; cv=none; b=C1Kc3uYlrX2OMQGH6bhLXhSZ5n2ICqG323AHq3sqXWWkNmsYD8n3VsRVdsrKvjnrbBbsFXri8gw4RnFSdKf2EcixfuD7YU/YgOiV12T6Ogu2lAQGsYcF35erOB76US4tMurImMMI+QyvqVyNH8398GFaQUAyNCxiLrUqtCn7eTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237518; c=relaxed/simple;
	bh=4EW6MTr5HsKmXs7QIO4MEotqn1ZDrm8EU7rTJmBn1TI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y3DLX2dSE0LvTp0+xn1SG4yVczq1h1K/BlybW0rnW5KvDbWTOqqCue739/B5rMyysXCRXSfdV9isemHqTpq36eAg/dLjKWn37l0epVLrnS8/JtQMBpQmIKXxtctc2WIlSiFZNBtj2ZxKtEnlgGD9+TlJJ5tPL5NPwvlMm4FoL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/flqF05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A07C4CED1;
	Tue, 11 Feb 2025 01:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237518;
	bh=4EW6MTr5HsKmXs7QIO4MEotqn1ZDrm8EU7rTJmBn1TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/flqF055czNbsMfy3LO0PGdchJ34AMgCReJyZQky5XKy5+iqD7EmnsF3XCKe8bqG
	 FtcHz2WYnAEiHE1+nEZZp5b3JmNIdQ6mguCxvrUx7c5SYjenP6dSrhUVyAyN7aCQqv
	 n/ly7xZWnC93bLEwR9Wh1G9gf0YMhXmoQXH0JOfWlKjTQxW3DGhsAnrFfaUK8LJI4z
	 Q4vUM9uvZVTwbCa0bAto0dZwm4yoAxETME/X5CwNR6fhOz6AZXnD74QdlXaA9EYfPk
	 2BZIoDpop8M4kEPaxoa9N3wIiZ2JruejIkX5BEuA4WH/0rWtS+n6M2UBg1AfDWzphm
	 Qx7HO+ReYPuiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gannon Kolding <gannon.kolding@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 12/15] ACPI: resource: IRQ override for Eluktronics MECH-17
Date: Mon, 10 Feb 2025 20:31:32 -0500
Message-Id: <20250211013136.4098219-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013136.4098219-1-sashal@kernel.org>
References: <20250211013136.4098219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.76
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
index 64d83ff3c0d90..96a987506e717 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -549,6 +549,12 @@ static const struct dmi_system_id maingear_laptop[] = {
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


