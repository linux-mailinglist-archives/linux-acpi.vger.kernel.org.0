Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B425A7A53
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Aug 2022 11:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiHaJh2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Aug 2022 05:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHaJh1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Aug 2022 05:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7D27DF6D
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661938645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XmHggHKK9R7cMs0dV+XOPlsbA0zUWszj+rTlynLPpec=;
        b=QrT8Y+8r8scfDaHuuPBT0Nf+WmtwH1H45TWwpYoU4J8Yj/2gyHjPwIAsCotVcOXc9uMeAy
        TbVaouR9XrRYrYxnYzrCqb+LOM6wqf2MxMHShtyt86iJeabW4/vp5PFQH8zdSaAumpd+j8
        sQUp8GMVs7WgMxpYjxYbyC6rlRBKZQU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-aU8d09T9NMSGmtdghpO99g-1; Wed, 31 Aug 2022 05:37:24 -0400
X-MC-Unique: aU8d09T9NMSGmtdghpO99g-1
Received: by mail-ed1-f72.google.com with SMTP id m15-20020a056402430f00b00448af09b674so3859720edc.13
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 02:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XmHggHKK9R7cMs0dV+XOPlsbA0zUWszj+rTlynLPpec=;
        b=QlXtBPi5eEogIdRcIpU41l7uQ//0m3aDn3cg89rlz9BoeUdAXZfz75TkHz1WxvkRTb
         R/wjb8jiZ3hVdET0sJTNQaOMrQhFwfIaF3BOGTWmuJJ7E3km3W2IGwK3BDeQxWTDwF06
         MQ+fcXWo112puHP6UYDgXqL/pSYnO8Ss0qgra/bC2IdF8qrSHxfivPulGf9uDQNYFPVK
         hLe8Ep9Lk+Z5N9ZwGX9RPNGlBqKjJwXFD9WSMyzubazbGXpJOSVuTXDhx+7vESb54gmW
         yceGrJUgZCAmxEjPGtn3yAM4i1JB171u/hB6I6GOazMgMLa7qcV/4QlKOyDT7tgXqD11
         qNDQ==
X-Gm-Message-State: ACgBeo1xRDjHwO93OrJiHVAmlVO5z1tkQFsXrEBrfT0+Yv1qSf7aBlxW
        YWCkbLeA5vG1Bm+olD1tFniM3EJ15oajkwkiZ/TCsZ7k83VwHzoemgrgF9yf4atNiiohZ/QiBKi
        3GSAw8bVQiJZGZTaSExXRCw==
X-Received: by 2002:a50:ee06:0:b0:449:e6:52f with SMTP id g6-20020a50ee06000000b0044900e6052fmr3044974eds.267.1661938642798;
        Wed, 31 Aug 2022 02:37:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5SRFRrZyrNdqu351EsyuvMQy+tGFxa7OtPF8kZHWGggRv6rAuJux9pcqNAwPBDYCJuhCjc8Q==
X-Received: by 2002:a50:ee06:0:b0:449:e6:52f with SMTP id g6-20020a50ee06000000b0044900e6052fmr3044957eds.267.1661938642553;
        Wed, 31 Aug 2022 02:37:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090627c400b0072f112a6ad2sm6869872ejc.97.2022.08.31.02.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 02:37:22 -0700 (PDT)
Message-ID: <8989df1c-8fa7-be27-c2f0-e528604e474a@redhat.com>
Date:   Wed, 31 Aug 2022 11:37:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/3] ACPI: PMIC: Replace open coded be16_to_cpu()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>
References: <20220830171155.42962-1-andriy.shevchenko@linux.intel.com>
 <20220830171155.42962-2-andriy.shevchenko@linux.intel.com>
 <Yw71GqF5x7u16yom@black.fi.intel.com> <Yw8rPW39Vif4yVAf@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yw8rPW39Vif4yVAf@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/31/22 11:34, Andy Shevchenko wrote:
> On Wed, Aug 31, 2022 at 08:43:54AM +0300, Mika Westerberg wrote:
>> On Tue, Aug 30, 2022 at 08:11:54PM +0300, Andy Shevchenko wrote:
>>> -#define VR_MODE_DISABLED        0
>>> -#define VR_MODE_AUTO            BIT(0)
>>> -#define VR_MODE_NORMAL          BIT(1)
>>> -#define VR_MODE_SWITCH          BIT(2)
>>> -#define VR_MODE_ECO             (BIT(0)|BIT(1))
>>> +#define PMIC_REG_MASK		GENMASK(11, 0)
>>> +
>>> +#define VR_MODE_DISABLED        (0 << 0)
>>> +#define VR_MODE_AUTO            (1 << 0)
>>> +#define VR_MODE_NORMAL          (2 << 0)
>>> +#define VR_MODE_ECO             (3 << 0)
>>> +#define VR_MODE_SWITCH          (4 << 0)
>>
>> IMHO this one is worse than what it was.
> 
> I'm not sure why. Here is obvious wrong use of BIT() macro against
> plain numbers. I can split it into a separate change with an explanation
> of why it's better. But I think it doesn't worth the churn.

FWIW I'm with Andy here, the VR_MODE_ECO clearly is trying
to just say 3, so this is just a plain enum for values 0-4 and
as such should not use the BIT macros.

Regards,

Hans


>> Anyway, that's just a nitpick. The other parts look good,
>>
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Thanks!
> 

