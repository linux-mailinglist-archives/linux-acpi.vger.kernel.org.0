Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DA7241D1D
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Aug 2020 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgHKPZz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Aug 2020 11:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbgHKPZz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Aug 2020 11:25:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076AFC06174A;
        Tue, 11 Aug 2020 08:25:54 -0700 (PDT)
Date:   Tue, 11 Aug 2020 17:25:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597159552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/PoO99VsZeKU1ujq9T6uhiYphTk/6W+rjmcRTYfavM=;
        b=OQq/o6a5Bx1Ji03ydocv7ch7KSWm4fMb57nF9O4u+W7WHjdpA1p7/5vErU95SZcp8sSeem
        YfIeb8dzL7aqLON9otn+2W4/sA6QOxOfTU/7xm7ePP9jAVSyAccLFCWZ8TbG0oIZdBS9qv
        bCuronuAuzXQoaZjYzk32Q58lii2T9gT7fdY+MLj6548T7krvIYSr5aPNM02sZIRZWjE5U
        cRSBYMfDTkQWGs/Fqe+DxoZYfVaPzrX29jos2k2Xv39m/9NXcgnkiFCkiONfs55VNCsbm3
        eYR0dwqATsfVoOK6OfhuVs7GYkCIA/eZQgLKi/9Bp3XkMLcs4pJbFfAy6PZfSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597159552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/PoO99VsZeKU1ujq9T6uhiYphTk/6W+rjmcRTYfavM=;
        b=ZWVlbzQie0KOYgCV5rE8j6j0xagRISQi6y5u2cw+QUeHXip+3H8rVXV+qC70k/TFMS/Oaf
        a+jffPRt062k0vAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephen Berman <stephen.berman@gmx.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200811152551.dmfw46urecbmeklr@linutronix.de>
References: <87ftatqu07.fsf@gmx.net>
 <20200624201156.xu6hel3drnhno6c3@linutronix.de>
 <87ftak2kxr.fsf@rub.de>
 <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
 <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com>
 <20200714141135.47adndrsdgpiqfy4@linutronix.de>
 <87blkbx1gt.fsf@gmx.net>
 <87imdp5r80.fsf@rub.de>
 <20200811132955.wbt55ns7bu5mxouq@linutronix.de>
 <CAJZ5v0h+n9VCz5=VixVbe_b=ZbTU3D=46stGhE9z7Y7yaUMJzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJZ5v0h+n9VCz5=VixVbe_b=ZbTU3D=46stGhE9z7Y7yaUMJzw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-08-11 16:34:09 [+0200], Rafael J. Wysocki wrote:
> On Tue, Aug 11, 2020 at 3:29 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2020-08-11 13:58:39 [+0200], Stephen Berman wrote:
> > > him about your workaround of adding 'thermal.tzp=3D300' to the kernel
> > > commandline, and he replied that this works for him too.  And it turns
> > > out we have similar motherboards: I have a Gigabyte Z390 M Gaming
> > > Rev. 1001 board and he has Gigabyte Z390 Designare rev 1.0.
> >
> > Yes. Based on latest dmesg, the ACPI tables contain code which schedules
> > the worker and takes so long. It is possible / likely that his board
> > contains the same tables which leads to the same effect. After all those
> > two boards are very similar from the naming part :)
> > Would you mind to dump the ACPI tables and send them? There might be
> > some hints.
>=20
> Do we have a BZ for this?  It would be useful to open one if not.

no, it came via lkml and I looked at it since it was bisected to a
workqueue commit with my signoff=E2=80=A6
Stephen, can you open a bug on https://bugzilla.kernel.org/?

> > It might be possible that a BIOS update fixes the problem but I would
> > prefer very much to fix this in kernel to ensure that such a BIOS does
> > not lead to this problem again.
>=20
> I agree.
>=20
> It looks like one way to address this issue might be to add a rate
> limit for thermal notifications on a given zone.

So one thing is that ACPI says to poll every second and driver is doing
it. This could be increased to something like 15 or 30 seconds as lower
sane level. I don't think there is much value in polling this sensor
every second. As workaound, Stephen is using `thermal.tzp=3D300' now.=20

Would it make sense to flush the workqueue before checking the
temperature? I have no idea what the ACPI is doing there but there is no
upper limit on time how long in may take, right? Doing this inline (and
avoiding the worker) is probably causing other trouble, right?

Sebastian
