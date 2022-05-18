Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDAB52BE43
	for <lists+linux-acpi@lfdr.de>; Wed, 18 May 2022 17:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbiERPCu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 11:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbiERPCt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 11:02:49 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FC21D2FDF;
        Wed, 18 May 2022 08:02:49 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2f16645872fso27702697b3.4;
        Wed, 18 May 2022 08:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ayfHAoqEtV8GWKK73lN72HvcNOrapmeyJaXzktDoFp4=;
        b=0i5R4c053As+/XsqizslXydUIJ3zc2GmYzYmsbGzyDsvfQEmDz9nt9BL9ZWLrk1iQm
         wK7buiSbeuJ0X7+02xpGS9WeyJidOBfWANio9IXfWqno+JILwfOZUIidLDmde9JXVoSH
         gc0d9hZAt3IeL5Ip7sr9anauGOAwDeAQyDukL0nyncEfQdjdQvKFCVR7Q9h7i/SDCIw1
         NBL+gtRjMXVoGIkc3cmumb4bDHQDRtqI4mcUbExt1LQU5L1MMWGnu5UjxsuKqO/WOvig
         3R5kX5gBS2eeWmD/ngH3zjA8AfbpMCSQVcbZQyleLYSMDSywIHSfA6ipfWUVxt56ggOW
         HCPA==
X-Gm-Message-State: AOAM531dd/v7QHFtaJM8WIG9A0fl/0+SEV8/RdQHopAcHneknrjNb0DX
        aFvKVJOJspX5GLxmKp0cHqk6gz+Uu2cYL95AQRw=
X-Google-Smtp-Source: ABdhPJxTDH362ZG7eZ1d0YXaROwhqfIiGt6sEyNfxW0dpdRgj7GdGxC2HW6tdf9RvBVyBjQZxaFchoSUUWT+jEJGtQE=
X-Received: by 2002:a81:91d4:0:b0:2fe:e300:3581 with SMTP id
 i203-20020a8191d4000000b002fee3003581mr19834231ywg.7.1652886168249; Wed, 18
 May 2022 08:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220505015814.3727692-1-rui.zhang@intel.com> <20220505015814.3727692-8-rui.zhang@intel.com>
 <CAJZ5v0jt1OND_d08mC0TC1LZ-JGANDY5fiDmH5RUfdtRk1vZFw@mail.gmail.com> <2dc4aa933d07add206a2aeefa15a4837aca6ff62.camel@intel.com>
In-Reply-To: <2dc4aa933d07add206a2aeefa15a4837aca6ff62.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 May 2022 17:02:37 +0200
Message-ID: <CAJZ5v0h=pYZkbhN2EiYzUGn36Q4-2tMyzfUP0uyFO=Sybse4DA@mail.gmail.com>
Subject: Re: [PATCH 7/7] rtc: cmos: Add suspend/resume endurance testing hook
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kalle Valo <kvalo@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        merez@codeaurora.org, mat.jonczyk@o2.pl,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Len Brown <len.brown@intel.com>
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

On Wed, May 18, 2022 at 4:45 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Tue, 2022-05-17 at 17:14 +0200, Rafael J. Wysocki wrote:
> > On Thu, May 5, 2022 at 3:58 AM Zhang Rui <rui.zhang@intel.com> wrote:
> > >
> > > Automated suspend/resume testing uses the RTC for wakeup.
> > > A short rtcwake period is desirable, so that more suspend/resume
> > > cycles can be completed, while the machine is available for
> > > testing.
> > >
> > > But if too short a wake interval is specified, the event can occur,
> > > while still suspending, and then no event wakes the suspended
> > > system
> > > until the user notices that testing has stalled, and manually
> > > intervenes.
> >
> > If the wakeup event occurs while still suspending, it should abort
> > the
> > suspend in progress, shouldn't it?  But the above implies that it
> > doesn't do that.
> >
> > If this is fixed, wouldn't it address the issue at hand?
>
> I think the rootcause of the original problem is that
> 1. on some systems, the ACPI RTC Fixed event is used during suspend
> only, and the ACPI Fixed event is enabled in the rtc-cmos driver
> .suspend() callback
> and
> 2. if the RTC Alarm already expires before .suspend() invoked, we will
> lose the ACPI RTC Fixed Event as well as the wakeup event, say 20
> seconds delay in freeze processes.

Well, the RTC Fixed event can be armed in a PM/HIBERNATE notifier and
if it fires before .suspend() runs, system wakeup can be triggered
from there.

> But, even if that problem is fixed, the suspend aborts and "fails" as
> expected, this is still a problem for the suspend-automation scenario,
> because the system actually can suspend successfully if we don't set
> the RTC alarm too aggressively. And in PCH overheating case, surely we
> will get false alarms, because we will never use a 60s+ rtc alarm for
> suspend-automation.

I'm not sure why this is a problem.

It only means that occasionally the system will not reach the final
"suspended" state, but that can happen regardless.
