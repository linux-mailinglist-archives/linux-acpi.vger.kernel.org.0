Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6736A2DD33A
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Dec 2020 15:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgLQOtG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 09:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbgLQOtF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 09:49:05 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62603C06138C
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2020 06:48:25 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id q22so20499333eja.2
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2020 06:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zyeRkT/Tiedmv3c7h0oJAQ3zimAR+ezz/jtOsHPbNqA=;
        b=w4MxlMApj68HrZJ+wPYGW1aygTpQog6dpy+8wwNWjQ5N7ENAWbs7X8kFfhl72slqoe
         +SvC0z+j7raXt3Yx87ZB2BZ2kPZ36IX37QyYqwXhx7X5KVkHGrCb6idfAVuxhb57sBWc
         XnOckrdm7IVIkUfdSR9Y98N9SlpoLfrwIMtWtuhMvSQ7wNuC5bS0cVXdCke46qOHduNi
         XT7UJ6X/SV0M2Fq8CKTfnbi/9qM5pKu831NmrI3DhbGNxCqa9MWJIR3YxKBizaw/VHN9
         7pVnK9e09KhUzppMk8GO5JbIADayxR8PTf8TJpPpDrYTYVI4gbDRcfmeHRLEB1NduxTW
         y7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zyeRkT/Tiedmv3c7h0oJAQ3zimAR+ezz/jtOsHPbNqA=;
        b=pMG77g2oGtRv8kPphPQp8CG7cEcMOix3iTMP3o62dbmTRus0lVSFbPKmZ/QUA2b6YR
         338XgLmqQm8Xj6+SSJcO7Zai8t1n6djk8t84IRWX6H8kUyRsGaCboyY+J8JkUvSrkeWm
         995b4MRd415tei3nfHmgJWqfnCZEuS0D50qZ+WA2QhH02PzZfvOwR9FaARak1XXrcNdJ
         vRR+kP6nkrSnIwWEQZdO7sKm4MNwjaXy+qNhR2z225orfMXsCryvCdd5LVdyRSeHHxJM
         OAYHYncOmqXzHTW1SGQnAl/akB9VJpo/jYK+gio6/9697LNj9iTk/tSFALuEMhb7iMvq
         cO7g==
X-Gm-Message-State: AOAM530N28qT5URLbDNjFBWJNWwmK2nSzzlEKAGrSfp3clYUTN8P2z53
        D131RkrwpLOAvENeREUSsENwyRNl0ony3XZRHhOwuQ==
X-Google-Smtp-Source: ABdhPJxglGkzGeLeHFoSoaR7wzOrrK1YMTmSAasoGs2HmfNFtnygGKC+eh76rdZcmH70kSVieSYhlaegaFGMX7I6qc4=
X-Received: by 2002:a17:906:17d0:: with SMTP id u16mr35171465eje.452.1608216503214;
 Thu, 17 Dec 2020 06:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <e9837ba5-deeb-c64c-2261-d0ab82eebfac@arm.com> <67cb563d19114f609348dc9f8b4307e9@huawei.com>
 <8f92d0b3-360b-5d47-10a7-83d09e75d993@arm.com> <6dcf51b2-cad5-d377-a34c-4e64fd3acbb8@arm.com>
 <3d0a3ae81241474f91748dde0cdd4d39@huawei.com>
In-Reply-To: <3d0a3ae81241474f91748dde0cdd4d39@huawei.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Thu, 17 Dec 2020 15:47:45 +0100
Message-ID: <CABdtJHvoWCE4Zd5gTf4wbAKtriWRFx6y1CSH0taVxMmEf7tweg@mail.gmail.com>
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

