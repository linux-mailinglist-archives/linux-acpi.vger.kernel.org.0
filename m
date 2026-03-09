Return-Path: <linux-acpi+bounces-21560-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHMUH7AAr2lmLgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21560-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:17:36 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D023D884
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33C4F305DA08
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 17:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A309F3E5EF7;
	Mon,  9 Mar 2026 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3vMdI15"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800223E5ED8;
	Mon,  9 Mar 2026 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076294; cv=none; b=tWDrbUngmUtstrhdnHTtNdGNwJg6Vmp/gc6o/fJplJhajbMot8UT+k0BAcjEjatYDdywYTSxRUK9nQJYs6U+39tJgbeScrfurVO59crxcXl70gfKtTh17wR9m71f+ZUXrp6j5N20iyvmaqq5GeJGwb8YkIsYVLlugu2Gd72J8L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076294; c=relaxed/simple;
	bh=x3RudnlH+jxF33dQ7fIbXEfMDvwX7L129SInsmk3/Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gr64eHL1V9TZQNOq//kT49fF2UQqphJvd6nrYmDrSAMzA7wOoPJGHW8sOEnDZdzLxdGVLbukNtt9ScvjIrflFqN4zryqW8ZJF1a0cNGT4JWpEYGwMXlW64T28MIGktreHWg8/nNYawhlLQqF86N9uy++v1l77UQ5Eelarbjderk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3vMdI15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6B9C4CEF7;
	Mon,  9 Mar 2026 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773076294;
	bh=x3RudnlH+jxF33dQ7fIbXEfMDvwX7L129SInsmk3/Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3vMdI15lTEpijpBNCa3E4V3nQsZQkMd4itWNes5hkliJ0gbym/uiJ+axomJ8s4xG
	 BCBYBbvSj88pnM49vWELMfBP7GKBRF3JczjZ4itbM74zFu1B7FnpUO3lZzxTdfym9n
	 6E8NLaA7H1PzIAkd59GgB2AsGTOBvCPXQ4p6cHLvTz6WYOvMVNM/f82tHlFyZ6fhHS
	 Q8DBvN6Ee4YOE3czwZ99S6cZBUPCjprE2d7voVsdex+2jaj31L7KX+fkYxne3IEPoV
	 lEeYi1QtVuiLuT06PMRls5RcPNeaMYX9Udb6BR0dSFSqi3C2EFmI2z+1Bwa2X5NsW4
	 NznA7knsede8Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject:
 [PATCH v2 3/5] platform/x86: fujitsu: Register ACPI notify handlers directly
Date: Mon, 09 Mar 2026 18:07:37 +0100
Message-ID: <1961003.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12863082.O9o76ZdvQC@rafael.j.wysocki>
References: <12863082.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0C3D023D884
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,vger.kernel.org,just42.net];
	TAGGED_FROM(0.00)[bounces-21560-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to using struct
platform_driver instead of struct acpi_driver, make it install its ACPI
notify handlers directly instead of using struct acpi_driver .notify()
callbacks.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Call fujitsu_laptop_platform_remove() in acpi_fujitsu_laptop_add()
   error code path if notify handler registration fails (Ilpo)

---
 drivers/platform/x86/fujitsu-laptop.c | 32 ++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 1adce90ae3e6..7816a867a60c 100644
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
@@ -1056,6 +1069,13 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	if (ret)
 		goto err_free_fifo;
 
+	ret = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+					      acpi_fujitsu_laptop_notify, device);
+	if (ret) {
+		fujitsu_laptop_platform_remove(device);
+		goto err_free_fifo;
+	}
+
 	ret = fujitsu_battery_charge_control_add(device);
 	if (ret < 0)
 		pr_warn("Unable to register battery charge control: %d\n", ret);
@@ -1074,6 +1094,9 @@ static void acpi_fujitsu_laptop_remove(struct acpi_device *device)
 
 	fujitsu_battery_charge_control_remove(device);
 
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       acpi_fujitsu_laptop_notify);
+
 	fujitsu_laptop_platform_remove(device);
 
 	kfifo_free(&priv->fifo);
@@ -1092,7 +1115,7 @@ static struct acpi_driver acpi_fujitsu_bl_driver = {
 	.ids = fujitsu_bl_device_ids,
 	.ops = {
 		.add = acpi_fujitsu_bl_add,
-		.notify = acpi_fujitsu_bl_notify,
+		.remove = acpi_fujitsu_bl_remove,
 		},
 };
 
@@ -1108,7 +1131,6 @@ static struct acpi_driver acpi_fujitsu_laptop_driver = {
 	.ops = {
 		.add = acpi_fujitsu_laptop_add,
 		.remove = acpi_fujitsu_laptop_remove,
-		.notify = acpi_fujitsu_laptop_notify,
 		},
 };
 
-- 
2.51.0





