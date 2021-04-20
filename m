Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3212365F4A
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 20:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhDTScS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Apr 2021 14:32:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:10300 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233381AbhDTScR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 20 Apr 2021 14:32:17 -0400
IronPort-SDR: Ur1in0XaMSYybqyUAYOstIldPbrkjKlf2Kjj9IsUfmMQTISbZPJkfMNl4oK6CFSvnvsS4Tqohd
 zfM9LckAbslw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="175670165"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="175670165"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:31:45 -0700
IronPort-SDR: nI6XlCRoQqyX9gVpSOBF3qh4q1h3IJIBuTQNtvecQ++HW1wKk1jlLPR3I/IZgycW99ThL2Hsw5
 c7CHtZTjtZcQ==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="427099403"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.244.102])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:31:44 -0700
Subject: Re: [RFC PATCH v5 4/4] scheduler: Add cluster scheduler level for x86
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>
Cc:     "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "hpa@zytor.com" <hpa@zytor.com>
References: <20210319041618.14316-1-song.bao.hua@hisilicon.com>
 <20210319041618.14316-5-song.bao.hua@hisilicon.com>
 <110234d1-22ce-8a9a-eabb-c15ac29a5dcd@linux.intel.com>
 <67cc380019fd40d88d7a493b6cbc0852@hisilicon.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <422b5d06-ec0e-f064-32fe-15df5b2957dd@linux.intel.com>
Date:   Tue, 20 Apr 2021 11:31:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <67cc380019fd40d88d7a493b6cbc0852@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 3/23/21 4:21 PM, Song Bao Hua (Barry Song) wrote:

>>
>> On 3/18/21 9:16 PM, Barry Song wrote:
>>> From: Tim Chen <tim.c.chen@linux.intel.com>
>>>
>>> There are x86 CPU architectures (e.g. Jacobsville) where L2 cahce
>>> is shared among a cluster of cores instead of being exclusive
>>> to one single core.
>>>
>>> To prevent oversubscription of L2 cache, load should be
>>> balanced between such L2 clusters, especially for tasks with
>>> no shared data.
>>>
>>> Also with cluster scheduling policy where tasks are woken up
>>> in the same L2 cluster, we will benefit from keeping tasks
>>> related to each other and likely sharing data in the same L2
>>> cluster.
>>>
>>> Add CPU masks of CPUs sharing the L2 cache so we can build such
>>> L2 cluster scheduler domain.
>>>
>>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>>> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>>
>>
>> Barry,
>>
>> Can you also add this chunk to the patch.
>> Thanks.
> 
> Sure, Tim, Thanks. I'll put that into patch 4/4 in v6.
> 

Barry,

This chunk will also need to be added to return cluster id for x86.
Please add it in your next rev.

Thanks.

Tim

---

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 800fa48c9fcd..2548d824f103 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -109,6 +109,7 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
+#define topology_cluster_id(cpu)		(per_cpu(cpu_l2c_id, cpu))
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
 extern unsigned int __max_die_per_package;
