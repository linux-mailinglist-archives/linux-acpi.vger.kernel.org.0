Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30303B47A3
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jun 2021 18:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFYQ7A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Jun 2021 12:59:00 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:49765 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229671AbhFYQ66 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Jun 2021 12:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1624640198; x=1656176198;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZXtRMQWNJI+ejJwk7tELGIlfquZy8wE7UmEjYspURGY=;
  b=QZ+N/dWZGHjxCkW99sC0aR027XjDI4sdeUUXOppXfYDItedMTWCewdtR
   gsMBiSzI2fuELizIYF9YLxQd2VOtPWJ0/8oj9QTjSHdrHs6gmialfSBej
   aXYj345MKc88xI2SxRvfb0jsz0rzXR+4+3d5KZ32eMaruJU+yn0fHjby7
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Jun 2021 09:56:37 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Jun 2021 09:56:34 -0700
Received: from [10.111.161.13] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Jun
 2021 09:56:32 -0700
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
To:     Ionela Voinescu <ionela.voinescu@arm.com>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
 <20210623041613.v2lo3nidpgw37abl@vireshk-i7>
 <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
 <20210624025414.4iszkovggk6lg6hj@vireshk-i7>
 <CAKfTPtAXMYYrG1w-iwSWXb428FkwFArEwXQgHnjShoCEMjdYcw@mail.gmail.com>
 <20210624104734.GA11487@arm.com>
 <daf1ddf5-6f57-84a8-2ada-90590c0c94b5@quicinc.com>
 <20210625102113.GB15540@arm.com>
 <1f83d787-a796-0db3-3c2f-1ca616eb1979@quicinc.com>
 <20210625143713.GA7092@arm.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <6b86e8cb-6088-12f1-863e-c5e4062bef8e@quicinc.com>
Date:   Fri, 25 Jun 2021 12:56:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625143713.GA7092@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03b.na.qualcomm.com (10.85.0.98) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 6/25/2021 10:37 AM, Ionela Voinescu wrote:
> Quick questions for you:
> 
> 1. When you say you tried a 5.4 kernel, did you try it with these
> patches backported? They also have some dependencies with the recent
> changes in the arch topology driver and cpufreq so they would not be
> straight forward to backport.

No. It turned out that this 5.4-based kernel has "ondemand" governor by default which works fine which could even scale down to the lowest_perf (1000 MHz). Once switched the governor to "schedutil", it could keep the freq to the lowest. While on the latest kernel, it also works fine by using "ondemand" first and then switch to "schedutil". Even though it can only scale down to lowest_nonlinear_perf (2000 MHz). It is more of that using "schedutil" by default would not work. Also, on the latest kernel, even "userspace" governor only allows to scale down to 2000 MHz.

> If the 5.4 kernel you tried did not have these patches, it might be best
> to try next/master that has these patches, but with
> CONFIG_ACPI_CPPC_CPUFREQ_FIE=n, just to eliminate the possibility that
> an incorrect frequency scale factor here would affect utilization that
> would then affect the schedutil frequency selection. I would not expect
> this behavior even if the scale factor was wrong, but it would be good
> to rule out.

I'll try that at least see if CONFIG_ACPI_CPPC_CPUFREQ_FIE=n would make the latest kernel to be able to scale down to 1000 MHz.

> 2. Is your platform booting with all CPUs? Are any hotplug operations
> done in your scenario?

Yes, booting with all CPUs. No additional hotplug there.
