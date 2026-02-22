Return-Path: <linux-acpi+bounces-21047-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNIABeoQm2lArgMAu9opvQ
	(envelope-from <linux-acpi+bounces-21047-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Feb 2026 15:21:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E1716F56A
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Feb 2026 15:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17591300AB39
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Feb 2026 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0860B350298;
	Sun, 22 Feb 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFE0iNbR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A0350282;
	Sun, 22 Feb 2026 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770086; cv=none; b=UQORnN8qyXlvWmj23rMcQdpOYfqgwtrE1YKmGbHtC8ocQu+m+4NheiHneGWTulML7rUX/Gx+d8jVAcXsn/fh6t9WEwJJQIhmaSn4Q/czbGNzLcbvzpSlAKCaLF+1UAJU/2Ofc1+KXVLpyjktVZwUhMjbooH5rkb1wEBsbgtWpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770086; c=relaxed/simple;
	bh=Z1GYpT7kRexzOKqSnvyNE61CrfrquC7xWfy+vlP+gwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTCDCwSbO4MoV36dSn6zcTaqMhkJzls3evwS2zfbSZYtxHt1gS6cWNCru5SSKAaHzOFUXcrqv3A68Kbloj9INfw8blyBvvadIdVLiVLkFKsAfEh6ZwjVQSkxb2ASHQo6UerdOo0DyEtCRuwSs5p3ZUprpqpBoPvo08X9rDIi7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFE0iNbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038D9C19424;
	Sun, 22 Feb 2026 14:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771770086;
	bh=Z1GYpT7kRexzOKqSnvyNE61CrfrquC7xWfy+vlP+gwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFE0iNbRPEe3RyimAA/wkaResDZb2I7Ih1OzOoc7WW9Qqx+CLYJLFcwu75Rmu+T/S
	 eSXiKdfzMZXZyW3bGb6dVyxMv3XuTjetS47Js7jvEcvuRkNuIKlG5sw34ueKORxYbv
	 5OKzto1pg6XRO+3M17NK599NXBZ6qaDZ0qAi/NIV9iKFRFcp3Zwqi/JnzT/BaWy/SH
	 9E51fZQE7Wtaxmzox8mtx/meTr0eBfEz2JTKeOLK0c5KZzxSeB79DcWaLXUJ6aNDtl
	 lhI6X+sPCDUzaEZMAQfCtRU8+5dFvnpeDCYAOw7vK+H20hXs48+9+Bdpg0mZsLf76I
	 4nqcMJp9RO12A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Danilo Krummrich <dakr@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 1/6] ACPI: TAD: Create one attribute group
Date: Sun, 22 Feb 2026 15:15:37 +0100
Message-ID: <5063303.GXAFRqVoOG@rafael.j.wysocki>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21047-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rafael.j.wysocki:mid,intel.com:email]
X-Rspamd-Queue-Id: E5E1716F56A
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of creating three attribute groups, one for each supported
subset of capabilities, create just one and use an .is_visible()
callback in it to decide which attributes will be visible.

