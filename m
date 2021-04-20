Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB893651BA
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 07:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhDTFJX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Apr 2021 01:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhDTFJW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Apr 2021 01:09:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C6BC061763
        for <linux-acpi@vger.kernel.org>; Mon, 19 Apr 2021 22:08:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id v6so55009147ejo.6
        for <linux-acpi@vger.kernel.org>; Mon, 19 Apr 2021 22:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IPJmTnk2cLrGBhNWEvbEbMW+tMyWDkXrDdyhBYO5k3I=;
        b=bLOQxDqfe2LQcS6WpJYWB468/cesOS31iyCovCg6/hKDEDnupB34iv0vxEbDyuxRUD
         fVJjO8XX06cLuYsB2LYerZRDr+/oBBYa8jJ38OgtsXWKPxy4AwOYF0iQU7K/MASiSBNj
         XivK0e76i05vLY2srJJid/9nymDq4jCLellH/wnwTbxQh49prQWm9q9Vr1MlUoxmPc6k
         IDAC41vt/rYbkdKiCxMnEsayHNtK2mEi/2Harg44zCC5RZFR0QWp51koxZ299hK8s+Kt
         Gn3KVq0y5W9N8qg5gXdGgC6hA03rlOhe7t9uaXXBQWhPpzpE1VIsP5cqn1k/atDTCLH5
         UihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IPJmTnk2cLrGBhNWEvbEbMW+tMyWDkXrDdyhBYO5k3I=;
        b=HkVR+RSvriJIy22Sf8Gj17RBVQkO2B9cfaGM3MUZXPQqhtyuefnZy2R9Ye1UzMKMyV
         PrEor5T1tDXR1lpRtkQ5YBSERgJ5NKsj95aJjzJNds2eYbsMpmDLzJduhaULcDzjYHnW
         5L2dSGQeDBlz/IdrDQQu2+ss8+Sdz32mZ5DJdzVUHv4//wVEWhkFlWel38GQ5RcSWLGa
         Z65rv/Kt7Cvh8QtbnsDqd2lBj/GT516fmwXoUDRdwqxGm0QHwHp5OoL0DnminUXGmhCo
         8c/Vr+61Z2wYQic1Od/VjL1asrUbNcmw0nhgNzijybX6bXm+8Z9MCuslz4IAK8SeWrjS
         dB6Q==
X-Gm-Message-State: AOAM531Rflt6VZ+hTuU993iW/MeKxDjnI/h/8iTl2raFEvvRgQlNnHGA
        HaorHPebfrNbyjfI+UOpJpHYQ3JUB73rxtAAwcZDTA==
X-Google-Smtp-Source: ABdhPJyFBoDf2edo02/s/lwEbYP0dtP5IMWlVu1arYZQxmMZfNJdIpzkXDQsIXIGYs2L53f+j4hfir65ieI3KI91s/Q=
X-Received: by 2002:a17:906:18e1:: with SMTP id e1mr9073273ejf.341.1618895328741;
 Mon, 19 Apr 2021 22:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <e1a52da9aec90766da5de51b1b839fd95d63a5af.camel@intel.com>
 <BL0PR12MB25321D18363AD50ACC7A2643BD499@BL0PR12MB2532.namprd12.prod.outlook.com>
 <CAPcyv4jztOGShTF+pVSMAtGeK4giHvC3mGNa5bC0pXz=2ZcrJw@mail.gmail.com> <BL0PR12MB2532D6AD41E6CF4F3252EE59BD489@BL0PR12MB2532.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB2532D6AD41E6CF4F3252EE59BD489@BL0PR12MB2532.namprd12.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 19 Apr 2021 22:08:39 -0700
Message-ID: <CAPcyv4jMQbHYQssaDDDQFEbOR1v14VUnejcSwOP9VGUnZSsCKw@mail.gmail.com>
Subject: Re: [ACPI Code First ECN v2]: Generic Port, performace data for
 hotplug memory
