Return-Path: <linux-acpi+bounces-21052-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCa5CV5znGmcGAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21052-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:33:50 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC25178C52
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 071A6300612E
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 15:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C44F2E975E;
	Mon, 23 Feb 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB29jXXI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1795927FB18;
	Mon, 23 Feb 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860826; cv=none; b=GAzG54lIx5Wk5/TkxaDBPvsh24h9I93r1UsjqejL9Z8bstZGewFl96YMOSgm9l7f9x+uRjYibIyAVZ8g6FPgs48SlhfIb1QAtusP8uLR/68HiPl65HlOTBwalHW43aFawJmmkBIJvuN9wDaKJ3WvQt3PueotHpwqd/Kw4RnJmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860826; c=relaxed/simple;
	bh=VzZrU/dFnGsRih3TvDfo18RrYRZGPj+QUNCUV0TW0y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTmDzdCZDRD+w9ttv2wDyqiIxjk1NIk5YQJrY5QK+SpK2PMFjVnbosxq6SfWO9hYpJ4TFZaTp6QXV27Qu0T7RWyrPAqi3uIjxCKqpunQd2p+QZjMFFG3mezFnZnX30yEsXGP9QoKenLwiR7qmXq3eJnKeYOCRGtFW4wLmStl3BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB29jXXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A615EC116C6;
	Mon, 23 Feb 2026 15:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860826;
	bh=VzZrU/dFnGsRih3TvDfo18RrYRZGPj+QUNCUV0TW0y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oB29jXXI85Qi8bkSIQxI6BfOOSwmVFQHsjcVAOm2fMgA6WmMHrH1tyW7ALPSBHqzq
	 SkOwXKVYmFVVGWd0QSslhb0GDColqLWPvPECCbjqrZlqt/2CyvUWR7s0E1hDm/g0XS
	 MmJroJPf6u1UJgnU+2q8idDVBu4i157JWHWo88VUYOIsqAEzV6ICGG63X3j/zBEKX+
	 yXiC9YgQVsOssJ1dnZv+BifwFySPAZ1QOrMDzHtswCmHRy5EMW58jRhJ7jEc7uYKqk
	 Cf0wS0fa9eYpYEmC8+rsNCXLcgqYy6yuYv2jJV7bsImWAWUlMGv1ekMj6IcLQdFHlD
	 D/ziDC1Ap+7LA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 linux-rtc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject:
 [PATCH v1 8/8] ACPI: TAD/x86: cmos_rtc: Consolidate address space handler
 setup
Date: Mon, 23 Feb 2026 16:33:27 +0100
Message-ID: <23028644.EfDdHjke4D@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5983325.DvuYhMxLoT@rafael.j.wysocki>
References: <5983325.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21052-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 9EC25178C52
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On x86, as a rule the CMOS RTC address space handler is set up by the
CMOS RTC ACPI scan handler attach callback, acpi_cmos_rtc_attach(),
but if the ACPI namespace does not contain a CMOS RTC device object,
the CMOS RTC address space handler installation is taken care of the
ACPI TAD (Timer and Alarm Device) driver.

This is not particularly straightforward and can be avoided by adding
the ACPI TAD device ID to the CMOS RTC ACPI scan handler which will
cause it to create a platform device for ACPI TAD after installing
the CMOS RTC address space handler.  One related detail that needs to
be taken care of, though, is that the creation of an ACPI TAD platform
device should not cause cmos_rtc_platform_device_present to be set,
since this may cause add_rtc_cmos() to suppress the creation of a
fallback CMOS RTC platform device which may not be the right thing
to do (for instance, due to the fact that the ACPI TAD driver is
missing an RTC class device interface).

After doing the above, the CMOS RTC address space handler installation
and removal can be dropped from the ACPI TAD driver (which allows it to
be simplified quite a bit), acpi_remove_cmos_rtc_space_handler() can
be dropped and acpi_install_cmos_rtc_space_handler() can be made static.

Update the code as per the above.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c     | 27 +++++----------------------
 drivers/acpi/x86/cmos_rtc.c | 26 +++++---------------------
 include/acpi/acpi_bus.h     |  9 ---------
 3 files changed, 10 insertions(+), 52 deletions(-)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 6d870d97ada6..4f5089fc023d 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -563,7 +563,6 @@ static int acpi_tad_disable_timer(struct device *dev, u32 timer_id)
 static void acpi_tad_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	acpi_handle handle = ACPI_HANDLE(dev);
 	struct acpi_tad_driver_data *dd = dev_get_drvdata(dev);
 
 	device_init_wakeup(dev, false);
@@ -587,7 +586,6 @@ static void acpi_tad_remove(struct platform_device *pdev)
 
 	pm_runtime_suspend(dev);
 	pm_runtime_disable(dev);
-	acpi_remove_cmos_rtc_space_handler(handle);
 }
 
 static int acpi_tad_probe(struct platform_device *pdev)
@@ -599,11 +597,6 @@ static int acpi_tad_probe(struct platform_device *pdev)
 	unsigned long long caps;
 	int ret;
 
