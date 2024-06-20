Return-Path: <linux-acpi+bounces-6535-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1F990FAB4
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 03:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65AC5B21CF8
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 01:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C74320B;
	Thu, 20 Jun 2024 01:00:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D5E3E19B;
	Thu, 20 Jun 2024 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718845218; cv=none; b=LsNx/Q1f1oRI2b/JpnBoTQjZquQIdzuLr5TJTxMvxdeXRV9b8ikiG1jhFuXaZjlxcf8Qb6OgSb9tsJZf4Gc6pZIPyeZTTBZnAbm9wcEOwpXRyWDTCYYY6+xizLrhDhlul7NXK77P4z7FEqDYbl04i9gjCF3EcxwTQe+1Pznj/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718845218; c=relaxed/simple;
	bh=klzghpBjDk64y3ejZgpH4rEFxWmyCGcl1y3qRLh7s1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qhGUyFXRm5Ev6DmwVqho2gbWwZNvsMuewOCAD5C1EbCxa2AQKkfOMo+VR/RzEbuZtYfx8V6+e65xjFDhKz/1Q6HlP4E/G9CiWYqTxhy0Vyc/4IUr04FjAL1ueys7zUsKtss2Azf0B+/xZMLuZXz8X5pXmwo3sUiZJn9QU3SFCyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 0DCF8602FFF57;
	Thu, 20 Jun 2024 08:59:39 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.2
From: Youwan Wang <youwan@nfschina.com>
To: lpieralisi@kernel.org
Cc: guohanjun@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	lenb@kernel.org,
	rafael@kernel.org,
	sudeep.holla@arm.com,
	linux-acpi@vger.kernel.org,
	Youwan Wang <youwan@nfschina.com>
Subject: [PATCH] ACPI / amba: Drop unnecessary check for registered amba_dummy_clk
Date: Thu, 20 Jun 2024 08:59:30 +0800
Message-Id: <20240620005930.295880-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amba_register_dummy_clk() is called only once from acpi_amba_init()
and acpi_amba_init() itself is called once during the initialisation.
amba_dummy_clk can't be initialised before this in any other code
path and hence the check for already registered amba_dummy_clk is
not necessary. Drop the same.

Signed-off-by: Youwan Wang <youwan@nfschina.com>
---
 drivers/acpi/arm64/amba.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index 60be8ee1dbdc..ef438417cc80 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -35,11 +35,7 @@ static const struct acpi_device_id amba_id_list[] = {
 
 static void amba_register_dummy_clk(void)
 {
-	static struct clk *amba_dummy_clk;
-
-	/* If clock already registered */
-	if (amba_dummy_clk)
-		return;
+	struct clk *amba_dummy_clk;
 
 	amba_dummy_clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, 0, 0);
 	clk_register_clkdev(amba_dummy_clk, "apb_pclk", NULL);
-- 
2.25.1


