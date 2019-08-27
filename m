Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8289DBA2
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2019 04:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfH0Cb1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 22:31:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbfH0Cb0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Aug 2019 22:31:26 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 109A2C0021D7
        for <linux-acpi@vger.kernel.org>; Tue, 27 Aug 2019 02:31:26 +0000 (UTC)
Received: by mail-io1-f72.google.com with SMTP id e17so25261738ioh.13
        for <linux-acpi@vger.kernel.org>; Mon, 26 Aug 2019 19:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ySf8YTYMsVP8iamqAEphzE0BR0aETXvL0kY9WW3W6kY=;
        b=cdFZV9X6maPKgN+a4zgbaQUrseCCBok+moPYCPnBoFun8aHff3y7djq46DxaktGYNI
         GnMnDmA1ZHNw5xGntfw/EOiZuuUQb5zV2BRDVzeOwVD8S8USXtHcjpd1Rrm5WAiJAeEg
         98Y9rtD6dVB0iIGDe1jDsqkjZEYvejGrrXr4oO6o/gB9QLwY5vrvx6Arl1nT9CGMmrkY
         JAkWNOkW2L7uzueUxwj51Mwgo9sbILkFlHMqy0TycE/mEJ2ERsxmTtZDRFN+4T9Dx7HF
         8zOJ5XZVIto1bGPRDTir3yq/+/iBeDIdn540n9VJ8oVUkOY/8+E4HJ08/IX1qpAUMDvP
         S4hg==
X-Gm-Message-State: APjAAAX2vfJWMhUYmG+prY9LiKOqGUxQiGxDb/C2ejmzYwCw2LvQnVpz
        NBUvj+xeXKe0saFgGRifVBuNxzbd2R89LL6xhpmoA2QLI7CLKiQxnQ3wSHIHQTOYsfwXuFehkxT
        Tayy9tr7fzpQry4cvFR1PdQ==
X-Received: by 2002:a5e:c101:: with SMTP id v1mr13090738iol.231.1566873085458;
        Mon, 26 Aug 2019 19:31:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzzoafTXhIdip+uTwFS7HgjaZ5P2T1bEX1t7ELjzkEe1CjYbFKzZkGpqR4VR89aap48to/uHw==
X-Received: by 2002:a5e:c101:: with SMTP id v1mr13090725iol.231.1566873085224;
        Mon, 26 Aug 2019 19:31:25 -0700 (PDT)
Received: from masetto.ahs3 (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id z9sm19383904ior.79.2019.08.26.19.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 19:31:24 -0700 (PDT)
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH v2] ACPI / CPPC: do not require the _PSD method when using
 CPPC
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
References: <20190826223047.13146-1-ahs3@redhat.com>
 <CAJZ5v0hXJNa3Z14MQgvNcVF8YxH+M46mMyC5U6vZqrpBZUjOgw@mail.gmail.com>
From:   Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <38f21587-f5c9-c831-d7ff-707974178d7f@redhat.com>
Date:   Mon, 26 Aug 2019 20:31:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hXJNa3Z14MQgvNcVF8YxH+M46mMyC5U6vZqrpBZUjOgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 8/26/19 5:02 PM, Rafael J. Wysocki wrote:
> On Tue, Aug 27, 2019 at 12:30 AM Al Stone <ahs3@redhat.com> wrote:
>>
>> According to the ACPI 6.3 specification, the _PSD method is optional
>> when using CPPC.  The underlying assumption is that each CPU can change
>> frequency independently from all other CPUs; _PSD is provided to tell
>> the OS that some processors can NOT do that.
>>
>> However, the acpi_get_psd() function returns ENODEV if there is no _PSD
>> method present, or an ACPI error status if an error occurs when evaluating
>> _PSD, if present.  This makes _PSD mandatory when using CPPC, in violation
>> of the specification, and only on Linux.
>>
>> This has forced some firmware writers to provide a dummy _PSD, even though
>> it is irrelevant, but only because Linux requires it; other OSPMs follow
>> the spec.  We really do not want to have OS specific ACPI tables, though.
>>
>> So, correct acpi_get_psd() so that it does not return an error if there
>> is no _PSD method present, but does return a failure when the method can
>> not be executed properly.  This allows _PSD to be optional as it should
>> be.
>>
>> v2:
>>    -- verified simple check for AE_NOT_FOUND was sufficient
>>    -- simplified return status check per Rafael's suggestion
>>
>> Signed-off-by: Al Stone <ahs3@redhat.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> ---
>>  drivers/acpi/cppc_acpi.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 15f103d7532b..7a946f1944ab 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -365,10 +365,12 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
>>         union acpi_object  *psd = NULL;
>>         struct acpi_psd_package *pdomain;
>>
>> -       status = acpi_evaluate_object_typed(handle, "_PSD", NULL, &buffer,
>> -                       ACPI_TYPE_PACKAGE);
>> -       if (ACPI_FAILURE(status))
>> -               return -ENODEV;
>> +       if (acpi_has_method(handle, "_PSD")) {
> 
> This doesn't look necessary any more.

Probably true.  I'll look back through acpi_evaluate_object_typed().

>> +               status = acpi_evaluate_object_typed(handle, "_PSD", NULL,
>> +                                                   &buffer, ACPI_TYPE_PACKAGE);
>> +               if (status == AE_NOT_FOUND)     /* _PSD is optional */
>> +                       return 0;
> 
> And what about the other possible errors?

Argh.  My apologies.  I was not paying attention.  I'll correct
this and send proper code tomorrow.  Really sorry for the noise :(...

>> +       }
>>
>>         psd = buffer.pointer;
>>         if (!psd || psd->package.count != 1) {
>> --
>> 2.21.0
>>


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
