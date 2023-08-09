Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D1677563E
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 11:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjHIJU2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 05:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjHIJU1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 05:20:27 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698A01FDE;
        Wed,  9 Aug 2023 02:20:26 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so1466512a12.1;
        Wed, 09 Aug 2023 02:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691572825; x=1692177625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQaLc2nrPpBthIHL1xHv2ULZnA/x9m4F2lf1Bl4ddVk=;
        b=DIZj0pcEdmMR3rLmx0FhuKp6g6fln8mU+z/sSnFK/j1JkwuTxXlpPEeGUSeWz3H826
         yuFSazC96OJR2mkTymVU175hR/+gXNRUqRn6OMITy4qTqh6My2oyX27LI6iwLuT17Gjo
         hR1shGoDWN5/3Bkzp4+HrYn9/RK0NmaxL97tX4fKFd74oWgYjZiYiZBD0NQDEqMT2epv
         XFIapg8LxjXjoE7FOGzH4gq22BM6/s7tlSUCI6ZkEJVRlUFei3qwx6MMie/qjQUy+85w
         azYWEFThqfvtZmeyfSx4SZatvi+23zueBw24x7rAxKs+ak31n1imYrewPV/8yL+W+EKE
         liKQ==
X-Gm-Message-State: AOJu0YxS6ulCeT2Oyyw32jj5ehtCkQyFJk8IzeVVG5GQmL9IEStDzERx
        k4S6plvv2vkYT8+EVwCtr08=
X-Google-Smtp-Source: AGHT+IHQymkVmf03FNeB5DWxGpGXvjqZuIUhesQ/SgWXPwpMAiEFq1X/yV4zd/M3vybssHCsoJw0Bw==
X-Received: by 2002:aa7:df09:0:b0:523:2e23:a0bf with SMTP id c9-20020aa7df09000000b005232e23a0bfmr2599976edy.11.1691572824686;
        Wed, 09 Aug 2023 02:20:24 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id e23-20020a056402089700b00521d2f7459fsm7681092edy.49.2023.08.09.02.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 02:20:24 -0700 (PDT)
Message-ID: <f133d401-1975-6c85-47c5-f9464d5ef06f@kernel.org>
Date:   Wed, 9 Aug 2023 11:20:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 3/3] ACPI: resource: Honor MADT INT_SRC_OVR settings
 for IRQ1 on AMD Zen
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        August Wikerfors <git@augustwikerfors.se>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
References: <20230809085526.84913-1-hdegoede@redhat.com>
 <20230809085526.84913-4-hdegoede@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230809085526.84913-4-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 09. 08. 23, 10:55, Hans de Goede wrote:
> On AMD Zen acpi_dev_irq_override() by default prefers the DSDT IRQ 1
> settings over the MADT settings.
> 
> This causes the keyboard to malfunction on some laptop models
> (see Links), all models from the Links have an INT_SRC_OVR MADT entry
> for IRQ 1.
...
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
...
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 21b542a6866c..b88e5e0135ab 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -52,6 +52,7 @@ int acpi_lapic;
>   int acpi_ioapic;
>   int acpi_strict;
>   int acpi_disable_cmcff;
> +int acpi_int_src_ovr[NR_IRQS_LEGACY];

So why not to use bool to make it clear this is not an irq number, but a 
state?

>   
>   /* ACPI SCI override configuration */
>   u8 acpi_sci_flags __initdata;
> @@ -588,6 +589,9 @@ acpi_parse_int_src_ovr(union acpi_subtable_headers * header,
>   
>   	acpi_table_print_madt_entry(&header->common);
>   
> +	if (intsrc->source_irq < NR_IRQS_LEGACY)
> +		acpi_int_src_ovr[intsrc->source_irq] = 1;

And "true" here.

thanks,
-- 
js
suse labs

