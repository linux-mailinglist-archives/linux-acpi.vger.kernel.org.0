Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF5C2DD4A8
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Dec 2020 16:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgLQPyv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 10:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgLQPyt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 10:54:49 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22488C06138C
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2020 07:54:09 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b2so29167235edm.3
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2020 07:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H2fBF1NZD/CA5dUGzgt8FhvOPCeP3OHfrcXGYZ8Dqu8=;
        b=JiZ/DChOMdVaVhhvFjIavU1hCDr1LEMABxAMu6nSRvsz7d/uAbN9rRbH7abAX4xjqD
         TcNHbmQDw2dJCPQZkjWYVKx0e48QsjqtYlJrnV4d4CCAgjTv26++1ruOc2GIeALu5UWj
         NBBAS/g4F4ZC0WtrHTtACaMR3MzSVEPkSLbFWZ3pu07ULL9qtHIuL3ke7nI4Yb6ZGFdP
         TGxOZybVcvnWv/CFtAcr+VR7oermP5Ss8zKl8c5mXyBp5d8dYd6RzsxbiwbHOJNasRv0
         SYnuYtx/1Ie6VL3mbMEhu8rc5xK+YPRhv2Jpn+CDzrx63e20qCHlPJyNPe9AjqKyeCSh
         VhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H2fBF1NZD/CA5dUGzgt8FhvOPCeP3OHfrcXGYZ8Dqu8=;
        b=p/xFD/E2vgbgL3PVE3qmtXFhQ/RPfJqooYh8wsgNmq1Osj4ojB0WHdC4chbivntrL/
         /alN7+S3N0Z7GHYA5za+V7vR4AE19ztC3Uy+MXZ7X5+wrQlNeoRfcL5nhWc9lELk0Lq1
         9JBPIA+2QMjqZQborS92rWCCXo61dd473/cN1MzaVzRnLt/1ey3HZrSGvIPBHuoU1EUH
         kYGCpwblzFSD4G+Diq1yA+SMgQ6cx9e23HhCaF05Qv2WRb8gMfmlBKCi+5lRo7vbwTgI
         pwTv+2UEVb4u/pj08OnRNvtNZGDRsUSsg8ct4noyO6bVBgo4d5BFhwlCfHMS9II5A0D9
         7lug==
X-Gm-Message-State: AOAM533layp54icD22lL5AlqDjBIImGeE4l33CY3sj1AvianTwj9lOzH
        VodGZLxYcMrgGg932u1Q4G9foA9piUMcH9SagZ3zGg==
X-Google-Smtp-Source: ABdhPJzyEXdOOu/8RKgq/ONFkpT4C1+WB0zpTC9uUzzkMOIl+ZAIzZ/mMFa5I/njrHnI41uC7riGkGp5VM/Lf1hbALo=
X-Received: by 2002:aa7:ce94:: with SMTP id y20mr38402010edv.361.1608220447789;
 Thu, 17 Dec 2020 07:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <e9837ba5-deeb-c64c-2261-d0ab82eebfac@arm.com> <67cb563d19114f609348dc9f8b4307e9@huawei.com>
 <8f92d0b3-360b-5d47-10a7-83d09e75d993@arm.com> <6dcf51b2-cad5-d377-a34c-4e64fd3acbb8@arm.com>
 <3d0a3ae81241474f91748dde0cdd4d39@huawei.com> <CABdtJHvoWCE4Zd5gTf4wbAKtriWRFx6y1CSH0taVxMmEf7tweg@mail.gmail.com>
 <93c22f3c57c042c39871a0fd3a2eaa0e@huawei.com>
In-Reply-To: <93c22f3c57c042c39871a0fd3a2eaa0e@huawei.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Thu, 17 Dec 2020 16:53:29 +0100
Message-ID: <CABdtJHswDUdB-mw5EJtncvFxqyE0O4zAH5QavbsrG9mWHyateQ@mail.gmail.com>
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

