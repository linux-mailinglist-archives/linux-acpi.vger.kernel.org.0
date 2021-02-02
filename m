Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699DE30C118
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 15:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhBBOMg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 09:12:36 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:33362 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbhBBOKv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 09:10:51 -0500
Received: by mail-oi1-f180.google.com with SMTP id j25so22884949oii.0;
        Tue, 02 Feb 2021 06:10:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYfGir+nbz/4ZTAALmTVXRO3TLfJBR8+o48CtPhExRw=;
        b=Cgy1Dq+CHDk3gfHmsmxzSsva2eRg0CPB9jLbbMqPNn5lNfHqaXDqKyWInJuYk1VlMM
         jf/2SW4VwXDOZxeBIK+OoEdZ9VpwvYGyqoPNA4uI+eWk2AWMdXNAqN1X2AIW0h7PhcMb
         lbkVJ4NIoPk+juHs9YRUVszCENUjU2b/3u/iOz0OcGd+fdLAXz8gGUBIJ9GrCyQbokX+
         josWlh0I9QaW4E356QtWHWT4oAJDp3XBlV1E+iQ85qPVSh1MiryZy19cM1aiUMbGKE8i
         PBp1m2ADSFAbIS0JHorx8ZSM6dU4GKsEOv8BXYGsl3vLeLd9ADZqnVMU72O4V4DgHgzf
         U+rA==
X-Gm-Message-State: AOAM533aUt8JXn+ORg6O7lbrlXgO/OQrWPvBa/vNdVlNmf8TLzRCUlYo
        HPkYHN6q2fCaPhed6NieC8mrJFvU5kowOdPamkA=
X-Google-Smtp-Source: ABdhPJzgzScfdhBlOTPsbrFqaBpBr46DpQwcwDV7GmB4WTMc+WTLZh24M0uZH+0WkkBRRQw/nRLNDeRsRq174H0X7Sc=
X-Received: by 2002:aca:308a:: with SMTP id w132mr2641367oiw.69.1612275009533;
 Tue, 02 Feb 2021 06:10:09 -0800 (PST)
MIME-Version: 1.0
References: <2367702.B5bJTmGzJm@kreacher> <1996712.1aSbzQgNOC@kreacher>
 <ab62890a1128b0d3109553208379015fcb36e0c7.camel@perches.com>
 <CAJZ5v0hoPLKe9mVY_mJgFrcLSdutTd-UFGJS11pu8qDzemy43w@mail.gmail.com> <d1064a357d80e2df3e78de1119f23c6f60ee1a50.camel@perches.com>
In-Reply-To: <d1064a357d80e2df3e78de1119f23c6f60ee1a50.camel@perches.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Feb 2021 15:09:57 +0100
Message-ID: <CAJZ5v0jBXoG01Yoqyryb3aJTagXR3JCufuA7fcfRrLZU+4TETQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] ACPI: battery: Clean up printing messages
To:     Joe Perches <joe@perches.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 2, 2021 at 2:38 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2021-02-01 at 19:44 +0100, Rafael J. Wysocki wrote:
> > On Mon, Feb 1, 2021 at 7:37 PM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Mon, 2021-02-01 at 19:16 +0100, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Replace the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
> > > > in battery.c with acpi_handle_debug() and acpi_handle_info() calls,
> > > > respectively, drop the _COMPONENT and ACPI_MODULE_NAME() definitions
> > > > that are not used any more, drop the no longer needed
> > > > ACPI_BATTERY_COMPONENT definition from the headers and update the
> > > > documentation accordingly.
> > > >
> > > > While at it, update the pr_fmt() definition and drop the unneeded
> > > > PREFIX sybmbol definition from battery.c.
> > > []
> > > > --- linux-pm.orig/drivers/acpi/battery.c
> > > []
> > > > @@ -466,7 +460,8 @@ static int extract_package(struct acpi_b
> > > >  static int acpi_battery_get_status(struct acpi_battery *battery)
> > > >  {
> > > >       if (acpi_bus_get_status(battery->device)) {
> > > > -             ACPI_EXCEPTION((AE_INFO, AE_ERROR, "Evaluating _STA"));
> > > > +             acpi_handle_info(battery->device->handle,
> > > > +                              "_STA evaluation failed\n");
> > >
> > > I believe this changes the logging level from KERN_ERR to KERN_INFO.
> > >
> > > Perhaps this and others should instead use acpi_handle_err()
> >
> > Actually, these log level changes, because the messages in question
> > are not very urgent.
> >
> > Something doesn't work and it's kind of good to know that, but there's
> > not much that can be done about it.
>
> That more argues for removal of KERN_<LEVEL> filtering.
>
> I fail to see how difficult it is to change these to the existing
> KERN_<LEVEL> using a simple acpi_handle_info() -> acpi_handle_err()
> substitution where appropriate.

I'm not really sure what you mean.

It is not a technical problem, but in my view the KERN_ERR log level
is excessive for these messages.

> At a minimum, the commit message should note the KERN_<LEVEL> changes.

OK, let me update the changelogs, then.
