Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C6E2D1105
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 13:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgLGMvh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 07:51:37 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34103 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgLGMvh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 07:51:37 -0500
Received: by mail-ot1-f66.google.com with SMTP id h19so12334641otr.1;
        Mon, 07 Dec 2020 04:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vxn1tTZc/iLRRR28SNO5T7qO/7J056/TEEpSwu6MIsQ=;
        b=g6K1kTOH95UcrsORF05wzx6MYT2GpdRXR8BHAiJiz7jKK5QjL0ZEz2pCKi8VvrS6Rt
         s9Rbe3nqZ7M68THoG51AOymTjbtLAztoz8vBX2BS2XgZKMiBaOlOtoTK4pe9UFgqNcLH
         7BYF7WVeKHp/2exKxQ7mr903gEWnLEx0QaYXBHRsL3yHdPP4uhCgmFwk+8OmFYzo6TMF
         Qml0y+enrQXdCFyn8++kRpiJ88L+tSsfZwNxY0IZbF1RZnCfELCHV8hnxH1NFJFbEZqF
         XVbx6uE7LINsrBq/J5L6e66QyYuy5IAZSyh5j0O8E6tLDW225kpHVxLsD7f3aYOKCiaW
         raSg==
X-Gm-Message-State: AOAM533y1dUETx+yL4biKebCcTS6YY2IZRtWy6831c/Oxzn0YoN3cn40
        nMz0kiqRmB2p/NHyajfuWzvR1B1070SgQgTLo1Y=
X-Google-Smtp-Source: ABdhPJzzpSAY68jEGm78o/tNi9pHSz9tYgXHA+KZEZK7PIa13OARX5x/q5c+wksETK2AQU8pvsCjPi3NXRl115RVbYo=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr5903659otn.321.1607345456056;
 Mon, 07 Dec 2020 04:50:56 -0800 (PST)
MIME-Version: 1.0
References: <3849919.JfvvSOo2yN@kreacher> <52a2b98c-6bf3-760b-eca9-93cf05fb4877@redhat.com>
In-Reply-To: <52a2b98c-6bf3-760b-eca9-93cf05fb4877@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Dec 2020 13:50:39 +0100
Message-ID: <CAJZ5v0hwUdsrG4AS_TJimN2ON+fOGP=tWRbTiqaWeY0vEX2-Kw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Add PNP0D80 to the _DEP exceptions list
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Dec 5, 2020 at 7:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12/5/20 4:29 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The PNP0D80 ("Windows-compatible System Power Management Controller")
> > device ID is used for identifying the special device object providing
> > the LPI (Low-power S0 Idle) _DSM interface [1].  That device object
> > does not supply any operation regions, but it appears in _DEP lists
> > for other devices in the ACPI tables on some systems to enforce
> > specific enumeration ordering that does not matter in Linux.
> >
> > For this reason, _DEP list entries pointing to the device object whose
> > _CID returns PNP0D80 need not be taken into account as real operation
> > region dependencies, so add that device ID to the list of device IDs
> > for which the matching _DEP list entries should be ignored.
> >
> > Accordingly, update the function used for matching device IDs in that
> > list to allow it to check _CID as well as _HID and rename it to
> > acpi_info_matches_ids().
> >
> > Link: https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf # [1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thank you for doing this, I contemplated doing the exact same
> thing but never got around to it.
>
> One small review remark inline:
>
> > ---
> >  drivers/acpi/scan.c |   27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/scan.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -719,25 +719,40 @@ int acpi_device_add(struct acpi_device *
> >  /* --------------------------------------------------------------------------
> >                                   Device Enumeration
> >     -------------------------------------------------------------------------- */
> > -static bool acpi_info_matches_hids(struct acpi_device_info *info,
> > -                                const char * const hids[])
> > +static bool acpi_info_matches_ids(struct acpi_device_info *info,
> > +                               const char * const ids[])
> >  {
> > +     struct acpi_pnp_device_id_list *cid_list = NULL;
> >       int i;
> >
> >       if (!(info->valid & ACPI_VALID_HID))
> >               return false;
> >
> > -     for (i = 0; hids[i]; i++) {
> > -             if (!strcmp(info->hardware_id.string, hids[i]))
> > +     if (info->valid & ACPI_VALID_CID)
> > +             cid_list = &info->compatible_id_list;
> > +
> > +     for (i = 0; ids[i]; i++) {
> > +             int j;
> > +
> > +             if (!strcmp(info->hardware_id.string, ids[i]))
> >                       return true;
> > +
> > +             if (!cid_list)
> > +                     continue;
> > +
> > +             for (j = 0; j < cid_list->count; j++) {
> > +                     if (!strcmp(cid_list->ids[j].string, ids[i]))
> > +                             return true;
> > +             }
> >       }
> >
> >       return false;
> >  }
> >
> >  /* List of HIDs for which we ignore matching ACPI devices, when checking _DEP lists. */
> > -static const char * const acpi_ignore_dep_hids[] = {
> > +static const char * const acpi_ignore_dep_ids[] = {
> >       "INT3396", /* Windows System Power Management Controller */
>
> I think this one can be dropped now, I checked my acpidump / dsdt.dsl
> collection and 45/45 DSDTs declaring a _HID of INT3396 also added a _CID of
> PNP0D80 to this.

Sure, in a separate patch.

Thanks!