On Thu, Dec 17, 2020 at 4:42 PM Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jon Nettleton [mailto:jon@solid-run.com]
> > Sent: 17 December 2020 14:48
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: Steven Price <steven.price@arm.com>; Robin Murphy
> > <robin.murphy@arm.com>; linux-arm-kernel@lists.infradead.org;
> > linux-acpi@vger.kernel.org; iommu@lists.linux-foundation.org;
> > devel@acpica.org; lorenzo.pieralisi@arm.com; joro@8bytes.org; Guohanjun
> > (Hanjun Guo) <guohanjun@huawei.com>; Linuxarm <linuxarm@huawei.com>;
> > Jonathan Cameron <jonathan.cameron@huawei.com>;
> > Sami.Mujawar@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> > Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
> >
> > On Mon, Dec 14, 2020 at 3:48 PM Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Steven Price [mailto:steven.price@arm.com]
> > > > Sent: 14 December 2020 13:43
> > > > To: Robin Murphy <robin.murphy@arm.com>; Shameerali Kolothum Thodi
> > > > <shameerali.kolothum.thodi@huawei.com>;
> > > > linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > > > iommu@lists.linux-foundation.org; devel@acpica.org
> > > > Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> > > > joro@8bytes.org; wanghuiqiang <wanghuiqiang@huawei.com>; Guohanjun
> > > > (Hanjun Guo) <guohanjun@huawei.com>; Jonathan Cameron
> > > > <jonathan.cameron@huawei.com>; Sami.Mujawar@arm.com
> > > > Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR nod=
e
> > > >
> > > > On 14/12/2020 12:33, Robin Murphy wrote:
> > > > > On 2020-12-14 10:55, Shameerali Kolothum Thodi wrote:
> > > > >> Hi Steve,
> > > > >>
> > > > >>> -----Original Message-----
> > > > >>> From: Steven Price [mailto:steven.price@arm.com]
> > > > >>> Sent: 10 December 2020 10:26
> > > > >>> To: Shameerali Kolothum Thodi
> > > > <shameerali.kolothum.thodi@huawei.com>;
> > > > >>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.or=
g;
> > > > >>> iommu@lists.linux-foundation.org; devel@acpica.org
> > > > >>> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> > > > >>> joro@8bytes.org; robin.murphy@arm.com; wanghuiqiang
> > > > >>> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> > > > >>> <guohanjun@huawei.com>; Jonathan Cameron
> > > > >>> <jonathan.cameron@huawei.com>; Sami.Mujawar@arm.com
> > > > >>> Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR=
 node
