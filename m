Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6224B9C8C
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Feb 2022 10:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbiBQJzu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Feb 2022 04:55:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbiBQJzt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Feb 2022 04:55:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C306D5544
        for <linux-acpi@vger.kernel.org>; Thu, 17 Feb 2022 01:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645091733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eyehDj2VTQQcbrlQrKGbSsSHxAxbSKUJikiSyHYpsMY=;
        b=AhHUAoA0je363/cRB47LVIswX6ERYkxo5t8d/ahIWSb0ESJ2PGojRnAY7kq//h7Ih7gDxg
        eJA2oIEb/lvqGMpW81HxoC9BQwWIoHbMjqC6NOAsIM8z68xPdn1shusN9/qdXKhTOiIkm7
        V80dcdrAcUWa6IH2KZiGTkMzL6kq7ok=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-G1a9-0ZFOaCAjL2V7XBuLg-1; Thu, 17 Feb 2022 04:55:31 -0500
X-MC-Unique: G1a9-0ZFOaCAjL2V7XBuLg-1
Received: by mail-ed1-f71.google.com with SMTP id m4-20020a50cc04000000b0040edb9d147cso3210513edi.15
        for <linux-acpi@vger.kernel.org>; Thu, 17 Feb 2022 01:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eyehDj2VTQQcbrlQrKGbSsSHxAxbSKUJikiSyHYpsMY=;
        b=aHfqf7zW3fLvjTJaAQaFVr/D+wB/99Du77PW13uiN7xA44b2Mq+KqlmKYADLX8i8Nw
         lVQY09wrWddKP2ICyyIhyYJ4MN4pjjJoM3jTWkTZcg9e3i3z0T8+sdGvhGp4FYCq7aC+
         1i4OfyfO24p54Ejyrw1nByrcodI2w0qqovRfjPedV92wWOxkI+Oa6sIOjSCV6ZTdHard
         pSYD6EBHo/Vxxri+gxXTA2xzljfd7YEhozfH+urXJ5ZStkRsN1ToMS62133mWNye9UWC
         TNiQF0JZQxiPIAw6xXLBXnJYTy/aFEWpo4KY+uLqHtN6OU2Rm+zk9yAYOs47QHbFb3vH
         JSIA==
X-Gm-Message-State: AOAM530s92Y+X+WXbNrBPzo5zCovew5dY0zrF32W7ygTKyvhozDlITha
        JbzRBvKp+0WU3R1asIB09U1v1pgCzPkiTK2r3jB5Hu4zT41w3vgjeFqKLYjD3AsIjXo8vWY1IRy
        +CEehCd3sn610UWpDO8OHRg==
X-Received: by 2002:a17:906:71d7:b0:6bb:c057:3a6 with SMTP id i23-20020a17090671d700b006bbc05703a6mr1658503ejk.22.1645091730653;
        Thu, 17 Feb 2022 01:55:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDSILftK4zZpohcvCGqRpOvy2dnmE9rgV73s3LlEyfrOXVw8a8s5388bBYSA2m939HVhQSTA==
X-Received: by 2002:a17:906:71d7:b0:6bb:c057:3a6 with SMTP id i23-20020a17090671d700b006bbc05703a6mr1658490ejk.22.1645091730425;
        Thu, 17 Feb 2022 01:55:30 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id j6sm2970866edl.98.2022.02.17.01.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 01:55:29 -0800 (PST)
Message-ID: <f2b58ed6-6c53-42af-6fa1-94b9fd746fc3@redhat.com>
Date:   Thu, 17 Feb 2022 10:55:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/6] Add multiple-consumer support to int3472-tps68470
 driver
Content-Language: en-US
To:     Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, markgross@kernel.org, robert.moore@intel.com
References: <20220216225304.53911-1-djrscally@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220216225304.53911-1-djrscally@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Dan,

On 2/16/22 23:52, Daniel Scally wrote:
> At the moment there are a few places in the int3472-tps68470 driver that are
> limited to just working with a single consuming device dependent on the PMIC.
> There are systems where multiple camera sensors share a single TPS68470, so
> we need to extend the driver to support them. This requires a couple of tweaks
> to the ACPI functions to fetch dependent devices, which also assumes that only
> a single dependent will be found.

This sounds great, thank you for your work on this. I have a bit of a backlog wrt
pdx86 patches to review and I try to through those in FIFO order to keep things fair,
so it may be a while (approx. 1-2 weeks) before I get around to reviewing
these.

Regards,

Hans


> 
> Hans - this (plus a series to media [1]) adds support for the Surface Go 2's
> IR camera...the regulator settings for the Go1/2/3 world facing camera are the
> same, so I'd expect them to match for the IR sensor too, which means it should
> enable support for your Go too.
> 
> Thanks
> Dan
> 
> 
> [1] https://lore.kernel.org/linux-media/20220215230737.1870630-1-djrscally@gmail.com/
> 
> Daniel Scally (6):
>   ACPI: scan: Add acpi_dev_get_next_consumer_dev()
>   ACPI: bus: Add iterator for dependent devices
>   platform/x86: int3472: Support multiple clock consumers
>   platform/x86: int3472: Add terminator to gpiod_lookup_table
>   platform/x86: int3472: Support multiple gpio lookups in board data
>   platform/x86: int3472: Add board data for Surface Go2 IR camera
> 
>  drivers/acpi/scan.c                           | 47 +++++++++--
>  drivers/clk/clk-tps68470.c                    | 13 +++-
>  drivers/platform/x86/intel/int3472/tps68470.c | 77 +++++++++++++++----
>  drivers/platform/x86/intel/int3472/tps68470.h |  3 +-
>  .../x86/intel/int3472/tps68470_board_data.c   | 58 +++++++++++++-
>  include/acpi/acpi_bus.h                       | 14 ++++
>  include/linux/platform_data/tps68470.h        |  7 +-
>  7 files changed, 188 insertions(+), 31 deletions(-)
> 

