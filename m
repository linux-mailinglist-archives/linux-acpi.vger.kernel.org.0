Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A3E51E157
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 23:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442903AbiEFVue (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 17:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348985AbiEFVud (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 17:50:33 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54E2637D;
        Fri,  6 May 2022 14:46:48 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 52EABFF802;
        Fri,  6 May 2022 21:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651873602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jgdW+utjX69lw9hZBaJPICrrQFeG4ACbfoIiurJVsC0=;
        b=cWZn2bIvqcSVFGu3IsFqsqClQjrfuRcnBfGvVG1LC+EZb+VCl3Yve3JqmG+2HHscqfqp4i
        vX97M++arG5GXblHmiyRHG9ZIgYSYZVpCZKXHS8td9kNTSj4IS28/SMJNhO9jrkVvk0ATN
        24bIxEbxb/BKyXuR5gp81RK8bjzdn5jkjH//ttYhUvkv0x4kUkoWf4YX59s1KBc9aZOfNG
        0gJTBGziACERliLJVvJ3QeGv//sGN7+r852isaiAwAtl7iQ64GSyw4gmGupgAcheSJ1W+9
        g30110feSLlykUWTJKC7WTbThbnp43eb6vzRn+UpM8oxgk68GpzG5k+tY7GEVA==
Date:   Fri, 6 May 2022 23:46:40 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     rjw@rjwysocki.net, kvalo@kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-wireless@vger.kernel.org, daniel.lezcano@linaro.org,
        merez@codeaurora.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: Re: [PATCH 7/7] rtc: cmos: Add suspend/resume endurance testing hook
Message-ID: <YnWXQE9QASycOzZo@mail.local>
References: <20220505015814.3727692-1-rui.zhang@intel.com>
 <20220505015814.3727692-8-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505015814.3727692-8-rui.zhang@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

I assume I can ignore this patch as this seems to be only for testing
I'm not even sure why this is needed as this completely breaks setting
the alarm time.

On 05/05/2022 09:58:14+0800, Zhang Rui wrote:
> Automated suspend/resume testing uses the RTC for wakeup.
> A short rtcwake period is desirable, so that more suspend/resume
> cycles can be completed, while the machine is available for testing.
> 
> But if too short a wake interval is specified, the event can occur,
> while still suspending, and then no event wakes the suspended system
> until the user notices that testing has stalled, and manually intervenes.
> 
> Here we add a hook to the rtc-cmos driver to
> a) remove the alarm timer in the beginning of suspend, if there is any
> b) arm the wakeup in PM notifier callback, which is in the very late stage
>    before the system really suspends
> The remaining part of suspend is usually measured under 10 ms,
> and so arming the timer at this point could be as fast as the minimum
> time of 1-second.
> 
> But there is a 2nd race.  The RTC has 1-second granularity, and unless
> you are timing the timer with a higher resolution timer,
> there is no telling if the current time + 1 will occur immediately,
> or a full second in the future.  And so 2-seconds is the safest minimum:
> 
> Run 1,000 s2idle cycles with (max of) 2 second wakeup period:
> 
>  # echo 2 > /sys/module/rtc_cmos/parameters/rtc_wake_override_sec
>  # sleepgraph.py -m freeze -multi 1000 0 -skiphtml -gzip
> 
> Clear the timer override, to not interfere with subsequent
> real use of the machine's suspend/resume feature:
> 
>  # echo 0 > /sys/module/rtc_cmos/parameters/rtc_wake_override_sec
> 
> Originally-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/rtc/interface.c |  1 +
>  drivers/rtc/rtc-cmos.c  | 45 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 9edd662c69ac..fb93aa2dc99c 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -1020,6 +1020,7 @@ void rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer)
>  		rtc_timer_remove(rtc, timer);
>  	mutex_unlock(&rtc->ops_lock);
>  }
> +EXPORT_SYMBOL_GPL(rtc_timer_cancel);
>  
>  /**
>   * rtc_read_offset - Read the amount of rtc offset in parts per billion
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index 7c006c2b125f..9590c40fa9d8 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -32,6 +32,7 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/spinlock.h>
> +#include <linux/suspend.h>
>  #include <linux/platform_device.h>
>  #include <linux/log2.h>
>  #include <linux/pm.h>
> @@ -70,6 +71,9 @@ static inline int cmos_use_acpi_alarm(void)
>  }
>  #endif
>  
> +static int rtc_wake_override_sec;
> +module_param(rtc_wake_override_sec, int, 0644);
> +
>  struct cmos_rtc {
>  	struct rtc_device	*rtc;
>  	struct device		*dev;
> @@ -89,6 +93,7 @@ struct cmos_rtc {
>  	u8			century;
>  
>  	struct rtc_wkalrm	saved_wkalrm;
> +	struct notifier_block	pm_nb;
>  };
>  
>  /* both platform and pnp busses use negative numbers for invalid irqs */
> @@ -744,6 +749,42 @@ static irqreturn_t cmos_interrupt(int irq, void *p)
>  		return IRQ_NONE;
>  }
>  
> +static int cmos_pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
> +{
> +	struct cmos_rtc *cmos = container_of(nb, struct cmos_rtc, pm_nb);
> +	struct rtc_device       *rtc = cmos->rtc;
> +	unsigned long           now;
> +	struct rtc_wkalrm       alm;
> +
> +	if (rtc_wake_override_sec == 0)
> +		return NOTIFY_OK;
> +
> +	switch (mode) {
> +	case PM_SUSPEND_PREPARE:
> +		/*
> +		 * Cancel the timer to make sure it won't fire
> +		 * before rtc is rearmed later.
> +		 */
> +		rtc_timer_cancel(rtc, &rtc->aie_timer);
> +		break;
> +	case PM_SUSPEND_LATE:
> +		if (rtc_read_time(rtc, &alm.time))
> +			return NOTIFY_BAD;
> +
> +		now = rtc_tm_to_time64(&alm.time);
> +		memset(&alm, 0, sizeof(alm));
> +		rtc_time64_to_tm(now + rtc_wake_override_sec, &alm.time);
> +		alm.enabled = true;
> +		if (rtc_set_alarm(rtc, &alm))
> +			return NOTIFY_BAD;
> +		if (cmos->wake_on)
> +			cmos->wake_on(cmos->dev);
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
>  #ifdef	CONFIG_PNP
>  #define	INITSECTION
>  
> @@ -937,6 +978,9 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
>  		 nvmem_cfg.size,
>  		 use_hpet_alarm() ? ", hpet irqs" : "");
>  
> +	cmos_rtc.pm_nb.notifier_call = cmos_pm_notify;
> +	register_pm_notifier(&cmos_rtc.pm_nb);
> +
>  	return 0;
>  
>  cleanup2:
> @@ -965,6 +1009,7 @@ static void cmos_do_remove(struct device *dev)
>  	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
>  	struct resource *ports;
>  
> +	unregister_pm_notifier(&cmos_rtc.pm_nb);
>  	cmos_do_shutdown(cmos->irq);
>  
>  	if (is_valid_irq(cmos->irq)) {
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
