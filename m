Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DA15E6AE3
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Sep 2022 20:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiIVS2J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Sep 2022 14:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiIVS1r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Sep 2022 14:27:47 -0400
Received: from vorpal.se (vorpal.se [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA7310B5B6;
        Thu, 22 Sep 2022 11:25:58 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 36A73147E0;
        Thu, 22 Sep 2022 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1663871075; bh=YPp9XLQrHEmQ1Fh3VV7+MtWVpj8ChtEPDyhsr15+7K4=;
        h=From:To:Cc:Subject:Date:From;
        b=i9ty52qyXZK9r+Kg04qD61SuQqpDF87mD+W3Kf1j37yc+IE1ebukP6yHnE7qK4m77
         VGkL1+V0WUDFO01qAzbVL6UZcl/4N1g/zbD1HPF+oIJd5iI+4IIkfqdIc+tOWRim8H
         6Ki1BDdtV62Ze/7JW1KzyKv/CgIpUk3Es5gxy5/2AJjfWcLE6vt23H5cddmmLZoy4l
         UPDEMyVUf1d38LShPnGiJrYerOZGjcrj79T2cEzaKixlPXD9+H1C9Uzm1PmX9zFI+J
         px3DH+2GHYNUFBKO99tQLO0uA6HeQy5C7UoGcAhVseRRVxR/0kDl0H+ocHUMVmuQbG
         r2OL6OZOsyfng==
From:   Arvid Norlander <lkml@vorpal.se>
To:     platform-driver-x86@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        Arvid Norlander <lkml@vorpal.se>
Subject: [PATCH RFC v2 0/2] Quickstart buttons driver and Toshiba Z830
Date:   Thu, 22 Sep 2022 20:24:22 +0200
Message-Id: <20220922182424.934340-1-lkml@vorpal.se>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

This is version 2 of this patch series, incorporating the various feedback
on the first version. However, there are some remaining issues that makes
me keep this marked RFC:
1. I tried to get rid of the memory allocation in quickstart_acpi_ghid (as
   suggested by Barnabás Pőcze), but I could not get that working. I'm not
   sure why I did wrong, but I kept getting ACPI errors indicating a buffer
   overflow. I would appreciate knowing how to allocate the buffer on stack
   properly in this case. The memory leak is at least fixed on the error
   path though.
2. The open question mentioned in the original cover letter remains
   undiscussed. I would still like some feedback on those points as well.

The original cover letter follows:

In the following patch series I implement support for three buttons on
the Toshiba Satellite/Portege Z830 (same laptop, different markets).

These buttons work via a PNP0C32 ACPI device. Hans de Goede pointed out
an old and flawed attempt to implement this as a staging driver.

With that staging driver as a starting point I have now implemented proper
support. I believe I have fixed the flaws with the original staging driver.
As it required almost a complete rewrite I have decided to present it as a
new driver instead of starting with a revert commit to restore the old
driver and then apply fixes on top.

The specification for PNP0C32 devices exists as a Microsoft specification.
It was previously available on their web site, but seems to have been taken
down during the last month. I had a local copy and I have uploaded it to
archive.org. It is available here for anyone interested (including a
conversion of the docx to PDF):

https://archive.org/details/microsoft-acpi-dirapplaunch

The old emails about support for these buttons can be found at:
https://marc.info/?l=linux-acpi&m=120550727131007
https://lkml.org/lkml/2010/5/28/327

Table of contents:
1. Summary of standard
2. Issues
2.1. Issue 1: Wake support
2.2. Issue 2: Button identification
2.3. Issue 3: GHID: 64-bit values?
2.4. Issue 4: MAINTAINERS?
3. User space API
3.1. Input device
3.2. Sysfs file: button_id (Read only)
3.3. Sysfs file: wakeup_cause (Read write)
4. HCI_HOTKEY_EVENT register (toshiba_acpi)


1. Summary of standard
======================

Here is a brief high level summary of the standard for PNP0C32. See
https://archive.org/details/microsoft-acpi-dirapplaunch for the full
standard.

PNP0C32 devices are "Direct Application Launch" buttons. The idea is that
they should work while the laptop is in various sleep modes (or even off).
The Z830 does not support waking from any sleep mode using these buttons,
it only supports them while it is awake.

Each PNP0C32 device represents a single button. Their meaning is completely
vendor defined. On Windows you can either:
* Make them launch an application when pressed (defined in the registry)
* Or an application can subscribe to specific Window messages to get
  notified when they are pressed (this is how they are used by the Toshiba
  software).

2. Issues
=========
Unfortunately there are a few issues where I would like some input.

On top of that I'm sure there are lots of issues as I'm fairly new to
kernel programming!

2.1. Issue 1: Wake support
--------------------------
This is untested as the Toshiba Z830 that I have simply does not support
this part in the firmware. I left the old behaviour in and only adapted it
slightly.

The driver adds a sysfs file "wakeup_cause" to each PNP0C32 device
(inspired by old approach) that would read "true" after causing the wakeup.
It would be up to user space query this and reset the value to false.
This is basically what the old staging driver did, only moved from an
(un-needed) platform driver to each ACPI driver.

As I cannot test it (the Z830 does not support the wakeup part of the spec)
I'm more inclined to just drop this feature, especially if the current
approach is suboptimal. It would then be up to someone else to implement
this in the future.

2.2. Issue 2: Button identification
-----------------------------------
There is NO generic way to know what the buttons are "supposed" to do.
Each button has a vendor defined ID (an 8-, 16- or 32-bit unsigned integer).
This ID can be read with the GHID ACPI method.

As such I map all these to KEY_UNKNOWN. Then suitable hwdb entries can be
created for udev that remap these to some sort of meaningful values.

Here is an example hwdb file I created for my laptop:
$ cat /etc/udev/hwdb.d/quickstart.hwdb 
evdev:name:Quickstart Button 1:dmi:bvn*:bvr*:bd*:svnTOSHIBA:pn*Z830:*
 KEYBOARD_KEY_01=prog1

evdev:name:Quickstart Button 2:dmi:bvn*:bvr*:bd*:svnTOSHIBA:pn*Z830:*
 KEYBOARD_KEY_01=prog2

evdev:name:Quickstart Button 3:dmi:bvn*:bvr*:bd*:svnTOSHIBA:pn*Z830:*
 KEYBOARD_KEY_01=touchpad_toggle

As can be seen I always use the scancode 1 here. Would it be better to use
the ID from GHID instead? This can be an arbitrary 32-bit value.

Note also that prog1 and prog2 are poor approximations of the real buttons.
In reality the buttons are "Eco mode" and "Open Windows Mobility center on
screen about switching to projection mode". However Linux seem to lack
suitable key definitions for these.

2.3. Issue 3: GHID: 64-bit values?
----------------------------------
The old staging driver had support for GHID returning a 64-bit value. It is
not clear to me why, as it is not mentioned in the specification. I could
not find anything when reading the old emails either. As such, I'm unsure
if I should drop it. The variable this gets stored to is just 32-bit
anyway.

If we decide to use GHID for scancode (see "Issue 2"), 64-bit values
might be a problem, as the scan code field is only 32 bits.

2.4. Issue 4: MAINTAINERS?
--------------------------
I got this from checkpatch.pl:
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

I'm not sure? Advice would be welcome.


3. User space API
=================
Currently the user space API is as a sparse keymap input device, plus two
unique sysfs files. Discussion on this is welcome!

3.1. Input device
-----------------
The device produces KEY_UNKNOWN events when the button is pressed, with
the scan code 1. We could change the scan code to the button ID reported
by ACPI via GHID. See also "Issue 2" and "Issue 3" above.

3.2. Sysfs file: button_id (Read only)
--------------------------
This file can be read to get the button ID as reported by GHID. It is
returned in human readable ASCII with a trailing newline.

3.3. Sysfs file: wakeup_cause (Read write)
-----------------------------
Will return "true\n" when read after the button was the wakeup cause.
This is latched until user space writes "false" to the file.

See also "Issue 1" above. If this is not a suitable interface I'm inclined
to just drop the wakeup handling entirely.


4. HCI_HOTKEY_EVENT register (toshiba_acpi)
============================
To enable quickstart hotkeys, the HCI_HOTKEY_EVENT (0x1e) register needs
to be set correctly by toshiba_acpi. toshiba_acpi currently sets this to
HCI_HOTKEY_ENABLE (0x9) on the Z830. This is not suitable.

* Windows drivers reads the register then sets it to 0x5. Presumably there
  is some logic going on there.
* HCI_GET on HCI_HOTKEY_EVENT returns 0xf before first call to set it when
  booting Linux on this laptop.
* From my testing any value between 1 and 7 (inclusive) gives the correct
  behaviour for the quickstart buttons. However, for normal hotkeys to work
  in toshiba_acpi, only values with the least significant bit set work.

Toshiba_acpi already detects some laptops using SCI_KBD_FUNCTION_KEYS. That
call is not supported on this laptop (return status TOS_NOT_SUPPORTED).

It is not clear to me how to detect when to use the 0x5 value. In the
attached patch I use a quirk table to enable this. There may be a better
way to do it.

Note! This series is based off the review-hans branch.

Best regards,
Arvid Norlander

Arvid Norlander (2):
  platform/x86: quickstart: Add ACPI quickstart button (PNP0C32) driver
  platform/x86: toshiba_acpi: Add quirk for buttons on Z830

 drivers/platform/x86/Kconfig        |  13 ++
 drivers/platform/x86/Makefile       |   3 +
 drivers/platform/x86/quickstart.c   | 320 ++++++++++++++++++++++++++++
 drivers/platform/x86/toshiba_acpi.c |  36 +++-
 4 files changed, 369 insertions(+), 3 deletions(-)
 create mode 100644 drivers/platform/x86/quickstart.c

-- 
2.37.3

