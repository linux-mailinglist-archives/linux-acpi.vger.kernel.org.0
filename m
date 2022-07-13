Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E45757331E
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jul 2022 11:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiGMJnr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Jul 2022 05:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiGMJno (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jul 2022 05:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72CA05FF1
        for <linux-acpi@vger.kernel.org>; Wed, 13 Jul 2022 02:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657705421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q57qMhZZqPk/BSCGCLflk0fgjBCLtpUl3ALcakqi8Wk=;
        b=GSubXM/0WdKkgpO55S/DQcHSKvBgWqeezgEqBYV1KcgP5Ie4YyBn8ZQH7Asg153+vzwpHD
        sMGlIYAuJs7Ezck8yH4ZJH6TQ5zaVHySHC1j1/cqYfuq65N68bLWza4pyn9gjY2KWYUB6X
        v1xin2lQqOUhAOAvLAmTXVNU8PXTSLU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-Goi0tbt5Oq6CCJtAAjhHUg-1; Wed, 13 Jul 2022 05:43:40 -0400
X-MC-Unique: Goi0tbt5Oq6CCJtAAjhHUg-1
Received: by mail-ej1-f70.google.com with SMTP id s4-20020a170906500400b006feaccb3a0eso3193439ejj.11
        for <linux-acpi@vger.kernel.org>; Wed, 13 Jul 2022 02:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q57qMhZZqPk/BSCGCLflk0fgjBCLtpUl3ALcakqi8Wk=;
        b=naN9yV5imk/liY9VlQCSgcg8TINWK0xOy0aZD5EBmN+uMJyuG6+tUK17RAYx5ZOEPA
         UTMffY4SxZZ8x+z/8+rOt8JGcHug1H5YSSMpiYW81NmgW16ziqA3L9BEl0glBpWuRpnc
         it1nb8JB/JarZtLiqWr3yWuLTnWhAS+uNe3eNezlrDKPYmqucr49npE2YKuyKmHAPyye
         ZZ9aiJDNppky16AAvPvj1o0qIP5fS0TwyW6V+R/Nsg/zoO5tp0CX896ifuZbXKzZ/Ldp
         Z/Ml5JZVYLLMPBPL6+HE4Dss8uC3zkb73tmlDNv7tEAWRfHM26/yH9ICU8Hin92czGfe
         dsjQ==
X-Gm-Message-State: AJIora+GPyfUvoufiRHc6Rv4rAzXlbbOP9z1p5H0yu9NMWh91bZQW/un
        e+I8g14iimhfwoXXj1pwQDPxfpK59u45L4ziGASQN0mMBpiFC0bt9OQLDsC7jxz4tpxaRmYtrUj
        dasZjUgjEGdiK78h8OR9ovg==
X-Received: by 2002:a17:907:75f1:b0:72b:9e40:c1a9 with SMTP id jz17-20020a17090775f100b0072b9e40c1a9mr1629683ejc.523.1657705419150;
        Wed, 13 Jul 2022 02:43:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s+Z5bMAfaWyqx0jGhRjxuupNcy/Zum1Xqp0A98ijLTZqoxpuYIDweA/zoY6C5/oHGoCejAbg==
X-Received: by 2002:a17:907:75f1:b0:72b:9e40:c1a9 with SMTP id jz17-20020a17090775f100b0072b9e40c1a9mr1629670ejc.523.1657705418890;
        Wed, 13 Jul 2022 02:43:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id kv20-20020a17090778d400b0072af6f166c2sm4821546ejc.82.2022.07.13.02.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:43:38 -0700 (PDT)
Message-ID: <02190bee-2e1b-bea3-b716-a7c7f5aa2ff0@redhat.com>
Date:   Wed, 13 Jul 2022 11:43:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Regression] ACPI: video: Change how we determine if brightness
 key-presses are handled
Content-Language: en-US
To:     Ben Greening <bgreening@gmail.com>, stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, rafael@kernel.org,
        linux-acpi@vger.kernel.org
References: <CALF=6jEe5G8+r1Wo0vvz4GjNQQhdkLT5p8uCHn6ZXhg4nsOWow@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CALF=6jEe5G8+r1Wo0vvz4GjNQQhdkLT5p8uCHn6ZXhg4nsOWow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ben,

On 7/13/22 07:27, Ben Greening wrote:
> (resending because of HTML formatting)
> Hi, I'm on Arch Linux and upgraded from kernel 5.18.9.arch1-1 to
> 5.18.10.arch1-1. The brightness keys don't work as well as before.
> Gnome had 20 degrees of brightness, now it's 10, and Xfce went from 10
> to 5. Additionally, on Gnome the brightness keys are a little slow to
> respond and there's a bit of a stutter. Don't know why Xfce doesn't
> stutter, but halving the degrees of brightness for both makes me
> wonder if each press is being counted twice.

Author of the troublesome patch here, sorry that this broke things
for you.

So this sounds like you are getting duplicate key-events reported,
causing the brightness to take 2 steps on each key-press which is
likely also causing the perceived stutter.

This suggests that acpi_video_handles_brightness_key_presses()
was returning true on your system and is now returning false.

Lets confirm this theory, please run either evtest or evemu-record
as root and then record events from the "Video Bus" device and then
press the brightness up/down keys. Press CTRL+C to exit. After this
repeat selecting the "Dell WMI hotkeys" device as input device.

I expect both tests/recordings to show brightness key events with
the troublesome kernel, showing that you are getting duplicate events.

If this is the case then as a workaround you can add:

video.report_key_events=1

to the kernel commandline. This should silence the "Video Bus"
events. Also can you provide the output of:

ls /sys/class/backlight

please?


> Reverting commit 3a0cf7ab8d in acpi_video.c and rebuilding
> 5.18.10.arch1-1 fixed it.

> The laptop is a Dell Inspiron n4010 and I use "acpi_backlight=video"
> to make the brightness keys work. Please let me know if there's any
> hardware info you need.

Note needing to add a commandline argument like this to get things
to work is something which really should always be reported upstream,
so that we can either adjust our heuristics; or add a quirk for your
laptop-model so that things will just work when another user tries
Linux on the same model.

So while at it lets look into fixing this properly to.

When you do not pass anything on the kernel commandline, what
is then the output of:

ls /sys/class/backlight

And for each directory under there, please cd into the dir
and then (as root) do:

cat max_brightness # this gives you the range of this backlight intf.
echo $some-value > brightness

picking some-value in a range of 0-max_brightness, repeating the
echo with different values (e.g. half-range + max) and see if
the screens brightness changes. Please let me know which directories
under /sys/class/backlight result in working backlight control
and which ones do not.

Also what is the output of "ls /sys/class/backlight" when
"acpi_backlight=video" is present on the kernel commandline ?

Regards,

Hans

