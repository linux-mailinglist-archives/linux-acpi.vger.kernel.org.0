Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FC03B3269
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jun 2021 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhFXPUU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Jun 2021 11:20:20 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:52566 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231708AbhFXPUT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Jun 2021 11:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1624547880; x=1656083880;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=sAbysC06T03vfpgx6gVyg0DlqzJgM/bP3q40WfRjb4s=;
  b=uRFa1slBw5oyJZ49W/dnFjqTk57wdYLIVgShLt7zCLCZt3Rqz4WavV1c
   EVjURL1PBWnPtXwS7t+lghSSV4XHOfd29OUcryC1bdcXOK/5I6b7wSo9J
   SJtTcmBrDeQbOgQoTUg/cO8cxknYpYsRzFWwjJ54aBp/cszZnyJoq5TZ9
   E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Jun 2021 08:18:00 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Jun 2021 08:18:00 -0700
Received: from [10.111.163.161] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 24 Jun
 2021 08:17:56 -0700
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
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
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <daf1ddf5-6f57-84a8-2ada-90590c0c94b5@quicinc.com>
Date:   Thu, 24 Jun 2021 11:17:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624104734.GA11487@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 6/24/2021 6:48 AM, Ionela Voinescu wrote:
> Not if the counters are implemented properly. The kernel considers that
> both reference and delivered performance counters should stop or reset
> during idle. The kernel would not account for idle itself.
> 
> If the reference performance counter does not stop during idle, while
> the core performance counter (delivered) does stop, the behavior above
> should be seen very often.
> 
> Qian, do you see these small delivered performance values often or
> seldom?

Ionela, so I managed to upgrade the kernel on the system to today's linux-next which suppose to include this series. The delivered perf is now 280. However, scaling_min_freq (200 MHz) is not equal to lowest_perf (100).

scaling_driver: acpi_cppc
scaling_governor: schedutil

Is that normal because lowest_nonlinear_perf is 200? 

Also, on this pretty idle system, 158 of 160 CPUs are always running in max freq (280 MHz). The other 2 are running in 243 and 213 MHz according to scaling_cur_freq. Apparently, "schedutil" does not work proper on this system. I am going to try other governors to narrow down the issue a bit.

FYI, here is the acpi_cppc registers reading:

/sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs
ref:160705801 del:449594095
/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf
300
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq
1000
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf
200
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf
100
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq
2800
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf
280
/sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf
100
/sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time
18446744073709551615
