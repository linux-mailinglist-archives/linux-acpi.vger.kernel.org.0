Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B00324F48
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Feb 2021 12:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBYLc4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 06:32:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13087 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbhBYLcf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Feb 2021 06:32:35 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DmVvV632zz165qQ;
        Thu, 25 Feb 2021 19:30:14 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Feb 2021 19:31:45 +0800
Subject: Re: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the SMMUv3
 subtable
To:     <devel@acpica.org>, <linux-acpi@vger.kernel.org>
CC:     <Robert.Moore@intel.com>, <erik.kaneda@intel.com>,
        <robin.murphy@arm.com>, <rafael.j.wysocki@intel.com>,
        <guohanjun@huawei.com>, <wanghaibin.wang@huawei.com>,
        Kunkun Jiang <jiangkunkun@huawei.com>
References: <20210225112620.1827-1-yuzenghui@huawei.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <319c8bd0-21f2-2e25-b1c9-a70697f9d315@huawei.com>
Date:   Thu, 25 Feb 2021 19:31:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210225112620.1827-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/2/25 19:26, Zenghui Yu wrote:
> As per the IORT spec, this field overrides the value in SMMU_IRD0.HTTU

s/SMMU_IRD0/SMMU_IDR0/
