Return-Path: <linux-acpi+bounces-21043-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPYlJdoQm2lArgMAu9opvQ
	(envelope-from <linux-acpi+bounces-21043-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Feb 2026 15:21:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415E16F54D
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Feb 2026 15:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50FED300BBB5
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Feb 2026 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D361834FF49;
	Sun, 22 Feb 2026 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT357Ebs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EE225DB0D;
	Sun, 22 Feb 2026 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770072; cv=none; b=pkMnPb3fBbyVbH2FfTULH9KQNBuJb+HO2EbtiM4cXhqlj+P2MJ6W+Nc7EVwJsJXgTUas147udZ4ZKyYRV6GfyoofvzD+drFpD6jhMwtNYDJTsI1faEuKtYaCsBpZ09QsRAf1mwwBygHJO3H3bkebYqEfWN4SqWDsvNOBJszhre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770072; c=relaxed/simple;
	bh=Wnb2YfEU6i9cMmpYwUDtZ2E3EJ4153psC3JNN7Xlfy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVjs+Ue+4Sw9oy/n3aNa9WPnem28PznyRRs7bwo9/wG79UfqYm4+OghCqCv6PviCJFQMwsO3d3vGlb/c4oGt1s1AUqqj2Ay0O9fVmK63H88BPeJf1hhh9Du0jCYpFcVx5FHc0ezhViGi7EsDP+lO2mABa7J8HnnhtUL7chn29Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT357Ebs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E13C19424;
	Sun, 22 Feb 2026 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771770072;
	bh=Wnb2YfEU6i9cMmpYwUDtZ2E3EJ4153psC3JNN7Xlfy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KT357EbsehDE+ZP2M84LHEn7wjTf4cGRn6FIs+96mzpQAl0tYdiSiuDXQYRHT3kU7
	 hnAdxIE7rwCyBSlmY4a0wyMsbswPynl9T2Aa/rxFbh1jDMvVM/M52c5waJE4lF89DZ
	 BVjxGV6XObU4kgVpA3gjKLekRwf4cuTfPQPxfUpL0inqnHaYJ+1uyr3TvcuYkGwSf1
	 qv4njut8ac/hP+w/d9YnoguPm1o+1Uq9f/I6y2gNEtRg7u5znLwFf8QPefN5uTm1d0
	 Q1uKZClRToSfXdwzClA0teScOxqZLWRsq/9eCYmLqtONJEoCFx4jb9dalYXSUraGo1
	 BuoQ9X14W1arw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Danilo Krummrich <dakr@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 5/6] ACPI: TAD: Add RTC class device interface
Date: Sun, 22 Feb 2026 15:18:29 +0100
Message-ID: <10819001.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4727679.LvFx2qVVIh@rafael.j.wysocki>
References: <4727679.LvFx2qVVIh@rafael.j.wysocki>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21043-lists,linux-acpi=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,rt.tz:url]
X-Rspamd-Queue-Id: 3415E16F54D
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add an RTC class device interface allowing to read and set the real time
value and providing a procfs callback to the ACPI TAD driver.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 2 deletions(-)

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
@@ -579,6 +583,77 @@ static const struct attribute_group acpi
 	.is_visible = acpi_tad_attr_is_visible,
 };
 
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
+static int acpi_tad_rtc_procfs(struct device *dev, struct seq_file *seq)
+{
+	struct acpi_tad_rt rt;
+	int ret;
+
+	ret = acpi_tad_get_real_time(dev, &rt);
+	if (ret)
+		return ret;
+
+	seq_printf(seq,
+		   "Time\t\t: %u:%u:%u\n"
+		   "Date\t\t: %u-%u-%u\n"
+		   "Daylight\t: %s\n",
+		   rt.hour, rt.minute, rt.second,
+		   rt.year, rt.month, rt.day,
+		   str_yes_no(rt.daylight == ACPI_TAD_TIME_ISDST));
+
+	if (rt.tz == ACPI_TAD_TZ_UNSPEC)
+		seq_puts(seq, "Timezone\t: unspecified\n");
+	else
+		seq_printf(seq, "Timezone\t: %d\n", rt.tz);
+
+	return 0;
+}
+
+static const struct rtc_class_ops acpi_tad_rtc_ops = {
+	.read_time = acpi_tad_rtc_read_time,
+	.set_time = acpi_tad_rtc_set_time,
+	.proc = acpi_tad_rtc_procfs,
+};
+
+/* Platform driver interface */
+
 static int acpi_tad_disable_timer(struct device *dev, u32 timer_id)
 {
 	return acpi_tad_wake_set(dev, "_STV", timer_id, ACPI_TAD_WAKE_DISABLED);
@@ -655,10 +730,16 @@ static int acpi_tad_probe(struct platfor
 	pm_runtime_suspend(dev);
 
 	ret = sysfs_create_group(&dev->kobj, &acpi_tad_attr_group);
-	if (ret)
+	if (ret) {
 		acpi_tad_remove(pdev);
+		return ret;
+	}
 
-	return ret;
+	if (caps & ACPI_TAD_RT)
+		devm_rtc_device_register(dev, "acpi-tad-rtc", &acpi_tad_rtc_ops,
+					 THIS_MODULE);
+
+	return 0;
 }
 
 static const struct acpi_device_id acpi_tad_ids[] = {




