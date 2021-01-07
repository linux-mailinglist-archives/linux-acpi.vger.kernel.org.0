Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9482ED0F0
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbhAGNkl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGNkl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:40:41 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC205C0612F4;
        Thu,  7 Jan 2021 05:40:00 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n7so4867735pgg.2;
        Thu, 07 Jan 2021 05:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oHAKwH9vSA8AdCN9U8+YV/5eT7vno7k7DP5s7UpkfBg=;
        b=ILYsePsM8H1Vk3NA2Rgig07+0vr1Bf45DH7Yeifbhij3qlF3BkhC9x9pYjc+9VszqK
         Lq82wjwebEOBpNHoGGfgoyT4xrpbp1+xOvMW9dRos6xT/iArW024RRANP9QJXyasLoW3
         BmELKZMNl3erkAnM6A412pCyWPGWL7KwB0/4M55fHSEp759spG9k8veZoDKxqE/b9+PD
         n4y9aWjKuAHOpdyIXXlHnxutUu2WFHfA7oSL90LtSk9FYSvaDxdaYmBlIPkoSAZny1QX
         pSKQAeCp98/lffvD5KNxrv6lSqsOx4/Tz1XMEIR1NJ1kTGlyshM4VmM9r+PJd8lETT57
         vEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oHAKwH9vSA8AdCN9U8+YV/5eT7vno7k7DP5s7UpkfBg=;
        b=CdrpYWdVnAdi/X+Bq0hHDYknUrH1UVBlX9en0bazRhy4ppgJQXsvwO9C28n8D8WT67
         y3mHQxogUeB/sGLriJG00jFhlbLVDvXnEsbW2/n+do2txkMKljVC6ex7Fj0XTZUGHnDS
         EiLwalO00atlyzaBflo4jvzzyoPkoGLW3k1QH3vYk67IDPKwGZIvVw+PYmGTM2aXfJgF
         +vWcIETaCpIlgYp8oP4A74Z+iVPxqL5sFjLFSP7n88LDqi8wIhkAdylKOqAMAghvHeDl
         ThjZZWZ2texGO46KfCKF0UdR7Skm16PmldkQYeaH1tzJiKgyWp0ysNIKgM5aCg1Tu6I5
         RNHQ==
X-Gm-Message-State: AOAM53025HmwGbNxEmCWQF1PhfZppsaeCOVcLjlyKKs9xgpneXciC1Dw
        c20jliy5ErlKmDZN0MngSkyqUAAwSqkCWxX+ngU=
X-Google-Smtp-Source: ABdhPJxr5GBvI9d4Rl13Q2/4ALtozP4g+ar2orhQaIxenfn8W+wOKNW86jhecoPUNJ7f8Fgn3Znkqw==
X-Received: by 2002:a05:6a00:8c7:b029:19d:afa5:34e5 with SMTP id s7-20020a056a0008c7b029019dafa534e5mr9076108pfu.30.1610026800319;
        Thu, 07 Jan 2021 05:40:00 -0800 (PST)
Received: from ?IPv6:2405:201:9004:69cd:a39f:75ee:d9e7:25d7? ([2405:201:9004:69cd:a39f:75ee:d9e7:25d7])
        by smtp.gmail.com with ESMTPSA id a1sm5733114pfo.56.2021.01.07.05.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 05:39:59 -0800 (PST)
Subject: Re: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by buffer
 overflow
To:     decui@microsoft.com, linux-acpi@vger.kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, wei.liu@kernel.org,
        sthemmin@microsoft.com, haiyangz@microsoft.com, kys@microsoft.com
References: <20201218040826.57203-1-decui@microsoft.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Message-ID: <42a039e8-d31e-9f17-bfe6-6a50968688db@gmail.com>
Date:   Thu, 7 Jan 2021 19:09:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201218040826.57203-1-decui@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 18/12/20 9:38 am, Dexuan Cui wrote:
> Linux VM on Hyper-V crashes with the latest mainline:
>
> [    4.069624] detected buffer overflow in strcpy
> [    4.077733] kernel BUG at lib/string.c:1149!
> ..
> [    4.085819] RIP: 0010:fortify_panic+0xf/0x11
> ...
> [    4.085819] Call Trace:
> [    4.085819]  acpi_device_add.cold.15+0xf2/0xfb
> [    4.085819]  acpi_add_single_object+0x2a6/0x690
> [    4.085819]  acpi_bus_check_add+0xc6/0x280
> [    4.085819]  acpi_ns_walk_namespace+0xda/0x1aa
> [    4.085819]  acpi_walk_namespace+0x9a/0xc2
> [    4.085819]  acpi_bus_scan+0x78/0x90
> [    4.085819]  acpi_scan_init+0xfa/0x248
> [    4.085819]  acpi_init+0x2c1/0x321
> [    4.085819]  do_one_initcall+0x44/0x1d0
> [    4.085819]  kernel_init_freeable+0x1ab/0x1f4
>
> This is because of the recent buffer overflow detection in the
> commit 6a39e62abbaf ("lib: string.h: detect intra-object overflow in fortified string functions")
>
> Here acpi_device_bus_id->bus_id can only hold 14 characters, while the
> the acpi_device_hid(device) returns a 22-char string
> "HYPER_V_GEN_COUNTER_V1".
>
> Per ACPI Spec v6.2, Section 6.1.5 _HID (Hardware ID), if the ID is a
> string, it must be of the form AAA#### or NNNN####, i.e. 7 chars or 8
> chars.
>
> The field bus_id in struct acpi_device_bus_id was originally defined as
> char bus_id[9], and later was enlarged to char bus_id[15] in 2007 in the
> commit bb0958544f3c ("ACPI: use more understandable bus_id for ACPI devices")
>
> It looks like so far an ID string of >=15 chars is only seen in the guest
> BIOS/firmware by Hyper-V, and AFAIK the ID string "HYPER_V_GEN_COUNTER_V1"
> is never used by Linux VM on Hyper-V, so let's just truncate the string to
> fix the panic.
>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>   drivers/acpi/scan.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a1b226eb2ce2..b801442b6b1b 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -674,7 +674,8 @@ int acpi_device_add(struct acpi_device *device,
>   	}
>   	if (!found) {
>   		acpi_device_bus_id = new_bus_id;
> -		strcpy(acpi_device_bus_id->bus_id, acpi_device_hid(device));
> +		strlcpy(acpi_device_bus_id->bus_id, acpi_device_hid(device),
> +			sizeof(acpi_device_bus_id->bus_id));

Please prefer strscpy() over strlcpy():

+		strscpy(acpi_device_bus_id->bus_id, acpi_device_hid(device),
+			sizeof(acpi_device_bus_id->bus_id));

See: 
https://lore.kernel.org/lkml/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/

Thanks,
Dwaipayan.

>   		acpi_device_bus_id->instance_no = 0;
>   		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
>   	}
