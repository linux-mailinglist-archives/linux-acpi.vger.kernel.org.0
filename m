Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E67E2D45B2
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Dec 2020 16:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgLIPn6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Dec 2020 10:43:58 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46857 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgLIPn4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2020 10:43:56 -0500
Received: by mail-oi1-f195.google.com with SMTP id k2so2113167oic.13
        for <linux-acpi@vger.kernel.org>; Wed, 09 Dec 2020 07:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9LrxAhyj7mPRx7hIEuiOchklAm6pj6kbffvw5W5WgY=;
        b=NrIC/s/N8rOeURcszBSE3ICFP8tJMS8A00FJdwoWPcRtGeAhw9gfoik2OuZsS/5ZuU
         JIf3y0I/MnCvhV4Cs1qyh9NojU+MpFUHeFSFWXxlr29S9L3Y1qYGEvcVpx3pVoxvbAk+
         m6iqY66Sz1DH/3rkTqAw5J8ebjJHvoq6PO15aNkvduxQWWdJLfikufnie2Jz9W4IV1C5
         vSY79Wjs9mBvZBOLaEgPBzg+jjcEtxlimhfL5gXKyLYU5JUXSbpBIch4QS6MmexB7NAg
         SXSA4Jm/AKnRFW3DsWiVpMFTQQc+Tm9Y4B0+rf8QERnA5sJVt5Z8HkwpMYutYpezyv2h
         xVNQ==
X-Gm-Message-State: AOAM533Xa7dZaDQr8W9oxO6f0H2k1ZtChonWQFI5C4wCtvravHRW+K9E
        PXlufSN7PF0+lEnl7Vkz3Zv9zB/kCfCJAN9UpUY=
X-Google-Smtp-Source: ABdhPJwBT7xFjtK2R5tXR80q04XuX4SaKCEiaAckw/1wpLPAzDUp9XHpWhnmZ6JtcsF9djur4k1S1P08kdjsLHmCIDA=
X-Received: by 2002:aca:5197:: with SMTP id f145mr2188245oib.71.1607528595309;
 Wed, 09 Dec 2020 07:43:15 -0800 (PST)
MIME-Version: 1.0
References: <1409ba0c-1580-dc09-e6fe-a0c9bcda6462@gmail.com>
 <858bb2b0-e2b4-f0d4-0088-7106fec3cb8f@gmail.com> <9a9c176c-8991-cd12-d2da-34114a9d1aca@gmail.com>
In-Reply-To: <9a9c176c-8991-cd12-d2da-34114a9d1aca@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Dec 2020 16:43:04 +0100
Message-ID: <CAJZ5v0gsAP1k2ej_5mgK5P_2rLn_GeMbjX9=-BG_die-6WmitA@mail.gmail.com>
Subject: Re: acpi_device_notify() binding devices that don't seem like they
 should be bound
To:     Daniel Scally <djrscally@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 9, 2020 at 10:55 AM Daniel Scally <djrscally@gmail.com> wrote:
>
>
>
> On 08/12/2020 23:48, Daniel Scally wrote:
> > Hello again
> >
> > On 06/12/2020 00:00, Daniel Scally wrote:
> >> INT3472:08 is not an acpi device that seems to be a good candidate for
> >> binding to 0000:00:00.0; it just happens to be the first child of
> >> PNP0A08:08 that shares _ADR 0 and has _STA not set to 0.
> >>
> >> The comment within acpi_find_child_device() does imply that there should
> >> only ever be a single child device with the same _ADR as the parent, so
> >> I suppose this is possibly a case of poor ACPI tables confusing the code
> >> a bit; given both PNP0A08:00 and _all_ of the INT3472 devices have _ADR
> >> set to zero (as indeed do the machine's cameras), but I'm not
> >> knowledgeable enough on ACPI to know whether that's to spec (or at least
> >> accounted for). The INT3472 devices themselves do not actually seem to
> >> represent a physical device (atleast, not in this case...sometimes they
> >> do...), rather they're a dummy being used to simply group some GPIO
> >> lines under a common _CRS. The sensors are called out as dependent on
> >> these "devices" in their _DEP method, which is already a horrible way of
> >> doing things so more broken ACPI being to blame wouldn't surprise me.
> >>
> >> The other problem that that raises is that there seems to be _no_ good
> >> candidate for binding to 0000:00:00.0 that's a child of PNP0A08:00 - the
> >> only devices sharing _ADR 0 and having _STA != 0 are those two INT3472
> >> entries and the machine's cameras.
> >
> > After some more reading, I'm pretty confident that this is the problem
> > now - I.E. that those devices having _ADR of 0 is what's causing this
> > issue to materialise, and that those values should be set to something
> > more appropriate. Still unsure about the best approach to fix it though
> > from a kernel point of view; there doesn't seem to be anything out of
> > whack in the logic, and I believe (correct me if I'm wrong) there can be
> > legitimate instances of child devices sharing _ADR=0 with the parent, so
> > the problem becomes how to identify the illegitimate instances so that
> > they can be discarded. My experience in this is really limited, so I
> > lean towards the conclusion that hard-coding exceptions somewhere might
> > be necessary to handle this without resorting to patched ACPI tables.
> > Whether that's within acpi_find_child_device() to prevent matching
> > occurring there, or else setting the adev->pnp.bus_address to some
> > alternate value after creation to compensate.
> >
> > I recognise that that's a horrible answer though, so I'm really hoping
> > that someone has an idea for how to handle this in a better way.
>
> Oops, missed this crucial line from the spec:
>
> "A device object must contain either an _HID object or an _ADR object,
> but should not contain both."
>
> And here's the Device declaration for these objects:
>
>         Device (PMI0)
>         {
>             Name (_ADR, Zero)  // _ADR: Address
>             Name (_HID, "INT3472")  // _HID: Hardware ID
>             Name (_CID, "INT3472")  // _CID: Compatible ID
>             Name (_DDN, "INCL-CRDD")  // _DDN: DOS Device Name
>             Name (_UID, Zero)  // _UID: Unique ID
>
> So that's the broken part rather than the _ADR value of 0 specifically.
> That at least gives a jumping off point for some logic to fix rather
> than a hardcoded anything, so I'll try to work out a nice way to handle
> that (probably ignoring adevs in acpi_find_child_device() with addr=0
> and a valid _HID) and submit a patch.

Please see the comment in find_child_checks(), though - it kind of
tries to handle this case already.

I guess what happens is that _STA is not present under the device that
is expected to be matched, so maybe the logic regarding this may be
changed somewhat.

> Sorry for the noise, think I'm good now :)

OK
