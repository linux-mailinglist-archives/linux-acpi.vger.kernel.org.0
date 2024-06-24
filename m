Return-Path: <linux-acpi+bounces-6593-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE23914083
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2024 04:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FB31C20B7F
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2024 02:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE37442C;
	Mon, 24 Jun 2024 02:31:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 5833C391;
	Mon, 24 Jun 2024 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719196317; cv=none; b=fjycwRfbuhCQg6vu3yGBT+E0TriJM/E58FtGMm0nJqbN2xQHFMLmM2uNZ+9He74Hlws+5V3degB61/cXofaYuIolEe64d/GE3cHYLvi2ZD4fzjLJ/yWB09NgYp454jN0nyqI+wvFDD3BT1kHLjQD8XznLg5gfU6IwPsE4KD9h/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719196317; c=relaxed/simple;
	bh=1DqsrIC0umS0g9MFEC1sErDNk2CMpDBQ4Y6d9GKSI6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=WQVF5mZhAvaTzl6pPw7TulNh/uK85GcJUYAI9dErnuuDr7w3VXVz2rmWgRJ0mY5I9pgttXCLNN+3Nwfag35puRqh7OV6JO6zYw0+3DWQ6+YSmkZT8AIGPz8IeUtsN0/fn7ror+67vKfi1YBQ6bV8G33eLkinZqanKJ0/TaFfEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 31FD46019EDA9;
	Mon, 24 Jun 2024 10:31:12 +0800 (CST)
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
Subject: [PATCH v4] ACPI / amba: Drop unnecessary check for registered amba_dummy_clk
Date: Mon, 24 Jun 2024 10:31:01 +0800
Message-Id: <20240624023101.369633-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620133758.319392-1-youwan@nfschina.com>
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
Acked-by: Hanjun Guo <guohanjun@huawei.com>
---
v1->v2->v3: Modify the commit log description
v3->v4: Update the commit message suggested by Sudeep;
        Add Acked-by from Sudeep;
        +Cc ARM64 maintainers Catalin and Will.
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


