Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D1B276BC3
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 10:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgIXI0Z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Sep 2020 04:26:25 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:38727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgIXI0Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2020 04:26:25 -0400
X-Greylist: delayed 60646 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 04:26:23 EDT
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MnagF-1kl78t23NN-00jX68; Thu, 24 Sep 2020 10:26:22 +0200
Received: by mail-qk1-f173.google.com with SMTP id v123so2487558qkd.9;
        Thu, 24 Sep 2020 01:26:22 -0700 (PDT)
X-Gm-Message-State: AOAM5322pE9d6oTUDb0fysgmklL1BUbMvIuxZ9lnKS8K5QjuEr2L1zxA
        ZY6wqc9/NIN+1S7po4YSnt5cXvw80BmJT+EDKbE=
X-Google-Smtp-Source: ABdhPJwdB4OckyypHDvhO1cGrqIWN2A9DDGKREeH56+z++Kes/ubhHRnkNRx8EJcehFdXXe5kRHJ6nndT91q+XgyvnE=
X-Received: by 2002:a37:5d8:: with SMTP id 207mr3790606qkf.352.1600935980950;
 Thu, 24 Sep 2020 01:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
 <dad42dce-15d0-245a-4d91-4733e54883a0@gmail.com> <CAK8P3a2ryzmsrHHApT9O=dvsw+=z18Sjd4ygVxvFrrDetKA+rQ@mail.gmail.com>
 <c4c1d999-9ab7-8988-906a-3cb6a70bc93d@gmail.com>
In-Reply-To: <c4c1d999-9ab7-8988-906a-3cb6a70bc93d@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 24 Sep 2020 10:26:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2XegsP71yvd8Ku08_k6ecQfkU+V+t+QnjQBrJKF2MwCg@mail.gmail.com>
Message-ID: <CAK8P3a2XegsP71yvd8Ku08_k6ecQfkU+V+t+QnjQBrJKF2MwCg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7BSu+DCzcAsvcwNW/57TzlBcHkc7QtvslyE7xNAfuxWY1xVxCeo
 vYxOvSAWLJpqEbhKmF0hg3Zga739OBAzSlxeJjvBo6SAvF3uiO049eJfPxMTg+7HB8vNX3B
 SKMxP6K3DPKwdLJhWX3WkxgN1SFR8v8X9nWg/AGHbA4tKGlll5EFdWlxArAeraBkXGUYH0B
 4qaWBHB0Oo/7g1ZZ+jkNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:582bsw1Rrf4=:sPBeZFmBT69s11y8Bqwgd+
 m/PUKiUo0KhGubXXotrGx+LRvY+R/vrgE37REXKbSenmUuuUa2dumfd+lnTPvFTRO1q1hN3uH
 l2Us+r93NZxLc2KPv8lQzmHH/3Wuvserps61c2au1tosZmvUdwh5LFSYopn1juVyKMDGypBzt
 c4ne/crunEBY12Eq7RtEzyRrCybHSz+0amEbVfZjhcwVmi9REHz7nVhFh8tAna2f4XWFz7S1Q
 Y6514NmNsynu65jLAyCh3+rzFoCxlQ7SlcEScLf2CWAppubX3yrxxWL7Fb4VnpiUXYCGN9Ztf
 gQALFbN2VbKWFHI7JGi2ndD0kdWVs4DQEmucr2c659lzdNOKQmt1LDoywvGSupI2Ff71Aq2yL
 MmZiBonZ3mNcOidb0x1zZT6FS3SV4Odw6LzGuf/7rQn216lmBGerPBzuVb+OfCSdl/ro+49VD
 QK7eAgKYWvPtd/fr5QH3OvebhMUWccqJ5HITp8d1aAmVtyLbpErKUeve/k17jrO+JLCsZPEsC
 F66SHVSGFSflw0UdPTExQyqED8XMLCM+46aSVvslI2ttvwfzyC/4PHopqbNjYZ7l//0CCEJIZ
 xzNjch1R8GWyrBlb2Tbf2qsNHwqbhnfjPyeeuMRtR3IPkQiMm4jPM/P8Zt6Sed2+4CHV0RYVg
 e3ZWsp7AGIi+uWzcDOLrF5J4eNDg7OPuyNrX7k/z+xrO2BkQlLCKLyRxWvYAkbfCyWH6zMpYw
 dgzwjWFhaRHpZzQceJa4UbDVLE/GVEJIMfiXyrBgd3q5F5gqVkQ3fnhjOvJVHgD6SVFUTmhco
 3Xe9BtvPioyKs2Hkf6t+fb05ELSYxt0Jql2QtnAdnQvmkVbp6m0harmwQuKWRQjL+TvdAluOs
 jxdpUlGo+c7w/8Zid6rNaWr2vJjWAfT1gPSxHr5bliz5GknIReeCojYeI3h6rYpjtO2adIOlf
 2bi87SFdnIAuz1TBLDXgLSed1gxdQVDcYTFozejbfDZsrNddiectF
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 24, 2020 at 1:28 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> On 9/23/20 9:43 PM, Arnd Bergmann wrote:
> > On Wed, Sep 23, 2020 at 5:43 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> >>
> >> On 9/23/20 5:30 PM, Arnd Bergmann wrote:
> >>> On Wed, Sep 23, 2020 at 5:15 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> The Surface System Aggregator Module (we'll refer to it as Surface
> >>>> Aggregator or SAM below) is an embedded controller (EC) found on various
> >>>> Microsoft Surface devices. Specifically, all 4th and later generation
> >>>> Surface devices, i.e. Surface Pro 4, Surface Book 1 and later, with the
> >>>> exception of the Surface Go series and the Surface Duo. Notably, it
> >>>> seems like this EC can also be found on the ARM-based Surface Pro X [1].
> >>>
> >>> I think this should go to drivers/platform/x86 or drivers/platform/surface/
> >>> along with other laptop vendor specific code rather than drivers/misc/.
> >>
> >> I initially had this under drivers/platform/x86. There are two main
> >> reasons I changed that: First, I think it's a bit too big for
> >> platform/x86 given that it basically introduces a new subsystem. At this
> >> point it's really less of "a couple of odd devices here and there" and
> >> more of a bus-type thing. Second, with the possibility of future support
> >> for ARM devices (Pro X, Pro X 2 which is rumored to come out soon), I
> >> thought that platform/x86 would not be a good fit.
> >
> > I don't see that as a strong reason against it. As you write yourself, the
> > driver won't work on the arm machines without major changes anyway,
> > and even if it does, it fits much better with the rest of it.
>
> Sorry, I should have written that a bit more clearly. I don't see any
> reason why these drivers would not work on an ARM device such as the Pro
> X right now, assuming that it boots via ACPI and the serial device it
> loads against is fully functional.

