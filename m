Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CE73B3814
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jun 2021 22:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhFXUrA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Jun 2021 16:47:00 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:34438 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230116AbhFXUrA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Jun 2021 16:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1624567480; x=1656103480;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=t61dWAbMMDRSTZHexoJmXU/Hc6CoxB6AF/BFYRLmSyg=;
  b=Bdqs5TgnQsKoKVZ3U230Ctws0YreyaoedmMKpiNGTpnfRm7ZWGzfxPxn
   ru9JJXdHT6vyzlHuxakk/D8DDMUqx/OYGL/h7AgT+7Luri3/7Y64sTFxF
   P/IgP+B9H5XZATaKER//htnZy1Nk6CIdgR8iLxa7Auqjl3PdnagBCwfai
   g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Jun 2021 13:44:40 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Jun 2021 13:44:39 -0700
Received: from [10.111.163.161] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 24 Jun
 2021 13:44:37 -0700
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
Message-ID: <81ea7ae0-54fd-85ba-b3de-a34520cb7f29@quicinc.com>
Date:   Thu, 24 Jun 2021 16:44:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624104734.GA11487@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03d.na.qualcomm.com (10.85.0.91) To
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

FYI, the latest data point it that on the new kernel, the delivered performance does match the cpufreq_cur_freq. IOW, feedback_ctrs works fine. Also, "powersave" governor could bring down the scaling_cur_freq to scaling_min_freq. Right now, looks like the puzzles on this particular system as mentioned in the previous post are,

1) lowest_freq/lowest_perf != scaling_min_freq
2) CPPC + schedutil is not able to scale down CPUs.
