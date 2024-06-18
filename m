Return-Path: <linux-acpi+bounces-6475-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BAA90CAF9
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 14:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D6D1C23124
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 12:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6743157476;
	Tue, 18 Jun 2024 11:59:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6ADAD15688F;
	Tue, 18 Jun 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711960; cv=none; b=kSUYmccUgzzte54LYDNAjLq6dLJLArErBVzHCq8Zt507yHUGDX3iCxE/l2/B+GkEpTmW/vwGPLfSAzZ+kDQSvKW0UMFGLweRq8TD+ZIRsp8fATkd5vgJ0UzRK+uVPt+y+wB0/d1BLHGTYhMB6uYlu8RgljWjEhR4ErwpvhqwCx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711960; c=relaxed/simple;
	bh=OFgcxovlRvwpT0CwjE+H4bQT2gq+ajV5CRw3gfHR+/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=enqscuh9fWYuOj6nrtqWdiIho2CHFh4OlMmeTinV9c0i/BoFn+9L8Rcgs8TgdupGshVUS1jXbayFLjkyelS+GSeSw5la1/rnokUopZ9saHsrZ5MtZiqcORbLWcR6PeChngTmvLjGxbUCaX54fN4xk0SbS+2pYv+LcFGSP5oLvG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 6B7C46026523F;
	Tue, 18 Jun 2024 19:59:01 +0800 (CST)
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
Subject: [PATCH v3] ACPI /amba: Fix meaningless code for amba_register_dummy_clk()
Date: Tue, 18 Jun 2024 19:58:45 +0800
Message-Id: <20240618115845.261297-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Defining `amba_dummy_clk` as static is meaningless.

The amba_register_dummy_clk() function is static and
is called during initialization. I think 'amba_dummy_clk'
should be NULL each time when initializing

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


