Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4886766E7D5
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 21:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjAQUjj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 15:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjAQUfp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 15:35:45 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8057241F7
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2023 11:21:00 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q130so2397646iod.4
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2023 11:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fqyWeWuyc2jRA+5UQYAEtNEii+X4xnVBaHeZrCTvJ0E=;
        b=WOZiCO0nwdx0/J8RBZ6fUPgASslwTEHjMpdR/SRXtTppO1orXLf+wGpPFAGLkaYr1x
         OXLmo4L7yLAGA/t16oMCARlsfHU9udsdYYFEWSEPfBAu2jAAhX/3BmhFlbT03H3ElQ3f
         z2YeV4v8PshtbvM8VhbsyOBdNp/0iFw2tBVfXD0fS955lXZ6AhUOb/t8S3KjJWmIcAyz
         dWAdwJQro88EBSHB+tSQQqs6DWMWmYU7UFfyEC/EA4d7GdhjRYyjryeAfKTjoJZb+igk
         JIvT4TOCREnVJp7LIXkVZP/mU8LOw0s/VbrPvNgHeayr12eYVspqEVx5/+zbgbNXXPhq
         PVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqyWeWuyc2jRA+5UQYAEtNEii+X4xnVBaHeZrCTvJ0E=;
        b=ZK/P47R0r830+pPrkLx27wTE2v8xaYf+5CW4yT7PMwFRTZVGoTZ+LF2u4BxDGvJeYn
         KDwCLf++0bdaqLMAttfE8aeB8ga8arpJhkx/M317Mahmc/KOX4xpU8mDRuL39+PvxUsi
         vIaVqrUGBSCtZiMHlHJd9JjhLHkdbDP9AChCbOORb6nYIWhLVtR6SlEClrvpWZO2axDd
         wtZvhq6cyrtlSJ03mUs5eetRG3QPGzUKv0VrmObUwt7KwRs5nDiGa1h4UXjS5S5ZXzNK
         V9lL0xy8MM44jZTuR++gZyT7Rgk/e/BBguX0QdLtR781tSWeDbf2BgHJlAXfplfxIJTN
         WQtw==
X-Gm-Message-State: AFqh2koDiJ7Ze0kScQGJu7TyLYh+BjdKNf6i4Co0+4fjSDU5RTmLECeF
        sngXMacNy3HyWg9opMNDtE23bQ==
X-Google-Smtp-Source: AMrXdXuk5GmCedTTwYstxz043kwWiO1txPjdUTef03V7SzkRyplINEz+OO3rRduwblja8AQXWLIq1w==
X-Received: by 2002:a6b:14c2:0:b0:6eb:68a1:78c with SMTP id 185-20020a6b14c2000000b006eb68a1078cmr3273688iou.10.1673983260051;
        Tue, 17 Jan 2023 11:21:00 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id e10-20020a026d4a000000b0038ac4923addsm9518035jaf.53.2023.01.17.11.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 11:20:59 -0800 (PST)
Message-ID: <b2819f68-8672-4909-c787-d1bdbd35da2e@linaro.org>
Date:   Tue, 17 Jan 2023 13:20:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v8 05/28] virt: gunyah: Add hypercalls to identify Gunyah
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-6-quic_eberman@quicinc.com>
 <63bbc640-9b0c-95af-3d35-291da0323db3@linaro.org>
 <4e8a7fdf-8c91-cf2f-d369-c67b7584f580@quicinc.com>
Content-Language: en-US
In-Reply-To: <4e8a7fdf-8c91-cf2f-d369-c67b7584f580@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 1/10/23 11:56 AM, Elliot Berman wrote:
>>> There are two calls to help identify Gunyah:
>>>
>>> 1. gh_hypercall_get_uid() returns a UID when running under a Gunyah
>>>     hypervisor.
>>> 2. gh_hypercall_hyp_identify() returns build information and a set of
>>>     feature flags that are supported by Gunyah.
>>
>> The first is a "service", while the second is a "hypercall".
>> Can you explain the distinction?  The sentence at the top
>> refers to both as "hypercalls".
>>
> 
> I learned more details about this to answer your question. "get_uid()" 
> is a standardized call that is ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID 
> defined in include/arm-smccc.h. I'll use that.

You didn't really explain the distinction between hypercall
and service in Gunyah.  Both are encoded as "vendor specific
hypervisor service calls" according to the SVCCC specification.
I haven't found where ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID
gets handled, but I accept your answer that it's basically
a standard call.  The "get UID" is the only one that's defined
as a Gunyah "service"; the rest are hypercalls.

It's not a big deal, I just noticed the difference and was
curious about it.

					-Alex
