Return-Path: <linux-acpi+bounces-5717-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8008C218E
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 12:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446D3B20BE0
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 10:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F84165FA2;
	Fri, 10 May 2024 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHD6c9/m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD0E1635CA
	for <linux-acpi@vger.kernel.org>; Fri, 10 May 2024 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335482; cv=none; b=D3ydBKnUtOqOIcRM9KgHZtZJC7B7aPJSDfO+AOTUXGA9tTQ8dzPmnIZgioAMkd4pcIepdScKs/SSYvYv9kWyyf8w/FwS+reI8ZGVak5X+hrmaZBEZAJ+CfPU3bGtJV/Ixz23M3avRylkvRvkZOI14sJKoGTUtp82PXpk2dMYTDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335482; c=relaxed/simple;
	bh=CHCf0uw/N6+zw/SN3vL7seaXkyeM7zFhxetL/kB2gkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fW5+4VQkEh5j1uQaw0dufjh5Bu0HBlj37JyASM6bVsrmswCLKSWC4yFdUsjT9CNzJ7cr+wunhrKNQdX+wqsNHkbP4VUHFBOce6VFRLMGCyIv90QgX1SnLw3FYcRg19hu05Wprq6Bcwwo1vnrUQX52GZif+gAFzkqPKB1zFQ3J1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHD6c9/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACA4C2BD11
	for <linux-acpi@vger.kernel.org>; Fri, 10 May 2024 10:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715335482;
	bh=CHCf0uw/N6+zw/SN3vL7seaXkyeM7zFhxetL/kB2gkg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sHD6c9/m6zpLvZOfmRfCxDa7n8N7J35g+rCEs6BLh9pdWQEbXR3fn/K/rl4NbnQj1
	 OBB54TqZlK4oHbFknGmOHhg/o/ORnfmA1l9r/MbiimPh1wni38fhZyZXFD1nv0rT+q
	 FuE7UbGvXBk4rFQBXvEYgK5Veho7owojN+x9vIH9EugnRAMoyGYeXO+eNHGtMWaSde
	 F2KajtdtZpDIyF3AKogRseYXrfxGtSkVnb8Pj/aYcl0IaVmSSycFAfVs6dIGb76VdY
	 02DE9+6tKVWqXHKeTFDf3CnXohjq8jvtrDO6uZl97JVSFIvHdh/20WEZLYfSI8nWRa
	 LFEfrCZybV8dQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5af12f48b72so347482eaf.3
        for <linux-acpi@vger.kernel.org>; Fri, 10 May 2024 03:04:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+nElpu5AGiwxWonecdvGocz8oE1cH6u/ebHwY9XA6fkeNcC5DspH9vERTLW/1RspAnn5v2QsWAAADN5RKGZasEsV+QE9ADIv/pQ==
X-Gm-Message-State: AOJu0YyZLytSgVlUCYsh4eWssdFz30G2gaZtn+H52SyYjkRb5eH9hq4c
	Lyqre3J33MvbsLUwCmQMhxalE1zsawJzmZ1e/jBLF23Bn/Vap3IjmaxRkkotWCOGLG+nfoCCvnS
	EoRc2d+cnjlrH+/VtO9OpL1BDCX0=
X-Google-Smtp-Source: AGHT+IG1Y9HFozDKhIo4SZLjwSDbXM+oyLJS1xZypnhgw2n/m0+kvryiA/yM0tYaTCHM1i0RFvUViTTbZP2tBUV6SF8=
X-Received: by 2002:a4a:d692:0:b0:5b2:f29:93f0 with SMTP id
 006d021491bc7-5b2815e3c4dmr2313500eaf.0.1715335421881; Fri, 10 May 2024
 03:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zi+0whTvDbAdveHq@kuha.fi.intel.com> <CAJZ5v0iAMG251n6yg-h6KCUywK2vSg4sX3FTnOuxcLaEvUwFPQ@mail.gmail.com>
 <ZjtuKzqpfKFbRaUi@kuha.fi.intel.com> <5781917.DvuYhMxLoT@kreacher>
 <27722d8b-ecdc-40d4-af47-8150a8a0a2e6@redhat.com> <87c1a667-b0cc-46b7-b7a8-2baead94e456@gmx.de>
