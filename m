Return-Path: <linux-acpi+bounces-561-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8791B7BF8BC
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 12:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87741C209F3
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 10:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276B3DF51
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48CF168DC
	for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2023 09:31:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 627FEB4
	for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2023 02:31:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D51741FB;
	Tue, 10 Oct 2023 02:31:44 -0700 (PDT)
Received: from [10.57.69.45] (unknown [10.57.69.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D266B3F762;
	Tue, 10 Oct 2023 02:31:02 -0700 (PDT)
Message-ID: <717a0880-1bc4-461f-bd42-c522d653b3ea@arm.com>
Date: Tue, 10 Oct 2023 10:30:56 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: bus: Move acpi_arm_init() to the place of after
 acpi_ghes_init()
To: Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <guohanjun@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 D Scott Phillips <scott@os.amperecomputing.com>
References: <20231010082123.4167603-1-guohanjun@huawei.com>
 <20231010085012.qkntexfsph333sif@bogus>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231010085012.qkntexfsph333sif@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-10 09:50, Sudeep Holla wrote:
> On Tue, Oct 10, 2023 at 04:21:23PM +0800, Hanjun Guo wrote:
>> acpi_agdi_init() in acpi_arm_init() will register a SDEI event, so
>> it needs the SDEI subsystem to be initialized (which is done in
>> acpi_ghes_init()) before the AGDI driver probing.
>>
>> In commit fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific
>> initialisation into acpi_arm_init()"), the acpi_agdi_init() was
>> called before acpi_ghes_init() and it causes following failure:
>>
>> | [    0.515864] sdei: Failed to create event 1073741825: -5
>> | [    0.515866] agdi agdi.0: Failed to register for SDEI event 1073741825
>> | [    0.515867] agdi: probe of agdi.0 failed with error -5
>> | ...
>> | [    0.516022] sdei: SDEIv1.0 (0x0) detected in firmware.
>>
>> Fix it by moving acpi_arm_init() to the place of after
>> acpi_ghes_init().
>>
>> Fixes: fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific initialisation into acpi_arm_init()")
>> Reported-by: D Scott Phillips <scott@os.amperecomputing.com>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>> ---
>>
>> I did a test on a ARM server and I didn't see regressions, but
>> I don't have a AGDI table firmware, so Scott please give a
>> test to see if it fixes your issue.
>>
>>   drivers/acpi/bus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index f41dda2d3493..a4aa53b7e2bb 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1410,10 +1410,10 @@ static int __init acpi_init(void)
>>   	acpi_init_ffh();
>>
>>   	pci_mmcfg_late_init();
>> -	acpi_arm_init();
>>   	acpi_viot_early_init();
>>   	acpi_hest_init();
>>   	acpi_ghes_init();
>> +	acpi_arm_init();
> 
> I am fine with the change, but just wanted to check with Robin/Jean-Philippe
> if there are any dependency on IORT initialisation for VIOT ? IIUC IORT was
> always initialised before VIOT but that changes after this change.

They should be independent, and typically we'd only expect to see one or 
the other anyway (although strictly a VMM *could* provide virtio-iommu 
for some devices while also emulating an SMMU for others if it really 
really wanted to).

Cheers,
Robin.

