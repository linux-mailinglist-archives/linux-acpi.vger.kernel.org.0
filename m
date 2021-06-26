Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91EF3B4EBE
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Jun 2021 15:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhFZNn6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Jun 2021 09:43:58 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:2731 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229518AbhFZNny (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 26 Jun 2021 09:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1624714892; x=1656250892;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=BexIPrr+P7AAObS1bvWIvUcR2OxWro+/IxJmIzFSTJA=;
  b=SCWp7F1wu/x5utbVkTDNDeknrAzcMUvejHBWeX6HXGYvw4JNJg1AIF8/
   eUyPEc5rCHIsu5IFmyztwMmnfJ26BPv1spp5pUvEgz3t3n62cJ23oOehB
   HzOTf8VAyNJ/bofO6LgVFjKjPfp/5hGdjVdgvBxI8cbiEeD6BehJdSLX/
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jun 2021 06:41:31 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Jun 2021 06:41:31 -0700
Received: from [10.111.161.5] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 26 Jun
 2021 06:41:28 -0700
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
From:   Qian Cai <quic_qiancai@quicinc.com>
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
 <888b0178-00cc-ffa4-48a2-8563cef557a4@quicinc.com>
Message-ID: <9096bdb2-2a38-6ba3-0315-f6e9bd5a4c0e@quicinc.com>
Date:   Sat, 26 Jun 2021 09:41:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <888b0178-00cc-ffa4-48a2-8563cef557a4@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03b.na.qualcomm.com (10.85.0.98) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 6/25/2021 10:29 PM, Qian Cai wrote:
> Ionela, I found that set ACPI_PROCESSOR=y instead of ACPI_PROCESSOR=m will fix the previous mentioned issues here (any explanations of that?) even though the scaling down is not perfect. Now, we have the following on this idle system:
> 
> # cat /sys/devices/system/cpu/*/cpufreq/cpuinfo_cur_freq | sort | uniq  -c
>  	79 1000000
>   	1 1160000
>  	73 1400000
>   	1 2000000
>   	4 2010000
>   	1 2800000
>   	1 860000
> 
> Even if I rerun a few times, there could still have a few CPUs running lower than lowest_perf (1GHz). Also, even though I set all CPUs to use "userspace" governor and set freq to the lowest. A few CPUs keep changing at will.
> 
> # cat /sys/devices/system/cpu/*/cpufreq/cpuinfo_cur_freq | sort | uniq  -c
> 	156 1000000
>   	3 2000000
>   	1 760000

Another date point is that set ACPI_CPPC_CPUFREQ_FIE=n fixed the issue that any CPU could run below the lowest freq.

schedutil:
# cat /sys/devices/system/cpu/*/cpufreq/cpuinfo_cur_freq | sort | uniq  -c
     80 1000000
     78 1400000
      1 2010000
      1 2800000

userspace:
# cat /sys/devices/system/cpu/*/cpufreq/cpuinfo_cur_freq | sort | uniq  -c
    158 1000000
      2 2000000
