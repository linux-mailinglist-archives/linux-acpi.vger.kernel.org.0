Return-Path: <linux-acpi+bounces-18051-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7525FBF7EBA
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 19:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D1F3A7852
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 17:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A732534B68B;
	Tue, 21 Oct 2025 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM7xQNjM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6A623BCE4;
	Tue, 21 Oct 2025 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068168; cv=none; b=ZxFhzvwOp7L7jULO2/tiEhyvIrvfgq3U/XAaLRkRErbfHOSjnSrE5vidVdM6KmuH2HdcJYjhxvpC4nhNTN3J4NWw6hnaSk1DbrAkQ7mZiZMflrsh0FBiz4x1H7l2pSDUEDdqv5V5BhG0bpcZOa54r2QEg3iDIXZEUZZU7I2EtBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068168; c=relaxed/simple;
	bh=tr9D0PnnlH4JBLjwZIbaVfaUWzAU9oe6dwsFcwU5bKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mioOrodZwwKPMoPWH0CTR/19hjiYJ/u9tSNH/oM+HFc2TvEJaFy4M23zaMbCeeJ5deZXWOCRUw4cmU7fk+8Huad2CsEGpjNR9pHscaE4zvMKHZw2itkdXuidYxYLX65YD0E6GvOcNfTHe8jWw2c76uwVNE+hdM5xsUmCNzc72MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM7xQNjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0A4C4CEF1;
	Tue, 21 Oct 2025 17:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761068165;
	bh=tr9D0PnnlH4JBLjwZIbaVfaUWzAU9oe6dwsFcwU5bKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QM7xQNjMYjaCZUu1pz+cdH+McrBUnjQbm/9BUqR1K0tdhJSqml4ybuaMCJ/7k4hLs
	 7c06KnoZcuhbYTJk2qtD7oROg4dKy462gAKa/Xtfw0Hf/s9GvBeDQheKdSBcHmBg2U
	 MZUkUEOWEB1k8ojmplGvxvfHPrYASLJgzGSGuMnELUwYZvEAKhB8A1mTI6SB2Rg03Z
	 mXjRMGIFEGdmOKJaa5J6o/X0pDKDWWzlRmMw5ucYHHy9iEaZz3bt/AtDwIF4U5C+Az
	 QVUqt5Y21C1Yudy770e+5H9/AbcSSHRnTj+acOaJuVXKWkEbLvHceYT+PNYvB1/kxG
	 /d29wZYRv/KaQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3 2/2] ACPI: TAD: Improve runtime PM using guard macros
Date: Tue, 21 Oct 2025 19:35:54 +0200
Message-ID: <13881356.uLZWGnKmhe@rafael.j.wysocki>
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

Use guard pm_runtime_active_try to simplify runtime PM cleanup and
implement runtime resume error handling in multiple places.

Also use guard pm_runtime_noresume to simplify acpi_tad_remove().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: Introduce a helper function to avoid using goto statements along
          with cleanup.h macros in one function (Jonathan).

v1 -> v2: Rebase after dropping the first patch in the series.

---
 drivers/acpi/acpi_tad.c |   72 +++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -90,19 +90,18 @@ static int acpi_tad_set_real_time(struct
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
 
 	return 0;
 }
 
-static int acpi_tad_get_real_time(struct device *dev, struct acpi_tad_rt *rt)
+static int acpi_tad_evaluate_grt(struct device *dev, struct acpi_tad_rt *rt)
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER };
@@ -111,12 +110,7 @@ static int acpi_tad_get_real_time(struct
 	acpi_status status;
 	int ret = -EIO;
 
-	pm_runtime_get_sync(dev);
-
 	status = acpi_evaluate_object(handle, "_GRT", NULL, &output);
-
-	pm_runtime_put_sync(dev);
-
 	if (ACPI_FAILURE(status))
 		goto out_free;
 
@@ -139,6 +133,21 @@ out_free:
 	return ret;
 }
 
+static int acpi_tad_get_real_time(struct device *dev, struct acpi_tad_rt *rt)
+{
+	int ret;
+
+	ACQUIRE(pm_runtime_active_try, pm)(dev);
+	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+		return -ENXIO;
+
+	ret = acpi_tad_evaluate_grt(dev, rt);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static char *acpi_tad_rt_next_field(char *s, int *val)
 {
 	char *p;
@@ -266,12 +275,11 @@ static int acpi_tad_wake_set(struct devi
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
 
@@ -314,12 +322,11 @@ static ssize_t acpi_tad_wake_read(struct
 
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
 
@@ -370,12 +377,11 @@ static int acpi_tad_clear_status(struct
 
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
 
@@ -411,12 +417,11 @@ static ssize_t acpi_tad_status_read(stru
 
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
 
@@ -571,16 +576,15 @@ static void acpi_tad_remove(struct platf
 
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




