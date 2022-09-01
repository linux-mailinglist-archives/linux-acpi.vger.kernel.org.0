Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECF05A9B1E
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Sep 2022 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiIAPDp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Sep 2022 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiIAPDo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Sep 2022 11:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C4D832E8
        for <linux-acpi@vger.kernel.org>; Thu,  1 Sep 2022 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662044623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ri++8kgJLK/ZmbUmB/ZEZevz4ywVMXS/Jp6CER2rYV8=;
        b=g1ejbb9Ywg7miXrZUNINksbAcs/ZYzKzimMzWfr1rpVkdPHbJQ2tCU0oTw3TmulKOutCgu
        gWUzZtX5E/sud2kFiCNFui2Z/COKOExe98sC2M9PSx8v8K+5flYWFCjOkPcINv3f7ppaxQ
        YF1yRG6AkG3ch5Fkdw1yZn6V9qWCu5k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-9jJsFqN_PSW9OvZcld19ug-1; Thu, 01 Sep 2022 11:03:42 -0400
X-MC-Unique: 9jJsFqN_PSW9OvZcld19ug-1
Received: by mail-ej1-f69.google.com with SMTP id qb39-20020a1709077ea700b0073ddc845586so6953749ejc.2
        for <linux-acpi@vger.kernel.org>; Thu, 01 Sep 2022 08:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ri++8kgJLK/ZmbUmB/ZEZevz4ywVMXS/Jp6CER2rYV8=;
        b=4J6ZdTll/+5/aHGj1Op3BwG6FKixsHKt4ShGLvmM1DVzNolpO2KuQXBpZFfN4k2sek
         hiSw+dXOux5tULJUccuXmR4UBvikEVvqutLIYarkkJz7nEnWuc5BnZrQvliO87MqcUkz
         jm3dCZRC9g9qs12Z3bm2MbTyXxS/N/I0dhwwPSYJK5KNqZhk+DsQUXyoI3sL+DonXetU
         Cntb/JEN/mxiYnkEwqAPJmEAS7mzeleU6Ut66QcC5ysnutdX/blEDHBsEX+sM+JnTHoR
         To7Z2S7Ws9YTNoUKyry0sm7m3fKC12pV7wcC7Nr1Y0TPUwsjNbWQnrjTckevWAtHTluQ
         j1Hw==
X-Gm-Message-State: ACgBeo218sA7Txg5yUy4PuIwwUtjJ5Rg+OpyOv7zkq8jdkkOpv6J3jwu
        IW2+hdTIe/SiQtLDIzzTswq7pWv/kdQjccXcLJRzSzYJd8kF1KrY9qFAbw/B+iTr6JcqnWoE1qo
        L7zB+Zu895o9ItSFbs+Iggg==
X-Received: by 2002:a05:6402:4148:b0:440:cb9f:d10f with SMTP id x8-20020a056402414800b00440cb9fd10fmr29271040eda.77.1662044621139;
        Thu, 01 Sep 2022 08:03:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4JZ8D4lCnTFjyQB+7z9KIPK+a5ZtacCncGANZ4ckQW9RgcNSuRy0wzf9lBHsG/MPTsfttDKg==
X-Received: by 2002:a05:6402:4148:b0:440:cb9f:d10f with SMTP id x8-20020a056402414800b00440cb9fd10fmr29271031eda.77.1662044620948;
        Thu, 01 Sep 2022 08:03:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id k11-20020a170906578b00b0073d9d887eddsm8583428ejq.56.2022.09.01.08.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 08:03:40 -0700 (PDT)
Message-ID: <e7076b64-33f4-f91b-49d4-81b7d4f593e0@redhat.com>
Date:   Thu, 1 Sep 2022 17:03:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] ACPI: video: Add Toshiba Satellite/Portege Z830 quirk
Content-Language: en-US
To:     Arvid Norlander <lkml@vorpal.se>, linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20220824184950.631520-1-lkml@vorpal.se>
 <20220824184950.631520-2-lkml@vorpal.se>
 <d097b844-8fe4-3469-2137-9e8407348175@redhat.com>
 <3863cad2-1910-b377-011b-4970eeb68e13@vorpal.se>
 <91260f39-27d9-222b-53e7-41ab4bb412a3@redhat.com>
 <9640be14-b478-5887-9057-de2796eccd6b@redhat.com>
 <ef3046e5-f402-3d33-8d94-4d9f87ceadd5@vorpal.se>
 <68b1c4fd-56a4-8de6-62ec-98bd6ef8b169@redhat.com>
 <918639a6-3cb0-5b8d-73b2-7eed623002a0@vorpal.se>
 <86b54175-e060-d4c2-ffd2-54f2544d6d4f@redhat.com>
 <314eecd8-efce-bf3a-f9ba-0cf311023200@vorpal.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <314eecd8-efce-bf3a-f9ba-0cf311023200@vorpal.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/1/22 16:15, Arvid Norlander wrote:
> Hi,
> 
> On 2022-09-01 12:42, Hans de Goede wrote:
>> Hi,
>>
> 
> <snip>
> 
>>
>> Great, thank you so much for testing this!
>>
>> Is it ok if I add a:
>>
>> Tested-by: Arvid Norlander <lkml@vorpal.se>
>>
>> to the 2 patches for fixing this to give you credit for your testing ?
> 
> Yes, of course. As a newcommer it is hard to learn and remember all these
> little rules you have in kernel development. It is quite different from the
> forge-based workflow I'm used to.

No worries, I think you are doing great. Actually I could just have
added your Tested-by tags if I wanted too. Only the Signed-off-by tag
is one which you must explicitly give.

But asking seemed like the polite thing to do :)

>>> I'm not set up to test hibernation (using swap file on btrfs). Nor do I
>>> know if it even works on this laptop. It has some sort of auto hibernate
>>> feature in BIOS called Intel Rapid Start. It supposedly auto transitions to
>>> hibernation after being asleep for a while. I have not looked into if this
>>> is supported on Linux, and what setup would be required to support it in
>>> that case.
>>
>> Regular suspend/resume testing is what I was looking for. On restore
>> from hibernation the backlight is already on when restoring the state so
>> I don't expect any problems there.  And as you indicate getting hibernation
>> to work is tricky in general, IMHO there is no need to go through all
>> the trouble necessary to (maybe) get that to work.
> 
> Hm, I have not found it tricky when I have had swap partitions. At least on
> my Thinkpads as long as I avoid nvidia drivers.

As long as you have large enough swap partitions, yes. Sometimes figuring out
what large enough is is tricky though. Anyway we are getting offtopic.

Regards,

Hans

