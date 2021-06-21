Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8863AF6FB
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jun 2021 22:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFUUvD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Jun 2021 16:51:03 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:14552 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229790AbhFUUvD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Jun 2021 16:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1624308530; x=1655844530;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3VRTmBGgxbNUCdwEHcZBa6NmCsXyGuWivDkf1Wx7pgM=;
  b=DHYv/grhJPbhuy2rgHUXSoJpdozBACPu4MMvfGYAuB0ZurF3N2weISbm
   stAeeVNUG8pi4M3fp4CW2YfEfUqWM9DDwF0NKkynqRMMcS1R9aSs2tXje
   GVpYG8Y8WkuBEIes7PQiZ0hJZLpsUZbeM8SMfiwLGJOgRB08UCKaqgfhE
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Jun 2021 13:48:49 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Jun 2021 13:48:48 -0700
Received: from [10.38.245.98] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 21 Jun
 2021 13:48:46 -0700
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
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
        Will Deacon <will@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
Date:   Mon, 21 Jun 2021 16:48:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1624266901.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 6/21/2021 5:19 AM, Viresh Kumar wrote:
> CPPC cpufreq driver is used for ARM servers and this patch series tries to
> provide counter-based frequency invariance support for them in the absence for
> architecture specific counters (like AMUs).

Viresh, this series works fine on my quick tests so far. BTW, I noticed some strange things even with the series applied mentioned below when reading acpi_cppc vs cpufreq sysfs. Do you happen to know are those just hardware/firmware issues because Linux just faithfully exported the register values?

== Arm64 server Foo ==
CPU max MHz:                     3000.0000
CPU min MHz:                     1000.0000

/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf
300
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq
1000
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf
200
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf
100
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq <--- should be 3000?
2800
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf <--- should be 300?
280
/sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf
100

== Arm64 server Bar ==
CPU max MHz:                     3000.0000
CPU min MHz:                     375.0000

/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf <--- should be 3000? There is no cpufreq boost.
3300
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq <--- don't understand why 0.
0
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf
375
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf
375
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq <--- ditto
0
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf
3000
/sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf
100
