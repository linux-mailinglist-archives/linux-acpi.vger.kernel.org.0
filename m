Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32ACD3727C1
	for <lists+linux-acpi@lfdr.de>; Tue,  4 May 2021 11:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhEDJFa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 May 2021 05:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhEDJF3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 May 2021 05:05:29 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E7DC061574;
        Tue,  4 May 2021 02:04:00 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id BCC38C645F; Tue,  4 May 2021 10:03:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1620119038; bh=EU8m/i/aDn4a1obGPTuutqZXKT0XejSop5WCsofK7+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=diC3HZ5+3cqoNkwOTBfBXnNvH3M90GYCezwXrvR37rWPTOTAsTtLPvwXtGwOUPEWO
         zzgzdNVhyCkIP5Jo+KirsxX4w7A3MenvDnGcZuS2jFpMBWmN7JTrg8AB9FF+8htay4
         cVis3XroUUezJ6iikRTRGGUsysJhGPlmb6yjpTTMpa5kQx0PDrvXxzJHStzHbzbFCX
         DnZ3xZvL0GyuBbwNLGG7y10kPO5DQhaTd3xYgRW0qjP9QMJCc5O2sV36YRae+iVHWj
         ljUYbBtIp6Kiu8btvyFr0aVdQM8sD+lyJfpmdYtC2Uw8DGkdHCqbYZ/EGM1xJ5eiYp
         yiBQBEwCFfMBQ==
Date:   Tue, 4 May 2021 10:03:58 +0100
From:   Sean Young <sean@mess.org>
To:     Chris McCrae <chrismccraeworks@gmail.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: Asus PN62S vs PN50 - ITE8708
Message-ID: <20210504090358.GA26800@gofer.mess.org>
References: <CAN2W0iNOsa6GYK28Vz=DmkyjY72H_bq=8EUkzFuy0_p9ZVms4A@mail.gmail.com>
 <20210503092005.GB14939@gofer.mess.org>
 <CAN2W0iME8VCdP=KdcH8PW7ZfEOdQJicKWQmE675-h3cd2=D1cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN2W0iME8VCdP=KdcH8PW7ZfEOdQJicKWQmE675-h3cd2=D1cA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Chris,

On Mon, May 03, 2021 at 11:44:04AM -0400, Chris McCrae wrote:
> Thanks for answering the call Sean.
> 
> On Mon, 3 May 2021 at 05:20, Sean Young <sean@mess.org> wrote:
> >
> > Hi Chris,
> >
> > On Fri, Apr 30, 2021 at 07:37:10PM -0400, Chris McCrae wrote:
> > > Recently acquired an Asus PN62S (Intel) as a media centre frontend
> > > (currently testing with Xubuntu 20.04 and a 5.10 kernel, and the most
> > > current BIOS available).  Having an integrated IR was part of the
> > > selling features.  However, getting it to be recognized by my system
> > > has become a challenge that I am getting obsessed with.  There's very
> > > little to find online on this device that is current, but there has
> > > been some recent conversation on this list about the same device, on a
> > > related machine, the PN50 (AMD).  I'm hoping that the knowledge here
> > > may lead to a solution for my issue.
> > >
> > > I can provide more detail on request, but at the moment I am focusing
> > > on the DSDT as a possible suspect.  I do not have the 16 byte issue
> > > that the PN50 experiences.  Mine is defined as 8 bytes, which is
> > > compatible with the ite-cir driver.  My issue is that there appears to
> > > be no attempt to bind the device to the driver (but it is visible in
> > > lsmod)... no messages about the driver in dmesg at all.  My thought is
> > > that the definition of the device in DSDT may somehow give it enough
> > > information (ITE8708) to know the driver could be needed, but not the
> > > correct information to make it work.
> > >
> > > An earlier message provided only part of the device definition in DSDT
> > > for the PN50.  I would like to be able to see the full definition for
> > > it from the PN50, to see if anything is significantly different.
> > > Ideally, if I had the full DSDT as a starting point, I could compare
> > > other areas such as motherboard resources.
> >
> > It would be great if we could see the entries for the IR device in your
> > DSDT. There is a guide here https://wiki.archlinux.org/title/DSDT on
> > how to do that.
> >
> Here the full device from the DSDT:
> 
>             Device (CR00)
>             {
>                 Name (_ADR, Zero)  // _ADR: Address
>                 Name (VBAN, 0x0680)
>                 Name (VIRQ, 0x0A)
>                 Name (UIDN, Zero)
>                 Name (_HID, EisaId ("ITE8708"))  // _HID: Hardware ID
>                 Method (_UID, 0, NotSerialized)  // _UID: Unique ID
>                 {
>                     Return (UIDN) /* \_SB_.PCI0.CR00.UIDN */
>                 }
> 
>                 Method (_STA, 0, Serialized)  // _STA: Status
>                 {
>                     If ((CIRE == Zero))
>                     {
>                         Return (Zero)
>                     }
>                     Return (0x0F)
>                 }
> 
>                 Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
>                 {
>                     Name (BUF0, ResourceTemplate ()
>                     {
>                         IO (Decode16,
>                             0x0000,             // Range Minimum
>                             0x0000,             // Range Maximum
>                             0x01,               // Alignment
>                             0x08,               // Length
>                             _Y10)
>                         IRQNoFlags (_Y11)
>                             {}
>                         DMA (Compatibility, NotBusMaster, Transfer8, )
>                             {}
>                     })
>                     CreateWordField (BUF0,
> \_SB.PCI0.CR00._CRS._Y10._MIN, IOPL)  // _MIN: Minimum Base Address
>                     CreateWordField (BUF0,
> \_SB.PCI0.CR00._CRS._Y10._MAX, IOPH)  // _MAX: Maximum Base Address
>                     CreateWordField (BUF0,
> \_SB.PCI0.CR00._CRS._Y11._INT, IRQ)  // _INT: Interrupts
>                     IOPL = VBAN /* \_SB_.PCI0.CR00.VBAN */
>                     IOPH = VBAN /* \_SB_.PCI0.CR00.VBAN */
>                     IRQ = (One << VIRQ) /* \_SB_.PCI0.CR00.VIRQ */
>                     Return (BUF0) /* \_SB_.PCI0.CR00._CRS.BUF0 */
>                 }
>             }

