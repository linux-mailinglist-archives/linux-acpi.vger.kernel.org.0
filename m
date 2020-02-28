Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3EBF173550
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2020 11:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgB1K1n (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Feb 2020 05:27:43 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37499 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1K1m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Feb 2020 05:27:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id b3so2114546otp.4;
        Fri, 28 Feb 2020 02:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3vhF7j/MsBkVwbUHAaD31ZVQA2bpYO88TuIPdepoZjo=;
        b=ap4cdmgAz/vHJCTo5D2ACzOtKIMAqVLEs4d8K2qxe4H26E1uyv7XNlR2AfaF0O3CwC
         NDksAA/tVlcQjXni/qKbZ7/9XLiE9P6i7vBqcdwDEVYsPjYEDiwPzLQqoPLqwvDF2g7q
         7Wu5OZwqotF+z3aIF1VegokvS1IHWvkXYI4fDGyVXRcNx38DsjjkCauzvp0cm1hIVyvC
         Smki7M1Gmp1pt2y0wvyM7yf2GFlTyIq1oVW1LsmKbbxxY8SLiZXLCXtlnsdAtKUN8z2G
         3SXJrC0ofYcddoiE7jtaUiVq4X+TFYGSGblsHuzNk9Rvh1LyswjZTfX+iR7CfnHwEb6/
         gKzA==
X-Gm-Message-State: APjAAAWOLIerjb8XJ3a7epNsdeHUbD9Tw2CiKWdPJRVMzPHlrEdik9PA
        oINNY4rNx9PPAz5HpKiTJaTPFMaziq5Z8Ne0rAcPP+41
X-Google-Smtp-Source: APXvYqywDcqQfD72MsU2RobLZS0g/jl8FF6lSH6lGshFlixc6ONmP2WsYDmrUKXJx+SLbMgdoXXK4UETUy/FZeVVhpI=
X-Received: by 2002:a9d:7653:: with SMTP id o19mr2615920otl.118.1582885661879;
 Fri, 28 Feb 2020 02:27:41 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Feb 2020 11:27:30 +0100
Message-ID: <CAJZ5v0h6eQ72p8uNnxRkAYJjSZ7yTC5yyZitoZ96KA+05Dq7Dg@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.6-rc4
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
 acpi-5.6-rc4

with top-most commit cabe17d0173ab04bd3f87b8199ae75f43f1ea473

 ACPI: watchdog: Set default timeout in probe

on top of commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9

 Linux 5.6-rc1

to receive ACPI fixes for 5.6-rc4.

These fix a couple of configuration issues in the ACPI watchdog
(WDAT) driver (Mika Westerberg) and make it possible to disable
that driver at boot time in case it still does not work as
expected (Jean Delvare).

Thanks!


---------------

Jean Delvare (1):
      ACPI: watchdog: Allow disabling WDAT at boot

Mika Westerberg (3):
      ACPICA: Introduce ACPI_ACCESS_BYTE_WIDTH() macro
      ACPI: watchdog: Fix gas->access_width usage
      ACPI: watchdog: Set default timeout in probe

---------------

 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 drivers/acpi/acpi_watchdog.c                    | 15 ++++++++++++---
 drivers/watchdog/wdat_wdt.c                     | 25 ++++++++++++++++++++++++-
 include/acpi/actypes.h                          |  3 ++-
 4 files changed, 42 insertions(+), 5 deletions(-)
