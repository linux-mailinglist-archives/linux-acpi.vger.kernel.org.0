Return-Path: <linux-acpi+bounces-11879-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93757A54159
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 04:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE750165519
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 03:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D44198A37;
	Thu,  6 Mar 2025 03:45:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD183B192;
	Thu,  6 Mar 2025 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741232719; cv=none; b=dcMuCDHtOB67d8jq6YtCrY3263PeSl2zVO1KSX0M0S8VcgvOiVn/TtFxdtZLdaCDCPwcTya6m8ZEkwskk0svmSgkuND87GZ3pN1mRTw+oBbncj6t6rKNJacVRILnuxAckEqVH5vuBjyLoYYDy7dmwf0ftAgcTNPW1oo7EH/ayt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741232719; c=relaxed/simple;
	bh=QoWgWcRJAnq489uxfdsGr04fuBwQ5eiqsqCp7mEVcG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i4PWFyeyEYh/lHIZco12QdpQywgwTmucGSxrx7QYEUSblt9pkb1ZepTBsa3Yk5D1erjX6g4a6W5jLkd5jYL0uJocKIqU/lBbOwBRW81ZyCyN+PkhmXHuTlxU+KnjiBa8EPG5JEnS9mbLc9FwUZsuW0WwljSbiX904mq6pvW+zrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z7ZyR3JwPz1R6D7;
	Thu,  6 Mar 2025 11:43:27 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id CF4BC1402C1;
	Thu,  6 Mar 2025 11:45:05 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Mar 2025 11:45:05 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 6 Mar
 2025 11:45:05 +0800
Message-ID: <a0b0cbfb-6a43-db68-3c0c-c5b1c498c3f4@huawei.com>
Date: Thu, 6 Mar 2025 11:44:56 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 02/14] mailbox: pcc: Always clear the platform ack
 interrupt first
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jassi Brar
	<jassisinghbrar@gmail.com>, Adam Young <admiyo@os.amperecomputing.com>,
	Robbie King <robbiek@xsightlabs.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-2-3b44f3d134b1@arm.com>
 <397910e0-38eb-553a-2bd2-c338d8c3a49c@huawei.com>
 <20250305142945.kzs4hfljbktkndbe@bogus>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250305142945.kzs4hfljbktkndbe@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/5 22:29, Sudeep Holla 写道:
> On Wed, Mar 05, 2025 at 11:45:35AM +0800, lihuisong (C) wrote:
>> 在 2025/3/3 18:51, Sudeep Holla 写道:
>>> The PCC mailbox interrupt handler (pcc_mbox_irq()) currently checks
>>> for command completion flags and any error status before clearing the
>>> interrupt.
>>>
>>> The below sequence highlights an issue in the handling of PCC mailbox
>>> interrupts, specifically when dealing with doorbell notifications and
>>> acknowledgment between the OSPM and the platform where type3 and type4
>>> channels are sharing the interrupt.
>>>
>>>           Platform Firmware              OSPM/Linux PCC driver
>>> ------------------------------------------------------------------------
>>>                                        build message in shmem
>>>                                        ring type3 channel doorbell
>>> receives the doorbell interrupt
>>>     process the message from OSPM
>>>     build response for the message
>>> ring the platform ack interrupt to OSPM
>>> 				--->
>>> build notification in type4 channel
>>>                                        start processing in pcc_mbox_irq()
>>>                                         enter pcc handler for type4 chan
>>>                                            command complete cleared
>>> 			        	 read the notification
>>>                                   <---     clear platform ack irq
>>>     		* no effect from above as platform ack irq *
>>> 		* not yet triggered on this channel *
>>> ring the platform ack irq on type4 channel
>>> 				--->
>>>                                         leave pcc handler for type4 chan
>>>                                         enter pcc handler for type3 chan
>>>                                            command complete set
>>> 					 read the response
>>>                                   <---     clear platform ack irq
>>>                                         leave pcc handler for type3 chan
>>>                                        leave pcc_mbox_irq() handler
>>>                                        start processing in pcc_mbox_irq()
>>>                                         enter pcc handler for type4 chan
>>>                                         leave pcc handler for type4 chan
>>>                                         enter pcc handler for type3 chan
>>>                                         leave pcc handler for type3 chan
>>>                                        leave pcc_mbox_irq() handler
>> This is not easy to understand to me.
>> The issue as below described is already very clear to me.
>> So suggest remove above flow graph.
> I understood it with the graph similar to the one above, though I simplified
> it in terms of PCC rather than specific IP reference.
>
>>> The key issue occurs when OSPM tries to acknowledge platform ack
>>> interrupt for a notification which is ready to be read and processed
>>> but the interrupt itself is not yet triggered by the platform.
>>>
>>> This ineffective acknowledgment leads to an issue later in time where
>>> the interrupt remains pending as we exit the interrupt handler without
>>> clearing the platform ack interrupt as there is no pending response or
>>> notification. The interrupt acknowledgment order is incorrect.
>>>
>> Has this issue been confired? It's more better if has the log.😁
>> But it seems a valid issue.
> Yes Robbie reported this. He is away and can't test or respond until next
> week. The log just says there was loads of spurious interrupts and nobody
> cared log as you got in the first patch of yours fixing similar race.
Yeah
>
>>> To resolve this issue, the platform acknowledgment interrupt should
>>> always be cleared before processing the interrupt for any notifications
>>> or response.
>>>
>> AFAIC，always clearing the platform ack interrupt first which is also the
>> communication flow as ACPI spec described.
> Indeed, not sure how we missed it so far.
>
>> I am not sure if it is ok when triggering interrupt and clearing interrupt
>> occur concurrently.
> Should be OK as we start clearing all the channels that share, if the
> handler doesn't clear any source, the interrupt must remain asserted.
ok, thank you for clarifying to me.
>
>> But this scenario is always possible. I think It doesn't matter with this
>> patch. It's just my confusion.
> Indeed, it can happen any time as you mentioned. No worries better to ask
> and clarify than assume. Thanks for your time and review.
>
> --
> Regards,
> Sudeep
>
>
> .

