Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1072D7109A4
	for <lists+linux-acpi@lfdr.de>; Thu, 25 May 2023 12:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbjEYKO4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 May 2023 06:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240885AbjEYKOt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 May 2023 06:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE6C1A6
        for <linux-acpi@vger.kernel.org>; Thu, 25 May 2023 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685009606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qUwZavWeot6BxoSwWB1BeOsQSAKpT3nzUsF0j/xmbk=;
        b=WA9KzHLurZiNo0mNBL2DYANoCSP7xhPrLa+fCmcHTtwn81hwYgwuAMWCH2/JroJVLcBpwg
        OcGApDfbVpZNSOPvG/rcaeyRkZBaDoReXDh7R9lb0pfSnSixzGaci1w15LF9bFtbbcLZxt
        2eY0RnhXnRnKWyyPTovk+mz8jX/YbUA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-EWfBRekiPF--qDVdg1-Msw-1; Thu, 25 May 2023 06:13:17 -0400
X-MC-Unique: EWfBRekiPF--qDVdg1-Msw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a355c9028so52770466b.3
        for <linux-acpi@vger.kernel.org>; Thu, 25 May 2023 03:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685009596; x=1687601596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qUwZavWeot6BxoSwWB1BeOsQSAKpT3nzUsF0j/xmbk=;
        b=RzHrSFTcV/O4q0hYy1B4vg2W+xnhqzcZH/PLTpzpmXZQ19faAs86WBiJFa5vqwbduO
         Z5eJqVLwLngRJASjRN8n+SKhFa5y8XOmxBHR3pvrpSBTYdDMqTamv5Yl2Gy7zGXePBdx
         vYVER4ehVVisr8JHSjXSk82FzP5mkWk0PW4SxUOPqoJ67o40rVeM57j7zyv0GZ4sPuYl
         eBe1u2maLT4/TbzO3zc5NzmA4/vn0EqCifgqIwY5MCUUZF2ZoDpeZz/Jo7D9RR2FaJUh
         XHz3LO++xPvET4oyoKF44YyNPSSAcWbMevGb+LmvH5Ae0EjIdRozwnkecboAgXzHpdp5
         6qew==
X-Gm-Message-State: AC+VfDyIe9eUb7/mRYqk1JfP2t0Whw92HUXM5lToiPXvVFeR3FwOWDBh
        q3BJMYw9bVyn6NriXodpdE9W660BxmfGwkvC7XFUDXcQDIm+lzB9GNztcCxT+Zk6eDr3kD9YHpU
        EXRfsNx85yt8Y+T/f4J8cvg==
X-Received: by 2002:a17:907:720f:b0:972:aa30:203e with SMTP id dr15-20020a170907720f00b00972aa30203emr1112321ejc.34.1685009596734;
        Thu, 25 May 2023 03:13:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4UVuOdKtAJmTw+9/lxOTaN96LepZ+KFwgazTOkVRaQ7goTvLQZICLYaLw7QL++QbWevUCWkA==
X-Received: by 2002:a17:907:720f:b0:972:aa30:203e with SMTP id dr15-20020a170907720f00b00972aa30203emr1112304ejc.34.1685009596436;
        Thu, 25 May 2023 03:13:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kq10-20020a170906abca00b00960005e09a3sm648261ejb.61.2023.05.25.03.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 03:13:15 -0700 (PDT)
Message-ID: <dcdb3d12-e0af-5e4d-119e-d4fbe9a9495b@redhat.com>
Date:   Thu, 25 May 2023 12:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/4] platform/x86/amd: pmc: Use pm_pr_dbg() for suspend
 related messages
Content-Language: en-US, nl
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>
References: <20230522200033.2605-1-mario.limonciello@amd.com>
 <20230522200033.2605-4-mario.limonciello@amd.com>
 <e9eb526d-84fe-b814-67a3-6f7977aa0078@redhat.com>
 <MN0PR12MB6101AF7606A3547EC5AA42A7E2409@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <MN0PR12MB6101AF7606A3547EC5AA42A7E2409@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mario,

On 5/23/23 18:21, Limonciello, Mario wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Tuesday, May 23, 2023 6:08 AM
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; rafael@kernel.org;
>> linus.walleij@linaro.org
>> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>> gpio@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-
>> pm@vger.kernel.org; S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>;
>> Natikar, Basavaraj <Basavaraj.Natikar@amd.com>
>> Subject: Re: [PATCH v2 4/4] platform/x86/amd: pmc: Use pm_pr_dbg() for
>> suspend related messages
>>
>> Hi Mario,
>>
>> On 5/22/23 22:00, Mario Limonciello wrote:
>>> Using pm_pr_dbg() allows users to toggle
>> `/sys/power/pm_debug_messages`
>>> as a single knob to turn on messages that amd-pmc can emit to aid in
>>> any s2idle debugging.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>  drivers/platform/x86/amd/pmc.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/amd/pmc.c
>> b/drivers/platform/x86/amd/pmc.c
>>> index 427905714f79..1304cd6f13f6 100644
>>> --- a/drivers/platform/x86/amd/pmc.c
>>> +++ b/drivers/platform/x86/amd/pmc.c
>>> @@ -543,7 +543,7 @@ static int amd_pmc_idlemask_read(struct
>> amd_pmc_dev *pdev, struct device *dev,
>>>     }
>>>
>>>     if (dev)
>>> -           dev_dbg(pdev->dev, "SMU idlemask s0i3: 0x%x\n", val);
>>> +           pm_pr_dbg("SMU idlemask s0i3: 0x%x\n", val);
>>>
>>>     if (s)
>>>             seq_printf(s, "SMU idlemask : 0x%x\n", val);
>>
>> This does not compile, amd/pmc.c may be build as an amd-pmc.ko module
>> and currently the pm_debug_messages_on flag used by pm_pr_dbg()
>> is not exported to modules:
>>
>>   CC [M]  drivers/platform/x86/amd/pmc.o
>>   LD [M]  drivers/platform/x86/amd/amd-pmc.o
>>   MODPOST Module.symvers
>> ERROR: modpost: "pm_debug_messages_on"
>> [drivers/platform/x86/amd/amd-pmc.ko] undefined!
>> make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
>> make: *** [Makefile:1978: modpost] Error 2
>>
>> Regards,
>>
>> Hans
>>
> 
> My apologies, yes I was compiling in when testing.  Let me ask if this
> series makes sense and is "generally" agreeable though.

I have no objections against this series, otherwise I don't really
have a strong opinion on this series.

If this makes sense and if exporting pm_debug_messages_on is ok
is Rafael's call to make IMHO.

Rafael ?

Regards,

Hans




