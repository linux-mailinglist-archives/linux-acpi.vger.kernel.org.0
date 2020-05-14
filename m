Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563021D2C51
	for <lists+linux-acpi@lfdr.de>; Thu, 14 May 2020 12:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgENKQG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 May 2020 06:16:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42703 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgENKQG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2020 06:16:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id m18so1888431otq.9;
        Thu, 14 May 2020 03:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RCuJSybcf0s1akIYY/bh28cVX3CU4HK4vp6WG+osZaU=;
        b=QHUDiXt5CpZArQNvGfuzwr1GQt6VtrStDbCMsCKAxtMCyEird3AHFQpYxlMPzUJcmv
         sisvvvijy2Auc/0qUFey+j9dz63F3WJIHlOhBHez9EwQRqVUqdZ7krh+wEHPcMcc//9m
         IcJePmB4l0JHXm5XpNlg+5hP23sVW+riAqXmQyrA6hee83Domy7DSTcARWcDEDqV+t2N
         f1JiX4BXwAyy+CPIzFUKILVXeJj4R53hffXhmLyTzutRJRDIkzuuhFXDJ8JbgtNFW+7Q
         CX44XzU26pf4QSo58jOm5A/IjwiA2QwIzJ7Ds01KVvSGwm9ZqOjeJt1XyhM2ObbngJOo
         c/EQ==
X-Gm-Message-State: AOAM531UXQQOLWJAyigamxiLvAdOLdV92BqxP5KQWzeDGj/aVif71G2X
        57GQUS/U3ZKiQUlgtYeSgOAojmkxPcxoHKTynjzaFu/T
X-Google-Smtp-Source: ABdhPJwuRFDmjmnaUvxYOXar162GewT6aw7SHwnuEvLuM4kHkd4JuzohYfSvFHGspEtXUcG0h6mUKijzH4wlTsPFFGE=
X-Received: by 2002:a9d:6ac8:: with SMTP id m8mr2937499otq.262.1589451365408;
 Thu, 14 May 2020 03:16:05 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 May 2020 12:15:54 +0200
Message-ID: <CAJZ5v0jgvBE4=14fwsFUx1q+iOO+xt2Jv4L6ER1N5pTLNk1fDw@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.7-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.7-rc6

with top-most commit 7b301750f7f8f6503e11f1af4a03832525f58c66

 ACPI: EC: PM: Avoid premature returns from acpi_s2idle_wake()

on top of commit 0e698dfa282211e414076f9dc7e83c1c288314fd

 Linux 5.7-rc4

to receive a power management fix for 5.7-rc6.

This prevents the suspend-to-idle internal loop from busy spinning
after a spurious ACPI SCI wakeup in some cases.

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: EC: PM: Avoid premature returns from acpi_s2idle_wake()

---------------

 drivers/acpi/ec.c       | 24 ++++++++++++++++--------
 drivers/acpi/internal.h |  1 -
 drivers/acpi/sleep.c    | 14 ++------------
 3 files changed, 18 insertions(+), 21 deletions(-)
