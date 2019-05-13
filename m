Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B92801BDA4
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2019 21:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfEMTR2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 May 2019 15:17:28 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:45122 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfEMTR1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 May 2019 15:17:27 -0400
Received: by mail-qk1-f201.google.com with SMTP id n65so12954326qke.12
        for <linux-acpi@vger.kernel.org>; Mon, 13 May 2019 12:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qd758GC+tv+AefghvcuLnRgxqiTzW/XC7mQzkKY2rj4=;
        b=Ie0xtH/UhJmKkwyMt3DIlOmfAWwFxcEfKEwn11rAWercN5KeYzBkDoSZgcdQpYMIv5
         6d/Ch5aANElCl/1/DnBj7+ViUBYnbKEuLKDpi2lK/JFns0tO1DqfYsEdtSK4cNPB75rV
         +LNDLfSKJUuEQ2DpfLfv9JffBzeMSq3OGAgBm3begLhWVN+0XfbWKpwOa6RCUDIXtNif
         xweR5Eg/3hAtSfX5PHNppVjekv/tsaSBZ5Yrb+9x4SfU4UfiQ/er76Fottg7ARQnGMgi
         RaSWK8r3KaOVVm7Yz8XShgND+oiFCYrpMMeBaxhEJMTluGOONH4qVWnmWk5D6WdINfke
         m30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qd758GC+tv+AefghvcuLnRgxqiTzW/XC7mQzkKY2rj4=;
        b=I0eEqnppDDP1htF62dcrUcAexTmfJlg2Fvn9LNKYcancDxZpbEnzCJ3gl7Co1NVfqp
         mXdQju0cBPOTeIHPUOBuQ/ME89KClbXJIMMmLrzn82Q/qsj1nJ4Gz+8KERkVGlTO59pY
         irtnhyaOGbYLssnJi51k6P0oXriScHG6WHZnKVG2oyNG1fL/i1gxMPPTdNlc+oBLYEVl
         5OP2/7Db19vo+tSOc2BDbGbLMPZz3S2vtD5jMOvJGP67DimRFBBzG1yT6XRNkROHpa5L
         zJ6VuGawoYd8VjmMzQKkrRpvOa9NKTV6p3kQNQOyq2ST0xDwLU5eNgJxaEfrumd5+66k
         mDgg==
X-Gm-Message-State: APjAAAWNOwxWUA6UbLUoEJq66MdMpNNwB7qv6H7IA6DE+8lj9a7QJORd
        jdDNre7E2xttNYgQH6y4p6Qy5M5kxuRN
X-Google-Smtp-Source: APXvYqw8t9O+HM3h+AllssTLnPtYtRgEr4WVIkwCW+cvChMq+eLSByMo/zwgfoWj1xtw64EWZqxqmDBG8MBS
X-Received: by 2002:a37:a705:: with SMTP id q5mr23313599qke.123.1557775046895;
 Mon, 13 May 2019 12:17:26 -0700 (PDT)
Date:   Mon, 13 May 2019 12:17:08 -0700
Message-Id: <20190513191708.87956-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RFC PATCH] ACPI: PM: Enable wake-up device GPEs for suspend-to-idle
From:   Rajat Jain <rajatja@google.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com,
        furquan@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I noticed that recently multiple systems (chromebooks) couldn't wake
from S0ix using LID or Keyboard after updating to a newer kernel, I
bisected and the issue is seen starting the following commit:

commit f941d3e41da7 ("ACPI: EC / PM: Disable non-wakeup GPEs for
suspend-to-idle")

and found that the issue gets fixed if I revert it. I debugged and
found that although PNP0C0D:00 (representing the LID) is wake capable
and should wakeup the system per the code in acpi_wakeup_gpe_init()
and in drivers/acpi/button.c:

localhost /sys # cat /proc/acpi/wakeup
Device  S-state   Status   Sysfs node
LID0      S4    *enabled   platform:PNP0C0D:00
CREC      S5    *disabled  platform:GOOG0004:00
                *disabled  platform:cros-ec-dev.1.auto
                *disabled  platform:cros-ec-accel.0
                *disabled  platform:cros-ec-accel.1
                *disabled  platform:cros-ec-gyro.0
                *disabled  platform:cros-ec-ring.0
                *disabled  platform:cros-usbpd-charger.2.auto
                *disabled  platform:cros-usbpd-logger.3.auto
D015      S3    *enabled   i2c:i2c-ELAN0000:00
PENH      S3    *enabled   platform:PRP0001:00
XHCI      S3    *enabled   pci:0000:00:14.0
GLAN      S4    *disabled
WIFI      S3    *disabled  pci:0000:00:14.3
localhost /sys #

On debugging, I found that its corresponding GPE is not being enabled.
The particular GPE's "gpe_register_info->enable_for_wake" does not have any
bits set when acpi_enable_all_wakeup_gpes() comes around to use it. I
looked at code and could not find any other code path that should set the
bits in "enable_for_wake" bitmask for the wake enabled devices for s2idle
(I do see that it happens for S3 in acpi_sleep_prepare()).

Thus I used the same call to enable the GPEs for wake enabled devices,
and verified that this fixes the regression I was seeing on multiple of
my devices.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203579
Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/acpi/sleep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 403c4ff15349..e52f1238d2d6 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -977,6 +977,8 @@ static int acpi_s2idle_prepare(void)
 	if (acpi_sci_irq_valid())
 		enable_irq_wake(acpi_sci_irq);
 
+	acpi_enable_wakeup_devices(ACPI_STATE_S0);
+
 	/* Change the configuration of GPEs to avoid spurious wakeup. */
 	acpi_enable_all_wakeup_gpes();
 	acpi_os_wait_events_complete();
@@ -1027,6 +1029,8 @@ static void acpi_s2idle_restore(void)
 {
 	acpi_enable_all_runtime_gpes();
 
+	acpi_disable_wakeup_devices(ACPI_STATE_S0);
+
 	if (acpi_sci_irq_valid())
 		disable_irq_wake(acpi_sci_irq);
 
-- 
2.21.0.1020.gf2820cf01a-goog

