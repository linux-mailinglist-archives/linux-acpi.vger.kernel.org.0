Return-Path: <linux-acpi+bounces-50-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA79B7AA7CE
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 06:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7DD4B281CBF
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 04:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611DC5666
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 04:31:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA30385
	for <linux-acpi@vger.kernel.org>; Fri, 22 Sep 2023 02:46:45 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF25192;
	Thu, 21 Sep 2023 19:46:42 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VsaTkdL_1695350797;
Received: from 30.240.112.49(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VsaTkdL_1695350797)
          by smtp.aliyun-inc.com;
          Fri, 22 Sep 2023 10:46:39 +0800
Message-ID: <fdc7a4ee-250f-7ec8-ca15-32cbd480bd3e@linux.alibaba.com>
Date: Fri, 22 Sep 2023 10:46:36 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: Questions: Should kernel panic when PCIe fatal error occurs?
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 Miaohe Lin <linmiaohe@huawei.com>
Cc: gregkh@linuxfoundation.org, Linux PCI <linux-pci@vger.kernel.org>,
 mahesh@linux.ibm.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, bhelgaas@google.com,
 "james.morse@arm.com" <james.morse@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lenb@kernel.org" <lenb@kernel.org>
References: <20230921215241.GA337765@bhelgaas>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230921215241.GA337765@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+ @Rafael for the APEI/GHES part.

On 2023/9/22 05:52, Bjorn Helgaas wrote:
> On Thu, Sep 21, 2023 at 08:10:19PM +0800, Shuai Xue wrote:
>> On 2023/9/21 07:02, Bjorn Helgaas wrote:
>>> On Mon, Sep 18, 2023 at 05:39:58PM +0800, Shuai Xue wrote:
>> ...
> 
>>> I guess your point is that for CPER_SEV_FATAL errors, the APEI/GHES
>>> path always panics but the native path never does, and that maybe both
>>> paths should work the same way?
>>
>> Yes, exactly. Both OS native and APEI/GHES firmware first are notifications
>> used to handles PCIe AER errors, and IMHO, they should ideally work in the
>> same way.
> 
> I agree, that would be nice, but the whole point of the APEI/GHES
> functionality is vendor value-add, so I'm not sure we can achieve that
> ideal.
> 
>> ...
>> As a result, AER driver only does recovery for non-fatal PCIe error.
> 
> This is only true for the APEI/GHES path, right?  For *native* AER
> handling, we attempt recovery for both fatal and non-fatal errors.

Yes, exactly.

> 
>>> It doesn't seem like the native path should always panic.  If we can
>>> tell that data was corrupted, we may want to panic, but otherwise I
>>> don't think we should crash the entire system even if some device is
>>> permanently broken.
>>
>> Got it. But how can we tell if the data is corrupted with OS native?
> 
> I naively expect that by PCIe protocol, corrupted DLLPs or TLPs
> detected by CRC, sequence number errors, etc, would be discarded
> before corrupting memory, so I doubt we'd get an uncorrectable error
> that means "sorry, I just corrupted your data."
> 
> But DPC is advertised as "avoiding the potential spread of any data
> corruption," so there must be some mechanisms of corruption, and since
> DPC is triggered by either ERR_FATAL or ERR_NONFATAL, I guess maybe
> the errors could tell us something.  I'm going to quit speculating
> because I obviously don't know enough about this area.
> 
>>>> However, I have changed my mind on this issue as I encounter a case where
>>>> a error propagation is detected due to fatal DLLP (Data Link Protocol
>>>> Error) error. A DLLP error occurred in the Compute node, causing the
>>>> node to panic because `struct acpi_hest_generic_status::error_severity` was
>>>> set as CPER_SEV_FATAL. However, data corruption was still detected in the
>>>> storage node by CRC.
>>>
>>> The only mention of Data Link Protocol Error that looks relevant is
>>> PCIe r6.0, sec 3.6.2.2, which basically says a DLLP with an unexpected
>>> Sequence Number should be discarded:
>>>
>>>   For Ack and Nak DLLPs, the following steps are followed (see Figure
>>>   3-21):
>>>
>>>     - If the Sequence Number specified by the AckNak_Seq_Num does not
>>>       correspond to an unacknowledged TLP, or to the value in
>>>       ACKD_SEQ, the DLLP is discarded
>>>
>>>       - This is a Data Link Protocol Error, which is a reported error
>>> 	associated with the Port (see Section 6.2).
>>>
>>> So data from that DLLP should not have made it to memory, although of
>>> course the DMA may not have been completed.  But it sounds like you
>>> did see corrupted data written to memory?
>>
>> The storage node use RDMA to directly access remote compute node.
>> And a error detected by CRC in the storage node. So I suspect yes.
> 
> When doing the CRC, can you distinguish between corrupted data and
> data that was not written because a DMA was only partially completed?

