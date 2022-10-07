Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386045F8155
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Oct 2022 01:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJGXoS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Oct 2022 19:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJGXoR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Oct 2022 19:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D62ABF3E
        for <linux-acpi@vger.kernel.org>; Fri,  7 Oct 2022 16:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665186255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9JJFXsFH0cxxZNhHLJVotmibuFesHsy5hhPOapnY+g=;
        b=a8vALOmDP1foFPuGRx/u19X7rRLMalliVbVOxD4OKagMhzHXl++4gVFPYce24B69f/HVt3
        WyAL0JQPBl8QjTTwrkBIriwIXrjFCpYYVksRi7ixTK2mHg4kTaK42zcQx0OVz5afvXG3uX
        V6rwfZ0TtVWz2E4KCPXoTVMYFZHdwIU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-371-ayBmhxhMNwuPqrqCFsEEAA-1; Fri, 07 Oct 2022 19:44:12 -0400
X-MC-Unique: ayBmhxhMNwuPqrqCFsEEAA-1
Received: by mail-ed1-f70.google.com with SMTP id r16-20020a05640251d000b004599cfb8b95so4806355edd.5
        for <linux-acpi@vger.kernel.org>; Fri, 07 Oct 2022 16:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9JJFXsFH0cxxZNhHLJVotmibuFesHsy5hhPOapnY+g=;
        b=lWrtWaNuglo77oDA3y9BcjzXebEQYsJH55Owv3Mhlch/g3TdgfRaUjWduv+yYqXIxF
         YXO2tqW3taX3QIg7KcfskjbfhNDV6mwZTByMutSzcoh0l8tfGRgXOfynyOQoAiCn9Ji9
         rDSuu0VvWPE1dAkgXLgudAD288OAvmzZe6PZOy/LCJOhlQdEcGnZLHmEorhsNYN6IZyF
         SeXYjj8R+adZ4Gj56x4t5u+rWc3bj7KQaZ/FonwqD0tvHdzS+ZItiFNbMISKz63BgSBf
         M+wiB8nPLJnG7sqEFDNgc226/GyJ2/Czo/W89tkZeBgcdyOmQY2HIzfjLgHE4IlJWjO3
         rPjA==
X-Gm-Message-State: ACrzQf0NZRRBP0eM5Hhc3FGeXkD6AONSmzPO9xoo1HOBgsFy7xvuubSf
        OC3jwygkYN+V7DfAV2+sbOH05DSEx0sA3oQabT6pjC4uMU4ru/Ky2+Qb7hu0LMQM2Ki7jYAH7PD
        gz5ua7WiFksFMOvj++YHP8w==
X-Received: by 2002:a05:6402:249f:b0:453:eb1b:1f8b with SMTP id q31-20020a056402249f00b00453eb1b1f8bmr6675984eda.235.1665186251191;
        Fri, 07 Oct 2022 16:44:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Dc1yVugHJ9N1naxQoLDRlS2sUcaBH8hx7fE9VZbkBHR/i0g9dTBlaP2GUUZChhYq952e5+w==
X-Received: by 2002:a05:6402:249f:b0:453:eb1b:1f8b with SMTP id q31-20020a056402249f00b00453eb1b1f8bmr6675973eda.235.1665186250985;
        Fri, 07 Oct 2022 16:44:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ku2-20020a170907788200b0073dc5bb7c32sm1890537ejc.64.2022.10.07.16.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 16:44:10 -0700 (PDT)
Message-ID: <c59c4112-32f6-821b-4176-bc334a68241c@redhat.com>
Date:   Sat, 8 Oct 2022 01:44:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RFC v2 0/2] Quickstart buttons driver and Toshiba Z830
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arvid Norlander <lkml@vorpal.se>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
References: <20220922182424.934340-1-lkml@vorpal.se>
 <5179a1cb-6ff4-2e4c-b1cb-cec53c2f41aa@redhat.com>
