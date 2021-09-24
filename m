Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41709417A64
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 20:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345326AbhIXSD4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Sep 2021 14:03:56 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:33484 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343995AbhIXSDw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Sep 2021 14:03:52 -0400
Received: by mail-ot1-f48.google.com with SMTP id s36-20020a05683043a400b0054d4c88353dso3346571otv.0;
        Fri, 24 Sep 2021 11:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MnM6Toow5UpW5vNHpXd/pLFN/yLu+amYO+vAZymKytE=;
        b=vD5OofPpMwUwLtR7TKhrkz+omoTwjGE3mH5sQaojcxnEovkePZmyuXvCZ7nMR3EzO0
         C+gsj3+0VTZcnJmzXbCILNdPUdBU2uv2+VGMvyismK6iWeHbIc58yd2Jv0b7ny/TEYJQ
         I/DP645Vqp/Bq6zwo27LengrAO8UkWQj8UFHcyDfCfs28Vrwajl6tu9HkD2u5X2sMH5e
         JZr1L8ZTQ+yFlP8y8h/YoqlWzM14M5r9imge0AME/4b1wPIy9OS3/i1NsZzgjpWg2LQR
         vKsCyoM0DezH4Lft4mrq9Q8hJEJzerpJxJTgR3G67FY1gZen/E27rCJeXko1r6tUdrXW
         D0Vw==
X-Gm-Message-State: AOAM5301yqgzDi3I0TvBgUr5VraqOm4hiN9YIB7CCJeMiN70G/kQtjWs
        PH/mi22GVOsUnLWYJ4xOdoFNwF5B1XvbDnO7mfZr2tqzTO4=
X-Google-Smtp-Source: ABdhPJyO0bYurMXVk8uIclqu4soXH/r6Q4TOArigoCnPcwmd2NAcJuWvEr27SUmxSiKbbgfHI7Tm/1c/vI0hsIRlYlk=
X-Received: by 2002:a05:6830:2784:: with SMTP id x4mr5332878otu.86.1632506539301;
 Fri, 24 Sep 2021 11:02:19 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Sep 2021 20:02:08 +0200
Message-ID: <CAJZ5v0jVNqcqHET2W1uPiBtGDJ=C6JMxJVCnRB4UyiT1ci=9-w@mail.gmail.com>
Subject: [GIT PULL] Device properties framework fix for v5.15-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.15-rc3

with top-most commit 5aeb05b27f81269a2bf2e15eab9fc0f9a400d3a8

 software node: balance refcount for managed software nodes

on top of commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f

 Linux 5.15-rc1

to receive a device properties framework fix for 5.15-rc3.

This fixes a software node refcount imbalance on device
removal (Laurentiu Tudor).

Thanks!


---------------

Laurentiu Tudor (1):
      software node: balance refcount for managed software nodes

---------------

 drivers/base/swnode.c | 3 +++
 1 file changed, 3 insertions(+)
