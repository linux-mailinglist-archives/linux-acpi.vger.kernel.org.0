Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6F4734C76
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jun 2023 09:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjFSHk4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Jun 2023 03:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFSHk4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Jun 2023 03:40:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F324B1;
        Mon, 19 Jun 2023 00:40:53 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ql1pJ4PZZztQYY;
        Mon, 19 Jun 2023 15:38:16 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 19 Jun 2023 15:40:50 +0800
Subject: Re: [PATCH v4 1/4] acpi: Move common tables helper functions to
 common lib
To:     Dave Jiang <dave.jiang@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
References: <168677921156.2787985.6927511816148622557.stgit@djiang5-mobl3>
 <168677928492.2787985.344130142021460418.stgit@djiang5-mobl3>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <2ae8d202-8c0d-d7d7-dec6-ef95d823a433@huawei.com>
Date:   Mon, 19 Jun 2023 15:40:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <168677928492.2787985.344130142021460418.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2023/6/15 5:48, Dave Jiang wrote:
> Some of the routines in ACPI driver/acpi/tables.c can be shared with
> parsing CDAT. CDAT is a device-provided data structure that is formatted
> similar to a platform provided ACPI table. CDAT is used by CXL and can
> exist on platforms that do not use ACPI. Split out the common routine
> from ACPI to accommodate platforms that do not support ACPI and move that
> to /lib. The common routines can be built outside of ACPI if
> FIRMWARE_TABLES is selected.
> 
> Link: https://lore.kernel.org/linux-cxl/CAJZ5v0jipbtTNnsA0-o5ozOk8ZgWnOg34m34a9pPenTyRLj=6A@mail.gmail.com/
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> v4:
> - Add MAINTAINERS entry (Hanjun)
> - Move __init_or_acpilib outside CONFIG_ACPI (0-day)
> ---
>   MAINTAINERS              |    2
>   drivers/acpi/Kconfig     |    1
>   drivers/acpi/tables.c    |  173 ------------------------------------------
>   include/linux/acpi.h     |   42 +++-------
>   include/linux/fw_table.h |   43 ++++++++++
>   lib/Kconfig              |    3 +
>   lib/Makefile             |    2
>   lib/fw_table.c           |  189 ++++++++++++++++++++++++++++++++++++++++++++++
>   8 files changed, 251 insertions(+), 204 deletions(-)
>   create mode 100644 include/linux/fw_table.h
>   create mode 100644 lib/fw_table.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 250518fc70ff..2145438e00dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -371,6 +371,8 @@ F:	include/acpi/
>   F:	include/linux/acpi.h
>   F:	include/linux/fwnode.h
>   F:	tools/power/acpi/
> +F:	include/linux/fw_table.h
> +F:	lib/fw_table.c

I think it's better in alphabetical order, others look
good to me,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
