Return-Path: <linux-acpi+bounces-3663-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D4B859790
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Feb 2024 16:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87F11F2114E
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Feb 2024 15:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29DB63126;
	Sun, 18 Feb 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4emYOoq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867D12E61
	for <linux-acpi@vger.kernel.org>; Sun, 18 Feb 2024 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708269341; cv=none; b=aVigeQrgS63W9YGRFouh2vDBqKCB+8CTFu2GdAAH7HhvcvYpOQfnIQTbW+AmqUTKvux5m1F3+RudVHjfESGManDPqyz3Kcs/3t4fL8hdlxTysDk7zprQEJee+5o1F+9iuhUSEETJQImyZHdPBf/Qd5pdrf5mvIiObQ9R1rCTut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708269341; c=relaxed/simple;
	bh=AT/4g82+z0A4bq4QKsiFhkfA1eqtI8Zo/JoEEPjswI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=alhzrcRkGOVPIIEnsL3ti+Z5enaYbjPIeU1pW+oN1DNVfFV5h5EDNFg5tyRiY4T/XYQcUmWHwutPXrvQmaFo2wCrH9aA6Q6vagO4tCNmnCoIdttefzZ6xf2PqQ0XS0UmRC+wOo0POgaVpZGbk5Hsn44FJQimglPRX6ImDhlTMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M4emYOoq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708269337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8N2cRJoNBGbsGMJL8la6bvhc7MCFnUApJ/hAJY4LAYs=;
	b=M4emYOoq4hFlKx3Ct7eDVIxqGHl4S89yclW2VwMRj/kf1wNVQXiA4jLfy8bHnqrhaaopUk
	aY6MhDiphvdLk7BGW5B/sXcomEe9zXxuqsfNx/ED4C6LdG5xZtIAFLzU8c15SvBNYVCIPx
	1ezMZfkJzz4vxXq3J9CUtz8iDFIVPfY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-azT1nFxDPoGryrhEUiKOeg-1; Sun,
 18 Feb 2024 10:15:35 -0500
X-MC-Unique: azT1nFxDPoGryrhEUiKOeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25C1629AC016;
	Sun, 18 Feb 2024 15:15:35 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7651B2026D06;
	Sun, 18 Feb 2024 15:15:34 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [RFC 0/2] ACPI: Adding new acpi_driver type drivers ?
Date: Sun, 18 Feb 2024 16:15:31 +0100
Message-ID: <20240218151533.5720-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hi Rafael,

I recently learned that some Dell AIOs (1) use a backlight controller board
connected to an UART. Canonical even submitted a driver for this in 2017:
https://lkml.org/lkml/2017/10/26/78

This UART has a DELL0501 HID with CID set to PNP0501 so that the UART is
still handled by 8250_pnp.c. Unfortunately there is no separate ACPI device
with an UartSerialBusV2() resource to model the backlight-controller.

The RFC patch 2/2 in this series uses acpi_quirk_skip_serdev_enumeration()
to still create a serdev for this for a backlight driver to bind to
instead of creating a /dev/ttyS0.

Like other cases where the UartSerialBusV2() resource is missing or broken
this will only create the serdev-controller device and the serdev-device
itself will need to be instantiated by the consumer (the backlight driver).

Unlike existing other cases which use DMI modaliases to load on a specific
board to work around brokeness of that board's specific ACPI tables, the
intend here is to have a single driver for all Dell AIOs using the DELL0501
HID for their UART, without needing to maintain a list of DMI matches.

This means that the dell-uart-backlight driver will need something to bind
to. The original driver from 2017 used an acpi_driver for this matching on
and binding to the DELL0501 acpi_device.

AFAIK you are trying to get rid of having drivers bind directly to
acpi_device-s so I assume that you don't want me to introduce a new one.
So to get a device to bind to without introducing a new acpi_driver
patch 2/2 if this series creates a platform_device for this.

The creation of this platform_device is why this is marked as RFC,
if you are ok with this solution I guess you can merge this series
already as is. With the caveat that the matching dell-uart-backlight
driver is still under development (its progressing nicely and the
serdev-device instantation + binding a serdev driver to it already
works).

If you have a different idea how to handle this I'm certainly open
to suggestions.

Regards,

Hans

1) All In One a monitor with a PC builtin


p.s.

I also tried this approach, but that did not work:

This was an attempt to create both a pdev from acpi_default_enumeration()
by making the PNP scan handler attach() method return 0 rather then 1;
and get a pnp_device created for the UART driver as well by
making acpi_is_pnp_device() return true.

This approach does not work due to the following code in pnpacpi_add_device():

	/* Skip devices that are already bound */
	if (device->physical_node_count)
		return 0;

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 01abf26764b0..847c08deea7b 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -353,10 +353,17 @@ static bool acpi_pnp_match(const char *idstr, const struct acpi_device_id **matc
  * given ACPI device object, the PNP scan handler will not attach to that
  * object, because there is a proper non-PNP driver in the kernel for the
  * device represented by it.
+ *
+ * The DELL0501 ACPI HID represents an UART (CID is set to PNP0501) with
+ * a backlight-controller attached. There is no separate ACPI device with
+ * an UartSerialBusV2() resource to model the backlight-controller.
+ * This setup requires instantiating both a pnp_device for the UART as well
+ * as a platform_device for the backlight-controller driver to bind too.
  */
 static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
 	{"INTC1080"},
 	{"INTC1081"},
+	{"DELL0501"},
 	{""},
 };
 
@@ -376,13 +383,16 @@ static struct acpi_scan_handler acpi_pnp_handler = {
  * For CMOS RTC devices, the PNP ACPI scan handler does not work, because
  * there is a CMOS RTC ACPI scan handler installed already, so we need to
  * check those devices and enumerate them to the PNP bus directly.
+ * For DELL0501 devices the PNP ACPI scan handler is skipped to create
+ * a platform_device, see the acpi_nonpnp_device_ids[] comment.
  */
-static int is_cmos_rtc_device(struct acpi_device *adev)
+static int is_special_pnp_device(struct acpi_device *adev)
 {
 	static const struct acpi_device_id ids[] = {
 		{ "PNP0B00" },
 		{ "PNP0B01" },
 		{ "PNP0B02" },
+		{ "DELL0501" },
 		{""},
 	};
 	return !acpi_match_device_ids(adev, ids);
@@ -390,7 +400,7 @@ static int is_cmos_rtc_device(struct acpi_device *adev)
 
 bool acpi_is_pnp_device(struct acpi_device *adev)
 {
-	return adev->handler == &acpi_pnp_handler || is_cmos_rtc_device(adev);
+	return adev->handler == &acpi_pnp_handler || is_special_pnp_device(adev);
 }
 EXPORT_SYMBOL_GPL(acpi_is_pnp_device);

 
Hans de Goede (2):
  ACPI: x86: Move acpi_quirk_skip_serdev_enumeration() out of
    CONFIG_X86_ANDROID_TABLETS
  ACPI: x86: Add DELL0501 handling to
    acpi_quirk_skip_serdev_enumeration()

 drivers/acpi/x86/utils.c | 38 ++++++++++++++++++++++++++++++++++----
 include/acpi/acpi_bus.h  | 22 +++++++++++-----------
 2 files changed, 45 insertions(+), 15 deletions(-)

-- 
2.43.0


