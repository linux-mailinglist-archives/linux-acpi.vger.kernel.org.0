Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6583B7353
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 15:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhF2Nkx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 09:40:53 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:64887 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232535AbhF2Nkw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Jun 2021 09:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1624973905; x=1656509905;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qz8iBYKp3HmDU5GU2mZ52IEWoHzQQS4QwGIeJTIBkzI=;
  b=qdbPUtcBKddeCSLL4DZeKpF974HwEsTGZ97VCjgAXfzLoop3l9is1A4q
   XGDKCewWRRYxHvo2DeB0pRIFLByUVnomMERS5WlSVDJOveyznRIF+Pzuu
   C4FnbBFcW16gBP6CbrTz9JyeD0Vf/nm3yVxSgg8Ng6NUQ6zaLRiMcGbco
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Jun 2021 06:38:25 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 29 Jun 2021 06:38:24 -0700
Received: from [10.111.173.197] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 29 Jun
 2021 06:38:22 -0700
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
References: <20210623041613.v2lo3nidpgw37abl@vireshk-i7>
 <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
 <20210624025414.4iszkovggk6lg6hj@vireshk-i7>
 <CAKfTPtAXMYYrG1w-iwSWXb428FkwFArEwXQgHnjShoCEMjdYcw@mail.gmail.com>
 <20210624104734.GA11487@arm.com>
 <daf1ddf5-6f57-84a8-2ada-90590c0c94b5@quicinc.com>
 <20210625102113.GB15540@arm.com>
 <1f83d787-a796-0db3-3c2f-1ca616eb1979@quicinc.com>
 <20210625143713.GA7092@arm.com>
 <888b0178-00cc-ffa4-48a2-8563cef557a4@quicinc.com>
 <20210629090553.GC2425@arm.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <253b765a-c152-4640-36cc-09d873d029c4@quicinc.com>
Date:   Tue, 29 Jun 2021 09:38:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629090553.GC2425@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03g.na.qualcomm.com (10.85.0.49) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 6/29/2021 5:06 AM, Ionela Voinescu wrote:
>> Ionela, I found that set ACPI_PROCESSOR=y instead of ACPI_PROCESSOR=m
>> will fix the previous mentioned issues here (any explanations of that?)
>> even though the scaling down is not perfect. Now, we have the following
>> on this idle system:
>>
> 
> I don't see how this would have played a role. The cppc cpufreq driver
> depends on functionality gated by CONFIG_ACPI_CPPC_LIB which in turn
> needs CONFIG_ACPI_PROCESSOR to trigger the parsing of the _CPC objects.
> If CONFIG_ACPI_PROCESSOR functionality is not built in or loaded, the
> cppc cpufreq driver could not be used at all.

Ionela, that is fine. I can live with setting ACPI_PROCESSOR=y to workaround. I
was more of just curious about why manually loading processor.ko would set the
lowest to 2GHz instead of 1GHz.

Anyway, if running below the lowest is not the a concern, then I have concluded
my testing here. Feel free to include:

Tested-by: Qian Cai <quic_qiancai@quicinc.com>
