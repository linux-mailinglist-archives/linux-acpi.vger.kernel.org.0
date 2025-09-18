Return-Path: <linux-acpi+bounces-17117-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22B8B87053
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 23:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC72A16BD0F
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 21:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD612EC081;
	Thu, 18 Sep 2025 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUk00Vbw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50824501B;
	Thu, 18 Sep 2025 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229850; cv=none; b=kD4jlA1tLAAxz7cCvwf7wmsfsXcxgsonuOWWPQ2/rSWWGMTMo+t4xoMpI0uu9rSE+XCbODPC2StEYHsF8lUgBerCgbzYFUTZge9WVJ5qE7lOJNgB2lHlA4DGBtKTWzUZafxXUNXC1SksIjkfY4Lf+I7hdNi3igQCfyydF105MpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229850; c=relaxed/simple;
	bh=wlNjaTZImKf2AeG6/odvaHilnkAGYMvkVffoJRmrn70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KM9UxOi4BaYDHj5fOLDZI8pMvko6SUnPHiF+rpkOGqhR/VZnlT86ilCYp30IaOCv1dOkGY6UHgaC96qt7t4VfvhxqqNtQQlPH21wevOgvPHJGic44uC0GTvLRh3neV+7U8aAvNwB+fSysW/rzv/eh8cCTcyLvVWVUczm9ybgPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUk00Vbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58984C4CEE7;
	Thu, 18 Sep 2025 21:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758229849;
	bh=wlNjaTZImKf2AeG6/odvaHilnkAGYMvkVffoJRmrn70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aUk00Vbwlm/AgYDloeJEF0n1g05Ksb4/qtHx8wCKS/Wh+DyVnJwXG4q+xUw1tbJEY
	 d47PTPbffMdIuVmHoikcrvZHyGs3p46TFO2GgJkaZy6pbmEiB/hRULt4To6ZZXwDKp
	 aR0PnxehpjIx0zH6Yfi03LygrpQpF1O6QtGE3cfV4oQkfMTMr3oeyr6tTiDpCZ8qb4
	 X66/RvzHnWK4zqESNRUtyVKZ/2k05Tq3KyiyQbGGo/NrYCbANloJxqzynxozOqatvn
	 fvf6CJ57d+XjF0Uz1Idb65Bc128JEsLRR3N4DWGUAG62eS2pIrXDdt9/T11tzegY9l
	 oGtiBcbX4eYKg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Huisong Li <lihuisong@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Subject: [PATCH v1 2/2] ACPI: processor: idle: Redefine two functions as void
Date: Thu, 18 Sep 2025 23:10:31 +0200
Message-ID: <2385759.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5926523.DvuYhMxLoT@rafael.j.wysocki>
References: <5926523.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that acpi_processor_power_init() and acpi_processor_power_exit()
don't need to return any values because their callers don't check them
anyway, so redefine those functions as void.

While at it, rearrange the code in acpi_processor_power_init() to
reduce the indentation level, get rid of a redundant local variable
in that function, and rephrase a code comment in it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |   47 +++++++++++++++++++-----------------------
 include/acpi/processor.h      |    4 +--
 2 files changed, 24 insertions(+), 27 deletions(-)

--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1137,47 +1137,45 @@ void acpi_processor_unregister_idle_driv
 	cpuidle_unregister_driver(&acpi_idle_driver);
 }
 
-int acpi_processor_power_init(struct acpi_processor *pr)
+void acpi_processor_power_init(struct acpi_processor *pr)
 {
-	int retval;
 	struct cpuidle_device *dev;
 
 	if (disabled_by_idle_boot_param())
-		return 0;
+		return;
 
 	acpi_processor_cstate_first_run_checks();
 
 	if (!acpi_processor_get_power_info(pr))
 		pr->flags.power_setup_done = 1;
 
-	if (pr->flags.power) {
-		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-		if (!dev)
-			return -ENOMEM;
-		per_cpu(acpi_cpuidle_device, pr->id) = dev;
-
-		acpi_processor_setup_cpuidle_dev(pr, dev);
-
-		/* Register per-cpu cpuidle_device. Cpuidle driver
-		 * must already be registered before registering device
-		 */
-		retval = cpuidle_register_device(dev);
-		if (retval) {
-
-			per_cpu(acpi_cpuidle_device, pr->id) = NULL;
-			kfree(dev);
-			return retval;
-		}
+	if (!pr->flags.power)
+		return;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return;
+
+	per_cpu(acpi_cpuidle_device, pr->id) = dev;
+
+	acpi_processor_setup_cpuidle_dev(pr, dev);
+
+	/*
+	 * Register a cpuidle device for this CPU.  The cpuidle driver using
+	 * this device is expected to be registered.
+	 */
+	if (cpuidle_register_device(dev)) {
+		per_cpu(acpi_cpuidle_device, pr->id) = NULL;
+		kfree(dev);
 	}
-	return 0;
 }
 
-int acpi_processor_power_exit(struct acpi_processor *pr)
+void acpi_processor_power_exit(struct acpi_processor *pr)
 {
 	struct cpuidle_device *dev = per_cpu(acpi_cpuidle_device, pr->id);
 
 	if (disabled_by_idle_boot_param())
-		return 0;
+		return;
 
 	if (pr->flags.power) {
 		cpuidle_unregister_device(dev);
@@ -1185,7 +1183,6 @@ int acpi_processor_power_exit(struct acp
 	}
 
 	pr->flags.power_setup_done = 0;
-	return 0;
 }
 
 MODULE_IMPORT_NS("ACPI_PROCESSOR_IDLE");
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -419,8 +419,8 @@ static inline void acpi_processor_thrott
 /* in processor_idle.c */
 extern struct cpuidle_driver acpi_idle_driver;
 #ifdef CONFIG_ACPI_PROCESSOR_IDLE
-int acpi_processor_power_init(struct acpi_processor *pr);
-int acpi_processor_power_exit(struct acpi_processor *pr);
+void acpi_processor_power_init(struct acpi_processor *pr);
+void acpi_processor_power_exit(struct acpi_processor *pr);
 int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
 int acpi_processor_hotplug(struct acpi_processor *pr);
 void acpi_processor_register_idle_driver(void);




