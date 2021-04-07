Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210F235738C
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 19:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhDGRuw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Apr 2021 13:50:52 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:36846 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhDGRut (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Apr 2021 13:50:49 -0400
Received: by mail-ot1-f47.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso18914233otq.3
        for <linux-acpi@vger.kernel.org>; Wed, 07 Apr 2021 10:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdty5jjF0kS1KwBKOuQvO5jA//0hz0U6KtPzoR/QqC0=;
        b=pmcvqce5F4PCfwfL2TVBPb6WhBX+rBxaRR57L8YL9lUge0L5ZUnKRMW5eLv8h9F3X/
         pqFWHirFoG96s/nEYdmFufRLncSgmVcmm/XtHfWTLubg6ntQWYM533RWytqzJQIcASWs
         g19HT2znYJFhK6y6QYCKcH4k0bqaQBReNUW8ZpkM0AtnPaGl2MKi5x9wkBBIDiWrKVlC
         H6oLxYf8LFayvrgG2/TKmYfYsdoBZBaUrkGFPNj5a1uRyenvAZ4BNJ+quqmb25mDpXIM
         4cwMrCOhOYp/9bdQ5gfD3Zp8oQGQ4KCu3sSOau+kV8obvg8nSA3S5QGqsjQiHNCZIvLK
         gb0Q==
X-Gm-Message-State: AOAM5325MN2ehkRg8cSdXDptVnp4pGqibhyMYsIN5oD4woNQ9kfqXGsj
        XmmPALV0QNz/Wm0n3xj1WDvnaHxASUnl6mKNOOg=
X-Google-Smtp-Source: ABdhPJwnCImGe3rSYixT+YE7sfW6UlSVvDtUH3js1QA8mRWJZ38+30nMtWs8HCdr+aM8unuUy8A7zowxSyroEI3vg4A=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr4025696otr.321.1617817838050;
 Wed, 07 Apr 2021 10:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210406211653.182338-1-hdegoede@redhat.com> <CAJZ5v0h6=_U+_=G8YL5rA701pTLGfyg4PmBudc3tFRKG=Wxh4A@mail.gmail.com>
 <4e796690-0a45-77e9-6b5d-61b3efa4b301@redhat.com>
In-Reply-To: <4e796690-0a45-77e9-6b5d-61b3efa4b301@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Apr 2021 19:50:27 +0200
Message-ID: <CAJZ5v0jYUA8GHqYvnkp=Q0fzMKcsXtuZ-RcSS3jc_exKjtsewA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: utils: Add acpi_reduced_hardware() helper
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 7, 2021 at 7:43 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 4/7/21 7:13 PM, Rafael J. Wysocki wrote:
> > On Tue, Apr 6, 2021 at 11:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Add a getter for the acpi_gbl_reduced_hardware variable so that modules
> >> can check if they are running on an ACPI reduced-hw platform or not.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>  drivers/acpi/utils.c    | 11 +++++++++++
> >>  include/acpi/acpi_bus.h |  1 +
> >>  include/linux/acpi.h    |  5 +++++
> >>  3 files changed, 17 insertions(+)
> >>
> >> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> >> index 682edd913b3b..4cb061d3169a 100644
> >> --- a/drivers/acpi/utils.c
> >> +++ b/drivers/acpi/utils.c
> >> @@ -872,6 +872,17 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
> >>  }
> >>  EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
> >>
> >> +/**
> >> + * acpi_reduced_hardware - Return if this is an ACPI-reduced-hw machine
> >> + *
> >> + * Return true when running on an ACPI-reduced-hw machine, false otherwise.
> >> + */
> >> +bool acpi_reduced_hardware(void)
> >> +{
> >> +       return acpi_gbl_reduced_hardware;
> >> +}
> >> +EXPORT_SYMBOL(acpi_reduced_hardware);
> >
> > EXPORT_SYMBOL_GPL()?
>
> Yes, that was my intention, no idea what happened here.
>
> Before I send a v2, do you have any remarks on patch 2/2 (which is actually
> the more interesting patch) ?

I thought that basing that check on the ACPICA's global variable may
be too coarse grained for some cases, but then I've decided to do it
as is now and we'll see.

No need to resend that one.
