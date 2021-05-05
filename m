Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3935A373407
	for <lists+linux-acpi@lfdr.de>; Wed,  5 May 2021 05:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhEEDxh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 May 2021 23:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhEEDxh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 May 2021 23:53:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F11C061574;
        Tue,  4 May 2021 20:52:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e12so703422ljn.2;
        Tue, 04 May 2021 20:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mmiFrZCTc5COSdywEuhQgJ81UHfZD82WwalKAnp/s4=;
        b=clbVKtibRFRr3Es155PDE8ajOZ2y+ZwCbczMQbFAsvc8g24XTSOeH6FbKtOGmoZDON
         qlosUWDP4qjZxLDYxUJd54qJJctP7fytcj1ejmmqhwzJrg3wsmDb7E0kqtVGXFPLQR9m
         0L59zVlcLVTR+iO8exmJ2E9EbHz81aSbtPlP8Rt09GDXbNzba5NJA82eQT4Gmm9ysKQY
         YA0OfigDlqiLuwWJDQ5Zh8tQIFDnM9Vq8Tf8YqQuA8tEPCHbLRrlEt9rei9A7Sr8UqqC
         cdLMl909mgcy6t8zsLepyJbQtgy8qLeM3VbSrZkPspjXJu44WCA9CxHCiA1lQAp28P0G
         4bzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mmiFrZCTc5COSdywEuhQgJ81UHfZD82WwalKAnp/s4=;
        b=AtlAw3p5aoYeMseDtS8C+5yboWdIrizWrrKbQKxuG9hI6Gg1vEtJRgjHqbIetNeYCE
         xoRo9vIeeg0bfo4Q6fw+XEK+ynfUui7qT0dOMlBrCmelZuXBFZG37mquF4q509JdsHVW
         ScmXSBCWSwwwgv4CGUtC0vwTjOxRi2sIsEw3RUXFmHX605HFNx/KSGdq0eccEwoZhlox
         ZVs1+bDx9v6zD02Pgxr3WaOQVtmfz9y9ZC+o7dyZwR1aT3URFosiYuMzGAOxkB8+jgNd
         Pm1WbdRO3xFD7Xj0sdKJhhR7/vfaKuBlYxGrkEZkgxAwJt+d7uTGBj8nTzJBGlV9JvSN
         kyqA==
X-Gm-Message-State: AOAM532oeRDkV5xDawDjmS2tzv/4cqB0DKtAopKVna7K91quYD/EJ6W+
        loaIaLxZKf9pY/9eFytlKq8LHdPewnzAx7UNHTu+V5fVvKJn6g==
X-Google-Smtp-Source: ABdhPJyn4ShXRkZ/z+eIiiMfkhm7kD1oHs6wJZH+4Oc1K/ZpTPqu4NF/zdKkgVrPjQmu6zeCFbN4r2urfv93t34aBo4=
X-Received: by 2002:a2e:2419:: with SMTP id k25mr14393563ljk.266.1620186758465;
 Tue, 04 May 2021 20:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAN2W0iNOsa6GYK28Vz=DmkyjY72H_bq=8EUkzFuy0_p9ZVms4A@mail.gmail.com>
 <20210503092005.GB14939@gofer.mess.org> <CAN2W0iME8VCdP=KdcH8PW7ZfEOdQJicKWQmE675-h3cd2=D1cA@mail.gmail.com>
 <20210504090358.GA26800@gofer.mess.org>
