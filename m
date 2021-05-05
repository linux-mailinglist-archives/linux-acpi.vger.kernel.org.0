Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835D1374A07
	for <lists+linux-acpi@lfdr.de>; Wed,  5 May 2021 23:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhEEVTq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 May 2021 17:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhEEVTp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 May 2021 17:19:45 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B858C061574;
        Wed,  5 May 2021 14:18:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s25so4366981lji.0;
        Wed, 05 May 2021 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=djoC0Z+pmOInDICvyUS0uOVicy3QU7aVQXXHVWM84O0=;
        b=KlG5H+3gT4FHDGnwoyJgdPxK4ZvPmKaM1z1/+POFbQBQVwq0qfH+qjfLEli+8k3oI+
         K26t69SuxEYSCQm3n21ABT0Dn0IfHPqpLo5mVaNBXYXqCXCnvrM6kghqgpyuZ/+Y9ut6
         k7J/ydiE13Rc20ehyBU4RJ8KQdbj//zZqgPWiNzMQqsQjM91HKmbM/Xo1tGixfbh308e
         N37qhph+7OcT3tSXz+BjBXNKFaiwmS/7wvrtJmox8cVEMOJSG6L2Ge7IPbrvh9CSVczH
         HMwbwFNd1QMIM7Ejl3Vp8kpu1s0G9tcIzuf+hpxJiqwdVf6wze9jyRkzQZe+j4bd54Ut
         nCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djoC0Z+pmOInDICvyUS0uOVicy3QU7aVQXXHVWM84O0=;
        b=Yx99pLs7Zuqw7qTkR7nNBmTB+wcxmaf4vpCwtnFEfABVYI2jJUlm39BAveVukBg0O3
         w2Zh1fTY27+Na+7gRmlo6XXXjz2pB3tk/eMis8sMNay1ZwOvie29E4fpGFiwtByEmAs5
         WjnyiaJgZe1/gvAntkIK/WF6m334YVbsUekXdwYRNQlFMym4CNr8dHNJtJvdruRgzv+g
         NDpn0MWUc+bu+ls5Jb9CRPeAOM2aaUqNWMUcRS8xx+iZBfYOmgU+IouJTgvLklCb3WXr
         Tjx2k9yMUa4X5WNbPm/Py3LGQCCLNzTUkp3zbW0PinjtTFxlTxq3M6GzjyuiUKkltU+F
         hm/Q==
X-Gm-Message-State: AOAM532UgGUbGkiJHvynQyaKttABFOPMhHt80Xe4HcdBtbTIyY/hfce2
        bOsLIri1amnTi0gBSIZz4Yq+nkvpoeyA9sKOlSKgqL1RoIfHig==
X-Google-Smtp-Source: ABdhPJw3/kv8oLy/NRWhoUI59OvqC/6ZUpwH5Hyeq+ZDu+nF9esyATskAj6fsTm7SQJYUDWJ6CwHm8LVYUZRup1T19Y=
X-Received: by 2002:a2e:2419:: with SMTP id k25mr604828ljk.266.1620249526714;
 Wed, 05 May 2021 14:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAN2W0iNOsa6GYK28Vz=DmkyjY72H_bq=8EUkzFuy0_p9ZVms4A@mail.gmail.com>
 <20210503092005.GB14939@gofer.mess.org> <CAN2W0iME8VCdP=KdcH8PW7ZfEOdQJicKWQmE675-h3cd2=D1cA@mail.gmail.com>
 <20210504090358.GA26800@gofer.mess.org> <CAN2W0iPsovnGnEZFsQi5wmERVM20hb3TsW1sRb-OfwH0mXh_pg@mail.gmail.com>
