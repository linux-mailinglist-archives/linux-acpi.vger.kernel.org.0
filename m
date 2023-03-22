Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7669D6C447A
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Mar 2023 08:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCVH4R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Mar 2023 03:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCVH4Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Mar 2023 03:56:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259A65BDA9
        for <linux-acpi@vger.kernel.org>; Wed, 22 Mar 2023 00:56:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so5963759wmq.3
        for <linux-acpi@vger.kernel.org>; Wed, 22 Mar 2023 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679471772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qYcPhJZyzoqPCml7TLicrRGfQxWTf1OJdmestWf5Yk=;
        b=Zd3bO64PJM2rGxrRGL7eASKdPdFEkyUYDMOdkRkcZy8htZxWgq3UqGCh7/khKdTWZZ
         4Cs2l6Az1UYgvga4eVdq+gZ9EYwmZvndHlm/MKbxbqu5m3Q0zfZUCU7CyIyl6giuBzNY
         /TiqudrZ14PoKvHhvc/mN5pBntVna9v3b/dzvhKayM4wjIjieato3kqbMzlUitQx9N5H
         rOGxSCukwJ3Rp9pf3rYzFvLkAg7/bX42L39+hF9veHnWi9iqj8ggXa2njYvFMRxAOEaR
         J1fkfWmj4Ep4UmQq3oYzNd0rgtr7bLvBLlU21SBv/TJLwRAjEq3MnfWGyuV/o8+HXHPV
         LeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679471772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qYcPhJZyzoqPCml7TLicrRGfQxWTf1OJdmestWf5Yk=;
        b=H3dlFmufz5PJgEgrP+V71WPYQ1JokFT/H3VkatQdUzxRXTitBi/MDrKTRpctyfkFs4
         VGdpWHcYSOMbcrJJQC6fg9ax10UXhlqGqgjJpQm+pAdzgYir485H2q+NGO4rQ1wqQvFS
         PQMPME03Adm46eXDbH98GiktqzI/ZQ9l8dBg2n6c0CQqS9JB5D6/hvfKgyQEvf9vuEVk
         k5l/OXk3XLOzq+07DaBaBDR2HAy4YOgWUo3RTIRvj1eyUAfaVcYKpa49JNb+W2yQ0Icg
         yzm5AgTBcPJkv6rbxuP6S58knNL1hXn1pxabV01NTjBzWTOPbPTrnZ3C85AF5HPfdBfa
         d8/g==
X-Gm-Message-State: AO0yUKW209H5jN3lXy/rq/9Mto6gP5RVtX0vsMVKPetIQabzAzhYBHZQ
        Schb5MxMQiPd7LoFHdzbIofzZg==
X-Google-Smtp-Source: AK7set/Jz2cYuoJ3tWJz6ScrVA2mcSoquD9CXkDac7AG14AT4P3rqBittub07VwHMcS1yWWgtwANbw==
X-Received: by 2002:a05:600c:2312:b0:3df:e6bb:768 with SMTP id 18-20020a05600c231200b003dfe6bb0768mr4705226wmo.24.1679471772523;
        Wed, 22 Mar 2023 00:56:12 -0700 (PDT)
Received: from [192.168.1.166] ([90.243.20.231])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc40e000000b003ee0d191539sm6965060wmi.10.2023.03.22.00.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:56:12 -0700 (PDT)
Message-ID: <6e90881b-ba24-7f5a-e80d-1ae7fc9d9382@linaro.org>
Date:   Wed, 22 Mar 2023 07:56:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [RFC v1 1/1] Refactor ACPI DMA to support platforms without
 shared info descriptor in CSRT
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     mika.westerberg@linux.intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-acpi@vger.kernel.org,
        Sudeep.Holla@arm.com, Souvik.Chakravarty@arm.com,
        Sunny.Wang@arm.com, lorenzo.pieralisi@linaro.org,
        bob.zhang@cixtech.com, fugang.duan@cixtech.com
References: <20230321160241.1339538-1-niyas.sait@linaro.org>
 <ZBnvHSmHVvgsumlM@smile.fi.intel.com>
From:   Niyas Sait <niyas.sait@linaro.org>
In-Reply-To: <ZBnvHSmHVvgsumlM@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21/03/2023 17:53, Andy Shevchenko wrote:

> can_we_avoid_long_name_of_the_functions_please() ?

Sure, will do that.

> Also is this renaming is a must?

It is not a must. I considered the existing method with shared info
as a special case as it uses non standard descriptors from CSRT table
and introduced the new function to handle it.

> Btw, what is the real argument of not using this table?
> 
> Yes, I know that this is an MS extension, but why ARM needs something else and
> why even that is needed at all? CSRT is only for the _shared_ DMA resources
> and I think most of the IPs nowadays are using private DMA engines (or
> semi-private when driver based on ID can know which channel services which
> device).

The issue is that shared info descriptor is not part of CSRT definition 
[1] and I think it is not standardized or documented anywhere.

I was specifically looking at NXP I.MX8MP platform and the DMA lines for 
devices are specified using FixedDMA resource descriptor. I think other 
Arm platforms like RPi have similar requirement.

[1] https://uefi.org/sites/default/files/resources/CSRT%20v2.pdf

-- 
Niyas
