Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1192CFC55
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Dec 2020 19:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgLER7L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Dec 2020 12:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgLER6W (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Dec 2020 12:58:22 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37586C061A54;
        Sat,  5 Dec 2020 08:59:18 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 91so4440233wrj.7;
        Sat, 05 Dec 2020 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pSZy2MIM2IOcpuaCO21YRk9eLUrSbTWR9J9zRoW6BTQ=;
        b=DpMQDu2t7TBEzkeYMsX+efAU3SxXevbCeoF/HYYK8ivNMoe3tvbAUaPheGZWrv0faI
         RdRfGGiqCY8xOEsvotkkShAi95/qHhK9Q3jDQXBSIOQfYDyUsAzCRBsNNUEScmNnAX/B
         cluQZbztVFYHIax8IS3VnFUAG2SCPkDvqDqivqGYirSixN1BlO4zfKHu1CK3b7GjwjtE
         x0hCT/XtlGCg/PYckZjue34q7a21MFEkiBNOvwCQ55KUnRsT1pA9IABnGkJfe+/B1jD4
         s96ViVn+DRwYkD6h5wMlKEIf0gThHWX/RsZCD2W1OZSNyzq3RXjCFMYbkoa2mnfhd5VU
         Lv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pSZy2MIM2IOcpuaCO21YRk9eLUrSbTWR9J9zRoW6BTQ=;
        b=dVDJhHXTGW3oJMNrtgHUDIbisJZRoB+qCwmNMnyR7YO4EdqEx91oP2Lxm8ll3sVU6L
         Ed6Y5osx8EltcOVyuW7FtAwhdIVfeOKIov5rEa5mKYbzCda3mlzl6URKlZsK2TIiCeyZ
         yEiYGVBQErnuxuVSmXKkkDoOt4J6NXLQ7eqtw4bs2JUzf8SGuP8KO/HXHjTAkP8RFNaV
         FwJj/+qlEeSgy8J2SHUemWUbqFzFEFipnM9EpfVIXTMMU82gOz01Q+6o+bBpewC51pez
         TG/xf1v3FwPVvhUoqQXIgQ8dAKbCofSWFR5ER4yTSZwoZxRGao9ENzTk6mleDunKW4l2
         /3RA==
X-Gm-Message-State: AOAM532CbZB8mc7xSkexmjG+Zsl4eA19sAA45GjrZp50kP9RegNRLKh8
        B5TMAuKyHt978XNe+jKYTJabBrsjjebSpg==
X-Google-Smtp-Source: ABdhPJwJG10DzMqxYNZFzuj+sbY6HlI/cnAVjqZ7ICArvqAvt/Uan3BW/DBUCVIq4Fc94MpSILvyTA==
X-Received: by 2002:a5d:668d:: with SMTP id l13mr10705249wru.279.1607187556867;
        Sat, 05 Dec 2020 08:59:16 -0800 (PST)
Received: from [192.168.1.211] ([2.31.225.57])
        by smtp.gmail.com with ESMTPSA id q1sm8137536wrj.8.2020.12.05.08.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 08:59:15 -0800 (PST)
Subject: Re: [PATCH] acpi: resource: Use AE_ABORT_METHOD to terminate
 acpi_dev_get_resources()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, mika.westerberg@linux.intel.com
References: <20201204002740.300109-1-djrscally@gmail.com>
 <2246133.BJYN6MDhT9@kreacher>
From:   Dan Scally <djrscally@gmail.com>
Message-ID: <884a73ea-0bc3-6598-b440-3d7c6a8561b6@gmail.com>
Date:   Sat, 5 Dec 2020 16:59:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2246133.BJYN6MDhT9@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 05/12/2020 15:21, Rafael J. Wysocki wrote:
> On Friday, December 4, 2020 1:27:40 AM CET Daniel Scally wrote:
>> Switching this function to AE_CTRL_TERMINATE broke the documented
>> behaviour of acpi_dev_get_resources() - AE_CTRL_TERMINATE does not, in
>> fact, terminate the resource walk because acpi_walk_resource_buffer()
>> ignores it (specifically converting it to AE_OK), referring to that
>> value as "an OK termination by the user function". This means that
>> acpi_dev_get_resources() does not abort processing when the preproc
>> function returns a negative value.
>>
>> Revert to AE_ABORT_METHOD
>>
>> Fixes: 8a66790b7850 ("ACPI / resources: Use AE_CTRL_TERMINATE to terminate resources walks")
>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> This is simply a revert of the above commit, so it would be better to present
> it as a revert explicitly.

Ah, of course. I'll resend as that, sorry for the noise

>
>> ---
>>  drivers/acpi/resource.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index ad04824ca3ba..f2f5f1dc7c61 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -541,7 +541,7 @@ static acpi_status acpi_dev_process_resource(struct acpi_resource *ares,
>>  		ret = c->preproc(ares, c->preproc_data);
>>  		if (ret < 0) {
>>  			c->error = ret;
>> -			return AE_CTRL_TERMINATE;
>> +			return AE_ABORT_METHOD;
>>  		} else if (ret > 0) {
>>  			return AE_OK;
>>  		}
>>
>
>
>
