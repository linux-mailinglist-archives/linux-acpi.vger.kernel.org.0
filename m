Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB173B4BFA
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Jun 2021 04:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhFZCbz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Jun 2021 22:31:55 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:2457 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229782AbhFZCby (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Jun 2021 22:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1624674573; x=1656210573;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OzVDDKY5xaLH3FGbd2mDr5h3AyjjviKx2toZSojncrg=;
  b=irO7A5ACWUHR/cSxmXi6bWGOeyX8ob/elhPHO+TG6D3Ne4B5nD6RFI1c
   3g1RoJeEDyOZ+ezCQEL0JMRmu4dnVgN/fu8UIERvFoB06lKFAlWkZkvz1
   xm8eEpJmW99nQ3ew4gkY1lOo6Tx3SMlz3YuRPMd3xhnryJEdrnn5FMLP6
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Jun 2021 19:29:30 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Jun 2021 19:29:30 -0700
Received: from [10.111.161.13] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Jun
 2021 19:29:27 -0700
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
Message-ID: <888b0178-00cc-ffa4-48a2-8563cef557a4@quicinc.com>
Date:   Fri, 25 Jun 2021 22:29:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625143713.GA7092@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03h.na.qualcomm.com (10.85.0.50) To
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
> 
> If the 5.4 kernel you tried did not have these patches, it might be best
> to try next/master that has these patches, but with
> CONFIG_ACPI_CPPC_CPUFREQ_FIE=n, just to eliminate the possibility that
> an incorrect frequency scale factor here would affect utilization that
> would then affect the schedutil frequency selection. I would not expect
> this behavior even if the scale factor was wrong, but it would be good
> to rule out.
> 
> 2. Is your platform booting with all CPUs? Are any hotplug operations
> done in your scenario?

Ionela, I found that set ACPI_PROCESSOR=y instead of ACPI_PROCESSOR=m will fix the previous mentioned issues here (any explanations of that?) even though the scaling down is not perfect. Now, we have the following on this idle system:

# cat /sys/devices/system/cpu/*/cpufreq/cpuinfo_cur_freq | sort | uniq  -c
 	79 1000000
  	1 1160000
 	73 1400000
  	1 2000000
  	4 2010000
  	1 2800000
  	1 860000

Even if I rerun a few times, there could still have a few CPUs running lower than lowest_perf (1GHz). Also, even though I set all CPUs to use "userspace" governor and set freq to the lowest. A few CPUs keep changing at will.

# cat /sys/devices/system/cpu/*/cpufreq/cpuinfo_cur_freq | sort | uniq  -c
	156 1000000
  	3 2000000
  	1 760000