On Mon, Dec 14, 2020 at 3:48 PM Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Steven Price [mailto:steven.price@arm.com]
> > Sent: 14 December 2020 13:43
> > To: Robin Murphy <robin.murphy@arm.com>; Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>;
> > linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > iommu@lists.linux-foundation.org; devel@acpica.org
> > Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> > joro@8bytes.org; wanghuiqiang <wanghuiqiang@huawei.com>; Guohanjun
> > (Hanjun Guo) <guohanjun@huawei.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; Sami.Mujawar@arm.com
> > Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
> >
> > On 14/12/2020 12:33, Robin Murphy wrote:
> > > On 2020-12-14 10:55, Shameerali Kolothum Thodi wrote:
> > >> Hi Steve,
> > >>
> > >>> -----Original Message-----
> > >>> From: Steven Price [mailto:steven.price@arm.com]
> > >>> Sent: 10 December 2020 10:26
> > >>> To: Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>;
> > >>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > >>> iommu@lists.linux-foundation.org; devel@acpica.org
> > >>> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> > >>> joro@8bytes.org; robin.murphy@arm.com; wanghuiqiang
> > >>> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> > >>> <guohanjun@huawei.com>; Jonathan Cameron
> > >>> <jonathan.cameron@huawei.com>; Sami.Mujawar@arm.com
> > >>> Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR nod=
e
> > >>>
> > >>> On 19/11/2020 12:11, Shameer Kolothum wrote:
> > >>>> RFC v1 --> v2:
> > >>>>    - Added a generic interface for IOMMU drivers to retrieve all t=
he
> > >>>>      RMR info associated with a given IOMMU.
> > >>>>    - SMMUv3 driver gets the RMR list during probe() and installs
> > >>>>      bypass STEs for all the SIDs in the RMR list. This is to keep
> > >>>>      the ongoing traffic alive(if any) during SMMUv3 reset. This i=
s
> > >>>>      based on the suggestions received for v1 to take care of the
> > >>>>      EFI framebuffer use case. Only sanity tested for now.
> > >>>
> > >>> Hi Shameer,
> > >>>
> > >>> Sorry for not looking at this before.
> > >>>
> > >>> Do you have any plans to implement support in the SMMUv2 driver? Th=
e
> > >>> platform I've been testing the EFI framebuffer support on has the
> > >>> display controller behind SMMUv2, so as it stands this series doesn=
't
> > >>> work. I did hack something up for SMMUv2 so I was able to test the =
first
> > >>> 4 patches.
> > >>
> > >> Thanks for taking a look. Sure, I can look into adding the support f=
or
> > >> SMMUv2.
> >
> > Great, thanks!
> >
> > >>>
> > >>>>    - During the probe/attach device, SMMUv3 driver reserves any
> > >>>>      RMR region associated with the device such that there is a un=
ity
> > >>>>      mapping for them in SMMU.
> > >>>
> > >>> For the EFI framebuffer use case there is no device to attach so I
> > >>> believe we are left with just the stream ID in bypass mode - which =
is
> > >>> definitely an improvement (the display works!)
> > >>
> > >> Cool. That=E2=80=99s good to know.
> > >>
> > >>   but not actually a unity
> > >>> mapping of the RMR range. I'm not sure whether it's worth fixing th=
is or
> > >>> not, but I just wanted to point out there's still a need for a driv=
er
> > >>> for the device before the bypass mode is replaced with the unity
> > >>> mapping.
> > >>
> > >> I am not sure either. My idea was we will have bypass STE setup for
> > >> all devices
> > >> with RMR initially and when the corresponding driver takes over(if
> > >> that happens)
> > >> we will have the unity mapping setup properly for the RMR regions. A=
nd
> > >> for cases
> > >> like the above, it will remain in the bypass mode.
> > >>
> > >> Do you see any problem(security?) if the dev streams remain in bypas=
s
> > >> mode for
> > >> this dev? Or is it possible to have a stub driver for this dev, so
> > >> that we will have
> > >> the probe/attach invoked and everything will fall in place?
> > >
> > > The downside is that if a driver never binds to that device, it remai=
ns
> > > bypassed. If some other externally-controlled malicious device could
> > > manage to spoof that device's requester ID, that could potentially be
> > > exploited.
> > >
> > >> TBH, I haven't looked into creating a temp domain for these types of
> > >> the devices
> > >> and also not sure how we benefit from that compared to the STE bypas=
s
> > >> mode.
> > >
> > > That said, setting up temporary translation contexts that ensure any
> > > access can *only* be to RMR regions until a driver takes over is an
> > > awful lot more work. I'm inclined to be pragmatic here and say we sho=
uld
> > > get things working at all with the simple bypass STE/S2CR method, the=
n
> > > look at adding the higher-security effort on top.
> > >
> > > Right now systems that need this are either broken (but effectively
> > > secure) or using default bypass with SMMUv2. People who prefer to
> > > maintain security over functionality in the interim can maintain that
> > > status quo by simply continuing to not describe any RMRs.
> >
> > I agree with Robin, let's get this working with the bypass mode (until
> > the device binds) like you've currently got. It's much better than what
> > we have otherwise. Then once that is merged we can look at the temporar=
y
> > translation context or stub driver. The temporary translation context
> > would be 'neatest', but I'm only aware of the EFI framebuffer use case
> > and for that it might be possible to do something simpler - if indeed
> > anything is needed at all. I'm not sure how much we need to be worried
> > about malicious devices spoofing requester IDs.
>
> Perfect. I will keep the STE bypass and respin the series once the update
> to the IORT rev E is made public(hope that will happen soon). In the
> meantime, appreciate any feedback on the rest of the patches in this seri=
es.

Shameer,

I am pretty sure rev E is already public.  You can find it here.

https://developer.arm.com/documentation/den0049/latest/

It is also marked non-confidential.

I also have initial patches for edk2 and the HoneyComb LX2160a
ACPI tables adding RMR nodes that partially work with your patches.
This is with basic SMMUv2 support but since you have more experience
this this I am more than happy to work with you on your patchset.

-Jon


>
> Thanks,
> Shameer
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
