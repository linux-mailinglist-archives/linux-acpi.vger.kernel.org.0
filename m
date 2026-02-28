Return-Path: <linux-acpi+bounces-21252-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABDpMzsGo2lo9AQAu9opvQ
	(envelope-from <linux-acpi+bounces-21252-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:14:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DED201C3D74
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA348304128A
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 15:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F7D4534BE;
	Sat, 28 Feb 2026 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqrj6MjJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D52D6E55;
	Sat, 28 Feb 2026 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772291604; cv=none; b=p/TfUgmxvKDlvFGp5Ehsa5z+gsDaXWBdqo0a9HbfyKGibKb9588B7XNyZrdzDThHxcO6C9PMjgIMUEbzYsLBhMARku7zDYvjdLwkBhR4bW/4sRs8fWvJc9vLtRpgGpZJ4wjNBFcG9odGNFryNND1sKRey5Y+MxflnhbbFJx9BsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772291604; c=relaxed/simple;
	bh=Z7MGjeaKrghIRXvHj3sjOMomomFKo2VTFmMgAlLX3b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HV1znQ3dF0m+c9tsesOtagYqG5LP5L800fOijPfVckoxfDmJLyTtjncIgZ0u2ozj3jpQMdH0n6TPSOO9EL+Xe/iiKj0rA9SbAjuKcv0s2MM2eIUv+dn/tUWxeMq605za2g0fXtG4zKQx8jDiZeRQVrgo2HgSFqtir7YLGMv2JTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqrj6MjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90457C19421;
	Sat, 28 Feb 2026 15:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772291604;
	bh=Z7MGjeaKrghIRXvHj3sjOMomomFKo2VTFmMgAlLX3b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zqrj6MjJXcQjMqSTcY/6TChS4ZLUso5yGWTejjNcrsqAJB9BqvwzR6wRFdS9QA0T7
	 7bO+wqPxCVbmdJNBU0Z1Ws8/d1EBLk79yc/UiyNV+WVTR8yLv4QYL96jk3yx+LJ0NZ
	 q75Z06/ibwRlpIbakhQ5k7IqS8btFDimTd1tPeMarAHwwhUXWYt6lLViu59fxckG2x
	 f+4zqNmDa9ZoDyrrwE/My5QOSB1smfz/eoezQlPjsWV6XQK9ZBRaP4enCRmhIkWq1w
	 dEI6516Z+seWvjV781n1bgyHQUVYP3uE6Jo2NHmjoGmwEG7nuv+JYk0fz7okK8ZRxQ
	 Wr4g5g8t8C+Cg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <benato.denis96@gmail.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject:
 [PATCH v1 1/4] platform/x86: asus-laptop: Register ACPI notify handler
 directly
Date: Sat, 28 Feb 2026 16:10:21 +0100
Message-ID: <5082508.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5971620.DvuYhMxLoT@rafael.j.wysocki>
References: <5971620.DvuYhMxLoT@rafael.j.wysocki>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21252-lists,linux-acpi=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DED201C3D74
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/asus-laptop.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index d96f6af26ff7..c927665dfa96 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1517,9 +1517,9 @@ static void asus_input_exit(struct asus_laptop *asus)
 /*
  * ACPI driver
  */
-static void asus_acpi_notify(struct acpi_device *device, u32 event)
+static void asus_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct asus_laptop *asus = acpi_driver_data(device);
+	struct asus_laptop *asus = data;
 	u16 count;
 
 	/* TODO Find a better way to handle events count. */
@@ -1881,6 +1881,11 @@ static int asus_acpi_add(struct acpi_device *device)
 	if (result && result != -ENODEV)
 		goto fail_pega_rfkill;
 
+	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+						 asus_acpi_notify, asus);
+	if (result)
+		goto fail_pega_rfkill;
+
 	asus_device_present = true;
 	return 0;
 
@@ -1906,6 +1911,7 @@ static void asus_acpi_remove(struct acpi_device *device)
 {
 	struct asus_laptop *asus = acpi_driver_data(device);
 
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, asus_acpi_notify);
 	asus_backlight_exit(asus);
 	asus_rfkill_exit(asus);
 	asus_led_exit(asus);
@@ -1932,7 +1938,6 @@ static struct acpi_driver asus_acpi_driver = {
 	.ops = {
 		.add = asus_acpi_add,
 		.remove = asus_acpi_remove,
-		.notify = asus_acpi_notify,
 		},
 };
 
-- 
2.51.0