Also stop failing proble if the AC wakeup capability is not
supported.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   85 +++++++++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 50 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -249,14 +249,6 @@ static ssize_t time_show(struct device *
 
 static DEVICE_ATTR_RW(time);
 
-static struct attribute *acpi_tad_time_attrs[] = {
-	&dev_attr_time.attr,
-	NULL,
-};
-static const struct attribute_group acpi_tad_time_attr_group = {
-	.attrs	= acpi_tad_time_attrs,
-};
-
 static int acpi_tad_wake_set(struct device *dev, char *method, u32 timer_id,
 			     u32 value)
 {
@@ -486,17 +478,6 @@ static ssize_t ac_status_show(struct dev
 
 static DEVICE_ATTR_RW(ac_status);
 
-static struct attribute *acpi_tad_attrs[] = {
-	&dev_attr_caps.attr,
-	&dev_attr_ac_alarm.attr,
-	&dev_attr_ac_policy.attr,
-	&dev_attr_ac_status.attr,
-	NULL,
-};
-static const struct attribute_group acpi_tad_attr_group = {
-	.attrs	= acpi_tad_attrs,
-};
-
 static ssize_t dc_alarm_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -545,14 +526,45 @@ static ssize_t dc_status_show(struct dev
 
 static DEVICE_ATTR_RW(dc_status);
 
-static struct attribute *acpi_tad_dc_attrs[] = {
+static struct attribute *acpi_tad_attrs[] = {
+	&dev_attr_caps.attr,
+	&dev_attr_ac_alarm.attr,
+	&dev_attr_ac_policy.attr,
+	&dev_attr_ac_status.attr,
 	&dev_attr_dc_alarm.attr,
 	&dev_attr_dc_policy.attr,
 	&dev_attr_dc_status.attr,
+	&dev_attr_time.attr,
 	NULL,
 };
-static const struct attribute_group acpi_tad_dc_attr_group = {
-	.attrs	= acpi_tad_dc_attrs,
+
+static umode_t acpi_tad_attr_is_visible(struct kobject *kobj,
+					struct attribute *a, int n)
+{
+	struct acpi_tad_driver_data *dd = dev_get_drvdata(kobj_to_dev(kobj));
+
+	if (a == &dev_attr_caps.attr)
+		return a->mode;
+
+	if ((dd->capabilities & ACPI_TAD_AC_WAKE) &&
+	    (a == &dev_attr_ac_alarm.attr || a == &dev_attr_ac_policy.attr ||
+	     a == &dev_attr_ac_status.attr))
+		return a->mode;
+
+	if ((dd->capabilities & ACPI_TAD_DC_WAKE) &&
+	    (a == &dev_attr_dc_alarm.attr || a == &dev_attr_dc_policy.attr ||
+	     a == &dev_attr_dc_status.attr))
+		return a->mode;
+
+	if ((dd->capabilities & ACPI_TAD_RT) && a == &dev_attr_time.attr)
+		return a->mode;
+
+	return 0;
+}
+
+static const struct attribute_group acpi_tad_attr_group = {
+	.attrs	= acpi_tad_attrs,
+	.is_visible = acpi_tad_attr_is_visible,
 };
 
 static int acpi_tad_disable_timer(struct device *dev, u32 timer_id)
@@ -567,12 +579,6 @@ static void acpi_tad_remove(struct platf
 
 	device_init_wakeup(dev, false);
 
-	if (dd->capabilities & ACPI_TAD_RT)
-		sysfs_remove_group(&dev->kobj, &acpi_tad_time_attr_group);
-
-	if (dd->capabilities & ACPI_TAD_DC_WAKE)
-		sysfs_remove_group(&dev->kobj, &acpi_tad_dc_attr_group);
-
 	sysfs_remove_group(&dev->kobj, &acpi_tad_attr_group);
 
 	scoped_guard(pm_runtime_noresume, dev) {
@@ -607,11 +613,6 @@ static int acpi_tad_probe(struct platfor
 		return -ENODEV;
 	}
 
-	if (!(caps & ACPI_TAD_AC_WAKE)) {
-		dev_info(dev, "Unsupported capabilities\n");
-		return -ENODEV;
-	}
-
 	if (!acpi_has_method(handle, "_PRW")) {
 		dev_info(dev, "Missing _PRW\n");
 		return -ENODEV;
@@ -643,24 +644,8 @@ static int acpi_tad_probe(struct platfor
 
 	ret = sysfs_create_group(&dev->kobj, &acpi_tad_attr_group);
 	if (ret)
-		goto fail;
-
-	if (caps & ACPI_TAD_DC_WAKE) {
-		ret = sysfs_create_group(&dev->kobj, &acpi_tad_dc_attr_group);
-		if (ret)
-			goto fail;
-	}
-
-	if (caps & ACPI_TAD_RT) {
-		ret = sysfs_create_group(&dev->kobj, &acpi_tad_time_attr_group);
-		if (ret)
-			goto fail;
-	}
-
-	return 0;
+		acpi_tad_remove(pdev);
 
-fail:
-	acpi_tad_remove(pdev);
 	return ret;
 }
 