As I understand, the dialect of ACPI used on the snapdragon laptops
is not really compatible with the subset expected by the kernel, so
you'd be more likely to run those laptops with a device tree description
of the hardware instead (if at all).

Making the driver talk to the hardware directly instead of going through
AML likely requires more refactoring.

> >> I'd be happy to move this to platform/surface though, if that's
> >> considered a better fit and you're okay with me adding that. Would make
> >> sense given that there's already a platform/chrome, which, as far as I
> >> can tell, also seems to be mainly focused on EC support.
> >
> > Yes, I think the main question is how much overlap you see functionally
> > between this driver and the others in drivers/platform/x86.
>
> I think that the Pro X likely won't be the last ARM Surface device with
> a SAM EC. Further, the subsystem is going to grow, and platform/x86
> seems more like a collection of, if at all, loosely connected drivers,
> which might give off the wrong impression. In my mind, this is just a
> bit more comparable to platform/chrome than the rest of platform/x86. I
> don't think I'm really qualified to make the decision on that though,
> that's just my opinion.

I would ask the drivers/platform/x86 maintainers for an opinion here,
they are probably best qualified to make that decision.

I don't really mind either way, for me this is more about who is
responsible as a subsystem maintainer than whether these are
technically x86 or not.

> Here's an overview of other drivers that I hopefully at some point get
> in good enough shape, which are part of this subsystem/dependent on the
> EC API introduced here:
>
> - A device registry / device hub for devices that are connected to the
>    EC but can't be detected via ACPI.
>
> - A dedicated battery driver for 7th generation devices (where the
>    battery isn't hanled via the ACPI shim).
>
> - A driver properly handling clipboard detachment on the Surface Books.
>
> - A driver for HID input/transport on the Surface Laptops and Surface
>    Book 3.
>
> - A driver for allowing users to set the performance/cooling mode via
>    sysfs.
>
> - Possibly a driver improving hot-plug handling of the discrete GPU in
>    the Surface Book base.

Note that drivers that connect to the bus typically don't live in the
same subdirectory as the driver that operates the bus. E.g. the
battery driver would go into drivers/power/supply and the input
would go into drivers/input/ or drivers/hid.

    Arnd
