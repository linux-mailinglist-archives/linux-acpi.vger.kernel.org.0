Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF451CC021
	for <lists+linux-acpi@lfdr.de>; Sat,  9 May 2020 11:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgEIJ47 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 May 2020 05:56:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbgEIJ47 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 9 May 2020 05:56:59 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2FC11136FA923CE6980A;
        Sat,  9 May 2020 17:56:56 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Sat, 9 May 2020
 17:56:49 +0800
Subject: Re: [PATCH] ACPI/IORT: Remove the unused __get_pci_rid()
To:     Zenghui Yu <yuzenghui@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <sudeep.holla@arm.com>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
References: <20200509093430.1983-1-yuzenghui@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <3a2e10af-2999-89e4-fa21-95c1c6411a22@huawei.com>
Date:   Sat, 9 May 2020 17:56:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200509093430.1983-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/5/9 17:34, Zenghui Yu wrote:
> Since commit bc8648d49a95 ("ACPI/IORT: Handle PCI aliases properly for
> IOMMUs"), __get_pci_rid() has become actually unused and can be removed.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>

Looks good to me,

Acked-by: Hanjun Guo <guohanjun@huawei.com>

