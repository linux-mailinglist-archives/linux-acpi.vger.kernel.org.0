Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD645290731
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 16:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408851AbgJPOa7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 10:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408850AbgJPOa6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Oct 2020 10:30:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ABAC0613D3
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2020 07:30:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t25so3430890ejd.13
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2020 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HxZxC2xN4lzCm1BeKzVFW4hqh8G5tGG2Mf0vSEc67QE=;
        b=WolBLivptc2j3q5VW+rzCLNqYgcLsymVLZSXbYA1W9eKZbIb3fs+vYIVZKVzrlXQf2
         3XBj2deyz3BslJy1VLkuU/yTfRtuxeQVMEXCP097u7RlUEnvDJjpaTxlz/nX2SV4aKys
         /wUDhrxNrXNw2BF//sJRZaUQ65q/qLYZzdW+YHPGAkfvwTvhFFNnRtDLuNdffv4A7sH6
         Xm2IKs+/o76ozGd0jQglT920M0xcczuEdLNpg8y/17x1H9oiLjrgrDP9cuV83jc/xcNR
         t514WqznkHf5ef/k0yplz4mEFNb0JEm8GUV3QwUd2e3/9kxREoW//9Ye4IcTPsR38XIo
         rGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HxZxC2xN4lzCm1BeKzVFW4hqh8G5tGG2Mf0vSEc67QE=;
        b=BznIFibtdQMd+JJvdOG+BtJgYb2AqHyXmnJBGDQvUKdzwLASm68TVr5fbZ9kIXWaEn
         WKMj74SnSqtEmiISTKmCql+q3uKp1DJQJt7oblFNApul+IlpIMwMX83BqHKzd44BKuPK
         04qTnjwVDupEETGpttmhvZL/KfaqQcGR4uQ6DO64/lfDLC4kRj31N+vTS/1D6CMSziqB
         q3soJldOxm1mxMTZf8yBTYo5WQvRziBTOP0sIBFmQtbjNJYS9Xy7wvOzojRWlgFig+F1
         BJtCFSPBqakbTKzvaxdp+g50iH4ZcwNNw/m/IR9amtCSUuCussbDONvnjVcfZgyQt0hd
         koPg==
X-Gm-Message-State: AOAM533rTsl5b2kHsaygIT9DRAOIuq61foProlqIRoCejtRp/tqpmSMQ
        FXVjaoPCZU+vsHAxoKm35qSWTg==
X-Google-Smtp-Source: ABdhPJx2V+HcSA1WIXgjnYCYGn0asCept/3SyeD2e6uDLYsJfAay4Eg3WPyRsyoYMBqdVJQbyl6EVA==
X-Received: by 2002:a17:906:ae48:: with SMTP id lf8mr3973233ejb.345.1602858656797;
        Fri, 16 Oct 2020 07:30:56 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:62bb:2bf7:e8cf:a48e])
        by smtp.gmail.com with ESMTPSA id e13sm1637007edc.9.2020.10.16.07.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 07:30:56 -0700 (PDT)
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
References: <1748021.N9i9sLPJ40@kreacher> <9373262.piL2bvXoCD@kreacher>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH 4/6] ACPICA: Add support for using logical addresses of
 GPE blocks
Message-ID: <3b69e0d0-fb8a-92b4-42fd-f2a8fcdd642b@tessares.net>
Date:   Fri, 16 Oct 2020 16:30:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <9373262.piL2bvXoCD@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 04/09/2020 19:24, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The logical address of every GPE block in system memory must be
> known before passing it to acpi_ev_initialize_gpe_block(), because
> memory cannot be mapped on the fly from an interrupt handler.
> Accordingly, the host OS must map every GPE block in system
> memory upfront and it can store the logical addresses of GPE
> blocks for future use.

(...)

> diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
> index a0e71f34c77a..37bb67ef3232 100644
> --- a/drivers/acpi/acpica/hwgpe.c
> +++ b/drivers/acpi/acpica/hwgpe.c
> @@ -46,8 +46,13 @@ acpi_status acpi_hw_gpe_read(u64 *value, struct acpi_gpe_address *reg)
>   	u32 value32;
>   
>   	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +#ifdef ACPI_GPE_USE_LOGICAL_ADDRESSES
> +		*value = (u64)ACPI_GET8(reg->address);

Thank you for the patch!

When compiling net-next repo, recently sync with Linus repo, I got an 
error when using i386 arch because of this line above.

Here are the commands I used:


