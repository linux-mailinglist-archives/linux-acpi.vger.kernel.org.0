Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403125E5E08
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Sep 2022 10:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiIVIzf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Sep 2022 04:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiIVIzU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Sep 2022 04:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9568285C
        for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2022 01:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663836918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdiDAJTCMAzX+ykt41hEleL0+IM5Y5eQhfHjMQrLPXI=;
        b=HiITEncCcELPWOLYjqzlUmfWmneAel+VCSMZvrUrp0Vg+KaAPtOMHkvOYUmEm1Qn8JyGgs
        9fYHPNSWsYYR5Pu+mzSzlI0/BrRer2335VHpcilLIgThxyQR5QCZ1l6q/PtIXnhGxb0LfS
        Qx/W3yVWfCoKLZPQDOebVs38hBBlqzo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-134-ZfM8luooMHyPBpmNo_biCw-1; Thu, 22 Sep 2022 04:55:17 -0400
X-MC-Unique: ZfM8luooMHyPBpmNo_biCw-1
Received: by mail-ed1-f70.google.com with SMTP id c6-20020a05640227c600b004521382116dso6297190ede.22
        for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2022 01:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EdiDAJTCMAzX+ykt41hEleL0+IM5Y5eQhfHjMQrLPXI=;
        b=Fa5eXnnTUo3HQ0/TtfCi5BcJ975mkgGtwPbkiu2JjmECXNAXYHEyNBUlZ7rL6UXXg1
         wnjijjue7Q36t5JNImVKnjcXL/5Eex8gIRfm3s3N+wh2EISh9hwl3xl1IJwNeRyFChJG
         ke36gCNQWdnpnIve4JBWElsPXjPdhs/1BCDRQsv6h9M2mKVq1nXxW2SKTHWZ3YtZptBb
         usfF8k/b+n+fwYoFy+davZJODaWB55lYiesGM7hsOBhipKb35AuWeGe47FaorpPcIfT8
         cAFG/pzik5hmzVOm9H2paBN8HSv7LoeO422sOfM4s14DVJ404UdhAqoEyMALZAUcFGIH
         4k+g==
X-Gm-Message-State: ACrzQf2rl+cOOFpbOTggS0h+w+bF8TauiAHvgWXa8pn2BjGzxYnVUZgy
        TKlfMm+BBF6ru0OQ4/KCqOq7WVBfdU/wkkeQbim7xlTc2kHxzmml0dx8CQUuT2lg3cBDhFW6w4t
        yGwMa+bqEBTyraVgUAhnyhA==
X-Received: by 2002:a17:907:802:b0:781:8017:b2df with SMTP id wv2-20020a170907080200b007818017b2dfmr1873872ejb.606.1663836916053;
        Thu, 22 Sep 2022 01:55:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM50x+2ek7YQDMVLHqoIQ0g6AvEXVXfaH5QJjBYK801HTXDjnpZl4u3C+Wgw3wumDVlPyD2ckA==
X-Received: by 2002:a17:907:802:b0:781:8017:b2df with SMTP id wv2-20020a170907080200b007818017b2dfmr1873857ejb.606.1663836915873;
        Thu, 22 Sep 2022 01:55:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id a10-20020a50ff0a000000b00454546561cfsm3203909edu.82.2022.09.22.01.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 01:55:15 -0700 (PDT)
Message-ID: <b3855fe0-4b85-a442-1835-3e62456b3206@redhat.com>
Date:   Thu, 22 Sep 2022 10:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 0/5] Add multiple-consumer support to int3472-tps68470
 driver
Content-Language: en-US
To:     Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, markgross@kernel.org, robert.moore@intel.com
References: <20220921230439.768185-1-djrscally@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220921230439.768185-1-djrscally@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On 9/22/22 01:04, Daniel Scally wrote:
> Hello all
> 
> At the moment there are a few places in the int3472-tps68470 driver that are
> limited to just working with a single consuming device dependent on the PMIC.
> There are systems where multiple camera sensors share a single TPS68470, so
> we need to extend the driver to support them. This requires a couple of tweaks
> to the ACPI functions to fetch dependent devices, which also assumes that only
> a single dependent will be found.
> 
> The v2 for this series was some time ago...it's kept falling to the back of my
> to-do list so I've only just gotten round to it; sorry about that. v2 here:
> 
> https://lore.kernel.org/linux-acpi/20220327161344.50477-1-djrscally@gmail.com/

Rafael, I would like to merge this through the pdx86 tree may I have your
ack for patches 1 + 2 for this. As a reminder (since it has been a while)
here are your review remarks to v2 of patch 1:

https://lore.kernel.org/platform-driver-x86/CAJZ5v0i2ciLHP-=8eQcZc0v0xCzhKHKpxLC=Kgv6W5E_5=HQJA@mail.gmail.com/

(which both seem to have been addressed)

AFAICT you did not have any remarks for v2 of patch 2.

Regards,

Hans

p.s.

Dan, if I want to give the IR cam a test run on my own Surface Go (version 1)
I guess I may need a sensor driver? Where can I find that sensor driver and
what do I need in userspace to test this ?



> Daniel Scally (5):
>   ACPI: scan: Add acpi_dev_get_next_consumer_dev()
>   ACPI: bus: Add iterator for dependent devices
>   platform/x86: int3472: Support multiple clock consumers
>   platform/x86: int3472: Support multiple gpio lookups in board data
>   platform/x86: int3472: Add board data for Surface Go2 IR camera
> 
>  drivers/acpi/scan.c                           | 40 +++++++---
>  drivers/clk/clk-tps68470.c                    | 13 +++-
>  drivers/platform/x86/intel/int3472/common.c   |  2 +-
>  drivers/platform/x86/intel/int3472/tps68470.c | 76 ++++++++++++++++---
>  drivers/platform/x86/intel/int3472/tps68470.h |  3 +-
>  .../x86/intel/int3472/tps68470_board_data.c   | 54 ++++++++++++-
>  include/acpi/acpi_bus.h                       | 15 +++-
>  include/linux/platform_data/tps68470.h        |  7 +-
>  8 files changed, 177 insertions(+), 33 deletions(-)
> 

