Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE972E93CB
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 11:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbhADK4k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 05:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADK4j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 05:56:39 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37590C061793
        for <linux-acpi@vger.kernel.org>; Mon,  4 Jan 2021 02:55:59 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id p22so26843033edu.11
        for <linux-acpi@vger.kernel.org>; Mon, 04 Jan 2021 02:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jNoWJV7/ZpanihG2/+qxpPMzBkVQY0wXDUZpsjLAt4k=;
        b=D8McgG9WOmzV0nhCGpe/uvPh6rmYuE+ywcPSbcLvakvFiLJ0zuXVBnHu99/syh08OB
         n+Vs3+9uzQtQFYdyyCWWXVnYL+sWFBjWy91DAghnPDOZIQXNOFzClp/1x0iAOJgzMqit
         X1sKLYH01EPc2aw7sfDBwjO1rai/c5dIrhSJqimB7xYenaTUlT9m2Zs4HV0ozKr/ff/N
         yzpmSaPbZFEbAIC919EXhnsDo7zinNKSMkQ73H8anP+MmTOfg0Qur1IeL1I/oKQaDCZD
         LjUJYvcdRKebRu4zgm9sYN6a+RpJjdon2E5G/VcfFhouxTliIfFJhcTSVwLS/gHy7k5E
         FV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jNoWJV7/ZpanihG2/+qxpPMzBkVQY0wXDUZpsjLAt4k=;
        b=bNtb0tIRo48BaO+PlBXgrwbNstpH7OLuubzXCXBr9JOCdwDKB9DKeKFk15qWMifm+k
         6gbr04RKeYy+U9oEg/6QomhiDs7HKMqaLusqBoJ0MLrZOJODtcFBkOruvQIRepuGB0+I
         2lkSSFJVwTxMateea7CA9iizu15B2BQZ8v5ZgVtp3G02eZhepEFT3oOt4thKH8o2noHD
         z2ZH0TibC42+pdO4TbjYOqcHnVT1nM3cUprjVH2bRk6inpyzfaPaCazbbJJThBLo5mKw
         98WvOgivAHgCoYOA85aMTHaupVPKhd3gDWCQVQIGIwaEBHZ5h5Gqyjl8k2tfGao+cFZE
         Kwrg==
X-Gm-Message-State: AOAM532HrHkkBwODEO/TZPewDlKgGX8V0tMkgURsr+N172PfBvmypTcR
        kLbdo/PNIuhOVh+Y7u9K6rJ6FN7qm9hyLutmRNOlhQ==
X-Google-Smtp-Source: ABdhPJyLjEwzDlo5bwj2FZyPv5CY2QTPm+IhrpEXAEAnsgnAnJgweeduHEH+ncaw8QMCBqYyguYHpqqCyITXGGXOeTQ=
X-Received: by 2002:a50:b746:: with SMTP id g64mr70060117ede.33.1609757757959;
 Mon, 04 Jan 2021 02:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <e9837ba5-deeb-c64c-2261-d0ab82eebfac@arm.com> <67cb563d19114f609348dc9f8b4307e9@huawei.com>
 <8f92d0b3-360b-5d47-10a7-83d09e75d993@arm.com> <6dcf51b2-cad5-d377-a34c-4e64fd3acbb8@arm.com>
 <3d0a3ae81241474f91748dde0cdd4d39@huawei.com> <CABdtJHvoWCE4Zd5gTf4wbAKtriWRFx6y1CSH0taVxMmEf7tweg@mail.gmail.com>
 <93c22f3c57c042c39871a0fd3a2eaa0e@huawei.com> <CABdtJHswDUdB-mw5EJtncvFxqyE0O4zAH5QavbsrG9mWHyateQ@mail.gmail.com>
 <CABdtJHvGXBMmjbb8z9aHQt=nhAvCiFdsKJZfzagsmT+Kj8G_Bw@mail.gmail.com> <4f0ede92d9d24b9da0baacd7e77e672d@huawei.com>
