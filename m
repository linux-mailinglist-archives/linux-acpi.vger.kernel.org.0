Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351883FF16E
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Sep 2021 18:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346321AbhIBQc1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Sep 2021 12:32:27 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:40638 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346333AbhIBQc0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Sep 2021 12:32:26 -0400
Received: by mail-oo1-f50.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so708439ooh.7;
        Thu, 02 Sep 2021 09:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVfG6I1rLgPXzfK5MWdtxixJnWlk2BTbcuZB+XVnrts=;
        b=K7jhT/FLS0nnDVk03KZ0wGokhwll25Vzxxa0GboFSUvwEcHlNFlgErtIBRrhaXbunV
         bUmzQClUrnsxd3rhr/G8PUVpue6ATNznI2iagdKzUyy4fLy2T6C7hMtiFS6ShQ/BB3/F
         KPRmYoiUSI78hOuWX3XfP0YYTtfBt3cHuZhk3GjvmN4rX7w17omQfWnmpxpOMv/KI+I9
         GI04IO3WuXWMKLedWDMNTtWbQmL1Sze6o5+O0AX6kFMdMhli9CXBljV9dj/HSW4ebo92
         ic4VU3ZQ4c26kqTu0sH42bDOl5J1K+TECGaK/4r6k0zpXdztP9rmRyUGxh/ayiIxciNZ
         mLJQ==
X-Gm-Message-State: AOAM532Cf87Z9OVDXKSSqoK2XuqB93gJQ+XCRhp7MI2EBjeYLlyGoekM
        5qgLsZKn3tA5CAtebsmk2wN5UUM5PcaIjZT0T/A=
X-Google-Smtp-Source: ABdhPJwMvJFIZ8AQs1kfhMrLw7Lo27Oc2Tw/XnzWPWaYPVc5aTbVjO0gHUee0XIh1SWP1pVWvZzx+L9DNwjPEVBge1U=
X-Received: by 2002:a4a:ca83:: with SMTP id x3mr3336445ooq.2.1630600285972;
 Thu, 02 Sep 2021 09:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210902025528.1017391-1-saravanak@google.com>
 <CAGETcx9N34RyrdKDR8dQ7ECyz7ZXBx-Ft16t033NjTiU8p=Y0g@mail.gmail.com>
 <CAJZ5v0gt_1vKQXxSY6HoHRPR9O_e1f7VwcBnSjeMgCdCibrwgQ@mail.gmail.com> <CAGETcx_dvpFKZnz2w43h=ybp-8YF=OdpW0f2mK+jvDPURDFQJQ@mail.gmail.com>
In-Reply-To: <CAGETcx_dvpFKZnz2w43h=ybp-8YF=OdpW0f2mK+jvDPURDFQJQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Sep 2021 18:31:14 +0200
Message-ID: <CAJZ5v0iDU9aCGaF2FfCXmHjQ2qPH7KmF46rmaPAsPaxOT1yPDg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Ulf reported an issue[1] with fw_devlink. This
 series tries to fix that issue.
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 2, 2021 at 6:27 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Sep 2, 2021 at 8:56 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Sep 2, 2021 at 4:57 AM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Oops, forgot to use a proper subject. Sorry.
> >
> > Is this a replacement for the "Fix rtl8366rb issues with fw_devlink=on " series?
>
> No. This is unrelated to that. This is the issue I'm trying to fix:
> https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/

Allright, thanks!

> This is kind of a replacement to, but the patch below might be needed
> in general (needs more thought):
> https://lore.kernel.org/lkml/CAGETcx9U2M5i1CAx605fG3Qwm1xwjH2uy4kY4vrAF7YSRSSg+w@mail.gmail.com/

I see.


> > > On Wed, Sep 1, 2021 at 7:55 PM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > Ulf, mind testing this?
> > > >
> > > > Thanks,
> > > > Saravana
> > > > [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > > >
> > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > >
> > > > Saravana Kannan (2):
> > > >   driver core: Add support for FWNODE_FLAG_NEVER_PROBES
> > > >   of: platform: Mark bus devices nodes with FWNODE_FLAG_NEVER_PROBES
> > > >
> > > >  drivers/base/core.c    |  8 ++++++++
> > > >  drivers/of/platform.c  | 16 ++++++++++++++++
> > > >  include/linux/fwnode.h |  8 +++++---
> > > >  3 files changed, 29 insertions(+), 3 deletions(-)
> > > >
> > > > --
> > > > 2.33.0.259.gc128427fd7-goog
> > > >
