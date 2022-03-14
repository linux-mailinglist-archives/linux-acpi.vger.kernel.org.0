Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499324D8DAB
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 21:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244768AbiCNUCp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 16:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244836AbiCNUCp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 16:02:45 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA5A3EA9F
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 13:01:34 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id u61so32988246ybi.11
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 13:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvSQZLVC46WFPzsBuFexBtLZE2ddKnu34L2COPZ/7sQ=;
        b=56UOGNga0Lg/4RyVQLwFtBvdV3ZnVUOXxrtPouPXMeaU8Q2hB5WexdDStvmF7IxvNz
         VUyY+5H+CSXR/rcRax/262mH37RSQBBA+HXefcY2Y4TK8bIpLyumlKvgleBWB82J5ZEX
         vCbrQkhixk5CM83XQcgbZ5gy0pE3EHO5QSGb0911UoXwtoU8uyPJdjmvmD2GPO4lfmUd
         KKg60mz0HLvEt3aEoZ83IY0HFJJNFg4R+vs++Mc+F7psxcIGA/F5wg5MMsetocCMyem/
         eofppFeQQc7TwU5XrbPpBMRuREWLqifDF4nM31rgaduTvFzfc9JY4ZPq4q8Osxa0uN3D
         2cag==
X-Gm-Message-State: AOAM5322g638Schb/ZOXLItj/q+yG3EX9sYt/xm7+xGsfBizl2k0PMX0
        VBe9FJqYzFs4Hf98PhKPot5UGt8Yx5AjtkTErgTAz7778Jc=
X-Google-Smtp-Source: ABdhPJwVmq3fi9UvNGGA5mR2/uOHDYi80bJEJD1UgIvBNPIWQCcE2f2NSllQI76pO6jGl/88idpQ3/HH1+hFrXsE8vQ=
X-Received: by 2002:a25:4052:0:b0:628:cdca:afb7 with SMTP id
 n79-20020a254052000000b00628cdcaafb7mr19648276yba.81.1647288094089; Mon, 14
 Mar 2022 13:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220310212805.3786-1-mario.limonciello@amd.com>
 <CAJZ5v0ibnaZZu_Gxngjbu5vzdQaJog8XZnJP6_msLqV_gi4Zig@mail.gmail.com> <BL1PR12MB5157839B59321A1A6AD9F73FE20E9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157839B59321A1A6AD9F73FE20E9@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Mar 2022 21:01:23 +0100
Message-ID: <CAJZ5v0g_TH+OeQkBwXELKZiRcxjLvstr8G_bXOBChJ94sTkvHw@mail.gmail.com>
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

On Mon, Mar 14, 2022 at 12:45 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> > I would do
> >
> > if (capbuf[OSC_SUPPORT_DWORD] == capbuf_ret[OSC_SUPPORT_DWORD])
> >         capbuf[OSC_QUERY_DWORD] = 0;
> > else
> >         capbuf[OSC_SUPPORT_DWORD] &= capbuf_ret[OSC_SUPPORT_DWORD];
> >
> > so that the loop terminates even if the firmware does strange things
> > and then it would only be necessary to check capbuf[OSC_QUERY_DWORD]
> > in the loop termination condition.
> >
> > Would that work?
> >
>
> I think it will.  I'll try it and send up a v7 if so.
>
> > > +               kfree(context.ret.pointer);
> > > +       } while (capbuf[OSC_QUERY_DWORD] &&
> > capbuf[OSC_SUPPORT_DWORD]);
> > >
> > > -       /* Now run _OSC again with query flag clear */
> > > -       capbuf[OSC_QUERY_DWORD] = 0;
> > > +       /*
> > > +        * Avoid problems with BIOS dynamically loading tables by indicating
> > > +        * support for CPPC even if it was masked.
> >
> > What exactly do you mean by "BIOS dynamically loading tables"?
>
> As mentioned in commit 159d8c274fd9:
>
>     On certain systems the BIOS loads SSDT tables dynamically based on the
>     capabilities the OS claims to support. However, on these systems the
>     _OSC actually clears some of the bits (under certain conditions) so what
>     happens is that now when we call the _OSC twice the second time we pass
>     the cleared values and that results errors like below to appear on the
>     system log:
>
>       ACPI BIOS Error (bug): Could not resolve symbol [\_PR.PR00._CPC], AE_NOT_FOUND (20210105/psargs-330)
>       ACPI Error: Aborting method \_PR.PR01._CPC due to previous error (AE_NOT_FOUND) (20210105/psparse-529)
>
> This block  is to avoid regressing that again by forcing it on these systems.

Well, this means that the code before and after the patch is not
actually following the spec.

First off, as mentioned in the changelog of commit 159d8c274fd9 (in
the part that has not been quoted above), the OS is required to pass
the same set of capabilities every time _OSC is evaluated.  This
doesn't happen after the change.

Second, acpi_bus_osc_negotiate_platform_control() should take the
capabilities mask returned by the platform which it doesn't do without
the patch.

That latter piece appears to be the bug in question here and IMO
fixing it doesn't even require calling acpi_run_osc() with the query
flag set for multiple times.

>
> >
> > > +        */
> > > +#ifdef CONFIG_X86
> > > +       if (boot_cpu_has(X86_FEATURE_HWP)) {
> > > +               capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
> > > +               capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
> > > +       }
> > > +#endif
> > >
> > > +       /* Now run _OSC again with query flag clear */
> > >         if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> > >                 return;
> > >
> > > --
> > > 2.34.1
> > >
