Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B2F2DE18F
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 11:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389241AbgLRKyk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 05:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733213AbgLRKyk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2020 05:54:40 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D7FC0617A7
        for <linux-acpi@vger.kernel.org>; Fri, 18 Dec 2020 02:53:59 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id q22so2592329eja.2
        for <linux-acpi@vger.kernel.org>; Fri, 18 Dec 2020 02:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YArGtYIwJqMcWaPkK4ru4ecQr4ZZxiSbO63kFscHRrQ=;
        b=pi+cPAExfsWZlp5c8sN0gXj2VnKCDID/zQtFZuv/diYj4vCgg+YqdcfqjcJk3LXnsv
         zNcADrjmZPmBAkqGqJrKgWyPtvZu0L1vIRZoeSxKc25cRnEloNXexsS5iOLkYMVumdTY
         ++qyJRjXQ4Pz9uHXCkd41lLsLEdyOlBZ9jslsohcalI+mDl94OqV1KRYzRY/dG6QtGKz
         wH3c1WRM0+L5xO7CqMWHMVuN7SQAOHFA9YdF6gNiV4baPdRPiphaW+6AkTJGAy5ExeQo
         HstXCgaC602ZFnYvtY0f2Udyxw75L2QhF7usJv9Ygd0ARA8vXM3JvighZVEyPw/PKvgI
         SJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YArGtYIwJqMcWaPkK4ru4ecQr4ZZxiSbO63kFscHRrQ=;
        b=jY+3ig9/HPxoCaxbyQtJeiIKysJXjKrWARp1b6LyoNuRkrWE2FSTMV4pfX33pBM+PG
         YL/YYnSbY9fYffeukiAXuX60YQ0OsM8yvYSevbINHKJyNqcUk9Zssg5yMb4WHT/Eo7gC
         UVL98ZSang6rE2CJ+35zpbfl0M9TsO9oEP9koc7lEHQtz/g+1s7409k0tza4Pml5FikP
         CdbByupJ5HzkFXEyKpPAVsWqQfHWjd1FpkasVaVtrBzpVDFPnieelXiAHuGmN50/j8e7
         1oZm44MiaYaM4j+1XTCT+97z8NihOAxiJA3/fDSudoncXyOLsdfp1lrTyfrxQ2X0hlf9
         bZ9Q==
X-Gm-Message-State: AOAM530FrBuUGfl0mlldJyAer283MMdaf66fUljZ+rSm7o7krJ0OHqZC
        XAycjDEWCDnjtCUUbam4l8XkoBaOaLWTAhI5FFsmWQ==
X-Google-Smtp-Source: ABdhPJzfB0uecFqUQp0RStx9a6uRSjbWKs4+KyJCpO8+fvwY5HLygSSgJfgRV/tdWAf6QK32Tposue0HQKhpfD1VB88=
X-Received: by 2002:a17:906:9452:: with SMTP id z18mr3407877ejx.389.1608288838332;
 Fri, 18 Dec 2020 02:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <e9837ba5-deeb-c64c-2261-d0ab82eebfac@arm.com> <67cb563d19114f609348dc9f8b4307e9@huawei.com>
 <8f92d0b3-360b-5d47-10a7-83d09e75d993@arm.com> <6dcf51b2-cad5-d377-a34c-4e64fd3acbb8@arm.com>
 <3d0a3ae81241474f91748dde0cdd4d39@huawei.com> <CABdtJHvoWCE4Zd5gTf4wbAKtriWRFx6y1CSH0taVxMmEf7tweg@mail.gmail.com>
 <93c22f3c57c042c39871a0fd3a2eaa0e@huawei.com> <CABdtJHswDUdB-mw5EJtncvFxqyE0O4zAH5QavbsrG9mWHyateQ@mail.gmail.com>
