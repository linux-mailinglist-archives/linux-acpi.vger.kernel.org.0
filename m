Return-Path: <linux-acpi+bounces-11582-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DADA48A22
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 21:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA291881411
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 20:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7671326FA77;
	Thu, 27 Feb 2025 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+jJARk7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E01AF0C9
	for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689460; cv=none; b=s5TlGWjLToVOAQLMQmzqE8PKj+W8pTSX5/HsAXzgX1gjdarMDy11PZ4eNq25jsRpz81PKLgUhK2vJbyMUzdAqHvKZp5aSRJMtAAU6+AHsjLmFMVT+XrgWv7VxPUlhfi+AXKVIVPVwf+lUxSiWRfm4pPS9DUZdY7rbHCh0ICtkf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689460; c=relaxed/simple;
	bh=qgrZ1xKbDxYULuMqytvj/KJ/YtRdjGY1V+Wsh3hcqS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wje0xfPw5oxQJeVXy8JSHu6mYxCT3t/tOYQobI0HaS8NJoM0Jj43KA8ISdKwHAFkkw2Knc28sQARAFVWvd+ZogxFfG3i2lJHLC1bNtdZZEpUKvmyDXvpq8RL7NDBRpH7NsfggNHnIRX1TOdJetoWan37zOigDF76fA6Q5yJj8G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+jJARk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FABC4CEE7;
	Thu, 27 Feb 2025 20:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740689459;
	bh=qgrZ1xKbDxYULuMqytvj/KJ/YtRdjGY1V+Wsh3hcqS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+jJARk70VoiArjZ7cww2V6aTbW2hq9arwhRI5k9063bAy20jkxJaEo/G+N2x9LLl
	 dVWMOnKTwxyIvJfr+tWHTb5ChHxYT7USBucrj2NOy/YsGZKalySVMF+DYvdbXrNmeM
	 1+dsW5LMNaeSK2BQ5J5KOWXhmjAypsEDLCTmAN7uwdWHK5NgFxV41owtngV+dKvUWf
	 LVx1Dgdj+khKpTRPVUnYgCXYuy9OmJZsry89huw8qAAbTCaDYI3AoTGjowYChcaBGw
	 6U2Yc7thK9BW26wCjEKGC+UOTiBafJuEmOSSKL/xvleDlyt0+S5Gkomltt6AGhuCPA
	 KBeeyMu6UMAaw==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org
Cc: kernel test robot <lkp@intel.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH v3 1/2] ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
Date: Thu, 27 Feb 2025 14:50:16 -0600
Message-ID: <20250227205049.765309-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227205049.765309-1-superm1@kernel.org>
References: <20250227205049.765309-1-superm1@kernel.org>
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


