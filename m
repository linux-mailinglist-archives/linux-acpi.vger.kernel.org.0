Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BF02D473B
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Dec 2020 17:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgLIQyP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Dec 2020 11:54:15 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:34430 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgLIQyI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2020 11:54:08 -0500
Received: by mail-oo1-f65.google.com with SMTP id t63so546561ooa.1
        for <linux-acpi@vger.kernel.org>; Wed, 09 Dec 2020 08:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2pLLZPe7ZhoOhjW9gte+/owQO3MfPR0ltpqAb8lgrWY=;
        b=tN7+EkkMoNWJJoztP/mk9aYP+12z3hUitmJjqw9AdHuZGcowyPQHgWYlBFOqljSQHs
         y/P3zCbUZaZHyE9IZkevDdtxFEUAYfTb9MSfSxIDvXfnp9ypPmdnuH2osK0gGlnIO6Rl
         F53oQS8DEUeZZh5NDh5Gw5iUu6md2qNN5WOetj/PX615txUIPeRV+2eaNnIIj39qJwcg
         +TLTzsZ0heCFhE8ztqFMMFMmD5Kkk8JSlEq9zwcCGXDSjhkaTakfafYknO/aQPeK4HZ0
         b1P8h08JHb0FZjegZuD098QaYjnj69o7Ew6VbMCMCURKQJagkl6p/5YJw83/ZSQG36ja
         tAow==
X-Gm-Message-State: AOAM530CUJ5Pftm6U8Zio5lBfcvgZ5Z6/ojyi+CuwT3LEsJfy6KZFLZh
        vurYrwkOMJRwztZhojZ7sLsn/b3qTsfK8eFb0Ks=
X-Google-Smtp-Source: ABdhPJwUK86ipo5kqfBcYfY/zn1KDP7EIQ7h8sqt1apV3H+yecVOmBMRkQoB379r0eqZg3phwZedyWW84w84qE27+ZE=
X-Received: by 2002:a4a:abc9:: with SMTP id o9mr2638197oon.1.1607532807177;
 Wed, 09 Dec 2020 08:53:27 -0800 (PST)
MIME-Version: 1.0
References: <1409ba0c-1580-dc09-e6fe-a0c9bcda6462@gmail.com>
 <858bb2b0-e2b4-f0d4-0088-7106fec3cb8f@gmail.com> <9a9c176c-8991-cd12-d2da-34114a9d1aca@gmail.com>
 <CAJZ5v0gsAP1k2ej_5mgK5P_2rLn_GeMbjX9=-BG_die-6WmitA@mail.gmail.com> <529a22f7-52ba-f87d-f82b-8f94e1637ca9@gmail.com>
In-Reply-To: <529a22f7-52ba-f87d-f82b-8f94e1637ca9@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Dec 2020 17:53:16 +0100
Message-ID: <CAJZ5v0jy=WecHEQFzfu++uENWerHf5GqfwZMYNjQ2V=H7Geq8Q@mail.gmail.com>
Subject: Re: acpi_device_notify() binding devices that don't seem like they
 should be bound