In-Reply-To: <20210504090358.GA26800@gofer.mess.org>
From:   Chris McCrae <chrismccraeworks@gmail.com>
Date:   Tue, 4 May 2021 23:52:27 -0400
Message-ID: <CAN2W0iPsovnGnEZFsQi5wmERVM20hb3TsW1sRb-OfwH0mXh_pg@mail.gmail.com>
Subject: Re: Asus PN62S vs PN50 - ITE8708
To:     Sean Young <sean@mess.org>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 4 May 2021 at 05:03, Sean Young <sean@mess.org> wrote:
>
> Hi Chris,
>
> On Mon, May 03, 2021 at 11:44:04AM -0400, Chris McCrae wrote:
> > Thanks for answering the call Sean.
> >
> > On Mon, 3 May 2021 at 05:20, Sean Young <sean@mess.org> wrote:
> > >
> > > Hi Chris,
> > >
> > > On Fri, Apr 30, 2021 at 07:37:10PM -0400, Chris McCrae wrote:
> > > > Recently acquired an Asus PN62S (Intel) as a media centre frontend
> > > > (currently testing with Xubuntu 20.04 and a 5.10 kernel, and the most
> > > > current BIOS available).  Having an integrated IR was part of the
> > > > selling features.  However, getting it to be recognized by my system
> > > > has become a challenge that I am getting obsessed with.  There's very
> > > > little to find online on this device that is current, but there has
> > > > been some recent conversation on this list about the same device, on a
> > > > related machine, the PN50 (AMD).  I'm hoping that the knowledge here
> > > > may lead to a solution for my issue.
> > > >
> > > > I can provide more detail on request, but at the moment I am focusing
> > > > on the DSDT as a possible suspect.  I do not have the 16 byte issue
> > > > that the PN50 experiences.  Mine is defined as 8 bytes, which is
> > > > compatible with the ite-cir driver.  My issue is that there appears to
> > > > be no attempt to bind the device to the driver (but it is visible in
> > > > lsmod)... no messages about the driver in dmesg at all.  My thought is
> > > > that the definition of the device in DSDT may somehow give it enough
> > > > information (ITE8708) to know the driver could be needed, but not the
> > > > correct information to make it work.
> > > >
> > > > An earlier message provided only part of the device definition in DSDT
> > > > for the PN50.  I would like to be able to see the full definition for
> > > > it from the PN50, to see if anything is significantly different.
> > > > Ideally, if I had the full DSDT as a starting point, I could compare
> > > > other areas such as motherboard resources.
> > >
> > > It would be great if we could see the entries for the IR device in your
> > > DSDT. There is a guide here https://wiki.archlinux.org/title/DSDT on
> > > how to do that.
> > >
> > Here the full device from the DSDT:
> >
> >             Device (CR00)
> >             {
> >                 Name (_ADR, Zero)  // _ADR: Address
> >                 Name (VBAN, 0x0680)
> >                 Name (VIRQ, 0x0A)
> >                 Name (UIDN, Zero)
> >                 Name (_HID, EisaId ("ITE8708"))  // _HID: Hardware ID
> >                 Method (_UID, 0, NotSerialized)  // _UID: Unique ID
> >                 {
> >                     Return (UIDN) /* \_SB_.PCI0.CR00.UIDN */
> >                 }
> >
> >                 Method (_STA, 0, Serialized)  // _STA: Status
> >                 {
> >                     If ((CIRE == Zero))
> >                     {
> >                         Return (Zero)
> >                     }
> >                     Return (0x0F)
> >                 }
> >
> >                 Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
> >                 {
> >                     Name (BUF0, ResourceTemplate ()
> >                     {
> >                         IO (Decode16,
> >                             0x0000,             // Range Minimum
> >                             0x0000,             // Range Maximum
> >                             0x01,               // Alignment
> >                             0x08,               // Length
> >                             _Y10)
> >                         IRQNoFlags (_Y11)
> >                             {}
> >                         DMA (Compatibility, NotBusMaster, Transfer8, )
> >                             {}
> >                     })
> >                     CreateWordField (BUF0,
> > \_SB.PCI0.CR00._CRS._Y10._MIN, IOPL)  // _MIN: Minimum Base Address
> >                     CreateWordField (BUF0,
> > \_SB.PCI0.CR00._CRS._Y10._MAX, IOPH)  // _MAX: Maximum Base Address
> >                     CreateWordField (BUF0,
> > \_SB.PCI0.CR00._CRS._Y11._INT, IRQ)  // _INT: Interrupts
> >                     IOPL = VBAN /* \_SB_.PCI0.CR00.VBAN */
> >                     IOPH = VBAN /* \_SB_.PCI0.CR00.VBAN */
> >                     IRQ = (One << VIRQ) /* \_SB_.PCI0.CR00.VIRQ */
> >                     Return (BUF0) /* \_SB_.PCI0.CR00._CRS.BUF0 */
> >                 }
> >             }
>
> Hmm this is not really telling us everything yet. Would you mind sending
> on the entire dmesg please?
>

I could send dmesg output, but aside from the fact that it's almost
1000 lines, I have just had a moderate degree of success.  Using the
pci=noacpi kernel option, gives me:

