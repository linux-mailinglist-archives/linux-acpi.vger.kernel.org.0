Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EAB29939D
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Oct 2020 18:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775583AbgJZRVE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Oct 2020 13:21:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41252 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775598AbgJZRVB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Oct 2020 13:21:01 -0400
Date:   Mon, 26 Oct 2020 18:20:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603732858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oB2n0giDJAYWcKw6n8mDK9I+WY0T57Mwbrgg5zYcJr8=;
        b=ATG4oJgyAV4DEFqzfnJMN996aPUgxFF0bAxJJJCAg69n+GE65sj1guHIvG0ebZP6kEuS0/
        47NdWhos9vOYpkRJ/T43/0jFyJvJPlijs9M72pmq0C0dSkaNeMXTaLovHfJ78pQYZ8/C7Q
        8AHK52r/ICHohBylwDlBm6xppyy4/uxQQCw7MboAZ74ggglGT13WX+U2LnT6AYFvS/COPG
        ZZiW2WRW8Y/uafR7zycJLzKXGYrufJavlfAMoRu83JkS8aEJh6oP2EFYaRfeOjdh6mxSqD
        O0oIgaQuwYitvuMekguHmak/Sb6Dql6KPc+ZMZHSd8KGbYLT4XWFMhYwvq0EbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603732858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oB2n0giDJAYWcKw6n8mDK9I+WY0T57Mwbrgg5zYcJr8=;
        b=yIxacmqX5WVWewymSGWT965ZXKcgemXRgvUgqQv3ONw/IE6JrPOlQcLqfy8xBf41NaDzeY
        75rbpYz0KZ9acSDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Berman <stephen.berman@gmx.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20201026172057.h5toqoobiyhc4g3g@linutronix.de>
References: <20200714141135.47adndrsdgpiqfy4@linutronix.de>
 <87blkbx1gt.fsf@gmx.net>
 <87imdp5r80.fsf@rub.de>
 <20200811132955.wbt55ns7bu5mxouq@linutronix.de>
 <CAJZ5v0h+n9VCz5=VixVbe_b=ZbTU3D=46stGhE9z7Y7yaUMJzw@mail.gmail.com>
 <20200811152551.dmfw46urecbmeklr@linutronix.de>
 <87ft8tayic.fsf@gmx.net>
 <20200811184902.2fm4eyprmpkfon2j@linutronix.de>
 <20201006214927.4nsqtfji4fdv3oed@linutronix.de>
 <3fc9074b-c153-8446-0289-1e4dfab395eb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3fc9074b-c153-8446-0289-1e4dfab395eb@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-10-07 18:18:03 [+0200], Rafael J. Wysocki wrote:
> On 10/6/2020 11:49 PM, Sebastian Andrzej Siewior wrote:
> > On 2020-08-11 20:49:05 [+0200], To Stephen Berman wrote:
> > > On 2020-08-11 19:22:19 [+0200], Stephen Berman wrote:
> > > > Attached.
> > > ssdt6.dsl:
> > > |  ThermalZone (TZ10)
> > > |  {
> > > =E2=80=A6
> > > |      Method (_TSP, 0, Serialized)  // _TSP: Thermal Sampling Period
> > > |      {
> > > |          Return (0x0A)
> > > |      }
> > > |
> > > |      Method (_TZP, 0, Serialized)  // _TZP: Thermal Zone Polling
> > > |      {
> > > |          Return (0x0A)
> > > |      }
> > > |
> > > |      Method (_TMP, 0, Serialized)  // _TMP: Temperature
> > > |      {
> > > |          \GSA1.ZRC3 ()
> > > |          Sleep (0x03E8)
> > > |          Notify (\_TZ.TZ10, 0x81) // Thermal Trip Point Change
> > > |          Return (0x0B54)
> > > |      }
> > >=20
> > > So if I read this correctly then TZ10 should be polled every second
> > > (check) and the temperature function contains a `sleep(1 second)' (wh=
ich
> > > explains the mysteries delay) followed by the Notify() (which schedul=
es
> > > the worker).
> > >=20
> > > > Done as Bug 208877.
> > Rafael, do you have any suggestions?
>=20
> I've lost track of this sorry.
>=20
> I have ideas, let me get back to this next week.

:)

> Cheers!

Sebastian