In-Reply-To: <4f0ede92d9d24b9da0baacd7e77e672d@huawei.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Mon, 4 Jan 2021 11:55:20 +0100
Message-ID: <CABdtJHvLpLsfgpLHnKqMaP48pqsuTh9WKhLcnU7cKHvnr-6BHQ@mail.gmail.com>
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
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 4, 2021 at 9:55 AM Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jon Nettleton [mailto:jon@solid-run.com]
> > Sent: 18 December 2020 10:53
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
> > On Thu, Dec 17, 2020 at 4:53 PM Jon Nettleton <jon@solid-run.com> wrote=
:
> > >
> > > On Thu, Dec 17, 2020 at 4:42 PM Shameerali Kolothum Thodi
> > > <shameerali.kolothum.thodi@huawei.com> wrote:
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Jon Nettleton [mailto:jon@solid-run.com]
> > > > > Sent: 17 December 2020 14:48
> > > > > To: Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>
> > > > > Cc: Steven Price <steven.price@arm.com>; Robin Murphy
> > > > > <robin.murphy@arm.com>; linux-arm-kernel@lists.infradead.org;
> > > > > linux-acpi@vger.kernel.org; iommu@lists.linux-foundation.org;
> > > > > devel@acpica.org; lorenzo.pieralisi@arm.com; joro@8bytes.org;
> > Guohanjun
> > > > > (Hanjun Guo) <guohanjun@huawei.com>; Linuxarm
> > <linuxarm@huawei.com>;
> > > > > Jonathan Cameron <jonathan.cameron@huawei.com>;
> > > > > Sami.Mujawar@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> > > > > Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR n=
ode
> > > > >
> > > > > On Mon, Dec 14, 2020 at 3:48 PM Shameerali Kolothum Thodi
> > > > > <shameerali.kolothum.thodi@huawei.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Steven Price [mailto:steven.price@arm.com]
> > > > > > > Sent: 14 December 2020 13:43
> > > > > > > To: Robin Murphy <robin.murphy@arm.com>; Shameerali Kolothum
> > Thodi
> > > > > > > <shameerali.kolothum.thodi@huawei.com>;
> > > > > > > linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.=
org;
> > > > > > > iommu@lists.linux-foundation.org; devel@acpica.org
> > > > > > > Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com=
;
> > > > > > > joro@8bytes.org; wanghuiqiang <wanghuiqiang@huawei.com>;
> > Guohanjun
> > > > > > > (Hanjun Guo) <guohanjun@huawei.com>; Jonathan Cameron
> > > > > > > <jonathan.cameron@huawei.com>; Sami.Mujawar@arm.com
> > > > > > > Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT R=
MR
> > node
> > > > > > >
> > > > > > > On 14/12/2020 12:33, Robin Murphy wrote:
> > > > > > > > On 2020-12-14 10:55, Shameerali Kolothum Thodi wrote:
> > > > > > > >> Hi Steve,
> > > > > > > >>
> > > > > > > >>> -----Original Message-----
> > > > > > > >>> From: Steven Price [mailto:steven.price@arm.com]
> > > > > > > >>> Sent: 10 December 2020 10:26
> > > > > > > >>> To: Shameerali Kolothum Thodi
> > > > > > > <shameerali.kolothum.thodi@huawei.com>;
> > > > > > > >>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.ker=
nel.org;
> > > > > > > >>> iommu@lists.linux-foundation.org; devel@acpica.org
> > > > > > > >>> Cc: Linuxarm <linuxarm@huawei.com>;
> > lorenzo.pieralisi@arm.com;
> > > > > > > >>> joro@8bytes.org; robin.murphy@arm.com; wanghuiqiang
> > > > > > > >>> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> > > > > > > >>> <guohanjun@huawei.com>; Jonathan Cameron
> > > > > > > >>> <jonathan.cameron@huawei.com>; Sami.Mujawar@arm.com
> > > > > > > >>> Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IO=
RT RMR
> > node
> > > > > > > >>>
> > > > > > > >>> On 19/11/2020 12:11, Shameer Kolothum wrote:
> > > > > > > >>>> RFC v1 --> v2:
> > > > > > > >>>>    - Added a generic interface for IOMMU drivers to retr=
ieve all
> > the
> > > > > > > >>>>      RMR info associated with a given IOMMU.
> > > > > > > >>>>    - SMMUv3 driver gets the RMR list during probe() and
> > installs
> > > > > > > >>>>      bypass STEs for all the SIDs in the RMR list. This =
is to keep
> > > > > > > >>>>      the ongoing traffic alive(if any) during SMMUv3 res=
et. This
> > is
> > > > > > > >>>>      based on the suggestions received for v1 to take ca=
re of
> > the
> > > > > > > >>>>      EFI framebuffer use case. Only sanity tested for no=
w.
> > > > > > > >>>
> > > > > > > >>> Hi Shameer,
> > > > > > > >>>
> > > > > > > >>> Sorry for not looking at this before.
> > > > > > > >>>
> > > > > > > >>> Do you have any plans to implement support in the SMMUv2
> > driver?
> > > > > The
> > > > > > > >>> platform I've been testing the EFI framebuffer support on=
 has the
