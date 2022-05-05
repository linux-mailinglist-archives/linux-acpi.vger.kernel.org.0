Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978FE51C344
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 17:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380390AbiEEPHP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 May 2022 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343500AbiEEPHN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2022 11:07:13 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0680B2CE17
        for <linux-acpi@vger.kernel.org>; Thu,  5 May 2022 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651763013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sA/KIQCdTb/F+pQjAIlInu0/F8H7M5rpL61UAO5Y95w=;
        b=fF3GVhp1oDZodowdt1LpdjhOhdAM7xKTj4207HDy6ytHe/fzaRvbUJCqYfXzDzZiIfJOhF
        eSX+jZpzObPN2paoCLBTADlEt5wVq64txj4XdaSE+4HTnsK/Zx4W6mbodTPI8YzDkwZitH
        4tCaM90dJYkEkrgOerzALmOQGWvioTM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-ZPEnOw0TP6OOagOFM9JcGQ-1; Thu, 05 May 2022 11:03:32 -0400
X-MC-Unique: ZPEnOw0TP6OOagOFM9JcGQ-1
Received: by mail-ej1-f70.google.com with SMTP id sc20-20020a1709078a1400b006f4a358c817so2776609ejc.16
        for <linux-acpi@vger.kernel.org>; Thu, 05 May 2022 08:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sA/KIQCdTb/F+pQjAIlInu0/F8H7M5rpL61UAO5Y95w=;
        b=uXFdOFaWuh4T1EyFm4AZcNfVRCpe/InKXkezL76GkzaQ3ZKBMIHuYmWtTtJUq0KOn+
         H47nYh44PWaKPjA+FVoihKH8K2codlZk9bRtXx8Ncoa8zC0MRLJkBZ7/iCzE2DBY5cUg
         F/tAKCoTVllJjdh0nIHih1d/xk5YgrgZ8whKn/1+POlnfnrCCYsZW0HUZKjTKKB2OzuX
         SlDzDD6y8eNIE6VUCFr9pFUAGpQaUFyodgN1EU1vjlndJ+dbqA+FDJXZnjqDzwlRjDet
         GzTYRl/6flp+3Xcmt9G4MlYdi1GggN9QvLwjY5a/ATN1rwvP+YuK2Y2bedYR7RoAS1X/
         k3Ag==
X-Gm-Message-State: AOAM531sBBIQiShX9wzYTf/FQr3lpyRx9a2zQJ31YCjCtprZd8ILI7aI
        44ST75O3WixRxiiY5rbDif34/dUYYLQG+sy+wTaP/wEG5MJkAgwfKwmpiuXpgu6LsNTiqATVaxu
        BcVHNhZcD+nzw7fP1cp/XTw==
X-Received: by 2002:a17:907:9811:b0:6f3:a389:a203 with SMTP id ji17-20020a170907981100b006f3a389a203mr27712768ejc.381.1651763010782;
        Thu, 05 May 2022 08:03:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvKcmoPezXMvFtXD5XeulCIfHDnyYC+o7MEOW/0DJHt5i1PmO2y8VD9/zVDY88RzlffxpBNw==
X-Received: by 2002:a17:907:9811:b0:6f3:a389:a203 with SMTP id ji17-20020a170907981100b006f3a389a203mr27712727ejc.381.1651763010396;
        Thu, 05 May 2022 08:03:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id i24-20020a05640200d800b0042617ba63a8sm980440edu.50.2022.05.05.08.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 08:03:29 -0700 (PDT)
Message-ID: <8e3ad8dc-b9a3-4c2d-f673-19434b565e72@redhat.com>
Date:   Thu, 5 May 2022 17:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/3] x86/PCI: Log E820 clipping
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220502203205.GA349835@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220502203205.GA349835@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/2/22 22:32, Bjorn Helgaas wrote:
> On Mon, May 02, 2022 at 02:24:26PM +0200, Hans de Goede wrote:
>> On 4/19/22 18:45, Bjorn Helgaas wrote:
>>> On Tue, Apr 19, 2022 at 05:16:44PM +0200, Hans de Goede wrote:
>>>> On 4/19/22 17:03, Bjorn Helgaas wrote:
>>>>> On Tue, Apr 19, 2022 at 11:59:17AM +0200, Hans de Goede wrote:
> 
>>>>>> So what is the plan to actually fix the issue seen on some
>>>>>> Lenovo models and Clevo Barebones ?   As I mentioned previously
>>>>>> I think that since all our efforts have failed so far that we
>>>>>> should maybe reconsider just using DMI quirks to ignore the
>>>>>> E820 reservation windows for host bridges on affected models ?
>>>>>
>>>>> I have been resisting DMI quirks but I'm afraid there's no other
>>>>> way.
>>>>
>>>> Well there is the first match adjacent windows returned by _CRS
>>>> and only then do the "covers whole region" exception check. I
>>>> still think that would work at least for the chromebook
>>>> regression...
>>>
>>> Without a crystal clear strategy, I think we're going to be
>>> tweaking the algorithm forever as the _CRS/E820 mix changes.
>>> That's why I think that in the long term, a "use _CRS only, with
>>> quirks for exceptions" strategy will be simplest.
>>
>> Looking at the amount of exception we already now about I'm not sure
>> if that will work well.
> 
> It's possible that many quirks will be required.  But I think in the
> long run the value of the simplest, most obvious strategy is huge.
> It's laid out in the spec already and it's the clearest way to
> agreement between firmware and OS.  When we trip over something, it's
> very easy to determine whether _CRS is wrong or Linux is using it
> wrong.  If we have to bring in question of looking at E820 entries,
> possibly merging them, using them or not based on overlaps ... that's
> a much more difficult conversation without a clear resolution.
> 
>>> So I think we should go ahead with DMI quirks instead of trying to
>>> make the algorithm smarter, and yes, I think we will need commandline
>>> arguments, probably one to force E820 clipping for future machines,
>>> and one to disable it for old machines.
>>
>> So what you are suggesting is to go back to a bios-date based approach
>> (to determine old vs new machines) combined with DMI quirks to force
>> E820 clipping on new machines which turn out to need it despite them
>> being new ?
> 
> Yes.  It's ugly but I think the 10-year outlook is better.

Ok, I've brushed off one of my earlier patches doing this and
added DMI quirks for the "Lenovo X1 Carbon 2nd gen" suspend
issue + the Asus C523NA / Google Coral Chromebook not booting
issues which we already know will get triggered by this based
on earlier testing.

I'll send this out right after this email.

Note this new patch is based on top of your:

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/resource

>> I have the feeling that if we switch to top-down allocating
>> that we can then switch to just using _CRS and that everything
>> will then just work, because we then match what Windows is doing...
> 
> Yes, it might.  But I'm not 100% comfortable because it basically
> sweeps _CRS bugs under the rug, and we may trip over them as we do
> more hotplug and (eventually) resource rebalancing.  I think we need
> to work toward getting _CRS more reliable.

Ok.

Regards,

Hans

