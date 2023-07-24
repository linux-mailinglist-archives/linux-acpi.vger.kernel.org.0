Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AFF75FBFD
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jul 2023 18:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGXQZe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jul 2023 12:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjGXQZ3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jul 2023 12:25:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C2C518E;
        Mon, 24 Jul 2023 09:25:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F16D2FEC;
        Mon, 24 Jul 2023 09:26:08 -0700 (PDT)
Received: from [10.1.26.44] (FVFF763DQ05P.cambridge.arm.com [10.1.26.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33FCA3F5A1;
        Mon, 24 Jul 2023 09:25:23 -0700 (PDT)
Message-ID: <46a3d6d3-f14e-efde-83eb-5952f313f909@arm.com>
Date:   Mon, 24 Jul 2023 17:25:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: acpi: Remove ETM from AMBA scan list (was Re: [PATCH V6 6/6]
 coresight: etm4x: Add ACPI support in platform driver)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     rafael@kernel.org, Len Brown <lenb@kernel.org>
Cc:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        gregkh@linuxfoundation.org
References: <20230710062500.45147-1-anshuman.khandual@arm.com>
 <20230710062500.45147-7-anshuman.khandual@arm.com>
 <38f0c8f3-5fb3-a18a-456d-867da2998786@arm.com>
 <ac77142d-964b-691d-ea15-105a523d9738@arm.com>
In-Reply-To: <ac77142d-964b-691d-ea15-105a523d9738@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael/Len

On 19/07/2023 11:11, Suzuki K Poulose wrote:
> Rafael, Len
> 
> Ping (packets 6, lost 100%).
> 
> 
> On 10/07/2023 17:40, Suzuki K Poulose wrote:
>> Rafael, Len
>>
>> On 10/07/2023 07:25, Anshuman Khandual wrote:
>>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>
>>> Drop ETM4X ACPI ID from the AMBA ACPI device list, and instead just 
>>> move it
>>> inside the new ACPI devices list detected and used via platform driver.
>>>
>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>> Cc: Len Brown <lenb@kernel.org>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: Leo Yan <leo.yan@linaro.org>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>> Cc: linux-acpi@vger.kernel.org
>>> Cc: coresight@lists.linaro.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com> (for ACPI specific 
>>> changes)
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>
>> We would like to queue this via coresight tree. The acpi_amba bits have
>> been reviewed by Sudeep. Please could you give us an Ack, if you are
>> happy with the proposal ?
>>

Please could one of you respond to this patch ? We are blocked on your 
Ack for queuing this. There are machines out there, which rely on this
patch to use Arm self-hosted tracing based on CoreSight.

Kind regards
Suzuki

> 
> Kind regards
> Suzuki
> 
>> Kind regards
>> Suzuki
>>
>>
>>> ---
>>>   drivers/acpi/acpi_amba.c                           |  1 -
>>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++++++
>>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
>>> index f5b443ab01c2..099966cbac5a 100644
>>> --- a/drivers/acpi/acpi_amba.c
>>> +++ b/drivers/acpi/acpi_amba.c
>>> @@ -22,7 +22,6 @@
>>>   static const struct acpi_device_id amba_id_list[] = {
>>>       {"ARMH0061", 0}, /* PL061 GPIO Device */
>>>       {"ARMH0330", 0}, /* ARM DMA Controller DMA-330 */
>>> -    {"ARMHC500", 0}, /* ARM CoreSight ETM4x */
>>>       {"ARMHC501", 0}, /* ARM CoreSight ETR */
>>>       {"ARMHC502", 0}, /* ARM CoreSight STM */
>>>       {"ARMHC503", 0}, /* ARM CoreSight Debug */
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c 
>>> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> index 43f583987250..703b6fcbb6a5 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> @@ -3,6 +3,7 @@
>>>    * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>>>    */
>>> +#include <linux/acpi.h>
>>>   #include <linux/bitops.h>
>>>   #include <linux/kernel.h>
>>>   #include <linux/moduleparam.h>
>>> @@ -2347,12 +2348,21 @@ static const struct of_device_id 
>>> etm4_sysreg_match[] = {
>>>       {}
>>>   };
>>> +#ifdef CONFIG_ACPI
>>> +static const struct acpi_device_id etm4x_acpi_ids[] = {
>>> +    {"ARMHC500", 0}, /* ARM CoreSight ETM4x */
>>> +    {}
>>> +};
>>> +MODULE_DEVICE_TABLE(acpi, etm4x_acpi_ids);
>>> +#endif
>>> +
>>>   static struct platform_driver etm4_platform_driver = {
>>>       .probe        = etm4_probe_platform_dev,
>>>       .remove        = etm4_remove_platform_dev,
>>>       .driver            = {
>>>           .name            = "coresight-etm4x",
>>>           .of_match_table        = etm4_sysreg_match,
>>> +        .acpi_match_table    = ACPI_PTR(etm4x_acpi_ids),
>>>           .suppress_bind_attrs    = true,
>>>           .pm            = &etm4_dev_pm_ops,
>>>       },
>>
> 

