Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12E052BF07
	for <lists+linux-acpi@lfdr.de>; Wed, 18 May 2022 18:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbiERQIj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 12:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbiERQIh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 12:08:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A71B1A8E33;
        Wed, 18 May 2022 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652890117; x=1684426117;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vwPFdV0OOofwiF6H6fH/GIodsFAIrAmgW41cFNehEjY=;
  b=ENjDHeHQhClwWGkDhJEEH72kXUQYlbifxUOSxRF/kvDyrBrY8nVOljCe
   TqYtoG7xLSxNsfWyDuuSzl8BA5/ckIdhpxVAObGCu20mCO1gcF/UFyO6G
   cVbkUgIpuDshcGKjuMrPmOlVcsXV3nHi+NtQ33WBBRXF2MBxzp56rrEhq
   w4zgA7q2x3xIopKG+BDBwsriE6bKHnpXUNxZb0PuZjbJyF6j/qSZKnmz0
   ut+s46PEFcXixPMsB7yVz5SnIUdvXQ2NGTeNIe2QoXDeGxyPSFxApcP49
   e3WH2R9vlZj5VS3t0uzrJ6wD6crK6/njKXb4I4gHGdSMQp20jPsp63rUy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="253793388"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="253793388"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 09:07:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="597878764"
Received: from zhenyan1-mobl1.ccr.corp.intel.com ([10.249.171.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 09:07:14 -0700
Message-ID: <20ad397b7975775d69d6c0ea902ca362fa3cf395.camel@intel.com>
Subject: Re: [PATCH 7/7] rtc: cmos: Add suspend/resume endurance testing hook
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Date:   Thu, 19 May 2022 00:07:12 +0800
In-Reply-To: <CAJZ5v0h=pYZkbhN2EiYzUGn36Q4-2tMyzfUP0uyFO=Sybse4DA@mail.gmail.com>
References: <20220505015814.3727692-1-rui.zhang@intel.com>
         <20220505015814.3727692-8-rui.zhang@intel.com>
         <CAJZ5v0jt1OND_d08mC0TC1LZ-JGANDY5fiDmH5RUfdtRk1vZFw@mail.gmail.com>
         <2dc4aa933d07add206a2aeefa15a4837aca6ff62.camel@intel.com>
         <CAJZ5v0h=pYZkbhN2EiYzUGn36Q4-2tMyzfUP0uyFO=Sybse4DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2022-05-18 at 17:02 +0200, Rafael J. Wysocki wrote:
> On Wed, May 18, 2022 at 4:45 PM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > On Tue, 2022-05-17 at 17:14 +0200, Rafael J. Wysocki wrote:
> > > On Thu, May 5, 2022 at 3:58 AM Zhang Rui <rui.zhang@intel.com>
> > > wrote:
> > > > 
> > > > Automated suspend/resume testing uses the RTC for wakeup.
> > > > A short rtcwake period is desirable, so that more
> > > > suspend/resume
> > > > cycles can be completed, while the machine is available for
> > > > testing.
> > > > 
> > > > But if too short a wake interval is specified, the event can
> > > > occur,
> > > > while still suspending, and then no event wakes the suspended
> > > > system
> > > > until the user notices that testing has stalled, and manually
> > > > intervenes.
> > > 
> > > If the wakeup event occurs while still suspending, it should
> > > abort
> > > the
> > > suspend in progress, shouldn't it?  But the above implies that it
> > > doesn't do that.
> > > 
> > > If this is fixed, wouldn't it address the issue at hand?
> > 
> > I think the rootcause of the original problem is that
> > 1. on some systems, the ACPI RTC Fixed event is used during suspend
> > only, and the ACPI Fixed event is enabled in the rtc-cmos driver
> > .suspend() callback
> > and
> > 2. if the RTC Alarm already expires before .suspend() invoked, we
> > will
> > lose the ACPI RTC Fixed Event as well as the wakeup event, say 20
> > seconds delay in freeze processes.
> 
> Well, the RTC Fixed event can be armed in a PM/HIBERNATE notifier and
> if it fires before .suspend() runs, system wakeup can be triggered
> from there.

Agreed.

Len,
Do you recall any other case that we may miss the RTC wakeup event?

> 
> > But, even if that problem is fixed, the suspend aborts and "fails"
> > as
> > expected, this is still a problem for the suspend-automation
> > scenario,
> > because the system actually can suspend successfully if we don't
> > set
> > the RTC alarm too aggressively. And in PCH overheating case, surely
> > we
> > will get false alarms, because we will never use a 60s+ rtc alarm
> > for
> > suspend-automation.
> 
> I'm not sure why this is a problem.
> 
> It only means that occasionally the system will not reach the final
> "suspended" state, but that can happen regardless.

It is not a kernel problem.
It is a problem for suspend-automation. Because suspend-automation is
chasing for kernel suspend problems, and IMO, cases like suspend aborts
because of long suspend delay from PCH thermal driver are not kernel
problems.

It would be nice to leverage a kernel I/F to get rid of such issues, 
But if the patch is rejected, I agree we can live without it.

thanks,
rui




