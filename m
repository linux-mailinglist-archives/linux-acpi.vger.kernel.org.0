Return-Path: <linux-acpi+bounces-18365-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CE2C1FB25
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 12:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D116A18975E0
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 11:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7A41F4CBB;
	Thu, 30 Oct 2025 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTGaLXYs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EE515ECD7;
	Thu, 30 Oct 2025 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822081; cv=none; b=OXK5FE/Eo3x+/l6tQ8esu4nnou7F0jORViCMDOZRn8axGkK+1CRrBaKTgQrvzxUNrkbnanVN5wD4HFF+jwZK/5lzYRS0TfYPLT3ThAivmDj9orOUUU2wpb01oeHugrxsn+/r66oSN01ZRt/iNw0LaQBt8B2L56S8djd9dGPx8wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822081; c=relaxed/simple;
	bh=7NRtdWsF8EGto5PaTDdkn+ejUGowQrX0uCuh7PfD5P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DENRY2P3GJSosnWicSeJXRW5jge7Ph5uFI0AF2ztOQxW1oA3lc8dKa5eRY7DMS/6fyjYISk7CXwhfuxACmviIWNQKkSc+A6ByfbNcc+XQ61zZ5GWlOxFufeG6R8vmFFp7LiS5XVWP8bzRxqNJAygq9zOMAX0YrPLk1wUP7H/n9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTGaLXYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12769C4CEF1;
	Thu, 30 Oct 2025 11:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761822081;
	bh=7NRtdWsF8EGto5PaTDdkn+ejUGowQrX0uCuh7PfD5P8=;
	h=From:To:Cc:Subject:Date:From;
	b=TTGaLXYs2aj5FFxdFCs49+sFJr5OwZ0SABkhvG6MVUsJNOpAnaa5ZK1lFtOlBhPtu
	 tbtd2XtbPRKNoWeBkrtbv3SQNNnsFwsy1jh2VRIqQKaBktKt3sgD2fOV448gCufJvJ
	 t/s3i2XHgvynokL1nfGk4bCoi2IxDVMbYQhpWfvZ9M/PC+Y618SNCLL6dmJsmzbZ+G
	 cftaPaPSLos/OT6tUIwNuxfucnNZJfsosdfJKnUY91Fo4iGM51a8SMqVfpA7GlR3HR
	 PankLX0RaK6Y1/FECrtALOyrRywjbKilhVjPU5hEkrVCTs+MMlhahpT5mT7exvrR6v
	 aDEZ7E+DW9bGA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vEQP8-00000000x99-3kVH;
	Thu, 30 Oct 2025 11:01:18 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ACPI: GTDT: Correctly number platform devices for MMIO timers
Date: Thu, 30 Oct 2025 11:01:15 +0000
Message-ID: <20251030110115.1842961-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pavan.kondeti@oss.qualcomm.com, guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Use the actual timer counter instead of the watchdog counter.

Fixes: 5669d92f3efa4 ("ACPI: GTDT: Generate platform devices for MMIO timers")
Reported-by: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 drivers/acpi/arm64/gtdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index fd995a1d3d248..8cc8af8fd408c 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -430,10 +430,10 @@ static int __init gtdt_platform_timer_init(void)
 				continue;
 
 			pdev = platform_device_register_data(NULL, "gtdt-arm-mmio-timer",
-							     gwdt_count, &atm,
+							     mmio_timer_count, &atm,
 							     sizeof(atm));
 			if (IS_ERR(pdev)) {
-				pr_err("Can't register timer %d\n", gwdt_count);
+				pr_err("Can't register timer %d\n", mmio_timer_count);
 				continue;
 			}
 
-- 
2.47.3


