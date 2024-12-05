Return-Path: <linux-acpi+bounces-9935-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B069E4E2C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 08:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C9F2853FD
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 07:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB341AC8A6;
	Thu,  5 Dec 2024 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICtjRC0l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDFF2770C
	for <linux-acpi@vger.kernel.org>; Thu,  5 Dec 2024 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383459; cv=none; b=t/1US2lfOvKYnEez7vthdsPYVY3XwTXqJCmgfjlH4IJAho4+651Z/Ep2gsx1WrKPcJOdO2fhHzLp5DCYYRq4p6vUU4PqszlhXrw+xisIFEe75CaAtLUkvqgFCoJHbXo035pculwFaNwrP9IBMYIJN5t9u3xtgqzIoMyHj37cV4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383459; c=relaxed/simple;
	bh=pSpEZVjdna42uoz1LPeVBGI8TwGgJsm0i3CG273qusE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tP1wJUmZhbe2xPTc3ZEzy8Wag2rDLQ0DLjS5BfOjDdW2K5nv9ZQjPofdIz5k60Xo0rOuNacxPADyb3M2mFUnX1m2PYwNr3tUWMm9u9mGc0nt1QbCgrtYV1WjDhWRM+dnJsH3U9GwJp8FMina6JD8GQfAdoB1i8ILdTnaRtJKb2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICtjRC0l; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2155c24a499so916025ad.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2024 23:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733383457; x=1733988257; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uWBGvCljzUDf0CoIOzQ08YHvBINRjNmeTAcURu1J7k=;
        b=ICtjRC0ltfjPNp8NZxYCy5MaVr4PELrnz/bjdWc3KIULBFOwFT6m+JauD1wUd+q00f
         PurRIEuIbkzKwm0kqiZ0d6BRGnaRqZ/mb7epod405yNBvseWITwWRAgeRWZ6ZANiqY+R
         P4p34fA0Y/iLMslzhXTnO21QqqMyibk7Uk1hwTU9rbunaHxSO8NzBfRwKqNAWfTJiDKk
         gjRHlZbIUrn8AArotQYpBDziU32O/veooUfGVIYUTMnn7zynxKsdoxbRNBGJmFUagRQb
         3zjxp9QPf7VPZ3cURhqSlPZWd2zEYFBaVHk70AQJJTZIms2p/Y7OVLyTQLP9Q247wmKc
         ZPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383457; x=1733988257;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uWBGvCljzUDf0CoIOzQ08YHvBINRjNmeTAcURu1J7k=;
        b=Bi4QRBQj2brtaIEAXlsUiDRdPLwJnwhLaCx+vE+H2uDGHt7Mbz4MY+l7/frC2YiQX9
         OP9RGIBmWC53GzRzemBZPxZbZi3Wklofgi0+MygeodQNMBWcPWcQMpDAZyHl92SDUPx4
         od4Jyt6I678DBttZgnCYvKGE5aHevSwudyeb2Qp2w+lyxUK6eF64D15TIojXG0Q5RmSi
         CIVYhhVsoTCYC5eM4Iro4mrEWpDaI+plxkB2po+UXNuUb9dleFR2Tnmwsu8p5KaesRT9
         yFE78GJ+zlIdhyFvOg0ISLbVN9SoWWLJZJTBkG+8kicdPTWwS8BKAe5zah5G0HQ4W2qh
         SdPw==
X-Forwarded-Encrypted: i=1; AJvYcCXwHpfH2BGq0r1tfIs00gGx4MtutmlVRCM0P3jAhOoS22Z4SG5OLXi8CrajnWJ6mGvAm7rLZgtw0zu9@vger.kernel.org
X-Gm-Message-State: AOJu0YypiGwFnqVqlvvUpEdGhqkIEE5t3FuvYkDdKqhUq5khb9IKc5zl
	jMpmXFHsc/X+uW+j8hnP4JF2eRh3XssQsrMrYg0Z4/sERaZiODVRQ5oC9w==
