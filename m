Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD4C4BEAFD
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 20:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiBUTBD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Feb 2022 14:01:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiBUS7Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 13:59:25 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2128AE4D
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 10:59:01 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2d625082ae2so148502927b3.1
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 10:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TRzQydVWanDQgNCCs+6E3SrrVASgrHiEyYQGSVS/q3s=;
        b=z2gWiEay7+nj30yoJun1qSQOEnZHFhuMhejYr4+OyX8YeqkoKp3bEN7w+Xyn6shCwh
         xgTsLO273O29STi7S4nasDoAQtsiBSbNCkGuBC7/FUfx3QT0cIN05/3ZyqtdW/Jdwp1L
         wtX+ghQPMkAlELFUvrB9v7dXxyWwC2KKyazJFQ1wizKYVn1BJfZQpsDWqGYpE0v/2u4L
         az0K3LFwcCO6YdjlAHvZyA6Viye/W/4jrQUWKFGoZetA7EZB3pkOPZiuKeHMH60bt4T4
         0xNMZgfc3GsvG6Gq5C3yptwdxLiXUuC9LGazBgamVydlbKdYr1N5nbKoUtC0u4YMkM8V
         JdYw==
X-Gm-Message-State: AOAM531AWlFbDEVALGzp7m2JbqVhep2BniJZA7Z4IKTAOm2y+5BaoW61
        5rzIQWBBN1vOdZgdTue/EQLxmI150m/+HAX5Q0oAE/EF
X-Google-Smtp-Source: ABdhPJzMhP4OfdGW03htEdElXrX85bZ+B0OR55xehaWRHAl8ZmYblCelIktOdZWuf+MrJUZza4n6R1PrKrZw/e4Pxpo=
X-Received: by 2002:a0d:e8d2:0:b0:2d6:1743:4023 with SMTP id
 r201-20020a0de8d2000000b002d617434023mr20903152ywe.7.1645469940936; Mon, 21
 Feb 2022 10:59:00 -0800 (PST)
MIME-Version: 1.0
References: <BL1PR12MB5157C5EA5510F0C9D7782AE8E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g81BmytcjgChXZumsHV5-byzSzDQbp2hc6CYzJ_6N=aw@mail.gmail.com>
 <BL1PR12MB5157E2CDD68BA585C5F4CF2BE2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0ho8PHGp0gAUp5KkUstTXLyUMsaQ7wTL=8xDJtjtXjPRw@mail.gmail.com>
 <CAJZ5v0j3Ma1HuUWoTmJvZDsUtm9hi84njJxJbBZMwe76eATSYQ@mail.gmail.com>
 <BL1PR12MB5157589AB3D9BC55C6D77EB4E2389@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0jmQaeSKj7wB1Jx+cxDHVxtHzbnTKZ4TcxnydHa5NOn+A@mail.gmail.com> <BL1PR12MB51570F5BD05980A0DCA1F3F4E23A9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51570F5BD05980A0DCA1F3F4E23A9@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Feb 2022 19:58:49 +0100
Message-ID: <CAJZ5v0iNoeUv0XjHWyazu5X8Y5=WXKabKtxB+bwHONgKab8fEA@mail.gmail.com>
Subject: Re: Regression in 5.16-rc1 with suspend to idle
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
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

On Mon, Feb 21, 2022 at 7:42 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [AMD Official Use Only]
>
> > > > Attached is another patch to try, testing the hypothesis that the
> > > > observed crash is related to CPUs being in idle state that are too
> > > > deep for some reason during late suspend and early resume.
> > >
> > > I tried 3 test kernels:
> > > * 5.17-rc4 + Your second debugging patch
> > > * 5.17-rc4+ Your first debugging patch
> > > * 5.17-rc4 + A hack I wrote that pushed amd-pmc into "later" in the
> > suspend
> > > using a global symbol called after LPS0 instead of letting it run in noirq stage
> > >
> > > It works properly on all of those, tried about 5x time in each.
> > >
> > > Then I confirmed I could still crash it on 5.17-rc4 with my control kernel.
> >
> > I would do something like the attached patch, then (provided that it works).
>
> I got a variation of this to work.  Let me clean it up some, do some more testing and I'll send
> it out to review.

OK

> Long term - are you opposed to drivers/acpi/x86/s2idle.c moving to drivers/platform/x86/?

It is tied to the code in sleep.c, so I'd rather not move it.

> I'd really like the stuff amd-pmc does to be a callback after lps0 (which is closer to how it works
> on Windows - it's the very last thing).

I see.

A notifier-based driver interface to be invoked from s2idle.c should
work for that.

> I feel like keeping the stuff it does as noirq is generally fragile, and I want to avoid this kind
> of breakage.

Sure.
