Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C23D2253CA
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Jul 2020 21:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgGSTvM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 19 Jul 2020 15:51:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42293 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726009AbgGSTvL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 19 Jul 2020 15:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595188269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5+W4juhVWCiEA3fhSp7PQYC8FiX7DnbLymUoDvTE4gg=;
        b=hmaF0854vEaDyXo3jhOu1rLfdEDINnMjQwwvYvuWrrDi9xSzynTTDKGgnPsKZCRArOx072
        CtOKQYAEajORhXDeYeOEPwi7bYP+1AhiOjwR1dueArMVck36Hzm641JYR10sXH+55NE+Wc
        Kdgv2LVQJKlgo/RvOBaQggAhFGpgDnY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-YgKi1HBrO_yyYbGAoZyAKg-1; Sun, 19 Jul 2020 15:51:08 -0400
X-MC-Unique: YgKi1HBrO_yyYbGAoZyAKg-1
Received: by mail-qt1-f199.google.com with SMTP id 94so10531245qtb.21
        for <linux-acpi@vger.kernel.org>; Sun, 19 Jul 2020 12:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+W4juhVWCiEA3fhSp7PQYC8FiX7DnbLymUoDvTE4gg=;
        b=XTBl72mcxhIlp66L8hC8KeF3vhKUqrNtgtle+y90yfDpRmnSLJtK8paV4LH9+4/KYF
         EkgH9HoT6oXXpGOiP6vHFp7/Injm/71l+LXn01+fUTnT3UWC8eQGQYhcimiUUoeIvyOr
         Tkf6v4ZrlJs4LvKK+eAYzhwdQzGEC44jmB4V0UrhjHMzY4qGo+c1t5cD/sSC7Zyzw9r0
         OBpsgGrjBBPS+O0PKHMymiF7xE2So2i2iGFEOxW4ufRLJGJYiaagEdHBGYk2sV68QCQH
         924wnKN/HfloDE7cUKsVbBTscMPnst/P5Ah0GRAfX2w/b9uZ4ZCtpL3rSLa3NwpK2+K8
         wFvQ==
X-Gm-Message-State: AOAM530CY+lPMeMvX0OjeDSIh4wnqLIQ0jkqiYRKI0K116u8IqMGMAKP
        LZCcwErJusPkzMQF6kbosihDfpuNDE80yxtnBmO039QpQmPH73XBVhDR27F89+8dm4hqmLvHR57
        +h2BlqeUtA1seyvU7q5HPnBMBYXU47YcOhIwy3Q==
X-Received: by 2002:ac8:4250:: with SMTP id r16mr20990798qtm.378.1595188267463;
        Sun, 19 Jul 2020 12:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9yVJg1QjyL9ivv5A6w+hu0GivIVSEEJqorLOC5n0j8PWQVDcfmYvz9E5//ryrqzbOSjwmCLlGhUm5y3yGbRs=
X-Received: by 2002:ac8:4250:: with SMTP id r16mr20990785qtm.378.1595188267211;
 Sun, 19 Jul 2020 12:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200717190547.648604-1-kherbst@redhat.com> <e7a8cb3a-e9f8-b78a-93f0-c09e5eb5ed10@canonical.com>
In-Reply-To: <e7a8cb3a-e9f8-b78a-93f0-c09e5eb5ed10@canonical.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sun, 19 Jul 2020 21:50:56 +0200
Message-ID: <CACO55tvLCrqeV8MsVDbTaWP2EPAeZtfU08Kb2fVGCD6X+g3-rg@mail.gmail.com>
Subject: Re: [PATCH] RFC: ACPI / OSI: remove workarounds for hybrid graphics laptops
To:     Alex Hung <alex.hung@canonical.com>
Cc:     Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lyude Paul <lyude@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 17, 2020 at 9:52 PM Alex Hung <alex.hung@canonical.com> wrote:
>
> On 2020-07-17 1:05 p.m., Karol Herbst wrote:
> > It's hard to figure out what systems are actually affected and right now I
> > don't see a good way of removing those...
> >
> > But I'd like to see thos getting removed and drivers fixed instead (which
> > happened at least for nouveau).
> >
> > And as mentioned before, I prefer people working on fixing issues instead
> > of spending time to add firmware level workarounds which are hard to know
> > to which systems they apply to, hard to remove and basically a big huge
> > pain to work with.> In the end I have no idea how to even figure out what systems are affected
> > and which not by this, so I have no idea how to even verify we can safely
> > remove this (which just means those are impossible to remove unless we risk
> > breaking systems, which again makes those supper annoying to deal with).
> >
> > Also from the comments it's hard to get what those bits really do. Are they
> > just preventing runtime pm or do the devices are powered down when booting?
> > I am sure it's the former, still...
> >
> > Please, don't do this again.
> >
> > For now, those workaround prevent power savings on systems those workaround
> > applies to, which might be any so those should get removed asap and if
> > new issues arrise removing those please do a proper bug report and we can
> > look into it and come up with a proper fix (and keep this patch out until
> > we resolve all of those).
> >
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > CC: Alex Hung <alex.hung@canonical.com>
> > CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > CC: Len Brown <lenb@kernel.org>
> > CC: Lyude Paul <lyude@redhat.com>
> > CC: linux-kernel@vger.kernel.org
> > CC: dri-devel@lists.freedesktop.org
> > CC: nouveau@lists.freedesktop.org
> > ---
> >  drivers/acpi/osi.c | 24 ------------------------
> >  1 file changed, 24 deletions(-)
> >
> > diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> > index 9f68538091384..d4405e1ca9b97 100644
> > --- a/drivers/acpi/osi.c
> > +++ b/drivers/acpi/osi.c
> > @@ -44,30 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
> >       {"Processor Device", true},
> >       {"3.0 _SCP Extensions", true},
> >       {"Processor Aggregator Device", true},
> > -     /*
> > -      * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
> > -      * cards as RTD3 is not supported by drivers now.  Systems with NVidia
> > -      * cards will hang without RTD3 disabled.
> > -      *
> > -      * Once NVidia drivers officially support RTD3, this _OSI strings can
> > -      * be removed if both new and old graphics cards are supported.
> > -      */
> > -     {"Linux-Dell-Video", true},
> > -     /*
> > -      * Linux-Lenovo-NV-HDMI-Audio is used by BIOS to power on NVidia's HDMI
> > -      * audio device which is turned off for power-saving in Windows OS.
> > -      * This power management feature observed on some Lenovo Thinkpad
> > -      * systems which will not be able to output audio via HDMI without
> > -      * a BIOS workaround.
> > -      */
> > -     {"Linux-Lenovo-NV-HDMI-Audio", true},
> > -     /*
> > -      * Linux-HPI-Hybrid-Graphics is used by BIOS to enable dGPU to
> > -      * output video directly to external monitors on HP Inc. mobile
> > -      * workstations as Nvidia and AMD VGA drivers provide limited
> > -      * hybrid graphics supports.
> > -      */
> > -     {"Linux-HPI-Hybrid-Graphics", true},
> >  };
> >
> >  static u32 acpi_osi_handler(acpi_string interface, u32 supported)
> >
>
> The changes were discussed and tested a while ago, and no crashes were
> observed. Thanks for solving PM issues in nouveau.
>
> Acked-by: Alex Hung <alex.hung@canonical.com>
>

By any chance, do you have a list of systems implementing those workarounds?