In-Reply-To: <CABdtJHswDUdB-mw5EJtncvFxqyE0O4zAH5QavbsrG9mWHyateQ@mail.gmail.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Fri, 18 Dec 2020 11:53:19 +0100
Message-ID: <CABdtJHvGXBMmjbb8z9aHQt=nhAvCiFdsKJZfzagsmT+Kj8G_Bw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 17, 2020 at 4:53 PM Jon Nettleton <jon@solid-run.com> wrote:
>
> On Thu, Dec 17, 2020 at 4:42 PM Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Jon Nettleton [mailto:jon@solid-run.com]
> > > Sent: 17 December 2020 14:48
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > > Cc: Steven Price <steven.price@arm.com>; Robin Murphy
> > > <robin.murphy@arm.com>; linux-arm-kernel@lists.infradead.org;
> > > linux-acpi@vger.kernel.org; iommu@lists.linux-foundation.org;
> > > devel@acpica.org; lorenzo.pieralisi@arm.com; joro@8bytes.org; Guohanj=
un
> > > (Hanjun Guo) <guohanjun@huawei.com>; Linuxarm <linuxarm@huawei.com>;
> > > Jonathan Cameron <jonathan.cameron@huawei.com>;
> > > Sami.Mujawar@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> > > Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
> > >
> > > On Mon, Dec 14, 2020 at 3:48 PM Shameerali Kolothum Thodi
> > > <shameerali.kolothum.thodi@huawei.com> wrote:
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Steven Price [mailto:steven.price@arm.com]
> > > > > Sent: 14 December 2020 13:43
> > > > > To: Robin Murphy <robin.murphy@arm.com>; Shameerali Kolothum Thod=
i
> > > > > <shameerali.kolothum.thodi@huawei.com>;
> > > > > linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > > > > iommu@lists.linux-foundation.org; devel@acpica.org
> > > > > Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> > > > > joro@8bytes.org; wanghuiqiang <wanghuiqiang@huawei.com>; Guohanju=
n
> > > > > (Hanjun Guo) <guohanjun@huawei.com>; Jonathan Cameron
> > > > > <jonathan.cameron@huawei.com>; Sami.Mujawar@arm.com
> > > > > Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR n=
ode
> > > > >
> > > > > On 14/12/2020 12:33, Robin Murphy wrote:
> > > > > > On 2020-12-14 10:55, Shameerali Kolothum Thodi wrote:
> > > > > >> Hi Steve,
> > > > > >>
> > > > > >>> -----Original Message-----
> > > > > >>> From: Steven Price [mailto:steven.price@arm.com]
> > > > > >>> Sent: 10 December 2020 10:26
> > > > > >>> To: Shameerali Kolothum Thodi
> > > > > <shameerali.kolothum.thodi@huawei.com>;
> > > > > >>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.=
org;
> > > > > >>> iommu@lists.linux-foundation.org; devel@acpica.org
> > > > > >>> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com=
;
> > > > > >>> joro@8bytes.org; robin.murphy@arm.com; wanghuiqiang
> > > > > >>> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> > > > > >>> <guohanjun@huawei.com>; Jonathan Cameron
> > > > > >>> <jonathan.cameron@huawei.com>; Sami.Mujawar@arm.com
> > > > > >>> Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT R=
MR node
> > > > > >>>
> > > > > >>> On 19/11/2020 12:11, Shameer Kolothum wrote:
> > > > > >>>> RFC v1 --> v2:
> > > > > >>>>    - Added a generic interface for IOMMU drivers to retrieve=
 all the
> > > > > >>>>      RMR info associated with a given IOMMU.
> > > > > >>>>    - SMMUv3 driver gets the RMR list during probe() and inst=
alls
> > > > > >>>>      bypass STEs for all the SIDs in the RMR list. This is t=
o keep
> > > > > >>>>      the ongoing traffic alive(if any) during SMMUv3 reset. =
This is
> > > > > >>>>      based on the suggestions received for v1 to take care o=
f the
> > > > > >>>>      EFI framebuffer use case. Only sanity tested for now.
> > > > > >>>
> > > > > >>> Hi Shameer,
> > > > > >>>
> > > > > >>> Sorry for not looking at this before.
> > > > > >>>
> > > > > >>> Do you have any plans to implement support in the SMMUv2 driv=
er?
> > > The
> > > > > >>> platform I've been testing the EFI framebuffer support on has=
 the
> > > > > >>> display controller behind SMMUv2, so as it stands this series=
 doesn't
> > > > > >>> work. I did hack something up for SMMUv2 so I was able to tes=
t the
> > > first
> > > > > >>> 4 patches.
> > > > > >>
> > > > > >> Thanks for taking a look. Sure, I can look into adding the sup=
port for
> > > > > >> SMMUv2.
> > > > >
> > > > > Great, thanks!
> > > > >
> > > > > >>>
> > > > > >>>>    - During the probe/attach device, SMMUv3 driver reserves =
any
> > > > > >>>>      RMR region associated with the device such that there i=
s a
> > > unity
> > > > > >>>>      mapping for them in SMMU.
> > > > > >>>
> > > > > >>> For the EFI framebuffer use case there is no device to attach=
 so I
