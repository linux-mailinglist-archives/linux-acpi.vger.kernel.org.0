Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F561472E6
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2020 22:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgAWVCv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Jan 2020 16:02:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36832 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729271AbgAWVCv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Jan 2020 16:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579813370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pLi5SfL84NgXq8WFsW3R7nL9ScHECfM9R+VNo4tDUzg=;
        b=eJkxG8YwEtCHo9879u+18Ah0ZeipVLPZogUGNnVWuyXdankzgleuFefYjW0t5QFt9VeklF
        +jgRkX7vCoA17F2GLk+UMNMsfuJGPNQ700bJgkqtGo/pfTjIddczpBo1gI+FIFf0eGH2Ll
        +hM3fLMvaOFCVIO/v1bAePKmGJEM6vY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-_5pGQQheORiVH_i-ROBxuA-1; Thu, 23 Jan 2020 16:02:48 -0500
X-MC-Unique: _5pGQQheORiVH_i-ROBxuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16724100551D;
        Thu, 23 Jan 2020 21:02:46 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-20.ams2.redhat.com [10.36.116.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D75DC8CCD9;
        Thu, 23 Jan 2020 21:02:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2] x86: Select HARDIRQS_SW_RESEND on x86
Date:   Thu, 23 Jan 2020 22:02:42 +0100
Message-Id: <20200123210242.53367-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Modern x86 laptops are starting to use GPIO pins as interrupts more
and more, e.g. touchpads and touchscreens have almost all moved away
from PS/2 and USB to using I2C with a GPIO pin as interrupt.
Modern x86 laptops also have almost all moved to using s2idle instead
of using the system S3 ACPI power state to suspend.

The Intel and AMD pinctrl drivers do not define irq_retrigger handlers
for the irqchips they register, this is causing edge triggered interrupts
which happen while suspended using s2idle to get lost.

One specific example of this is the lid switch on some devices, lid
switches used to be handled by the embedded-controller, but now the
lid open/closed sensor is sometimes directly connected to a GPIO pin.
On most devices the ACPI code for this looks like this:

Method (_E00, ...) {
	Notify (LID0, 0x80) // Status Change
}

Where _E00 is an ACPI event handler for changes on both edges of the GPIO
connected to the lid sensor, this event handler is then combined with an
_LID method which directly reads the pin. When the device is resumed by
opening the lid, the GPIO interrupt will wake the system, but because the
pinctrl irqchip doesn't have an irq_retrigger handler, the Notify will no=
t
happen. This is not a problem in the case the _LID method directly reads
the GPIO, because the drivers/acpi/button.c code will call _LID on resume
anyways.

But some devices have an event handler for the GPIO connected to the
lid sensor which looks like this:

Method (_E00, ...) {
	if (LID_GPIO =3D=3D One)
		LIDS =3D One
	else
		LIDS =3D Zero
	Notify (LID0, 0x80) // Status Change
}

And the _LID method returns the cached LIDS value, since on open we
do not re-run the edge-interrupt handler when we re-enable IRQS on resume
(because of the missing irq_retrigger handler), _LID now will keep
reporting closed, as LIDS was never changed to reflect the open status,
this causes userspace to re-resume the laptop again shortly after opening
the lid.

The Intel GPIO controllers do not allow implementing irq_retrigger withou=
t
emulating it in software, at which point we are better of just using the
generic HARDIRQS_SW_RESEND mechanism rather then re-implementing software
emulation for this separately in aprox. 14 different pinctrl drivers.

This commit selects HARDIRQS_SW_RESEND solving the problem of
edge-triggered GPIO interrupts not being re-triggered on resume when they
were triggered during suspend (s2idle) and/or when they were the cause of
the wakeup.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
I'm sending this out as a RFC since I'm not %100 sure this is the best
solution and it seems like a somewhat big change to make.

Also maybe we should add a Cc: stable@vger.kernel.org ??? This seems like
somewhat a big change for that but it does solve some real issues...
---
Changes in v2:
-v2 is really a resend because I forgot to add the pinctrl people to the =
Cc
-While at it also fix some typos in the commit message
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1cbfc7b3ae8..8f8128047b49 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -118,6 +118,7 @@ config X86
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_RESERVATION_MODE
 	select GENERIC_IRQ_SHOW
+	select HARDIRQS_SW_RESEND
 	select GENERIC_PENDING_IRQ		if SMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
--=20
2.24.1

