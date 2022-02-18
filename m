Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38E4BB484
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Feb 2022 09:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiBRIpb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Feb 2022 03:45:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiBRIpb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Feb 2022 03:45:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C1D2B31A6;
        Fri, 18 Feb 2022 00:45:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o24so13307646wro.3;
        Fri, 18 Feb 2022 00:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Sr7ZtpXKpXSR3HHhw/hN/uykfNrvRkMr17XVKktgdG8=;
        b=m0IWxK/45Qx7pGUcJrOeQenjuZ2zyPv1kKRTcJyKCpHtTXH4fEaCi2F2EHTljhftxy
         Zs9vy+viOeerFVdkAkmGV78xxjBdRKKH96Ocyh2GHY1omXDlFdnlJf46ivWvbqM8fzqL
         10MSg5y5QGPl4I9myBskqcwoHRUtlyub5TrbkN5mWQJRESuqtlkv7XLtGAeh6GLiN3uK
         JOV1Z3Ch0+H7qAH+k5sHzuzvTlFuxgbZbUHTUqoAvn4hYegWa6malxdmBa5oSeu+UqL+
         AU3nDoDRyVNyTA3XsIWPmsqywl9jVfB+sZscVxcCLqR/0m++K4euXVqDO9xZDTqoee1/
         DC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sr7ZtpXKpXSR3HHhw/hN/uykfNrvRkMr17XVKktgdG8=;
        b=BAP3+qNeRzSoyyVHrDoQjqcvFRn3ASR+3Kxwrlkik5szED1X2QbscCXOen5wjE3lAd
         AbpyMafJX0SD7Ir3axUn9b5vS1qYZGIw91M1kg9P7GkwissQYcfeg8tBbBVNWXeHsHKL
         8BwMp38VWGsnGZkTxbOR2k6sVwRJP+ARNTVQKYEzPvYVLQgd8Bk0uoHnCYwBdurmSeBQ
         ALCTqWUDNg9v1HBFd3PZukSHf5Aln2RB7zfMEUSCyzsO8MRghQPKTzzwXnlM6AGx6leB
         5zhjxGqJP6Uerh/H9PRDPWcdcc9iJIzt3iWzntcYRGZF2xlp8jaHGNHRZ4qYrSSib2Je
         jttA==
X-Gm-Message-State: AOAM5310Soa+pfseymobF5qHI/igpH4ucndttEtQMfFj1+f2/EHBfo75
        UO5jmZp3obapDLsiMShnOPs=
X-Google-Smtp-Source: ABdhPJyPud2lA0YJnj3pirn1ww5ilXBn1bqnmQhyDC78BctFCW06uq2qo1/Ijuuj1hJCC8d+wBzw1w==
X-Received: by 2002:adf:eb89:0:b0:1e4:b8f4:da74 with SMTP id t9-20020adfeb89000000b001e4b8f4da74mr5272178wrn.408.1645173911799;
        Fri, 18 Feb 2022 00:45:11 -0800 (PST)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id o4sm3988275wms.9.2022.02.18.00.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 00:45:11 -0800 (PST)
Message-ID: <e9846ac9-0b61-3c11-8a5c-0dc1dd69e6cf@gmail.com>
Date:   Fri, 18 Feb 2022 08:45:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/6] Add multiple-consumer support to int3472-tps68470
 driver
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, markgross@kernel.org, robert.moore@intel.com
References: <20220216225304.53911-1-djrscally@gmail.com>
 <f2b58ed6-6c53-42af-6fa1-94b9fd746fc3@redhat.com>
From:   Daniel Scally <djrscally@gmail.com>
In-Reply-To: <f2b58ed6-6c53-42af-6fa1-94b9fd746fc3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans

On 17/02/2022 09:55, Hans de Goede wrote:
> Hi Dan,
>
> On 2/16/22 23:52, Daniel Scally wrote:
>> At the moment there are a few places in the int3472-tps68470 driver that are
>> limited to just working with a single consuming device dependent on the PMIC.
>> There are systems where multiple camera sensors share a single TPS68470, so
>> we need to extend the driver to support them. This requires a couple of tweaks
>> to the ACPI functions to fetch dependent devices, which also assumes that only
>> a single dependent will be found.
> This sounds great, thank you for your work on this. I have a bit of a backlog wrt
> pdx86 patches to review and I try to through those in FIFO order to keep things fair,
> so it may be a while (approx. 1-2 weeks) before I get around to reviewing
> these.


No problem, thanks very much

>
> Regards,
>
> Hans
>
>
>> Hans - this (plus a series to media [1]) adds support for the Surface Go 2's
>> IR camera...the regulator settings for the Go1/2/3 world facing camera are the
>> same, so I'd expect them to match for the IR sensor too, which means it should
>> enable support for your Go too.
>>
>> Thanks
>> Dan
>>
>>
>> [1] https://lore.kernel.org/linux-media/20220215230737.1870630-1-djrscally@gmail.com/
>>
>> Daniel Scally (6):
>>   ACPI: scan: Add acpi_dev_get_next_consumer_dev()
>>   ACPI: bus: Add iterator for dependent devices
>>   platform/x86: int3472: Support multiple clock consumers
>>   platform/x86: int3472: Add terminator to gpiod_lookup_table
>>   platform/x86: int3472: Support multiple gpio lookups in board data
>>   platform/x86: int3472: Add board data for Surface Go2 IR camera
>>
>>  drivers/acpi/scan.c                           | 47 +++++++++--
>>  drivers/clk/clk-tps68470.c                    | 13 +++-
>>  drivers/platform/x86/intel/int3472/tps68470.c | 77 +++++++++++++++----
>>  drivers/platform/x86/intel/int3472/tps68470.h |  3 +-
>>  .../x86/intel/int3472/tps68470_board_data.c   | 58 +++++++++++++-
>>  include/acpi/acpi_bus.h                       | 14 ++++
>>  include/linux/platform_data/tps68470.h        |  7 +-
>>  7 files changed, 188 insertions(+), 31 deletions(-)
>>
