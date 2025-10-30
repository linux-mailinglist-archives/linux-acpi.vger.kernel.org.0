Return-Path: <linux-acpi+bounces-18366-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A4EC1FB01
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 12:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D03AB4E1EA4
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 11:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE61524169D;
	Thu, 30 Oct 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTC0Ps6J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858393595B;
	Thu, 30 Oct 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822102; cv=none; b=itLjRtnVhJsG1Ea8BDqOATAvh0k4ATgttlP7GnQhTQ/cAPlxkmjqoejWMlmxfrWKbJSGKunBn3faDd8C2GH1cpW24/qX5ojlEHu9/sb5pkB77sBDqNBwVB5Cp1Uhyd2VHUYzb9a1FGw3GyKvHNiMLfmr6BM+EQ+GVwbtfN7RetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822102; c=relaxed/simple;
	bh=pbhBnQlD+ZJLKzn9PCW0WP9IW4K3HSFliaB0o7tNIok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWFmEXphUmOlEqbCapTCRwYC+/f5UUP/dGWz4lk9W5x7B0reYRIkq4cytcaMHWWb/K4H4ByIijo5govNlQOjUbop3DTU0gKC8gUL91rRihC8OA7VD57KOro87O+GiYG3+BB8ovDhy9j0mU/dR+To4Mco170hhu1OH6i25UEBve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTC0Ps6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BA8C4CEF1;
	Thu, 30 Oct 2025 11:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761822102;
	bh=pbhBnQlD+ZJLKzn9PCW0WP9IW4K3HSFliaB0o7tNIok=;
	h=From:To:Cc:Subject:Date:From;
	b=RTC0Ps6JZmDhKLUGwQ2oB7YC6Zxi+k4vFukpLqVVXwvpu+Es6YYOBd6PzMvoC02YV
	 9tgeu8nGXeej01ao88Luvlyk76SmIPWr9dbF5Leda8HaseGeQbnCsqL+naFUNy/u3Z
	 ulbqLfbUbdDg7bLKNs8cJPuAfvtbuvWpQ7925Bm+17C4wEhczUzASHvD2f4w9BkHu+
	 G/87oke0dPsBmEL7hRzRmPAnZCKWyNxcLoKeXsAymrmllIt6I476EUKJynOT8hl1zr
	 tw4fnTlUlJ3LLPVTkt1s0PYcYu9FsPbay1looiC/Ph0apeTGyzzAZ9+YZkXafX2RuX
	 Zx2xBtvB5Dw0g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vEQPU-00000000x9p-0NR2;
	Thu, 30 Oct 2025 11:01:40 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ACPI: GTDT: Get rid of acpi_arch_timer_mem_init()
Date: Thu, 30 Oct 2025 11:01:37 +0000
Message-ID: <20251030110137.1843007-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Since 0f67b56d84b4c ("clocksource/drivers/arm_arch_timer_mmio: Switch
over to standalone driver"), acpi_arch_timer_mem_init() is unused.

Remove it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 drivers/acpi/arm64/gtdt.c | 34 ----------------------------------
 include/linux/acpi.h      |  1 -
 2 files changed, 35 deletions(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 8cc8af8fd408c..ffc867bac2d60 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -303,40 +303,6 @@ static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
 	return -EINVAL;
 }
 
-/**
- * acpi_arch_timer_mem_init() - Get the info of all GT blocks in GTDT table.
- * @timer_mem:	The pointer to the array of struct arch_timer_mem for returning
- *		the result of parsing. The element number of this array should
- *		be platform_timer_count(the total number of platform timers).
- * @timer_count: It points to a integer variable which is used for storing the
- *		number of GT blocks we have parsed.
- *
- * Return: 0 if success, -EINVAL/-ENODEV if error.
- */
-int __init acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem,
-				    int *timer_count)
-{
-	int ret;
-	void *platform_timer;
-
-	*timer_count = 0;
-	for_each_platform_timer(platform_timer) {
-		if (is_timer_block(platform_timer)) {
-			ret = gtdt_parse_timer_block(platform_timer, timer_mem);
-			if (ret)
-				return ret;
-			timer_mem++;
-			(*timer_count)++;
-		}
-	}
-
-	if (*timer_count)
-		pr_info("found %d memory-mapped timer block(s).\n",
-			*timer_count);
-
-	return 0;
-}
-
 /*
  * Initialize a SBSA generic Watchdog platform device info from GTDT
  */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5ff5d99f6ead5..22b377c3a3196 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -755,7 +755,6 @@ int acpi_reconfig_notifier_unregister(struct notifier_block *nb);
 int acpi_gtdt_init(struct acpi_table_header *table, int *platform_timer_count);
 int acpi_gtdt_map_ppi(int type);
 bool acpi_gtdt_c3stop(int type);
-int acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem, int *timer_count);
 #endif
 
 #ifndef ACPI_HAVE_ARCH_SET_ROOT_POINTER
-- 
2.47.3


