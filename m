Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BADF847D3B
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2019 10:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfFQIhF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jun 2019 04:37:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18585 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727424AbfFQIhF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Jun 2019 04:37:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7645971360ECAA5C908A;
        Mon, 17 Jun 2019 16:37:01 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Jun 2019
 16:36:57 +0800
Subject: Re: [PATCH v4 0/4] arm64: SPE ACPI enablement
To:     Jeremy Linton <jeremy.linton@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <mark.rutland@arm.com>,
        <lorenzo.pieralisi@arm.com>, <sudeep.holla@arm.com>
References: <20190615010910.33921-1-jeremy.linton@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <7215e7f2-b8d3-999e-427b-428282765276@huawei.com>
Date:   Mon, 17 Jun 2019 16:36:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190615010910.33921-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019/6/15 9:09, Jeremy Linton wrote:
> This patch series enables the Arm Statistical Profiling
> Extension (SPE) on ACPI platforms.
> 
> This is possible because ACPI 6.3 uses a previously
> reserved field in the MADT to store the SPE interrupt
> number, similarly to how the normal PMU is described.
> If a consistent valid interrupt exists across all the
> cores in the system, a platform device is registered.
> That then triggers the SPE module, which runs as normal.
> 
> We also add the ability to parse the PPTT for IDENTICAL
> cores. We then use this to sanity check the single SPE
> device we create. This creates a bit of a problem with
> respect to the specification though. The specification
> says that its legal for multiple tree's to exist in the
> PPTT. We handle this fine, but what happens in the
> case of multiple tree's is that the lack of a common
> node with IDENTICAL set forces us to assume that there
> are multiple non-IDENTICAL cores in the machine.
> 
> v3->v4: Rebase to 5.2.
> 	Minor formatting, patch rearrangement.
> 	Add missing `inline` in static header definition.
> 	Drop ARM_SPE_ACPI and just use ARM_SPE_PMU.

Tested on top of 5.2-rc1, I can see in the boot log:

arm_spe_pmu arm,spe-v1: probed for CPUs 0-95 [max_record_sz 128, align 4, features 0x7]

and I also tested perf record, and works as expected,

Tested-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

