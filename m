Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28B2C8EE52
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 16:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbfHOOfh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 10:35:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37960 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730915AbfHOOff (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Aug 2019 10:35:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id r20so6334072ota.5
        for <linux-acpi@vger.kernel.org>; Thu, 15 Aug 2019 07:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtTSn2uMyyP8QHhCiI6vaNdIzu8IHEHZhZ5nwC+nMAU=;
        b=SKCgJPMtqGWaAgPyBegFRU6EEdONVbu0j61P5gtoRE4UErFe+R7Ub66HzTc61+kbgV
         D8q9Sl+m1g/U+avBtVEQNUXF53Iz6r8GiwAkhR1E/qau580gcInBFwJYtEYscx/83qpw
         86ijLE0oe3fq+5KonS9l7lSylfNEOs6TxOoQREuDk8Uc6adQOx3d6ul8W82jpykYxADV
         hcEPPbVYwXzkmvmoSIHrR+x9c95azEBuiHlrqD3TTcR4XsiD3zy4PBLOaS9jHsEcIJHT
         YyKjsgoZeTy6IwPXE6vWBHrXcCqaEGudpC/PXkqC+f5s2/EyvT2oDPT4BvDrQcKPoSxq
         V8kw==
X-Gm-Message-State: APjAAAXYCTInSVxejmgvcanekOtL1RbnoEuELtDDVz6tp0aOVJbvqRVo
        PY46N2Hz1W9Gbq00V24O8iS6BIwwxTnXPntQqPy4kQ==
X-Google-Smtp-Source: APXvYqzKOnt+7f9VOL89+ec428aBeZSnl2atgboE0ieQNu4BQtWa3L1DeSUe5NY6fj6Fh4lzcbXWphwAs3uyRC9CmKY=
X-Received: by 2002:a6b:f906:: with SMTP id j6mr5800892iog.26.1565879733515;
 Thu, 15 Aug 2019 07:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
 <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
 <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com>
 <CADnq5_NUox3vvg6Mt3i9erA+AL2MfotpNBZQnWWknn4j+j-F=Q@mail.gmail.com>
 <CACO55tty6TqEo4UBkX5YckLuP-XhHXKVs0ew+Q8__sKMi1BCbA@mail.gmail.com>
 <CADnq5_PWuLU0pcG549-xThMHy3W0P2+fAO_Ledk6FP2TVG3+gQ@mail.gmail.com> <6ed1c393ffeb4c24ab5875927d6a37ac@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <6ed1c393ffeb4c24ab5875927d6a37ac@AUSX13MPC101.AMER.DELL.COM>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 15 Aug 2019 16:35:22 +0200
Message-ID: <CACO55ttUKCGJq66czgsgWSR5VE6VmQFs6Syr0R2CenXomU2O-w@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     Mario.Limonciello@dell.com
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        Alex Hung <alex.hung@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 15, 2019 at 4:30 PM <Mario.Limonciello@dell.com> wrote:
>
> > On Thu, Aug 15, 2019 at 10:15 AM Karol Herbst <kherbst@redhat.com> wrote:
> > >
> > > On Thu, Aug 15, 2019 at 4:13 PM Alex Deucher <alexdeucher@gmail.com>
> > wrote:
> > > >
> > > > On Thu, Aug 15, 2019 at 10:04 AM Karol Herbst <kherbst@redhat.com> wrote:
> > > > >
> > > > > On Thu, Aug 15, 2019 at 3:56 PM <Mario.Limonciello@dell.com> wrote:
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: linux-acpi-owner@vger.kernel.org <linux-acpi-
> > owner@vger.kernel.org> On
> > > > > > > Behalf Of Dave Airlie
> > > > > > > Sent: Wednesday, August 14, 2019 5:48 PM
> > > > > > > To: Karol Herbst
> > > > > > > Cc: LKML; Linux ACPI; dri-devel; nouveau; Rafael J . Wysocki; Alex Hung;
> > Ben
> > > > > > > Skeggs; Dave Airlie
> > > > > > > Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI
> > string to
> > > > > > > enable dGPU direct output"
> > > > > > >
> > > > > > > On Thu, 15 Aug 2019 at 07:31, Karol Herbst <kherbst@redhat.com>
> > wrote:
> > > > > > > >
> > > > > > > > This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.
> > > > > > > >
> > > > > > > > The original commit message didn't even make sense. AMD _does_
> > support it and
> > > > > > > > it works with Nouveau as well.
> > > > > > > >
> > > > > > > > Also what was the issue being solved here? No references to any bugs
> > and not
> > > > > > > > even explaining any issue at all isn't the way we do things.
> > > > > > > >
> > > > > > > > And even if it means a muxed design, then the fix is to make it work
> > inside the
> > > > > > > > driver, not adding some hacky workaround through ACPI tricks.
> > > > > > > >
> > > > > > > > And what out of tree drivers do or do not support we don't care one
> > bit anyway.
> > > > > > > >
> > > > > > >
> > > > > > > I think the reverts should be merged via Rafael's tree as the original
> > > > > > > patches went in via there, and we should get them in asap.
> > > > > > >
> > > > > > > Acked-by: Dave Airlie <airlied@redhat.com>
> > > > > > > Dave.
> > > > > >
> > > > > > There are definitely going to be regressions on machines in the field with
> > the
> > > > > > in tree drivers by reverting this.  I think we should have an answer for all
> > of those
> > > > > > before this revert is accepted.
> > > > > >
> > > > > > Regarding systems with Intel+NVIDIA, we'll have to work with partners to
> > collect
> > > > > > some information on the impact of reverting this.
> > > > > >
> > > > > > When this is used on a system with Intel+AMD the ASL configures AMD
> > GPU to use
> > > > > > "Hybrid Graphics" when on Windows and "Power Express" and
> > "Switchable Graphics"
> > > > > > when on Linux.
> > > > >
> > > > > and what's exactly the difference between those? And what's the actual
> > > > > issue here?
> > > >
> > > > Hybrid Graphics is the new "standard" way of handling these laptops.
> > > > It uses the standard _PR3 APCI method to handle dGPU power.  Support
> > > > for this was added to Linux relatively later compared to when the
> > > > laptops were launched.  "Power Express" used the other AMD specific
> > > > ATPX ACPI method to handle dGPU power.  The driver supports both so
> > > > either method will work.
> > > >
> > > > Alex
> > > >
> > >
> > > thanks for clarifying. But that still means that we won't need such
> > > workarounds for AMD users, right? amdgpu handles hybrid graphics just
> > > fine, right?
> >
> > Yeah it should, assuming you have a new enough kernel which supports
> > HG, which has been several years at this point IIRC.
> >
> > Alex
> >
>
> Can you define how new of a kernel is a new enough kernel?
>
> Looking on my side these problems were on new hardware (Precision 7740) and
> are checked as recently as start of this summer, w/ kernel 4.15.

That's not even a long term one. And it shouldn't get any fixes. I
just checked, last update was 16 months ago.

>
> We can arrange to have it checked again on 5.3rcX w/ the OSI disabled.

yeah, please do. If there are any issues, we (as in drm developers)
are happy to fix the issues inside the drivers.
