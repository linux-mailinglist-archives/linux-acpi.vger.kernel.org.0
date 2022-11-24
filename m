Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC21637FFD
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Nov 2022 21:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKXUBJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Nov 2022 15:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKXUBI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Nov 2022 15:01:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF0364DD
        for <linux-acpi@vger.kernel.org>; Thu, 24 Nov 2022 12:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669320003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G8ifTS6PG9dEREX9PR6KkAWzSoCO7YzSSqxtzhe7mPo=;
        b=g/q9rUWdB3BuaPgd3M6bh6a1OrB/6snI8tJe/eCZORpwzNfIpzQSAS3U+24dQX5aLK8ayn
        SehCap9SiwVWDjZeCSz0+ksscYqMtWvhS+v2LdG36iT1oW6PZLYMrDh9AUrX8VpuXPeJSN
        JGPLRJ0X87pxPrQOJ9DxwDC6WgKNYlk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-cPP8cuYWMeW5kvLnVDlXUQ-1; Thu, 24 Nov 2022 15:00:02 -0500
X-MC-Unique: cPP8cuYWMeW5kvLnVDlXUQ-1
Received: by mail-ed1-f71.google.com with SMTP id e15-20020a056402190f00b00461b0576620so1361892edz.2
        for <linux-acpi@vger.kernel.org>; Thu, 24 Nov 2022 12:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8ifTS6PG9dEREX9PR6KkAWzSoCO7YzSSqxtzhe7mPo=;
        b=Md2K/zRrLu7dbQDPKLQ46HBzfb3CrpKyX1ZTpLtxRWFmr+sBTHx2kwpTZNwJs8kNfL
         iaxoyBuQB4InZG4qAdh/xJFB1xlHqTkt1W7rZAB9G51dJgrsVWTuLtqOLjtGaSXdCQnd
         dLwL6slJZq/ncVTdkB7sqhsGON0X5WOtOMO/iGALjbQRgFWeeHNvwfSM0hNfKjjtOwkm
         c7WUpwxZkwplFkdugTKu58FTgv0XDbsip+mwMEzyOiRwo/uhGkjVZeGycL4FFB3NF339
         993n2WeEQMX8HSwSBxkO+X9nKjX+KxXL7pBqH7eQTXtlEnlp4AoVK8D4jPwNLKc0Lakn
         J5fA==
X-Gm-Message-State: ANoB5plCiHvu/HheOK+UpmBdPDofHW2LUdFeXHBmbroRu1NaSGg4iTnu
        idZ1zfrn32yDMHcV8pPTocVHJNA+l9mLJKX6pn+/w108yLD3FidVyyB9OMhCD+foK2gfv6QR82l
        spC4JTCTyE0Dl0VkzjwFfZg==
X-Received: by 2002:a17:906:2e96:b0:7ad:8f76:17c7 with SMTP id o22-20020a1709062e9600b007ad8f7617c7mr18213845eji.315.1669320000647;
        Thu, 24 Nov 2022 12:00:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf76a/mmCkrmvDZGKLFvozcxz02V0B3/EAS4xR/MTqK+LqrUBWq3Lqgu8EwPb3/Oz1AZcj69tg==
X-Received: by 2002:a17:906:2e96:b0:7ad:8f76:17c7 with SMTP id o22-20020a1709062e9600b007ad8f7617c7mr18213832eji.315.1669320000417;
        Thu, 24 Nov 2022 12:00:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id a4-20020aa7d744000000b004615f7495e0sm888362eds.8.2022.11.24.11.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 11:59:59 -0800 (PST)
Message-ID: <a30cba31-e3a9-9ed5-8476-ed88d18d5e4f@redhat.com>
Date:   Thu, 24 Nov 2022 20:59:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/3] platform/x86: int3472/discrete: Make it work with
 IPU6
Content-Language: en-US, nl
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org
References: <20221124195737.390729-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221124195737.390729-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Sorry this series was sent to the wrong people / list. I will resend it
to the right people now. Please ignore.

Regards,

Hans



On 11/24/22 20:57, Hans de Goede wrote:
> Hi All,
> 
> Here is a small set of patches to make the int3472/discrete code
> work with the sensor drivers bundled with the (unfortunately out of tree)
> IPU6 driver.
> 
> There are parts of the out of tree IPU6 code, like the sensor drivers,
> which can be moved to the mainline and I do plan to work on this at some
> point and then some of this might need to change. But for now the goal is
> to make the out of tree driver work with standard mainline distro kernels
> through e.g. dkms. Otherwise users need to run a patched kernel just for
> a couple of small differences.
> 
> This is basically a rewrite of this patch:
> https://github.com/intel/ipu6-drivers/blob/master/patch/int3472-support-independent-clock-and-LED-gpios-5.17%2B.patch
> 
> Wich users who want to use the IPU6 driver so far have had to manually
> apply to their kernels which is quite inconvenient.
> 
> This rewrite makes 2 significant changes:
> 
> 1. Don't break things on IPU3 platforms
> 
> 2. Instead of extending the int3472_sensor_configs[] quirks table for each
> model which needs "clken" and "pled" GPIOs, do this based on matching
> the ACPI HID of the ACPI device describing the sensor.
> 
> The need for these GPIOs is a property of the specific sensor driver which
> binds using this same HID, so by using this we avoid having to extend the
> int3472_sensor_configs[] quirks table all the time.
> 
> This allows roling back the behavior to at least use a clk-framework
> clk instead of clken GPIO on a per sensor(-driver) basis as we mainline
> the sensor drivers, assuming that the drivers are switched over to the
> clk framework as part of their mainlining.
> 
> A bigger question is what to do with the privacy-led GPIO on IPU3
> we so far have turned the LED on/off at the same as te clock,
> but at least on some IPU6 models this won't work, because they only
> have a privacy-led GPIO and no clk_en GPIO (there is no sensor
> clk-control at all on some models).
> 
> I think we should maybe move all models, including IPU3 based
> models over to using a normal GPIO for controlling the privacy-led
> to make things consistent.
> 
> And likewise (eventually) completely drop the "clken" GPIO this
> patch series introduces (with some sensors) and instead always model
> this through the clk-framework.
> 
> Regards,
> 
> Hans
> 
> 
> Hans de Goede (3):
>   platform/x86: int3472/discrete: Refactor GPIO to sensor mapping
>   platform/x86: int3472/discrete: Get the polarity from the _DSM entry
>   platform/x86: int3472/discrete: Add support for sensor-drivers which
>     expect clken + pled GPIOs
> 
>  drivers/platform/x86/intel/int3472/common.h   |  2 +-
>  drivers/platform/x86/intel/int3472/discrete.c | 92 ++++++++++++++++---
>  2 files changed, 78 insertions(+), 16 deletions(-)
> 