In-Reply-To: <CAN2W0iPsovnGnEZFsQi5wmERVM20hb3TsW1sRb-OfwH0mXh_pg@mail.gmail.com>
From:   Chris McCrae <chrismccraeworks@gmail.com>
Date:   Wed, 5 May 2021 17:18:35 -0400
Message-ID: <CAN2W0iPo=kxJmkcPP9+p2nH_T+fyZ8KVFO4ehc8UOeK5A9O=Lg@mail.gmail.com>
Subject: Re: Asus PN62S vs PN50 - ITE8708
To:     Sean Young <sean@mess.org>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 4 May 2021 at 23:52, Chris McCrae <chrismccraeworks@gmail.com> wrote:
>
> On Tue, 4 May 2021 at 05:03, Sean Young <sean@mess.org> wrote:
> >
> > Hi Chris,
> >
> > On Mon, May 03, 2021 at 11:44:04AM -0400, Chris McCrae wrote:
> > > Thanks for answering the call Sean.
> > >
> > > On Mon, 3 May 2021 at 05:20, Sean Young <sean@mess.org> wrote:
> > > >
> > > > Hi Chris,
> > > >
> > > > On Fri, Apr 30, 2021 at 07:37:10PM -0400, Chris McCrae wrote:
> > > > > Recently acquired an Asus PN62S (Intel) as a media centre frontend
> > > > > (currently testing with Xubuntu 20.04 and a 5.10 kernel, and the most
> > > > > current BIOS available).  Having an integrated IR was part of the
> > > > > selling features.  However, getting it to be recognized by my system
> > > > > has become a challenge that I am getting obsessed with.  There's very
> > > > > little to find online on this device that is current, but there has
> > > > > been some recent conversation on this list about the same device, on a
> > > > > related machine, the PN50 (AMD).  I'm hoping that the knowledge here
> > > > > may lead to a solution for my issue.
> > > > >
> > > > > I can provide more detail on request, but at the moment I am focusing
> > > > > on the DSDT as a possible suspect.  I do not have the 16 byte issue
> > > > > that the PN50 experiences.  Mine is defined as 8 bytes, which is
> > > > > compatible with the ite-cir driver.  My issue is that there appears to
> > > > > be no attempt to bind the device to the driver (but it is visible in
> > > > > lsmod)... no messages about the driver in dmesg at all.  My thought is
> > > > > that the definition of the device in DSDT may somehow give it enough
> > > > > information (ITE8708) to know the driver could be needed, but not the
> > > > > correct information to make it work.
> > > > >
> > > > > An earlier message provided only part of the device definition in DSDT
> > > > > for the PN50.  I would like to be able to see the full definition for
> > > > > it from the PN50, to see if anything is significantly different.
> > > > > Ideally, if I had the full DSDT as a starting point, I could compare
> > > > > other areas such as motherboard resources.
> > > >
> > > > It would be great if we could see the entries for the IR device in your
> > > > DSDT. There is a guide here https://wiki.archlinux.org/title/DSDT on
> > > > how to do that.
> > > >
> > > Here the full device from the DSDT:
> > >
> > >             Device (CR00)
> > >             {
> > >                 Name (_ADR, Zero)  // _ADR: Address
> > >                 Name (VBAN, 0x0680)
> > >                 Name (VIRQ, 0x0A)
> > >                 Name (UIDN, Zero)
> > >                 Name (_HID, EisaId ("ITE8708"))  // _HID: Hardware ID
> > >                 Method (_UID, 0, NotSerialized)  // _UID: Unique ID
> > >                 {
> > >                     Return (UIDN) /* \_SB_.PCI0.CR00.UIDN */
> > >                 }
> > >
> > >                 Method (_STA, 0, Serialized)  // _STA: Status
> > >                 {
> > >                     If ((CIRE == Zero))
> > >                     {
> > >                         Return (Zero)
> > >                     }
> > >                     Return (0x0F)
> > >                 }
> > >
> > >                 Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
> > >                 {
> > >                     Name (BUF0, ResourceTemplate ()
> > >                     {
> > >                         IO (Decode16,
> > >                             0x0000,             // Range Minimum
> > >                             0x0000,             // Range Maximum
> > >                             0x01,               // Alignment
> > >                             0x08,               // Length
> > >                             _Y10)
> > >                         IRQNoFlags (_Y11)
> > >                             {}
> > >                         DMA (Compatibility, NotBusMaster, Transfer8, )
> > >                             {}
> > >                     })
> > >                     CreateWordField (BUF0,
> > > \_SB.PCI0.CR00._CRS._Y10._MIN, IOPL)  // _MIN: Minimum Base Address
> > >                     CreateWordField (BUF0,
> > > \_SB.PCI0.CR00._CRS._Y10._MAX, IOPH)  // _MAX: Maximum Base Address
> > >                     CreateWordField (BUF0,
> > > \_SB.PCI0.CR00._CRS._Y11._INT, IRQ)  // _INT: Interrupts
> > >                     IOPL = VBAN /* \_SB_.PCI0.CR00.VBAN */
> > >                     IOPH = VBAN /* \_SB_.PCI0.CR00.VBAN */
> > >                     IRQ = (One << VIRQ) /* \_SB_.PCI0.CR00.VIRQ */
> > >                     Return (BUF0) /* \_SB_.PCI0.CR00._CRS.BUF0 */
> > >                 }
> > >             }
> >
> > Hmm this is not really telling us everything yet. Would you mind sending
> > on the entire dmesg please?
> >
>
> I could send dmesg output, but aside from the fact that it's almost
> 1000 lines, I have just had a moderate degree of success.  Using the
> pci=noacpi kernel option, gives me:
>
> [    1.767176] ite_cir: Auto-detected model: ITE8708 CIR transceiver
> [    1.767177] ite_cir: Using model: ITE8708 CIR transceiver
> [    1.767178] ite_cir: TX-capable: 1
> [    1.767179] ite_cir: Sample period (ns): 8680
> [    1.767180] ite_cir: TX carrier frequency (Hz): 38000
> [    1.767180] ite_cir: TX duty cycle (%): 33
> [    1.767181] ite_cir: RX low carrier frequency (Hz): 0
> [    1.767182] ite_cir: RX high carrier frequency (Hz): 0
> [    1.840766] rc rc0: ITE8708 CIR transceiver as /devices/virtual/rc/rc0
> [    1.840842] rc rc0: lirc_dev: driver ite-cir registered at minor =
> 0, raw IR receiver, raw IR transmitter
> [    1.840881] input: ITE8708 CIR transceiver as /devices/virtual/rc/rc0/input3
> [    1.844915] ite_cir: driver has been successfully loaded
>
> So after a couple of weeks, I should be happier, right?  Never seen
> any of these lines before.  I am happy that there's progress, but some
> things still aren't right.
>
> 1.  The kernel option will be used to focus my debugging efforts.  At
> least this seems to support the idea that ACPI plays a role in this.
> I was beginning to lose faith in that idea.
> 2.  Since the device seems to be recognized by the system, I thought
> I'd take a quick stab at seeing if it recognized a remote.  No matter
> the protocol, the remote, or distance, neither ir-keytable or ir-ctl
> (thanks for that tool!) wanted to register any signals.  So far I'm
> chalking that up to the previous point.  Maybe it's possible that
> communication is still hampered, even though the device can be
> identified.  Sort out PCI, and maybe things start rolling.  I know the
> receiver works, since I confirmed that with a test install of Windows
> 10 early on in this process.

