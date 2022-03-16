Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4124DAE29
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Mar 2022 11:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355109AbiCPKV2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Mar 2022 06:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355104AbiCPKV1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 06:21:27 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086065BD1A
        for <linux-acpi@vger.kernel.org>; Wed, 16 Mar 2022 03:20:13 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2e58e59d101so16990337b3.13
        for <linux-acpi@vger.kernel.org>; Wed, 16 Mar 2022 03:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mhaNyjTIS1cIGMji7UhkQW+aATVlod4sQoXQV3HzLA=;
        b=xDMtZ4RwvaIY43JjzbOYL9WSNGRgCya7EbVlOLyLWRWK5QLuz5789LHKPyjr9/3gMc
         5xSrQXSFrdfBHmBqbGv7ETP7OKq9n6pfWADUgIY8XOz5oeE0F37z4g7qN7m3JojDF+ry
         jaOPzktauYod6jJqKSet77M5k4yv1AzVXk9xET1vkizR9e2t4Vynd6bKs4lHI03nktaK
         vGWe8LBG+Y3NZLPk+9V1rNMJv2pH0l3fUIB4QBkYJ0k2OxzZ3LaCSCOk3USaivMf3Axa
         B9APyVOIANxOA3cnlYnOMBnmH8IZ3XA6sxCEchD2JhLUxu917ajCWlYHEAzYYOt1AOdQ
         z8dQ==
X-Gm-Message-State: AOAM531bZZmOaJisLHVLRJpx0Hfdv/bqgZ/jWVVz91caJqTj6H9EvQKY
        PI3UEepDf9aY/yESJBStntudBbYLd0Ws4reYkBo=
X-Google-Smtp-Source: ABdhPJygFuXlYCF07KVs4pOQjxP5lMKXskQ0xWKrEnZy5C59Z1e0xnI1Ff43gbACM8eimWdppeM9Jlla6C/Phb8sBQs=
X-Received: by 2002:a81:5cf:0:b0:2e5:7477:168e with SMTP id
 198-20020a8105cf000000b002e57477168emr11470558ywf.149.1647426012281; Wed, 16
 Mar 2022 03:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220310212805.3786-1-mario.limonciello@amd.com>
 <CAJZ5v0ibnaZZu_Gxngjbu5vzdQaJog8XZnJP6_msLqV_gi4Zig@mail.gmail.com>
 <BL1PR12MB5157839B59321A1A6AD9F73FE20E9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g_TH+OeQkBwXELKZiRcxjLvstr8G_bXOBChJ94sTkvHw@mail.gmail.com>
 <BL1PR12MB51576398DFBD0EADC6AFEAF1E2109@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0i=ecAksq0TV+iLVObm-=fUfdqPABzzkgm9K6KxO1ZCcg@mail.gmail.com>
 <CAJZ5v0iStA0JmO0H3z+VgQsVuQONVjKPpw0F5HKfiq=Gb6B5yw@mail.gmail.com> <BL1PR12MB515702B2DB9FED265B7B41BAE2109@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB515702B2DB9FED265B7B41BAE2109@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Mar 2022 11:20:00 +0100
Message-ID: <CAJZ5v0iQOG0-6SOfDwVm2QFOm1C0Nmtb=+2PHrMEt4ycCzOLtw@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 15, 2022 at 9:32 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> > > > > That latter piece appears to be the bug in question here and IMO
> > > > > fixing it doesn't even require calling acpi_run_osc() with the query
> > > > > flag set for multiple times.
> > > >
> > > > I think just taking the results will re-introduce the CPC bug though
> > > > won't it?  So how to avoid it but also to take the results?
> > >
> > > I think that the OS should not ask for the control of the CPPC bits if
> > > they are masked by the firmware and it should avoid invoking _CPC
> > > then.
> > >
> > > Otherwise we risk breaking legitimate cases in which the firmware
> > > actually doesn't want the OS to control those bits.
> >
> > I'm basically talking about reverting commit 159d8c274fd9, as the part
> > of the _OSC definition in the spec it is based on appears to be bogus
> > (that will be addressed separately via the ACPI spec process), and
> > applying the attached change on top of that.
> >
> > If this looks good to you, I'll take care of it.
>
> Yes, that looks great and I checked with 159d8c274fd9 reverted and that applying
> the problem does not exist.  I do think it has the possibility to cause CPPC to not
> be enabled outside of Intel though since HWP is only set there so I would suggest
> this other change on top of it:

Good point.

I'll make it x86-specific for the time being and that can be changed later.

> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 4df749b82568..e61dbd7f7108 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -314,10 +314,8 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>  #endif
>  #ifdef CONFIG_X86
>         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
> -       if (boot_cpu_has(X86_FEATURE_HWP)) {
> -               capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
> -               capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
> -       }
> +       capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
> +       capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
>  #endif
>
>         if (IS_ENABLED(CONFIG_SCHED_MC_PRIO))
