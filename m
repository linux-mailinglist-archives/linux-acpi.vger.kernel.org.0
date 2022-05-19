Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C1B52C9D3
	for <lists+linux-acpi@lfdr.de>; Thu, 19 May 2022 04:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiESCd4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 22:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiESCdz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 22:33:55 -0400
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12548C6E74;
        Wed, 18 May 2022 19:33:55 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id d132so2118250vke.0;
        Wed, 18 May 2022 19:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6jbyutOwumj+LrvLcjzetQUKqPKzUNIp/FTCu48hvw=;
        b=jOoVC97FIxfNPed3L7v50RfQbh4AxRDz6r5YpX9jAZhcRTU0o+NQKZykKjHAh2F/ys
         xrm0S25mrpm5bSv+yLmkFFLSy7E/yEB1FdoBWm40eZqCcIqzOHOyz3T0aJ7jJk8q+bSK
         MHNlEdAHDIapuoQug+gYN8/qLy2ZuuEKXToj7ELyy0Q8jDxQj2QJiYHv67p9Dar+Tfpi
         KzUczpBWalmeW13dOSI428BpE2wF8Ao+1QAp6M2v/wyw/3d8X3SH7oWwOodIuuyOzUzj
         4gZxvH3+fnz2X5zF+db+v5uAiHLXzSe7bJPGIm/0vbEdygxuJxOW9AWTAtvEd0AyCTht
         RC3A==
X-Gm-Message-State: AOAM530F454QTKv0KMPfxJUShz+1r9KRmFXRwOYuVoL1bEyqPCu0gPFc
        zDzLC9EjLHuS6wFEP4vKSwRrb6JDUpVPhHhkrK8=
X-Google-Smtp-Source: ABdhPJwON+5z8eNTjw6bpXmLZQJvvRhiCNs5QCAZObqr3pRwKRoTxGdMQmC3/+8n/nYodjdo61T9rduIi1V9+RNE1ck=
X-Received: by 2002:a1f:5907:0:b0:352:6327:926f with SMTP id
 n7-20020a1f5907000000b003526327926fmr986181vkb.1.1652927634185; Wed, 18 May
 2022 19:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220505015814.3727692-1-rui.zhang@intel.com> <20220505015814.3727692-8-rui.zhang@intel.com>
 <CAJZ5v0jt1OND_d08mC0TC1LZ-JGANDY5fiDmH5RUfdtRk1vZFw@mail.gmail.com>
 <2dc4aa933d07add206a2aeefa15a4837aca6ff62.camel@intel.com>
 <CAJZ5v0h=pYZkbhN2EiYzUGn36Q4-2tMyzfUP0uyFO=Sybse4DA@mail.gmail.com> <20ad397b7975775d69d6c0ea902ca362fa3cf395.camel@intel.com>
In-Reply-To: <20ad397b7975775d69d6c0ea902ca362fa3cf395.camel@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 18 May 2022 16:33:43 -1000
Message-ID: <CAJvTdKnRmsR+1b2urHr7=u7AcvCfr7m+GqLfLLgOgoB9KaB-zQ@mail.gmail.com>
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
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

First let's agree on why this should not be ignored.

Our development team at Intel has lab with laptops, we run sleepgraph
on every RC, and we publish the tool in public:
https://www.intel.com/content/www/us/en/developer/topic-technology/open/pm-graph/overview.html

But even if we were funded to do it (which we are not), we can't
possibly test every kind of device.
We need the community to help testing Linux (suspend/resume,
specifically) on a broad range of devices, so together we can make it
better for all.

The community is made up mostly of users, rather than kernel hackers,
and so this effectively means that distro binary kernels need to be
able to support testing.

Enabling that broad community of users/contributors is the goal.

As Rui explained, this patch does nothing and breaks nothing if the
new hook remains unused.
If it is used, then overrides the wakeup duration for all subsequent
system suspends, until it is cleared.
If it does more than that, or does that in a clumsy way, then let's fix that.

Today it gives us two new capabilities:

1. Prevents a lost wake event.  Commonly we see this with kcompatd
taking 20 seconds when we had previously armed the RTC for 15 seconds.
The system will sleep forever, until the user intervenes -- which may
be a very long time later.

Rafael, If you have a better way to fix that, I'm all ears.  Aborted
suspend flows are ugly -- particularly when the user didn't want them,
but they are much less ugly then losing a wake event, which can result
in losing, say 10-hours of test time.

2. Allows more suspends/resume cycles per time.  Say the early wake is
fixed.  Then we have to decide how long to sleep before being
suspended.  If we set it for 1 second, and suspend takes longer than 1
second, then all of our tests will fail with early wakeups and we have
tested nothing.  If we set it to 60 seconds, and suspend takes 1
second, then 59/60 seconds are spent sleeping, when they could be
spent testing Linux.  With this patch, we can set it to the minimum of
2 seconds right before we sleep, guaranteeing that we spend at least 1
second, and under 2 seconds sleeping, and the rest of the time testing
-- which allows us to meet the goal.

thanks,
Len Brown, Intel
