Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A8F52D0E8
	for <lists+linux-acpi@lfdr.de>; Thu, 19 May 2022 12:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiESK4p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 May 2022 06:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiESK4n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2022 06:56:43 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80F9674C8;
        Thu, 19 May 2022 03:56:40 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id i11so8345727ybq.9;
        Thu, 19 May 2022 03:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsPdkWTA95Eqpmk1DP4Hoq5zSJ+0tKlh8Uu+b07Gp3I=;
        b=pIf9QKtn0Qd8es0SBlcyJKGIswkPAhV0/KRRrAqIAsw4SwWd8xzfHjc3NOIzEdh3UI
         7LQRwDP193hX6DmoWepvqYsQ7fSFqyAKMbwxaMOjLgkRLCbV+HtHm8MXt4pPq3Xrng2T
         ap78Cl6ELvduRBYu75MIciyMirRy95/Q+rqNlsg7d3L8BXi7XHGz3qxzPerP7kSzO32K
         KVpt6OJmIVG17h9qE0ZhanakzNQs0dEvVeCoz5QvHGPa3r54JQH/DDQ3Qkt12jXawLue
         yayGoIMH8fjNl8TZygpRvSZXeolOmXEICXbYExj6YRLtYUhEh456FrhV6B5g3orZ7YUu
         MJaQ==
X-Gm-Message-State: AOAM533ukr+QXG+k42c1XIe3DyItwTc8ZlXX7fyKUT10AQxZBCjabc6y
        DqFzbKg/EzzsForx2bsN/lrT/ydQ5ljjqZyhGTnalOMxvOw=
X-Google-Smtp-Source: ABdhPJwCu8Y04Iz7ROUNEcavVfM2tjOMiMfDIW+3GBT9+Gd0rU87hBC+0P8SwDbKar1qT4O1G+LjmO2Jv1cWC99NNq8=
X-Received: by 2002:a25:d687:0:b0:64e:3a41:8d5 with SMTP id
 n129-20020a25d687000000b0064e3a4108d5mr3688875ybg.622.1652957800200; Thu, 19
 May 2022 03:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220505015814.3727692-1-rui.zhang@intel.com> <20220505015814.3727692-8-rui.zhang@intel.com>
 <CAJZ5v0jt1OND_d08mC0TC1LZ-JGANDY5fiDmH5RUfdtRk1vZFw@mail.gmail.com>
 <2dc4aa933d07add206a2aeefa15a4837aca6ff62.camel@intel.com>
 <CAJZ5v0h=pYZkbhN2EiYzUGn36Q4-2tMyzfUP0uyFO=Sybse4DA@mail.gmail.com>
 <20ad397b7975775d69d6c0ea902ca362fa3cf395.camel@intel.com> <CAJvTdKnRmsR+1b2urHr7=u7AcvCfr7m+GqLfLLgOgoB9KaB-zQ@mail.gmail.com>
In-Reply-To: <CAJvTdKnRmsR+1b2urHr7=u7AcvCfr7m+GqLfLLgOgoB9KaB-zQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 May 2022 12:56:28 +0200
Message-ID: <CAJZ5v0jZgLdVboWEG_akqC1U3wk4q9NqiFVqiOdvDMw1uqK_oA@mail.gmail.com>
Subject: Re: [PATCH 7/7] rtc: cmos: Add suspend/resume endurance testing hook
To:     Len Brown <lenb@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Thu, May 19, 2022 at 4:33 AM Len Brown <lenb@kernel.org> wrote:
>
> First let's agree on why this should not be ignored.
>
> Our development team at Intel has lab with laptops, we run sleepgraph
> on every RC, and we publish the tool in public:
> https://www.intel.com/content/www/us/en/developer/topic-technology/open/pm-graph/overview.html
>
> But even if we were funded to do it (which we are not), we can't
> possibly test every kind of device.
> We need the community to help testing Linux (suspend/resume,
> specifically) on a broad range of devices, so together we can make it
> better for all.
>
> The community is made up mostly of users, rather than kernel hackers,
> and so this effectively means that distro binary kernels need to be
> able to support testing.
>
> Enabling that broad community of users/contributors is the goal.
>
> As Rui explained, this patch does nothing and breaks nothing if the
> new hook remains unused.
> If it is used, then overrides the wakeup duration for all subsequent
> system suspends, until it is cleared.
> If it does more than that, or does that in a clumsy way, then let's fix that.
>
> Today it gives us two new capabilities:
>
> 1. Prevents a lost wake event.  Commonly we see this with kcompatd
> taking 20 seconds when we had previously armed the RTC for 15 seconds.
> The system will sleep forever, until the user intervenes -- which may
> be a very long time later.
>
> Rafael, If you have a better way to fix that, I'm all ears.  Aborted
> suspend flows are ugly -- particularly when the user didn't want them,
> but they are much less ugly then losing a wake event, which can result
> in losing, say 10-hours of test time.

The real problem here is the missed wakeup events and I've already
said in this thread how this can be fixed and Rui appears to agree
with me.

So I'd say why don't we just go and fix it?

And it is orthogonal to the first 3 patches in this series, because
they move the PCH thermal delay to the noirq phase which is later than
the arming of the RTC Fixed Event IIUC.

> 2. Allows more suspends/resume cycles per time.  Say the early wake is
> fixed.  Then we have to decide how long to sleep before being
> suspended.  If we set it for 1 second, and suspend takes longer than 1
> second, then all of our tests will fail with early wakeups and we have
> tested nothing.

We have tested "early" wakeups which is what the users would see on
the system in question if they set the RTC wake time to 1 second
before suspending.

This may not be what we want to test, though, but that is a different
problem, as discussed below.

> If we set it to 60 seconds, and suspend takes 1
> second, then 59/60 seconds are spent sleeping, when they could be
> spent testing Linux.  With this patch, we can set it to the minimum of
> 2 seconds right before we sleep, guaranteeing that we spend at least 1
> second, and under 2 seconds sleeping, and the rest of the time testing
> -- which allows us to meet the goal.

So the goal specifically is to test the last phase of system suspend
and in particular whether or not the platform has reached the specific
minimum-power state at the end of it.

In order to do that, we basically want to ignore all of the wakeup
events except for the special RTC wakeup 1 second after the platform
has been asked to get into the minimum-power state, so what we are
talking about here really is a special suspend test mode using the RTC
as a wakeup vehicle.
