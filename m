Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C6C1D3F58
	for <lists+linux-acpi@lfdr.de>; Thu, 14 May 2020 22:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgENUwv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 May 2020 16:52:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32900 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727835AbgENUwu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2020 16:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589489569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z1B3fYOYm8pvnyTjtbhTkkBslablP1daKS/L1NhMlF8=;
        b=Sl80lIr4X1sI4SKCf/WERF5bRlYqZtmCrf6QHyfKVtW+B3yfLSor6uDVMl7oIEZFMXH6sv
        WaHSyMVQ1hUVaQLPXjA9z3f3R9Cz0DCM3N9fnp9cXWpq2aU1ZT5qtWuIgc990CKr2cEVyq
        RJhaXuT//+NrqKWAPFCp2vEWFqlg4sM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-PUP0xLt9Pd-c5w3zpS7DpQ-1; Thu, 14 May 2020 16:52:47 -0400
X-MC-Unique: PUP0xLt9Pd-c5w3zpS7DpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78ECB474;
        Thu, 14 May 2020 20:52:46 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3976F1000320;
        Thu, 14 May 2020 20:52:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH 2/2] Input: soc_button_array - Add support for INT33D3 tablet-mode switch devices
Date:   Thu, 14 May 2020 22:52:42 +0200
Message-Id: <20200514205242.138230-2-hdegoede@redhat.com>
In-Reply-To: <20200514205242.138230-1-hdegoede@redhat.com>
References: <20200514205242.138230-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

According to the Microsoft documentation for Windows 8 convertible
devices, these devices should implement a PNP0C60 "laptop/slate mode state
indicator" ACPI device.

This device can work in 2 ways, if there is a GPIO which directly
indicates the device is in tablet-mode or not then the direct-gpio mode
should be used. If there is no such GPIO, but instead the events are
coming from e.g. the embedded-controller, then there should still be
a PNP0C60 ACPI device and event-injection should be used to send the
events. The drivers/platform/x86/intel-vbtn.c code is an example from
a standardized manner of doing the latter.

On various 2-in-1s with either a detachable keyboard, or with 360°
hinges, the direct GPIO mode is indicated by an ACPI device with a
HID of INT33D3, which contains a single GpioInt in its ACPI resource
table, which directly indicates if the device is in tablet-mode or not.

This commit adds support for this to the soc_button_array code, as
well as for the alternative ID9001 HID which some devices use
instead of the INT33D3 HID.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/soc_button_array.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index e3a22a61f5d9..837c787e9c4b 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -397,6 +397,15 @@ static const struct soc_device_data soc_device_PNP0C40 = {
 	.button_info = soc_button_PNP0C40,
 };
 
+static const struct soc_button_info soc_button_INT33D3[] = {
+	{ "tablet_mode", 0, EV_SW, SW_TABLET_MODE, false, false, false },
+	{ }
+};
+
+static const struct soc_device_data soc_device_INT33D3 = {
+	.button_info = soc_button_INT33D3,
+};
+
 /*
  * Special device check for Surface Book 2 and Surface Pro (2017).
  * Both, the Surface Pro 4 (surfacepro3_button.c) and the above mentioned
@@ -459,6 +468,8 @@ static const struct soc_device_data soc_device_MSHW0040 = {
 
 static const struct acpi_device_id soc_button_acpi_match[] = {
 	{ "PNP0C40", (unsigned long)&soc_device_PNP0C40 },
+	{ "INT33D3", (unsigned long)&soc_device_INT33D3 },
+	{ "ID9001", (unsigned long)&soc_device_INT33D3 },
 	{ "ACPI0011", 0 },
 
 	/* Microsoft Surface Devices (5th and 6th generation) */
-- 
2.26.0

