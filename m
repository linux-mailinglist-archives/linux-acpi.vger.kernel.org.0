Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFD38EE73
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 16:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbfHOOl2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 10:41:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44060 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbfHOOl2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Aug 2019 10:41:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so2410448wrf.11;
        Thu, 15 Aug 2019 07:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HcFpMiTtuOvVin5sw+3DuNBsfQfOejkUnh6Hot437es=;
        b=OXLlY6kcmuBDEe2qQ4D5NprGXUFSF0Iq0QNrVXw7/W68GetZu/DpIukPUSwgwKeZUK
         Zk4/NxyLYNzC5yqz3gR0lH0oDpOb5p1Ee9GGvY0zD9jOJQZIFXt9Qj+Q83eBvVRkO+7Z
         ADB3X5dMqjih80/3kRrwBojC3m3pfqMSdmI3E98upGyKdt1dWP8Hf1RivgQ3A3yEBqel
         VJX8E0D5hylR36JRDpziyrYYwvPHZ1flrImBCn+Lqg1B1Rd+byxgO+tq97Nvb5YsToRq
         n9ciL7JVxnKEv1JB1yPzC7SYtCv54PUQFWnMSIQlhBh9EXDzMxTkNhsDKJ1xqXlPOKip
         JtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcFpMiTtuOvVin5sw+3DuNBsfQfOejkUnh6Hot437es=;
        b=ZY6kfd2qUOl08eUYcyB9O0oaBgdZhnhRMTHzxybX2jIO8qz7hYD0XxL+l24NjUphC8
         7x27qhhKmowca/K3uqruBN0HFfW+DDaSm/mQ2/L+ZDYqULR0+Q+Apfuc0F+PpH6N7MT/
         9rsBxxr1pMcuUY0KszZJV30ms2yR+4cjb7JDbXA7ja02IvieitP8JfTN3ATadWUparxm
         LsAG4hvDJq4lxsVZH/rw7Wn20VnyM7tN900xCkCbqxzfNE3tt3ui9OHEONWpUDY56LD9
         VDMSQBoRNuP58VblkZxmW7kDDfDC/RdLFau/G16k6KkTg3tBC2ktmTSpV+9CfpGQnS2L
         UnaA==
X-Gm-Message-State: APjAAAVq08qJGyLfW6R8xM2wFW36AmbNhyoWCKM4B/m2ifjcuZafvM+K
        R8wtA3ukuH19wTdFsF0V4d9nmK0fq/YLCjtCUoM=
X-Google-Smtp-Source: APXvYqwu7tBhNmf/UnYZw2m8f2ftuHlgfpBHXl/sfxChx5P3Gt4q17UYOIlrbtBUl+i40lNOQNcjUR9EbI4EFrUTFIo=
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr5805577wru.74.1565880085269;
 Thu, 15 Aug 2019 07:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
 <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
 <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com>
 <CADnq5_NUox3vvg6Mt3i9erA+AL2MfotpNBZQnWWknn4j+j-F=Q@mail.gmail.com>
 <CACO55tty6TqEo4UBkX5YckLuP-XhHXKVs0ew+Q8__sKMi1BCbA@mail.gmail.com>
 <CADnq5_PWuLU0pcG549-xThMHy3W0P2+fAO_Ledk6FP2TVG3+gQ@mail.gmail.com> <6ed1c393ffeb4c24ab5875927d6a37ac@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <6ed1c393ffeb4c24ab5875927d6a37ac@AUSX13MPC101.AMER.DELL.COM>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Aug 2019 10:41:13 -0400
Message-ID: <CADnq5_NoCR3f7VhKnqkvvVAF+=R0aN69WRCDxwcVLHTPpfHyTQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     Mario.Limonciello@dell.com
Cc:     Karol Herbst <kherbst@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Alex Hung <alex.hung@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 15, 2019 at 10:30 AM <Mario.Limonciello@dell.com> wrote:
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

I don't remember off hand.  It was before the _PR3 support in the pci
subsystem was upstream.  What was the problem you were seeing with
this system?

Alex

>
> We can arrange to have it checked again on 5.3rcX w/ the OSI disabled.
