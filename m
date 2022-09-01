Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AA25A94E4
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Sep 2022 12:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiIAKmx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Sep 2022 06:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbiIAKme (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Sep 2022 06:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703C312D536
        for <linux-acpi@vger.kernel.org>; Thu,  1 Sep 2022 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662028933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBAkshLez74zArR4YKii1/Vay7rF77DExaEbL9VjahI=;
        b=VW7PAL/5bXsJtHY4/OPUwNdv0cQy6cFhXdxLtlNhpRmYfl25lAvMVcmSQ7fV6WsXDikL89
        qgKyGslVv8FZInvaimWbY+fgKCk89hJozaFc/vcQUGVveCw9wZR6tidt5IguiHsYHqQkJZ
        +sn1XXxX6NuTSHDhwZoQx6PZwmtd37o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-504-LMaulRl1OnyFJk_OlT_zqQ-1; Thu, 01 Sep 2022 06:42:12 -0400
X-MC-Unique: LMaulRl1OnyFJk_OlT_zqQ-1
Received: by mail-ej1-f72.google.com with SMTP id ds17-20020a170907725100b007419bfb5fd4so5265504ejc.4
        for <linux-acpi@vger.kernel.org>; Thu, 01 Sep 2022 03:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GBAkshLez74zArR4YKii1/Vay7rF77DExaEbL9VjahI=;
        b=UmIImQMerjK5KskSvt69fPoYWNGanugy+Gb5bPLC602ON0JuOFdFR6kUzgiG038NJz
         amj4L94IvsX2BoY7IyJGfoJ0hiMjG7e4gfp5Q62aWK35PEvXK/H9JgW+V/JyF9wLutdp
         faH82ltuiDtgfjfREKyG9GlIpRISaWLNG4Zli0diWQaTKTXQUSpHYyvLAKnbm2QkGKes
         bXKjqo+tsYrjoavovO/xbPCiUUJJPqP3prKQxRENEr8HYvUQs2HK5k36RQKbKw7pk+yu
         eNcoRdvnKUV2nBdCe7rdujDnj/ru3KIC8qAso4p1PXXDht2YbkiqVpPEIjNQxSrFvWCe
         QPXw==
X-Gm-Message-State: ACgBeo2/xYqR5/oAXjFtWv3GPonnYDMHKMD+wugcJAM90CQpFAcamIxV
        2QLGlnDfZb6DHul5ZynaRpg9ur6b0zx9RMW00GoRpqELqVVNR1IXCfyCcngq8CLokZWRfjvPKBh
        wexencbXcupCDNlcV5Nh3yQ==
X-Received: by 2002:a17:907:75c1:b0:72f:248d:5259 with SMTP id jl1-20020a17090775c100b0072f248d5259mr23710765ejc.227.1662028931187;
        Thu, 01 Sep 2022 03:42:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Y/Rs/Hm3l7kPVkgtVXOYYCY2bq9Db+z+lhpqaPD2EYVgL9ArK1IzI5slCJhvDEPaxsgk77Q==
X-Received: by 2002:a17:907:75c1:b0:72f:248d:5259 with SMTP id jl1-20020a17090775c100b0072f248d5259mr23710753ejc.227.1662028930929;
        Thu, 01 Sep 2022 03:42:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id fe15-20020a1709072a4f00b0073da4b623e8sm8116704ejc.152.2022.09.01.03.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 03:42:10 -0700 (PDT)
Message-ID: <86b54175-e060-d4c2-ffd2-54f2544d6d4f@redhat.com>
Date:   Thu, 1 Sep 2022 12:42:09 +0200
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <918639a6-3cb0-5b8d-73b2-7eed623002a0@vorpal.se>
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

On 8/31/22 15:44, Arvid Norlander wrote:
> Hi,
> 
> 
> On 2022-08-29 20:58, Hans de Goede wrote:
>> Hi,
>>
>> On 8/29/22 20:30, Arvid Norlander wrote:
>>> Hi,
>>>
>>> On 2022-08-29 16:12, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>
>>> <snip>
>>>
>>>>
>>>> Arvid, here is a git branch with my backlight-refactor for you
>>>> to test:
>>>>
>>>> https://github.com/jwrdegoede/linux-sunxi/commits/backlight-refactor-for-arvid
>>>>
>>>> If you can give this a test spin (without any special kernel
>>>> commandline options) then that would be great.
>>>
>>> I'll set up a PKGBUILD and get this built (I'm building on other computers).
>>> It may take a couple of days before I get around to that however. I hope
>>> this is okay with you.
>>
>> Yes that is fine, thank you.
> 
> Just and update to let you know that your tree works, at least for suspend.

Great, thank you so much for testing this!

Is it ok if I add a:

Tested-by: Arvid Norlander <lkml@vorpal.se>

to the 2 patches for fixing this to give you credit for your testing ?

> I'm not set up to test hibernation (using swap file on btrfs). Nor do I
> know if it even works on this laptop. It has some sort of auto hibernate
> feature in BIOS called Intel Rapid Start. It supposedly auto transitions to
> hibernation after being asleep for a while. I have not looked into if this
> is supported on Linux, and what setup would be required to support it in
> that case.

Regular suspend/resume testing is what I was looking for. On restore
from hibernation the backlight is already on when restoring the state so
I don't expect any problems there.  And as you indicate getting hibernation
to work is tricky in general, IMHO there is no need to go through all
the trouble necessary to (maybe) get that to work.

Regards,

Hans

