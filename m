Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D46A3B1A94
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jun 2021 14:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFWNAI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Jun 2021 09:00:08 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38663 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230019AbhFWNAI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Jun 2021 09:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1624453071; x=1655989071;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=15/CAV2snDdvyAJxjJ5PKrRh/F+DBXa8aHprIfhpyUU=;
  b=M+SFXFoWK8Hl7ISVGlRLBol2RTa2nfzAjsRO+8wMU6NVQ/iKy/PCZBn5
   CELXVUGPxLGgqr9Fph8/sDGancTgMzW6tfdeGgvwCeX3KYg00/sEeEvBR
   jmwpYuQBABP/oJJVM7BMo3Yw0dqavO00nhq617EJGeDU3JRngCkZgap+Q
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Jun 2021 05:57:50 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Jun 2021 05:57:49 -0700
Received: from [10.38.240.33] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 23 Jun
 2021 05:57:47 -0700
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
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
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
 <20210623041613.v2lo3nidpgw37abl@vireshk-i7>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
Date:   Wed, 23 Jun 2021 08:57:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623041613.v2lo3nidpgw37abl@vireshk-i7>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03d.na.qualcomm.com (10.85.0.91) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 6/23/2021 12:16 AM, Viresh Kumar wrote:
> On 21-06-21, 16:48, Qian Cai wrote:
>>
>>
>> On 6/21/2021 5:19 AM, Viresh Kumar wrote:
>>> CPPC cpufreq driver is used for ARM servers and this patch series tries to
>>> provide counter-based frequency invariance support for them in the absence for
>>> architecture specific counters (like AMUs).
>>
>> Viresh, this series works fine on my quick tests so far.
> 
> Do you want me to add your Tested-by for the series ?

Viresh, I am afraid I don't feel comfortable yet. I have a few new tests in development, and will provide an update once ready. Also, I noticed the delivered perf is even smaller than lowest_perf (100).

# cat /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs
 ref:103377547901 del:54540736873
# cat /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs
 ref:103379170101 del:54541599117

100 * (54541599117 - 54540736873) / (103379170101 - 103377547901) = 53

My understanding is that the delivered perf should fail into the range between lowest_perf and highest_perf. Is that assumption correct? This happens on 5.4-based kernel, so I am in process running your series on that system to see if there is any differences. In any case, if it is a bug it is pre-existing, but I'd like to understand a bit better in that front first.