> > > > > > > >>> display controller behind SMMUv2, so as it stands this se=
ries
> > doesn't
> > > > > > > >>> work. I did hack something up for SMMUv2 so I was able to=
 test
> > the
> > > > > first
> > > > > > > >>> 4 patches.
> > > > > > > >>
> > > > > > > >> Thanks for taking a look. Sure, I can look into adding the=
 support for
> > > > > > > >> SMMUv2.
> > > > > > >
> > > > > > > Great, thanks!
> > > > > > >
> > > > > > > >>>
> > > > > > > >>>>    - During the probe/attach device, SMMUv3 driver reser=
ves
> > any
> > > > > > > >>>>      RMR region associated with the device such that the=
re is
> > a
> > > > > unity
> > > > > > > >>>>      mapping for them in SMMU.
> > > > > > > >>>
> > > > > > > >>> For the EFI framebuffer use case there is no device to at=
tach so I
> > > > > > > >>> believe we are left with just the stream ID in bypass mod=
e - which
> > is
> > > > > > > >>> definitely an improvement (the display works!)
> > > > > > > >>
> > > > > > > >> Cool. That=E2=80=99s good to know.
> > > > > > > >>
> > > > > > > >>   but not actually a unity
> > > > > > > >>> mapping of the RMR range. I'm not sure whether it's worth=
 fixing
> > this
> > > > > or
> > > > > > > >>> not, but I just wanted to point out there's still a need =
for a driver
> > > > > > > >>> for the device before the bypass mode is replaced with th=
e unity
> > > > > > > >>> mapping.
> > > > > > > >>
> > > > > > > >> I am not sure either. My idea was we will have bypass STE =
setup for
> > > > > > > >> all devices
> > > > > > > >> with RMR initially and when the corresponding driver takes=
 over(if
> > > > > > > >> that happens)
> > > > > > > >> we will have the unity mapping setup properly for the RMR =
regions.
> > And
> > > > > > > >> for cases
> > > > > > > >> like the above, it will remain in the bypass mode.
> > > > > > > >>
> > > > > > > >> Do you see any problem(security?) if the dev streams remai=
n in
> > bypass
> > > > > > > >> mode for
> > > > > > > >> this dev? Or is it possible to have a stub driver for this=
 dev, so
> > > > > > > >> that we will have
> > > > > > > >> the probe/attach invoked and everything will fall in place=
?
> > > > > > > >
> > > > > > > > The downside is that if a driver never binds to that device=
, it remains
> > > > > > > > bypassed. If some other externally-controlled malicious dev=
ice could
> > > > > > > > manage to spoof that device's requester ID, that could pote=
ntially be
> > > > > > > > exploited.
> > > > > > > >
> > > > > > > >> TBH, I haven't looked into creating a temp domain for thes=
e types
> > of
> > > > > > > >> the devices
> > > > > > > >> and also not sure how we benefit from that compared to the=
 STE
> > bypass
> > > > > > > >> mode.
> > > > > > > >
> > > > > > > > That said, setting up temporary translation contexts that e=
nsure any
> > > > > > > > access can *only* be to RMR regions until a driver takes ov=
er is an
> > > > > > > > awful lot more work. I'm inclined to be pragmatic here and =
say we
> > should
> > > > > > > > get things working at all with the simple bypass STE/S2CR m=
ethod,
> > then
> > > > > > > > look at adding the higher-security effort on top.
> > > > > > > >
> > > > > > > > Right now systems that need this are either broken (but eff=
ectively
> > > > > > > > secure) or using default bypass with SMMUv2. People who pre=
fer to
> > > > > > > > maintain security over functionality in the interim can mai=
ntain that
> > > > > > > > status quo by simply continuing to not describe any RMRs.
> > > > > > >
> > > > > > > I agree with Robin, let's get this working with the bypass mo=
de (until
> > > > > > > the device binds) like you've currently got. It's much better=
 than what
