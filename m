Return-Path: <linux-acpi+bounces-18052-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09F6BF7EC6
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 19:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D783AAA9B
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2328C34C800;
	Tue, 21 Oct 2025 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8X8sgIt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB17C23BCE4;
	Tue, 21 Oct 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068172; cv=none; b=q9tJ1YJrEngruM2kilI6s7cPc6P9DjfbwgntH1n+4QQQBGvkWvz6ESDBJwcoI9dEbH43gVkYqUh5Auepe8Yh8QbY97PIPy9getFIow50GgKTXN4P8bfrFtYnJH+5zDt+SoSkcUJMnmsNBqDsqxVFIju134okl7Z87gPQpbeeGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068172; c=relaxed/simple;
	bh=vIDhnWWXuu7ZhO04wW3hkRyYZbwm1xPMIRx5DylFCro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUlUgUdJn70jH4qyL53O4m11GvUY97UbRcNdE3uvAtRltqqg50KUALNCRG2cMN3HLSa21JJHk1yoDR79eneng5cGMC6xfZVUf1GTl2MO+xoHdsF/qTu5Ffne9QMS36rImMusVPqsGWBcmPd9haXjNAGlqKNwVMAH8PXKcQL6KD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8X8sgIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B824C4CEF5;
	Tue, 21 Oct 2025 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761068171;
	bh=vIDhnWWXuu7ZhO04wW3hkRyYZbwm1xPMIRx5DylFCro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8X8sgIt2EL9qa3LEB8TFAGp3HGPG4hmS5GX6t0ucO2gcsi1xt9rrN1HvHr8OIIIV
	 LjjGGMDEioDMPG7MqrmSTlq0XtPOGd7C8qh/UtQm1B1/yUJGheHqyOgw1t3KvpIjuO
	 9Ottvw8lvTaN8qAv8A9IRPkqIxE2oT4Bw3LNRDa81mQx7mt0KxTWjLiW5Xykcnn/uT
	 y+QbpN17qjVIMyIRCHFfo9g9aMYrBNJnJiXHJJ8U0fBirqqnn7uTRR2Zwk3oB52SSm
	 X22UI0Z476j4RtSgrBroAmzcTGLhFtl/mzAzZ60jFCKUv9GWTxH7rp728Wvz3zw0lr
	 7OzPixcDlEQxQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject:
 [PATCH v3 1/2] ACPI: TAD: Rearrange runtime PM operations in
 acpi_tad_remove()
Date: Tue, 21 Oct 2025 19:33:39 +0200
Message-ID: <5031965.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4698369.LvFx2qVVIh@rafael.j.wysocki>
References: <4698369.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] 

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

v1 -> v3: No changes

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




