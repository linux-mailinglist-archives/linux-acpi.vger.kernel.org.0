Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3DF4D98E0
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Mar 2022 11:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347110AbiCOKgX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Mar 2022 06:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347142AbiCOKgW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Mar 2022 06:36:22 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8EB338B7
        for <linux-acpi@vger.kernel.org>; Tue, 15 Mar 2022 03:35:09 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2dbfe58670cso195969257b3.3
        for <linux-acpi@vger.kernel.org>; Tue, 15 Mar 2022 03:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pkc9GvGFo4iMQJpC2p6s/Wqo1qfRHuszmmXMcpGLxXA=;
        b=GMC3ucgt2L5dCVkwCW1iodeIvZlFi3TztvrtLzZ4gb0VBdf12remkRcclJ2nwuxYPX
         ETHfSz90tpo3/EzrJwLyd0jC2AdAhd8IvP7kdG5bETJ9lmH3ZWHA5XDnFyqdM/+qT+yL
         pb4F8pXCQsreKoK2Sg93LXV+YTJVI46EXijjRozrulse3H7mkaqCvKQyTuHto5hsVwW4
         wJI9GfdhkSTBni3uvXR9SGM8YRx8+MrFKCwIqMUar8cCw6jGsRIayn+1sh6Ncj96nvSB
         Yrk9V1HIKsO1ZSmTsVdX/gWIPGK1tDaBybwu3oEpymKI2GUQ3XH51pPPLuEAThdR1EIP
         A8+g==
X-Gm-Message-State: AOAM531ov7NayRLNDglaDz2u0uR94QceSJLCjm/teBT0etnGu5BgNlKS
        g0yeLpd30kQBqAvNQNBEVyaci6LAjJfPl9KDFFiwUhLU
X-Google-Smtp-Source: ABdhPJwzTFdmtm9GPvDwA16IgyRR4ukqA0j6rFQMwNsTA0IWMZEEWwMpxmQrwKpMEt5Eids3m2B98RxPaua72Uz2mtg=
X-Received: by 2002:a0d:e904:0:b0:2e5:80bb:90a6 with SMTP id
 s4-20020a0de904000000b002e580bb90a6mr3833332ywe.515.1647340507584; Tue, 15
 Mar 2022 03:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220310212805.3786-1-mario.limonciello@amd.com>
 <CAJZ5v0ibnaZZu_Gxngjbu5vzdQaJog8XZnJP6_msLqV_gi4Zig@mail.gmail.com>
 <BL1PR12MB5157839B59321A1A6AD9F73FE20E9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g_TH+OeQkBwXELKZiRcxjLvstr8G_bXOBChJ94sTkvHw@mail.gmail.com> <BL1PR12MB51576398DFBD0EADC6AFEAF1E2109@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51576398DFBD0EADC6AFEAF1E2109@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Mar 2022 11:34:55 +0100
Message-ID: <CAJZ5v0i=ecAksq0TV+iLVObm-=fUfdqPABzzkgm9K6KxO1ZCcg@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: bus: For platform OSC negotiate capabilities
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 15, 2022 at 5:30 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Monday, March 14, 2022 15:01
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>; Rafael J . Wysocki
> > <rjw@rjwysocki.net>; ACPI Devel Maling List <linux-acpi@vger.kernel.org>;
> > Mika Westerberg <mika.westerberg@linux.intel.com>; Hou, Xiaomeng
> > (Matthew) <Xiaomeng.Hou@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>;
> > Huang, Ray <Ray.Huang@amd.com>; Hans de Goede
> > <hdegoede@redhat.com>
> > Subject: Re: [PATCH v6] ACPI: bus: For platform OSC negotiate capabilities
> >
> > On Mon, Mar 14, 2022 at 12:45 AM Limonciello, Mario
> > <Mario.Limonciello@amd.com> wrote:
> > >
> > > [Public]
> > >
> > > > I would do
> > > >
> > > > if (capbuf[OSC_SUPPORT_DWORD] ==
> > capbuf_ret[OSC_SUPPORT_DWORD])
> > > >         capbuf[OSC_QUERY_DWORD] = 0;
> > > > else
> > > >         capbuf[OSC_SUPPORT_DWORD] &=
> > capbuf_ret[OSC_SUPPORT_DWORD];
> > > >
> > > > so that the loop terminates even if the firmware does strange things
> > > > and then it would only be necessary to check
> > capbuf[OSC_QUERY_DWORD]
> > > > in the loop termination condition.
> > > >
> > > > Would that work?
> > > >
> > >
> > > I think it will.  I'll try it and send up a v7 if so.
> > >
> > > > > +               kfree(context.ret.pointer);
> > > > > +       } while (capbuf[OSC_QUERY_DWORD] &&
> > > > capbuf[OSC_SUPPORT_DWORD]);
> > > > >
> > > > > -       /* Now run _OSC again with query flag clear */
> > > > > -       capbuf[OSC_QUERY_DWORD] = 0;
> > > > > +       /*
> > > > > +        * Avoid problems with BIOS dynamically loading tables by
> > indicating
> > > > > +        * support for CPPC even if it was masked.
> > > >
> > > > What exactly do you mean by "BIOS dynamically loading tables"?
> > >
> > > As mentioned in commit 159d8c274fd9:
> > >
> > >     On certain systems the BIOS loads SSDT tables dynamically based on the
> > >     capabilities the OS claims to support. However, on these systems the
> > >     _OSC actually clears some of the bits (under certain conditions) so what
> > >     happens is that now when we call the _OSC twice the second time we
> > pass
> > >     the cleared values and that results errors like below to appear on the
> > >     system log:
> > >
> > >       ACPI BIOS Error (bug): Could not resolve symbol [\_PR.PR00._CPC],
> > AE_NOT_FOUND (20210105/psargs-330)
> > >       ACPI Error: Aborting method \_PR.PR01._CPC due to previous error
> > (AE_NOT_FOUND) (20210105/psparse-529)
> > >
> > > This block  is to avoid regressing that again by forcing it on these systems.
> >
> > Well, this means that the code before and after the patch is not
> > actually following the spec.
> >
> > First off, as mentioned in the changelog of commit 159d8c274fd9 (in
> > the part that has not been quoted above), the OS is required to pass
> > the same set of capabilities every time _OSC is evaluated.  This
> > doesn't happen after the change.
> >
> > Second, acpi_bus_osc_negotiate_platform_control() should take the
> > capabilities mask returned by the platform which it doesn't do without
> > the patch.
>
> Right on both points.
>
> >
> > That latter piece appears to be the bug in question here and IMO
> > fixing it doesn't even require calling acpi_run_osc() with the query
> > flag set for multiple times.
>
> I think just taking the results will re-introduce the CPC bug though
> won't it?  So how to avoid it but also to take the results?

I think that the OS should not ask for the control of the CPPC bits if
they are masked by the firmware and it should avoid invoking _CPC
then.

Otherwise we risk breaking legitimate cases in which the firmware
actually doesn't want the OS to control those bits.
