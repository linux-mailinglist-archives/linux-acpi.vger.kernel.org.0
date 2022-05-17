Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D3752A5B5
	for <lists+linux-acpi@lfdr.de>; Tue, 17 May 2022 17:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349694AbiEQPLT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 May 2022 11:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiEQPLS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2022 11:11:18 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9748C3BF83;
        Tue, 17 May 2022 08:11:17 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id o16so4316359ilq.8;
        Tue, 17 May 2022 08:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGPIS3p0tWsSXcV5cfysBPCoWfQJFt5F5/zMc/X+4/o=;
        b=qCPylro6LUZ/DLS1aKo/X4Dg0CbYbgYkwmCsJkssMk6CEppAJ7QhuR/GhKxvcfOHkz
         23ZOiW4ZhmxugJmad68ijjG0bM3eKBOyIEPQOWBadqYXq2+ID9L4Fv/CvqQe3feP0FuW
         O7RM2oBF6HEG9x9xtIQH4nsbtuPPIh7CQTya3TgSDK6k2+ZzBIrgDqCyE74hA97/rMOK
         he4LStNSfvpagEjDZ5I7XnrUDfSgRu+fVK2qBK3VZl7QLgvo5RF1BAD0nCE96mEArAY2
         eZKez27GFXLdq5+Cfunlp66jcY+ZFNAjFSY0MY6sBfUoiWo522o7wQnKacKE8dXL7pyO
         HEeA==
X-Gm-Message-State: AOAM532bl7B3NiP1mzaizbVDmrWon4NvqnSeyh9nksoMmSZAAniHbzoj
        4sPDXO//Ahn/tOt7aUoR3G5SYCuHd+qH0ptLb08=
X-Google-Smtp-Source: ABdhPJwK6fPMmh+Dnc1oRwDJgKzRMCwZgXVd17RX63pPzibJ2b6aKSXh1DQN7VJkzs7yxRUyylT1YwjWOQpGdstQXh8=
X-Received: by 2002:a05:6e02:1568:b0:2cf:6711:c3c6 with SMTP id
 k8-20020a056e02156800b002cf6711c3c6mr12690956ilu.59.1652800276946; Tue, 17
 May 2022 08:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220505015814.3727692-1-rui.zhang@intel.com>
In-Reply-To: <20220505015814.3727692-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 17:11:05 +0200
Message-ID: <CAJZ5v0gj=zOF-9sMaWtWbPm7051W31qbJsK25bceeAe693Wj3g@mail.gmail.com>
Subject: Re: [PATCH 0/7] PM: Solution for S0ix failure caused by PCH overheating
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, kvalo@kernel.org,
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

On Thu, May 5, 2022 at 3:58 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On some Intel client platforms like SKL/KBL/CNL/CML, there is a
> PCH thermal sensor that monitors the PCH temperature and blocks the system
> from entering S0ix in case it overheats.
>
> Commit ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due to PCH
> temperature above threshold") introduces a delay loop to cool the
> temperature down for this purpose.
>
> However, in practice, we found that the time it takes to cool the PCH down
> below threshold highly depends on the initial PCH temperature when the
> delay starts, as well as the ambient temperature.
>
> For example, on a Dell XPS 9360 laptop, the problem can be triggered
> 1. when it is suspended with heavy workload running.
> or
> 2. when it is moved from New Hampshire to Florida.
>
> In these cases, the 1 second delay is not sufficient. As a result, the
> system stays in a shallower power state like PCx instead of S0ix, and
> drains the battery power, without user' notice.
>
> In this patch series, we first fix the problem in patch 1/7 ~ 3/7, by
> 1. expand the default overall cooling delay timeout to 60 seconds.
> 2. make sure the temperature is below threshold rather than equal to it.
> 3. move the delay to .suspend_noirq phase instead, in order to
>    a) do the cooling when the system is in a more quiescent state
>    b) be aware of wakeup events during the long delay, because some wakeup
>       events (ACPI Power button Press, USB mouse, etc) become valid only
>       in .suspend_noirq phase and later.
>
> However, this potential long delay introduces a problem to our suspend
> stress automation test, because the delay makes it hard to predict how
> much time it takes to suspend the system.
> As we want to do as much suspend iterations as possible in limited time,
> setting a 60+ seconds rtc alarm for suspend which usually takes shorter
> than 1 second is far beyond overkill.
>
> Thus, in patch 4/7 ~ 7/7, a rtc driver hook is introduced, which cancels
> the armed rtc alarm in the beginning of suspend and then rearm the rtc
> alarm with a short interval (say, 2 second) right before system suspended.
>
> By running
>  # echo 2 > /sys/module/rtc_cmos/parameters/rtc_wake_override_sec
> before suspend, the system can be resumed by RTC alarm right after it is
> suspended, no matter how much time the suspend really takes.
>
> This patch series has been tested on the same Dell XPS 9360 laptop and
> S0ix is 100% achieved across 1000+ s2idle iterations.

Overall, the first three patches in the series can go in without the
rest, so let's put them into a separate series.

Patch [4/7] doesn't depend on the first three ones, so it can go in by itself.

Patch [5/7] is to be dropped anyway as per the earlier discussion.

Patch [6/7] is only needed to apply patch [7/7] which is controversial.

I think that we can drop or defer patches [6-7/7] for now.
