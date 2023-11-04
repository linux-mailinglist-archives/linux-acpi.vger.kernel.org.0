Return-Path: <linux-acpi+bounces-1236-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB89A7E1166
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 23:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29117281452
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 22:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D615C26294
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMpFDBfd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0DB1A584
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 20:58:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4099C4
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 13:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699131512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9MYSylF7D63mQeDYGWMad8OtfBIPbXBCIH5nkZWYNMk=;
	b=VMpFDBfdsC/hpO7DD4P/VsuuA1SRW7VigJ5G4OEYmGJFQZzDPQaRY/quvcN9ynra5b8nUy
	FnX0x8D6SsFI6yEqQ2S9AJSiPn856/44vKyijqur743chmO9Qz38vH5hi75PHh3d5GNQm9
	Qtu+hlTPlxqWsR/B+4B5/z4L3mEl9/I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-DN1gPslPMmyhVjfTkCU1ug-1; Sat,
 04 Nov 2023 16:58:30 -0400
X-MC-Unique: DN1gPslPMmyhVjfTkCU1ug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6564D38117EB;
	Sat,  4 Nov 2023 20:58:30 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 63A462026D4C;
	Sat,  4 Nov 2023 20:58:29 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 1/4] ACPI: scan: Add LNXVIDEO HID to ignore_serial_bus_ids[]
Date: Sat,  4 Nov 2023 21:58:25 +0100
Message-ID: <20231104205828.63139-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

The I2C-core already has filtering to skip i2c_client instantiation for
LNXVIDEO acpi_device-s with I2cSerialBus resources, since LNXVIDEO devices
are not i2c_client-s and are handled by the acpi_video driver.

This filtering was added to i2c-core-acpi.c in commit 3a4991a9864c ("i2c:
acpi: Do not create i2c-clients for LNXVIDEO ACPI devices").

Now a similar problem has shown up where the SPI-core is instantiating
an unwanted SPI-device for a SpiSerialBus resource under a LNXVIDEO
acpi_device. On a Lenovo Yoga Tab 3 YT3-X90F this unwanted SPI-device
instanstantiation causes the SPI-device instanstantiation for the WM5102
audio codec to fail with:

[   21.988441] pxa2xx-spi 8086228E:00: chipselect 0 already in use

Instead of duplicating the I2C-core filtering in the SPI-core code, push
the filtering of SerialBus resources under LNXVIDEO acpi_device-s up into
the ACPI-core by adding the LNXVIDEO HID to ignore_serial_bus_ids[].

Note the filtering in the I2C-core i2c_acpi_do_lookup() function is still
necessary because this not only impacts i2c_client instantiation but it
also makes the I2C-core ignore the I2cSerialBus resource when checking what
the maximum speed is the I2C bus supports, which is still necessary.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 691d4b7686ee..4b6faa2350f5 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1727,6 +1727,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 * Some ACPI devs contain SerialBus resources even though they are not
 	 * attached to a serial bus at all.
 	 */
+		{ACPI_VIDEO_HID, },
 		{"MSHW0028", },
 	/*
 	 * HIDs of device with an UartSerialBusV2 resource for which userspace
-- 
2.41.0


