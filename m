Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1599152A8FF
	for <lists+linux-acpi@lfdr.de>; Tue, 17 May 2022 19:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiEQRJs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 May 2022 13:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351412AbiEQRJG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2022 13:09:06 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54671506D4;
        Tue, 17 May 2022 10:09:04 -0700 (PDT)
Received: from relay4-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::224])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id E253BC65DF;
        Tue, 17 May 2022 17:07:49 +0000 (UTC)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B3415E0006;
        Tue, 17 May 2022 17:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652807258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lMslnncr3ii3Tkm1tB44alj8rpL8Y4RP39Ic20UO+ks=;
        b=NV4NKeda8S4TQDTGbPu7/JpPe2xaqRFF+0D2NppThjNGRRqzjeY9dWkIxtMyzboiHAaH6v
        UcNhUv1rdN6gzz3kDihWRkKcGDn9P3dro+noKnqjp2bhtOhqUqUzOfWH2roWBLLCPjNtWE
        glY67Ghd34mxekvUcKtwM3v3ufm0tpUbknXzbWjHzEP1JaR9JKNgVCfoGf55dkfdXivuAr
        RF72k6OwT7VrM5DYoDLPB4mThf3tagC/Ic0eMorY0/P+RzrTNaatCdo1J0tM46DwYyeH5g
        UtFhUh2v9AA+IikUNbYFa37FRbMoK1fqib3HWrOD4G87QrcYV/j/R6os3MP/8A==
Date:   Tue, 17 May 2022 19:07:37 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kvalo@kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        merez@codeaurora.org, mat.jonczyk@o2.pl,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 0/7] PM: Solution for S0ix failure caused by PCH
 overheating
Message-ID: <YoPWWYOMqshE06vr@mail.local>
References: <20220505015814.3727692-1-rui.zhang@intel.com>
 <CAJZ5v0gj=zOF-9sMaWtWbPm7051W31qbJsK25bceeAe693Wj3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gj=zOF-9sMaWtWbPm7051W31qbJsK25bceeAe693Wj3g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 17/05/2022 17:11:05+0200, Rafael J. Wysocki wrote:
> On Thu, May 5, 2022 at 3:58 AM Zhang Rui <rui.zhang@intel.com> wrote:
> >
> > On some Intel client platforms like SKL/KBL/CNL/CML, there is a
> > PCH thermal sensor that monitors the PCH temperature and blocks the system
> > from entering S0ix in case it overheats.
> >
> > Commit ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due to PCH
> > temperature above threshold") introduces a delay loop to cool the
> > temperature down for this purpose.
> >
> > However, in practice, we found that the time it takes to cool the PCH down
> > below threshold highly depends on the initial PCH temperature when the
> > delay starts, as well as the ambient temperature.
> >
> > For example, on a Dell XPS 9360 laptop, the problem can be triggered
> > 1. when it is suspended with heavy workload running.
> > or
> > 2. when it is moved from New Hampshire to Florida.
> >
> > In these cases, the 1 second delay is not sufficient. As a result, the
> > system stays in a shallower power state like PCx instead of S0ix, and
> > drains the battery power, without user' notice.
> >
> > In this patch series, we first fix the problem in patch 1/7 ~ 3/7, by
> > 1. expand the default overall cooling delay timeout to 60 seconds.
> > 2. make sure the temperature is below threshold rather than equal to it.
> > 3. move the delay to .suspend_noirq phase instead, in order to
> >    a) do the cooling when the system is in a more quiescent state
> >    b) be aware of wakeup events during the long delay, because some wakeup
> >       events (ACPI Power button Press, USB mouse, etc) become valid only
> >       in .suspend_noirq phase and later.
> >
> > However, this potential long delay introduces a problem to our suspend
> > stress automation test, because the delay makes it hard to predict how
> > much time it takes to suspend the system.
> > As we want to do as much suspend iterations as possible in limited time,
> > setting a 60+ seconds rtc alarm for suspend which usually takes shorter
> > than 1 second is far beyond overkill.
> >
> > Thus, in patch 4/7 ~ 7/7, a rtc driver hook is introduced, which cancels
> > the armed rtc alarm in the beginning of suspend and then rearm the rtc
> > alarm with a short interval (say, 2 second) right before system suspended.
> >
> > By running
> >  # echo 2 > /sys/module/rtc_cmos/parameters/rtc_wake_override_sec
> > before suspend, the system can be resumed by RTC alarm right after it is
> > suspended, no matter how much time the suspend really takes.
> >
> > This patch series has been tested on the same Dell XPS 9360 laptop and
> > S0ix is 100% achieved across 1000+ s2idle iterations.
> 
> Overall, the first three patches in the series can go in without the
> rest, so let's put them into a separate series.
> 
> Patch [4/7] doesn't depend on the first three ones, so it can go in by itself.
> 
> Patch [5/7] is to be dropped anyway as per the earlier discussion.
> 
> Patch [6/7] is only needed to apply patch [7/7] which is controversial.
> 
> I think that we can drop or defer patches [6-7/7] for now.

I don't think 7/7 is really useful in the upstream kernel, I don't plan
to apply it

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
