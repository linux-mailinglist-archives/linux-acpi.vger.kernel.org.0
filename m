Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F4735E6BE
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Apr 2021 21:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbhDMTBF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Apr 2021 15:01:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:34357 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230397AbhDMTBE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Apr 2021 15:01:04 -0400
IronPort-SDR: S4Oy7l2ID2WDCBasHKZHaUkg3XwYVfIUGih/wbF16bgGrRpuJ+7m+i+HAoj76KknRwGbIYxrMW
 zOwTeaprXisw==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="279791308"
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="279791308"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 12:00:35 -0700
IronPort-SDR: YEYZ9PrUFNIeD52/0lbNqFpdYVSE/a+PNNIjh2WVNCHXLUZfot91z4rJjSy1FXquDjx8EX3LFd
 RrTQi7kdgTyg==
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="443533651"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.18.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 12:00:34 -0700
Subject: Re: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters and
 add cluster scheduler
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>
References: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
 <737932c9-846a-0a6b-08b8-e2d2d95b67ce@linux.intel.com>
 <20210108151241.GA47324@e123083-lin>
 <99c07bdf-02d1-153a-bd1e-2f4200cc67c5@linux.intel.com>
 <20210111092811.GB47324@e123083-lin>
 <4fdc781e-7385-2ae6-d9c9-3ec165f473c4@arm.com>
 <9201b56a29dd4dacb7d9fcbf307ca5ff@hisilicon.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <6e067798-5585-5169-38fc-77e173831af5@linux.intel.com>
Date:   Tue, 13 Apr 2021 12:00:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9201b56a29dd4dacb7d9fcbf307ca5ff@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/13/21 3:45 AM, Song Bao Hua (Barry Song) wrote:
> 
> 
>
> Right now in the main cases of using wake_affine to achieve
> better performance, processes are actually bound within one
> numa which is also a LLC in kunpeng920. 
> 
> Probably LLC=NUMA is also true for X86 Jacobsville, Tim?

In general for x86, LLC is partitioned at the sub-numa cluster level.  
LLC could be divided between sub-numa cluster within a NUMA node.
That said, for Jacobsville, we don't have sub-numa clusters
so LLC=NUMA is true for that platform. 

Tim