> > > > >>>
> > > > >>> On 19/11/2020 12:11, Shameer Kolothum wrote:
> > > > >>>> RFC v1 --> v2:
> > > > >>>>    - Added a generic interface for IOMMU drivers to retrieve a=
ll the
> > > > >>>>      RMR info associated with a given IOMMU.
> > > > >>>>    - SMMUv3 driver gets the RMR list during probe() and instal=
ls
> > > > >>>>      bypass STEs for all the SIDs in the RMR list. This is to =
keep
> > > > >>>>      the ongoing traffic alive(if any) during SMMUv3 reset. Th=
is is
> > > > >>>>      based on the suggestions received for v1 to take care of =
the
> > > > >>>>      EFI framebuffer use case. Only sanity tested for now.
> > > > >>>
> > > > >>> Hi Shameer,
> > > > >>>
> > > > >>> Sorry for not looking at this before.
> > > > >>>
> > > > >>> Do you have any plans to implement support in the SMMUv2 driver=
?
> > The
> > > > >>> platform I've been testing the EFI framebuffer support on has t=
he
> > > > >>> display controller behind SMMUv2, so as it stands this series d=
oesn't
> > > > >>> work. I did hack something up for SMMUv2 so I was able to test =
the
> > first
> > > > >>> 4 patches.
> > > > >>
> > > > >> Thanks for taking a look. Sure, I can look into adding the suppo=
rt for
> > > > >> SMMUv2.
> > > >
> > > > Great, thanks!
> > > >
> > > > >>>
> > > > >>>>    - During the probe/attach device, SMMUv3 driver reserves an=
y
> > > > >>>>      RMR region associated with the device such that there is =
a
> > unity
> > > > >>>>      mapping for them in SMMU.
> > > > >>>
> > > > >>> For the EFI framebuffer use case there is no device to attach s=
o I
> > > > >>> believe we are left with just the stream ID in bypass mode - wh=
ich is
> > > > >>> definitely an improvement (the display works!)
> > > > >>
> > > > >> Cool. That=E2=80=99s good to know.
> > > > >>
> > > > >>   but not actually a unity
> > > > >>> mapping of the RMR range. I'm not sure whether it's worth fixin=
g this
> > or
> > > > >>> not, but I just wanted to point out there's still a need for a =
driver
> > > > >>> for the device before the bypass mode is replaced with the unit=
y
> > > > >>> mapping.
> > > > >>
> > > > >> I am not sure either. My idea was we will have bypass STE setup =
for
> > > > >> all devices
> > > > >> with RMR initially and when the corresponding driver takes over(=
if
> > > > >> that happens)
> > > > >> we will have the unity mapping setup properly for the RMR region=
s. And
> > > > >> for cases
> > > > >> like the above, it will remain in the bypass mode.
> > > > >>
> > > > >> Do you see any problem(security?) if the dev streams remain in b=
ypass
> > > > >> mode for
> > > > >> this dev? Or is it possible to have a stub driver for this dev, =
so
> > > > >> that we will have
> > > > >> the probe/attach invoked and everything will fall in place?
> > > > >
> > > > > The downside is that if a driver never binds to that device, it r=
emains
> > > > > bypassed. If some other externally-controlled malicious device co=
uld
> > > > > manage to spoof that device's requester ID, that could potentiall=
y be
> > > > > exploited.
> > > > >
> > > > >> TBH, I haven't looked into creating a temp domain for these type=
s of
> > > > >> the devices
> > > > >> and also not sure how we benefit from that compared to the STE b=
ypass
> > > > >> mode.
> > > > >
> > > > > That said, setting up temporary translation contexts that ensure =
any
> > > > > access can *only* be to RMR regions until a driver takes over is =
an
> > > > > awful lot more work. I'm inclined to be pragmatic here and say we=
 should
> > > > > get things working at all with the simple bypass STE/S2CR method,=
 then
> > > > > look at adding the higher-security effort on top.
> > > > >
> > > > > Right now systems that need this are either broken (but effective=
ly
> > > > > secure) or using default bypass with SMMUv2. People who prefer to
> > > > > maintain security over functionality in the interim can maintain =
that
> > > > > status quo by simply continuing to not describe any RMRs.
> > > >
> > > > I agree with Robin, let's get this working with the bypass mode (un=
til
> > > > the device binds) like you've currently got. It's much better than =
what
> > > > we have otherwise. Then once that is merged we can look at the temp=
orary
> > > > translation context or stub driver. The temporary translation conte=
xt
> > > > would be 'neatest', but I'm only aware of the EFI framebuffer use c=
ase
> > > > and for that it might be possible to do something simpler - if inde=
ed
> > > > anything is needed at all. I'm not sure how much we need to be worr=
ied
> > > > about malicious devices spoofing requester IDs.
> > >
> > > Perfect. I will keep the STE bypass and respin the series once the up=
date
> > > to the IORT rev E is made public(hope that will happen soon). In the
> > > meantime, appreciate any feedback on the rest of the patches in this =
series.
> >
> > Shameer,
>
> Hi Jon,
>
> >
> > I am pretty sure rev E is already public.  You can find it here.
> >
> > https://developer.arm.com/documentation/den0049/latest/
> >
> > It is also marked non-confidential.
>
> Yes, Rev E is already out there. But I am told that ARM folks are working=
 on
> some updates to the IORT spec, especially around the RMR topic. Hopefully
> it will be out soon.

Yes there are some changes coming to the SPEC but I don't know if it is
worth holding up your patchset as an initial implementation.  If you would
like I am more than happy to bring this up as a topic for the next Steering
Committee meeting.

Jon

>
> >
> > I also have initial patches for edk2 and the HoneyComb LX2160a
> > ACPI tables adding RMR nodes that partially work with your patches.
>
> Thanks for the update and good to know that it is useful.
>
> Shameer
>
> > This is with basic SMMUv2 support but since you have more experience
> > this this I am more than happy to work with you on your patchset.
> >
> > -Jon
> >
> >
> > >
> > > Thanks,
> > > Shameer
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
