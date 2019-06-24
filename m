Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C37A451996
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2019 19:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfFXRcb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jun 2019 13:32:31 -0400
Received: from foss.arm.com ([217.140.110.172]:55516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfFXRcb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jun 2019 13:32:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5A5DC0A;
        Mon, 24 Jun 2019 10:32:30 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 125903F718;
        Mon, 24 Jun 2019 10:32:29 -0700 (PDT)
Subject: Re: [PATCH] ACPI / APEI: Remove needless __ghes_check_estatus() calls
To:     Borislav Petkov <bp@alien8.de>,
        luanshi <zhangliguang@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
References: <1560749129-26288-1-git-send-email-zhangliguang@linux.alibaba.com>
 <20190621151826.GA19067@zn.tnic>
From:   James Morse <james.morse@arm.com>
Message-ID: <699f3fa3-0696-c894-0d00-93794defb89d@arm.com>
Date:   Mon, 24 Jun 2019 18:32:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621151826.GA19067@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Boris,

On 21/06/2019 16:18, Borislav Petkov wrote:
> On Mon, Jun 17, 2019 at 01:25:29PM +0800, luanshi wrote:
>> Function __ghes_check_estatus() is called after __ghes_peek_estatus(),
>> but it is already called in __ghes_peek_estatus(). So we should remove

>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 993940d..1041a4d 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -372,10 +372,6 @@ static int ghes_read_estatus(struct ghes *ghes,
>>  	if (rc)
>>  		return rc;
>>  
>> -	rc = __ghes_check_estatus(ghes, estatus);
>> -	if (rc)
>> -		return rc;
>> -
>>  	return __ghes_read_estatus(estatus, *buf_paddr, fixmap_idx,
>>  				   cper_estatus_len(estatus));
>>  }
>> @@ -882,12 +878,6 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
>>  		return rc;
>>  	}
>>  
>> -	rc = __ghes_check_estatus(ghes, &tmp_header);
>> -	if (rc) {
>> -		ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
>> -		return rc;
>> -	}
>> -
>>  	len = cper_estatus_len(&tmp_header);
>>  	node_len = GHES_ESTATUS_NODE_LEN(len);
>>  	estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool, node_len);
>> -- 
> 
> Yah, looks correct to me.

Yes, looks like I changed my mind halfway through about whether peek should just get the
values needed to allocate 'enough' memory, or do some validation too.


> James, I think the cleaner thing to do would be for
> __ghes_peek_estatus() not to call __ghes_check_estatus() at the end but
> to return success and we can keep the two functions - "peek" and "check"
> status - separate and always do:
> 
> 	if (peek)
> 		return ...;
> 
> 	if (check)
> 		return ...;
> 
> because this way the checking remains separate in __ghes_check_estatus()
> and so is the peeking in __ghes_peek_estatus().
> 
> We can merge the two functions because we always do peek and then check
> but keeping them separate makes the code clearer.
> 
> Am I making some sense...?

Makes sense to me.


Thanks,

James
