Return-Path: <linux-acpi+bounces-20143-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDB6D0D5A5
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 12:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AC9B3008186
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 11:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B3333F8B4;
	Sat, 10 Jan 2026 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pebd8ydp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7733F8B3;
	Sat, 10 Jan 2026 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045857; cv=none; b=rszw8E+OcXMv+8JRk4pzJgVDszo+NOh1ZJYGivj3xG8ytvDfh2f8O4bMT/WKDw4bXP322IBoziQwENN7/V6gQd8UZccuEMUJ0JsQn8AYtJjvVY06PtMDePlLwOmD71UQvdZs3LIhb4l3QZkEjXpI1LsP3FvQSxB0LB+2998sWZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045857; c=relaxed/simple;
	bh=O/vl07S9TMZbDYPKIT0hvCWn2P+kaBWOULhD1PnN3lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DbCet73+pIq7BbfZsdiE+Os3d3mlFu9HzYRr7rlNdxvyRPqg7yUPRboN8DiNImQk+YSqXVjdxezyiP1MFV0uqcVxhc8e1P4SS6j98B79ziBc/SJKXWVDjjOPr4ipHUz6ad7yAU1vcfzuOWAwnlJd7HwKs8EUe4Rph4/NCHNFLjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pebd8ydp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1D8C4CEF1;
	Sat, 10 Jan 2026 11:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768045857;
	bh=O/vl07S9TMZbDYPKIT0hvCWn2P+kaBWOULhD1PnN3lA=;
	h=From:To:Cc:Subject:Date:From;
	b=pebd8ydpWkG0QiXaotDwDwImnnfAHDxORNji53DpPuuzfqfeDuMPClIMVBoYeFdie
	 nSfqMvlOLWpBOwcWBN+BXBmBACLYDyXvM/tudInHxh0Ia5WwFTkUoPOY6mAStskaFB
	 SgIkOhm9VeLqpY9ULl2inQQeVTiyryhAIuJiZUTzh29jBmqz1IdVEDN3JZFjwdqLqp
	 w4O9C3qRISO8oQpEaxZivzMizgZ0mLSAdyylPc1aeBmax3yjZPqnBJ8cP0LcaCi2TS
	 4QKU+a5rGqBPqylBp6Tjwfk/e0dXAelbvetGEarRIx9bFEku6dW6VXEqLjGfzS8hKy
	 4Picmi1/vMhnw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1] ACPI: scan: Clean up after recent changes
Date: Sat, 10 Jan 2026 12:50:54 +0100
Message-ID: <12825056.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use LIST_HEAD() for initializing an on-stack list head in two places and
remove an empty code line added by mistake.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is based on ACPI changes in linux-next.

---
 drivers/acpi/acpi_platform.c |    2 +-
 drivers/acpi/scan.c          |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -136,7 +136,7 @@ struct platform_device *acpi_create_plat
 	}
 
 	if (adev->device_type == ACPI_BUS_TYPE_DEVICE && !adev->pnp.type.backlight) {
-		struct list_head resource_list = LIST_HEAD_INIT(resource_list);
+		LIST_HEAD(resource_list);
 
 		count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
 		if (count < 0)
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2602,8 +2602,8 @@ static void acpi_scan_postponed(void)
 
 static void acpi_scan_claim_resources(struct acpi_device *adev)
 {
-	struct list_head resource_list = LIST_HEAD_INIT(resource_list);
 	struct resource_entry *rentry;
+	LIST_HEAD(resource_list);
 	unsigned int count = 0;
 	const char *regionid;
 
@@ -2660,7 +2660,6 @@ exit:
 	acpi_dev_free_resource_list(&resource_list);
 }
 
-
 static int __init acpi_reserve_motherboard_resources(void)
 {
 	struct acpi_scan_system_dev *sd, *tmp;




