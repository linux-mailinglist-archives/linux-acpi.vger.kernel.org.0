Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90E5D3695
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2019 02:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfJKAyA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Oct 2019 20:54:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727518AbfJKAx7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Oct 2019 20:53:59 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DAD81C24DE4D932AB452;
        Fri, 11 Oct 2019 08:53:57 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 11 Oct 2019
 08:53:50 +0800
Subject: Re: [RFC PATCH 0/3] ACPI, arm64: Backport for ACPI PPTT 6.3 thread
 flag for stable 4.19.x
To:     John Garry <john.garry@huawei.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robert.moore@intel.com>, <erik.schmauss@intel.com>,
        <sudeep.holla@arm.com>, <rrichter@marvell.com>,
        <jeremy.linton@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linuxarm@huawei.com>, <gregkh@linuxfoundation.org>,
        <wanghuiqiang@huawei.com>
References: <1570714192-236724-1-git-send-email-john.garry@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <ed2ce119-dd68-131c-72e9-e95fc8fc6465@huawei.com>
Date:   Fri, 11 Oct 2019 08:53:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1570714192-236724-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi John,

On 2019/10/10 21:29, John Garry wrote:
> This series is a backport of the ACPI PPTT 6.3 thread flag feature for
> supporting arm64 systems.
> 
> The background is that some arm64 implementations are broken, in that they
> incorrectly advertise that a CPU is mutli-threaded, when it is not - the
> HiSilicon Taishanv110 rev 2, aka tsv110, being an example.
> 
> This leads to the system topology being incorrect. The reason being that
> arm64 topology code uses a combination of ACPI PPTT (Processor Properties
> Topology Table) and the system MPIDR (Multiprocessor Affinity Register) MT
> bit to determine the topology.
> 
> Until ACPI 6.3, the PPTT did not have any method to determine whether
> a CPU was multi-threaded, so only the MT bit is used - hence the
> broken topology for some systems.
> 
> In ACPI 6.3, a PPTT thread flag was introduced, which - when supported -
> would be used by the kernel to determine really if a CPU is multi-threaded
> or not, so that we don't get incorrect topology.

Thanks for doing this, and this patch set fix my CPU topology issue
in 4.19 kernel with updated firmware.

> 
> Note: I'm sending this as an RFC before sending to stable proper. I also
> have a 5.2 and 5.3 backport which are almost the same, and only
> significant change being that the ACPICA patch is not required.

5.2 stable was end of life, so only 4.19 and 5.3 are needed I think.

Thanks
Hanjun