Getting happier :-)  I have at least a work-around for each of my two
points of contention.

For #1.  Having ruled out IRQ as an area of interest, looked at PCI
enumeration.  After some reading, on a bit of a whim, I changed device
\_SB.PCI0.CR00._ADR from Zero to One in my custom DSDT.  Now the
driver shows up without having to use pci=noacpi.  In fact, I tested
addresses from 0x01 to 0x0F, and all produced driver loading results.
So I can make this work with a custom DSDT, however I don't know if
this is the correct/accurate fix, or did 2 ugly bugs just have a
beautiful child?  I'd like to know and understand the true solution,
plus I'd like to at least try to feed some sort of realistic
information to ASUS to perhaps make its way into a future BIOS
revision.  Should I start a new thread on linux-acpi with this more
pointed question?

For #2.  This seems to be mostly the common Linux gotcha of
permissions.  Once I added the user to the groups 'input' and 'video'
I started to see results.  Plus the barebones kernel I had made (to
save compile time and have a huge log buffer) was missing most of the
protocols.  Once I added the user to the groups, rebooted with the
full kernel sporting a custom DSDT, ir-keytable and ir-ctl both had
lots to say.

Thanks again.

Chris

>
> Thanks for taking the time Sean.  I know you've got a lot of other
> things on the go, so I really do appreciate it.
>
> > > > Thanks
> > > >
> > > > Sean
> > >
> > > I've been using the latest ACPI Spec (6.3) to better comprehend the
> > > macros, and what they should produce.  Running the DSDT through
> > > acpiexec for \_SB.PCI0.CR00._CRS gives:
> > >
> > > - execute \_SB.PCI0.CR00._CRS
> > > Evaluating \_SB.PCI0.CR00._CRS
> > > 0x1 Outstanding allocations after evaluation of \_SB.PCI0.CR00._CRS
> > > Evaluation of \_SB.PCI0.CR00._CRS returned object 0x562c4e9a9c90,
> > > external buffer length 28
> > > [Buffer] Length 10 =   0000: 47 01 80 06 80 06 01 08 22 00 04 2A 00 00
> > > 79 00  // G......."..*..y.
> > >
> > > I'm still a little unclear on the first byte (47) and the last two (79
> > > 00), generated presumably by ResourceTemplate(), but the rest seem to
> > > match the expected results based on the inputs.  Aside from the
> > > obvious difference in the address range length compared to the PN50's
> > > BUF0, which seems to be the PN50's problem, the definition of BUF0 is
> > > consistent.  I've even recompiled the DSDT with a length of 0x10 just
> > > to see if that made a difference, and it doesn't.  Still no sign of
> > > the driver in dmesg.  Although it would be nice to see the full CR00
> > > definition for the PN50, it seems less likely that the problem lies
> > > here.
> > >
> > > I've tried various acpi kernel debugging settings, but easily get
> > > swamped with output.  Is there a process path somewhere that can be
> > > followed to understand how the device goes through the ACPI process
> > > and eventually gets picked up by the kernel?  I still feel like the
> > > problem precedes the kernel's involvement.  The kernel obviously has
> > > some degree of awareness of the DSDT entry, because I can find :
> > >
> > > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/ITE8708:00/
> > >
> > > The status is correct (0x0F), but under the physical_node, I have no
> > > 'resources' entry.  Should there be one?  I have a 'resource' file,
> > > but it only returns zeroes.
> >
> > This does _sound_ like an acpi issue, I've cc'ed linux-acpi@vger.kernel.org.
> >
> > > And instead of being linked to ite_cir (which is showing in lsmod, but
> > > not used by anything), the driver ->
> > > ../../../bus/pci/drivers/skl_uncore
> > >
> > > To me, that seems like it's processing what it has been presented, but
> > > I've been wrong before.  I'm open for directions on where to
> > > investigate next.
> >
> > This is not something I can help with, I'm afraid.
> >
> > Thanks,
> >
> > Sean
