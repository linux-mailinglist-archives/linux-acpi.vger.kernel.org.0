Return-Path: <linux-acpi+bounces-17118-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1556FB8705F
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 23:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03351162C47
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 21:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209F02F49EB;
	Thu, 18 Sep 2025 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lallFBBP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90322D594D;
	Thu, 18 Sep 2025 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229856; cv=none; b=tTEpALf/ZU9esPDqjM5IpnzhjNA2tLT+QjhMQxQduQVkfS5C6/hn4i3zNrzMfmYWRkN749Qlmh4RSYop1ChbW/aT2tEJ3otDFWP6cqnB/78UxtD27wUYXpL6fO3nuTA72vTqGqj/U1RXJZ4bVSlTFgIOp5qZwTOucXKA6ExGyoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229856; c=relaxed/simple;
	bh=GTU39OVki/AXOb5+gpAep3ky1ReqWJfjSGGsMzkKEt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glQHFiw+kaA+R0BAMDLYNMwE1xawMXO8kAS1LeVD4vi8mjG8OIA9UAhm5T77SGrLfGkmR2L9X7WuWatmJ0KRRwANiuNAq53VAiUKgd7Neq4KMvZBL/w8kp013W7O8nlKtlhnE4GkULquayvTS5dxd7yDHUGcDaoXKPuJlbGO6is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lallFBBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B0FC4CEE7;
	Thu, 18 Sep 2025 21:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758229854;
	bh=GTU39OVki/AXOb5+gpAep3ky1ReqWJfjSGGsMzkKEt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lallFBBPAjBv+IgXeDmK8xmeq2JTMVQdw4GaJ6Intk+3jX+WJSReW/BOdSwr4feAq
	 Ag3GTgNXA6reTew+O10yNsdaKxfgC1ityw33jPbFezoRdzlKOgRwFG/t7sFrEJD36j
	 KQ8rTOhk+4oAtUQxuPdsOqyCiy4YxX3UWDHHk5ckfnmDUoVgWPHFSY2u2lEQ56S1cd
	 pHye5FXhyYjZhNT++H3Mn9vz4NpmHRXvb0p9Gfr+97L19JXuTX/pJ63JeHHOnXcs99
	 xvmldGvVKzaCFPurUbfo9BPVuuufEE6S7THLXH2wsbf4bNclobVMUktueThchCs9v+
	 yoy1MQnbLYAuw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Huisong Li <lihuisong@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Subject:
 [PATCH v1 1/2] ACPI: processor: Update cpuidle driver check in
 __acpi_processor_start()
Date: Thu, 18 Sep 2025 23:09:17 +0200
Message-ID: <5044465.31r3eYUQgx@rafael.j.wysocki>
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

Commit 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle
driver registration") moved the ACPI idle driver registration to
acpi_processor_driver_init() and acpi_processor_power_init() does
not register an idle driver any more, so the cpuidle driver check
in __acpi_processor_start() needs to be updated to avoid calling
acpi_processor_power_init() without a cpuidle driver (in which
case the registration of the cpuidle device in that function
would fail anyway).

Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle driver registration")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Commit 7a8c994cbb2d is only in linux-next at this point.

---
 drivers/acpi/processor_driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -166,7 +166,7 @@ static int __acpi_processor_start(struct
 	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
 		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
 
-	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
+	if (cpuidle_get_driver() == &acpi_idle_driver)
 		acpi_processor_power_init(pr);
 
 	acpi_pss_perf_init(pr);




