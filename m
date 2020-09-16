Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6D826CC5D
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 22:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgIPUnA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Sep 2020 16:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbgIPRD2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Sep 2020 13:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600275805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KWuNiHJM+3srt9mGCXZA/purfg1IvgYJY5TmJukU+/g=;
        b=WSkmRC45RpIsaSNIJI8Bmqeeywlq2A1d0QiYcA3MUvhpiR0k4yOIZd6V1vobmKyX6rQK3w
        dFbwpDPuf4tXAWIMjavqhHtbSjqs5SmFxJr4oEB3bjxk2im049n5HWmp4nFz8qnKXFqevd
        yeiYJkWwp/gx4PUoNw01DaQ4+OS6IVg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-myQ6hTmuOUarvXhRa0gIvQ-1; Wed, 16 Sep 2020 11:56:58 -0400
X-MC-Unique: myQ6hTmuOUarvXhRa0gIvQ-1
Received: by mail-ed1-f70.google.com with SMTP id x23so2665029eds.5
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2020 08:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KWuNiHJM+3srt9mGCXZA/purfg1IvgYJY5TmJukU+/g=;
        b=beUvHvctnnE/mozZqg7ZT7h9Oyi7ixpKxPG5tvldukQRKROepUYjfq8GGLnaGzTK59
         Ly1HSbXNs2eiO7rx/LV/k+cWWu1eNQR6wQIPuZK4PFH90grZBNCozlfQsvMDqbuKfB2C
         BwO5PkL+COOJzAeI766zMILW6+dQQ8Rm64Mizmo3KQIp22CE+IvEjWdXFWfjbqKC4FXV
         x6jzDv7NHpmgriYD+TkTNcmnsARMH6uYYICtMbOki0Bw2p+b4C7wJ8TyJAXnWbDzQ1SQ
         PVhNmm/wrtj21grZ12LL55IPIntTNBGWXF4OCHsdSG9jl4mDACWVvSG6yFvpdB21XGFP
         kq0g==
X-Gm-Message-State: AOAM532yONJ7RKOlRcwaVA28fBbuZXaoIEiBWOP1+4FYb13lGEh2KSJm
        2qch+hVUyCDz7EBCS5ufv0uGyzFdhhKdupKV0VHxSaaAAFj9OnnOXBks05grSYHcJdkWrYiXvXQ
        lhK/1RSYJXX0/xJqcirqPNw==
X-Received: by 2002:a50:ab1d:: with SMTP id s29mr29425952edc.246.1600271816053;
        Wed, 16 Sep 2020 08:56:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyx7YenjX1uGYvGmnY0vIA9GEywN5m3HHb4c1OGgPPWq1JNUBtOjo032cN6g7JB4pvYOjG8FQ==
X-Received: by 2002:a50:ab1d:: with SMTP id s29mr29425938edc.246.1600271815838;
        Wed, 16 Sep 2020 08:56:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id nm7sm12974795ejb.70.2020.09.16.08.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 08:56:54 -0700 (PDT)
Subject: Re: [PATCH] i2c: core: Call i2c_acpi_install_space_handler() before
 i2c_acpi_register_devices()
To:     Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Kai Heng Feng <kai.heng.feng@canonical.com>,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20200909103233.58287-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b1c0b39f-8115-5c27-614f-a31a2731111f@redhat.com>
Date:   Wed, 16 Sep 2020 17:56:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909103233.58287-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/9/20 12:32 PM, Hans de Goede wrote:
> Some ACPI i2c-devices _STA method (which is used to detect if the device
> is present) use autodetection code which probes which device is present
> over i2c. This requires the I2C ACPI OpRegion handler to be registered
> before we enumerate i2c-clients under the i2c-adapter.
> 
> This fixes the i2c touchpad on the Lenovo ThinkBook 14-IIL and
> ThinkBook 15 IIL not getting an i2c-client instantiated and thus not
> working.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1842039
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Ping? This fixes a serious problem (non working touchpad on various
laptop models) and is a pretty straight-forward fix.

Arguably it should even go to stable, but I'm not 100% sure about that
because these sorta ACPI enumeration problems can sometimes by
tricky. With that said in this case the fix does seem to be
very straight forward and obviously correct.

Mika, since this deals with the ACPI bits of the i2c-core can
you review this one please?

Regards,

Hans


> ---
>   drivers/i2c/i2c-core-base.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 5ec082e2039d..573b5da145d1 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1464,8 +1464,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>   
>   	/* create pre-declared device nodes */
>   	of_i2c_register_devices(adap);
> -	i2c_acpi_register_devices(adap);
>   	i2c_acpi_install_space_handler(adap);
> +	i2c_acpi_register_devices(adap);
>   
>   	if (adap->nr < __i2c_first_dynamic_bus_num)
>   		i2c_scan_static_board_info(adap);
> 