-	ret = acpi_install_cmos_rtc_space_handler(handle);
-	if (ret < 0) {
-		dev_info(dev, "Unable to install space handler\n");
-		return -ENODEV;
-	}
 	/*
 	 * Initialization failure messages are mostly about firmware issues, so
 	 * print them at the "info" level.
@@ -611,27 +604,22 @@ static int acpi_tad_probe(struct platform_device *pdev)
 	status = acpi_evaluate_integer(handle, "_GCP", NULL, &caps);
 	if (ACPI_FAILURE(status)) {
 		dev_info(dev, "Unable to get capabilities\n");
-		ret = -ENODEV;
-		goto remove_handler;
+		return -ENODEV;
 	}
 
 	if (!(caps & ACPI_TAD_AC_WAKE)) {
 		dev_info(dev, "Unsupported capabilities\n");
-		ret = -ENODEV;
-		goto remove_handler;
+		return -ENODEV;
 	}
 
 	if (!acpi_has_method(handle, "_PRW")) {
 		dev_info(dev, "Missing _PRW\n");
-		ret = -ENODEV;
-		goto remove_handler;
+		return -ENODEV;
 	}
 
 	dd = devm_kzalloc(dev, sizeof(*dd), GFP_KERNEL);
-	if (!dd) {
-		ret = -ENOMEM;
-		goto remove_handler;
-	}
+	if (!dd)
+		return -ENOMEM;
 
 	dd->capabilities = caps;
 	dev_set_drvdata(dev, dd);
@@ -673,11 +661,6 @@ static int acpi_tad_probe(struct platform_device *pdev)
 
 fail:
 	acpi_tad_remove(pdev);
-	/* Don't fallthrough because cmos rtc space handler is removed in acpi_tad_remove() */
-	return ret;
-
-remove_handler:
-	acpi_remove_cmos_rtc_space_handler(handle);
 	return ret;
 }
 
diff --git a/drivers/acpi/x86/cmos_rtc.c b/drivers/acpi/x86/cmos_rtc.c
index a6df5b991c96..ced334e19896 100644
--- a/drivers/acpi/x86/cmos_rtc.c
+++ b/drivers/acpi/x86/cmos_rtc.c
@@ -18,13 +18,12 @@
 #include "../internal.h"
 
 static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
+	{ "ACPI000E", 1 }, /* ACPI Time and Alarm Device (TAD) */
 	ACPI_CMOS_RTC_IDS
 };
 
 bool cmos_rtc_platform_device_present;
 
-static bool cmos_rtc_space_handler_present __read_mostly;
-
 static acpi_status acpi_cmos_rtc_space_handler(u32 function,
 					       acpi_physical_address address,
 					       u32 bits, u64 *value64,
@@ -56,8 +55,9 @@ static acpi_status acpi_cmos_rtc_space_handler(u32 function,
 	return AE_BAD_PARAMETER;
 }
 
-int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
+static int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
 {
+	static bool cmos_rtc_space_handler_present __read_mostly;
 	acpi_status status;
 
 	if (cmos_rtc_space_handler_present)
@@ -76,22 +76,6 @@ int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
 
 	return 1;
 }
-EXPORT_SYMBOL_GPL(acpi_install_cmos_rtc_space_handler);
-
-void acpi_remove_cmos_rtc_space_handler(acpi_handle handle)
-{
-	acpi_status status;
-
-	if (cmos_rtc_space_handler_present)
-		return;
-
-	status = acpi_remove_address_space_handler(handle,
-						   ACPI_ADR_SPACE_CMOS,
-						   acpi_cmos_rtc_space_handler);
-	if (ACPI_FAILURE(status))
-		pr_err("Failed to remove CMOS-RTC address space handler\n");
-}
-EXPORT_SYMBOL_GPL(acpi_remove_cmos_rtc_space_handler);
 
 static int acpi_cmos_rtc_attach(struct acpi_device *adev,
 				const struct acpi_device_id *id)
@@ -103,9 +87,9 @@ static int acpi_cmos_rtc_attach(struct acpi_device *adev,
 		return ret;
 
 	if (IS_ERR_OR_NULL(acpi_create_platform_device(adev, NULL))) {
-		pr_err("Failed to create CMOS-RTC platform device\n");
+		pr_err("Failed to create a platform device for %s\n", (char *)id->id);
 		return 0;
-	} else {
+	} else if (!id->driver_data) {
 		cmos_rtc_platform_device_present = true;
 	}
 	return 1;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index aad1a95e6863..be6d9032a161 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -760,8 +760,6 @@ int acpi_disable_wakeup_device_power(struct acpi_device *dev);
 #ifdef CONFIG_X86
 bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *status);
 bool acpi_quirk_skip_acpi_ac_and_battery(void);
-int acpi_install_cmos_rtc_space_handler(acpi_handle handle);
-void acpi_remove_cmos_rtc_space_handler(acpi_handle handle);
 int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip);
 #else
 static inline bool acpi_device_override_status(struct acpi_device *adev,
@@ -773,13 +771,6 @@ static inline bool acpi_quirk_skip_acpi_ac_and_battery(void)
 {
 	return false;
 }
-static inline int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
-{
-	return 1;
-}
-static inline void acpi_remove_cmos_rtc_space_handler(acpi_handle handle)
-{
-}
 static inline int
 acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
 {
-- 
2.51.0





