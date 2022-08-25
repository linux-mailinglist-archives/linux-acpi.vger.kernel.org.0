Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B28D5A17BC
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 19:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbiHYRKt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243034AbiHYRKi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 13:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4F726CC
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661447430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dx3HzN2xuXenNmxd9LOVm10MA7Gc1ZlAX5AILOiL1+8=;
        b=Enjf+4RlFmDDOJLa+1B0yB0HpAZKx+n6mKkWlimXY7fwYrLQeDu3H+E+FfoPwsPYHIKTpI
        Day4AvlHSg+Fy9oMsz8d1sUwjr5UGDO0sWZczEKsoeY5pRzhQhkBiX8eEOExPwezgTk9AM
        rLLEUfdPAR4hELfoCnCYwiNWXpVzqTc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-144-wsrKd1A1OiyJMsuoxZX8eQ-1; Thu, 25 Aug 2022 13:10:29 -0400
X-MC-Unique: wsrKd1A1OiyJMsuoxZX8eQ-1
Received: by mail-ej1-f69.google.com with SMTP id gs35-20020a1709072d2300b00730e14fd76eso6520760ejc.15
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 10:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dx3HzN2xuXenNmxd9LOVm10MA7Gc1ZlAX5AILOiL1+8=;
        b=iLFFnn+1OhQesdwnNgxMepFqqYKumVGIP8wT6YmEmgdKnzuex9MxUqWEGtYS8WBC1H
         w5j7O4bdIMqmgXJwQ+M5gpNnBy1+xIGB7iHdd0MlPz/c1goqpJMwMhorNMfJCK3/RB0k
         zYlnUO0YMQvyFWiLSslxI1Vy7GUJeU9MIXJGImUSvBXc2hBHQ/dCLrnoxkWh5BLgYzSS
         YJYBPEZY2t/8yTIPckrwuMGzgVaHYqwgxGcEqSf6i8sjezY8WEYmH4l72fkycv5FvyoD
         fpvsXoR+QyPr5Zm2QqnM4XUvPUfzQaGbb/V+JNyvs/HHyoHlXlZRhZs/haCmkATHaWbX
         WB0g==
X-Gm-Message-State: ACgBeo1ldULNbziQb7X9l2nZv2LVI/6PIfwh9nnFngNYP3HyznQmQB1K
        PR9JqknyNYGbWAsQdyh//flDVGf/FYw5T81b1dn/hXZ9JNnjJxNk0DG2/XjCDUXqJGhacSJmKWy
        jgU/uIrldnwtEx8m+zMVuvA==
X-Received: by 2002:a17:907:75ea:b0:73d:daa0:3cbe with SMTP id jz10-20020a17090775ea00b0073ddaa03cbemr1379376ejc.662.1661447428123;
        Thu, 25 Aug 2022 10:10:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6hP7WFOIarW4pjNTI4KIGm/m0FsE0b4nyIVjKHn16oG2apz5byQK8NkuFjO6XBoYIGbBWRPw==
X-Received: by 2002:a17:907:75ea:b0:73d:daa0:3cbe with SMTP id jz10-20020a17090775ea00b0073ddaa03cbemr1379357ejc.662.1661447427876;
        Thu, 25 Aug 2022 10:10:27 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090618a900b0073d9d887eddsm2729552ejf.56.2022.08.25.10.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 10:10:27 -0700 (PDT)
Message-ID: <e045505a-813f-c10f-4054-0ebb677c9e5c@redhat.com>
Date:   Thu, 25 Aug 2022 19:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: ACPI ID list termination
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <CAHp75VczhmTTdMbj7z2DOPm+k4SWGzuLF8NyJ2FWHwhfg9HJ1Q@mail.gmail.com>
 <CAJZ5v0j=90uhWRcVWKVyDhEuVNWw-W28RoKkCwxpzNd3NLC9mg@mail.gmail.com>
 <CAHp75VdfMF_AyONneSMHzmX_cU_tEa97EhL43iu07+9BvFO_ZA@mail.gmail.com>
 <CAJZ5v0g+tBAC87EtOK1E+C-J3k9depNTMGMQ3CmcWnHaCidzXQ@mail.gmail.com>
 <CAHp75VecV9KKFZJDAQJjomBP3oCCJfjqts6OYRk337uGLrWVoQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VecV9KKFZJDAQJjomBP3oCCJfjqts6OYRk337uGLrWVoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/25/22 19:07, Andy Shevchenko wrote:
