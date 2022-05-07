Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177F751E54A
	for <lists+linux-acpi@lfdr.de>; Sat,  7 May 2022 09:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379415AbiEGHpG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 7 May 2022 03:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiEGHpF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 7 May 2022 03:45:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AAD51E75;
        Sat,  7 May 2022 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651909280; x=1683445280;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B/wLy1WHMXvMEi+PTF4fxeilLSxaSgG5N6MO4b5BZN8=;
  b=aUq+IhcVVn1glTJf95LHC27o8w6a8JTrwEF6n+qq5zI8SovZzYHVSFXu
   8l3L5ZMuWY76sDxxaf9RIVkrrv5w5YMIPTB5E3Fx1fN3H9m4bVKoaAKv7
   cwFH1cBQcmFMGDsVi4DzbNJfvOlyNY4KtongLav/TXeLyTLGbun1cxORQ
   W8PRHYT/b1cRD5GmqogM+KdcV6pmnbklweaheXgxZX8EanKsi4YpuxaEO
   RW57nkyrxF733Svmu9g6szqcdz8OQw4/wH/KDayD+7HS5/MxAII+9btK8
   5hAhf7JSHYPhg0NPp5zbbk45qqugDbLoExG/U8aACY9xER9dZmmobz43E
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="267512235"
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="267512235"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 00:41:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="586409140"
Received: from xinmeigo-mobl.ccr.corp.intel.com ([10.255.29.106])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 00:41:16 -0700
Message-ID: <831d118f3eaa6abde991ea3c9f55b6befa956f15.camel@intel.com>
Subject: Re: [PATCH 7/7] rtc: cmos: Add suspend/resume endurance testing hook
From:   Zhang Rui <rui.zhang@intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     rjw@rjwysocki.net, kvalo@kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-wireless@vger.kernel.org, daniel.lezcano@linaro.org,
        merez@codeaurora.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Date:   Sat, 07 May 2022 15:41:13 +0800
In-Reply-To: <YnYgTtwTOtITODD4@mail.local>
References: <20220505015814.3727692-1-rui.zhang@intel.com>
         <20220505015814.3727692-8-rui.zhang@intel.com>
         <YnWXQE9QASycOzZo@mail.local>
         <320773e042a538782411f4db838bdc70a1b0851b.camel@intel.com>
         <YnYgTtwTOtITODD4@mail.local>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 2022-05-07 at 09:31 +0200, Alexandre Belloni wrote:
> On 07/05/2022 10:00:40+0800, Zhang Rui wrote:
> > Hi, Alexandre,
> > 
> > Thanks for reviewing the patch.
> > 
> > On Fri, 2022-05-06 at 23:46 +0200, Alexandre Belloni wrote:
> > > Hello,
> > > 
> > > I assume I can ignore this patch as this seems to be only for
> > > testing
> > 
> > The main purpose of this patch is for automate testing.
> > But this doesn't mean it cannot be part of upstream code, right?
> > 
> > > I'm not even sure why this is needed as this completely breaks
> > > setting
> > > the alarm time.
> > 
> > Or overrides the alarm time, :)
> > 
> > People rely on the rtc alarm in the automated suspend stress test,
> > which suspend and resume the system for over 1000 iterations.
> > As I mentioned in the cover letter of this patch series, if the
> > system
> > suspend time varies from under 1 second to over 60 seconds, how to
> > alarm the RTC before suspend?
> > This feature is critical in this scenario.
> > 
> > Plus, the current solution is transparent to people who don't
> > known/use
> > this "rtc_wake_override_sec" parameter. And for people who use
> > this,
> > they should know that the previous armed RTC alarm will be overrode
> > whenever a system suspend is triggered. I can add a message when
> > the
> > parameter is set, if needed.
> > 
> 
> It is not transparent, if I read your patch properly, this breaks
> wakeup
> for everyone...
> 
> > > On 05/05/2022 09:58:14+0800, Zhang Rui wrote:
> > > > +static int cmos_pm_notify(struct notifier_block *nb, unsigned
> > > > long
> > > > mode, void *_unused)
> > > > +{
> > > > +	struct cmos_rtc *cmos = container_of(nb, struct
> > > > cmos_rtc,
> > > > pm_nb);
> > > > +	struct rtc_device       *rtc = cmos->rtc;
> > > > +	unsigned long           now;
> > > > +	struct rtc_wkalrm       alm;
> > > > +
> > > > +	if (rtc_wake_override_sec == 0)
> > > > +		return NOTIFY_OK;
> > > > +
> > > > +	switch (mode) {
> > > > +	case PM_SUSPEND_PREPARE:
> > > > +		/*
> > > > +		 * Cancel the timer to make sure it won't fire
> > > > +		 * before rtc is rearmed later.
> > > > +		 */
> > > > +		rtc_timer_cancel(rtc, &rtc->aie_timer);
> > > > +		break;
> > > > +	case PM_SUSPEND_LATE:
> > > > +		if (rtc_read_time(rtc, &alm.time))
> > > > +			return NOTIFY_BAD;
> > > > +
> > > > +		now = rtc_tm_to_time64(&alm.time);
> > > > +		memset(&alm, 0, sizeof(alm));
> > > > +		rtc_time64_to_tm(now + rtc_wake_override_sec,
> > > > &alm.time);
> > > > +		alm.enabled = true;
> > > > +		if (rtc_set_alarm(rtc, &alm))
> > > > +			return NOTIFY_BAD;
> 
> ... because if rtc_wake_override_sec is not set, this sets the alarm
> to
> now which is the current RTC time, ensuring the alarm will never
> trigger.

No.
As the code below
> > > > 
> > > > 	if (rtc_wake_override_sec == 0)
> > > > +		return NOTIFY_OK;

We check for rtc_wake_override_sec at the beginning of the notifier
callback. So it takes effect only if a) rtc_wake_override_sec is set,
AND b) a suspend is triggered.

thanks,
rui


