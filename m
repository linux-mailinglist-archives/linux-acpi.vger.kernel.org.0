Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC5F811FD58
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 04:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfLPDt7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 15 Dec 2019 22:49:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbfLPDt7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 15 Dec 2019 22:49:59 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C76EB634CA425675EF14;
        Mon, 16 Dec 2019 11:49:56 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 16 Dec 2019
 11:49:50 +0800
Subject: Re: [PATCH] ACPI/IORT: fix the iort_id_map function
To:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20191215203303.29811-1-pankaj.bansal@nxp.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <ffc5a6e9-cac3-d6c6-fe16-745b4f9e481f@huawei.com>
Date:   Mon, 16 Dec 2019 11:49:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20191215203303.29811-1-pankaj.bansal@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Pankaj,

On 2019/12/15 23:12, Pankaj Bansal wrote:
> As per http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf
> in ID mappings:
> Number of IDs = The number of IDs in the range minus one.

Hmm, the spec is confusing, the spec may need to be updated, for example,
for a PCI bus, device ID + function ID will take 8 bits and will be 256
IDs for that PCI bus, not sure why we need to minus one.

> 
> Therefore, it's valid for ID mapping to contain single device mapping which
> would have Number of IDs field 0.

Why not use single mapping flag for this case?

Thanks
Hanjun