> On Thu, Aug 25, 2022 at 8:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Thu, Aug 25, 2022 at 6:48 PM Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>>
>>> On Thu, Aug 25, 2022 at 3:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> On Thu, Aug 25, 2022 at 2:38 PM Andy Shevchenko
>>>> <andy.shevchenko@gmail.com> wrote:
>>>>>
>>>>> I have stumbled over __acpi_match_device() implementation and noticed
>>>>> different types of termination of the struct acpi_device_id (ACPI ID
>>>>> list), i.e. '{ }' vs. '{"", 0}'.
>>>>>
>>>>> As I read the code of the above mentioned function, I see that it
>>>>> dereferences the id field without NULL check. This means we are quite
>>>>> lucky (somebody before guarantees the match) we have no crash here.
>>>>
>>>> I'm not sure what you mean.
>>>>
>>>> In __acpi_match_device() id is a pointer used for walking the acpi_ids
>>>> table (if not NULL).  Its initial value is the acpi_ids value and it's
>>>> incremented in every step, so it cannot be NULL.
>>>>
>>>> The loop is terminated if both the first byte of the device ID field
>>>
>>> ^^^ (1)
>>>
>>>> and the cls field in the current row are both zeros, so both
>>>> termination markers in use should work.
>>>>
>>>> Or am I missing anything?
>>>
>>> Yes. The ID field itself is _dereferenced_ w/o NULL check. So, compare
>>> two ID lists:
>>>
>>> FIRST:
>>>   { "A", 1 },
>>>   { "B", 2 },
>>>   { "", 0}
>>>
>>> SECOND:
>>>   { "A", 1 },
>>>   { "B", 2 },
>>>   { }
>>>
>>> They are different in the terminator and the above mentioned function
>>> simply will crash the kernel if no match is found. Of course I might
>>> miss something, but as I said it seems we are simply lucky that
>>> somebody else (platform / device core code?) does our job.
>>
>> OK, I see.  id->id[0] doesn't work if id->id is NULL which it is in
>> the second case.
>>
>> I think it doesn't crash in practice, because it's always called when
>> there's a match.
>>
>> Anyway, something like this would fix it, wouldn't it:
> 
> Yep, that's what I had in my mind, but was in doubt about the case in
> general. Hence the discussion. Yet, w/o this patch prevents us to call
> the mentioned match functions when there is no guarantee that match is
> there. That said, you may add my
> 
> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> to the below patch when formally sent.

Replying to make sure this does not get accidentally applied:

NACK. See my other email in this thread.

Regards,

Hans


> 
>> ---
>>  drivers/acpi/bus.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Index: linux-pm/drivers/acpi/bus.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/bus.c
>> +++ linux-pm/drivers/acpi/bus.c
>> @@ -868,8 +868,8 @@ static bool __acpi_match_device(struct a
>>      list_for_each_entry(hwid, &device->pnp.ids, list) {
>>          /* First, check the ACPI/PNP IDs provided by the caller. */
>>          if (acpi_ids) {
>> -            for (id = acpi_ids; id->id[0] || id->cls; id++) {
>> -                if (id->id[0] && !strcmp((char *)id->id, hwid->id))
>> +            for (id = acpi_ids; (id->id && id->id[0]) || id->cls; id++) {
>> +                if (id->id && id->id[0] && !strcmp((char *)id->id, hwid->id))
>>                      goto out_acpi_match;
>>                  if (id->cls && __acpi_match_device_cls(id, hwid))
>>                      goto out_acpi_match;
> 
> 
> 

