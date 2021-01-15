Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED6E2F84AF
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 19:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbhAOSqM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 13:46:12 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:45234 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbhAOSqM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jan 2021 13:46:12 -0500
Received: by mail-ot1-f51.google.com with SMTP id n42so9460461ota.12;
        Fri, 15 Jan 2021 10:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=z0btH/R6VCJOAjjPWhNQaLL4Wx08xMQtdZEgk6q4iP0=;
        b=E6vgz9H0nB0yV7rQAURwmuFPsm+DpxDuAKzQ6RnSP4vXcYB4Tto61EuV3PSWVtF18D
         sH57/3vui8/3w/6jNni3/VmO+mRE5cozmaqgJhJVR6eZbqi3Nqf3O8NNGaBX6n/+mL0E
         GL+lLf8aympCe7u2W/Yt54HeZt3uWVEc9X/VMVW+uktxdGGNliTo3MRZFf4vG8PSlDUc
         UwN9slSoiBGrUetQBI8RrxQcNDqgcO/NQo2VdSIM1SQ1lD5TBjXy91TJnGdjSUjPRcqX
         ZzyefJvCORnA8khdjm9YL+VUUrL5N9dRDnKsTnVQQG3PyKVBg05jamikFA/8P0LlIvUX
         URXw==
X-Gm-Message-State: AOAM5313nlUEyLvVf6N8A9nMJkvYSDbF4WktyrIvVykLJPQSXfXG/DbA
        7jdtSB821gvlP0NpZss5aejcPowhXG/Fam09I+VP1w+GdXY=
X-Google-Smtp-Source: ABdhPJy1nHBiigX5KjYUCLl4dv86nVoHY1qR6Ml1Ecfq9sCtLMHC3trAHk3iuKYSI3C5r9DV+8crqMmxdK+vYRO7EyA=
X-Received: by 2002:a05:6830:4b5:: with SMTP id l21mr9581186otd.321.1610736331694;
 Fri, 15 Jan 2021 10:45:31 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jan 2021 19:45:20 +0100
Message-ID: <CAJZ5v0ipfG_GBT0nYjZk3LA9LDpWQLoe81-309h0P1X5BvOOdg@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.11-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.11-rc4

with top-most commit 179892adb0436139fd8e6af7b27f54219c1750f8

 Merge branch 'acpi-docs'

on top of commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837

 Linux 5.11-rc3

to receive ACPI fixes for 5.11-rc4.

These address a device ID bounds check error in the device
enumeration code and fix a mistake in the documentation.

Specifics:

 - Harden the ACPI device enumeration code against device ID length
   overflows to address a Linux VM cash on Hyper-V (Dexuan Cui).

 - Fix a mistake in the documentation of error type values for PCIe
   errors (Qiuxu Zhuo).

Thanks!


---------------

Dexuan Cui (1):
      ACPI: scan: Harden acpi_device_add() against device ID overflows

Qiuxu Zhuo (1):
      Documentation: ACPI: EINJ: Fix error type values for PCIe errors

---------------

 Documentation/firmware-guide/acpi/apei/einj.rst |  4 ++--
 drivers/acpi/internal.h                         |  2 +-
 drivers/acpi/scan.c                             | 15 ++++++++++++++-
 3 files changed, 17 insertions(+), 4 deletions(-)
