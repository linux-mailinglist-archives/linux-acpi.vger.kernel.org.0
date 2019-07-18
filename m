Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73866CB7B
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2019 11:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389697AbfGRJFO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Jul 2019 05:05:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33744 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfGRJFN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jul 2019 05:05:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so28190593otl.0;
        Thu, 18 Jul 2019 02:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dbjrQhJgnQ3BGnOKEmGO3kvNqsibJb8XahuXMl4G3Rg=;
        b=F7sxKz805G501SMlxeEDvrQxYFN6Dh4ecoQafIPbosFGZMUepPW+VjZLWsPthkzJzx
         loTNUO8y8HBdOx8S3H+/68qHzzzeedUT2RVcg/kS6nlUt3bcCvlJYH4vsZDsosWEPipc
         iYjtyGyuWKE0dQrYaQb+GM22Ko7djtyjF6Y82iCERHF0Pug4e14YI5A/5fXzLopgdUxU
         AC/FdRMsCovUB3SJNeDMFEnEa96iO2hCT/r/hAM7xfo+YF/xN4Bb/uu16LNqRUmM76N+
         rj69rlH31NsPAlWH3xtrW7Q8YLTdRpdwDTDr29YRzHJ2dQTcv8WcKfnKIu2qSuHS35QH
         xbuA==
X-Gm-Message-State: APjAAAV+h//xwEwf0KwQbnZTkuiDF4Hui00N9lTP9z6DIQJcl6IxvqfP
        AEOZEDcd2qO+SVjwj4JboMvNkHcJv+DqRcLKO/tlFumQ
X-Google-Smtp-Source: APXvYqzQfAtxufns7fVaIPSAQyYUGkGFqi9woLuP+dIBUMiKDS+wBVwUIkMaTJsusKkMvjBsevMjCVMt0t8HaVecABw=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr9307370otn.266.1563440712782;
 Thu, 18 Jul 2019 02:05:12 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Jul 2019 11:05:01 +0200
Message-ID: <CAJZ5v0gMu2TUBVdoL2X5koz7giQYxjkaHv8SXKWToedYURHzuQ@mail.gmail.com>
Subject: [GIT PULL] Additional ACPI updates for v5.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.3-rc1-3

with top-most commit 2c66a5b52e9e328cd52af0d961f99a0e6717a065

 Merge branches 'acpi-misc' and 'acpi-video'

on top of commit a131c2bf165684315f606fdd88cf80be22ba32f3

 Merge tag 'acpi-5.3-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for 5.3-rc1.

These get rid of two clang warnings, add a new quirk mechanism to the
ACPI backlight driver (and apply it to one machine) and update the
table load object initialization in ACPICA (this is a replacement for
a previously reverted ACPICA commit).

Specifics:

 - Make ACPI table loading work more consistently regardless of the
   exact mechanism used for loading a table (Erik Schmauss).

 - Get rid of two clang warnings (Arnd Bergmann).

 - Add new quirk mechanism to the ACPI backlight driver and use it
   to add a quirk for PB Easynote MZ35 (Hans de Goede).

Thanks!


---------------

Arnd Bergmann (2):
      ACPI: blacklist: fix clang warning for unused DMI table
      ACPI: fix false-positive -Wuninitialized warning

Erik Schmauss (1):
      ACPICA: Update table load object initialization

Hans de Goede (1):
      ACPI: video: Add new hw_changes_brightness quirk, set it on PB
Easynote MZ35

---------------

 drivers/acpi/acpi_video.c      | 37 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/exconfig.c | 18 ++++++++----------
 drivers/acpi/acpica/tbxfload.c | 10 +++-------
 drivers/acpi/blacklist.c       |  4 ++++
 include/linux/acpi.h           |  5 ++++-
 5 files changed, 56 insertions(+), 18 deletions(-)
