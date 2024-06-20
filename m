Return-Path: <linux-acpi+bounces-6546-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E491066C
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 15:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE601C20D50
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4D91ACE9B;
	Thu, 20 Jun 2024 13:38:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A4E8740875;
	Thu, 20 Jun 2024 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890703; cv=none; b=YcSGCAI1M/3PkEfvB28MIAtGRIeLbkAXDtSiRpsSFOzIt68ATu2pbjwKwDDbd6sG8ZG5xb314EZjHJyPaupsfaVJrQ/s/HXPhqrb5utDL24TWNZcFDYIvnbLt+NIyaT6f2D/YJvR2G9xG33IPobXQuTdqiQenhGuu/yPFtRmejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890703; c=relaxed/simple;
	bh=unEzMvww3pesd5qyBOZ279APJqn8wjX88d/51G4IfTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=FzAZm/j2c4JmNQiycHnwv35tEsLBXOjU4tMaCCEQNSivPxx9pwHyZPq1F93/4HzIs5ZgXsKkoglsG7IRURtWNQXBod53TeWwSoJZ37vCENTImip4zbpWDUpCIoMl0UsOTHlG9Nal6nTIKxxIwEe8UZUP0nUE3uaqa0N3x+9qbjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 28B9F6047F7D1;
	Thu, 20 Jun 2024 21:38:10 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.2
From: Youwan Wang <youwan@nfschina.com>
To: youwan@nfschina.com
Cc: guohanjun@huawei.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	rafael@kernel.org,
	sudeep.holla@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org
Subject: [PATCH] ACPI / amba: Drop unnecessary check for registered amba_dummy_clk
Date: Thu, 20 Jun 2024 21:37:58 +0800
Message-Id: <20240620133758.319392-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240618115845.261297-1-youwan@nfschina.com>
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
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
v1->v2->v3: Modify the commit log description
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


