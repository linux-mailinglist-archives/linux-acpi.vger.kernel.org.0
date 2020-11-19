Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE192B9A9D
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 19:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgKSS2t (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Nov 2020 13:28:49 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33801 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgKSS2s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2020 13:28:48 -0500
Received: by mail-oi1-f194.google.com with SMTP id s18so6255093oih.1;
        Thu, 19 Nov 2020 10:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=679DbEgEKUHSQ/f4lkOzU7rgexZjgi5oxyhY1SdFMHA=;
        b=hlYFASEvNXpCoM/xLcL+blyVIs11eVl7+8+0LWJys99Akdpvemkdo8f3Udy4aImYtV
         dmqGtkB54ICFIivH54Vv04bBIFX/JsKnBAeIcWr6j3j0mcO1HVtkxm9DAPiI/8KCFOJ8
         vj8keddjqgJrTvlqP458Png53JYlz2Sw+IsIAtuu8d3baJjg3mivTAo9AJYaGXQvSwqV
         MZxsz2xDkcwAW97vWHKx+ZznuUzFRUThNlUxai5IzLmeGnTvSqcR8GlZfVDZcbf4qdtm
         Z/TMWvs/TDV1dnsSRUT8Gk+kqoOUUYqjWjm4t++6+DxPpC+jdIqKuG9BCy0qQpuiQs9n
         KAIQ==
X-Gm-Message-State: AOAM5321bKZPRi7TfsZ/atZ9cNDYRJ0YFZ2Ih9ha3IKhtv/lBRJ8JO1m
        3T6CpU0CjtdCA5QldaPZ9nM58rtotLPBfWgewU0=
X-Google-Smtp-Source: ABdhPJw+fh+QivBQNhApdmdRdN/pzxqE7rfkU6EMW5ISKbgEowIynOnGbF746b8HurzPYS7kUTzkqzS+1E/MXmxnr1A=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr3222658oib.69.1605810527882;
 Thu, 19 Nov 2020 10:28:47 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Nov 2020 19:28:37 +0100
Message-ID: <CAJZ5v0hEqP=GgF3VZpn8GVX4ajnzDV4T3ZMMMGUbEe-BqUoHOA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.10-rc5
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
 acpi-5.10-rc5

with top-most commit de15e20f50b126b3a5a753dd259df775e6a0ea5c

 Merge branch 'acpi-fan'

on top of commit 09162bc32c880a791c6c0668ce0745cf7958f576

 Linux 5.10-rc4

to receive ACPI fixes for 5.10-rc5.

These fix recent regression in the APEI code and initialization
issue in the ACPI fan driver.

Specifics:

 - Make the APEI code avoid attempts to obtain logical addresses for
   registers located in the I/O address space to fix initialization
   issues (Aili Yao).

 - Fix sysfs attribute initialization in the ACPI fan driver (Guenter
   Roeck).

Thanks!


---------------

Aili Yao (1):
      ACPI, APEI, Fix error return value in apei_map_generic_address()

Guenter Roeck (1):
      ACPI: fan: Initialize performance state sysfs attribute

---------------

 drivers/acpi/apei/apei-base.c | 4 ++++
 drivers/acpi/fan.c            | 1 +
 2 files changed, 5 insertions(+)