X-Gm-Gg: ASbGnctMiYXD5t0uRN9kzeiR24dIpBYTx8R/XvjG9VgdhJL8hLwcRnxLKOhvXm4nhe+
	v4t1Sm9UGjz/qs6OlbZB67E525E3+o9JcEQJrX7ntm8B55LnQ9ZKuFDQwX2FvKBCSVIAzpXySsE
	mdVyUHS2eFBHw6JLGwXWRl6JCX+2GljiiuUOMJaW5BFgF0D5cwsH23Zge85jWoJ9Ma68v70A9hs
	oSvkixFY8oTKvbY0KSs3T077VO2BDJ6j0lpQ5mK5t6c8eAsfibNUfHz+d80Nw==
X-Google-Smtp-Source: AGHT+IHMnRdtAVebYTwUYVXJ8tgaVff025+GCJvLUaXmK0v6X8Hb+LUSs5xEWv29Z7k7JLleW199BQ==
X-Received: by 2002:a17:903:2348:b0:215:a81b:42e1 with SMTP id d9443c01a7336-215bcfac5b8mr49060895ad.8.1733383456999;
        Wed, 04 Dec 2024 23:24:16 -0800 (PST)
Received: from smtpclient.apple ([2406:4440:0:105::41:a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f09151sm6437305ad.175.2024.12.04.23.24.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2024 23:24:16 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v3 2/7] ACPI: scan: Extract CSI-2 connection graph from
 _CRS
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <CAJZ5v0jeE=3-0ad7OMWETnhYfQE+fhw2dQTfYTmn=_6gDnDghQ@mail.gmail.com>
Date: Thu, 5 Dec 2024 15:23:59 +0800
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2D27B47A-A6EB-487C-8DEA-6792A0BAE886@gmail.com>
References: <4542595.LvFx2qVVIh@kreacher> <2927980.e9J7NaK4W3@kreacher>
 <C20272A3-65B5-4AAD-B6AD-0B93A95C5D93@gmail.com>
 <CAJZ5v0jeE=3-0ad7OMWETnhYfQE+fhw2dQTfYTmn=_6gDnDghQ@mail.gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)


