Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518184C2667
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Feb 2022 09:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiBXImW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Feb 2022 03:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiBXImV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Feb 2022 03:42:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A101C3669C
        for <linux-acpi@vger.kernel.org>; Thu, 24 Feb 2022 00:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645692109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7rzV6PMlfh0kMehM1//3l3REbruRJHskxAdx2VyLiJ4=;
        b=FRFiFeT/I39O5GotJDfgaqBu6YBMmFk9hpuzWtAkAOB05I7g3k9JkCwEkDJaixTiX/9mzm
        SHTNm0ow5U2THsT+ksQWEHmVmBAZqYG95kOggDW1xdznE88qdOJyXknTtTAXNYj6dB3cNd
        bxWFEPkz2EGXyaZtINFczuv0yWElUKM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-zmFbtHVSMIiKMQE0j2Ybjg-1; Thu, 24 Feb 2022 03:41:48 -0500
X-MC-Unique: zmFbtHVSMIiKMQE0j2Ybjg-1
Received: by mail-ed1-f70.google.com with SMTP id y13-20020aa7c24d000000b00411925b7829so398771edo.22
        for <linux-acpi@vger.kernel.org>; Thu, 24 Feb 2022 00:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7rzV6PMlfh0kMehM1//3l3REbruRJHskxAdx2VyLiJ4=;
        b=UudJcH3RHlazd4qs//Fd5cwjPt6PMl2scYvSFipi2FWazxI3RN1oWhrrSrvxsTLZTW
         kI3L+Elz7dPyRLhD8BLqqih9OQXMe2T6OBdPpzHKRJhtSGbcpLLsBNk0AMSLefNI+8fN
         6OveRsjt2YvPJoAyTFQqyrMo3gtNDa60Edhs0hn1RhbQcZ90SUtnYJdpn1f/nzLuNymF
         /YreH147AkG3zSyLXHsaNroEP9d+UKqr+NJf42tCCwDVxiU5tPEU6JoSsdSQZ3en7q5A
         hubSgJossO9QHrbCFpgo5f6BcZVc8FZPjxL9f0t0mn3yNup+QIoXL3qqM+fx/83NdTGk
         w5Wg==
X-Gm-Message-State: AOAM533cPvZpSfH7UOeTF5U1ONidH7eZwL+sCSeZPEp3A+cu1T3ezisL
        YZSx41aWhoGiOrWGqjl2Lo58ksm4tvQc4THMgygLxD84f3veSEGTEG4ptPMOsxVnlvx/2U3TuIv
        IOeikNM/7J3h7+KdpSWE2Cw==
X-Received: by 2002:a05:6402:2709:b0:413:1871:3bc7 with SMTP id y9-20020a056402270900b0041318713bc7mr1273935edd.71.1645692107308;
        Thu, 24 Feb 2022 00:41:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2ZnEJ7WLgoVt692c1UYQI/8lrGcjAT66YxdAlZI5uwMqd9g0R+sHv+Ya1lMpUKZsLcmGnIA==
X-Received: by 2002:a05:6402:2709:b0:413:1871:3bc7 with SMTP id y9-20020a056402270900b0041318713bc7mr1273924edd.71.1645692107101;
        Thu, 24 Feb 2022 00:41:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id j20sm934530edt.67.2022.02.24.00.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 00:41:46 -0800 (PST)
Message-ID: <303dc74a-4d63-70a2-9891-af3e3d8baf26@redhat.com>
Date:   Thu, 24 Feb 2022 09:41:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] x86/acpi: Work around broken XSDT on SEGA AALE board
Content-Language: en-US
To:     Mark Cilissen <mark@yotsuba.nl>, linux-acpi@vger.kernel.org,
        x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220223160708.88100-1-mark@yotsuba.nl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220223160708.88100-1-mark@yotsuba.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mark,

On 2/23/22 17:07, Mark Cilissen wrote:
> On this board the ACPI RSDP structure points to both a RSDT and an XSDT,
> but the XSDT points to a truncated FADT. This causes all sorts of trouble
> and usually a complete failure to boot after the following error occurs:
> 
>   ACPI Error: Unsupported address space: 0x20 (*/hwregs-*)
>   ACPI Error: AE_SUPPORT, Unable to initialize fixed events (*/evevent-*)
>   ACPI: Unable to start ACPI Interpreter
> 
> This leaves the ACPI implementation in such a broken state that subsequent
> kernel subsystem initialisations go wrong, resulting in among others
> mismapped PCI memory, SATA and USB enumeration failures, and freezes.
> 
> As this is an older embedded platform that will likely never see any BIOS
> updates to address this issue and its default shipping OS only complies to
> ACPI 1.0, work around this by forcing `acpi=rsdt`. This patch, applied on
> top of Linux 5.10.102, was confirmed on real hardware to fix the issue.
> 
> Signed-off-by: Mark Cilissen <mark@yotsuba.nl>
> Cc: stable@vger.kernel.org

Wow, you got it working, cool!

The patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> ---
>  arch/x86/kernel/acpi/boot.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 5b6d1a95776f..7caf4da075cd 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1328,6 +1328,17 @@ static int __init disable_acpi_pci(const struct dmi_system_id *d)
>  	return 0;
>  }
>  
> +static int __init disable_acpi_xsdt(const struct dmi_system_id *d)
> +{
> +	if (!acpi_force) {
> +		pr_notice("%s detected: force use of acpi=rsdt\n", d->ident);
> +		acpi_gbl_do_not_use_xsdt = TRUE;
> +	} else {
> +		pr_notice("Warning: DMI blacklist says broken, but acpi XSDT forced\n");
> +	}
> +	return 0;
> +}
> +
>  static int __init dmi_disable_acpi(const struct dmi_system_id *d)
>  {
>  	if (!acpi_force) {
> @@ -1451,6 +1462,20 @@ static const struct dmi_system_id acpi_dmi_table[] __initconst = {
>  		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
>  		     },
>  	 },
> +	/*
> +	 * Boxes that need ACPI XSDT use disabled due to corrupted tables
> +	 */
> +	{
> +	 .callback = disable_acpi_xsdt,
> +	 .ident = "SEGA AALE",
> +	 .matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board"),
> +		     DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
> +		     DMI_MATCH(DMI_BIOS_VERSION, "V1.12"),
> +		     DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
> +		     },
> +	},
>  	{}
>  };
>  
> 
> base-commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507

