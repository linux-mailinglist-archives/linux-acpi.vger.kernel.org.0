Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4FB38E426
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 06:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfHOEoU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 00:44:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40049 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbfHOEoT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Aug 2019 00:44:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id c34so3384130otb.7
        for <linux-acpi@vger.kernel.org>; Wed, 14 Aug 2019 21:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7sgS6p5Q/fcvkuEHxhDuVLaRmp/CaA8gA0Ducst9aSA=;
        b=tYEb6RQRkIUacF3KM7JslX6oEFSmpDDYzHGKbA6t/NBeaYwjakn1JsufL0j1vPLvfq
         tBoDr3QPzv9Mz0Nf1Pfe3kY69wFIbdT9NNZBwGV6bNXd93Rfjk8lpsuf0+pIWX6edz6G
         CjilX/n+3REecp0jIH4ejkwUnM54jeuFahpZD25kkeBETA71ORIZ+0vcf5I6PKLmx3Bn
         WNhh2eHajGNV9SM/wh7v6lwsA8NGRy6w1ALG3xoi1zyXBvwImT/gPuB2G9Hs9PExG+8I
         Qg44ps4XYt3/Gx99VzG7j6qGCjBOkyHRquNctBhWNCyKxUa+v2qn4PMhJG1w9Ejx8EO0
         3cpg==
X-Gm-Message-State: APjAAAVLf7hbpg/NyZMUI0d8MqEhpsNRMd8G0YpiR+7fc7ae2sJgpASD
        iG875GuRbmIS/ClzO6kCSL8FJoa62gA3NMUZByGXtg==
X-Google-Smtp-Source: APXvYqzSDSGEKv6Lo/FEdaBeeBng3hZLZ0ZFMnC1IGlwgNjG49HHY2f6Hq8EMesb30W3wQuAlY93QT/q+q+6otEXm7U=
X-Received: by 2002:a6b:f906:: with SMTP id j6mr3664108iog.26.1565844258431;
 Wed, 14 Aug 2019 21:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-4-kherbst@redhat.com>
 <CAJ=jquaVcWisQ3Qw-_GMktcOq4zqFmeYXztfwNAVKZJO=_+yLA@mail.gmail.com>
In-Reply-To: <CAJ=jquaVcWisQ3Qw-_GMktcOq4zqFmeYXztfwNAVKZJO=_+yLA@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 15 Aug 2019 06:44:06 +0200
Message-ID: <CACO55ttcXhod940t_G1ty74tU7vT2K1tShwqAwhcy0Eu2TYGqA@mail.gmail.com>
Subject: Re: [PATCH 3/7] Revert "ACPI / OSI: Add OEM _OSI strings to disable
 NVidia RTD3"
To:     Alex Hung <alex.hung@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 15, 2019 at 1:35 AM Alex Hung <alex.hung@canonical.com> wrote:
>
> On Wed, Aug 14, 2019 at 3:31 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > This reverts commit 9251a71db62ca9cc7e7cf364218610b0f018c291.
> >
> > This was never discussed with anybody Nouveau related and we would have NACKed
> > this change immediately.
> >
> > We have a better workaround, which makes it actually work with Nouveau. No idea
> > why the comment mentions the Nvidia driver and assumes it gives any weight to
> > the reasoning.... we don't care about out of tree drivers.
> >
> > Nouveau does support RTD3, but we had some issues with that. And we even have
> > a better fix for this issue. Also, can we _please_ do it in a way worthy of an
> > upstream community the next time?
> >
> > If some distribution feels like they have to please companies not wanting to
> > be part of the linux community, please do so downstream and don't try to push
> > something like this upstream.
>
> Hi Karol,
>
> A lot of appreciation for your hard-work on this issue, but unfriendly
> comments aren't necessary. At the time this was discussed with
> hardware vendors and platform vendors and it worked for many systems
> and benefit for many people buying these platforms. Last but not
> least, I do appreciate better fixes and want to retire the hacks too.
>

sorry if that sounded too harsh, but the issue is not that it helped,
the issue is, that nobody talked with us about that. And those three
commits also sounded like they were mainly targeted against the Nvidia
driver (and please correct me if I am wrong here).

The situation would be completely different if we would have talked
about all this earlier (and I wouldn't get annoyed by all of this in
the first place).

I am well aware this is a super painful issue for a lot of users, but
even then disabling RTD3 (for a limited amount of hardware) inside
nouveau would be the only acceptable way to disable it.

I don't see how pushing vendors to add some firmware code to disable
certain features  helps in any way, when there is a fast and easy way
to disable it and wouldn't draw resources away from actually fixing
it.

> I am going to notify hardware owners to test these patches on the
> original intended systems, and will report whether there are
> regressions.
>
>
> >
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > CC: Alex Hung <alex.hung@canonical.com>
> > CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > CC: Dave Airlie <airlied@redhat.com>
> > CC: Lyude Paul <lyude@redhat.com>
> > CC: Ben Skeggs <bskeggs@redhat.com>
> > ---
> >  drivers/acpi/osi.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> > index 56cc95b6b724..f5d559a2ff14 100644
> > --- a/drivers/acpi/osi.c
> > +++ b/drivers/acpi/osi.c
> > @@ -44,15 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
> >         {"Processor Device", true},
> >         {"3.0 _SCP Extensions", true},
> >         {"Processor Aggregator Device", true},
> > -       /*
> > -        * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
> > -        * cards as RTD3 is not supported by drivers now.  Systems with NVidia
> > -        * cards will hang without RTD3 disabled.
> > -        *
> > -        * Once NVidia drivers officially support RTD3, this _OSI strings can
> > -        * be removed if both new and old graphics cards are supported.
> > -        */
> > -       {"Linux-Dell-Video", true},
> >  };
> >
> >  static u32 acpi_osi_handler(acpi_string interface, u32 supported)
> > --
> > 2.21.0
> >
>
>
> --
> Cheers,
> Alex Hung
