Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA66C28FEB8
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 08:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394463AbgJPG71 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 02:59:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394391AbgJPG70 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Oct 2020 02:59:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 917EF1C2B9DAEA29B522;
        Fri, 16 Oct 2020 14:59:23 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 16 Oct 2020 14:59:16 +0800
Subject: Re: [PATCH 1/1] ACPI/IORT: Fix doc warnings in iort.c
To:     Shiju Jose <shiju.jose@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linuxarm@huawei.com>
References: <20201014093139.1580-1-shiju.jose@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <c4987f7a-49b6-7c80-911d-1703fb6eb892@huawei.com>
Date:   Fri, 16 Oct 2020 14:59:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201014093139.1580-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/10/14 17:31, Shiju Jose wrote:
> Fix following warnings caused by mismatch between
> function parameters and function comments.
> 
> drivers/acpi/arm64/iort.c:55: warning: Function parameter or member 'iort_node' not described in 'iort_set_fwnode'
> drivers/acpi/arm64/iort.c:55: warning: Excess function parameter 'node' description in 'iort_set_fwnode'
> drivers/acpi/arm64/iort.c:682: warning: Function parameter or member 'id' not described in 'iort_get_device_domain'
> drivers/acpi/arm64/iort.c:682: warning: Function parameter or member 'bus_token' not described in 'iort_get_device_domain'
> drivers/acpi/arm64/iort.c:682: warning: Excess function parameter 'req_id' description in 'iort_get_device_domain'
> drivers/acpi/arm64/iort.c:1142: warning: Function parameter or member 'dma_size' not described in 'iort_dma_setup'
> drivers/acpi/arm64/iort.c:1142: warning: Excess function parameter 'size' description in 'iort_dma_setup'
> drivers/acpi/arm64/iort.c:1534: warning: Function parameter or member 'ops' not described in 'iort_add_platform_device'
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Acked-by: Hanjun Guo <guohanjun@huawei.com>
