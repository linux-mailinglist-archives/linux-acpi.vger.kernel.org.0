Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA5723842
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 08:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjFFG6E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Jun 2023 02:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjFFG6D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2023 02:58:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C16B2
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 23:58:02 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qb1T60cWTztQTy;
        Tue,  6 Jun 2023 14:55:38 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 14:57:58 +0800
Subject: Re: [PATCH] ACPI: bus: Consolidate all arm specific initialisation
 into acpi_arm_init()
To:     Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230605103550.2427459-1-sudeep.holla@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <a27f1809-a4f4-6ed6-6ef1-27ad2ec7cd83@huawei.com>
Date:   Tue, 6 Jun 2023 14:57:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20230605103550.2427459-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023/6/5 18:35, Sudeep Holla wrote:
> Move all of the ARM-specific initialization into one function namely
> acpi_arm_init(), so it is not necessary to modify/update bus.c every
> time a new piece of it is added.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Link: https://lore.kernel.org/r/CAJZ5v0iBZRZmV_oU+VurqxnVMbFN_ttqrL=cLh0sUH+=u0PYsw@mail.gmail.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/acpi/arm64/Makefile |  2 +-
>   drivers/acpi/arm64/agdi.c   |  2 +-
>   drivers/acpi/arm64/apmt.c   |  2 +-
>   drivers/acpi/arm64/init.c   | 10 ++++++++++
>   drivers/acpi/arm64/init.h   | 20 ++++++++++++++++++++
>   drivers/acpi/arm64/iort.c   |  1 +
>   drivers/acpi/bus.c          |  7 +------
>   include/linux/acpi.h        |  6 ++++++
>   include/linux/acpi_agdi.h   | 13 -------------
>   include/linux/acpi_apmt.h   | 19 -------------------
>   include/linux/acpi_iort.h   |  2 --
>   11 files changed, 41 insertions(+), 43 deletions(-)
>   create mode 100644 drivers/acpi/arm64/init.c
>   create mode 100644 drivers/acpi/arm64/init.h
>   delete mode 100644 include/linux/acpi_agdi.h
>   delete mode 100644 include/linux/acpi_apmt.h

I like this consolidation a lot,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
