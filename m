Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7DE3255B9
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Feb 2021 19:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhBYSlV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 13:41:21 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:45472 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhBYSkQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Feb 2021 13:40:16 -0500
Received: by mail-ot1-f46.google.com with SMTP id d9so6623909ote.12;
        Thu, 25 Feb 2021 10:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ITHXQVoZK05s1kAx0r5o3a4vBtj2XmRuIaKADABFDT0=;
        b=XmC6x7o7SO4cz98g1oUnH6OTXQckZWX3Grn8UeUbjIx9RQMoVZrQ1aWk/+4P/Uy3dq
         K4cG6AavJG/5StcpEXvTqacv4Pd7k9Rita65bFsEbAFh20aFOYYkHLdNrdf72onuYau9
         +Lb6T1RUswlKxAORRxnNPkT+MbwhZf3ScCioyJl057BJjDyu1yWMUIO7rYaD8kBgQVRP
         3/kqjr5eXZIwKViqb6Mtx2owoaZLM5nIKkkYs8i4lSi/IY7GGyUGV3CmBgkvvDzoJKP7
         W990Pf/04jmutf2YsfXzyRcEM4YX4RJAqgEMSA4+EEtxrjBpYdJnnXOV+rSikwkuq6oO
         z7mA==
X-Gm-Message-State: AOAM5313lR/pdw4sosVx7n7UcemRWbKoLp5tKgKxxDqSs3rks1gmGYxv
        FIWyqpvh6cnGoQqVh/fveDFGmR+5GuXJawMBah+pZYK2epQ=
X-Google-Smtp-Source: ABdhPJxlvDvD+br19q/Qe1TOQKte83WsYhK/+QgTTYrKHzf1hdz9FvNZ1BCMU93fSa2NU2gbXdo/CudbsqQz/S5x+S0=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr3369005otr.260.1614278370828;
 Thu, 25 Feb 2021 10:39:30 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Feb 2021 19:39:20 +0100
Message-ID: <CAJZ5v0gQ-T0_75Wx37=W4g7AKNR5C_wOKEu9VB2u-x2uTKxJGA@mail.gmail.com>
Subject: [GIT PULL] Additional ACPI updates for v5.12-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.12-rc1-3

with top-most commit b11ffaeacd1984b1fca41374c769fb0ff0aa0a42

 Merge branch 'acpi-tables'

on top of commit 628af43984feeecfe086ae885ab407bd0e7c329e

 Merge tag 'acpi-5.12-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for 5.12-rc1.

These make additional changes to the platform profile interface
merged recently and add support for the FPDT ACPI table.

Specifics:

 - Rearrange Kconfig handling of ACPI_PLATFORM_PROFILE, add
   "balanced-performance" to the list of supported platform profiles
   and fix up some file references in a comment (Maximilian Luz).

 - Add support for parsing the ACPI Firmware Performance Data Table
   (FPDT) and exposing the data from there via sysfs (Zhang Rui).

Thanks!


---------------

Maximilian Luz (3):
      ACPI: platform: Hide ACPI_PLATFORM_PROFILE option
      ACPI: platform: Fix file references in comment
      ACPI: platform: Add balanced-performance platform profile

Zhang Rui (1):
      ACPI: tables: introduce support for FPDT table

---------------

 Documentation/ABI/testing/sysfs-firmware-acpi    |  43 ++++
 Documentation/ABI/testing/sysfs-platform_profile |  18 +-
 drivers/acpi/Kconfig                             |  24 +--
 drivers/acpi/Makefile                            |   1 +
 drivers/acpi/acpi_fpdt.c                         | 264 +++++++++++++++++++++++
 drivers/acpi/platform_profile.c                  |   1 +
 drivers/platform/x86/Kconfig                     |   4 +-
 include/linux/platform_profile.h                 |   6 +-
 8 files changed, 334 insertions(+), 27 deletions(-)
