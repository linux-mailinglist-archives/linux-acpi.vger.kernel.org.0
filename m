Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785653FF095
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Sep 2021 17:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345986AbhIBP5O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Sep 2021 11:57:14 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:39556 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346004AbhIBP5L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Sep 2021 11:57:11 -0400
Received: by mail-oi1-f182.google.com with SMTP id v2so3133536oie.6;
        Thu, 02 Sep 2021 08:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFUx7gWJXzWAVMJZhKIZuBAi3Q5/fwFRAMT3ERwoDNU=;
        b=faj1tccVwLeud2X9xML3b55iK/VUwfReFGA129Invx+MVkiO3hVQR9ILonBqzVC0o/
         QSoivudHSO8pJK59KcG13I4JM2QZegtBnWQrRh9qumKio4S1lxI5fJR5kJE+wTORBenp
         OjmsSWA/oTKnO+yeX+Rs0/1MtaY0tpZXIk9wTnQ4L7FTMhC1WlULn7BgZqP57ONCqR/m
         U5CcfGBu+k37+x3U1hjUgJ2DApjaaas+CGN+44MEU+5ifqWYbyqwRLQYECAsJPMhfg+5
         ARWMj5wqWaVJjW1H2POUTDKd/BdE3o2LphPLkoiXhcL2R8Z4qAY+OUaP9Gu1cRjrMOzZ
         BdPQ==
X-Gm-Message-State: AOAM531n2tEJzkF92RyiWX1aSAkcnurl3Y3Xr6qKrj/0csfye9sHejGt
        kkKcsqJ40/gXrk7SWW0SWFTl0MQ9tLcgZBHNJ6YvmA/MWJM=
X-Google-Smtp-Source: ABdhPJxIJZ2hpZoIlUXIs+4Zj9pU9AHWGv27CaebZYzijqb5oqSbI+DFF0kg+FU3gYPDzNUAB0pbUi3JBb/JGzDWwl8=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr2618384ois.69.1630598172439;
 Thu, 02 Sep 2021 08:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210902025528.1017391-1-saravanak@google.com> <CAGETcx9N34RyrdKDR8dQ7ECyz7ZXBx-Ft16t033NjTiU8p=Y0g@mail.gmail.com>
In-Reply-To: <CAGETcx9N34RyrdKDR8dQ7ECyz7ZXBx-Ft16t033NjTiU8p=Y0g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Sep 2021 17:56:01 +0200
Message-ID: <CAJZ5v0gt_1vKQXxSY6HoHRPR9O_e1f7VwcBnSjeMgCdCibrwgQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Ulf reported an issue[1] with fw_devlink. This
 series tries to fix that issue.
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Thu, Sep 2, 2021 at 4:57 AM Saravana Kannan <saravanak@google.com> wrote:
>
> Oops, forgot to use a proper subject. Sorry.

Is this a replacement for the "Fix rtl8366rb issues with fw_devlink=on " series?


> On Wed, Sep 1, 2021 at 7:55 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Ulf, mind testing this?
> >
> > Thanks,
> > Saravana
> > [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> >
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Saravana Kannan (2):
> >   driver core: Add support for FWNODE_FLAG_NEVER_PROBES
> >   of: platform: Mark bus devices nodes with FWNODE_FLAG_NEVER_PROBES
> >
> >  drivers/base/core.c    |  8 ++++++++
> >  drivers/of/platform.c  | 16 ++++++++++++++++
> >  include/linux/fwnode.h |  8 +++++---
> >  3 files changed, 29 insertions(+), 3 deletions(-)
> >
> > --
> > 2.33.0.259.gc128427fd7-goog
> >
