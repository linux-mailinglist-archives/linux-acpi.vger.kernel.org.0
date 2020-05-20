Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C981DB7EE
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 17:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgETPRO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 11:17:14 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41656 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgETPRO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 May 2020 11:17:14 -0400
Received: by mail-ot1-f65.google.com with SMTP id 63so2731644oto.8;
        Wed, 20 May 2020 08:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=APMAJd2ccAAAHw6hrNKtkZpgfoVo+A8PajU4FrsMAFE=;
        b=Dy3aETvdnArVlbTBUJhPia6cFRb460LXMPSzxR+VUuXyanSUkSkebVSAXb/fg/NSbq
         AjjSrwfFUXlqDpj1pJWXr6iPR45IeSpGaOA9pdM8nf4YLSxmnNGMbJw1XnQyLy0Zm7U2
         cSQh8kHfyArW1IA5W/noqDKC8b450ZA1bAKCrXj87kvzwG5qORDDNVup7UOSsLRWpH3d
         irqEzGItvwKqiffyzigGhORx7ZBzlVkDLB69L/qJ30W7v/9BafKKmqdnNGND+pKUQBWI
         u8vOWJGO56JJre1tcyj4xpN9bHja5gYzSMv8Fpts7MhXgcujHbrQxHW1wuNswqkO5MBu
         A20A==
X-Gm-Message-State: AOAM532NoW53Gw3QxTKwiww4b6mIxNO2uBsmT59FwLDZeZqwxpOphEhC
        ggeyt9i/OIIbLYwXXDb3UODd3waBdOTiFhUkJtnixoFl
X-Google-Smtp-Source: ABdhPJxoPE2D697+U4admlbKECT9cJECJahPHQEDu8JvuPpj6HsQS3maF4rirsAISehOjdejt3hVjcx6nefCzronUug=
X-Received: by 2002:a9d:6c0f:: with SMTP id f15mr1842461otq.118.1589987833168;
 Wed, 20 May 2020 08:17:13 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 May 2020 17:17:02 +0200
Message-ID: <CAJZ5v0jE6tnyd741Y1B_1gzVMtcf112e1EOqjJ1AR+oUd5ee_w@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.7-rc7
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
 pm-5.7-rc7

with top-most commit 607b9df63057a56f6172d560d5366cca6a030c76

 ACPI: EC: PM: Avoid flushing EC work when EC GPE is inactive

on top of commit 7b301750f7f8f6503e11f1af4a03832525f58c66

 ACPI: EC: PM: Avoid premature returns from acpi_s2idle_wake()

to receive a power management fix for 5.7-rc7.

This makes a recently introduced suspend-to-idle wakeup issue
on Dell XPS13 9360 go away.

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: EC: PM: Avoid flushing EC work when EC GPE is inactive

---------------

 drivers/acpi/ec.c    |  6 +++++-
 drivers/acpi/sleep.c | 15 ++++-----------
 2 files changed, 9 insertions(+), 12 deletions(-)
