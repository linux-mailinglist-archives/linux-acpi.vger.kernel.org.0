Return-Path: <linux-acpi+bounces-255-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C33A7B1C8E
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0DCF428314F
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 12:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3348BF6
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 12:35:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F34746A
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 11:30:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804539C;
	Thu, 28 Sep 2023 04:30:47 -0700 (PDT)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RxB4t2kDlztSyt;
	Thu, 28 Sep 2023 19:26:22 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm000004.china.huawei.com
 (7.193.23.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 28 Sep
 2023 19:30:44 +0800
Message-ID: <8689e2aa-5fbd-cf9d-d168-a72669aea5ed@huawei.com>
Date: Thu, 28 Sep 2023 19:30:44 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 4/4] soc: kunpeng_hccs: Migrate to use generic PCC
 shmem related macros
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-hwmon@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andi Shyti
	<andi.shyti@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
	<linux@roeck-us.net>
References: <20230927-pcc_defines-v2-0-0b8ffeaef2e5@arm.com>
 <20230927-pcc_defines-v2-4-0b8ffeaef2e5@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230927-pcc_defines-v2-4-0b8ffeaef2e5@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000004.china.huawei.com (7.193.23.18)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

lgtm,
Reviewed-by: Huisong Li <lihuisong@huawei.com>


在 2023/9/28 0:26, Sudeep Holla 写道:
> Use the newly defined common and generic PCC shared memory region
> related macros in this driver to replace the locally defined ones.
>
> Cc: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/soc/hisilicon/kunpeng_hccs.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
> index f3810d9d1caa..27a96cafd1ea 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
> @@ -31,10 +31,6 @@
>   
>   #include "kunpeng_hccs.h"
>   
> -/* PCC defines */
> -#define HCCS_PCC_SIGNATURE_MASK		0x50434300
> -#define HCCS_PCC_STATUS_CMD_COMPLETE	BIT(0)
> -
>   /*
>    * Arbitrary retries in case the remote processor is slow to respond
>    * to PCC commands
> @@ -187,7 +183,7 @@ static int hccs_check_chan_cmd_complete(struct hccs_dev *hdev)
>   	 * deadline_us(timeout_us) until PCC command complete bit is set(cond)
>   	 */
>   	ret = readw_poll_timeout(&comm_base->status, status,
> -				 status & HCCS_PCC_STATUS_CMD_COMPLETE,
> +				 status & PCC_STATUS_CMD_COMPLETE,
>   				 HCCS_POLL_STATUS_TIME_INTERVAL_US,
>   				 cl_info->deadline_us);
>   	if (unlikely(ret))
> @@ -208,7 +204,7 @@ static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
>   	int ret;
>   
>   	/* Write signature for this subspace */
> -	tmp.signature = HCCS_PCC_SIGNATURE_MASK | hdev->chan_id;
> +	tmp.signature = PCC_SIGNATURE | hdev->chan_id;
>   	/* Write to the shared command region */
>   	tmp.command = cmd;
>   	/* Clear cmd complete bit */
>