[    1.767176] ite_cir: Auto-detected model: ITE8708 CIR transceiver
[    1.767177] ite_cir: Using model: ITE8708 CIR transceiver
[    1.767178] ite_cir: TX-capable: 1
[    1.767179] ite_cir: Sample period (ns): 8680
[    1.767180] ite_cir: TX carrier frequency (Hz): 38000
[    1.767180] ite_cir: TX duty cycle (%): 33
[    1.767181] ite_cir: RX low carrier frequency (Hz): 0
[    1.767182] ite_cir: RX high carrier frequency (Hz): 0
[    1.840766] rc rc0: ITE8708 CIR transceiver as /devices/virtual/rc/rc0
[    1.840842] rc rc0: lirc_dev: driver ite-cir registered at minor =
0, raw IR receiver, raw IR transmitter
[    1.840881] input: ITE8708 CIR transceiver as /devices/virtual/rc/rc0/input3
[    1.844915] ite_cir: driver has been successfully loaded

So after a couple of weeks, I should be happier, right?  Never seen
any of these lines before.  I am happy that there's progress, but some
things still aren't right.

1.  The kernel option will be used to focus my debugging efforts.  At
least this seems to support the idea that ACPI plays a role in this.
I was beginning to lose faith in that idea.
2.  Since the device seems to be recognized by the system, I thought
I'd take a quick stab at seeing if it recognized a remote.  No matter
the protocol, the remote, or distance, neither ir-keytable or ir-ctl
(thanks for that tool!) wanted to register any signals.  So far I'm
chalking that up to the previous point.  Maybe it's possible that
communication is still hampered, even though the device can be
identified.  Sort out PCI, and maybe things start rolling.  I know the
receiver works, since I confirmed that with a test install of Windows
10 early on in this process.

Thanks for taking the time Sean.  I know you've got a lot of other
things on the go, so I really do appreciate it.

> > > Thanks
> > >
> > > Sean
> >
> > I've been using the latest ACPI Spec (6.3) to better comprehend the
> > macros, and what they should produce.  Running the DSDT through
> > acpiexec for \_SB.PCI0.CR00._CRS gives:
> >
> > - execute \_SB.PCI0.CR00._CRS
> > Evaluating \_SB.PCI0.CR00._CRS
> > 0x1 Outstanding allocations after evaluation of \_SB.PCI0.CR00._CRS
> > Evaluation of \_SB.PCI0.CR00._CRS returned object 0x562c4e9a9c90,
> > external buffer length 28
> > [Buffer] Length 10 =   0000: 47 01 80 06 80 06 01 08 22 00 04 2A 00 00
> > 79 00  // G......."..*..y.
> >
> > I'm still a little unclear on the first byte (47) and the last two (79
> > 00), generated presumably by ResourceTemplate(), but the rest seem to
> > match the expected results based on the inputs.  Aside from the
> > obvious difference in the address range length compared to the PN50's
> > BUF0, which seems to be the PN50's problem, the definition of BUF0 is
> > consistent.  I've even recompiled the DSDT with a length of 0x10 just
> > to see if that made a difference, and it doesn't.  Still no sign of
> > the driver in dmesg.  Although it would be nice to see the full CR00
> > definition for the PN50, it seems less likely that the problem lies
> > here.
> >
> > I've tried various acpi kernel debugging settings, but easily get
> > swamped with output.  Is there a process path somewhere that can be
> > followed to understand how the device goes through the ACPI process
> > and eventually gets picked up by the kernel?  I still feel like the
> > problem precedes the kernel's involvement.  The kernel obviously has
> > some degree of awareness of the DSDT entry, because I can find :
> >
> > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/ITE8708:00/
> >
> > The status is correct (0x0F), but under the physical_node, I have no
> > 'resources' entry.  Should there be one?  I have a 'resource' file,
> > but it only returns zeroes.
>
> This does _sound_ like an acpi issue, I've cc'ed linux-acpi@vger.kernel.org.
>
> > And instead of being linked to ite_cir (which is showing in lsmod, but
> > not used by anything), the driver ->
> > ../../../bus/pci/drivers/skl_uncore
> >
> > To me, that seems like it's processing what it has been presented, but
> > I've been wrong before.  I'm open for directions on where to
> > investigate next.
>
> This is not something I can help with, I'm afraid.
>
> Thanks,
>
> Sean
