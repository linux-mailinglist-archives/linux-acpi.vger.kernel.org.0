Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9252933C806
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Mar 2021 21:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhCOUxv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Mar 2021 16:53:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:46786 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231406AbhCOUxo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Mar 2021 16:53:44 -0400
IronPort-SDR: MoRRlM8tYjnSTFFbDhoBMJwsB3gsN5dbScw50vfZj5J+E94sVY9wrxv9FDpsrwyDVuZ4coF5DP
 ED15NoX5BLCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="168427514"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="168427514"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 13:53:43 -0700
IronPort-SDR: UmN7Xty5kJHpaJ/Bav3R7JijAPjfMYPsyCYhxow/JKYG8+zblTey/huYZLzx4L1gC4fkgjcUk2
 SyHS+3/tSMFQ==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="411972696"
Received: from schen9-mobl.amr.corp.intel.com ([10.252.129.167])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 13:53:43 -0700
Subject: Re: [Linuxarm] Re: [RFC PATCH v4 3/3] scheduler: Add cluster
 scheduler level for x86
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
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
References: <20210301225940.16728-1-song.bao.hua@hisilicon.com>
 <20210301225940.16728-4-song.bao.hua@hisilicon.com>
 <YD4T0qBBgR6fPbQb@hirez.programming.kicks-ass.net>
 <a8474bae-5d9a-8c0b-766a-7188ed71320b@linux.intel.com>
 <6d8940e227324c2c88474d9d0769c001@hisilicon.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <e23d04d3-723e-5733-a43a-601f58ecfee4@linux.intel.com>
Date:   Mon, 15 Mar 2021 13:53:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6d8940e227324c2c88474d9d0769c001@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


> It seems sensible the more CPU we get in the cluster, the more
> we need the kernel to be aware of its existence.
> 
> Tim, it is possible for you to bring up the cpu_cluster_mask and
> cluster_sibling for x86 so that the topology can be represented
> in sysfs and be used by scheduler? It seems your patch lacks this
> part.

You mean having something in /sys/devices/system/cpu/cpu0/topology
on cluster information so that an external program can 
affinitize to a cluster if it prefers to do so?

Tim  

> 
> BTW, I wonder if x86 can do some improvement on your KMP_AFFINITY
> by leveraging the cluster topology level.
> https://software.intel.com/content/www/us/en/develop/documentation/cpp-compiler-developer-guide-and-reference/top/optimization-and-programming-guide/openmp-support/openmp-library-support/thread-affinity-interface-linux-and-windows.html
> 
> KMP_AFFINITY has thread affinity modes like compact and scatter,
> it seems this "compact" and "scatter" can also use the cluster
> information as you see we are also struggling with the "compact"
> and "scatter" issues here in this patchset :-)
> 
> Thanks
> Barry
> 
