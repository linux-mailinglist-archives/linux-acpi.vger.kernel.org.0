Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E7D52BEBA
	for <lists+linux-acpi@lfdr.de>; Wed, 18 May 2022 17:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbiEROqJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 10:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbiEROqC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 10:46:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F4810FC0;
        Wed, 18 May 2022 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652885161; x=1684421161;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gXoZ0ellxDf5DW/hOT3AppLjG2uBvaTOmGsHg3Apdkc=;
  b=imHYQhpNeh5P0m3jb3IaA4jFAKZMj3uy9JqxNWmouTSoaIEmPS9cE/Uc
   EHlTiph8oC4nreADni7AQyI+zsCB1ljxWX7/sqi+FRQZRjevdLJIZBDT3
   8HYelzQqK4NC9vheElZMkcAlrSQtxjvzNNVyfoWSNn6EKy0rg0J0VI/on
   z0yFfmSuvjrSmMyGuB3cuez0OWs9sD6uVzS2N4/MCXIQi3s1hPJp9VtOD
   y+BRhE9U1AJF0eF4AahYzqQaqKQ0eK1N+1x9DhNo4R1IfGdRJDEfiV2RF
   lK6w72zBjr0tlhY9RK0pmQkvYTFE65RCRmaXkDTl4RHyzoDEKSSlEwNxn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="252226059"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="252226059"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 07:44:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="569503708"
Received: from zhenyan1-mobl1.ccr.corp.intel.com ([10.249.171.228])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 07:44:49 -0700
Message-ID: <2dc4aa933d07add206a2aeefa15a4837aca6ff62.camel@intel.com>
Subject: Re: [PATCH 7/7] rtc: cmos: Add suspend/resume endurance testing hook
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
Date:   Wed, 18 May 2022 22:44:46 +0800
In-Reply-To: <CAJZ5v0jt1OND_d08mC0TC1LZ-JGANDY5fiDmH5RUfdtRk1vZFw@mail.gmail.com>
References: <20220505015814.3727692-1-rui.zhang@intel.com>
         <20220505015814.3727692-8-rui.zhang@intel.com>
         <CAJZ5v0jt1OND_d08mC0TC1LZ-JGANDY5fiDmH5RUfdtRk1vZFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 2022-05-17 at 17:14 +0200, Rafael J. Wysocki wrote:
> On Thu, May 5, 2022 at 3:58 AM Zhang Rui <rui.zhang@intel.com> wrote:
> > 
> > Automated suspend/resume testing uses the RTC for wakeup.
> > A short rtcwake period is desirable, so that more suspend/resume
> > cycles can be completed, while the machine is available for
> > testing.
> > 
> > But if too short a wake interval is specified, the event can occur,
> > while still suspending, and then no event wakes the suspended
> > system
> > until the user notices that testing has stalled, and manually
> > intervenes.
> 
> If the wakeup event occurs while still suspending, it should abort
> the
> suspend in progress, shouldn't it?  But the above implies that it
> doesn't do that.
> 
> If this is fixed, wouldn't it address the issue at hand?

I think the rootcause of the original problem is that
1. on some systems, the ACPI RTC Fixed event is used during suspend
only, and the ACPI Fixed event is enabled in the rtc-cmos driver
.suspend() callback
and
2. if the RTC Alarm already expires before .suspend() invoked, we will
lose the ACPI RTC Fixed Event as well as the wakeup event, say 20
seconds delay in freeze processes.

But, even if that problem is fixed, the suspend aborts and "fails" as
expected, this is still a problem for the suspend-automation scenario,
because the system actually can suspend successfully if we don't set
the RTC alarm too aggressively. And in PCH overheating case, surely we
will get false alarms, because we will never use a 60s+ rtc alarm for
suspend-automation.

thanks,
rui



