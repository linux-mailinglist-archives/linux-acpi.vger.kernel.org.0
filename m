Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970B35A7525
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Aug 2022 06:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiHaEZZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Aug 2022 00:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiHaEZX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Aug 2022 00:25:23 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C19C2CC91
        for <linux-acpi@vger.kernel.org>; Tue, 30 Aug 2022 21:25:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id by6so13373238ljb.11
        for <linux-acpi@vger.kernel.org>; Tue, 30 Aug 2022 21:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2/84/Nh2RhkEyirPhb0dLLfmJLiDgXr/8IIxfqEETHY=;
        b=l8loCtVpq8dHknjal7vbA+tRfWKPpK/i473LraJOTLK78Br7+eD2EUoxHy1fZGwyWk
         HBfbmNOMSyzryRPnkmTlfJkhkBYh0DEQj5gH2OfqB1JG/cFzAe2wy2Bem1OjZJnhb1V0
         WAnFnxfyE4a5CeDeTCA4lSmaodNBNmQyTlZdi7/FC805McY88ir62+dXyampyVcOnzoa
         Tqt0xV2OxDUMjnu8YO+pjZJnp5+6LXTCiy2peZFeXfqGdanGSPDHgijv4h2DSnCXUEmi
         g/dk4R8N5U5bbyBqHWPIrTtbNtMEzDfhv+Fu5qm4cSF8Rfb5JWn5vrz5CnUurE1NjU/X
         fcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2/84/Nh2RhkEyirPhb0dLLfmJLiDgXr/8IIxfqEETHY=;
        b=ENmKDBsA1qOYrnlAQ55OLBz82ZTH0SSR9AEJS/4TWw2D609dZTSh2tU0PWdZYK2JoZ
         W3up4XqQcADR18MWGQk/YMTMbsuNx29c7GovVe3oAPhYpW4H9KBypBGksCtWFCTwuTCr
         JMXUBdKQP48q1q6u8s6DcSlR3YCYM969whJnCdHM/tTmVRe/UJ9lnnek3R2aQIIm6Qdi
         OjFX3sRD6KmjRjsZ5XdlVMMrsqVAsCigYj0lseZ4tgUw7W/9VJv9kiucuK9NNgTdreUR
         mDjhsKo87GF+Em7/o3XECB8c2cw1Od+GKndWkJzpjgMAGvz1mD/6l9IS4NHrGZ1kntH/
         C3ow==
X-Gm-Message-State: ACgBeo1FrNTqZz491pjFyLPCBTgQ4FBj9ZPX8+wpb0Bb8mSl9AFDWR/D
        5xFS875Nf6kKWTTiiY5kMbF4Pg==
X-Google-Smtp-Source: AA6agR5FXtXMTMhfYUHF89tazxkaOtUvoMdkpjxOJUyUaibRWpW2IyKUiTyZdyTIl/80wOMgVV+wAQ==
X-Received: by 2002:a2e:9012:0:b0:267:e7ce:3d0a with SMTP id h18-20020a2e9012000000b00267e7ce3d0amr1388164ljg.83.1661919918867;
        Tue, 30 Aug 2022 21:25:18 -0700 (PDT)
Received: from [192.168.0.199] (89-71-83-146.dynamic.chello.pl. [89.71.83.146])
        by smtp.gmail.com with ESMTPSA id t13-20020a056512208d00b0049476261c30sm604583lfr.113.2022.08.30.21.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 21:25:18 -0700 (PDT)
Message-ID: <7ec74091-8b19-2ec6-dd94-1297395b8589@semihalf.com>
Date:   Wed, 31 Aug 2022 06:25:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ACPICA: Synchronize disabling wake mask and servicing
 wake-up IRQ
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, upstream@semihalf.com
References: <1cf5ec82-0f1e-3bc7-4367-dcba1ee0f64d@semihalf.com>
 <CAJZ5v0gHMO42xiKsN5+QRM0FBN=Z1NfEQFCTzRWdwGuOmd+PZg@mail.gmail.com>
 <85fa3a0c-cee9-3aaa-cd41-7d4ca9d90235@semihalf.com>
 <CAJZ5v0jcxnWt14RL0Cpj_LWdATUH2yMV9cu5uphV=DeOg0oayQ@mail.gmail.com>