> > > > > > > we have otherwise. Then once that is merged we can look at th=
e
> > temporary
> > > > > > > translation context or stub driver. The temporary translation=
 context
> > > > > > > would be 'neatest', but I'm only aware of the EFI framebuffer=
 use case
> > > > > > > and for that it might be possible to do something simpler - i=
f indeed
> > > > > > > anything is needed at all. I'm not sure how much we need to b=
e
> > worried
> > > > > > > about malicious devices spoofing requester IDs.
> > > > > >
> > > > > > Perfect. I will keep the STE bypass and respin the series once =
the update
> > > > > > to the IORT rev E is made public(hope that will happen soon). I=
n the
> > > > > > meantime, appreciate any feedback on the rest of the patches in=
 this
> > series.
> > > > >
> > > > > Shameer,
> > > >
> > > > Hi Jon,
> > > >
> > > > >
> > > > > I am pretty sure rev E is already public.  You can find it here.
> > > > >
> > > > > https://developer.arm.com/documentation/den0049/latest/
> > > > >
> > > > > It is also marked non-confidential.
> > > >
> > > > Yes, Rev E is already out there. But I am told that ARM folks are w=
orking on
> > > > some updates to the IORT spec, especially around the RMR topic. Hop=
efully
> > > > it will be out soon.
> > >
> > > Yes there are some changes coming to the SPEC but I don't know if it =
is
> > > worth holding up your patchset as an initial implementation.  If you =
would
> > > like I am more than happy to bring this up as a topic for the next St=
eering
> > > Committee meeting.
> > >
> > > Jon
> >
> > Shameer,
> >
>
> Hi Jon,
>
> > My first attempt at smmuv2 support can be found in this kernel branch.
> >
> > https://github.com/SolidRun/linux-stable/commits/linux-5.10.y-cex7
> >
> > It is functioning if the bypass SMRs are setup in the firmware and RMR'=
s
> > are exposed in the ACPI tables.
>
> Ok. Thanks for sharing it. Happy to carry those patches as part of this
> series if you are fine with it.

That is fine with me.  I have also cc'd Laurentiu from NXP as part of the
code is lifted from his integration with the Qualcom patches submitted
for device-tree handling.

We may want to also start a conversation if the RMR list should be
populated from the device-tree codepaths and then have the SMMU*
drivers share the same mechanism for adding the bypass mappings
and then letting drivers reclaim the DMA regions.

I think there was an Nvidia patchset that did something similar based
on DT reserved memory regions and smmu mappings.

>
>   Different from your situation we do want
> > the device to reclaim the RMR's associated with it on initialization, a=
nd I
> > am still seeing issues there.  I need to spend more time figuring out w=
hy
> > this is not working properly.
>
> I am not sure what your requirement is here. So if the kernel driver even=
tually
> comes up and takes control of the device, you no longer require the bypas=
s/identity
> mapping for these regions. Is that correct?

Yes this is basically correct.  I believe some of the issues I have
run into will
be covered in the next release of the RMR specs.  For now this patchset
does give me basic working functionality, and the future refinements will
add more fine grained security that I am looking for.

As I mentioned before, it would be nice to get this functionality moving
forward and then we can refine it as spec updates are made public.

-Jon

>
> Shameer
>
> > -Jon
> >
> > >
> > > >
> > > > >
> > > > > I also have initial patches for edk2 and the HoneyComb LX2160a
> > > > > ACPI tables adding RMR nodes that partially work with your patche=
s.
> > > >
> > > > Thanks for the update and good to know that it is useful.
> > > >
> > > > Shameer
> > > >
> > > > > This is with basic SMMUv2 support but since you have more experie=
nce
> > > > > this this I am more than happy to work with you on your patchset.
> > > > >
> > > > > -Jon
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Shameer
> > > > > > _______________________________________________
> > > > > > linux-arm-kernel mailing list
> > > > > > linux-arm-kernel@lists.infradead.org
> > > > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