To:     Vikram Sethi <vsethi@nvidia.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "Douglas, Chet R" <chet.r.douglas@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 19, 2021 at 9:22 PM Vikram Sethi <vsethi@nvidia.com> wrote:
>
> > From: Dan Williams <dan.j.williams@intel.com>
> > On Mon, Apr 19, 2021 at 3:56 PM Vikram Sethi <vsethi@nvidia.com> wrote:
> > [..]
> > > > * Replace all instances of "Initiator" with "Initiator / Port" in "=
Table
> > > >   5.59 Flags - Generic Initiator Affinity Structure", including the
> > > >   table name.
> > >
> > > I wanted to discuss the implications of a CXL host bridge implementat=
ion that
> > > does not set the "Architectural Transactions" bit/flag in the aforeme=
ntioned
> > > Flags in Table 5.59.
> > >
> > > Since the kernel would be expecting all "System RAM" to have equivale=
nt
> > > Functional properties, if HDM cannot have all the same functionality,=
 then in
> > > the absence of ISA specific ACPI tables clarifying what architectural=
 feature isn't
> > > supported, the kernel may be forced to not online the HDM memory as s=
ystem
> > > RAM. If there is more granular expression of what features are lackin=
g in a ISA
> > > Specific table (eg Memory Tagging/Memory Protection keys not supporte=
d),
> > > the kernel could choose to not enable that feature in all of system R=
AM (if
> > > discrepancy discovered at boot), but still online the HDM as System R=
AM.
> > >
> > > To that end, it may be useful to clarify this to host vendors by way =
of an
> > > Implementation note (ideally in the CXL specification). Something lik=
e:
> > > "CXL hosts are encouraged to support all architectural features in HD=
M
> > > as they do in CPU attached memory to avoid either the memory from
> > > being onlined as System RAM, or the architectural feature being disab=
led.
> > > Hosts must indicate architectural parity for HDM in ACPI SRAT
> > > =E2=80=9CGeneric Port=E2=80=9D flags =E2=80=9CArchitectural transacti=
ons=E2=80=9D bit by setting it to 1.
> > > A port that sets this bit to 0 will need ISA specific ways/ACPI table=
s to
> > > describe which specific ISA features would not work in HDM, so an OS
> > > could disable that memory or that feature."
> > >
> > > Thoughts?
> >
> > The problem, as you know, is that those features are already defined
> > without those "ISA specific ways / ACPI tables". I think it simply
> > must be the case that the only agent in the system that is aware of
> > the intersection of capabilities between ISA and CXL (platform
> > firmware) must mitigate the conflict. I.e. so that the CXL
> > infrastructure need not worry about ISA feature capability and vice
> > versa. To me, this looks like a platform firmware pre-boot
> > configuration menu / switch that turns off CXL (declines to publish
> > ACPI0016 devices) if incompatible ISA feature "X" is enabled, or the
> > reverse turns off ISA feature "X" if CXL is enabled. In other words,
> > the conflict needs to be resolved before the OS boots, setting this
> > bit to 0 is not a viable option for mitigating the conflict because
> > there is no requirement for the OS to even look at this flag.
>
> Leaving it to Firmware is easier for the OS, but could be a couple
> of issues with that:
> Platform firmware may not have a way of disabling ISA feature
> if it is directly visible to the OS via CPU ID registers, and the
> registers can't be trapped to some FW and values adjusted
> on access
> Platform Firmware may not know if the OS supports a specific
> Feature (code may not exist or not default option etc) so it
> may be premature/suboptimal to disable CXL hostbridge
> altogether. Although I suppose a UEFI variable type knob
> could be adjusted in this case and take effect on reboot.
>
> Also, for some *future* ISA features where it may be possible and
> practical to define ISA feature support discovery per NUMA
> node/address range w/ ACPI (prior to userspace ABI being set),
> the platform would want to enable the CXL host bridge and leave
> selective enablement of the feature to the OS. Yes, this is messy
> and best avoided, but it may make sense depending on ISA
> feature and how messy it makes user space. I'm personally
> not in favor of this latter option, but I'm told this was discussed
> in other Coherent interconnect forums and chosen as a path
> forward.

I think it's reasonable for new stuff to define _OSC or other opt-in
requirements to allow the OS to manage ISA vs CXL conflict policy. For
existing conflicts the only reliable mechanism is decline to publish
ACPI0016 if platform firmware can enumerate an ISA feature that it is
not supported on CXL. So I think the proposal here is a recommendation
for platform firmware implementations that they are responsible for
this conflict resolution unless / until other mechanisms arrive.
