Return-Path: <linux-acpi+bounces-500-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA4E7BC4AC
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 06:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19630280CC6
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 04:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EF879CF
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 04:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924BC622
	for <linux-acpi@vger.kernel.org>; Sat,  7 Oct 2023 02:46:05 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0EBBD;
	Fri,  6 Oct 2023 19:46:02 -0700 (PDT)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S2V2N57KxzVlSD;
	Sat,  7 Oct 2023 10:42:36 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm000004.china.huawei.com
 (7.193.23.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 7 Oct
 2023 10:45:59 +0800
Message-ID: <8286dbfe-9807-5e68-533c-9bb321ee7855@huawei.com>
Date: Sat, 7 Oct 2023 10:45:55 +0800
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
	<liuyonglong@huawei.com>
References: <20230914115753.9064-1-lihuisong@huawei.com>
 <20230920064703.23543-1-lihuisong@huawei.com>
 <20230920064703.23543-3-lihuisong@huawei.com>
 <20230920141147.bq7cjiqjk6c36t6d@bogus>
 <1b05f595-b485-5a7e-ad31-b19f462fe43f@huawei.com>
 <20230929112736.iribjiwzk5wszb4k@bogus>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230929112736.iribjiwzk5wszb4k@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000004.china.huawei.com (7.193.23.18)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


在 2023/9/29 19:27, Sudeep Holla 写道:
> On Thu, Sep 21, 2023 at 10:27:36AM +0800, lihuisong (C) wrote:
>> 在 2023/9/20 22:11, Sudeep Holla 写道:
>>> On Wed, Sep 20, 2023 at 02:47:03PM +0800, Huisong Li wrote:
>>>> Currently, HCCS driver directly uses Generic Communications Channel Shared
>>>> Memory Region which is used in type0/1/2 to communicate with platform,
>>>> but actually doesn't support type3/4/5.
>>>> So this patch adds the check for PCC subspace type.
>>>>
>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>> ---
>>>>    drivers/soc/hisilicon/kunpeng_hccs.c | 17 +++++++++++++++++
>>>>    1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
>>>> index f3810d9d1caa..4ba3bfd45a01 100644
>>>> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
>>>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
>>>> @@ -174,6 +174,19 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
>>>>    	return rc;
>>>>    }
>>>> +static int hccs_check_pcc_info(struct hccs_dev *hdev)
>>>> +{
>>>> +	struct pcc_mbox_chan *pcc_chan = hdev->cl_info.pcc_chan;
>>>> +
>>>> +	if (pcc_chan->type >= ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE) {
>>>> +		dev_err(hdev->dev, "unsupport for subspace type%u.\n",
>>>> +			pcc_chan->type);
>>>> +		return -EOPNOTSUPP;
>>>> +	}
>>> Is this the only use of the PCC type information you have or do you plan to
>>> use it for something other than the validation.
>> Yeah, it is just validation now. we want to plan this driver can support
>> more types.
> OK
>
>>> Just for sake of argument, I can say all users of PCC must then do the
>>> similar validation. I don't know where to draw the line here.
>> If export PCC type, it is good for the user of PCC to be more universal and
>> more compatible.
>>
> I don't think it is a good idea to just export raw ACPI PCC type to the
I understand you.
But the format and size of type0-2, type3/4 and type5 are different.
And all PCC client drivers need to know which PCC type they used and how 
to fill
the shared memory region header.
Please notice that the type used by the client driver is fixed and 
agreed with the platform in advance.
> client drivers. What if the driver in the future needs to work on a DT
> platform as well and need to work with non-PCC mailbox channel ?
It's also an alternative path.
>
> Also pushing the client PCC drivers to have more ACPI knowledge to understand
> what each type means is also something I prefer to avoid. The real information
Yeah, it is great that the PCC client drivers don't need to know which 
PCC type is used.
But it is inevitable according to above mentioned.
> you want is whether this is an initiator(previously known master) channel or
> responder(previously known as slave) channel. It boils down to unidirectional
> vs bidirectional and what direction in bidirectional channels.
not just for this.
>
> It would be good if mbox framework can be taught that, or atleast make an
> attempt to see what people think about it. Just patching it the way you are
> proposing is just going to hide real issue here.
>
>>> Ideally I would expect the driver to make this transparent and give error
>>> during transmit if not supported.
>> I understand you.
>> I just check this type only once during the initializing phase.
>> Otherwise, every once need to verify it when send PCC command.
> Agreed, but refer above for my concern on the solution proposed.
>
>>> The driver must be able to work with different PCC type to support variety
>>> of platforms TBH. What is the issue exactly here ? Is this to prevent the
>> Agree more with you.
>> IMO, the user of PCC has the ability to support variety of platforms if they
>> can get PCC type.
>> In this case, to prevent type 4 is necessary if driver cannot act as a
>> slave.
>> on the other hand, If one driver acts as a slave, platform must supply slave
>> subspace for them.
>>> use of Type 4 ? I think we must do something better but I don't know what
>>> that is yet.
>> Yes, we can try to do it better. I have a concern, like below.
>>
> Thanks for agreeing.
>
>> You know that the use of PCC can use polling mode and interrupt mode to
>> communicate with platform.
>> I'm not sure if the obtaining of the polling mode and interrupt mode is an
>> issue to prevent driver to be more universal.
> Again this must be addressed at mailbox API level.
Maybe it is ok.
The harder thing to deal with is that the client driver needs to decide 
if set rx_callback for the polling or
interrupt mode before requesting PCC channel.
because driver doesn't know whether platform supports interrupt.
If we fully put PCC type and interrupt mode we discussed to mailbox API 
or PCC driver, there are possibly
many works should be done. I have no good idea to do it yet.
>
>> But this driver can know if they support interrupt mode based on struct
>> mbox_chan::struct mbox_controller::txdone_irq after requesting PCC channel.
> Agreed, I was about to ask the same.
>
>> Because I'm not sure it's a better way.
> Again agreed.
>
>> You know that drivers used interrupt mode need to fill the rx_callback
>> function into mbx_client when register PCC channel.
>> And drivers used polling mode don't do it.
>> If we use this way, drivers that both support the two mode have to modify
>> the rx_callback pointer after requesting PCC channel.
> I am not sure if I followed all the details here. May be a rough hack helps
> to understand what you are proposing ? Ofcourse not for merging, just to
> understand the issue better.
please see the above reply😁
>
> --
> Regards,
> Sudeep
>
> .

