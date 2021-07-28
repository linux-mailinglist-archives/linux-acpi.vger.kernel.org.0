Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E353D94FC
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jul 2021 20:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhG1SH4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Jul 2021 14:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229565AbhG1SH4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Jul 2021 14:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627495673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0AVdR5f9fdBxwFnH1F67ptdM3miCCcQl9UjY1zbZCJY=;
        b=cigc3jcfkBBjM8g9Wv6PKnKFGR4pwI604YD7jhNlutRl42CVQzwpd/cvlBOuGl6yVDtqJl
        ai2PtdHtVTc1qvYvSuIYkxSwV3z2dAdN8431s6y+plQdcPGr6NKsLXEfWzUJp6KYBK9Z1A
        8oW+IeeYEPCYIHSdZj9GBNygEsmSRRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-W8R7mvATPqmNr8JAB6IcAw-1; Wed, 28 Jul 2021 14:07:52 -0400
X-MC-Unique: W8R7mvATPqmNr8JAB6IcAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DA4F107ACF5;
        Wed, 28 Jul 2021 18:07:51 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78DED19C66;
        Wed, 28 Jul 2021 18:07:49 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [RFC 0/1] platform/x86: Add and use a dual_accel_detect() helper
Date:   Wed, 28 Jul 2021 20:07:47 +0200
Message-Id: <20210728180748.190258-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

I've marked this as a RFC because I'm waiting for feedback from the
bug-reporter to check if this actually fixes his issue. But I fully
expect it will (I already tested this on some of my own hw).

IOW I don't expect this patch to change before I will merge it,
so please review.

Here is more info from the commit msg:

"""
Various 360 degree hinges (yoga) style 2-in-1 devices use 2 accelerometers
to allow the OS to determine the angle between the display and the base of
the device.

On Windows these are read by a special HingeAngleService process which
calls undocumented ACPI methods, to let the firmware know if the 2-in-1 is
in tablet- or laptop-mode. The firmware may use this to disable the kbd and
touchpad to avoid spurious input in tablet-mode as well as to report
SW_TABLET_MODE info to the OS.

Since Linux does not call these undocumented methods, the SW_TABLET_MODE
info reported by various pdx86 drivers is incorrect on these devices.

Before this commit the intel-hid and thinkpad_acpi code already had 2
hardcoded checks for ACPI hardware-ids of dual-accel sensors to avoid
reporting broken info.

And now we also have a bug-report about the same problem in the intel-vbtn
code. Since there are at least 3 different ACPI hardware-ids in play, add
a new dual_accel_detect() helper which checks for all 3, rather then
adding different hardware-ids to the drivers as bug-reports trickle in.
"""

Regards,

Hans


Hans de Goede (1):
  platform/x86: Add and use a dual_accel_detect() helper

 drivers/platform/x86/Kconfig             |  3 +
 drivers/platform/x86/dual_accel_detect.h | 75 ++++++++++++++++++++++++
 drivers/platform/x86/intel-hid.c         | 21 ++-----
 drivers/platform/x86/intel-vbtn.c        | 18 +++++-
 drivers/platform/x86/thinkpad_acpi.c     |  3 +-
 5 files changed, 101 insertions(+), 19 deletions(-)
 create mode 100644 drivers/platform/x86/dual_accel_detect.h

-- 
2.31.1

