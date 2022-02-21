Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FF84BDD8E
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 18:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355280AbiBUKqV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Feb 2022 05:46:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355438AbiBUKps (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 05:45:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0DBA27B26
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 02:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645438045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JKcYC1jQAnijQ05LdhY3CVZ5ZYi0oZ2fyWz8eU5HqPE=;
        b=G89fFXXAzBL4MM/q3V0jsHa2gyGfKzTHR3teEYf+I+iaJ0QukmfqgbJuka7qp0xB6K7qKf
        hwJjNhLpqj2OAehD2l6ZbpqR32BvrNdwpkAYlrx6jVDuyPjFbzuDXLP5k5kJ97PPxKVRP+
        hK7ta69HF4Ebb1NalDIEtGqmWxp3DHU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-_ISPLLXKNaCaZpDhbwJnnQ-1; Mon, 21 Feb 2022 05:07:21 -0500
X-MC-Unique: _ISPLLXKNaCaZpDhbwJnnQ-1
Received: by mail-ej1-f71.google.com with SMTP id m4-20020a170906160400b006be3f85906eso4447198ejd.23
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 02:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JKcYC1jQAnijQ05LdhY3CVZ5ZYi0oZ2fyWz8eU5HqPE=;
        b=r55QVBE4rEPZOq7HGeJNkKRXU3bTENv8DoO7oiSoce9NDALp5f72fl0/MTgEiRuFGr
         0ufI1vysGpFdXOThoK0w3x0eahVZhSNTPDaecOfoU9xAaU9hZHB/ZLfuRb5txpZ0Y6iX
         cKwFf7LkW/w6f3FXTV70moZcTuRzjhgnd985T1u9PkyTsAkuGgIYfoh67l2D8xmFlmD6
         QZpVOvCrnA1oBborH8Rj6CxvNEluStxEUu4UTLRkyDOlH1IgvSweY/16v7o3TdT7daud
         jZOzz+z+S7FSIimfGBmZZC6dga3w+LpDLmudab60E8aKywmqqm78sBVN+GD3AcCxKj8y
         54zg==
X-Gm-Message-State: AOAM5331oriJpKFe3tAS2RCI6Cy6jDasswO6cPekTZahmcTwEGr9GHG1
        jUgNt6wlxj4upKSjVdrJjuaGs5ry16GNwilxbWDbcy+2r/gjNPRtOrcK5mzdnpwL7fcLNx6VKFF
        IcSCQFEbn2JGc7TvOl7AWHA==
X-Received: by 2002:a05:6402:520c:b0:412:7f7d:b06b with SMTP id s12-20020a056402520c00b004127f7db06bmr21088271edd.91.1645438040210;
        Mon, 21 Feb 2022 02:07:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkY61AooWL3STz8a6Kvk0GMWUYyH4lzSYr5r0n1bCnKaka25Ycc31hfJnIxY+O5F3+pEpLUg==
X-Received: by 2002:a05:6402:520c:b0:412:7f7d:b06b with SMTP id s12-20020a056402520c00b004127f7db06bmr21088250edd.91.1645438040053;
        Mon, 21 Feb 2022 02:07:20 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a13sm5571821edn.25.2022.02.21.02.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 02:07:19 -0800 (PST)
Message-ID: <7f8f0c0c-cc47-f1bb-3826-6e782dac196a@redhat.com>
Date:   Mon, 21 Feb 2022 11:07:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/6] Add multiple-consumer support to int3472-tps68470
 driver
Content-Language: en-US
To:     Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     lenb@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        markgross@kernel.org, robert.moore@intel.com
References: <20220216225304.53911-1-djrscally@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220216225304.53911-1-djrscally@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/16/22 23:52, Daniel Scally wrote:
> At the moment there are a few places in the int3472-tps68470 driver that are
> limited to just working with a single consuming device dependent on the PMIC.
> There are systems where multiple camera sensors share a single TPS68470, so
> we need to extend the driver to support them. This requires a couple of tweaks
> to the ACPI functions to fetch dependent devices, which also assumes that only
> a single dependent will be found.
> 
> Hans - this (plus a series to media [1]) adds support for the Surface Go 2's
> IR camera...the regulator settings for the Go1/2/3 world facing camera are the
> same, so I'd expect them to match for the IR sensor too, which means it should
> enable support for your Go too.

Thank you, this mostly looks good to me. I've added some small remarks but
nothing big stands out.

Rafael, I think it would be easiest for me to merge this entire series through
pdx86/for-next. May I have your ack for patches 1+2 to merge them through
the pdx86 tree?

Regards,

Hans



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

