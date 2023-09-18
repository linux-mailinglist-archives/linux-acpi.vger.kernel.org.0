Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D83D7A423A
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Sep 2023 09:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjIRHYq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Sep 2023 03:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240202AbjIRHYo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Sep 2023 03:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5936311C
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 00:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695021836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0X6nPXSE7/E4A2/k0Un11UGzVNET9zDINiZ1CDm6B3I=;
        b=bM4RKwcFMLcgHiYrhz+BlClos4rcSbJUVRS/xsRnMmPzER7jCGyoR43G3jTO59qkunVQH/
        rmm5/8bes5T1j/QyzbVzhY3EQP13mRyfubw/pxd1xDpSplmlO7uOHteZTO1Ve2t4LU8/XB
        2t5Nr0auGcEBlB5bAMTUqmqKFROYi0w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-01nNZ8ohOlyfTTvBbJSjqw-1; Mon, 18 Sep 2023 03:23:54 -0400
X-MC-Unique: 01nNZ8ohOlyfTTvBbJSjqw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-320004980a2so1140898f8f.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 00:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695021833; x=1695626633;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0X6nPXSE7/E4A2/k0Un11UGzVNET9zDINiZ1CDm6B3I=;
        b=hlSF2IoTODEdzHIu7nQ7baa6du5kx25T3a27W+eVR3Y9VZTqZWrVQDyGClHzQ25azT
         1A2FfkPxFzi0c8R0hZrnMPm3nKT1K0Had+VfnwEQxsFTDG+waBL6vZ2ulJmOhMATVYIy
         29OOkxalyrzNH/q91XPrS+6fAzeazbMo7NRokH3ve5HryQ1teuI5NMevYLbau5li2Q/a
         KD0VnCERwr+fQ64IJqq8qBg0H57wcsfUnEH3NGPf4TMYA22vdjmYFyrlUi+FdlAcbui7
         2Ddu75JW7kNINNfz93of4XkqCmLY46PANfssVMI/cKvmc2DhKgDMqtmS+ayxHAYF4ECr
         T5tA==
X-Gm-Message-State: AOJu0Yxw3Zvfd0QlnH4ATqpnrSWi1/Ns0/9ICJNrqVLzJHW6Nr258nGk
        ZpN6bnHb9FdLKCpxXd6Aem5sKsIS5ArxycmZxnmLT2c5B0Meqz1PGI3wwaNU/DTmRiTsDsfY6Hw
        FR/AvGFYHf4Hw+xhAHWBGJA==
X-Received: by 2002:a05:6000:1f14:b0:320:93a:6273 with SMTP id bv20-20020a0560001f1400b00320093a6273mr3892320wrb.49.1695021832883;
        Mon, 18 Sep 2023 00:23:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIyCgcmFGegFagb9F0fyM3I9eD4NSBhk7L/MYBNHEWKeTUb+wBLOpIUnInAQZtY2UKF9U56g==
X-Received: by 2002:a05:6000:1f14:b0:320:93a:6273 with SMTP id bv20-20020a0560001f1400b00320093a6273mr3892289wrb.49.1695021832512;
        Mon, 18 Sep 2023 00:23:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee? (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de. [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
        by smtp.gmail.com with ESMTPSA id ba13-20020a0560001c0d00b0031ddf6cc89csm8905269wrb.98.2023.09.18.00.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 00:23:52 -0700 (PDT)
Message-ID: <887344ee-068d-f78f-d5f8-e816b966d875@redhat.com>
Date:   Mon, 18 Sep 2023 09:23:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 3/9] Documentation/scrub-configure.rst: Add
 documentation for scrub driver
To:     shiju.jose@huawei.com, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, naoya.horiguchi@nec.com,
        tony.luck@intel.com, james.morse@arm.com,
        dave.hansen@linux.intel.com, jiaqiyan@google.com,
        jthoughton@google.com, somasundaram.a@hpe.com,
        erdemaktas@google.com, pgonda@google.com, rientjes@google.com,
        duenwen@google.com, Vilas.Sridharan@amd.com,
        mike.malvestuto@intel.com, gthelen@google.com, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        prime.zeng@hisilicon.com
References: <20230915172818.761-1-shiju.jose@huawei.com>
 <20230915172818.761-4-shiju.jose@huawei.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230915172818.761-4-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 15.09.23 19:28, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add documentation for scrub driver, supports configure scrub parameters,
> in Documentation/scrub-configure.rst
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>   Documentation/scrub-configure.rst | 55 +++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
>   create mode 100644 Documentation/scrub-configure.rst
> 
> diff --git a/Documentation/scrub-configure.rst b/Documentation/scrub-configure.rst
> new file mode 100644
> index 000000000000..9f8581b88788
> --- /dev/null
> +++ b/Documentation/scrub-configure.rst
> @@ -0,0 +1,55 @@
> +==========================
> +Scrub subsystem driver
> +==========================
> +
> +Copyright (c) 2023 HiSilicon Limited.
> +
> +:Author:   Shiju Jose <shiju.jose@huawei.com>
> +:License:  The GNU Free Documentation License, Version 1.2
> +          (dual licensed under the GPL v2)
> +:Original Reviewers:
> +
> +- Written for: 6.7
> +- Updated for:
> +
> +Introduction
> +------------
> +The scrub subsystem driver provides the interface for configure the

"... interface for configuring memory scrubbers in the system."

are we only configuring firmware/hw-based memory scrubbing? I assume so.

> +parameters of memory scrubbers in the system. The scrub device drivers
> +in the system register with the scrub configure subsystem.

Maybe say a few words what memory scrubbing is, and what it is used for.

> +
> +The scrub configure driver exposes the scrub controls to the user
> +via sysfs.
> +
> +The File System
> +---------------
> +
> +The configuration parameters of the registered scrubbers could be
> +accessed via the /sys/class/scrub/scrubX/regionN/
> +
> +sysfs
> +-----
> +
> +Sysfs files are documented in
> +`Documentation/ABI/testing/sysfs-class-scrub-configure`.
> +
> +Example
> +-------
> +
> +  The usage takes the form shown in this example::
> +
> +    # echo 0x300000 > /sys/class/scrub/scrub0/region0/addr_base
> +    # echo 0x100000 > /sys/class/scrub/scrub0/region0/addr_size
> +    # cat /sys/class/scrub/scrub0/region0/speed_available
> +    # 1-60
> +    # echo 25 > /sys/class/scrub/scrub0/region0/speed
> +    # echo 1 > /sys/class/scrub/scrub0/region0/enable
> +
> +    # cat /sys/class/scrub/scrub0/region0/speed
> +    # 0x19

Is it reasonable to return the speed as hex? You set it as dec.

> +    # cat /sys/class/scrub/scrub0/region0/addr_base
> +    # 0x100000

But didn't we set it to 0x300000 ...

> +    # cat /sys/class/scrub/scrub0/region0/addr_size
> +    # 0x200000

... and didn't we set it to 0x100000 ?

Or what's the magic happening here?

> +
> +    # echo 0 > /sys/class/scrub/scrub0/region0/enable

-- 
Cheers,

David / dhildenb

