Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30C7304C99
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 23:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbhAZWtR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 17:49:17 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:45131 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389318AbhAZRni (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2021 12:43:38 -0500
Received: by mail-oi1-f169.google.com with SMTP id g69so18566376oib.12;
        Tue, 26 Jan 2021 09:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJ72xtQb/apq7ktVmUZOoZF5gi4XecKFdTaYGhNBH1o=;
        b=G8HAIBEMbfRA1Lvv8mz0UOgtChZ02cBia3FPsb4lG7mwO0wIrhJTj//c0l8vTaKOnp
         66BC9CHqGtnVhrI6JT1+5XQeTThvRUmmUHmWUfu4VZvArKKSIUI2Uq+f5T1DBTKlpeRB
         3UTR33iMJ/ug5yO6I50aTAWuCTPsr+1v3dCLQdTS1KYAooNouchm7aAvTg4+ZBqu/9Sh
         GCRmLDsLQ+vedpYQEpMXAHZy3aGoU7MnLy73yR2QxkzeIAoVZwQkS2SDQu5JURlKq9g1
         pOBnQyUUCjOBXDHaFVLPHHU5JiWt7mNgEBMm6ih0e4nUbhv8MsxGsYUf7iwDGbGnYK/B
         XxPQ==
X-Gm-Message-State: AOAM530IUaRNKyTQ+jRALz3zdF/64typ4+zu6ObI3ocWXYDE4k558knX
        +FY1pcaAZKafCiR2bWqhUyDVm40cZiPwfkpiVTM=
X-Google-Smtp-Source: ABdhPJylvthRLeFRbGztWeYc0cUy11nuCi6H60NlqbHxtdh9KLhNIYag2aaGhLRgWpYiWmPTrEXmT2vnCDGZ4qm3e1E=
X-Received: by 2002:aca:fc84:: with SMTP id a126mr526298oii.71.1611682977103;
 Tue, 26 Jan 2021 09:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
 <20210126155723.9388-5-mika.westerberg@linux.intel.com> <CAJZ5v0i+wCOFZOhyx6i=TUGMeWyQR4vXzDN06G6xheFwC66Tuw@mail.gmail.com>
 <SA1PR19MB4926907D028D3F924FF42A36FABC9@SA1PR19MB4926.namprd19.prod.outlook.com>
In-Reply-To: <SA1PR19MB4926907D028D3F924FF42A36FABC9@SA1PR19MB4926.namprd19.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jan 2021 18:42:46 +0100
Message-ID: <CAJZ5v0hQ_JZVfOpSZY0hxc01He9x7uzgU2rsKffmQubaeKy=EA@mail.gmail.com>
Subject: Re: [PATCH 4/6] ACPI: Execute platform _OSC also with query bit clear
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 6:37 PM Limonciello, Mario
<Mario.Limonciello@dell.com> wrote:
>
> > On Tue, Jan 26, 2021 at 5:01 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > From: Mario Limonciello <mario.limonciello@dell.com>
> > >
> > > The platform _OSC can change the hardware state when query bit is not
> > > set. According to ACPI spec it is recommended that the OS runs _OSC with
> > > query bit set until the platform does not mask any of the capabilities.
> > > Then it should run it with query bit clear in order to actually commit
> > > the changes. At the moment Linux only runs the _OSC with query bit set
> >
> > And that's because there was nothing it could ask to control using the
> > _SB scope _OSC.
> >
> > Today it is just reporting what features are supported by it.
> >
> > However, with the upcoming USB4 CM support it needs to ask for the
> > control of that feature and that's why the _SB scope _OSC support
> > needs to be extended.  So it is not a fix for a bug or missing spec
> > coverage, which this part of the changelog kind of implies, it's just
> > enabling a new feature.
>
> Other operating systems behave as described in the ACPI spec long before USB4 CM
> support was added.  Admittedly this is semantics of whether to call it
> a "bug", but specifically the lack of this in the existing Linux kernel code
> *can* actually cause you to get into a situation where you have no functional
> USB4.  This will happen if you boot between two different kernels or potentially
> two different operating systems.  This is due to how the selection of FW or SW
> CM is made.  If this patch "alone" was brought further backward the older kernels
> FW CM mode would be activated in those situations.

I would put that information into the changelog.

Moreover, have you looked at acpi_pci_osc_control_set()?

What it does is analogous to what you are proposing, but a bit
different, and I would like to preserve consistency between _OSC use
cases.

So would it be possible to adjust the _SB _OSC evaluation flow to
follow the PCI _OSC one?  That is, if any control bits are there, pass
them along with the last evaluation of _OSC with the query flag clear.
Or is the latter defective and if so then why?

>
> >
> > > and this is going to cause problems with the USB4 CM (Connection
> > > Manager) switch that is going to commit the switch only when the OS
> > > requests control over the feature.
> > >
> > > For this reason modify the _OSC support so that we first execute it with
> > > query bit set, then use the returned valu as base of the features we
> >
> > s/valu/value/
> >
> > > want to control and run the _OSC again with query bit clear.
> > >
> > > Also rename the function to better match what it does.
> > >
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > >
> > > ---
> > >  drivers/acpi/bus.c | 43 +++++++++++++++++++++++++++++++------------
> > >  1 file changed, 31 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > > index 1682f8b454a2..ca7c7b2bf56e 100644
> > > --- a/drivers/acpi/bus.c
> > > +++ b/drivers/acpi/bus.c
> > > @@ -282,9 +282,9 @@ bool osc_pc_lpi_support_confirmed;
> > >  EXPORT_SYMBOL_GPL(osc_pc_lpi_support_confirmed);
> > >
> > >  static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
> > > -static void acpi_bus_osc_support(void)
> > > +static void acpi_bus_osc_negotiate_platform_control(void)
> > >  {
> > > -       u32 capbuf[2];
> > > +       u32 capbuf[2], *capbuf_ret;
> > >         struct acpi_osc_context context = {
> > >                 .uuid_str = sb_uuid_str,
> > >                 .rev = 1,
> > > @@ -321,17 +321,36 @@ static void acpi_bus_osc_support(void)
> > >                 capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
> > >         if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
> > >                 return;
> > > -       if (ACPI_SUCCESS(acpi_run_osc(handle, &context))) {
> > > -               u32 *capbuf_ret = context.ret.pointer;
> > > -               if (context.ret.length > OSC_SUPPORT_DWORD) {
> > > -                       osc_sb_apei_support_acked =
> > > -                               capbuf_ret[OSC_SUPPORT_DWORD] &
> > OSC_SB_APEI_SUPPORT;
> > > -                       osc_pc_lpi_support_confirmed =
> > > -                               capbuf_ret[OSC_SUPPORT_DWORD] &
> > OSC_SB_PCLPI_SUPPORT;
> > > -               }
> > > +
> > > +       if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> > > +               return;
> > > +
> > > +       capbuf_ret = context.ret.pointer;
> > > +       if (context.ret.length <= OSC_SUPPORT_DWORD) {
> > >                 kfree(context.ret.pointer);
> > > +               return;
> > >         }
> > > -       /* do we need to check other returned cap? Sounds no */
> > > +
> > > +       /*
> > > +        * Now run _OSC again with query flag clean and with the caps
> >
> > s/clean/clear/
> >
> > > +        * both platform and OS supports.
> >
> > s/both platform and OS supports/supported by both the OS and the platform/
> >
> > > +        */
> > > +       capbuf[OSC_QUERY_DWORD] = 0;
> > > +       capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
> > > +       kfree(context.ret.pointer);
> > > +
> > > +       if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> > > +               return;
> > > +
> > > +       capbuf_ret = context.ret.pointer;
> > > +       if (context.ret.length > OSC_SUPPORT_DWORD) {
> > > +               osc_sb_apei_support_acked =
> > > +                       capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
> > > +               osc_pc_lpi_support_confirmed =
> > > +                       capbuf_ret[OSC_SUPPORT_DWORD] &
> > OSC_SB_PCLPI_SUPPORT;
> > > +       }
> > > +
> > > +       kfree(context.ret.pointer);
> > >  }
> > >
> > >  /* ------------------------------------------------------------------------
> > --
> > > @@ -1168,7 +1187,7 @@ static int __init acpi_bus_init(void)
> > >          * _OSC method may exist in module level code,
> > >          * so it must be run after ACPI_FULL_INITIALIZATION
> > >          */
> > > -       acpi_bus_osc_support();
> > > +       acpi_bus_osc_negotiate_platform_control();
> > >
> > >         /*
> > >          * _PDC control method may load dynamic SSDT tables,
> > > --
> > > 2.29.2
> > >
