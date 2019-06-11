Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC8413D1E2
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2019 18:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391217AbfFKQLN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jun 2019 12:11:13 -0400
Received: from foss.arm.com ([217.140.110.172]:36918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388744AbfFKQLN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Jun 2019 12:11:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB679337;
        Tue, 11 Jun 2019 09:11:12 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05C143F73C;
        Tue, 11 Jun 2019 09:11:11 -0700 (PDT)
Date:   Tue, 11 Jun 2019 17:11:06 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Al Stone <ahs3@redhat.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH] ACPI / processors: allow a processor device _UID to
 be a string
Message-ID: <20190611160906.GA27548@e107155-lin>
References: <20190610200734.1182-1-ahs3@redhat.com>
 <20190611125258.GA16445@e107155-lin>
 <5ea4f403-853f-5067-4e9b-a8aabec5b1cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea4f403-853f-5067-4e9b-a8aabec5b1cd@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 11, 2019 at 10:03:15AM -0600, Al Stone wrote:
> On 6/11/19 6:53 AM, Sudeep Holla wrote:
> > On Mon, Jun 10, 2019 at 02:07:34PM -0600, Al Stone wrote:
> >> In the ACPI specification, section 6.1.12, a _UID may be either an
> >> integer or a string object.  Up until now, when defining processor
> >> Device()s in ACPI (_HID ACPI0007), only integers were allowed even
> >> though this ignored the specification.  As a practical matter, it
> >> was not an issue.
> >>
> >> Recently, some DSDTs have shown up that look like this:
> >>
> >>   Device (XX00)
> >>   {
> >> 	Name (_HID, "ACPI0007" /* Processor Device */)
> >>         Name (_UID, "XYZZY-XX00")
> >>         .....
> >>   }
> >>
> >> which is perfectly legal.  However, the kernel will report instead:
> >>
> >
> > I am not sure how this can be perfectly legal from specification
> > perspective. It's legal with respect to AML namespace but then the
> > other condition of this matching with entries in static tables like
> > MADT is not possible where there are declared to be simple 4 byte
> > integer/word. Same is true for even ACPI0010, the processor container
> > objects which need to match entries in PPTT,
> >
> > ACPI Processor UID(in MADT): The OS associates this GICC(applies even
> > for APIC and family) Structure with a processor device object in
> > the namespace when the _UID child object of the processor device
> > evaluates to a numeric value that matches the numeric value in this
> > field.
> >
> > So for me that indicates it can't be string unless you have some ways to
> > match those _UID entries to ACPI Processor ID in MADT and PPTT.
> >
> > Let me know if I am missing to consider something here.
> >
> > --
> > Regards,
> > Sudeep
> >
>
> Harumph.  I think what we have here is a big mess in the spec, but
> that is exactly why this is an RFC.
>
> The MADT can have any of ~16 different subtables, as you note.  Of
> those, only these require a numeric _UID:
>
>    -- Type 0x0: Processor Local APIC
>    -- Type 0x4: Local APIC NMI [0]
>    -- Type 0x7: Processor Local SAPIC [1]
>    -- Type 0x9: Processor Local x2APIC
>    -- Type 0xa: Local x2APIC NMI [0]
>    -- Type 0xb: GICC
>
> Note [0]: a value of !0x0 is also allowed, indicating all processors
>      [1]: this has two fields that could be interpreted as an ID when
>           used together
>
> It does not appear that you could build a usable system without any
> of these subtables -- but perhaps someone knows of incantations that
> could -- which is why I thought a string _UID might be viable.
>

I hope no one is shipping such device yet or am I wrong ?
We can ask them to fix as Linux simply can't boot on such system or
even if it boots, it may have issues with acpi_processor drivers.

> If we consider the PPTT too, then yeah, _UID must be an integer for
> some devices.
>
> Thanks for the feedback; it forced me to double-check my thinking about
> the MADT.  The root cause of the issue is not the kernel in this case,
> but a lack of clarity in the spec -- or at least implied requirements
> that probably need to be explicit.  I'll send in a spec change.
>

Completely agreed. Even little more clarification on this is helpful.
Thanks for volunteering :) to take up spec change, much appreciated.

--
Regards,
Sudeep