> 2024=E5=B9=B412=E6=9C=884=E6=97=A5 03:44=EF=BC=8CRafael J. Wysocki =
<rafael@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi,
>=20
> Sorry for the delay.
>=20
> On Thu, Nov 21, 2024 at 10:57=E2=80=AFPM Miao Wang =
<shankerwangmiao@gmail.com> wrote:
>>=20
>> 2023=E5=B9=B411=E6=9C=887=E6=97=A5 00:09=EF=BC=8CRafael J. Wysocki =
<rjw@rjwysocki.net> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> +static acpi_status acpi_bus_check_add(acpi_handle handle, bool =
first_pass,
>>>                                    struct acpi_device **adev_p)
>>>  {
>>>      struct acpi_device *device =3D acpi_fetch_acpi_dev(handle);
>>> @@ -2054,9 +2059,25 @@ static acpi_status acpi_bus_check_add(ac
>>>              if (acpi_device_should_be_hidden(handle))
>>>                      return AE_OK;
>>>=20
>>> -            /* Bail out if there are dependencies. */
>>> -            if (acpi_scan_check_dep(handle, check_dep) > 0)
>>> -                    return AE_CTRL_DEPTH;
>>> +            if (first_pass) {
>>> +                    acpi_mipi_check_crs_csi2(handle);
>>> +
>>> +                    /* Bail out if there are dependencies. */
>>> +                    if (acpi_scan_check_dep(handle) > 0) {
>>> +                            /*
>>> +                             * The entire CSI-2 connection graph =
needs to be
>>> +                             * extracted before any drivers or scan =
handlers
>>> +                             * are bound to struct device objects, =
so scan
>>> +                             * _CRS CSI-2 resource descriptors for =
all
>>> +                             * devices below the current handle.
>>> +                             */
>>> +                            acpi_walk_namespace(ACPI_TYPE_DEVICE, =
handle,
>>> +                                                ACPI_UINT32_MAX,
>>> +                                                =
acpi_scan_check_crs_csi2_cb,
>>> +                                                NULL, NULL, NULL);
>>> +                            return AE_CTRL_DEPTH;
>>> +                    }
>>> +            }
>>>=20
>>>              fallthrough;
>>>      case ACPI_TYPE_ANY:     /* for ACPI_ROOT_OBJECT */
>>>=20
>>=20
>> Hi, I'd like to report some issues caused by this patch. Correct me =
if I'm wrong
>> since I'm not expert on ACPI. Before this patch, properties of ACPI =
devices with
>> _DEP relationship declared were evaluated after the initialization of =
the
>> depending devices, i.e. the execution of handler->attach(). With this =
patch,
>> _CRS of all the ACPI devices are evaluated to check if the device =
contains a
>> CSI2 resource, regardless of the declaration of _DEP relationship.
>=20
> Yes, but the _DEP information is not relevant for whether or not _CRS
> may be evaluated at all.
>=20
>> The evaluation of _CRS is even before _STA
>=20
> Not really.  _STA has already been evaluated by
> acpi_ns_init_one_device() for all devices at this point.

I quickly scanned the code in acpi_ns_init_one_device(), and it seems
that it an object does not have _INI method, then the _STA will not be
evaluated here.

>=20
>> and other methods indicating the status of the device.
>=20
> No, but it doesn't matter, at least by the spec.  Had the device been
> disabled, _CRS would have been expected to work anyway:
>=20
> "If a device is disabled, then _CRS returns a valid resource template
> for the device, but the actual resource assignments in the return byte
> stream are ignored." (ACPI 6.5, Section 6.2.2. _CRS (Current Resource
> Settings)).
>=20
> That said, adding a device status check before the _CRS evaluation in
> acpi_bus_check_add() is not inconceivable.
>=20
>> This has caused some issues in certain scenarios, where the DSDT =
contains legacy
>> devices, which requires reading IO ports to form the result of its =
_CRS. An
>> example of such a legacy device is declared in the DSDT is as below:
>>=20
>>    Device (LPT)
>>    {
>>        Name (_HID, EisaId ("PNP0400") /* Standard LPT Parallel Port =
*/)
>>        Name (_UID, 0x02)  // _UID: Unique ID
>>        Name (_DDN, "LPT1")  // _DDN: DOS Device Name
>>        Name (_DEP, Package (0x01)  // _DEP: Dependencies
>>        {
>>            \_SB.PCI0
>>        })
>>        OperationRegion (ITE1, SystemIO, 0x2E, 0x02)
>>        Field (ITE1, ByteAcc, NoLock, Preserve) {INDX, 8,   DATA, 8}
>>        IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
>>        {
>>            // Omitting some declarations of fields
>>            IOAH,   8,
>>            IOAL,   8,
>>        }
>>        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource =
Settings
>>        {
>>            Name (BUF0, ResourceTemplate ()
>>            {
>>                IO (Decode16,
>>                    0x0378,             // Range Minimum
>>                    0x0378,             // Range Maximum
>>                    0x01,               // Alignment
>>                    0x08,               // Length
>>                    _Y01)
>>                IRQ (Level, ActiveLow, Exclusive, _Y02)
>>                    {7}
>>            })
>>            CreateByteField (BUF0, \LPT._CRS._Y01._MIN, IOLO)
>>            CreateByteField (BUF0, 0x03, IOHI)
>>            CreateByteField (BUF0, \LPT._CRS._Y01._MAX, IORL)
>>            CreateByteField (BUF0, 0x05, IORH)
>>            CreateByteField (BUF0, \LPT._CRS._Y01._LEN, LEN1)
>>            CreateByteField (BUF0, \LPT._CRS._Y02._INT, IRQL)
>>=20
>>            IOLO =3D IOAL /* \LPT_.IOAL */
>>            IORL =3D IOAL /* \LPT_.IOAL */
>>            IOHI =3D IOAH /* \LPT_.IOAH */
>>            IORH =3D IOAH /* \LPT_.IOAH */
>>            // Omitting some assignments and calculations
>>=20
>>            Return (BUF0)
>>        }
>>    }
>>=20
>> On non-x86 platforms, IO ports are implemented using MMIO. The memory =
is
>> remapped in the initialization of the PCI root, using its QWordIO =
resource
>> declared in its _CRS, in acpi_pci_root_remap_iospace(). Before the
>> initialization of the PCI root, reads and writes of the IO ports will =
result in
>> accessing memory region which is not mapped.
>=20
> That's not really straightforward.
>=20
>> Before this patch, adding a _DEP of Package(){PCI0} to these legacy =
devices will
>> postpone the initialization of these devices after the PCI root, =
solving the
>> above problem. After this patch, however, the evaluation of _CRS =
regardless of
>> _DEP declarations causes accessing IO ports before they are ready.
>=20
> Well, before this patch, Linux simply did not have to evaluate _CRS
> during device discovery.
>=20
> Nowhere in the spec it is stated that _CRS cannot be evaluated for a
> given device before enumerating all devices listed by its _DEP object.
> As it is currently defined, _DEP is only about operation region
> dependencies, not even about general device enumeration ordering (even
> though it is used for enforcing specific enumeration ordering in the
> field because OSes tend to enumerate devices in the order following
> from _DEP as a matter of fact).
>=20
>> I've checked the ACPI spec, and it states that ``OSPM must guarantee =
that the
>> following operation regions are always accessible: SystemIO operation =
regions"
>=20
> Which to me is clearly at odds with the SystemIO implementation
> description above.
>=20
>> and ``Since the region types above are permanently available, no _REG =
methods
>> are required, nor will OSPM evaluate any _REG methods that appear in =
the same
>> scope as the operation region declaration(s) of these types". It =
seems that
>> from the view of the AML codes in the DSDT, it can never know when =
the IO ports
>> are ready, and it is impossible for Linux on non-x86 platforms to =
ensure IO
>> ports are always accessible.
>=20
> They aren't always accessible anyhow.  They become accessible after
> enumerating the PCI host bridge and they aren't accessible earlier.
>=20
>> I wonder if there would be a better solution to this problem.
>=20
> Well, it is a bit unfortunate that it took 6 kernel release cycles to
> realize that there was a problem.  Had this been reported earlier,
> there would have been more options on the table.

