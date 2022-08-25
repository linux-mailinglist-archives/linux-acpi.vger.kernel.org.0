Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A45A17B0
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 19:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiHYRJq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 13:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHYRJp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 13:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B196765AF
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661447382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U18RZrV3XhiB6LETaCP3xknAzn74RS72oS5hqB9zFLA=;
        b=ccjkk0DIf8v/HDqUpIRmJD4KwfYFYjgdhwpag3W/msCx8Ri3jdTNqz5dlWkFcgXT8nh0fs
        kfYdzLXX1OsmMSAISR7Peiu+zikmPfq22VhS/olu7kq8kr7MgPGQtPglm4/HqvMwuq0axk
        pm03oG1v0vQBYeBOJl4om9Bx6XGWHjI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-454-iAYnvSIFOR2wUdzbYeJotA-1; Thu, 25 Aug 2022 13:09:41 -0400
X-MC-Unique: iAYnvSIFOR2wUdzbYeJotA-1
Received: by mail-ed1-f69.google.com with SMTP id q32-20020a05640224a000b004462f105fa9so11971056eda.4
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 10:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=U18RZrV3XhiB6LETaCP3xknAzn74RS72oS5hqB9zFLA=;
        b=Lcp4cr0twRnv/Z2S6s0P4Ertqb9SXEPLARY8mdjbXDYeuKibLK4+wCEzMr+wn8MApO
         uxOgbdlaUdlMC5bxP+DNXZad4qO9axrjZ04k+tEOCn6pjcOSsyT1jtT/Gg4ya2lw+WQH
         s97/Sk2+A7mO3i29fne2AsYqLYK/Au/HJV+1hvKEvIZ2i7GhDYCr0lougBQbHNO7CmYR
         9C83DgSztug8PA29oyeXpkXJU1oEatLxDO6Dja2t9aVsDH0hylA3X7+ANMTQNHvnMuvo
         TjdSibiCVf/pCWqSmOTGYcSD50ID2kZkRUKPityiUoTUsFnYuAUtQYba+8ssF8mMi4zo
         Dn8w==
X-Gm-Message-State: ACgBeo38r4cKabuC6ZDTP9HZr76op4E5Ij4tLsSkM7P2jT+OWu7Fy0ak
        0OKA1rokwsqoMIpZ0SvY0kx0Zg3CFq7yQYG99M+FFA+8TkSITvEOEsOL9TTUNn0AO66IrSc6Ohe
        Px4/k5Qz5NPrrVmkazyZk/g==
X-Received: by 2002:a05:6402:191:b0:445:cf66:25c5 with SMTP id r17-20020a056402019100b00445cf6625c5mr4023270edv.58.1661447380398;
        Thu, 25 Aug 2022 10:09:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR56ZStQzjCPROb1RnkNQLA30LpEeLSaI9ApsYn/kETtlwF+RJXG3VyDAzKHNlx6F3gHpwJTBg==
X-Received: by 2002:a05:6402:191:b0:445:cf66:25c5 with SMTP id r17-20020a056402019100b00445cf6625c5mr4023255edv.58.1661447380184;
        Thu, 25 Aug 2022 10:09:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b0073d87068042sm2679868ejc.110.2022.08.25.10.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 10:09:39 -0700 (PDT)
Message-ID: <69897481-88bc-2c7a-8862-65fbc40fc0b6@redhat.com>
Date:   Thu, 25 Aug 2022 19:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: ACPI ID list termination
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <CAHp75VczhmTTdMbj7z2DOPm+k4SWGzuLF8NyJ2FWHwhfg9HJ1Q@mail.gmail.com>
 <CAJZ5v0j=90uhWRcVWKVyDhEuVNWw-W28RoKkCwxpzNd3NLC9mg@mail.gmail.com>
 <CAHp75VdfMF_AyONneSMHzmX_cU_tEa97EhL43iu07+9BvFO_ZA@mail.gmail.com>
 <CAJZ5v0g+tBAC87EtOK1E+C-J3k9depNTMGMQ3CmcWnHaCidzXQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0g+tBAC87EtOK1E+C-J3k9depNTMGMQ3CmcWnHaCidzXQ@mail.gmail.com>
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

On 8/25/22 19:03, Rafael J. Wysocki wrote:
> On Thu, Aug 25, 2022 at 6:48 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> On Thu, Aug 25, 2022 at 3:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Thu, Aug 25, 2022 at 2:38 PM Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>>
>>>> I have stumbled over __acpi_match_device() implementation and noticed
>>>> different types of termination of the struct acpi_device_id (ACPI ID
>>>> list), i.e. '{ }' vs. '{"", 0}'.
>>>>
>>>> As I read the code of the above mentioned function, I see that it
>>>> dereferences the id field without NULL check. This means we are quite
>>>> lucky (somebody before guarantees the match) we have no crash here.
>>>
>>> I'm not sure what you mean.
>>>
>>> In __acpi_match_device() id is a pointer used for walking the acpi_ids
>>> table (if not NULL).  Its initial value is the acpi_ids value and it's
>>> incremented in every step, so it cannot be NULL.
>>>
>>> The loop is terminated if both the first byte of the device ID field
>>
>> ^^^ (1)
>>
>>> and the cls field in the current row are both zeros, so both
>>> termination markers in use should work.
>>>
>>> Or am I missing anything?
>>
>> Yes. The ID field itself is _dereferenced_ w/o NULL check. So, compare
>> two ID lists:
>>
>> FIRST:
>>   { "A", 1 },
>>   { "B", 2 },
>>   { "", 0}
>>
>> SECOND:
>>   { "A", 1 },
>>   { "B", 2 },
>>   { }
>>
>> They are different in the terminator and the above mentioned function
>> simply will crash the kernel if no match is found. Of course I might
>> miss something, but as I said it seems we are simply lucky that
>> somebody else (platform / device core code?) does our job.

No they are not different, the id field is not a "char *" as
I believe you are thinking. The id field actually is a pre-allocated
array of length ACPI_ID_LEN:

struct acpi_device_id {
        __u8 id[ACPI_ID_LEN];
        kernel_ulong_t driver_data;
        __u32 cls;
        __u32 cls_msk;
};

So in both terminators above id[] will be set to 0 and there is
no problem other then the style being inconsistent.


> 
> OK, I see.  id->id[0] doesn't work if id->id is NULL which it is in
> the second case.
> 
> I think it doesn't crash in practice, because it's always called when
> there's a match.
> 
> Anyway, something like this would fix it, wouldn't it:
> 
> ---
>  drivers/acpi/bus.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/acpi/bus.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/bus.c
> +++ linux-pm/drivers/acpi/bus.c
> @@ -868,8 +868,8 @@ static bool __acpi_match_device(struct a
>      list_for_each_entry(hwid, &device->pnp.ids, list) {
>          /* First, check the ACPI/PNP IDs provided by the caller. */
>          if (acpi_ids) {
> -            for (id = acpi_ids; id->id[0] || id->cls; id++) {
> -                if (id->id[0] && !strcmp((char *)id->id, hwid->id))
> +            for (id = acpi_ids; (id->id && id->id[0]) || id->cls; id++) {
> +                if (id->id && id->id[0] && !strcmp((char *)id->id, hwid->id))
>                      goto out_acpi_match;
>                  if (id->cls && __acpi_match_device_cls(id, hwid))
>                      goto out_acpi_match;
> 

This change is not necessary, see above.

Regards,

Hans