In-Reply-To: <5179a1cb-6ff4-2e4c-b1cb-cec53c2f41aa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/7/22 13:42, Hans de Goede wrote:
> Hi,
> 
> On 9/22/22 20:24, Arvid Norlander wrote:
>> Hi,
>>
>> This is version 2 of this patch series, incorporating the various feedback
>> on the first version. However, there are some remaining issues that makes
>> me keep this marked RFC:
>> 1. I tried to get rid of the memory allocation in quickstart_acpi_ghid (as
>>    suggested by Barnabás Pőcze), but I could not get that working. I'm not
>>    sure why I did wrong, but I kept getting ACPI errors indicating a buffer
>>    overflow. I would appreciate knowing how to allocate the buffer on stack
>>    properly in this case. The memory leak is at least fixed on the error
>>    path though.
> 
> It can be quite hard to predict how large an object ACPI methods will
> return. Even if you get it right for your laptop model it may fail
> on other models. So using ACPI_ALLOCATE_BUFFER here (which I assume this
> is about) is absolutely fine, I would even say it is a good idea :)
> 
>> 2. The open question mentioned in the original cover letter remains
>>    undiscussed. I would still like some feedback on those points as well.
>>
>> The original cover letter follows:
>>
>> In the following patch series I implement support for three buttons on
>> the Toshiba Satellite/Portege Z830 (same laptop, different markets).
>>
>> These buttons work via a PNP0C32 ACPI device. Hans de Goede pointed out
>> an old and flawed attempt to implement this as a staging driver.
>>
>> With that staging driver as a starting point I have now implemented proper
>> support. I believe I have fixed the flaws with the original staging driver.
>> As it required almost a complete rewrite I have decided to present it as a
>> new driver instead of starting with a revert commit to restore the old
>> driver and then apply fixes on top.
>>
>> The specification for PNP0C32 devices exists as a Microsoft specification.
>> It was previously available on their web site, but seems to have been taken
>> down during the last month. I had a local copy and I have uploaded it to
>> archive.org. It is available here for anyone interested (including a
>> conversion of the docx to PDF):
>>
>> https://archive.org/details/microsoft-acpi-dirapplaunch
>>
>> The old emails about support for these buttons can be found at:
>> https://marc.info/?l=linux-acpi&m=120550727131007
>> https://lkml.org/lkml/2010/5/28/327
>>
>> Table of contents:
>> 1. Summary of standard
>> 2. Issues
>> 2.1. Issue 1: Wake support
>> 2.2. Issue 2: Button identification
>> 2.3. Issue 3: GHID: 64-bit values?
>> 2.4. Issue 4: MAINTAINERS?
>> 3. User space API
>> 3.1. Input device
>> 3.2. Sysfs file: button_id (Read only)
>> 3.3. Sysfs file: wakeup_cause (Read write)
>> 4. HCI_HOTKEY_EVENT register (toshiba_acpi)
>>
>>
>> 1. Summary of standard
>> ======================
>>
>> Here is a brief high level summary of the standard for PNP0C32. See
>> https://archive.org/details/microsoft-acpi-dirapplaunch for the full
>> standard.
>>
>> PNP0C32 devices are "Direct Application Launch" buttons. The idea is that
>> they should work while the laptop is in various sleep modes (or even off).
>> The Z830 does not support waking from any sleep mode using these buttons,
>> it only supports them while it is awake.
>>
>> Each PNP0C32 device represents a single button. Their meaning is completely
>> vendor defined. On Windows you can either:
>> * Make them launch an application when pressed (defined in the registry)
>> * Or an application can subscribe to specific Window messages to get
>>   notified when they are pressed (this is how they are used by the Toshiba
>>   software).
>>
>> 2. Issues
>> =========
>> Unfortunately there are a few issues where I would like some input.
>>
>> On top of that I'm sure there are lots of issues as I'm fairly new to
>> kernel programming!
>>
>> 2.1. Issue 1: Wake support
>> --------------------------
>> This is untested as the Toshiba Z830 that I have simply does not support
>> this part in the firmware. I left the old behaviour in and only adapted it
>> slightly.
>>
>> The driver adds a sysfs file "wakeup_cause" to each PNP0C32 device
>> (inspired by old approach) that would read "true" after causing the wakeup.
>> It would be up to user space query this and reset the value to false.
>> This is basically what the old staging driver did, only moved from an
>> (un-needed) platform driver to each ACPI driver.
>>
>> As I cannot test it (the Z830 does not support the wakeup part of the spec)
>> I'm more inclined to just drop this feature, especially if the current
>> approach is suboptimal. It would then be up to someone else to implement
>> this in the future.
> 
> Hmm, since you have already written / ported the wakeup_cause code
> I would prefer to retain it.
> 
> You could add a module_param (boolean, default off) to enable this using
> a is_visible callback which returns 0 as mode when the boolean is not set
> (thus hiding the wakeup_cause sysfs attribute).
> Then people can easily test this on other models and if it turns out to
> be useful (and works as is) then we can drop the parameter and just
> always enable this.
> 
> That is not the prettiest of solutions, but this way we atleast preserve
> the work/functionality from the staging driver.

So thinking more about this, I believe that the module param would be
over kill and I think it is best to just keep this with the suggested
changes from the review added.

If it works on other models then it might be useful to some users;
and if it turns out to not work then we can change/fix it without
worrying about breaking existing users of the API since if it does
not work in the first place then there won't be any users.

Regards,

Hans

