Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1F470EC3
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2019 03:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbfGWBlr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jul 2019 21:41:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728086AbfGWBlr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jul 2019 21:41:47 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7D0567083CA7C08087D1;
        Tue, 23 Jul 2019 09:41:44 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Jul 2019
 09:41:34 +0800
Subject: Re: [PATCH] ACPI/IORT: Rename arm_smmu_v3_set_proximity() 'node'
 local variable
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-acpi@vger.kernel.org>
CC:     Will Deacon <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
References: <20190722161433.23027-1-lorenzo.pieralisi@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <7743b3e7-da5f-667d-9222-7ecab5a20876@huawei.com>
Date:   Tue, 23 Jul 2019 09:41:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190722161433.23027-1-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019/7/23 0:14, Lorenzo Pieralisi wrote:
> Commit 36a2ba07757d ("ACPI/IORT: Reject platform device creation on NUMA
> node mapping failure") introduced a local variable 'node' in
> arm_smmu_v3_set_proximity() that shadows the struct acpi_iort_node
> pointer function parameter.
> 
> Execution was unaffected but it is prone to errors and can lead
> to subtle bugs.
> 
> Rename the local variable to prevent any issue.
> 
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

