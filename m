Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E1719F89D
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Apr 2020 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgDFPOI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 6 Apr 2020 11:14:08 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35049 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbgDFPOH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Apr 2020 11:14:07 -0400
Received: by mail-oi1-f194.google.com with SMTP id t25so13359991oij.2;
        Mon, 06 Apr 2020 08:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=QnGJpUcnr/LV52LUQSsfc6dIRSvEfNk579Oi3E4BtZw=;
        b=Xoi49p/6iRzhLdT6hx1V/WWCjj5dkxuc6Hd092rD6T7urHGKeqFUnQm1WL7uNaMVNE
         BLOOHSBue8XCUJjZ28ItIjsFcM+YUV/a3/8J0ZpeYJBUVaQvEeP7NH9ouooIfkcIPhOy
         pjp861gY+R1re/Mc8H+0eGoanzz45DTMbFB046+0fumSi32tP6JGneduoPHoKPYnWJfd
         zepok9cpI0PtjekWHGUXEQ5VntXurM5qjVOt4BBc3DeGFbVPANnrPWJZPTUZ+WR4KH5P
         Lh1dt/bw2zMa6v1vZ+fw3JatrJqd2m2+ChQlV8nPkkU/0SreUDdrHYdZMOuVeVSdI8pA
         BT3A==
X-Gm-Message-State: AGi0PuZcm2+0GdyDdAUo88LufYk9kSB//fgbgopwihtxsjan2iM3Gh9x
        F6crbfaOQjbOqz6xLrctMZwzyRwgUveKzyX9+5PPKtV/
X-Google-Smtp-Source: APiQypIvLhm4CgDSPv6mQsDS2leEsn8gXORXQlDxnq7+kZLH4nFyJJVQTQSogX/C6SWU6St1GIg5J+C3YfETlGEQQo0=
X-Received: by 2002:a05:6808:8f:: with SMTP id s15mr13524853oic.110.1586186046794;
 Mon, 06 Apr 2020 08:14:06 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Apr 2020 17:13:55 +0200
Message-ID: <CAJZ5v0j8rEiD0uv+LQoAQyfdXORF+joz-vLVH4ryH9_xvZebOQ@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.7-rc1-2

with top-most commit 33ae7f715e30a674599c7f57dce0512b6051edbf

 Merge branches 'acpi-cppc', 'acpi-video' and 'acpi-drivers'

on top of commit 2ce94bc4e056d3e48291aac87a95ebd2a86348ba

 Merge tag 'pnp-5.7-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for 5.7-rc1.

These update the ACPICA code in the kernel to the 20200326 upstream
revision, fix an ACPI-related CPU hotplug deadlock on x86, update
Intel Tiger Lake device IDs in some places, add a new ACPI backlight
blacklist entry, update the "acpi_backlight" kernel command line
switch documentation and clean up a CPPC library routine.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision 20200326
   including:

   * Fix for a typo in a comment field (Bob Moore).
   * acpiExec namespace init file fixes (Bob Moore).
   * Addition of NHLT to the known tables list (Cezary Rojewski).
   * Conversion of PlatformCommChannel ASL keyword to PCC (Erik
     Kaneda).
   * acpiexec cleanup (Erik Kaneda).
   * WSMT-related typo fix (Erik Kaneda).
   * sprintf() utility function fix (John Levon).
   * IVRS IVHD type 11h parsing implementation (Michał Żygowski).
   * IVRS IVHD type 10h reserved field name fix (Michał Żygowski).

 - Fix ACPI-related CPU hotplug deadlock on x86 (Qian Cai).

 - Fix Intel Tiger Lake ACPI device IDs in several places (Gayatri
   Kammela).

 - Add ACPI backlight blacklist entry for Acer Aspire 5783z (Hans
   de Goede).

 - Fix documentation of the "acpi_backlight" kernel command line
   switch (Randy Dunlap).

 - Clean up the acpi_get_psd_map() CPPC library routine (Liguang
   Zhang).

Thanks!


---------------

Bob Moore (3):
      ACPICA: Fix a typo in a comment field
      ACPICA: Fixes for acpiExec namespace init file
      ACPICA: Update version 20200326

Cezary Rojewski (1):
      ACPICA: Add NHLT table signature

Erik Kaneda (3):
      ACPICA: Change PlatformCommChannel ASL keyword to PCC
      ACPICA: acpiexec: remove redeclaration of
acpi_gbl_db_opt_no_region_support
      ACPICA: WSMT: Fix typo, no functional change

Gayatri Kammela (3):
      ACPI: Update Tiger Lake ACPI device IDs
      platform/x86: intel-hid: fix: Update Tiger Lake ACPI device ID
      thermal: int340x_thermal: fix: Update Tiger Lake ACPI device IDs

Hans de Goede (1):
      ACPI: video: Use native backlight on Acer Aspire 5783z

John Levon (1):
      ACPICA: utilities: fix sprintf()

Liguang Zhang (1):
      ACPI: CPPC: clean up acpi_get_psd_map()

Michał Żygowski (2):
      ACPICA: Implement IVRS IVHD type 11h parsing
      ACPICA: Fix IVRS IVHD type 10h reserved field name

Qian Cai (1):
      x86: ACPI: fix CPU hotplug deadlock

Randy Dunlap (1):
      ACPI: video: Docs update for "acpi_backlight" kernel parameter options

---------------

 Documentation/admin-guide/kernel-parameters.txt    |  8 +++--
 arch/x86/kernel/acpi/cstate.c                      |  3 +-
 drivers/acpi/acpica/acnamesp.h                     |  2 ++
 drivers/acpi/acpica/dbinput.c                      | 16 +++++-----
 drivers/acpi/acpica/dbxface.c                      |  1 +
 drivers/acpi/acpica/dswexec.c                      | 33 ++++++++++++++++++++
 drivers/acpi/acpica/dswload.c                      |  2 --
 drivers/acpi/acpica/dswload2.c                     | 35 ++++++++++++++++++++++
 drivers/acpi/acpica/nsnames.c                      |  6 +---
 drivers/acpi/acpica/utdecode.c                     |  2 +-
 drivers/acpi/acpica/utdelete.c                     |  9 +++---
 drivers/acpi/acpica/utprint.c                      |  7 ++++-
 drivers/acpi/cppc_acpi.c                           | 33 +++++---------------
 drivers/acpi/device_pm.c                           |  2 +-
 drivers/acpi/dptf/dptf_power.c                     |  2 +-
 drivers/acpi/dptf/int340x_thermal.c                |  8 ++---
 drivers/acpi/processor_throttling.c                |  7 -----
 drivers/acpi/tables.c                              |  2 +-
 drivers/acpi/video_detect.c                        |  9 ++++++
 drivers/platform/x86/intel-hid.c                   |  2 +-
 .../intel/int340x_thermal/int3400_thermal.c        |  2 +-
 .../intel/int340x_thermal/int3403_thermal.c        |  2 +-
 include/acpi/acpixf.h                              |  2 +-
 include/acpi/actbl2.h                              | 21 +++++++++++--
 include/acpi/actbl3.h                              |  6 ++--
 include/acpi/acuuid.h                              |  2 +-
 include/acpi/processor.h                           |  8 +++++
 27 files changed, 155 insertions(+), 77 deletions(-)
