Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766C64C895E
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Mar 2022 11:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiCAKf7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Mar 2022 05:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiCAKf6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2022 05:35:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 244495677B
        for <linux-acpi@vger.kernel.org>; Tue,  1 Mar 2022 02:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646130916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t5+CqQycvyRYkX2L7ftAW8XFXfOSyd5vBfPXO20RDoY=;
        b=JzvNfasuQnudUHUQUBul74oDM64iASFuCQQAdxn1RCkBfLLZFX9Z64sWuvQtmk+WtJYGH8
        E0oNeMU8ePSy+FW7WSjNEjuZ8djBCsU1K1iQW0qHvK7SxB2GsSQhuKcSlRy5WUxlg9JVor
        IcIANTPTWk7hyL8Wx4iJbU5aOLyMGl0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-fEc7DcCeOXiXp0wfXZe1rQ-1; Tue, 01 Mar 2022 05:35:14 -0500
X-MC-Unique: fEc7DcCeOXiXp0wfXZe1rQ-1
Received: by mail-ed1-f70.google.com with SMTP id u28-20020a50d51c000000b004159ffb8f24so70364edi.4
        for <linux-acpi@vger.kernel.org>; Tue, 01 Mar 2022 02:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t5+CqQycvyRYkX2L7ftAW8XFXfOSyd5vBfPXO20RDoY=;
        b=GMv25F2SQn8SZxLRETUvJYfsbNxYWWZzq7sOiUjMpysb9CNGjtg1F5G1tGHJmLlW5l
         puPiVM3bgtc6J0lUt5zZInYneKmBZ6wVf56cTw9QYVL2hVh8S+JdXV5FFsGe0TyPDPxF
         VNQYxyv0tVaEfFxeVqu/zW/S0ALgRJDjRO5M+r0LoPOzjdSXgolBS6LMUHBZivhD/+eu
         huHicopT0mXdbvqQWGz/7vFdbh2FY350gtIOds+DbDu3H2MRfbcXtUj3fDpL+FHsFM8u
         097wOjIF0aJBnSi2OJkClrdmmvNwG4cjDoKMihCa0CwYUMPD+OYf/tiZSbfec19PM6se
         xeAA==
X-Gm-Message-State: AOAM532o3cbRfcoXtVkSjo0/++FOgX5quDcGeo/equWkaClqIbB2BVYm
        W0HNoojHnh0yoA7LtLj8SaE8YK9Twu07Hn0ddm39nB48l9ml9h/g5vv5CAvN2Gy/VgZNEqeafo5
        7xhZ5QIRihdef9lp4EdxG/g==
X-Received: by 2002:a17:906:ae0c:b0:6a6:a09f:f8d5 with SMTP id le12-20020a170906ae0c00b006a6a09ff8d5mr18681297ejb.627.1646130913702;
        Tue, 01 Mar 2022 02:35:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAdPmzF4amKRWFY4CqbK9+TaLQceHPa3pbwSa4/lapqks5H4m/k0c1vhA7PaCgkd0Nsmupyg==
X-Received: by 2002:a17:906:ae0c:b0:6a6:a09f:f8d5 with SMTP id le12-20020a170906ae0c00b006a6a09ff8d5mr18681286ejb.627.1646130913507;
        Tue, 01 Mar 2022 02:35:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id da23-20020a056402177700b0041394d8173csm4911547edb.31.2022.03.01.02.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 02:35:13 -0800 (PST)
Message-ID: <e9bfc654-5504-29ff-5a5a-b73f24691600@redhat.com>
Date:   Tue, 1 Mar 2022 11:35:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-acpi@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220228183355.9090-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/28/22 19:33, Jason A. Donenfeld wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> We create a list of ACPI "PNP" IDs which contains _HID, _CID, and CLS
> entries of the respective devices. However, when making structs for
> matching, we squeeze those IDs into acpi_device_id, which only has 9
> bytes space to store the identifier. The subsystem actually captures the
> full length of the IDs, and the modalias has the full length, but this
> struct we use for matching is limited. It originally had 16 bytes, but
> was changed to only have 9 in 6543becf26ff ("mod/file2alias: make
> modalias generation safe for cross compiling"), presumably on the theory
> that it would match the ACPI spec so it didn't matter.
> 
> Unfortunately, while most people adhere to the ACPI specs, Microsoft
> decided that its VM Generation Counter device [1] should only be
> identifiable by _CID with a value of "VM_Gen_Counter", which is longer
> than 9 characters.
> 
> To allow device drivers to match identifiers that exceed the 9 byte
> limit, this simply ups the length to 16, just like it was before the
> aforementioned commit. Empirical testing indicates that this
> doesn't actually increase vmlinux size on 64-bit, because the ulong in
> the same struct caused there to be 7 bytes of padding anyway, and when
> doing a s/M/Y/g i386_defconfig build, the bzImage only increased by
> 0.0055%, so negligible.
> 
> This patch is a prerequisite to add support for VMGenID in Linux, the
> subsequent patch in this series. It has been confirmed to also work on
> the udev/modalias side in userspace.
> 
> [1] https://download.microsoft.com/download/3/1/C/31CFC307-98CA-4CA5-914C-D9772691E214/VirtualMachineGenerationID.docx
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Co-authored-by: Jason A. Donenfeld <Jason@zx2c4.com>
> [Jason: reworked commit message a bit, went with len=16 approach.]
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

The need for this is a bit meh, but I have no objections against
solving it this way:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> Hi Rafael,
> 
> This patch is directed toward you specifically. The first and last patch
> of the series this is part of have been through the ringer of review a
> bit already and do not specifically require your attention, but we wound
> up getting hung up on an ACPI ID matching API limitation. This patch
> fixes that limitation with this patch that you see here, with a trivial
> one line fix, which does require your attention.
> 
> The other patches will go through my random.git tree naturally, but
> because those patches depend on this one here, in order to compile
> without warnings (and be functional at all), it would be nice if you
> would provide an "Acked-by" on it and permit me to /also/ take it
> through my random.git tree (if it looks like a correct patch to you, of
> course). This would make the merge logistics a lot easier. Plus it's a
> small +1/-1 line change.
> 
> This v6 updates the commit message.
> 
> Please have a look and let me know what you think.
> 
> Thanks,
> Jason
> 
>  include/linux/mod_devicetable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 4bb71979a8fd..5da5d990ff58 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -211,7 +211,7 @@ struct css_device_id {
>  	kernel_ulong_t driver_data;
>  };
>  
> -#define ACPI_ID_LEN	9
> +#define ACPI_ID_LEN	16
>  
>  struct acpi_device_id {
>  	__u8 id[ACPI_ID_LEN];

