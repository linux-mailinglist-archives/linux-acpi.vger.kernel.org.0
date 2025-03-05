Return-Path: <linux-acpi+bounces-11872-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03289A50E44
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 23:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C406188B389
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 22:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C9A266562;
	Wed,  5 Mar 2025 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhg7u9C6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AD2661B5;
	Wed,  5 Mar 2025 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741212117; cv=none; b=s3hvrNLT6JUtSnGZGqbKw6IQUR3ry0CFUqHItVG5jzWLTC3QDXztqAA9RTUQnD417hAKyix0rXR+zshyRrnjhWQ9vgtwZs2uyo9t2j+eBF+i2uAWgwp3xzMkS8WZ7DBqZNZN25l8QkQUJePOb4f5Zn7M7njFpFiBZ9MXbWa0jbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741212117; c=relaxed/simple;
	bh=qgrZ1xKbDxYULuMqytvj/KJ/YtRdjGY1V+Wsh3hcqS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZWJBQHKg0rPed0L6PrBI09CJ8c6+lEvWF6/8PPfiGV7OvJQZF6lmC7n3aRpTxq9IuUREZJ1PU13ToBH+fRY8fKZboyxzbAW7WjKkYnMnFP2GFjf76jrwDluTMwVayAVWuwpvp1dOtQgmcBvL6PIh+sw6V1ypMRDlKChnElrMm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhg7u9C6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14514C4CEE7;
	Wed,  5 Mar 2025 22:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741212117;
	bh=qgrZ1xKbDxYULuMqytvj/KJ/YtRdjGY1V+Wsh3hcqS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhg7u9C6jkqOJRMy1U/KCTHuULVXdiXUg+enBU04SzcY4tXOphD4+SOI5u0Cn0uek
	 z2qXpdjjMO32glSFYL92UydtX/ic7w2uV3Q1K0M2c+UrIP2g2Qe2ee0/LA3MXa7TWH
	 20IfR8bqtl20v1Js1tvVpnQNx3wAPb1UIEO37oLRAa9uxyqs/bkDrtqHsPxZLxVYxk
	 NdSLMNfB4Z7GhDeZtxi5IwZz9LK5xGHLwwUHI6uT2rg2FwS316jWrjQ6Cy9sWe6U4m
	 rB/2xMgHyGrpwOmD+s566j9WpBmcI14P2VGs9xue8BDHRxOYPJAQe/C9tBMOxfjazj
	 CXNcoNwAO6VpQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	linux-acpi@vger.kernel.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 RESEND 1/2] ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
Date: Wed,  5 Mar 2025 16:01:45 -0600
Message-ID: <20250305220146.3932955-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305220146.3932955-1-superm1@kernel.org>
References: <20250305220146.3932955-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

acpi_register_lps0_dev() and acpi_unregister_lps0_dev() may be used
in drivers that don't require CONFIG_SUSPEND or compile on !X86.

Add prototypes for those cases.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502191627.fRgoBwcZ-lkp@intel.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Add struct acpi_s2idle_dev_ops outside defines too
---
 include/linux/acpi.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4e495b29c640f..8d2abe5dede93 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1115,13 +1115,13 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 
 acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
 					   u32 val_a, u32 val_b);
-#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
 struct acpi_s2idle_dev_ops {
 	struct list_head list_node;
 	void (*prepare)(void);
 	void (*check)(void);
 	void (*restore)(void);
 };
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 int acpi_get_lps0_constraint(struct acpi_device *adev);
@@ -1130,6 +1130,13 @@ static inline int acpi_get_lps0_constraint(struct device *dev)
 {
 	return ACPI_STATE_UNKNOWN;
 }
+static inline int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
+{
+	return -ENODEV;
+}
+static inline void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
+{
+}
 #endif /* CONFIG_SUSPEND && CONFIG_X86 */
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
-- 
2.43.0


