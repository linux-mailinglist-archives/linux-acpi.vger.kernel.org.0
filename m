Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AB85E5E23
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Sep 2022 11:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIVJHy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Sep 2022 05:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIVJHx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Sep 2022 05:07:53 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B32B2D84;
        Thu, 22 Sep 2022 02:07:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n15so7519288wrq.5;
        Thu, 22 Sep 2022 02:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Lc01pxS7q+WM84eQOKwpZ8GVMsKlTCdoSl+t7XzNmmA=;
        b=RbCTv5XR3WIp8uuxZy8X0WTBJElmTPLj5L5QJmxOCHDabvdrlXs0sZa26Y+2OCB/wM
         bkOg32k2FZj2N/k2Wg8w0r0vDoiYaEmrJvRBVNpxLhg13qmf3FWQnMbMhhcPfj5+G7Nx
         TWRKcxJg/IwCBlGplgpuv1oB/8q51BDLxFs78dz2i0Y1W1DSh5Xbj9vSnIXGUJnDRNh5
         ojEl2iUweK26IpBbxSWMKz5BPW7nqBCPCyium3x2l38nPNhuDqgIGlHtYA1I4hcEdcr8
         WZh22qz6qJI+delKO/1XGK7VL1s1FcnV9qdF2Qaorh1JfRpERBJLrKrD9NdFZwP2a89e
         nWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Lc01pxS7q+WM84eQOKwpZ8GVMsKlTCdoSl+t7XzNmmA=;
        b=Z/9WJOarNO7UPfKhMXd/oGgGdEGrVCF0QgvEnevfRDSk8yuYRAEqPQql+yJ3tPdoW7
         BX7GqNzlOt8u1W14HqihY0o8QGGz2lF64kXjwzY4BiU9zQtSN+ygTsfpCK1W1OIbSznn
         ajmAze9fHSKOSyOfARiroTHY3FMHN0J83CDHyNLbbPv7GuOUoHqwoI45JoL7G06LfOot
         Xx3ZEnZclJniG3TtH2L4BwSiNEnXLepp389UDEIOKP+++3KCUiC9VPtzzWdADkt32r3c
         lhPaj9frQzp02iFlCfu1ZeyxerKFpsPHzEve+fLeZufByb1BU6y7DODTRLgntOboHh7D
         8Szw==
X-Gm-Message-State: ACrzQf2SpR0uVmjSnw6tDZecDp69Leie3j89hdOhTnGKWlGWFQ2hvQ4Y
        o3XELy/962DGzzfUFxktE90=
X-Google-Smtp-Source: AMsMyM6OhNsqdus/6gIXZZ90j8IUVPI+vlRImvqXvVN8jLCpqVhqHuHGufAEh6OUdXIKk4kuSzYqKw==
X-Received: by 2002:a05:6000:178e:b0:22b:451:9f63 with SMTP id e14-20020a056000178e00b0022b04519f63mr1265576wrg.521.1663837670107;
        Thu, 22 Sep 2022 02:07:50 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6106000000b002286231f479sm4582265wrt.50.2022.09.22.02.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 02:07:49 -0700 (PDT)
Message-ID: <fda85ff3-8b52-288b-bb37-630decd51d4e@gmail.com>
Date:   Thu, 22 Sep 2022 10:07:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/5] Add multiple-consumer support to int3472-tps68470
 driver
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, markgross@kernel.org, robert.moore@intel.com
References: <20220921230439.768185-1-djrscally@gmail.com>
 <b3855fe0-4b85-a442-1835-3e62456b3206@redhat.com>
From:   Daniel Scally <djrscally@gmail.com>
In-Reply-To: <b3855fe0-4b85-a442-1835-3e62456b3206@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans

On 22/09/2022 09:55, Hans de Goede wrote:
> Hi All,
>
> On 9/22/22 01:04, Daniel Scally wrote:
>> Hello all
>>
>> At the moment there are a few places in the int3472-tps68470 driver that are
>> limited to just working with a single consuming device dependent on the PMIC.
>> There are systems where multiple camera sensors share a single TPS68470, so
>> we need to extend the driver to support them. This requires a couple of tweaks
>> to the ACPI functions to fetch dependent devices, which also assumes that only
>> a single dependent will be found.
>>
>> The v2 for this series was some time ago...it's kept falling to the back of my
>> to-do list so I've only just gotten round to it; sorry about that. v2 here:
>>
>> https://lore.kernel.org/linux-acpi/20220327161344.50477-1-djrscally@gmail.com/
> Rafael, I would like to merge this through the pdx86 tree may I have your
> ack for patches 1 + 2 for this. As a reminder (since it has been a while)
> here are your review remarks to v2 of patch 1:
>
> https://lore.kernel.org/platform-driver-x86/CAJZ5v0i2ciLHP-=8eQcZc0v0xCzhKHKpxLC=Kgv6W5E_5=HQJA@mail.gmail.com/
>
> (which both seem to have been addressed)
>
> AFAICT you did not have any remarks for v2 of patch 2.
>
> Regards,
>
> Hans
>
> p.s.
>
> Dan, if I want to give the IR cam a test run on my own Surface Go (version 1)
> I guess I may need a sensor driver? Where can I find that sensor driver and
> what do I need in userspace to test this ?


It's the ov7251 sensor driver - the required changes are in mainline now
actually so you should be good there. The format of the data is a bit
unconventional; it's Y10 but passed through Intel's CIO2 CSI receiver
which packs it into a different format [1]. I'm probably just going to
add support for that format to Howdy [2] which is what people want to
use this camera for, but for now you can just test by using the
ipu3-unpack utility in libcamera [3] to convert back to proper Y10 and
then raw2rgbpnm [4] to turn it into a ppm. I use this script for now:
https://paste.debian.net/1254629. Be warned that unless you are in
sunlight the image is basically just grey - the IR LED on the front of
the surface needs driving to give a clear image otherwise. I have an led
driver for the tps68470 which can do that, I'm just working on getting
it all tied in so it triggers when streaming starts.



[1]
https://www.linuxtv.org/downloads/v4l-dvb-apis-new/userspace-api/v4l/pixfmt-yuv-luma.html

[2] https://github.com/boltgolt/howdy

[3] https://git.libcamera.org/libcamera/libcamera.git/tree/utils/ipu3

[4] https://paste.debian.net/1254629

>
>
>> Daniel Scally (5):
>>   ACPI: scan: Add acpi_dev_get_next_consumer_dev()
>>   ACPI: bus: Add iterator for dependent devices
>>   platform/x86: int3472: Support multiple clock consumers
>>   platform/x86: int3472: Support multiple gpio lookups in board data
>>   platform/x86: int3472: Add board data for Surface Go2 IR camera
>>
>>  drivers/acpi/scan.c                           | 40 +++++++---
>>  drivers/clk/clk-tps68470.c                    | 13 +++-
>>  drivers/platform/x86/intel/int3472/common.c   |  2 +-
>>  drivers/platform/x86/intel/int3472/tps68470.c | 76 ++++++++++++++++---
>>  drivers/platform/x86/intel/int3472/tps68470.h |  3 +-
>>  .../x86/intel/int3472/tps68470_board_data.c   | 54 ++++++++++++-
>>  include/acpi/acpi_bus.h                       | 15 +++-
>>  include/linux/platform_data/tps68470.h        |  7 +-
>>  8 files changed, 177 insertions(+), 33 deletions(-)
>>
