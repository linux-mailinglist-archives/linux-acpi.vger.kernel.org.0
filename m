Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244B64CBEFB
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Mar 2022 14:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiCCNj0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Mar 2022 08:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCCNj0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2022 08:39:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF38514893E
        for <linux-acpi@vger.kernel.org>; Thu,  3 Mar 2022 05:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646314719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kV1jPhpxz/H+Y6fQr0IfoEf/5nAIxaNBpjXk9EuheDE=;
        b=ell5QSZilbrWEIlOloG5aaBSVkQFsc0gpsKAfyh9+s/rgOsQ6ly+C+SyP1vb/2byY+yvYy
        wv79e3vmZIPmxZwORI3qp6NA4rq2k9XWMj757TgBBAgOuXa0jg0Rv7Ad8AtrThH1+A0DY/
        0R76TGXJP89ibKkdWHQRhsXjzDevLfE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-r7UHg-bgP96a3fqq_g106w-1; Thu, 03 Mar 2022 08:38:38 -0500
X-MC-Unique: r7UHg-bgP96a3fqq_g106w-1
Received: by mail-ej1-f71.google.com with SMTP id d7-20020a1709061f4700b006bbf73a7becso2741134ejk.17
        for <linux-acpi@vger.kernel.org>; Thu, 03 Mar 2022 05:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kV1jPhpxz/H+Y6fQr0IfoEf/5nAIxaNBpjXk9EuheDE=;
        b=izYqx8jlwJxVq/Iw6F356QmEP5ufOhVGqCD7Tinxm1B4JMtX96NrPYQzcGY9sf6d0E
         N8SznGbvd2embytZp1Y6gdfIJB958naK8c1gVETO555Xvf3Ue5y43mf1C8iT83kR4jRp
         nq10RQgqiFcGfjykmJOLsopPvcw85ZxjI3Lou0A6Hkt/xWnV14LCnvJwCG6TQ8DoOV6z
         27owzVjGjvxRsLOU7xuZlTVlRfra9eqiWaftjjGXQ+tuYl5J2sgUpRQVw8PzHeMn4qHo
         AEkTHm31P75bjlkUic9+PZifzdIZ51hYC+rTNf4jcAcitVCNneimEW52tkJifVNLrE+B
         uBhA==
X-Gm-Message-State: AOAM532jqXOpWVOJ3KKBVNnsOsRlZGMACvpI7GCdDcjaw695lNsdGRmy
        tcTVjuIK0O6yPgOTx6Q2hj6EfqL21cZDLAonZW7f8YUnegocVHYXeD35/ZPAJEA3rz3Ksc4Go61
        M/kCA6Ap4c4JqRqsOzxholw==
X-Received: by 2002:aa7:dc0c:0:b0:413:c9ab:381c with SMTP id b12-20020aa7dc0c000000b00413c9ab381cmr17212791edu.275.1646314717811;
        Thu, 03 Mar 2022 05:38:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2IvPU7oGxg9mGP/R4nr8JF4lCyy/f+OG79qmsf/DoCTolNSwqbYOrJAbboAYdKiGrjQpAbQ==
X-Received: by 2002:aa7:dc0c:0:b0:413:c9ab:381c with SMTP id b12-20020aa7dc0c000000b00413c9ab381cmr17212767edu.275.1646314717593;
        Thu, 03 Mar 2022 05:38:37 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id my16-20020a1709065a5000b006d6e1023b7bsm710889ejc.8.2022.03.03.05.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 05:38:37 -0800 (PST)
Message-ID: <43b0c275-e728-492b-c6a7-d054fae72117@redhat.com>
Date:   Thu, 3 Mar 2022 14:38:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] ACPI / x86: Work around broken XSDT on Advantech
 DAC-BJ01 board
Content-Language: en-US
To:     Mark Cilissen <mark@yotsuba.nl>
Cc:     linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kernel test robot <lkp@intel.com>
References: <20220302040800.10355-1-mark@yotsuba.nl>
 <832a5b2e-d70c-f1a6-e377-7697b1eb7049@redhat.com>
 <7BD8A71A-95C7-4A10-82FD-BEAAE0B0DDE9@yotsuba.nl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <7BD8A71A-95C7-4A10-82FD-BEAAE0B0DDE9@yotsuba.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Mark,

On 3/2/22 21:20, Mark Cilissen wrote:
>> On 2 Mar 4 Reiwa, at 10:02, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
> 
> Hi Hans,
> 
>>
>>> […]
>>
>> Heh, I should have noticed this new version before replying. I see that
>> you've dropped the BIOS-date match. But that actually is often more useful
>> then the BIOS_VERSION, sometimes vendors don't bump the version when
>> doing a new BIOS build.
>>
>> If you only want to match the exact BIOS you tested against I would
>> drop the BIOS_VENDOR check instead.
> 
> I am admittedly bit wary of dropping the BIOS_VENDOR check. As the cause of
> this issue seems to be specifically a BIOS compilation error, it feels 
> incomplete to leave this match out.
> 
> Since “CRB” in the DMI product name indicates the board design is derivative
> of a generic Intel reference design (“Customer Reference Board”),
> maybe it’s better to drop the SYS_VENDOR match instead?
> It seems to bear little relation to the actual vendor (Advantech)
> encountered in my testing hardware, anyway.
> 
> Let me know; if you still feel it’s better to drop the BIOS_VENDOR match,
> I will do that instead.

I think that there are a lot more boards that will have
DMI_BIOS_VENDOR == "Phoenix Technologies LTD"
then that there are boards that will have
DMI_PRODUCT_NAME == "Bearlake CRB Board"

So if you want to make the DMI match as specific as possible then
IMHO dropping the bios-vendor match is best.

Regards,

Hans


