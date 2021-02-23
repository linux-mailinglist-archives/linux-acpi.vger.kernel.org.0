Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FA23229AB
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Feb 2021 12:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhBWLvO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Feb 2021 06:51:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12200 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbhBWLvN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Feb 2021 06:51:13 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DlHPV4GyfzlNJW;
        Tue, 23 Feb 2021 19:48:30 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Feb 2021 19:50:25 +0800
Subject: Re: [PATCH v1 0/4] ACPI: Get rid of ACPICA message printing from core
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <5138173.kHyPcihzTF@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <daadf47e-dac2-93a8-3070-9e9cbc0dae50@huawei.com>
Date:   Tue, 23 Feb 2021 19:50:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5138173.kHyPcihzTF@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/2/23 2:57, Rafael J. Wysocki wrote:
> Hi All,
> 
> This series replaces ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() in the ACPI
> processor driver and sysfs code and drops definitions of related symbols
> that are not used for anything meaningful any more.
> 
> Please refer to the patch changelogs for details.

Except patch 1/4, others are looking good to me. some
legacy printk(PRIFIX ...) are still there, but we can
clean up them later.

Feel feel to add my review tag with minor issue addressed.

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
