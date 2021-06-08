Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50A139FAAA
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 17:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhFHP3h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 11:29:37 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:35375 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhFHP3g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 11:29:36 -0400
Received: by mail-oi1-f169.google.com with SMTP id v22so21918412oic.2
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jun 2021 08:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNwqdF6FkF+jEphsav1OW8cGD9Z3o0y9RutUW9W683k=;
        b=nAHCul9o2WOflGZ+9cLkKBgJSj4Tnyu3/2X3CVw1b5RoerbD+iMId/I6WJ7RMXdZiG
         vsgqizH8KieMXQvJS9wsCmTyxrtYO6j2BPFU31cJj0I6yLTLmw9gcZiL0ZkOL0FlQLYd
         yO3Dy74XKVG5CGSLsfPqm9faw8Et0ZEkpGAbgcHkRXqqWlIxOkVLpEYBCJ960eBWNk9R
         OKccY9B+7UIUmXsvaR9SwLHb3cBE9AVzC/xRD1EizI1VTB43Ri75YtrNDg86zUFSV3Wr
         OFklkR8NhE8Ao9v0mNYYYFMCeUUqWvmVH0ovMzE6VLBl9CLszv5N5UpGJnD+8PNfTG9K
         uj4w==
X-Gm-Message-State: AOAM531cleY0h1KHxmzkTdCj5NufULsarFqtVOypOjtLGr0xcguM+7Sv
        GoNmiEiWC5ewJ42plXQWiMEY2jZDRDFy82HAdn0=
X-Google-Smtp-Source: ABdhPJw77ZfVxI0LUmBlUzwfJDe5Gk5EiRp2mgYf1qRMoU0+3AGGWi6PwFORKPY+Iw1IzD/mf56Jnwn6i9dg404tClo=
X-Received: by 2002:aca:650d:: with SMTP id m13mr3242674oim.157.1623166063480;
 Tue, 08 Jun 2021 08:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210607173156.5548-1-mario.limonciello@amd.com>
 <20210608053546.GA14116@lst.de> <CAJZ5v0gMgwJ9kq_mo_dYoTUAqQzhXmrgp9wnY4TRPU1pJp=TyQ@mail.gmail.com>
 <556a22c7-58af-b9d4-d50c-25d7d16bd344@amd.com>
In-Reply-To: <556a22c7-58af-b9d4-d50c-25d7d16bd344@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Jun 2021 17:27:32 +0200
Message-ID: <CAJZ5v0jwjSruQ1OYNyuJ=3UJA5LJW1-fGSw3Jy8jhRFfXasTuQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] ACPI: Move check for _DSD StorageD3Enable property
 to acpi
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        rrangel@chromium.org, David Box <david.e.box@linux.intel.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal-bakulchandra.Shah@amd.com,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Prike Liang <prike.liang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 8, 2021 at 4:18 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 6/8/2021 06:20, Rafael J. Wysocki wrote:
> > On Tue, Jun 8, 2021 at 7:35 AM Christoph Hellwig <hch@lst.de> wrote:
> >>
> >> On Mon, Jun 07, 2021 at 12:31:55PM -0500, Mario Limonciello wrote:
> >>> +/**
> >>> + * acpi_storage_d3 - Check if a storage device should use D3.
> >
> > Let's be specific about what D3 means here in the first place and
> > that's D3hot AFAICS.
> >
> > And the comment should be something like "Check whether or not to use
> > D3hot in the suspend path".
>
> Actually it can be D3hot or D3cold.  Microsoft's documentation doesn't
> indicate it's D3hot.  On the AMD platforms that prompted some of these
> changes it's D3cold.

So say "D3" in the one-line description above and "D3hot or D3cold (if
supported)" in the more detailed comment below.

> >
> >>> + * @dev: Device to check
> >>> + *
> >>> + * Returns %true if @dev should be put into D3 when the ->suspend method is
> >>> + * called, else %false.  The name of this function is somewhat misleading
> >>> + * as it has nothing to do with storage except for the name of the ACPI
> >>> + * property.  On some platforms resume will not work if this hint is ignored.
> >
> > I would write it this way:
> >
> > "Return %true if the platform firmware wants @dev to be programmed
> > into D3hot in the suspend path, or %false when there is no specific
> > preference. On some platforms, if this hint is ignored, @dev may
> > remain unresponsive after suspending the platform as a whole."
> >
> > And I'm not sure if it is necessary to mention "storage" in this comment at all.
> >
>
> Is your thought here in not mentioning "storage" that this symbol may be
> overloaded in the future to look at more than just the StorageD3Enable
> property and used for other things too?

Well, the property itself is not about storage any more anyway.
