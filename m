Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D873F4FD6
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Aug 2021 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhHWRu2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Aug 2021 13:50:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:7008 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231452AbhHWRu1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Aug 2021 13:50:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="196727115"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="196727115"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 10:49:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="597229956"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.14.9])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 10:49:33 -0700
Subject: Re: [PATCH 3/3] scheduler: Add cluster scheduler level for x86
To:     Barry Song <21cnbao@gmail.com>, bp@alien8.de,
        catalin.marinas@arm.com, dietmar.eggemann@arm.com,
        gregkh@linuxfoundation.org, hpa@zytor.com, juri.lelli@redhat.com,
        bristot@redhat.com, lenb@kernel.org, mgorman@suse.de,
        mingo@redhat.com, peterz@infradead.org, rjw@rjwysocki.net,
        sudeep.holla@arm.com, tglx@linutronix.de
Cc:     aubrey.li@linux.intel.com, bsegall@google.com,
        guodong.xu@linaro.org, jonathan.cameron@huawei.com,
        liguozhu@hisilicon.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, msys.mizuma@gmail.com,
        prime.zeng@hisilicon.com, rostedt@goodmis.org,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        will@kernel.org, x86@kernel.org, xuwei5@huawei.com,
        yangyicong@huawei.com, linuxarm@huawei.com,
        Barry Song <song.bao.hua@hisilicon.com>
References: <20210820013008.12881-1-21cnbao@gmail.com>
 <20210820013008.12881-4-21cnbao@gmail.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <32bcec89-57d5-65e3-970b-affcf4f41667@linux.intel.com>
Date:   Mon, 23 Aug 2021 10:49:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210820013008.12881-4-21cnbao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 8/19/21 6:30 PM, Barry Song wrote:
> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> There are x86 CPU architectures (e.g. Jacobsville) where L2 cahce is
> shared among a cluster of cores instead of being exclusive to one
> single core.
> To prevent oversubscription of L2 cache, load should be balanced
> between such L2 clusters, especially for tasks with no shared data.
> On benchmark such as SPECrate mcf test, this change provides a
> boost to performance especially on medium load system on Jacobsville.
> on a Jacobsville that has 24 Atom cores, arranged into 6 clusters
> of 4 cores each, the benchmark number is as follow:
> 
>  Improvement over baseline kernel for mcf_r
>  copies		run time	base rate
>  1		-0.1%		-0.2%
>  6		25.1%		25.1%
>  12		18.8%		19.0%
>  24		0.3%		0.3%
> 
> So this looks pretty good. In terms of the system's task distribution,
> some pretty bad clumping can be seen for the vanilla kernel without
> the L2 cluster domain for the 6 and 12 copies case. With the extra
> domain for cluster, the load does get evened out between the clusters.
> 
> Note this patch isn't an universal win as spreading isn't necessarily
> a win, particually for those workload who can benefit from packing.

I have another patch set to make cluster scheduling selectable at run
time and boot time.  Will like to see people's feed back on this patch
set first before sending that out.

Thanks.

Tim
