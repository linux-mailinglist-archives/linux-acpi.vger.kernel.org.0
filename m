Return-Path: <linux-acpi+bounces-855-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E617D4113
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 22:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63251C2037B
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2E123745
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="R+rP9eZt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DBA224D3
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 19:41:04 +0000 (UTC)
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Oct 2023 12:41:01 PDT
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD9A9D68
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 12:41:01 -0700 (PDT)
Received: from localhost.localdomain ([141.170.221.62])
	by smtp.orange.fr with ESMTPSA
	id v0fzqGEQclciav0g5qWHER; Mon, 23 Oct 2023 21:33:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698089610;
	bh=kOczc4xzag/NnlA9XkZf9hv4EVckr0nepjgeN8+fjfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R+rP9eZtOV0Gu0NgUyXgpD5G0f7Mtnczfb9ANQB6jCAf4xSPtHm9RgbLkUnE2KTiG
	 bMzIpIpSvRY8aVNbezdI543C0GvzU2WBn/AWvO8yTCymF+IEThHhmXyh6W2hnYgjih
	 47nmsTCLNMt1SjjO/t++jo/H/DcBtu2tBh45kl+XeeoQpwnjyNt3woqlqbN//11jK6
	 CtGtMniOzX2+jIp2J6vd40m9penXIjlljjSx21ozWTrFgNdliWCUSKO7hP1+Or8TDU
	 LKjitwJAjSQjTlfkrtnqGvNXfrsVHmTIUD5mWrnIkAGnvWaMQn4dhqj183ecjJOEyL
	 /8FbvSHUFvyOQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Oct 2023 21:33:30 +0200
X-ME-IP: 141.170.221.62
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/4] ACPI: sysfs: Remove some dead code
Date: Mon, 23 Oct 2023 21:33:18 +0200
Message-Id: <eb978f8d3141857438a134885e9c38a75bf2245c.1698081019.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snprintf() never returns <0 values.
So remove some dead code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/acpi/device_sysfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 1cf6568a813f..23373faa35ec 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -168,8 +168,6 @@ static int create_pnp_modalias(const struct acpi_device *acpi_dev, char *modalia
 			continue;
 
 		count = snprintf(&modalias[len], size, "%s:", id->id);
-		if (count < 0)
-			return -EINVAL;
 
 		if (count >= size)
 			return -ENOMEM;
@@ -228,8 +226,6 @@ static int create_of_modalias(const struct acpi_device *acpi_dev, char *modalias
 	for (i = 0; i < nval; i++, obj++) {
 		count = snprintf(&modalias[len], size, "C%s",
 				 obj->string.pointer);
-		if (count < 0)
-			return -EINVAL;
 
 		if (count >= size)
 			return -ENOMEM;
-- 
2.32.0


