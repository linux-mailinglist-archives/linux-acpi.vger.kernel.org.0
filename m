Return-Path: <linux-acpi+bounces-17935-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76787BECF76
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 14:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2F25E0E38
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 12:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642C0284674;
	Sat, 18 Oct 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yn50TWnQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370CF354ADF;
	Sat, 18 Oct 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760790299; cv=none; b=lhUi5e1KMbXbPVSSX5hcnjW5A05e4GGgijShn1YF7kZ92bs3ZKgf0+QJkkWFJLS+vF/tLOgJTAu+e7xBxN8vzLHGznu3sa29NtuQ3wwQeZ3AN6opKAJPky3LnoTgzWEnb2Whh1MuS7B1SsNj2d/zivf5ljTn44IEtueGwbUdlb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760790299; c=relaxed/simple;
	bh=l/aAsZf6qoeMlNgkXSMypl1VDNVAcZQnG1zVE8VEAXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKjI47Bh+x959W0qQ240t24KGgk9o6GwbhYRuH8iW2+5TQaEFiJG2eUGe7DhsrkYmOyNAnTKKL7N5x4EGhybby+5WD9NpUGEz+vtbMUN4OXf1cVJKUhLw0BranRvKo8EkQeyK8ohhJTUE9MnD8Z2zbzWw69DPNhEcFfhcdRV4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yn50TWnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EC6C4CEF8;
	Sat, 18 Oct 2025 12:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760790299;
	bh=l/aAsZf6qoeMlNgkXSMypl1VDNVAcZQnG1zVE8VEAXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yn50TWnQ9qd+yEexh2GKNnuLDe4q8aKdbUnferwTelvEA+ZQosCY3MXb94BktNoBB
	 koAeqWipf/U1ZZy5UByJ1plMzaeiX8P1+mT/EWOHlYD8uQhvb6cJ2sjcuMzPbDI+kg
	 POkTJfV9h9pm3zu3AKUBfSe/NBeJn5GDvMPHDV9TSrs4vYGCvhI7xOB0zZb1xJAc0g
	 YWuCrRi8G/PWXZ2SwK3Gdwo6wRJyh4mfNvfv2ZL6Op4e+UHefa4NV6NBlFb7ftQqKD
	 sxor1QHhQ7BZ7UbA9ign/oMbY6Xht2oWtKbyOOhZgLLUmcZVJwZfj0B4S+P82Q7P2m
	 3eKL3jr4a6jQQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 2/2] ACPI: TAD: Improve runtime PM using guard macros
Date: Sat, 18 Oct 2025 14:24:42 +0200
Message-ID: <22877917.EfDdHjke4D@rafael.j.wysocki>
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

Use guard pm_runtime_active_try to simplify runtime PM cleanup and
implement runtime resume error handling in multiple places.

Also use guard pm_runtime_noresume to simplify acpi_tad_remove().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   57 +++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -90,12 +90,11 @@ static int acpi_tad_set_real_time(struct
 	args[0].buffer.pointer = (u8 *)rt;
 	args[0].buffer.length = sizeof(*rt);
 
-	pm_runtime_get_sync(dev);
+	ACQUIRE(pm_runtime_active_try, pm)(dev);
+	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, "_SRT", &arg_list, &retval);
-
-	pm_runtime_put_sync(dev);
-
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
 
@@ -111,12 +110,11 @@ static int acpi_tad_get_real_time(struct
 	acpi_status status;
 	int ret = -EIO;
 
-	pm_runtime_get_sync(dev);
+	ACQUIRE(pm_runtime_active_try, pm)(dev);
+	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+		return -ENXIO;
 
 	status = acpi_evaluate_object(handle, "_GRT", NULL, &output);
-
-	pm_runtime_put_sync(dev);
-
 	if (ACPI_FAILURE(status))
 		goto out_free;
 
@@ -266,12 +264,11 @@ static int acpi_tad_wake_set(struct devi
 	args[0].integer.value = timer_id;
 	args[1].integer.value = value;
 
-	pm_runtime_get_sync(dev);
+	ACQUIRE(pm_runtime_active_try, pm)(dev);
+	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
-
-	pm_runtime_put_sync(dev);
-
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
 
@@ -314,12 +311,11 @@ static ssize_t acpi_tad_wake_read(struct
 
 	args[0].integer.value = timer_id;
 
-	pm_runtime_get_sync(dev);
+	ACQUIRE(pm_runtime_active_try, pm)(dev);
+	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
-
-	pm_runtime_put_sync(dev);
-
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -370,12 +366,11 @@ static int acpi_tad_clear_status(struct
 
 	args[0].integer.value = timer_id;
 
-	pm_runtime_get_sync(dev);
+	ACQUIRE(pm_runtime_active_try, pm)(dev);
+	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, "_CWS", &arg_list, &retval);
-
-	pm_runtime_put_sync(dev);
-
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
 
@@ -411,12 +406,11 @@ static ssize_t acpi_tad_status_read(stru
 
 	args[0].integer.value = timer_id;
 
-	pm_runtime_get_sync(dev);
+	ACQUIRE(pm_runtime_active_try, pm)(dev);
+	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, "_GWS", &arg_list, &retval);
-
-	pm_runtime_put_sync(dev);
-
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -571,16 +565,15 @@ static void acpi_tad_remove(struct platf
 
 	sysfs_remove_group(&dev->kobj, &acpi_tad_attr_group);
 
-	pm_runtime_get_noresume(dev);
-
-	acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
-	acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
-	if (dd->capabilities & ACPI_TAD_DC_WAKE) {
-		acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
-		acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
+	scoped_guard(pm_runtime_noresume, dev) {
+		acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
+		acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
+		if (dd->capabilities & ACPI_TAD_DC_WAKE) {
+			acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
+			acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
+		}
 	}
 
-	pm_runtime_put_noidle(dev);
 	pm_runtime_suspend(dev);
 	pm_runtime_disable(dev);
 	acpi_remove_cmos_rtc_space_handler(handle);




