Return-Path: <linux-acpi+bounces-12088-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C850A5C0AD
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 13:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE4C7A9CF9
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB68A2561D2;
	Tue, 11 Mar 2025 12:19:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E025A32A;
	Tue, 11 Mar 2025 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695579; cv=none; b=mcmw+AQ7IR9WnfPWzZy0iWxQzf8VKtuMyAXrkPGAfTnAbAmIn9olE8TcSkp3CvszWrGmeqGPujCbL/Oyj0kxgWCEe5WGL5+oGn8hiqCCF8qXcL4LhjVse37pFBS/H8tgCrG//hzdA353ussli38vdU3+4ClhDd6/TM0PSm/bsTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695579; c=relaxed/simple;
	bh=QGHKG7HiIt7aXvrPkNPFW6Z2v/uD46Z5q/eQUFHAVuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N7CWPafSFNDGcBS55/NECUrcv2hyKTuPXQwyf1649HyjA3wxWcB2hxLbvGHmueW2VFUsRFIjUs/BneS8V4+rAw4cfNYY5RArhLi+1rhPPMDSnSRr3Dd1lHPMD402tu9q9ivHjaffSq66m9I7GNHJp5ZqzhTZD4ZW74U9/0QMRcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZBt7j2tYGz1R6Sm;
	Tue, 11 Mar 2025 20:17:53 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 23630140138;
	Tue, 11 Mar 2025 20:19:34 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 20:19:33 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Mar
 2025 20:19:33 +0800
Message-ID: <8361a849-2b3d-a5d2-464f-da597f0e2516@huawei.com>
Date: Tue, 11 Mar 2025 20:19:32 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 08/13] mailbox: pcc: Refactor and simplify
 check_and_ack()
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jassi Brar
	<jassisinghbrar@gmail.com>, Adam Young <admiyo@os.amperecomputing.com>,
	Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-8-1b1822bc8746@arm.com>
 <34bdfee2-4780-f45b-7891-e845b13fdd2f@huawei.com> <Z9AnsaoxypL6qult@bogus>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <Z9AnsaoxypL6qult@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/11 20:08, Sudeep Holla 写道:
> On Tue, Mar 11, 2025 at 07:47:39PM +0800, lihuisong (C) wrote:
>> 在 2025/3/6 0:38, Sudeep Holla 写道:
>>> The existing check_and_ack() function had unnecessary complexity. The
>>> logic could be streamlined to improve code readability and maintainability.
>>>
>>> The command update register needs to be updated in order to acknowledge
>>> the platform notification through type 4 channel. So it can be done
>>> unconditionally. Currently it is complicated just to make use of
>>> pcc_send_data() which also executes the same updation.
>>>
>>> In order to simplify, let us just ring the doorbell directly from
>>> check_and_ack() instead of calling into pcc_send_data(). While at it,
>>> rename it into pcc_chan_check_and_ack() to maintain consistency in the
>>> driver.
>> LGTM except for some trivial,
>> Acked-by: Huisong Li <lihuisong@huawei.com>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>    drivers/mailbox/pcc.c | 37 +++++++++++++------------------------
>>>    1 file changed, 13 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>>> index b3d133170aac7f8acfd1999564c69b7fe4f6d582..90d6f5e24df7e796f8c29705808eb6df2806c1f2 100644
>>> --- a/drivers/mailbox/pcc.c
>>> +++ b/drivers/mailbox/pcc.c
>>> @@ -117,8 +117,6 @@ struct pcc_chan_info {
>>>    static struct pcc_chan_info *chan_info;
>>>    static int pcc_chan_count;
>>> -static int pcc_send_data(struct mbox_chan *chan, void *data);
>>> -
>>>    /*
>>>     * PCC can be used with perf critical drivers such as CPPC
>>>     * So it makes sense to locally cache the virtual address and
>>> @@ -288,33 +286,24 @@ static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
>>>    	return 0;
>>>    }
>>> -static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
>>> +static void pcc_chan_check_and_ack(struct pcc_chan_info *pchan)
>> How about use pcc_chan_ack?
What do you think of this?
>>>    {
>>> -	struct acpi_pcct_ext_pcc_shared_memory pcc_hdr;
>>> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_hdr;
>>>    	if (pchan->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
>>>    		return;
>>> -	/* If the memory region has not been mapped, we cannot
>>> -	 * determine if we need to send the message, but we still
>>> -	 * need to set the cmd_update flag before returning.
>>> -	 */
>>> -	if (pchan->chan.shmem == NULL) {
>>> -		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
>>> -		return;
>>> -	}
>>> -	memcpy_fromio(&pcc_hdr, pchan->chan.shmem,
>>> -		      sizeof(struct acpi_pcct_ext_pcc_shared_memory));
>>> +
>>> +	pcc_chan_reg_read_modify_write(&pchan->cmd_update);
>>> +
>>> +	pcc_hdr = pchan->chan.shmem;
>> Should use the original code?
>>
>> memcpy_fromio(&pcc_hdr, pchan->chan.shmem,
>> 		      sizeof(struct acpi_pcct_ext_pcc_shared_memory));
>>
> ioread32(&pcc_hdr->flags) just reads 4 byte flag instead of copying entire
> header for no reason. It should be same as memcpy_fromio(.., .., 4)
>
get it.
>
> .

