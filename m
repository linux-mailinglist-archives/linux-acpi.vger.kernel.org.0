Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B063A357360
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 19:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhDGRnb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Apr 2021 13:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230073AbhDGRnb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Apr 2021 13:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617817400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDm5BO11OjtYF4Z6dkPqyPAi5vFLg1rZe0QxwYE4Ojg=;
        b=S9X/TWYHzVTevJ0pZ+WsJ2aZWdPGDhxdKr1n7jVYG7ZG7D7fOzJnEWcM/YiZlr6b5uod9T
        DrRg+BHIU+IB5hnC8RA9Acj62XLY2m/map5DdDsSmZ8fpAAMlXe9HglhBavNI2QCdxAjaM
        26wXAsoyVNnT0EWHQC777kGvoFaR39s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-6kj4bu4BOp6R8-eT7qdnWg-1; Wed, 07 Apr 2021 13:43:19 -0400
X-MC-Unique: 6kj4bu4BOp6R8-eT7qdnWg-1
Received: by mail-ej1-f70.google.com with SMTP id l1so3159258eji.9
        for <linux-acpi@vger.kernel.org>; Wed, 07 Apr 2021 10:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WDm5BO11OjtYF4Z6dkPqyPAi5vFLg1rZe0QxwYE4Ojg=;
        b=bpujxuTwUu1MuJQAupuKwz8wtHbSpkWqhinW5kOWxOlHXKGKFkIQKNJxw5L/0G3wq6
         UNS2j3qsWeIJEqwJzOLjC6sCuQRHDNV7btXKYsxdMbXbNP+jFWmOYjuxG28tyBnEyvSB
         hAFmHpqK511Tebh3kAN4ufP2HdBfNh9gUDOAuDN3AkQwQFljykozU5MnqaYZx+P9wBMW
         623l5rDvvSwyHrE7dCMvnIk/p2u/FYA/kszEcuhonaoOh7bCMFp26D7j+nUeBE9BjAmY
         ZFYNywkAnDQxXd/rgjUfsrcHVRFYZT/EhlJZINmvWzwMRlhYlSeetvwAj1aZQmc8dVUA
         XmSQ==
X-Gm-Message-State: AOAM531QkPt7MvhSL5jQtdfCYJDntJQDDRUg75E5yYYDU0mM8s9wBqAt
        EWIezOXT9kYAxRZCTy9WAgSaWqutROWi5IK60UeM0Ixgt3zWhLcAZ3OpIdVvK4R8es/DOPLlUEZ
        YRXec0kVFwhXz2fixRwS0/sIstTmDYjo1Zc4EDlPStDLo9wteBciB0uJ+Lml2mrD51zKzS+aQsQ
        ==
X-Received: by 2002:a17:906:9442:: with SMTP id z2mr5299103ejx.79.1617817397398;
        Wed, 07 Apr 2021 10:43:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLRdUgJLJcMpXYN55ty9o47PhIpcoH+lGsDNmQZn/+sAwiIO4jR7VNCcGiPfmqz7ljbGXp2g==
X-Received: by 2002:a17:906:9442:: with SMTP id z2mr5299069ejx.79.1617817397153;
        Wed, 07 Apr 2021 10:43:17 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id rk1sm8720536ejb.88.2021.04.07.10.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 10:43:16 -0700 (PDT)
Subject: Re: [PATCH 1/2] ACPI: utils: Add acpi_reduced_hardware() helper
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20210406211653.182338-1-hdegoede@redhat.com>
 <CAJZ5v0h6=_U+_=G8YL5rA701pTLGfyg4PmBudc3tFRKG=Wxh4A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4e796690-0a45-77e9-6b5d-61b3efa4b301@redhat.com>
Date:   Wed, 7 Apr 2021 19:43:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h6=_U+_=G8YL5rA701pTLGfyg4PmBudc3tFRKG=Wxh4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 4/7/21 7:13 PM, Rafael J. Wysocki wrote:
> On Tue, Apr 6, 2021 at 11:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Add a getter for the acpi_gbl_reduced_hardware variable so that modules
>> can check if they are running on an ACPI reduced-hw platform or not.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/utils.c    | 11 +++++++++++
>>  include/acpi/acpi_bus.h |  1 +
>>  include/linux/acpi.h    |  5 +++++
>>  3 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
>> index 682edd913b3b..4cb061d3169a 100644
>> --- a/drivers/acpi/utils.c
>> +++ b/drivers/acpi/utils.c
>> @@ -872,6 +872,17 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
>>  }
>>  EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
>>
>> +/**
>> + * acpi_reduced_hardware - Return if this is an ACPI-reduced-hw machine
>> + *
>> + * Return true when running on an ACPI-reduced-hw machine, false otherwise.
>> + */
>> +bool acpi_reduced_hardware(void)
>> +{
>> +       return acpi_gbl_reduced_hardware;
>> +}
>> +EXPORT_SYMBOL(acpi_reduced_hardware);
> 
> EXPORT_SYMBOL_GPL()?

Yes, that was my intention, no idea what happened here.

Before I send a v2, do you have any remarks on patch 2/2 (which is actually
the more interesting patch) ?

Regards,

Hans







> 
>> +
>>  /*
>>   * acpi_backlight= handling, this is done here rather then in video_detect.c
>>   * because __setup cannot be used in modules.
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index f28b097c658f..d631cb52283e 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -78,6 +78,7 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
>>
>>  bool acpi_dev_found(const char *hid);
>>  bool acpi_dev_present(const char *hid, const char *uid, s64 hrv);
>> +bool acpi_reduced_hardware(void);
>>
>>  #ifdef CONFIG_ACPI
>>
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 3bdcfc4401b7..e2e6db8313c8 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -748,6 +748,11 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
>>         return NULL;
>>  }
>>
>> +static inline bool acpi_reduced_hardware(void)
>> +{
>> +       return false;
>> +}
>> +
>>  static inline void acpi_dev_put(struct acpi_device *adev) {}
>>
>>  static inline bool is_acpi_node(const struct fwnode_handle *fwnode)
>> --
>> 2.30.2
>>
> 

