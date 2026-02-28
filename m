Return-Path: <linux-acpi+bounces-21258-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEUoH5YIo2m/9AQAu9opvQ
	(envelope-from <linux-acpi+bounces-21258-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:24:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D145C1C3E48
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2054930E9BEF
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAED1478879;
	Sat, 28 Feb 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpmC7SWv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E647886C;
	Sat, 28 Feb 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292200; cv=none; b=aLsXiF9pDTTY+kGLphSe45kHHDlqK50qdzT7m2qiIAkUT5UJvUZVPvzteNJdazFu9oOCZfC/utDl5MfdhbPjd/RyWYPEmkhtGi+6FtSUIpjCF20QM/AkLx8fRHxqqgL/SNhLVrCep/x5YP/c5x67PJnL25OD2DMFYEZxaMrroqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292200; c=relaxed/simple;
	bh=MJXWblM739RYRpdFmI1gK9MFn9b2EdZcgFEaiSl27W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgKWi+oLqPItwJLbo6IN0RCGisqsX4LrfD8Pc4s6YS1ctWFKaSXqGqlPU539T78j+x9UXunUiGexlug4Y+J2saVi8RgulvZc46xVGAIvMD9gFcNuTE5JqE4gcujycXbCHwQcHbY8wltW0GmeQguXw9gSROQlSo5Yp6v+9VQnIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpmC7SWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7078DC19421;
	Sat, 28 Feb 2026 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772292200;
	bh=MJXWblM739RYRpdFmI1gK9MFn9b2EdZcgFEaiSl27W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PpmC7SWv6T9c2qZQ8GdXG43x0M0G7lMYs7d48gx1jPdfAb/oPo1uyyvDNHGiWP5YD
	 o6DOauX/V1QHBzsH2ED4qCwI6PxrgCJai/f5U/zagyUcaozxai6KvGLsp/Zdgaca2m
	 BrgUofkyGao8OlgVR/MfP75fAFSAUZjTtnljxo5f0GixnPiOrW9mGrLVz02tlDGQ7X
	 bznf4H0JCiNcsNX9aelyROgegrp2pV4zVuSTO34hdSAnm1MNjhmKOUUEam2K6NyL5X
	 GJtRUkZuSJV/z9kfi0fdaeXoB5QJQIMNFotPll49PRpP9MMN4hokA82FedEA5So2ED
	 m6f/khdnfj2vQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <benato.denis96@gmail.com>
Subject:
 [PATCH v1 1/2] platform/x86: eeepc-laptop: Register ACPI notify handler
 directly
Date: Sat, 28 Feb 2026 16:22:08 +0100
Message-ID: <3681264.iIbC2pHGDl@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <7916328.EvYhyI6sBW@rafael.j.wysocki>
References: <7916328.EvYhyI6sBW@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21258-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,ljones.dev];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D145C1C3E48
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 974f55e0b36f..626a99a71fce 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1204,9 +1204,10 @@ static void eeepc_input_notify(struct eeepc_laptop *eeepc, int event)
 		pr_info("Unknown key %x pressed\n", event);
 }
 
-static void eeepc_acpi_notify(struct acpi_device *device, u32 event)
+static void eeepc_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct eeepc_laptop *eeepc = acpi_driver_data(device);
+	struct eeepc_laptop *eeepc = data;
+	struct acpi_device *device = eeepc->device;
 	int old_brightness, new_brightness;
 	u16 count;
 
@@ -1422,9 +1423,16 @@ static int eeepc_acpi_add(struct acpi_device *device)
 	if (result)
 		goto fail_rfkill;
 
+	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
+						 eeepc_acpi_notify, eeepc);
+	if (result)
+		goto fail_acpi_notifier;
+
 	eeepc_device_present = true;
 	return 0;
 
+fail_acpi_notifier:
+	eeepc_rfkill_exit(eeepc);
 fail_rfkill:
 	eeepc_led_exit(eeepc);
 fail_led:
@@ -1444,6 +1452,7 @@ static void eeepc_acpi_remove(struct acpi_device *device)
 {
 	struct eeepc_laptop *eeepc = acpi_driver_data(device);
 
+	acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY, eeepc_acpi_notify);
 	eeepc_backlight_exit(eeepc);
 	eeepc_rfkill_exit(eeepc);
 	eeepc_input_exit(eeepc);
@@ -1464,11 +1473,9 @@ static struct acpi_driver eeepc_acpi_driver = {
 	.name = EEEPC_LAPTOP_NAME,
 	.class = EEEPC_ACPI_CLASS,
 	.ids = eeepc_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = eeepc_acpi_add,
 		.remove = eeepc_acpi_remove,
-		.notify = eeepc_acpi_notify,
 	},
 };
 
-- 
2.51.0