In-Reply-To: <87c1a667-b0cc-46b7-b7a8-2baead94e456@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 May 2024 12:03:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com>
Message-ID: <CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com>
Subject: Re: Missing default handler for the EmbeddedControl OpRegion
To: Armin Wolf <W_Armin@gmx.de>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:32=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 09.05.24 um 12:35 schrieb Hans de Goede:
>
> > Hi Rafael,
> >
> > On 5/8/24 2:50 PM, Rafael J. Wysocki wrote:
> >> [Resending because it appears to have got lost, sorry for duplicates.]
> >>
> >> On Wednesday, May 8, 2024 2:20:59 PM CEST Heikki Krogerus wrote:
> >>> On Mon, May 06, 2024 at 07:45:07PM +0200, Rafael J. Wysocki wrote:
> >>>> Hi,
> >>>>
> >>>> On Mon, Apr 29, 2024 at 4:55=E2=80=AFPM Heikki Krogerus
> >>>> <heikki.krogerus@linux.intel.com> wrote:
> >>>>> Hi,
> >>>>>
> >>>>> There's a bug that is caused by an EmbeddedControl OpRegion which i=
s
> >>>>> declared inside the scope of a specific USB Type-C device (PNP0CA0)=
:
> >>>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D218789
> >>>> And in this bug you are essentially proposing to install the EC
> >>>> OpRegion handler at the namespace root instead of the EC device.
> >>>>
> >>>> This sounds reasonable, although AFAICS this is a matter of modifyin=
g
> >>>> the EC driver (before the EC OpRegion handler is installed by the EC
> >>>> drvier, ACPICA has no way to handle EC address space accesses anyway=
).
> >>>>
> >>>>> It looks like that's not the only case where that OpRegion ID is us=
ed
> >>>>> outside of the EC device scope. There is at least one driver in Lin=
ux
> >>>>> Kernel (drivers/platform/x86/wmi.c) that already has a custom handl=
er
> >>>>> for the EmbeddedControl OpRegion, and based on a quick search, the
> >>>>> problem "Region EmbeddedControl (ID=3D3) has no handler" has happen=
ed
> >>>>> with some other devices too.
> >>>> AFAICS, installing the EC address space handler at the EC device
> >>>> object itself is not based on any sound technical arguments, it's ju=
st
> >>>> been always done this way in Linux.  It's quite possible that the EC
> >>>> address space handler should have been installed at the namespace ro=
ot
> >>>> from the outset.
> >>> Okay, thank you for the explanation. So can we simply change it like
> >>> this (I may have still misunderstood something)?
> >> Roughly speaking, yes, but it is missing an analogous change around
> >> the removal.
> >>
> >> Please see the appended patch (which I have created independently in
> >> the meantime).  It doesn't break stuff for me and Andy points out that
> >> there are examples of EmbeddedControl OpRegions outside the EC device
> >> scope in the spec (see Section 9.17.15 in ACPI 6.5, for instance).
> >>
> >> So I think that this change can be made relatively safely (but adding =
Hans and
> >> Mario to the CC in case they know something that might be broken by it=
).
> > +Cc Armin for WMI EC handler
> >
> > No objections from me against registering the EC handler at the root,
> > when I saw that the WMI driver was registering its own handler I was
> > already wondering why we did not just register the acpi/ec.c handler at
> > the root level but I did not have time to pursue this further.
> >
> > One question which I have is does the drivers/acpi/ec.c version handle
> > read/writes of a width other then 8 bits ? Armin recently added support
> > for other widths to the WMI version of the OpRegion handler to fix
> > issues on some laptop models:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dc663b26972eae7d2a614f584c92a266fe9a2d44c
> >
> > Regards,
> >
> > Hans
>
> Hi,
>
> the handling of multi-byte reads/writes was taken from the ec driver itse=
lf, so
> using the standard ec handler should make no difference for the WMI drive=
r.

Thanks for the confirmation!

So AFAICS acpi_wmi_ec_space_handler() will not be necessary after this
change, but so long as it is installed by acpi_wmi_probe(), it will be
used for opregions in the WMI device scope, so I'd prefer to remove it
in a separate patch to avoid making too many changes in one go.

Let me add a changelog to the patch posted here

https://lore.kernel.org/linux-acpi/5781917.DvuYhMxLoT@kreacher/

and submit it properly along with a separate change removing
acpi_wmi_ec_space_handler().

