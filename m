Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030D34D30FB
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Mar 2022 15:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiCIO0Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Mar 2022 09:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiCIO0P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2022 09:26:15 -0500
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641D710E566
        for <linux-acpi@vger.kernel.org>; Wed,  9 Mar 2022 06:25:16 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2dbd97f9bfcso24413807b3.9
        for <linux-acpi@vger.kernel.org>; Wed, 09 Mar 2022 06:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKHJtpr1arBcDGRB+SNRF4WSgdjl1aHSdgT+Ot5TuC4=;
        b=ZI2Ehhz0/KllwINwFwby70b86laM9FpGHWCdJmfRXTV5DBLHuljfBsth6HC1wyCt/y
         shzzqYp32Ob7hgFA2to+lIYEYMLuz1lgLB5HKoqb8PwOLzzjXklqbkudtYPG7QjYE2aZ
         K88sQDYQor4UqS36bb7kPOiKMNbTX7W+TYrQHxnZMMbZjDg+7n0AMCQ9YH6f0BejfYJT
         tqy5iEasncjmu4fe0dd7+0GHPZ3tq+QxqnF6NS6lGZeW7t6td7HmkcuI+eILkalHw90w
         eY0SSD2DUEfdBLsBunrb/MdFCXHZztcfZAAnwVR8Vwrh7Jrp554GPeqa35LryhRsXYFW
         2lXQ==
X-Gm-Message-State: AOAM533hxE+mzDAwVMKh3EaQj3aqhafNO0DG4rpmDBesGHzpBTKQqx7n
        KtVlqV/rWcBq3e1L/EL902LwK0WDwQzLWk40eC4uCZ0C
X-Google-Smtp-Source: ABdhPJz7d+CcP8QLMYu2qdxwnBzWxrT56HixdZRAiw9VR48JKBEz9/CfLzB9/VvySK1Ju7VKtgBFlm70UcCe2ezkuik=
X-Received: by 2002:a81:bd0:0:b0:2dc:184b:e936 with SMTP id
 199-20020a810bd0000000b002dc184be936mr17161210ywl.7.1646835915701; Wed, 09
 Mar 2022 06:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20220308224200.2691564-1-mario.limonciello@amd.com>
 <CAJZ5v0ixsSuH_d+CCiU_Mn7HaCf6mLekOadte9j33NKg4aH20w@mail.gmail.com> <BL1PR12MB515736C2283780FA1215554EE20A9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB515736C2283780FA1215554EE20A9@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Mar 2022 15:25:04 +0100
Message-ID: <CAJZ5v0g8L9cLOx+1Hrb=JyVzqZwPfs09RUYMxKvOA41rtw4Ghg@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Add support for `AE_SUPPORT` in _OSC queries
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
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

On Wed, Mar 9, 2022 at 2:48 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
> > >
> > > commit a412caea5a2d ("ACPI: bus: Allow negotiating _OSC capabilities")
> > > added support for `acpi_run_osc` to return `AE_SUPPORT` when negotiating
> > > an _OSC.
> > >
> > > This was fixed in other kernel consumers, but `acpi_pci_run_osc` was
> > > missed.  Update the function to detect when called with
> > `OSC_QUERY_ENABLE`
> > > set and attempt to negotiate up to 5 times.
> >
> > This is not how it is designed to work, though.
> >
> > acpi_pci_query_osc() is for that.
> >
> > >
> > > Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> > > Fixes: a412caea5a2d ("ACPI: bus: Allow negotiating _OSC capabilities")
> >
> > So I'm seriously thinking about dropping that whole lot at this point.
>
> Do you want me to send up a series perhaps that reverts those 3 commits

I can just drop them at this point, so no need to revert.

> and instead moves the logic changes on query handling from acpi_run_osc into
> acpi_bus_osc_negotiate_platform_control?

Yes, please!