Yeah, since it is rare to keep a legacy device on non-X86 platforms,
and as a result, this issue is not discovered until now.

>=20
> At this point, the functionality related to CSI-2 connection graphs
> simply needs to be there, the only option for avoiding _CRS evaluation
> in acpi_bus_check_add() would be to somehow defer the enumeration of
> all devices using CSI-2 connections until the host bridge is
> enumerated.  Alternatively, the enumeration of the PCI host bridge
> might be pushed forward, but that would require addressing at least a
> few enumeration ordering issues.  None of these would be a small
> change and backporting any of that would have been a considerable
> effort.
>=20
> One of the things worth considering is whether or not CSI-2 is
> relevant for the architectures that rely on the old behavior related
> to _DEP.  If not at all, a Kconfig option could be added to disable
> CSI-2 graphs enumeration on those architectures and that would make
> the problem go away.

I'm not familiar with ACPI. However, in my personal point of view, it
seems that the root cause of the issue is in the ACPI standard, which
assumes SystemIO operation regions are always available, which is not
the case on non-X86 platforms. Also, there is no mechanism for the DSDT
code to know whether SystemIO operation regions are available, and it
is thus impossible to return ``a valid resource template" in the _CRS
method when SystemIO operation regions are unavailable. So it is not
the architectures that want to rely on the old behavior related to
_DEP, but all non-x86 architectures with ACPI support may have no
choice but to rely on this to postpone possible IO port operations after
the initialization of the PCI host bridge. However, on non-x86
architectures, there might be limited number of machines with devices
using legacy IO operations, so this issue is currently not so =
significant.

The documents for CSI-2 give me an impression that it is related to a
certain kind of camera, so I don't think it is good to remove this for
specific architectures.

> Also I'm wondering if the firmware could be updated to survive a mere
> evaluation of _CRS if the hardware is not ready.

If we only consider the current ACPI standard, I cannot come up with
a solution on the firmware side, as discussed before. But utilizing
(or abusing?) the current Linux implementation details, I managed to
work this around in this way:

Device (LPT)
{
    //...

    Name (STAD, Zero)
    Name (_DEP, Package (0x01)
    {
        \_SB.PCI0
    })

    Method (_STA, 0, NotSerialized)
    {
        STAD =3D One
        // other codes
    }
   =20
    Method (_CRS, 0, NotSerialized)
    {
        Name (BUF0,/*....*/)

        // Initialize BUF0

        If (STAD)
        {
            // do actual IO operations and fill BUF0 with actual
            // numbers
        }
       =20
        Return (BUF0)
    }
}

This work around is because I noticed the _STA method is called after
the depending PCI0 is initialized, so set a flag in the _STA method to
mark the availability of the IO port operations.

Maybe we can prioritize the initialization of the PCI host bridge to
fully eliminate this issue?

Cheers,

Miao Wang



