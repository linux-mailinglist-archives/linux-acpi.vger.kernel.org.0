Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EBE42FAD1
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Oct 2021 20:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242554AbhJOSV2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Oct 2021 14:21:28 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:41820 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbhJOSV2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Oct 2021 14:21:28 -0400
Received: by mail-ot1-f53.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so13974775ote.8;
        Fri, 15 Oct 2021 11:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=X8aFAh665RVTVga5uIb4o7VG/MtjiIB5HxboqHwSZfQ=;
        b=2zUvZK+ZLOsMfb1dpj/WOCDz9Q95J3RIEpbGtN4XF0va9LYV16LokPrewpr2VT0vLP
         o8aP/pKqSjkCVJY2fYzlGIiKyyxFaIfbKz3Z1cFOm3Mpwi2qMLWu5GD0vWdSra661ibV
         otwyaPFSSR+YgFr1eqQ9rPebX1EW3mSY7f6I5cpCxvnNiBfiHk/FOE5KOhYL/NCJlvmI
         6urdgxzptXwNCLRolsm7PUBroDwpPeev913AeUQga8BNNupE8R7lHFFWz7BT5rM7usBt
         c031YvjlA7HZIiMDyWMlucIwx7HXGYzdGcTXGX+REBxqO5CVWBzCcGRDJ0I0kgDnVDDP
         ErWQ==
X-Gm-Message-State: AOAM531ZcMb/tSTzQHghw2bB05L4KbCcgOhpYe9tvvxZ05nKD+vGohfP
        XgUEtka4zaYgxKGEmyNGPyRHePaf61O/2i+rPsv1E/5CCzc=
X-Google-Smtp-Source: ABdhPJx3al7aEsKuw2qf1TGILeueUv73Af5gN8i66wme99co2f4Gx+ECXdXQQK5DxhOtN7btqWBtxtMI96c+S9jKq30=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr8941767oth.198.1634321961344;
 Fri, 15 Oct 2021 11:19:21 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Oct 2021 20:19:10 +0200
Message-ID: <CAJZ5v0jyqT335x5iB1HWnESR5OZbitHQqc369rffhkO4h3wMCQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.15-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.15-rc6

with top-most commit 1ea1dbf1f54c3345072c963b3acf8830e2468c1b

 ACPI: PM: Include alternate AMDI0005 id in special behaviour

on top of commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc

 Linux 5.15-rc5

to receive an ACPI fix for 5.15-rc6.

This adds a missing device ID to a quirk list in the suspend-to-idle
support code.

Thanks!


---------------

Sachi King (1):
      ACPI: PM: Include alternate AMDI0005 id in special behaviour

---------------

 drivers/acpi/x86/s2idle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
