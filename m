Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4A852BCE2
	for <lists+linux-acpi@lfdr.de>; Wed, 18 May 2022 16:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbiEROL3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 10:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238571AbiEROLN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 10:11:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3210DBBE;
        Wed, 18 May 2022 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652883072; x=1684419072;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M9I9fQ/4b004eaPqCWILxpXuWE4PMN1HRcRIEnUtL7Q=;
  b=n514XNfYivaWbi+UJ89rna5c1o82JIWysC5uMZJVpkK5OwE05ngw2hfa
   sbW5mHvaEtdjKEn+3MZLa8YrzOXrXgNkbBJggwB9LhD7T2Cy+SrjhKJti
   QFOcWV/ml9PS0SjdGrJxW8D/++8U53lwJde969fku66YWvLjSM09hRYyN
   Kq4veATBf/barhwA0NVtfN8QzpD22aQj8WBN6tuWgAjOTYhTrOww4lQJ3
   LE7jerr+OCg7hfXNn5GRtyK0BUQpSvUGkJQhbwobqs0DmoUpEoJAeOYtK
   VF8ZdJlMnzCB/tTRpdUI6iDVd1r/6FBHsrHrkaAt85tQqYpZnh9QFo5CE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="334735484"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="334735484"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 07:11:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="569487380"
Received: from zhenyan1-mobl1.ccr.corp.intel.com ([10.249.171.228])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 07:11:08 -0700
Message-ID: <f1200b880b05d1d24c7bfebe9f359979dc1feabd.camel@intel.com>
Subject: Re: [PATCH 0/7] PM: Solution for S0ix failure caused by PCH
 overheating
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
Date:   Wed, 18 May 2022 22:11:05 +0800
In-Reply-To: <CAJZ5v0gj=zOF-9sMaWtWbPm7051W31qbJsK25bceeAe693Wj3g@mail.gmail.com>
References: <20220505015814.3727692-1-rui.zhang@intel.com>
         <CAJZ5v0gj=zOF-9sMaWtWbPm7051W31qbJsK25bceeAe693Wj3g@mail.gmail.com>
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

Hi, Rafael,

On Tue, 2022-05-17 at 17:11 +0200, Rafael J. Wysocki wrote:
> On Thu, May 5, 2022 at 3:58 AM Zhang Rui <rui.zhang@intel.com> wrote:
> > 
> > On some Intel client platforms like SKL/KBL/CNL/CML, there is a
> > PCH thermal sensor that monitors the PCH temperature and blocks the
> > system
> > from entering S0ix in case it overheats.
> > 
> > Commit ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due to
> > PCH
> > temperature above threshold") introduces a delay loop to cool the
> > temperature down for this purpose.
> > 
> > However, in practice, we found that the time it takes to cool the
> > PCH down
> > below threshold highly depends on the initial PCH temperature when
> > the
> > delay starts, as well as the ambient temperature.
> > 
> > For example, on a Dell XPS 9360 laptop, the problem can be
> > triggered
> > 1. when it is suspended with heavy workload running.
> > or
> > 2. when it is moved from New Hampshire to Florida.
> > 
> > In these cases, the 1 second delay is not sufficient. As a result,
> > the
> > system stays in a shallower power state like PCx instead of S0ix,
> > and
> > drains the battery power, without user' notice.
> > 
> > In this patch series, we first fix the problem in patch 1/7 ~ 3/7,
> > by
> > 1. expand the default overall cooling delay timeout to 60 seconds.
> > 2. make sure the temperature is below threshold rather than equal
> > to it.
> > 3. move the delay to .suspend_noirq phase instead, in order to
> >    a) do the cooling when the system is in a more quiescent state
> >    b) be aware of wakeup events during the long delay, because some
> > wakeup
> >       events (ACPI Power button Press, USB mouse, etc) become valid
> > only
> >       in .suspend_noirq phase and later.
> > 
> > However, this potential long delay introduces a problem to our
> > suspend
> > stress automation test, because the delay makes it hard to predict
> > how
> > much time it takes to suspend the system.
> > As we want to do as much suspend iterations as possible in limited
> > time,
> > setting a 60+ seconds rtc alarm for suspend which usually takes
> > shorter
> > than 1 second is far beyond overkill.
> > 
> > Thus, in patch 4/7 ~ 7/7, a rtc driver hook is introduced, which
> > cancels
> > the armed rtc alarm in the beginning of suspend and then rearm the
> > rtc
> > alarm with a short interval (say, 2 second) right before system
> > suspended.
> > 
> > By running
> >  # echo 2 > /sys/module/rtc_cmos/parameters/rtc_wake_override_sec
> > before suspend, the system can be resumed by RTC alarm right after
> > it is
> > suspended, no matter how much time the suspend really takes.
> > 
> > This patch series has been tested on the same Dell XPS 9360 laptop
> > and
> > S0ix is 100% achieved across 1000+ s2idle iterations.
> 
> Overall, the first three patches in the series can go in without the
> rest, so let's put them into a separate series.
> 
> Patch [4/7] doesn't depend on the first three ones, so it can go in
> by itself.
> 
> Patch [5/7] is to be dropped anyway as per the earlier discussion.
> 
> Patch [6/7] is only needed to apply patch [7/7] which is
> controversial.
> 
> I think that we can drop or defer patches [6-7/7] for now.

This all sounds reasonable to me.
I will resend them separately.

-rui

