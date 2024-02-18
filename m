Return-Path: <linux-acpi+bounces-3664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BC8859791
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Feb 2024 16:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973001C20A64
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Feb 2024 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D886BFD3;
	Sun, 18 Feb 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsRj1gkT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250FF6BFB1
	for <linux-acpi@vger.kernel.org>; Sun, 18 Feb 2024 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708269341; cv=none; b=A2DdSKg8NbI4rZshV6JizP6KsGbOBbu49Y3I2g7lSnlmXA4qlVFAkByMSYkQo6WY0qUeR3OxJijpLN4YgcbR1gmExvhFrBMi+8G4Z5ZVNT7G6MWdh1AG0PclTZoNFxFJr2vfUDo59/GbBw7s6dpLaaJT3Ti699gKh34xlUHnDm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708269341; c=relaxed/simple;
	bh=2o0ttsWy89W6/u5LrL+3e4IjYNW50nbyuEYMJYS97aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNrz42RLLAvmJHzY/mwFu3/c2bklIM8Jz4Ac0h8NGch5krt0uNUuE/vA7B6Q/lKKexqVBY7oHMJfcIhtfT1GM0fzIjVfIOTJtAXgdTV5NWg9IMm5yRTJ79M9hxYLKzfGaW1ztwHGWI9rlTTPkMeerHA/7F/B/5pa/0aUXY2SK58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RsRj1gkT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708269338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=169qxuN/SLhNSbuvpjTl9Gx75EiQBZCj2mn9mrkTc+k=;
	b=RsRj1gkT+lgtFFSfKZemEwU6MOCgkHYiPXoezPuIPxCT6qgM6QH0CtL+YTX8vzWOd+M2uk
	JB7JgpVE2Di2zWitPfzy8a4UuyCjBT13rshqM+62ybwbOE8We66+KInvwXtU+DpxqXtwcp
	sIWSNCPdiTUx/3TxMrwku0cwPCuICBw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-m85nvEjjOXiPF7ZaZWBHwg-1; Sun, 18 Feb 2024 10:15:37 -0500
X-MC-Unique: m85nvEjjOXiPF7ZaZWBHwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF186101A52A;
	Sun, 18 Feb 2024 15:15:36 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3177C2026D06;
	Sun, 18 Feb 2024 15:15:36 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [RFC 2/2] ACPI: x86: Add DELL0501 handling to acpi_quirk_skip_serdev_enumeration()
Date: Sun, 18 Feb 2024 16:15:33 +0100
Message-ID: <20240218151533.5720-3-hdegoede@redhat.com>
In-Reply-To: <20240218151533.5720-1-hdegoede@redhat.com>
References: <20240218151533.5720-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Some recent(ish) Dell AIO devices have a backlight controller board
connected to an UART.

This UART has a DELL0501 HID with CID set to PNP0501 so that the UART is
still handled by 8250_pnp.c. Unfortunately there is no separate ACPI device
with an UartSerialBusV2() resource to model the backlight-controller.
This causes the kernel to create a /dev/ttyS0 char-device for the UART
instead of creating an in kernel serdev-controller + serdev-device pair
for a kernel backlight driver.

Use the existing acpi_quirk_skip_serdev_enumeration() mechanism to work
around this by returning skip=true for tty-ctrl parents with a HID
of DELL0501.

Like other cases where the UartSerialBusV2() resource is missing or broken
this will only create the serdev-controller device and the serdev-device
itself will need to be instantiated by platform code.

Unfortunately in this case there is no device for the platform-code
instantiating the serdev-device to bind to. So also create
a platform_device for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 185176a521ad..c7af2d2986fd 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -493,8 +493,28 @@ static int acpi_dmi_skip_serdev_enumeration(struct device *controller_parent, bo
 
 int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
 {
+	struct acpi_device *adev = ACPI_COMPANION(controller_parent);
+
 	*skip = false;
 
+	/*
+	 * The DELL0501 ACPI HID represents an UART (CID is set to PNP0501) with
+	 * a backlight-controller attached. There is no separate ACPI device with
+	 * an UartSerialBusV2() resource to model the backlight-controller.
+	 * Set skip to true so that the tty core creates a serdev ctrl device.
+	 * The backlight driver will manually create the serdev client device.
+	 */
+	if (acpi_dev_hid_match(adev, "DELL0501")) {
+		*skip = true;
+		/*
+		 * Create a platform dev for dell-uart-backlight to bind to.
+		 * This is a static device, so no need to store the result.
+		 */
+		platform_device_register_simple("dell-uart-backlight", PLATFORM_DEVID_NONE,
+						NULL, 0);
+		return 0;
+	}
+
 	return acpi_dmi_skip_serdev_enumeration(controller_parent, skip);
 }
 EXPORT_SYMBOL_GPL(acpi_quirk_skip_serdev_enumeration);
-- 
2.43.0


