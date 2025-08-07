Return-Path: <linux-acpi+bounces-15568-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC87B1DB40
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 18:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486A51AA5488
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2742271479;
	Thu,  7 Aug 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qkw36kaD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA77726D4E8;
	Thu,  7 Aug 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582574; cv=none; b=nC1QZThvJG6EprLzMO8+xjtFqj1bFIc4kuubEkY+6hafB1I79vM1fZUyvRqKFVD49lHiHm061eKOHXNpGnoQsifQhor8bQhvSUCRGweei3+Ryums6sbclDBHMnxoJDHUCVd9VM+CqsxoWmCw3yP+aOSY/al/Q0urHA5fERzok6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582574; c=relaxed/simple;
	bh=V0zwWY5dCF706NVg1BhU/LV6NFl38SUmlax6Gx4zqYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Evy8w/orjo33JK+Az3/qmthTVlCsQGGwuhDl+AUGp8an5uU5PCu3vYjr7v/RRVxiWgObNKS90xBshD/9fU8aCrBTdTx8nJf/diOaJG/FknN/fwfvqmz5SWnXRVdSCH/+3YntGaabANi05jhe8EVcqScgXwnLFlDGsPdQwEMiCGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qkw36kaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C02C4CEEB;
	Thu,  7 Aug 2025 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754582574;
	bh=V0zwWY5dCF706NVg1BhU/LV6NFl38SUmlax6Gx4zqYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qkw36kaDU2xf8ZffwT5Bpq0+4qoNWnmA4PY6TyjLP1N+KfYWEWXT9yiNe2o1hDU+P
	 U+isEu+Yp8GnJf17tYjwuJFui7ZqnZPSEZQx7ZMKYNbAIXT0IfFAI77I1UL31df42h
	 zQ3LKOcd3reYs06AG4+dwnaZ9OzcknNjRx1VMmWVCF5a4WDyipc1SZbjndGca4KunI
	 FUuBEho4I6wcSyw5CQtMxh0J6N4Qqw++CAmQjlf0loZoOxy3pYeahe7naeSY5Kow63
	 xnUUU2MeNEfg4ajHiVh5ZSTaSL2yqTY52+KiwfVeELOWgbEk2xM4oCMoC16rQ/Bz03
	 wweQGUOb3YHMQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uk34o-004zf7-T6;
	Thu, 07 Aug 2025 17:02:46 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/4] ACPI: GTDT: Generate platform devices for MMIO timers
Date: Thu,  7 Aug 2025 17:02:40 +0100
Message-Id: <20250807160243.1970533-2-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250807160243.1970533-1-maz@kernel.org>
References: <20250807160243.1970533-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

In preparation for the MMIO timer support code becoming an actual
driver, mimic what is done for the SBSA watchdog and expose
a synthetic device for each MMIO timer block.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/arm64/gtdt.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 70f8290b659de..fd995a1d3d248 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -388,11 +388,11 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
 	return 0;
 }
 
-static int __init gtdt_sbsa_gwdt_init(void)
+static int __init gtdt_platform_timer_init(void)
 {
 	void *platform_timer;
 	struct acpi_table_header *table;
-	int ret, timer_count, gwdt_count = 0;
+	int ret, timer_count, gwdt_count = 0, mmio_timer_count = 0;
 
 	if (acpi_disabled)
 		return 0;
@@ -414,20 +414,41 @@ static int __init gtdt_sbsa_gwdt_init(void)
 		goto out_put_gtdt;
 
 	for_each_platform_timer(platform_timer) {
+		ret = 0;
+
 		if (is_non_secure_watchdog(platform_timer)) {
 			ret = gtdt_import_sbsa_gwdt(platform_timer, gwdt_count);
 			if (ret)
-				break;
+				continue;
 			gwdt_count++;
+		} else 	if (is_timer_block(platform_timer)) {
+			struct arch_timer_mem atm = {};
+			struct platform_device *pdev;
+
+			ret = gtdt_parse_timer_block(platform_timer, &atm);
+			if (ret)
+				continue;
+
+			pdev = platform_device_register_data(NULL, "gtdt-arm-mmio-timer",
+							     gwdt_count, &atm,
+							     sizeof(atm));
+			if (IS_ERR(pdev)) {
+				pr_err("Can't register timer %d\n", gwdt_count);
+				continue;
+			}
+
+			mmio_timer_count++;
 		}
 	}
 
 	if (gwdt_count)
 		pr_info("found %d SBSA generic Watchdog(s).\n", gwdt_count);
+	if (mmio_timer_count)
+		pr_info("found %d Generic MMIO timer(s).\n", mmio_timer_count);
 
 out_put_gtdt:
 	acpi_put_table(table);
 	return ret;
 }
 
-device_initcall(gtdt_sbsa_gwdt_init);
+device_initcall(gtdt_platform_timer_init);
-- 
2.39.2


