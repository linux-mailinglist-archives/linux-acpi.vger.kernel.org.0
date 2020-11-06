Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8CD2A9753
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Nov 2020 15:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgKFOBj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Nov 2020 09:01:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbgKFOBi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Nov 2020 09:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604671297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=S00aK9fNTqlK7mSJ9g7X1HE/gjrKeLDzQAXdMZ1JGdw=;
        b=bSK52ZQwNdPjHfWzQr+6fisrNrmOedVLByv/ld7arGqsgRitCxal8xIrjgH6p1tLRmTskG
        quuczA9PPmHoZp4GjL5JfBR8tNmL6ylOHfq0avj4nNcIoOMYIV0jTck9pn1S8N97iwxfhc
        5elUkNm7/OfgINmjeOGpbmypjhSMOXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-1h2p-XBwOlSVFC2VbMdyKw-1; Fri, 06 Nov 2020 09:01:34 -0500
X-MC-Unique: 1h2p-XBwOlSVFC2VbMdyKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E432D5F9F4;
        Fri,  6 Nov 2020 14:01:32 +0000 (UTC)
Received: from x1.localdomain (ovpn-113-52.ams2.redhat.com [10.36.113.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 644A71007615;
        Fri,  6 Nov 2020 14:01:31 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <mgross@linux.intel.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: thinkpad_acpi: Do not report SW_TABLET_MODE on Yoga 11e
Date:   Fri,  6 Nov 2020 15:01:30 +0100
Message-Id: <20201106140130.46820-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Yoga 11e series has 2 accelerometers described by a BOSC0200 ACPI node.
This setup relies on a Windows service which reads both accelerometers and
then calculates the angle between the 2 halves to determine laptop / tent /
tablet mode and then reports the calculated mode back to the EC by calling
special ACPI methods on the BOSC0200 node.

The bmc150 iio driver does not support this (it involves double
calculations requiring sqrt and arccos so this really needs to be done
in userspace), as a result of this on the Yoga 11e the thinkpad_acpi
code always reports SW_TABLET_MODE=0, starting with GNOME 3.38 reporting
SW_TABLET_MODE=0 causes GNOME to:

1. Not show the onscreen keyboard when a text-input field is focussed
   with the touchscreen.
2. Disable accelerometer based auto display-rotation.

This makes sense when in laptop-mode but not when in tablet-mode. But
since for the Yoga 11e the thinkpad_acpi code always reports
SW_TABLET_MODE=0, GNOME does not know when the device is in tablet-mode.

Stop reporting the broken (always 0) SW_TABLET_MODE on Yoga 11e models
to fix this.

Note there are plans for userspace to support 360 degree hinges style
2-in-1s with 2 accelerometers and figure out the mode by itself, see:
https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/issues/216

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 7fc779cd652a..08d5bb3104f9 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3220,7 +3220,14 @@ static int hotkey_init_tablet_mode(void)
 
 		in_tablet_mode = hotkey_gmms_get_tablet_mode(res,
 							     &has_tablet_mode);
-		if (has_tablet_mode)
+		/*
+		 * The Yoga 11e series has 2 accelerometers described by a
+		 * BOSC0200 ACPI node. This setup relies on a Windows service
+		 * which calls special ACPI methods on this node to report
+		 * the laptop/tent/tablet mode to the EC. The bmc150 iio driver
+		 * does not support this, so skip the hotkey on these models.
+		 */
+		if (has_tablet_mode && !acpi_dev_present("BOSC0200", "1", -1))
 			tp_features.hotkey_tablet = TP_HOTKEY_TABLET_USES_GMMS;
 		type = "GMMS";
 	} else if (acpi_evalf(hkey_handle, &res, "MHKG", "qd")) {
-- 
2.28.0

