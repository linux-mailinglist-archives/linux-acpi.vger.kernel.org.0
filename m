Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956EC5B50EE
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Sep 2022 21:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIKTuR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 11 Sep 2022 15:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIKTuP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Sep 2022 15:50:15 -0400
Received: from vorpal.se (unknown [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E021E1F;
        Sun, 11 Sep 2022 12:50:00 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id E6D25147DF;
        Sun, 11 Sep 2022 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1662925784; bh=dMCK44BNynJDu8c8gyT1BDnfM3qjsKG3OUE/8o/opg8=;
        h=From:To:Cc:Subject:Date:From;
        b=fEQCt02bt2Z4yIvChexqLTVWeNz1sjDyVD9quat9Roz1chAHAAm2BzzbSDiZYu40B
         qrRHsPQfFiA09T6ZMq7HZq4e8GccW6oJoer5Ncd6NfNDecQGqMywTHB9zVQ420EOUi
         FwAPl31Slkv3H0+2+re6ufBtGTFtT14EDsKFqom+gRB859Q3kQQVKjud5SpPRdQi1d
         MK4r4P0ekEW8+f2koS5L6KqGErt5LXf9q2DSXckjI0THBI4uLKWKvBbudjVIY3EJmY
         qn6T8b368PCNXdYJOozz/ULWwFXOSuYWmhFMwFWEnTwRDK4UpHL6hzWSxpJmjfYvth
         GIubHMbicM9hA==
From:   Arvid Norlander <lkml@vorpal.se>
To:     platform-driver-x86@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>,
        Arvid Norlander <lkml@vorpal.se>
Subject: [PATCH RFC 0/2] Quickstart buttons driver and Toshiba Z830
Date:   Sun, 11 Sep 2022 21:49:32 +0200
Message-Id: <20220911194934.558019-1-lkml@vorpal.se>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NO_DNS_FOR_FROM,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

In the following patch series I implement support for three buttons on
the Toshiba Satellite/Portege Z830 (same laptop, different markets).

These buttons work via a PNP0C32 ACPI device. Hans de Goede pointed out
an old and flawed attempt to implement this as a staging driver.

With that staging driver as a starting point I have now implemented proper
support. I believe I have fixed the flaws with the original staging driver.
As it required almost a complete rewrite I have decided to present it as a
new driver instead of starting with a revert commit to restore the old
driver and then apply fixes on top.

The specification for PNP0C32 devices exist as a Microsoft specification.
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
2.5. Issue 5: Where does the driver go?
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
------------
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
------------
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
------------
The old staging driver had support for GHID returning a 64-bit value. It is
not clear to me why, as it is not mentioned in the specification. I could
not find anything when reading the old emails either. As such, I'm unsure
if I should drop it. The variable this gets stored to is just 32-bit
anyway.

If we decide to use GHID for scancode (see "Issue 2"), 64-bit values
might be a problem, as the scan code field is only 32 bits.

2.4. Issue 4: MAINTAINERS?
------------
I got this from checkpatch.pl:
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

I'm not sure? Advice would be welcome.

2.5. Issue 5: Where does the driver go?
------------
For now, I have left this in staging as with the original driver. I'm not
sure if this is the right approach. Apart from the question of wakeup
handling, I believe the driver to be feature-complete. Advise is welcome. 


3. User space API
=================
Currently the user space API is as a sparse keymap input device, plus two
unique sysfs files. Discussion on this is welcome!

3.1. Input device
----------------
The device produces KEY_UNKNOWN events when the button is pressed, with
the scan code 1. We could change the scan code to the button ID reported
by ACPI via GHID. See also "Issue 2" and "Issue 3" above.

3.2. Sysfs file: button_id (Read only)
-------------------------
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

Best regards,
Arvid Norlander

Note! This series is based off the review-hans branch.

Arvid Norlander (2):
  staging: quickstart: Add ACPI quickstart button (PNP0C32) driver
  platform/x86: toshiba_acpi: Add quirk for buttons on Z830

 drivers/platform/x86/toshiba_acpi.c     |  31 +-
 drivers/staging/Kconfig                 |   2 +
 drivers/staging/Makefile                |   1 +
 drivers/staging/quickstart/Kconfig      |  12 +
 drivers/staging/quickstart/Makefile     |   1 +
 drivers/staging/quickstart/quickstart.c | 376 ++++++++++++++++++++++++
 6 files changed, 422 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/quickstart/Kconfig
 create mode 100644 drivers/staging/quickstart/Makefile
 create mode 100644 drivers/staging/quickstart/quickstart.c


base-commit: b8bad0fbf4366928266eb9fba7430a011edc321e
prerequisite-patch-id: 5b404f0b72a3a4a5d38250578956213c8c7733bd
prerequisite-patch-id: be8533cbf34f7aa97f9d59a26a5edb6691096403
-- 
2.37.3

