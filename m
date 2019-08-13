Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E45AA8C42C
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2019 00:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHMWPz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Aug 2019 18:15:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33913 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfHMWPy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Aug 2019 18:15:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id c7so5210229otp.1
        for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2019 15:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=l3UiqyQdkzzBfC+pgGtBbYgwOzNc0kqIlToMjux/dcg=;
        b=piAeyEBvj6lMQw63DhkLYHvzld+ReVvqDemzUxIp9CfatJDYUTO3oG8R826g00bY0x
         hA8kXlujsYYlz4Bf/huByEMEDf1KL274OHMIW2EGSXXaeDrwVeftNS+JxH3dRLUHViIp
         zmTnCvqKgXw/LbaNnDAcetd8lEqSBrm3/AFUv6h+7tIbzRwUSdJzWZcPhiU/LkE4B/15
         Z8ZkFWHUVL7HvcmQt1pzo+ujgvINM32zoT1RRfqNoCbzMCsiEvZ44vRLUkSaoJ9WJRxx
         mWXmB78tbSIO4cenRG1mkPh+lB7UTcM30m2FA3jU5xf8gpcftGneTuvUV6Vklx4kP7tm
         /eGA==
X-Gm-Message-State: APjAAAVcN593d0SJvIosuEKHC+QnO2ymQw+wfRdiJTtnP/Ln3lyIh+Vo
        mTxK3Wmy1yIF/6mbHQj4jH2LH2c5TOs=
X-Google-Smtp-Source: APXvYqxv+oF6XIEC+dv7wJmSSoinLlXdDjSl0WGd3LDyf4pIirWgA7sw8J1fy8iFq9Uq2j49IrwB8w==
X-Received: by 2002:a5e:9308:: with SMTP id k8mr28048240iom.143.1565734553758;
        Tue, 13 Aug 2019 15:15:53 -0700 (PDT)
Received: from masetto.ahs3 (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id r20sm15757418ioj.32.2019.08.13.15.15.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 15:15:53 -0700 (PDT)
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH] ACPI / CPPC: do not require the _PSD method when using
 CPPC
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>
References: <20190805170338.29493-1-ahs3@redhat.com>
 <d60f5bed-ca91-fc72-2e4d-309fb8f42960@redhat.com>
 <3154828.dzdK0YMts5@kreacher>
From:   Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <84c60c6c-949e-2ebd-e9be-7e7cb0fcca00@redhat.com>
Date:   Tue, 13 Aug 2019 16:15:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3154828.dzdK0YMts5@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 8/13/19 3:57 PM, Rafael J. Wysocki wrote:
> On Tuesday, August 13, 2019 4:00:56 PM CEST Al Stone wrote:
>> On 8/5/19 11:03 AM, Al Stone wrote:
>>> According to the ACPI 6.3 specification, the _PSD method is optional
>>> when using CPPC.  The underlying assumption appears to be that each CPU
>>> can change frequency independently from all other CPUs; _PSD is provided
>>> to tell the OS that some processors can NOT do that.
>>>
>>> However, the acpi_get_psd() function returns -ENODEV if there is no _PSD
>>> method present, or an ACPI error status if an error occurs when evaluating
>>> _PSD, if present.  This essentially makes _PSD mandatory when using CPPC,
>>> in violation of the specification, and only on Linux.
>>>
>>> This has forced some firmware writers to provide a dummy _PSD, even though
>>> it is irrelevant, but only because Linux requires it; other OSPMs follow
>>> the spec.  We really do not want to have OS specific ACPI tables, though.
>>>
>>> So, correct acpi_get_psd() so that it does not return an error if there
>>> is no _PSD method present, but does return a failure when the method can
>>> not be executed properly.  This allows _PSD to be optional as it should
>>> be.
>>>
>>> Signed-off-by: Al Stone <ahs3@redhat.com>
>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>> Cc: Len Brown <lenb@kernel.org>
>>> ---
>>>  drivers/acpi/cppc_acpi.c | 11 +++++++----
>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index 15f103d7532b..e9ecfa13e997 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -365,10 +365,13 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
>>>  	union acpi_object  *psd = NULL;
>>>  	struct acpi_psd_package *pdomain;
>>>  
>>> -	status = acpi_evaluate_object_typed(handle, "_PSD", NULL, &buffer,
>>> -			ACPI_TYPE_PACKAGE);
>>> -	if (ACPI_FAILURE(status))
>>> -		return -ENODEV;
>>> +	if (acpi_has_method(handle, "_PSD")) {
>>> +		status = acpi_evaluate_object_typed(handle, "_PSD", NULL,
>>> +						    &buffer, ACPI_TYPE_PACKAGE);
>>> +		if (ACPI_FAILURE(status))
>>> +			return -ENODEV;
>>> +	} else
>>> +		return 0;		/* _PSD is optional */
>>>  
>>>  	psd = buffer.pointer;
>>>  	if (!psd || psd->package.count != 1) {
>>>
>>
>> Rafael,
>>
>> Any other comments?
> 
> Yes (they will be sent separately).

Thanks, I appreciate it.

>> Would it be possible to pull this into an -rc?
>> I'd really like to avoid anyone else having to ship Linux-specific
>> DSDTs and SSDTs.
> 
> You won't achieve that through this patch alone, because they will
> also want older kernels that don't include it to run on their platforms.

My apologies for not mentioning this before, but these are platforms
that are not widely available yet.  As far as I know they will not be
able to use older kernels at all, even with this fix.  They are very
heavily reliant on the most recent changes to quite a few other things
such as HMAT, PPTT, and CPPC in general.  This was just one of the items
their firmware developers ran into, so a 5.3 fix is plenty.

Unless, of course, I missed your point entirely....

> Thanks,
> Rafael
> 
> 
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
