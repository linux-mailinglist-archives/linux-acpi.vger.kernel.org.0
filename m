Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA524CF2D1
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Mar 2022 08:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiCGHqH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Mar 2022 02:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiCGHqG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Mar 2022 02:46:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F27824BFB
        for <linux-acpi@vger.kernel.org>; Sun,  6 Mar 2022 23:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646639112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NifscFrnEl450cF6R79qgacbuDR21aDOyM2/R6oYISs=;
        b=fRyd21bZXIs+0rt1bIgFqeXA9zTk/HSHcFyOTDsUUAeYFMjpNjahvKEwfES0vbM03ot7+a
        ljkiaUDC842vroJoRsXHJDVxVMeBYA1AgtiQ6oxz3Kd7Z3b3mykWC/0ZloYojoVqa/9WJ+
        ZcDlyLUtJCuVsC01PZSjHOhg0vJEtys=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-KH4f5wJ0OO-uV0SdpcBPqQ-1; Mon, 07 Mar 2022 02:45:11 -0500
X-MC-Unique: KH4f5wJ0OO-uV0SdpcBPqQ-1
Received: by mail-ed1-f70.google.com with SMTP id r8-20020aa7d588000000b00416438ed9a2so1659605edq.11
        for <linux-acpi@vger.kernel.org>; Sun, 06 Mar 2022 23:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NifscFrnEl450cF6R79qgacbuDR21aDOyM2/R6oYISs=;
        b=v7DEnQGxlyxmXgmxaWJR/8Cfl+6x7kbDYPh5oe2j5H1+151t0I02WFCz3KBK2Ea2JN
         tTmwahecf3tBm9po7SbddSqlX6ogQWT2iINrwfS/qJtdm81qWM37CcqhjJ4DEfJtg8Ah
         g2/mgdFAAk8k5uRv46sbQL7HyX3V7XBQQetOxTqiaCvW/zy37hfMHE+J62VnyVVOyojA
         77f9MnmuAS5t/OUCeb+wBCTn9LtUYST/p3ts0jP6uh1AU/CaCD9RoeoodX0wkvQ5YlI0
         VijAck3dEnwZeXGSkNxmc1ILnOSW3wlJedlVP4HgoeBS4UqIKJUm8BObZJZ2RXK5dt/u
         CqTg==
X-Gm-Message-State: AOAM531d4lM3t3Y4Io+ApxyR75pZRG2n6EnuWxSZv+hPsf2P6ND26/GW
        NVCKkJnwWMV5vJ4sV9iAiNc+r1HAmvTL4CeLfueToSBeNFG74UF/hYsGkxNXoLLwk2q7xsTgki6
        g9JyL27K1xePWRFskAKCTpg==
X-Received: by 2002:a50:bac5:0:b0:416:4651:7782 with SMTP id x63-20020a50bac5000000b0041646517782mr3788354ede.219.1646639109851;
        Sun, 06 Mar 2022 23:45:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgfgKmFkq/vChb0vrEYNVBwocMMMJaNK7CTdVHlgcGjQ0BypLfhDaEpPBIyvBzlFSBmVFHnw==
X-Received: by 2002:a50:bac5:0:b0:416:4651:7782 with SMTP id x63-20020a50bac5000000b0041646517782mr3788340ede.219.1646639109699;
        Sun, 06 Mar 2022 23:45:09 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id k18-20020a50ce52000000b0040f75ad0e60sm5947345edj.83.2022.03.06.23.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 23:45:09 -0800 (PST)
Message-ID: <b7d06540-6ecc-f12a-4c1f-64d174c2f693@redhat.com>
Date:   Mon, 7 Mar 2022 08:45:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3] ACPI / x86: Work around broken XSDT on Advantech
 DAC-BJ01 board
Content-Language: en-US
To:     Mark Cilissen <mark@yotsuba.nl>, linux-acpi@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kernel test robot <lkp@intel.com>
References: <20220307031658.81285-1-mark@yotsuba.nl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220307031658.81285-1-mark@yotsuba.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/7/22 04:16, Mark Cilissen wrote:
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
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks, the new version looks good to me.

Regards,

Hans

> ---
> v3:
> - Change DMI matching criteria as per Hans's suggestion
> 
> v2:
> - Reduce DMI match count to 4 to not overflow dmi_system_id structure
> Reported-by: kernel test robot <lkp@intel.com>
> - Change board ident to correct name
> - Fix small style issue
> - Fix up subject as per Rafael's changes
> ---
>  arch/x86/kernel/acpi/boot.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 5b6d1a95776f..0d01e7f5078c 100644
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
> @@ -1451,6 +1462,19 @@ static const struct dmi_system_id acpi_dmi_table[] __initconst = {
>  		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
>  		     },
>  	 },
> +	/*
> +	 * Boxes that need ACPI XSDT use disabled due to corrupted tables
> +	 */
> +	{
> +	 .callback = disable_acpi_xsdt,
> +	 .ident = "Advantech DAC-BJ01",
> +	 .matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board"),
> +		     DMI_MATCH(DMI_BIOS_VERSION, "V1.12"),
> +		     DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
> +		     },
> +	 },
>  	{}
>  };
>  
> 
> base-commit: 038101e6b2cd5c55f888f85db42ea2ad3aecb4b6

