Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDBE460F02
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Nov 2021 07:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhK2G54 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Nov 2021 01:57:56 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27309 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhK2Gzz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Nov 2021 01:55:55 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J2bdB6VQrzbj6x;
        Mon, 29 Nov 2021 14:52:30 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 14:52:36 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 14:52:36 +0800
Subject: Re: [PATCH v3] acpi/tables: Add AEST in ACPI Table Definition
To:     Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lorenzo.pieralisi@arm.com>, <sudeep.holla@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>
References: <20211129061044.1779456-1-ishii.shuuichir@fujitsu.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <e721c474-1788-5edb-3ce9-26b1ec03b784@huawei.com>
Date:   Mon, 29 Nov 2021 14:52:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20211129061044.1779456-1-ishii.shuuichir@fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/11/29 14:10, Shuuichirou Ishii wrote:
> When We added AEST using the Upgrading ACPI tables via initrd function,
> the kernel could not recognize the AEST, so added the AEST table to
> the list to enable the table upgrade function.
> 
> Signed-off-by: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
> ---
> v3 : Changed the location of the change log so that it does not
>       disappear when the patch is applied.
> 
> v2 : The reason for committing in the commit log was not clear,
>       so it was pointed out and corrected.
> 
>   drivers/acpi/tables.c | 2 +-

Acked-by: Hanjun Guo <guohanjun@huawei.com>
