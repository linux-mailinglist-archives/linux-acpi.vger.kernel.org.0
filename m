Return-Path: <linux-acpi+bounces-14-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BA67A90E6
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 04:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8671C2098A
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 02:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127655229
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 02:30:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7DA15A4
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 02:27:41 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC9B99;
	Wed, 20 Sep 2023 19:27:39 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RrfNK44YSzMlhR;
	Thu, 21 Sep 2023 10:24:01 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 21 Sep
 2023 10:27:36 +0800
Message-ID: <1b05f595-b485-5a7e-ad31-b19f462fe43f@huawei.com>
Date: Thu, 21 Sep 2023 10:27:36 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/2] soc: kunpeng_hccs: add the check for PCC subspace
 type
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <rafael@kernel.org>, <rafael.j.wysocki@intel.com>, <xuwei5@hisilicon.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<soc@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
References: <20230914115753.9064-1-lihuisong@huawei.com>
 <20230920064703.23543-1-lihuisong@huawei.com>
 <20230920064703.23543-3-lihuisong@huawei.com>
 <20230920141147.bq7cjiqjk6c36t6d@bogus>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230920141147.bq7cjiqjk6c36t6d@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


在 2023/9/20 22:11, Sudeep Holla 写道:
> On Wed, Sep 20, 2023 at 02:47:03PM +0800, Huisong Li wrote:
>> Currently, HCCS driver directly uses Generic Communications Channel Shared
>> Memory Region which is used in type0/1/2 to communicate with platform,
>> but actually doesn't support type3/4/5.
>> So this patch adds the check for PCC subspace type.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/soc/hisilicon/kunpeng_hccs.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
>> index f3810d9d1caa..4ba3bfd45a01 100644
>> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
>> @@ -174,6 +174,19 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
>>   	return rc;
>>   }
>>   
>> +static int hccs_check_pcc_info(struct hccs_dev *hdev)
>> +{
>> +	struct pcc_mbox_chan *pcc_chan = hdev->cl_info.pcc_chan;
>> +
>> +	if (pcc_chan->type >= ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE) {
>> +		dev_err(hdev->dev, "unsupport for subspace type%u.\n",
>> +			pcc_chan->type);
>> +		return -EOPNOTSUPP;
>> +	}
>   
> Is this the only use of the PCC type information you have or do you plan to
> use it for something other than the validation.
Yeah, it is just validation now. we want to plan this driver can support 
more types.
>
> Just for sake of argument, I can say all users of PCC must then do the
> similar validation. I don't know where to draw the line here.

If export PCC type, it is good for the user of PCC to be more universal 
and more compatible.

>
> Ideally I would expect the driver to make this transparent and give error
> during transmit if not supported.
I understand you.
I just check this type only once during the initializing phase.
Otherwise, every once need to verify it when send PCC command.
>
> The driver must be able to work with different PCC type to support variety
> of platforms TBH. What is the issue exactly here ? Is this to prevent the
Agree more with you.
IMO, the user of PCC has the ability to support variety of platforms if 
they can get PCC type.
In this case, to prevent type 4 is necessary if driver cannot act as a 
slave.
on the other hand, If one driver acts as a slave, platform must supply 
slave subspace for them.
> use of Type 4 ? I think we must do something better but I don't know what
> that is yet.

Yes, we can try to do it better. I have a concern, like below.

You know that the use of PCC can use polling mode and interrupt mode to 
communicate with platform.
I'm not sure if the obtaining of the polling mode and interrupt mode is 
an issue to prevent driver to be more universal.
But this driver can know if they support interrupt mode based on struct 
mbox_chan::struct mbox_controller::txdone_irq after requesting PCC channel.
Because I'm not sure it's a better way.
You know that drivers used interrupt mode need to fill the rx_callback 
function into mbx_client when register PCC channel.
And drivers used polling mode don't do it.
If we use this way, drivers that both support the two mode have to 
modify the rx_callback pointer after requesting PCC channel.
>