To:     Daniel Scally <djrscally@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 9, 2020 at 5:20 PM Daniel Scally <djrscally@gmail.com> wrote:
>
> Hi Rafael
>
> On 09/12/2020 15:43, Rafael J. Wysocki wrote:
> > On Wed, Dec 9, 2020 at 10:55 AM Daniel Scally <djrscally@gmail.com> wrote:
> >>
> >>
> >> On 08/12/2020 23:48, Daniel Scally wrote:
> >>> Hello again
> >>>
> >>> On 06/12/2020 00:00, Daniel Scally wrote:
> >>>> INT3472:08 is not an acpi device that seems to be a good candidate for
> >>>> binding to 0000:00:00.0; it just happens to be the first child of
> >>>> PNP0A08:08 that shares _ADR 0 and has _STA not set to 0.
> >>>>
> >>>> The comment within acpi_find_child_device() does imply that there should
> >>>> only ever be a single child device with the same _ADR as the parent, so
> >>>> I suppose this is possibly a case of poor ACPI tables confusing the code
> >>>> a bit; given both PNP0A08:00 and _all_ of the INT3472 devices have _ADR
> >>>> set to zero (as indeed do the machine's cameras), but I'm not
> >>>> knowledgeable enough on ACPI to know whether that's to spec (or at least
> >>>> accounted for). The INT3472 devices themselves do not actually seem to
> >>>> represent a physical device (atleast, not in this case...sometimes they
> >>>> do...), rather they're a dummy being used to simply group some GPIO
> >>>> lines under a common _CRS. The sensors are called out as dependent on
> >>>> these "devices" in their _DEP method, which is already a horrible way of
> >>>> doing things so more broken ACPI being to blame wouldn't surprise me.
> >>>>
> >>>> The other problem that that raises is that there seems to be _no_ good
> >>>> candidate for binding to 0000:00:00.0 that's a child of PNP0A08:00 - the
> >>>> only devices sharing _ADR 0 and having _STA != 0 are those two INT3472
> >>>> entries and the machine's cameras.
> >>> After some more reading, I'm pretty confident that this is the problem
> >>> now - I.E. that those devices having _ADR of 0 is what's causing this
> >>> issue to materialise, and that those values should be set to something
> >>> more appropriate. Still unsure about the best approach to fix it though
> >>> from a kernel point of view; there doesn't seem to be anything out of
> >>> whack in the logic, and I believe (correct me if I'm wrong) there can be
> >>> legitimate instances of child devices sharing _ADR=0 with the parent, so
> >>> the problem becomes how to identify the illegitimate instances so that
> >>> they can be discarded. My experience in this is really limited, so I
> >>> lean towards the conclusion that hard-coding exceptions somewhere might
> >>> be necessary to handle this without resorting to patched ACPI tables.
> >>> Whether that's within acpi_find_child_device() to prevent matching
> >>> occurring there, or else setting the adev->pnp.bus_address to some
> >>> alternate value after creation to compensate.
> >>>
> >>> I recognise that that's a horrible answer though, so I'm really hoping
> >>> that someone has an idea for how to handle this in a better way.
> >> Oops, missed this crucial line from the spec:
> >>
> >> "A device object must contain either an _HID object or an _ADR object,
> >> but should not contain both."
> >>
> >> And here's the Device declaration for these objects:
> >>
> >>         Device (PMI0)
> >>         {
> >>             Name (_ADR, Zero)  // _ADR: Address
> >>             Name (_HID, "INT3472")  // _HID: Hardware ID
> >>             Name (_CID, "INT3472")  // _CID: Compatible ID
> >>             Name (_DDN, "INCL-CRDD")  // _DDN: DOS Device Name
> >>             Name (_UID, Zero)  // _UID: Unique ID
> >>
> >> So that's the broken part rather than the _ADR value of 0 specifically.
> >> That at least gives a jumping off point for some logic to fix rather
> >> than a hardcoded anything, so I'll try to work out a nice way to handle
> >> that (probably ignoring adevs in acpi_find_child_device() with addr=0
> >> and a valid _HID) and submit a patch.
> > Please see the comment in find_child_checks(), though - it kind of
> > tries to handle this case already.
> It down-weights them currently yes, but does still allow them to match.
> I think it makes more sense to not allow a match at all, at least in the
> situation I've encountered, but I suppose the implication of the logic
> in this check is that at some point we've encountered ACPI entries with
> both _HID and _ADR that were potentially correct matches, which kinda
> re-complicates things again.

That's correct.

> > I guess what happens is that _STA is not present under the device that
> > is expected to be matched, so maybe the logic regarding this may be
> > changed somewhat.
>
> Hmm yeah I guess so, so this is kinda a combination of two problems
> probably. And if the actual device that is expected to match had a _STA
> > 0 then presumably the down-weighting of devices with a _HID in
> find_child_checks() would ensure the correct dev was matched.

That's the intended outcome.

We may need another value (between the min and the max) to return when
adev->pnp.type.platform_id is not set and _STA is not present.
