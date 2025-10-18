Return-Path: <linux-acpi+bounces-17936-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4B6BECF7F
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 14:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319AE5E1060
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD4D2868A6;
	Sat, 18 Oct 2025 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyeCoXJp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C9354ADF;
	Sat, 18 Oct 2025 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760790306; cv=none; b=qyCmVzZ9+IOR4BwnjVG/mR8YhK6o8L/Uuj0yCjALwkI539TC9ZAgfz+x53KYC4EJobwU5l08ndk5Bi3fT/uw8G1KjRDGjd37wXLPCZGaRv3km42dLokwhfs804gxtYzusA/YkC5OB2y91IaoosoqGoTy2jnzRWUEkFxC1gEaqTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760790306; c=relaxed/simple;
	bh=5Ojmj4sxlrJnfMaPuiqa45Z5k6CAnRPeizijVc+oRQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRziCdg23kyeyHKAOl2v+8fvggsEU5M6IX0JUh9ikNirixd4Uq90E6gtlBmltas6LY8t3GcoETr46OKMvISwlzPkTFOKNFw1hMxk/4H9NWpARmfEcHjn4oI0337KWcNiPbYkb7Mz3BF37Gvab23J9b378WLSc2xO4QrfwM4rFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyeCoXJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55BFC113D0;
	Sat, 18 Oct 2025 12:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760790304;
	bh=5Ojmj4sxlrJnfMaPuiqa45Z5k6CAnRPeizijVc+oRQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyeCoXJpC1xhKkihEbYMHzGDp/HHgkg2ZmLGmmxMeBEkSJDwoeDrlldQgXl2+bKPW
	 KfAI6fDxegKALu4/26/mvaLgMDOg/FiSP2bb0v6DMVTe5AMakZZwh5shJluYjOPJEJ
	 aAlC/jgGXki0H8KM4MAayPtrWfoeUdPY3VEw6FG0F8GH9FZEPoWz5mEiE9b+vnVwkk
	 pfQhnxebFEWj0fqUgmj/iqeABKVsEghlQCWi2lErZK/eB1vI7/Ls2aXkmGdGvuqmJe
	 dFIZvQoNa1Q8+vr283ZP0B65RK9Qkmxgvaqn+bE8prB2YN+KIj0L8grEI9cF1JQaUM
	 vy9vhCpNYqkwA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject:
 [PATCH v2 1/2] ACPI: TAD: Rearrange runtime PM operations in
 acpi_tad_remove()
Date: Sat, 18 Oct 2025 14:23:07 +0200
Message-ID: <2333453.iZASKD2KPV@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <8599731.T7Z3S40VBb@rafael.j.wysocki>
References: <8599731.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is not necessary to resume the device upfront in acpi_tad_remove()
because both acpi_tad_disable_timer() and acpi_tad_clear_status()
attempt to resume it, but it is better to prevent it from suspending
between these calls by incrementing its runtime PM usage counter.

Accordingly, replace the pm_runtime_get_sync() call in acpi_tad_remove()
with a pm_runtime_get_noresume() one and put the latter right before the
first invocation of acpi_tad_disable_timer().

In addition, use pm_runtime_put_noidle() to drop the device's runtime
PM usage counter after using pm_runtime_get_noresume() to bump it up
to follow a common pattern and use pm_runtime_suspend() for suspending
the device afterward.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -563,8 +563,6 @@ static void acpi_tad_remove(struct platf
 
 	device_init_wakeup(dev, false);
 
-	pm_runtime_get_sync(dev);
-
 	if (dd->capabilities & ACPI_TAD_RT)
 		sysfs_remove_group(&dev->kobj, &acpi_tad_time_attr_group);
 
@@ -573,6 +571,8 @@ static void acpi_tad_remove(struct platf
 
 	sysfs_remove_group(&dev->kobj, &acpi_tad_attr_group);
 
+	pm_runtime_get_noresume(dev);
+
 	acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
 	acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
 	if (dd->capabilities & ACPI_TAD_DC_WAKE) {
@@ -580,7 +580,8 @@ static void acpi_tad_remove(struct platf
 		acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
 	}
 
-	pm_runtime_put_sync(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_suspend(dev);
 	pm_runtime_disable(dev);
 	acpi_remove_cmos_rtc_space_handler(handle);
 }




