Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DCB51E539
	for <lists+linux-acpi@lfdr.de>; Sat,  7 May 2022 09:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445970AbiEGHfR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 7 May 2022 03:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386097AbiEGHfQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 7 May 2022 03:35:16 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E2E4579C;
        Sat,  7 May 2022 00:31:28 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B50DEFF803;
        Sat,  7 May 2022 07:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651908687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yj76RWm4PAng0nU1sLIhfTSnacWzd2+e9h4pJ1GF1LQ=;
        b=SU+FT2mtyoLI+ePai5KrBxZwbcPn5dyEgTSZmUiPaPgi8JvwLnvTo+Yfr7M7imJmOw1FFi
        +Tpzh9lhyJHW9LGwcDQx3MNmik6H3igk7l4PphypmdMLFnSaU1jxz7ce9sDSiC1BmOJiP3
        br4hzudrrfzoFEeypRwJO9Pg2jhUl63irsaUr8gB59UYh/BDEKRycJSP5HEG5CV9Yc54Tk
        6Z+mCLRQis/UG1OyCpx+//AlGJ7D1qGboVu/RV/KJ5GiuDG3rTbdfuh6nemfX5t+E5GScD
        dd+n9LilWKUhQcsYB4Aqp17byP8FjJ4MKRi/Y+VJeRwukYvb5G5CP466K7hWxg==
Date:   Sat, 7 May 2022 09:31:26 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     rjw@rjwysocki.net, kvalo@kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-wireless@vger.kernel.org, daniel.lezcano@linaro.org,
        merez@codeaurora.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: Re: [PATCH 7/7] rtc: cmos: Add suspend/resume endurance testing hook
Message-ID: <YnYgTtwTOtITODD4@mail.local>
References: <20220505015814.3727692-1-rui.zhang@intel.com>
 <20220505015814.3727692-8-rui.zhang@intel.com>
 <YnWXQE9QASycOzZo@mail.local>
 <320773e042a538782411f4db838bdc70a1b0851b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <320773e042a538782411f4db838bdc70a1b0851b.camel@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 07/05/2022 10:00:40+0800, Zhang Rui wrote:
> Hi, Alexandre,
> 
> Thanks for reviewing the patch.
> 
> On Fri, 2022-05-06 at 23:46 +0200, Alexandre Belloni wrote:
> > Hello,
> > 
> > I assume I can ignore this patch as this seems to be only for testing
> 
> The main purpose of this patch is for automate testing.
> But this doesn't mean it cannot be part of upstream code, right?
> 
> > I'm not even sure why this is needed as this completely breaks
> > setting
> > the alarm time.
> 
> Or overrides the alarm time, :)
> 
> People rely on the rtc alarm in the automated suspend stress test,
> which suspend and resume the system for over 1000 iterations.
> As I mentioned in the cover letter of this patch series, if the system
> suspend time varies from under 1 second to over 60 seconds, how to
> alarm the RTC before suspend?
> This feature is critical in this scenario.
> 
> Plus, the current solution is transparent to people who don't known/use
> this "rtc_wake_override_sec" parameter. And for people who use this,
> they should know that the previous armed RTC alarm will be overrode
> whenever a system suspend is triggered. I can add a message when the
> parameter is set, if needed.
> 

It is not transparent, if I read your patch properly, this breaks wakeup
for everyone...

> > On 05/05/2022 09:58:14+0800, Zhang Rui wrote:
> > > +static int cmos_pm_notify(struct notifier_block *nb, unsigned long
> > > mode, void *_unused)
> > > +{
> > > +	struct cmos_rtc *cmos = container_of(nb, struct cmos_rtc,
> > > pm_nb);
> > > +	struct rtc_device       *rtc = cmos->rtc;
> > > +	unsigned long           now;
> > > +	struct rtc_wkalrm       alm;
> > > +
> > > +	if (rtc_wake_override_sec == 0)
> > > +		return NOTIFY_OK;
> > > +
> > > +	switch (mode) {
> > > +	case PM_SUSPEND_PREPARE:
> > > +		/*
> > > +		 * Cancel the timer to make sure it won't fire
> > > +		 * before rtc is rearmed later.
> > > +		 */
> > > +		rtc_timer_cancel(rtc, &rtc->aie_timer);
> > > +		break;
> > > +	case PM_SUSPEND_LATE:
> > > +		if (rtc_read_time(rtc, &alm.time))
> > > +			return NOTIFY_BAD;
> > > +
> > > +		now = rtc_tm_to_time64(&alm.time);
> > > +		memset(&alm, 0, sizeof(alm));
> > > +		rtc_time64_to_tm(now + rtc_wake_override_sec,
> > > &alm.time);
> > > +		alm.enabled = true;
> > > +		if (rtc_set_alarm(rtc, &alm))
> > > +			return NOTIFY_BAD;

... because if rtc_wake_override_sec is not set, this sets the alarm to
now which is the current RTC time, ensuring the alarm will never
trigger.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
