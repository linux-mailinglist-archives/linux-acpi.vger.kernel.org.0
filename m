Return-Path: <linux-acpi+bounces-21335-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DvAFr14qGnpugAAu9opvQ
	(envelope-from <linux-acpi+bounces-21335-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:23:57 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5B32063C4
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10C5832B4982
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5CC3D3D1A;
	Wed,  4 Mar 2026 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T24yqbjA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298413D3D02;
	Wed,  4 Mar 2026 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648226; cv=none; b=qlZXutVKjNKkpt/MAJfaGxn121mNVF4afezqdhmwHlBBQeF2l3gLB1sgrdil3vpsjdNNuxQsK5tXjWbRqW/LRHD4O3B6HwCmzoQ+gejI2iUMPjp/11S3mWPLPNQIMB3b8l3MLOjck5vMQt7iIv7/9ajHUGyhnSrPadU0iXyCZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648226; c=relaxed/simple;
	bh=ZCLNPMwxz6kSqgJOI80qPQJZSq4OzEpHaHSxd6TUvwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCMVLa807Vq2o9QXN1ReNdASAWyI0TheIVQU9YY7OxX8yoAbAcjnVSSDRHoQ6B47a/HRb8be7baRfuSAlsVfy1Mk1mglZf5gbay7XGqFkGLlZZBz9Q6J4VeQLe8jDkQoqk/dyhYCv5g588PiBZh+zROvzoCnnx2mz81M9GiiTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T24yqbjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97717C2BCAF;
	Wed,  4 Mar 2026 18:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772648225;
	bh=ZCLNPMwxz6kSqgJOI80qPQJZSq4OzEpHaHSxd6TUvwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T24yqbjA1blkut1p1Vc/1tAEfJF6wk2l0xBkOeXoW5ry0uDqBqk9uD7h8K7hoD/VB
	 IQFiyQ/d7I4fkjCt8czJm5BscCb8DgiEmFScHd2nfLnggr5g6QwlFsAMxX99lntr5O
	 Pkq4ggZ1IEmDthk8oGixRgRU4hHYiXF5T9qRf/oUSZ41o9hqxCpL9gCQzuU53zSkaC
	 jsgUoVElNnSvsoti53yuxTJwA/MLZcHwkth4DykRKbI0CXlwb1FPALKNLuE6V3E15l
	 nAjkd29FtxSuk22bvq6Alyn259DJWvWiDX3SzfeT8ovfIHogP4sh5ed+5tK95J6LZ4
	 gNnQwEQgSms5g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-rtc@vger.kernel.org,
 Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1 6/7] ACPI: TAD: Add RTC class device interface
Date: Wed, 04 Mar 2026 19:16:01 +0100
Message-ID: <2352027.iZASKD2KPV@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5092662.31r3eYUQgx@rafael.j.wysocki>
References: <5092662.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AC5B32063C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21335-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rt.day:url,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add an RTC class device interface allowing to read and set the real time
value to the ACPI TAD driver.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/rtc.h>
 #include <linux/suspend.h>
 
 MODULE_DESCRIPTION("ACPI Time and Alarm (TAD) Device Driver");
@@ -51,6 +52,7 @@ MODULE_AUTHOR("Rafael J. Wysocki");
 
 /* ACPI TAD RTC */
 #define ACPI_TAD_TZ_UNSPEC	2047
+#define ACPI_TAD_TIME_ISDST	3
 
 struct acpi_tad_driver_data {
 	u32 capabilities;
@@ -164,6 +166,8 @@ static int acpi_tad_get_real_time(struct
 	return 0;
 }
 
+/* sysfs interface */
+
 static char *acpi_tad_rt_next_field(char *s, int *val)
 {
 	char *p;
@@ -579,6 +583,71 @@ static const struct attribute_group acpi
 	.is_visible = acpi_tad_attr_is_visible,
 };
 
+#ifdef CONFIG_RTC_CLASS
+/* RTC class device interface */
+
+static int acpi_tad_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct acpi_tad_rt rt;
+
+	rt.year = tm->tm_year + 1900;
+	rt.month = tm->tm_mon + 1;
+	rt.day = tm->tm_mday;
+	rt.hour = tm->tm_hour;
+	rt.minute = tm->tm_min;
+	rt.second = tm->tm_sec;
+	rt.tz = ACPI_TAD_TZ_UNSPEC;
+	rt.daylight = ACPI_TAD_TIME_ISDST * !!tm->tm_isdst;
+
+	return acpi_tad_set_real_time(dev, &rt);
+}
+
+static int acpi_tad_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct acpi_tad_rt rt;
+	int ret;
+
+	ret = acpi_tad_get_real_time(dev, &rt);
+	if (ret)
+		return ret;
+
+	tm->tm_year = rt.year - 1900;
+	tm->tm_mon = rt.month - 1;
+	tm->tm_mday = rt.day;
+	tm->tm_hour = rt.hour;
+	tm->tm_min = rt.minute;
+	tm->tm_sec = rt.second;
+	tm->tm_isdst = rt.daylight == ACPI_TAD_TIME_ISDST;
+
+	return 0;
+}
+
+static const struct rtc_class_ops acpi_tad_rtc_ops = {
+	.read_time = acpi_tad_rtc_read_time,
+	.set_time = acpi_tad_rtc_set_time,
+};
+
+static void acpi_tad_register_rtc(struct device *dev)
+{
+	struct rtc_device *rtc;
+
+	rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc))
+		return;
+
+	rtc->range_min = mktime64(1900,  1,  1,  0,  0,  0);
+	rtc->range_max = mktime64(9999, 12, 31, 23, 59, 59);
+
+	rtc->ops = &acpi_tad_rtc_ops;
+
+	devm_rtc_register_device(rtc);
+}
+#else /* !CONFIG_RTC_CLASS */
+static inline void acpi_tad_register_rtc(struct device *dev) {}
+#endif /* !CONFIG_RTC_CLASS */
+
+/* Platform driver interface */
+
 static int acpi_tad_disable_timer(struct device *dev, u32 timer_id)
 {
 	return acpi_tad_wake_set(dev, "_STV", timer_id, ACPI_TAD_WAKE_DISABLED);
@@ -660,10 +729,15 @@ static int acpi_tad_probe(struct platfor
 	pm_runtime_suspend(dev);
 
 	ret = sysfs_create_group(&dev->kobj, &acpi_tad_attr_group);
-	if (ret)
+	if (ret) {
 		acpi_tad_remove(pdev);
+		return ret;
+	}
 
-	return ret;
+	if (caps & ACPI_TAD_RT)
+		acpi_tad_register_rtc(dev);
+
+	return 0;
 }
 
 static const struct acpi_device_id acpi_tad_ids[] = {