From:   =?UTF-8?Q?Marek_Ma=c5=9blanka?= <mm@semihalf.com>
In-Reply-To: <CAJZ5v0jcxnWt14RL0Cpj_LWdATUH2yMV9cu5uphV=DeOg0oayQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 30.08.2022 13:18, Rafael J. Wysocki wrote:
> On Tue, Aug 30, 2022 at 8:14 AM Marek Maślanka <mm@semihalf.com> wrote:
>>
>> On 29.08.2022 16:12, Rafael J. Wysocki wrote:
>>> On Mon, Aug 29, 2022 at 12:21 PM Marek Maślanka <mm@semihalf.com> wrote:
>>>>
>>>> The GPE interrupts that are the wake-up source are "turned off" by clear
>>>> the “enable_for_wake” flag when the kernel resumes (suspend_enter() ->
>>>> acpi_s2idle_restore() -> acpi_disable_wakeup_devices() ->
>>>> acpi_set_gpe_wake_mask()). On the resume path the kernel also resumes
>>>> the interrupts (suspend_enter() -> dpm_resume_noirq() -> resume_irqs())
>>>> which process the GPE interrupt that woke-up the kernel (... ->
>>>> acpi_irq() -> acpi_ev_sci_xrupt_handler() -> acpi_ev_gpe_detect() -> …).
>>>> The GPE interrupt routine stops in the acpi_ev_gpe_detect () function
>>>> when the "enable_for_wake" flag is cleared.
>>>>
>>>> As the interrupt servicing might work simultaneously on SMP, it’s
>>>> possible that the “enable_for_wake” flag can be cleared before the GPE
>>>> interrupt gets chances to be processed. It might happen when the CPU
>>>> processed other IRQ before the GPE IRQ that woke up the device.
>>>>
>>>> This issue is seen on low-end Chromebooks with two cores CPU when HPET
>>>> IRQ is triggered while resuming the device and is processed before the
>>>> ACPI GPE interrupt on the same CPU core.
>>>>
>>>> Before clear the enable_for_wake flag we need to make sure that the
>>>> specific wake-up GPE IRQ block was processed.
>>>>
>>>> Signed-off-by: Marek Maslanka <mm@semihalf.com>
>>>
>>> First off, if you want to modify ACPICA code, the way to do that is
>>> via the upstream ACPICA project on GitHub.
>>>
>>> Second, I'm not sure what the problem is.
>>>
>>> Yes, acpi_ev_gpe_detect() will bail out early when none of the GPEs in
>>> the given block is enabled either for wake or for run, but since the
>>> system has been woken up already and the GPE is now disabled, it will
>>> not trigger again until enabled next time.
>>>
>>> Is the problem that the GPE will signal wakeup spuriously on the next
>>> suspend or is it something else?
>>
>> In my cases the problem is the GPE STS flag that cannot be cleared
>> (acpi_ev_gpe_detect() -> acpi_ev_detect_gpe() -> acpi_ev_gpe_dispatch()
>> -> acpi_hw_clear_gpe()). If the status bit is not cleared before the
>> next suspend, the device will not wake up.
> 
> Interesting.
> 
> Have you considered modifying acpi_set_gpe_wake_mask() to clear the
> GPE status after clearing the bit in the enable_for_wake mask if the
> corresponding bit in enable_for_run is also unset?

Clearing the GPE status after clearing the bit in enable_for_wake in
the acpi_set_gpe_wake_mask() solve my issue. But keep in mind it
doesn't solve the root cause. The GPE handlers are not invoked which
could have other disadvantages.
