Return-Path: <linux-acpi+bounces-21354-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AqGC1GBqGmYvAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21354-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 20:00:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96642206C2D
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 20:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B598F316C664
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7243D75C3;
	Wed,  4 Mar 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJm1IkvI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5912F26E706;
	Wed,  4 Mar 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650545; cv=none; b=n1ACpysoXYEdWaS1pCupfiE+U6makTWLZUMI5m4uyeHhQIOZte4SWLn0ybNWUJRMuZQmOd48Oq+0pBJdXSyxzDRWH8GAgMagGk4nJCpqBRoinu8z2by48Oq4l5DZTpSB7yfLD1J9i9tla960vrsq96U3YDjfEI/tG9Z87Td/OAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650545; c=relaxed/simple;
	bh=xjT6WTJcnXYr+ovaB1HIY41Fj5oLXC7PQvl+9n8hlLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bk3cddxrl8eJIXC2Lrl0c1HT5P71aZzgCx1ElM5NhJdKpzfzeEHwgxE5UCTl5zAiZ0RSmehsrAuFQKITKAn5+pNcXYIcaE5Ja/5fYTAS6cHxjISCE70yxgv+bS7zy7QZ4MOUkENo/uvSwz4EmPn07At620lx94xc1siypH2Ay8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJm1IkvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79195C2BC86;
	Wed,  4 Mar 2026 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772650545;
	bh=xjT6WTJcnXYr+ovaB1HIY41Fj5oLXC7PQvl+9n8hlLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJm1IkvIrhH/5uJ8AnnNeTjkPxvVeZuTVcC8j6Sowmx7Gni8E98gXiUsik+PgfhNZ
	 NrFTnqqlYUpoO9dhnIGqR6V5QSTx2xgCSpbpSASg3mqodtE0f8BN/DCxpWv6mBMu7y
	 dzGxLfwMGnyQhGXk/1QgB9zvdEnsPL860nWlWn3TWGB+Xb4FY7emDn5/X3Me9geq0R
	 wFedjGADzq7MNgig7ttetekMKuiCeGhuyZYKNrv+p+vmPSH7bBbieV6PWXvj7mq/Cp
	 SNj6c86QAYPSGgv42GF4QGD4+6mUTLeYrH2rbJWTFpDtGmZFZh+NQ0+SLDlFYLlav0
	 ZgUJrJrwEh0qQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 2/3] platform/surface: surfacepro3_button: Register ACPI notify
 handler
Date: Wed, 04 Mar 2026 19:54:47 +0100
Message-ID: <1881356.TLkxdtWsSY@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2909929.BEx9A2HvPv@rafael.j.wysocki>
References: <2909929.BEx9A2HvPv@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 96642206C2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21354-lists,linux-acpi=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/surface/surfacepro3_button.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
index a6c9d4d370be..6d394daf5bc4 100644
--- a/drivers/platform/surface/surfacepro3_button.c
+++ b/drivers/platform/surface/surfacepro3_button.c
@@ -72,8 +72,9 @@ struct surface_button {
 	bool suspended;
 };
 
-static void surface_button_notify(struct acpi_device *device, u32 event)
+static void surface_button_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	struct surface_button *button = acpi_driver_data(device);
 	struct input_dev *input;
 	int key_code = KEY_RESERVED;
@@ -227,6 +228,15 @@ static int surface_button_add(struct acpi_device *device)
 		goto err_free_input;
 
 	device_init_wakeup(&device->dev, true);
+
+	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+						surface_button_notify, device);
+	if (error) {
+		device_init_wakeup(&device->dev, false);
+		input_unregister_device(input);
+		goto err_free_button;
+	}
+
 	dev_info(&device->dev, "%s [%s]\n", acpi_device_name(device),
 		 acpi_device_bid(device));
 	return 0;
@@ -242,6 +252,8 @@ static void surface_button_remove(struct acpi_device *device)
 {
 	struct surface_button *button = acpi_driver_data(device);
 
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       surface_button_notify);
 	device_init_wakeup(&device->dev, false);
 	input_unregister_device(button->input);
 	kfree(button);
@@ -257,7 +269,6 @@ static struct acpi_driver surface_button_driver = {
 	.ops = {
 		.add = surface_button_add,
 		.remove = surface_button_remove,
-		.notify = surface_button_notify,
 	},
 	.drv.pm = &surface_button_pm,
 };
-- 
2.51.0





