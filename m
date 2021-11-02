Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D87B44389E
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 23:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhKBWmp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 18:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229844AbhKBWmp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Nov 2021 18:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635892809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=370zfpGuUR/QYlFDjZLZ/oiv1jiwAesX/9g3hqhjOWQ=;
        b=bp3AY5+ni7F6SwN8dMK1A8N+n+Jbt/UbvZm8AglVrMJbQ3wgfVqpyBkohsONXtARNgBn1E
        s9XWbl4NZkXaE/sMDCdumghiNTzCVroSqIL51NAd9Uw+SgY0wQDkiD24gz0XEAiXhHNg/g
        fe2xEAQZNi1myGd/esiNCPZoLsSZeV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-ljJlO3FTMM6OqP6-4iJRIQ-1; Tue, 02 Nov 2021 18:40:05 -0400
X-MC-Unique: ljJlO3FTMM6OqP6-4iJRIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C035BBEE3;
        Tue,  2 Nov 2021 22:40:03 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B04960C05;
        Tue,  2 Nov 2021 22:40:00 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC v2 0/2] ACPI/power-suppy add fuel-gauge support on cht-wc PMIC without USB-PD support devs
Date:   Tue,  2 Nov 2021 23:39:57 +0100
Message-Id: <20211102223959.3873-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Here is a new RFC to add battery monitoring support on the Xiaomi Mi Pad 2
this implements option 2 of the different options which I gave in v1:
https://lore.kernel.org/platform-driver-x86/20211031162428.22368-1-hdegoede@redhat.com/

To solve the challenges of getting this to work on this device, as
you can see compared to option 1, the first patch has gone from
adding 3 separate quirks to adding only one; and the 2 gpiolib-acpi
and 2 bq27xxx_battery driver patches are now no longer necessary.

These are now all 4 replaced by a new special xiaomi-mipad2 module
under drivers/platform/x86 which uses a DMI modalias to autoload
and thus will only be auto-loaded on the actual Mi Pad 2.

I like this option much better then the previous option, but this
still a RFC for now, since I would like to also see what is necessary
to get everything PMIC / micro-USB connector related to work on the
Yoga Book YB1-X91L which is on its way to me.

Regards,

Hans


p.s.

While working on this I realized that there also is a 4th option,
which is basically option 1 from the v1 RFC minus the 2 gpiolib-acpi
patches.

With the 2nd option (as implemented by this RFC) we leave the
_AEI handler in place and run the fuel-gauge without interrupt,
we can do the same when marking the fuel-gauge as always present
by treating IRQs on ACPI devices the same way as in the
max17042_battery code, which has already solved the IRQ problem
without disabling the _AEI handler:

		/*
		 * On ACPI systems the IRQ may be handled by ACPI-event code,
		 * so we need to share (if the ACPI code is willing to share).
		 */
		if (acpi_id)
			flags |= IRQF_SHARED | IRQF_PROBE_SHARED;

This is a pretty decent option too, it requires:

1. 2 more always_present quirks in the ACPI scan code which is part of
the main kernel image.

2. Patches to the bq27xxx_battery code to support ACPI enumeration.




Hans de Goede (2):
  ACPI / x86: Add PWM2 on the Xiaomi Mi Pad 2 to the always_present list
  platform/x86: xiaomi-mipad2: New driver for Xiaomi Mi Pad 2 tablets

 drivers/acpi/x86/utils.c             |   5 ++
 drivers/platform/x86/Kconfig         |  13 +++
 drivers/platform/x86/Makefile        |   1 +
 drivers/platform/x86/xiaomi-mipad2.c | 126 +++++++++++++++++++++++++++
 4 files changed, 145 insertions(+)
 create mode 100644 drivers/platform/x86/xiaomi-mipad2.c

-- 
2.31.1

