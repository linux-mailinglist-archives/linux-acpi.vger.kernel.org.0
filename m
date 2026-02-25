Return-Path: <linux-acpi+bounces-21171-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ4vK35jn2lRagQAu9opvQ
	(envelope-from <linux-acpi+bounces-21171-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 22:02:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA9419D8F7
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 22:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 876583055959
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 20:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3322EAD15;
	Wed, 25 Feb 2026 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmGjk/EK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81052DC789;
	Wed, 25 Feb 2026 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053063; cv=none; b=eCaFftqgI1OAmAGLGQGXcudQOnlLhC6FJGSigr+90OzPiwOQwrdnYUU+BoVrRWmRN8Kajp9IgKDvrcmM4Fwox3V6g8gU1fQeoTLaEj7Zbo/nH7aWDA+TlzNRg99OUURmB1ufLaI43nqK3jzvcQNIwMER19TEzHgLNrolz0XGrIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053063; c=relaxed/simple;
	bh=PAs1bGrn2mdKOWRmzEaVX6nloInZtadGhLhSZt/+Vd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiOBzy0owsk9YnJdjm2qSG8MVqNE0Dn+XnL5paG8dMKfm/T1dIXitR4EHvo0vzHByN6RhHKcXp9jCkDUWdwnV5ZFFjlxvfdSsJJI5jpdSAMdBFNUUhcpc0kW4lTIhrGLnlFZIji8hbv750NlzL5nIMy9jAddgL07XQsUtVtrhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmGjk/EK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8578C116D0;
	Wed, 25 Feb 2026 20:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772053063;
	bh=PAs1bGrn2mdKOWRmzEaVX6nloInZtadGhLhSZt/+Vd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BmGjk/EKyTJP0jPdPWx7zQCAjw6cvZWezt5plX4oNKADWK3j5ezvu/7T9isyxNh23
	 Rjkc/96CC6wt7TgghE4mQglFWBOVQY5SwJPy74FhA0GRC3/oAk1wSQ9xffTRaNUJhN
	 40OTybxWgCM8ACU+tfoRbTPomu8YGXBL0m0n82TOOCSritq0rgoP5eipmneMHqfLz6
	 EDt0EZ+j0VL5wF8IcKheOcseHwlGhiKwrr8a/F11BPb9ZGhJI57hlbFu6SxKA81xE8
	 qrCL6oOkSGo3WPF0Gp4+o/Fkdl/WXfpiseTJAj+8xwuvwLOJQYuB6wRGZ3YGeQAGrv
	 JFTII+AiFjFhg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject:
 [PATCH v1 3/5] platform/x86: fujitsu: Register ACPI notify handlers directly
Date: Wed, 25 Feb 2026 21:47:07 +0100
Message-ID: <10828467.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <1968442.tdWV9SEqCh@rafael.j.wysocki>
References: <1968442.tdWV9SEqCh@rafael.j.wysocki>
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
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,vger.kernel.org,just42.net];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-21171-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-acpi];
	BLOCKLISTDE_FAIL(0.00)[10.30.226.201:query timed out,100.90.174.1:query timed out,172.234.253.10:query timed out];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 4AA9419D8F7
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to using struct
platform_driver instead of struct acpi_driver, make it install its ACPI
notify handlers directly instead of using struct acpi_driver .notify()
callbacks.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/fujitsu-laptop.c | 30 ++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 1adce90ae3e6..cb13c06b8f35 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -502,8 +502,9 @@ static int fujitsu_backlight_register(struct acpi_device *device)
 
 /* Brightness notify */
 
-static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 event)
+static void acpi_fujitsu_bl_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	struct fujitsu_bl *priv = acpi_driver_data(device);
 	int oldb, newb;
 
@@ -558,7 +559,18 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
 	if (ret)
 		return ret;
 
-	return fujitsu_backlight_register(device);
+	ret = fujitsu_backlight_register(device);
+	if (ret)
+		return ret;
+
+	return acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+					       acpi_fujitsu_bl_notify, device);
+}
+
+static void acpi_fujitsu_bl_remove(struct acpi_device *device)
+{
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       acpi_fujitsu_bl_notify);
 }
 
 /* ACPI device for hotkey handling */
@@ -941,8 +953,9 @@ static void acpi_fujitsu_laptop_release(struct acpi_device *device)
 	}
 }
 
-static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
+static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	struct fujitsu_laptop *priv = acpi_driver_data(device);
 	unsigned long flags;
 	int scancode, i = 0;
@@ -1056,6 +1069,11 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	if (ret)
 		goto err_free_fifo;
 
+	ret = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+					      acpi_fujitsu_laptop_notify, device);
+	if (ret)
+		goto err_free_fifo;
+
 	ret = fujitsu_battery_charge_control_add(device);
 	if (ret < 0)
 		pr_warn("Unable to register battery charge control: %d\n", ret);
@@ -1074,6 +1092,9 @@ static void acpi_fujitsu_laptop_remove(struct acpi_device *device)
 
 	fujitsu_battery_charge_control_remove(device);
 
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       acpi_fujitsu_laptop_notify);
+
 	fujitsu_laptop_platform_remove(device);
 
 	kfifo_free(&priv->fifo);
@@ -1092,7 +1113,7 @@ static struct acpi_driver acpi_fujitsu_bl_driver = {
 	.ids = fujitsu_bl_device_ids,
 	.ops = {
 		.add = acpi_fujitsu_bl_add,
-		.notify = acpi_fujitsu_bl_notify,
+		.remove = acpi_fujitsu_bl_remove,
 		},
 };
 
@@ -1108,7 +1129,6 @@ static struct acpi_driver acpi_fujitsu_laptop_driver = {
 	.ops = {
 		.add = acpi_fujitsu_laptop_add,
 		.remove = acpi_fujitsu_laptop_remove,
-		.notify = acpi_fujitsu_laptop_notify,
 		},
 };
 
-- 
2.51.0