Hmm this is not really telling us everything yet. Would you mind sending
on the entire dmesg please?

> > Thanks
> >
> > Sean
> 
> I've been using the latest ACPI Spec (6.3) to better comprehend the
> macros, and what they should produce.  Running the DSDT through
> acpiexec for \_SB.PCI0.CR00._CRS gives:
> 
> - execute \_SB.PCI0.CR00._CRS
> Evaluating \_SB.PCI0.CR00._CRS
> 0x1 Outstanding allocations after evaluation of \_SB.PCI0.CR00._CRS
> Evaluation of \_SB.PCI0.CR00._CRS returned object 0x562c4e9a9c90,
> external buffer length 28
> [Buffer] Length 10 =   0000: 47 01 80 06 80 06 01 08 22 00 04 2A 00 00
> 79 00  // G......."..*..y.
> 
> I'm still a little unclear on the first byte (47) and the last two (79
> 00), generated presumably by ResourceTemplate(), but the rest seem to
> match the expected results based on the inputs.  Aside from the
> obvious difference in the address range length compared to the PN50's
> BUF0, which seems to be the PN50's problem, the definition of BUF0 is
> consistent.  I've even recompiled the DSDT with a length of 0x10 just
> to see if that made a difference, and it doesn't.  Still no sign of
> the driver in dmesg.  Although it would be nice to see the full CR00
> definition for the PN50, it seems less likely that the problem lies
> here.
> 
> I've tried various acpi kernel debugging settings, but easily get
> swamped with output.  Is there a process path somewhere that can be
> followed to understand how the device goes through the ACPI process
> and eventually gets picked up by the kernel?  I still feel like the
> problem precedes the kernel's involvement.  The kernel obviously has
> some degree of awareness of the DSDT entry, because I can find :
> 
> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/ITE8708:00/
> 
> The status is correct (0x0F), but under the physical_node, I have no
> 'resources' entry.  Should there be one?  I have a 'resource' file,
> but it only returns zeroes.

This does _sound_ like an acpi issue, I've cc'ed linux-acpi@vger.kernel.org.

> And instead of being linked to ite_cir (which is showing in lsmod, but
> not used by anything), the driver ->
> ../../../bus/pci/drivers/skl_uncore
> 
> To me, that seems like it's processing what it has been presented, but
> I've been wrong before.  I'm open for directions on where to
> investigate next.

This is not something I can help with, I'm afraid.

Thanks,

Sean
