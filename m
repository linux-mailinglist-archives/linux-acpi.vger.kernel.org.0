Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9077F346D98
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Mar 2021 23:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhCWWwW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Mar 2021 18:52:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:44363 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234056AbhCWWvz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Mar 2021 18:51:55 -0400
IronPort-SDR: NnElrSfJ4mwaF0v2TgwEluAe1KJjkp17LrTA77P6lS5zvopDznpFw9+i1xjYVidv+/VowSFJzm
 2l26z3+R7zMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="187267071"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="187267071"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 15:51:55 -0700
IronPort-SDR: b3cIenSAHtIFrqMGBdnds/IuZBprUlUsf22giSkWhZFX1rZFMzweJYHNEdVXFSZecVvl1JvoGO
 rRFiSYJbkKLQ==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="607897422"
Received: from schen9-mobl.amr.corp.intel.com ([10.255.229.173])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 15:50:50 -0700
Subject: Re: [RFC PATCH v5 4/4] scheduler: Add cluster scheduler level for x86
To:     Barry Song <song.bao.hua@hisilicon.com>, catalin.marinas@arm.com,
        will@kernel.org, rjw@rjwysocki.net, vincent.guittot@linaro.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        lenb@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     msys.mizuma@gmail.com, valentin.schneider@arm.com,
        gregkh@linuxfoundation.org, jonathan.cameron@huawei.com,
        juri.lelli@redhat.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        aubrey.li@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, xuwei5@huawei.com, prime.zeng@hisilicon.com,
        guodong.xu@linaro.org, yangyicong@huawei.com,
        liguozhu@hisilicon.com, linuxarm@openeuler.org, hpa@zytor.com
References: <20210319041618.14316-1-song.bao.hua@hisilicon.com>
 <20210319041618.14316-5-song.bao.hua@hisilicon.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <110234d1-22ce-8a9a-eabb-c15ac29a5dcd@linux.intel.com>
Date:   Tue, 23 Mar 2021 15:50:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210319041618.14316-5-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 3/18/21 9:16 PM, Barry Song wrote:
> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> There are x86 CPU architectures (e.g. Jacobsville) where L2 cahce
> is shared among a cluster of cores instead of being exclusive
> to one single core.
> 
> To prevent oversubscription of L2 cache, load should be
> balanced between such L2 clusters, especially for tasks with
> no shared data.
> 
> Also with cluster scheduling policy where tasks are woken up
> in the same L2 cluster, we will benefit from keeping tasks
> related to each other and likely sharing data in the same L2
> cluster.
> 
> Add CPU masks of CPUs sharing the L2 cache so we can build such
> L2 cluster scheduler domain.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>


Barry,

Can you also add this chunk to the patch.
Thanks.

Tim


diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 2a11ccc14fb1..800fa48c9fcd 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -115,6 +115,7 @@ extern unsigned int __max_die_per_package;
 
 #ifdef CONFIG_SMP
 #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
+#define topology_cluster_cpumask(cpu)		(cpu_clustergroup_mask(cpu))
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
 
