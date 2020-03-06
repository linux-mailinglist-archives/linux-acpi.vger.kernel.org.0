Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDED17BA09
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2020 11:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgCFKSw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Mar 2020 05:18:52 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:36737 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgCFKSw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2020 05:18:52 -0500
Received: by mail-oi1-f174.google.com with SMTP id t24so2046284oij.3;
        Fri, 06 Mar 2020 02:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pBGDyn9+QX+LdnDHx3BkVjv8dhcNCQI8pss/MoHaa/8=;
        b=RxpnsL3eLOsU8pROKuILry3sfMN7ySOaImnNzFH3ofmhJ8C7/cDr1rF5jCIGAH4oOs
         ygE1qOKw8qftYRz3GAqgC5MDeYzmw7ZVI1Xop3C56abiQr5X/8jrPplUEdu/B59hY8jg
         AAPcj6TQkSfDJC6IYW7UiJUUL2dn/KqnVg8bP95cLc4lShqYruwwWHh5B9fV7RycVdYz
         ixO3G9CN0g7r3KjHmwnNooOlV1IIqZMRON4lsomjuenvXvvoy77DMll/l+sy6ICnPo4O
         4ucOLvaIYvw5PaoZA8Zf2fcobelq05jdGPfftlc1Qv4rWhWakLbOkddw0lUmBpHUV22x
         Aztg==
X-Gm-Message-State: ANhLgQ0rEMyeSysOp4EtTRJ5QQ7v9osWht/1AUPk2s0yh48IF6NxRAGh
        YZB5iLI4jvJAd/VdkUlpvvjYVoy7iJpcpDeozP66+404
X-Google-Smtp-Source: ADFU+vu8kbz8bz/u5Ksox53bjHQ3vaFiM1M89FiCv76TOI1OnsZrNghbKnlig5x6pZuN6ZUKY7NxThFJYncOW0BYOEo=
X-Received: by 2002:aca:ebcf:: with SMTP id j198mr1933251oih.115.1583489931843;
 Fri, 06 Mar 2020 02:18:51 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Mar 2020 11:18:40 +0100
Message-ID: <CAJZ5v0g+iTke+8DL28YzCBeDbe=WNQnUhWuO8QjLhAwGy3U0=A@mail.gmail.com>
Subject: [GIT PULL] ACPI documentation fix for v5.6-rc5
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
 acpi-5.6-rc5

with top-most commit 86dfa5bec24952f99f2cfa778975d5a914c3a1d2

 Merge branch 'acpi-doc'

on top of commit 98d54f81e36ba3bf92172791eba5ca5bd813989b

 Linux 5.6-rc4

to receive an ACPI documentation fix for 5.6-rc5.

This fixes Sphinx format warinings in an ACPI fan document added
recently (Randy Dunlap).

Thanks!


---------------

Randy Dunlap (1):
      Documentation/admin-guide/acpi: fix fan_performance_states.rst warnings

---------------

 Documentation/admin-guide/acpi/fan_performance_states.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