================================================
$ make defconfig KBUILD_DEFCONFIG=i386_defconfig
*** Default configuration is based on 'i386_defconfig'
#
# configuration written to .config
#
$ scripts/config --disable DRM --disable PCCARD --disable ATA --disable 
MD --disable PPS --disable SOUND --disable USB --disable IOMMU_SUPPORT 
--disable INPUT_LEDS --disable AGP --disable VGA_ARB --disable EFI 
--disable WLAN --disable WIRELESS --disable LOGO --disable NFS_FS 
--disable XFRM_USER --disable INET6_AH --disable INET6_ESP --disable 
NETDEVICES -e KUNIT -d KUNIT_DEBUGFS -d KUNIT_TEST -d KUNIT_EXAMPLE_TEST 
-d EXT4_KUNIT_TESTS -d SYSCTL_KUNIT_TEST -d LIST_KUNIT_TEST -d 
LINEAR_RANGES_TEST -d BITS_TEST -d KUNIT_ALL_TESTS -e INET_DIAG -d 
INET_UDP_DIAG -d INET_RAW_DIAG -d INET_DIAG_DESTROY -e MPTCP -e 
MPTCP_IPV6 -e MPTCP_KUNIT_TESTS
$ KCFLAGS=-Werror make -j8 -l8
scripts/kconfig/conf  --syncconfig Kconfig
(...)
   CC      drivers/acpi/acpica/hwgpe.o
In file included from ./include/acpi/acpi.h:24,
                  from drivers/acpi/acpica/hwgpe.c:10:
drivers/acpi/acpica/hwgpe.c: In function 'acpi_hw_gpe_read':
./include/acpi/actypes.h:501:48: error: cast to pointer from integer of 
different size [-Werror=int-to-pointer-cast]
   501 | #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) 
(p))
       |                                                ^
drivers/acpi/acpica/acmacros.h:18:41: note: in expansion of macro 
'ACPI_CAST_PTR'
    18 | #define ACPI_CAST8(ptr)                 ACPI_CAST_PTR (u8, (ptr))
       |                                         ^~~~~~~~~~~~~
drivers/acpi/acpica/acmacros.h:22:43: note: in expansion of macro 
'ACPI_CAST8'
    22 | #define ACPI_GET8(ptr)                  (*ACPI_CAST8 (ptr))
       |                                           ^~~~~~~~~~
drivers/acpi/acpica/hwgpe.c:50:17: note: in expansion of macro 'ACPI_GET8'
    50 |   *value = (u64)ACPI_GET8(reg->address);
       |                 ^~~~~~~~~
drivers/acpi/acpica/hwgpe.c: In function 'acpi_hw_gpe_write':
./include/acpi/actypes.h:501:48: error: cast to pointer from integer of 
different size [-Werror=int-to-pointer-cast]
   501 | #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) 
(p))
       |                                                ^
drivers/acpi/acpica/acmacros.h:18:41: note: in expansion of macro 
'ACPI_CAST_PTR'
    18 | #define ACPI_CAST8(ptr)                 ACPI_CAST_PTR (u8, (ptr))
       |                                         ^~~~~~~~~~~~~
drivers/acpi/acpica/acmacros.h:26:43: note: in expansion of macro 
'ACPI_CAST8'
    26 | #define ACPI_SET8(ptr, val)             (*ACPI_CAST8 (ptr) = 
(u8) (val))
       |                                           ^~~~~~~~~~
drivers/acpi/acpica/hwgpe.c:85:3: note: in expansion of macro 'ACPI_SET8'
    85 |   ACPI_SET8(reg->address, value);
       |   ^~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [scripts/Makefile.build:283: drivers/acpi/acpica/hwgpe.o] 
Error 1
make[2]: *** [scripts/Makefile.build:500: drivers/acpi/acpica] Error 2
make[1]: *** [scripts/Makefile.build:500: drivers/acpi] Error 2
make: *** [Makefile:1777: drivers] Error 2
================================================


> +		return_ACPI_STATUS(AE_OK);
> +#else
>   		return acpi_os_read_memory((acpi_physical_address)reg->address,
>   					    value, ACPI_GPE_REGISTER_WIDTH);
> +#endif
>   	}
>   
>   	status = acpi_os_read_port((acpi_io_address)reg->address,
> @@ -76,8 +81,13 @@ acpi_status acpi_hw_gpe_read(u64 *value, struct acpi_gpe_address *reg)
>   acpi_status acpi_hw_gpe_write(u64 value, struct acpi_gpe_address *reg)
>   {
>   	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +#ifdef ACPI_GPE_USE_LOGICAL_ADDRESSES
> +		ACPI_SET8(reg->address, value);

(and also because of this line)

By chance, do you already have a fix for that? I didn't see any other 
email related to this issue, I am surprised no bot already reported the 
problem but maybe I didn't look everywhere :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
