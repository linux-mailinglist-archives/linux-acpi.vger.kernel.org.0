Return-Path: <linux-acpi+bounces-8743-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9F099BE82
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2024 06:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9431B1F20587
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2024 04:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362B91531F9;
	Mon, 14 Oct 2024 03:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaOckwhb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F2D1531DB;
	Mon, 14 Oct 2024 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878273; cv=none; b=lR0zBLPqVefHKYk8Qozt7U1QkBkt7N16cqvwLk9Ac7vurOD0cT90mXHcQ2v3HRLxe9grGwyFigLowG6LOLeFGaSH2d3BUmv1OHZVW7zSG5GJGpk7vwh2XgnKj7ocxfDIHbe1jsADTjddtkOWJ8y1QtHtVMoQA/QaEkZ51gWjpjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878273; c=relaxed/simple;
	bh=6s3OGOHRU58VqivfciXiddSG7EoSd0koQvzd8DNnfSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofWz7O/glaRSVr+n5zVYvEPuG9gswxSZPKSkJB2S8GAo4aSAZKRQo4Vu+3d7kgwPeSH1/qM+DP+R8H7GWUKQ4tMSZnJ4kY5+94DgD5eKyNiKkvzYZAeNAnPWeapi81UkIegbFwiHhdaBtWQUB7LxhWQT5evwAcG1VqhFqofR2j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaOckwhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4FAC4CECE;
	Mon, 14 Oct 2024 03:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878272;
	bh=6s3OGOHRU58VqivfciXiddSG7EoSd0koQvzd8DNnfSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KaOckwhb6araNAVhOuuEoqi9n/FyZ4T/sds1lNewfFiETtCiN9wyKjZ7pod2lczRI
	 QVHrdqXezeGxgUMSSvEQSQHmfw+lo7e6B7XQpkGzfa+HH8naEWs+KxvclS8mdY1bMH
	 SnYa1svAdA5xqGdgwZv2TICGh8T5VfEnIWeLnm7dfYxgR6tmh8Q0zB5bPV59dg+vU2
	 ln7DwZX0i5VSt4U1WVA9nc3h4qm6CBFtBVP3eVf3m7qLVDDmHbKIPGzB0AoCxRONNH
	 beZrMp0rsj+alxmkuOp3tUoTBxPhwKzVA1oxCI7hZKh991jKtWiLc9h+g6EhHxZOob
	 PiDWm+ko1y7RA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 14/20] ACPI: resource: Fold Asus Vivobook Pro N6506M* DMI quirks together
Date: Sun, 13 Oct 2024 23:57:16 -0400
Message-ID: <20241014035731.2246632-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035731.2246632-1-sashal@kernel.org>
References: <20241014035731.2246632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 1af7e441feb08cdaab8f4a320577ed0bba1f5896 ]

Asus Vivobook Pro 15 OLED comes in 3 N6506M* models:

N6506MU: Intel Ultra 9 185H, 3K OLED, RTX4060
N6506MV: Intel Ultra 7 155H, 3K OLED, RTX4050
N6506MJ: Intel Ultra 7 155H, FHD OLED, RTX3050

Fold the 3 DMI quirks for these into a single quirk to reduce the number
of quirks.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20241005212819.354681-5-hdegoede@redhat.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 3d74ebe9dbd80..03110ed6a4f7a 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -532,24 +532,10 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 		},
 	},
 	{
-		/* Asus Vivobook Pro N6506MV */
+		/* Asus Vivobook Pro N6506M* */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "N6506MV"),
-		},
-	},
-	{
-		/* Asus Vivobook Pro N6506MU */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "N6506MU"),
-		},
-	},
-	{
-		/* Asus Vivobook Pro N6506MJ */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "N6506MJ"),
+			DMI_MATCH(DMI_BOARD_NAME, "N6506M"),
 		},
 	},
 	{
-- 
2.43.0