> > > > > >>> believe we are left with just the stream ID in bypass mode - =
which is
> > > > > >>> definitely an improvement (the display works!)
> > > > > >>
> > > > > >> Cool. That=E2=80=99s good to know.
> > > > > >>
> > > > > >>   but not actually a unity
> > > > > >>> mapping of the RMR range. I'm not sure whether it's worth fix=
ing this
> > > or
> > > > > >>> not, but I just wanted to point out there's still a need for =
a driver
> > > > > >>> for the device before the bypass mode is replaced with the un=
ity
> > > > > >>> mapping.
> > > > > >>
> > > > > >> I am not sure either. My idea was we will have bypass STE setu=
p for
> > > > > >> all devices
> > > > > >> with RMR initially and when the corresponding driver takes ove=
r(if
> > > > > >> that happens)
> > > > > >> we will have the unity mapping setup properly for the RMR regi=
ons. And
> > > > > >> for cases
> > > > > >> like the above, it will remain in the bypass mode.
> > > > > >>
> > > > > >> Do you see any problem(security?) if the dev streams remain in=
 bypass
> > > > > >> mode for
> > > > > >> this dev? Or is it possible to have a stub driver for this dev=
, so
> > > > > >> that we will have
> > > > > >> the probe/attach invoked and everything will fall in place?
> > > > > >
> > > > > > The downside is that if a driver never binds to that device, it=
 remains
> > > > > > bypassed. If some other externally-controlled malicious device =
could
> > > > > > manage to spoof that device's requester ID, that could potentia=
lly be
> > > > > > exploited.
> > > > > >
> > > > > >> TBH, I haven't looked into creating a temp domain for these ty=
pes of
> > > > > >> the devices
> > > > > >> and also not sure how we benefit from that compared to the STE=
 bypass
> > > > > >> mode.
> > > > > >
> > > > > > That said, setting up temporary translation contexts that ensur=
e any
> > > > > > access can *only* be to RMR regions until a driver takes over i=
s an
> > > > > > awful lot more work. I'm inclined to be pragmatic here and say =
we should
> > > > > > get things working at all with the simple bypass STE/S2CR metho=
d, then
> > > > > > look at adding the higher-security effort on top.
> > > > > >
> > > > > > Right now systems that need this are either broken (but effecti=
vely
> > > > > > secure) or using default bypass with SMMUv2. People who prefer =
to
> > > > > > maintain security over functionality in the interim can maintai=
n that
> > > > > > status quo by simply continuing to not describe any RMRs.
> > > > >
> > > > > I agree with Robin, let's get this working with the bypass mode (=
until
> > > > > the device binds) like you've currently got. It's much better tha=
n what
> > > > > we have otherwise. Then once that is merged we can look at the te=
mporary
> > > > > translation context or stub driver. The temporary translation con=
text
> > > > > would be 'neatest', but I'm only aware of the EFI framebuffer use=
 case
> > > > > and for that it might be possible to do something simpler - if in=
deed
> > > > > anything is needed at all. I'm not sure how much we need to be wo=
rried
> > > > > about malicious devices spoofing requester IDs.
> > > >
> > > > Perfect. I will keep the STE bypass and respin the series once the =
update
> > > > to the IORT rev E is made public(hope that will happen soon). In th=
e
> > > > meantime, appreciate any feedback on the rest of the patches in thi=
s series.
> > >
> > > Shameer,
> >
> > Hi Jon,
> >
> > >
> > > I am pretty sure rev E is already public.  You can find it here.
> > >
> > > https://developer.arm.com/documentation/den0049/latest/
> > >
> > > It is also marked non-confidential.
> >
> > Yes, Rev E is already out there. But I am told that ARM folks are worki=
ng on
> > some updates to the IORT spec, especially around the RMR topic. Hopeful=
ly
> > it will be out soon.
>
> Yes there are some changes coming to the SPEC but I don't know if it is
> worth holding up your patchset as an initial implementation.  If you woul=
d
> like I am more than happy to bring this up as a topic for the next Steeri=
ng
> Committee meeting.
>
> Jon

Shameer,

My first attempt at smmuv2 support can be found in this kernel branch.

https://github.com/SolidRun/linux-stable/commits/linux-5.10.y-cex7

It is functioning if the bypass SMRs are setup in the firmware and RMR's
are exposed in the ACPI tables.  Different from your situation we do want
the device to reclaim the RMR's associated with it on initialization, and I
am still seeing issues there.  I need to spend more time figuring out why
this is not working properly.

-Jon

>
> >
> > >
> > > I also have initial patches for edk2 and the HoneyComb LX2160a
> > > ACPI tables adding RMR nodes that partially work with your patches.
> >
> > Thanks for the update and good to know that it is useful.
> >
> > Shameer
> >
> > > This is with basic SMMUv2 support but since you have more experience
> > > this this I am more than happy to work with you on your patchset.
> > >
> > > -Jon
> > >
> > >
> > > >
> > > > Thanks,
> > > > Shameer
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