Yes, the receiving application layer will perform length verification.
So the data length is definitely correct.

> 
>> ...
>> I tried to inject Data Link Protocol Error on some platform. The mechanism
>> behind is that rootport controls the sequence number of the specific TLPs
>> and ACK/NAK DLLPs. Data Link Protocol Error will be detected at the Rx side
>> of ACK/NAK DLLPs.
>>
>> In such case, NIC and NVMe recovered on fatal and non-fatal DLLP
>> errors.
> 
> I'm guessing this error injection directly writes the AER status bit,
> which would probably only test the reporting (sending an ERR_FATAL
> message), AER interrupt generation, firmware or OS interrupt handling,
> etc.
> 
> It probably would not actually generate a DLLP with a bad sequence
> number, so it probably does not test the hardware behavior of
> discarding the DLLP if the sequence number is bad.  Just my guess
> though.

No, we don't touch AER status bit. The Root port controller provides Error
Injection Function to trigger a real DLLP error. For example,

- set a bad Bad sequence number, assuming 3
- enable error injection
- send a TLP from the controller's Application Interface, assuming SEQ#5 is
  given to the TLP
- the SEQ# is Changed to #2 by the Error Injection Function in Layer2.

> 
>> ...
>> My point is that how kernel could recover from non-fatal and fatal
>> errors in firmware first without DPC? If CPER_SEV_FATAL is used to
>> report fatal PCIe error, kernel will panic in APEI/GHES driver.
> 
> The platform decides whether to use CPER_SEV_FATAL, so we can't change
> that.  We *could* change whether Linux panics when the platform says
> an error is CPER_SEV_FATAL.  That happens in drivers/acpi, so it's
> really up to Rafael.

Agreed. Of course, we are talking about and focus on the desired behavior
of Linux kernel.

> 
> Personally I would want to hear from vendors who use the APEI/GHES
> path.  Poking around the web for logs that mention HEST and related
> things, it looks like at least Dell, HP, and Lenovo use it.  And there
> are drivers/acpi/apei commits from nxp.com, alibaba.com, amd.com,
> arm.com huawei.com, etc., so some of them probably care, too.
> 

Aha, sure. In OS native mode, kernel controls everything, directly acting
on the MSI, checking AER status and do recovery for CE, non-fatal and fatal
errors. While for firmware first, as it name indicates, the kernel and
firmware co-work together to handle processor, memory, PCIe and
platform specific errors.

Actually, this is a question from my colleague from firmware team.
The original question is that:

    "Should I set CPER_SEV_FATAL for Generic Error Status Block when a
    PCIe fatal error is detected? If set, kernel will always panic.
    Otherwise, kernel will always not panic."

So I pull a question about desired behavior of Linux kernel first :)
From the perspective of the kernel, CPER_SEV_FATAL for Generic Error
Status Block is not reasonable. The kernel will attempt to recover
Fatal errors, although recovery may fail.

Best Regards,
Shuai





