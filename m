Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94EC7A57F1
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Sep 2023 05:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjISDkP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Sep 2023 23:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjISDkP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Sep 2023 23:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F66B112
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 20:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695094762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBvJUlyaw2bkgeQrcu2quBogD5BtM2KTe/dcbAYZ1+c=;
        b=biKZMDUP6D7oCRRNxyr7grv1Kuiq4ETuoYZbcZTnUrkiksyWaZX/b45TPhHx93f07/nOvn
        HOmTjOPR4IF4RZ3LInCIOmwmtrn7YGgjciongD7lp6gRvHWoQG5MSxawMQOpGaZ200h7tf
        ha73mHbYNksgp8rykAeEBy6oqypLvos=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-yaddyEIfMG2VFIzldo-TAw-1; Mon, 18 Sep 2023 23:39:18 -0400
X-MC-Unique: yaddyEIfMG2VFIzldo-TAw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c44a2cbea0so20428765ad.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 20:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695094758; x=1695699558;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBvJUlyaw2bkgeQrcu2quBogD5BtM2KTe/dcbAYZ1+c=;
        b=p/3YaRVqGlvhSKlbwyrIiolNtfMUjJ+t58uY6f6D24Ja6TCOXgNC3XMcH0HoTqCXck
         Hd4RQbZcnz3I9AhDQRRmKbi6gDaYwPWPngGzZCCFgoGzdV+N8Wy5chhcEjOPcI/B5jKI
         JqIZkmn2eOjpqvn4yLh5bpfIR/8KQy6RCWP9cROKazqSgVTwty6qzKRQi0Yg4eGVHHKN
         HdERxFCOh5hNuVgG+t6qeiRS0bOVULQQubvStBaoLvmVQrhiZHS1EeoHSOwgI0R7R49w
         TtPPI6zjpyor0grLMuCcHZ1dA5B7xu05ch2mRkbBE3TtYTgWKi0D81H6lT84YkGDAhvP
         o4OA==
X-Gm-Message-State: AOJu0YzuyyeLWjcYlH2Udd5lPTGUvCwdkb5RU+R4NkSqk7QLUbyxcYVj
        x/hPfUA6PQopXe6i8uT6+fViTL77W2c+BxX+5pmOwUQyMfD3NBRZEahl6/SE+C97tpnsj9HKeou
        9SM8FrWXcp0OohgurkovJQg==
X-Received: by 2002:a17:902:ecca:b0:1c3:432f:9f69 with SMTP id a10-20020a170902ecca00b001c3432f9f69mr2008954plh.23.1695094757879;
        Mon, 18 Sep 2023 20:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaoSZiSFZ7Dx5QmHpQ853bVS36OFRusCjmGB2jt3hklfrALFF9t8rRDnMvZC9r997ICNVz6g==
X-Received: by 2002:a17:902:ecca:b0:1c3:432f:9f69 with SMTP id a10-20020a170902ecca00b001c3432f9f69mr2008930plh.23.1695094757591;
        Mon, 18 Sep 2023 20:39:17 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902e9d400b001c567dcf22dsm2846570plk.281.2023.09.18.20.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 20:39:16 -0700 (PDT)
Message-ID: <31fa3aa7-c12c-3eb7-e9d2-5967a735ac78@redhat.com>
Date:   Tue, 19 Sep 2023 13:39:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 29/35] irqchip/gic-v3: Don't return errors from
 gic_acpi_match_gicc()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-30-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-30-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 9/14/23 02:38, James Morse wrote:
> gic_acpi_match_gicc() is only called via gic_acpi_count_gicr_regions().
> It should only count the number of enabled redistributors, but it
> also tries to sanity check the GICC entry, currently returning an
> error if the Enabled bit is set, but the gicr_base_address is zero.
> 
> Adding support for the online-capable bit to the sanity check
> complicates it, for no benefit. The existing check implicitly
> depends on gic_acpi_count_gicr_regions() previous failing to find
> any GICR regions (as it is valid to have gicr_base_address of zero if
> the redistributors are described via a GICR entry).
> 
> Instead of complicating the check, remove it. Failures that happen
> at this point cause the irqchip not to register, meaning no irqs
> can be requested. The kernel grinds to a panic() pretty quickly.
> 
> Without the check, MADT tables that exhibit this problem are still
> caught by gic_populate_rdist(), which helpfully also prints what
> went wrong:
> | CPU4: mpidr 100 has no re-distributor!
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/irqchip/irq-gic-v3.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 

With below nits resolved:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 72d3cdebdad1..0f54811262eb 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -2415,21 +2415,15 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
>   
>   	/*
>   	 * If GICC is enabled and has valid gicr base address, then it means
> -	 * GICR base is presented via GICC
> +	 * GICR base is presented via GICC. The redistributor is only known to
> +	 * be accessible if the GICC is marked as enabled. If this bit is not
> +	 * set, we'd need to add the redistributor at runtime, which isn't
> +	 * supported.
>   	 */
> -	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
> +	if (gicc->flags & ACPI_MADT_ENABLED && gicc->gicr_base_address)
>   		acpi_data.enabled_rdists++;
> -		return 0;
> -	}
>   

	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
	

> -	/*
> -	 * It's perfectly valid firmware can pass disabled GICC entry, driver
> -	 * should not treat as errors, skip the entry instead of probe fail.
> -	 */
> -	if (!acpi_gicc_is_usable(gicc))
> -		return 0;
> -
> -	return -ENODEV;
> +	return 0;
>   }
>   
>   static int __init gic_acpi_count_gicr_regions(void)

Thanks,
Gavin

