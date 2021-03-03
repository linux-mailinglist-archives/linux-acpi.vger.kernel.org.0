Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937C332C442
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388041AbhCDAMF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:12:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:48141 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234126AbhCCSfu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Mar 2021 13:35:50 -0500
IronPort-SDR: ee6TOyeIEDuomTqbzXr3J0xgldnlusRCRozBGHoSdbR5BXugZotUPJNsvkYp7FAnWS0cwYje1C
 x93FCUUyly4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="174893768"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="174893768"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 10:34:02 -0800
IronPort-SDR: dNnm3riT/7iRr/+P6cRiMU4ZgdyvTBUh6WFIfxcQD/gSTHhF+ZJY/BVXlhzMZLktWhbLt3oJrC
 XD4jS0hoN94Q==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="407363306"
Received: from schen9-mobl.amr.corp.intel.com ([10.252.135.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 10:34:01 -0800
Subject: Re: [RFC PATCH v4 3/3] scheduler: Add cluster scheduler level for x86
To:     Peter Zijlstra <peterz@infradead.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, lenb@kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        msys.mizuma@gmail.com, valentin.schneider@arm.com,
        gregkh@linuxfoundation.org, jonathan.cameron@huawei.com,
        juri.lelli@redhat.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        aubrey.li@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, xuwei5@huawei.com, prime.zeng@hisilicon.com,
        guodong.xu@linaro.org, yangyicong@huawei.com,
        liguozhu@hisilicon.com, linuxarm@openeuler.org, hpa@zytor.com
References: <20210301225940.16728-1-song.bao.hua@hisilicon.com>
 <20210301225940.16728-4-song.bao.hua@hisilicon.com>
 <YD4T0qBBgR6fPbQb@hirez.programming.kicks-ass.net>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <a8474bae-5d9a-8c0b-766a-7188ed71320b@linux.intel.com>
Date:   Wed, 3 Mar 2021 10:34:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YD4T0qBBgR6fPbQb@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 3/2/21 2:30 AM, Peter Zijlstra wrote:
> On Tue, Mar 02, 2021 at 11:59:40AM +1300, Barry Song wrote:
>> From: Tim Chen <tim.c.chen@linux.intel.com>
>>
>> There are x86 CPU architectures (e.g. Jacobsville) where L2 cahce
>> is shared among a cluster of cores instead of being exclusive
>> to one single core.
> 
> Isn't that most atoms one way or another? Tremont seems to have it per 4
> cores, but earlier it was per 2 cores.
> 

Yes, older Atoms have 2 cores sharing L2.  I probably should
rephrase my comments to not leave the impression that sharing
L2 among cores is new for Atoms.

Tremont based Atom CPUs increases the possible load imbalance more
with 4 cores per L2 instead of 2.  And also with more overall cores on a die, the
chance increases for packing running tasks on a few clusters while leaving
others empty on light/medium loaded systems.  We did see
this effect on Jacobsville.

So load balancing between the L2 clusters is more
useful on Tremont based Atom CPUs compared to the older Atoms.

Tim
