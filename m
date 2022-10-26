Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E56860E543
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Oct 2022 18:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiJZQJ7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Oct 2022 12:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiJZQJ5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2022 12:09:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BF582AC5B
        for <linux-acpi@vger.kernel.org>; Wed, 26 Oct 2022 09:09:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ECDA1FB;
        Wed, 26 Oct 2022 09:09:57 -0700 (PDT)
Received: from [10.1.197.38] (unknown [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 039B23F792;
        Wed, 26 Oct 2022 09:09:49 -0700 (PDT)
Message-ID: <e5080938-11e5-44c0-0434-f8d06a0cd953@arm.com>
Date:   Wed, 26 Oct 2022 17:09:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ACPI: AGDI: Improve error reporting for problems during
 .remove()
Content-Language: en-GB
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20221014160623.467195-1-u.kleine-koenig@pengutronix.de>
 <Y05zSNDbt94ejpzm@lpieralisi>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <Y05zSNDbt94ejpzm@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi guys,

On 18/10/2022 10:35, Lorenzo Pieralisi wrote:
> On Fri, Oct 14, 2022 at 06:06:23PM +0200, Uwe Kleine-Kï¿½nig wrote:
>> Returning an error value in a platform driver's remove callback results in
>> a generic error message being emitted by the driver core, but otherwise it
>> doesn't make a difference. The device goes away anyhow.
>>
>> So instead of triggering the generic platform error message, emit a more
>> helpful message if a problem occurs and return 0 to suppress the generic
>> message.
>>
>> This patch is a preparation for making platform remove callbacks return
>> void.
> 
> If that's the plan - I don't have anything against this patch.
> 
>> Signed-off-by: Uwe Kleine-Kï¿½nig <u.kleine-koenig@pengutronix.de>
>> ---
>> Hello,
>>
>> note that in the situations where the driver returned an error before
>> and now emits a message, there is a resource leak. Someone who knows
>> more about this driver and maybe even can test stuff, might want to
>> address this. This might not only be about non-freed memory, the device
>> disappears but it is kept in sdei_list and so might be used after being
>> gone.

> I'd need James' input on this. I guess we may ignore
> sdei_event_disable() return value and continue anyway in agdi_remove(),
> whether that's the right thing to do it is a different question.

The unregister stuff is allowed to fail if the event is 'in progress' on another CPU.
Given the handler panic()s the machine, if an event is in progress, the resource leak
isn't something worth worrying about. The real problem is that the handler code may be
free()d while another CPU is still executing it, which is only a problem for modules.

As this thing can't be built as a module, and the handler panic()s the machine, I don't
think there is going to be a problem here.


Thanks,

James


>> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
>> index cf31abd0ed1b..f605302395c3 100644
>> --- a/drivers/acpi/arm64/agdi.c
>> +++ b/drivers/acpi/arm64/agdi.c
>> @@ -64,8 +64,11 @@ static int agdi_remove(struct platform_device *pdev)
>>  	int err, i;
>>  
>>  	err = sdei_event_disable(adata->sdei_event);
>> -	if (err)
>> -		return err;
>> +	if (err) {
>> +		dev_err(&pdev->dev, "Failed to disable sdei-event #%d (%pe)\n",
>> +			adata->sdei_event, ERR_PTR(err));
>> +		return 0;
>> +	}
>>  
>>  	for (i = 0; i < 3; i++) {
>>  		err = sdei_event_unregister(adata->sdei_event);
>> @@ -75,7 +78,11 @@ static int agdi_remove(struct platform_device *pdev)
>>  		schedule();
>>  	}
>>  
>> -	return err;
>> +	if (err)
>> +		dev_err(&pdev->dev, "Failed to unregister sdei-event #%d (%pe)\n",
>> +			adata->sdei_event, ERR_PTR(err));
>> +
>> +	return 0;
>>  }
>>  
>>  static struct platform_driver agdi_driver = {
>>
>> base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
>> -- 
>> 2.37.2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

