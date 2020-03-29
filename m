Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB691970C7
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Mar 2020 00:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgC2We1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 29 Mar 2020 18:34:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23119 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728093AbgC2We1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 29 Mar 2020 18:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585521266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2OFzBfakby1fIs+QET3KgqnU3GSddaRvYESK/j3cXaw=;
        b=bRHS6zSaE4No0NQedmfPO6GC4ijBQZzm71R7qnDmpjuxy796j/YGKUGzP8twI2Kh9qNX3O
        xk3koa4XY/kfDE+vGmQmg6p+P1qIc8lR67kRPPBkn8tQTxGPAXjYJQvGndBPjCSi+mbaxg
        9cPcifxgXBCSWE9hsGJ2Y4C+6EWNzrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-aERaAk6-NP24lDzXvhZeXA-1; Sun, 29 Mar 2020 18:34:24 -0400
X-MC-Unique: aERaAk6-NP24lDzXvhZeXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E489800D4E;
        Sun, 29 Mar 2020 22:34:23 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-12.ams2.redhat.com [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89D295DA66;
        Sun, 29 Mar 2020 22:34:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.6 regression fix 0/2] ACPI: PM: s2idle: Fix some systems no longer waking up from suspend
Date:   Mon, 30 Mar 2020 00:34:17 +0200
Message-Id: <20200329223419.122796-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael, Andy and Darren,

I've been debugging an issue I noticed on various Cherry Trail devices
this weekend. The issue is that when trying to wakeup the laptop / 2-in-1
with the USB keyboard, then it not only not wakes up, after this wakeup
attempt it will also no longer wakeup through other means such as the
power-button, IOW the system hangs which is not so nice.

This is also happening in 5.5 since 5.5.5 .

Here is the explanation of the problem from the commit message of the
first patch:

###

Since commit fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from
waking up the system") the SCI triggering without there being a wakeup
cause recognized by the ACPI sleep code will no longer wakeup the system.

This works as intended, but this is a problem for devices where the SCI
is shared with another device which is also a wakeup source.

In the past these from the pov of the ACPI sleep code spurious SCIs would
still cause a wakeup so the wakeup from the device sharing the interrupt
would actually wakeup the system. This now no longer works.

This is a problem on e.g. Bay Trail-T and Cherry Trail devices where
some peripherals (typically the XHCI controller) can signal a
Power Management Event (PME) to the Power Management Controller (PMC)
to wakeup the system, this uses the same interrupt as the SCI.
These wakeups are handled through a special INT0002 ACPI device which
checks for events in the GPE0a_STS for this and takes care of acking
the PME so that the shared interrupt stops triggering.

The change to the ACPI sleep code to ignore the spurious SCI, causes
the system to no longer wakeup on these PME events. To make things
worse this means that the INT0002 device driver interrupt handler will
no longer run, causing the PME to not get cleared and resulting in the
system hanging. Trying to wakeup the system after such a PME through e.g.
the power button no longer works.

###

The first patch in this series adds an acpi_s2idle_register_wake_callback=
()
function the ACPI sleep code which registers a callback to be called from
acpi_s2idle_wake() and when the callback returns true, return true from
acpi_s2idle_wake().

The second patch in this series makes the INT0002 driver use this mechani=
sm
to check the GPE0a_STS register from acpi_s2idle_wake() and to tell the
system to wakeup if a PME is signaled in the register.

This is the cleanest solution I could come up with. I hope it is to your
liking.

Since the INT0002 driver change depends on the changes from the first
patch I suggest that we merge both patches to Rafael's tree.
Andy or Darren, may we have your Acked-by for that?

Regards,

Hans

