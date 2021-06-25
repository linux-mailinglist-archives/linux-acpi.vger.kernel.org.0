Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA3A3B447A
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jun 2021 15:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFYNeY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Jun 2021 09:34:24 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27913 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229615AbhFYNeX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Jun 2021 09:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1624627923; x=1656163923;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=c92uEGAxnyrw7O3VecCM/YRAymsWQVHnDR1PxIKS3zQ=;
  b=Nm/8Pu6RAEeRpS68bW+L2CFSDv/t9Q7Za7hJ4oaSqXDtT+8AoVgaDAsb
   TC7nHa9/FJXltEFYNb0Wws4oVZmZA6FZKr21ms2v3U5PZEG6Vii7jyhp4
   FwjP12ZVnbnoRcZsrHDGPqBhHdKIVZOwURwwYaKi5VYpUSeAfAgaEdAby
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Jun 2021 06:32:02 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Jun 2021 06:32:02 -0700
Received: from [10.111.161.13] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Jun
 2021 06:31:59 -0700
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
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <1f83d787-a796-0db3-3c2f-1ca616eb1979@quicinc.com>
Date:   Fri, 25 Jun 2021 09:31:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625102113.GB15540@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03e.na.qualcomm.com (10.85.0.48) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 6/25/2021 6:21 AM, Ionela Voinescu wrote:
>> scaling_driver: acpi_cppc
>                   ^^^^^^^^^
> I suppose you mean "cppc-cpufreq"?
> 
> "acpi_cppc" is not a scaling driver option.

Ionela, yes. Sorry about that.

> So your CPUs run at frequencies between 200MHz and 280MHz?

2000 to 2800 MHz.

> Based on your acpi_cppc information below I would have assumed 2GHz as
> lowest nonlinear and 2.8GHz as nominal. The reason for this is that
> according to the ACPI spec the frequency values in the _CPC objects are
> supposed to be in MHz, so 2800 MHz for nominal frequency would be
> 2.8GHz.
> 
> When you try more governors, make sure to check out the difference
> between scaling_cur_freq and cpuinfo_cur_freq at [2]. The first gives
> you the frequency that the governor (schedutil) is asking for, while the
> second is giving you the current frequency obtained from the counters.
> 
> So to check the actual frequency the cores are running at, please check
> cpuinfo_cur_freq.

The problem is that all CPUs are never scaling down. "cpuinfo_cur_freq" and "scaling_cur_freq" are always the 2800 MHz on all CPUs on this idle system. This looks like a regression somewhere as in 5.4-based kernel, I can see "cpuinfo_cur_freq" can go down to 2000 MHz in the same scenario. I'll bisect a bit unless you have better ideas?
