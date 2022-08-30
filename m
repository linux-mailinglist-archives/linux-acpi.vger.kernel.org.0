Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F06D5A5B99
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Aug 2022 08:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiH3GOY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Aug 2022 02:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiH3GOY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Aug 2022 02:14:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1205AB8A47
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 23:14:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z25so14132196lfr.2
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 23:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7cMddbY8v0HxN2Rnuz3g9EXMyDXB9ItyJCZmqgsHfNo=;
        b=B0HRgLtM9VCGiz/pFfiGbG1c7vq5K8vVu8flblPJoKxo8cWkYnMkegru/bgL5FF2ax
         s9cAyc5RxcWTQKY1ZwudosYm0svp73M2U0i7afCB4ezHsaxhHRuOFLHdv+w8HOIB8l1k
         dKs78bA/Z49bgi1mQ5QjfYZisiNFmv8L+UX3nFUbhJokRf1rvmC8pZAMGEWYKNRc0qfd
         /3GTkxp8YRCz9a7A5Z5t2XH775EohYGyNBzalGq4DhV93b4uKUeYxgf180mnTAPCufV0
         K5VcUqKXANy5jd5uUf/VcDYNIJsNoKDCsAqBRoRVuf+xkgBV08863A4t8QMJ3W1/T0XI
         CwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7cMddbY8v0HxN2Rnuz3g9EXMyDXB9ItyJCZmqgsHfNo=;
        b=DLZsTU2xtJ4kFY8pygU37TghkzMSTnPV/uHTY6ZVNtwNJ8gbOdsCtKhdZDwE4+baD2
         UNLuhwtVttY94NQ5KNzOXgCHclQRjmW5eleztxf6uE54jnq/RZ8d4nXjutVCr7XQj7F2
         YLG2gEruYCSvzSgomLcWA0ARoDvyx0At4yhIFQP8hcUNGJxJ2jKmje42KF5BT75PF8Oj
         YH+wOJCfiV99PBszNBeS+h6ajOCleNp5veDjjN3LyGnBWR7IVpIEe8Yyj8oWbNbQU4hq
         76/VwlnXWFfhgbo3Drf8UZqyCUURjSE5HWhFWY2ptVNg/WBc7+gS4nd73BVTSMfHco6D
         0fag==
X-Gm-Message-State: ACgBeo0iMTtl4f12VrIk3t8VAH1s9TgJHf8b9j+XHz5lJl3/t0CbN0xC
        Tg5CssO5dbx3BTwpdFmYm1G3aQ==
X-Google-Smtp-Source: AA6agR5M1IuXZtRu45x1SGRgKe0a/V6Y0Etgz2Q6WQGjFTYAzERUmiN3xelLJIyFoGmXy7v4CGJQlg==
X-Received: by 2002:a05:6512:3f0a:b0:492:da2e:ce69 with SMTP id y10-20020a0565123f0a00b00492da2ece69mr6657653lfa.269.1661840061398;
        Mon, 29 Aug 2022 23:14:21 -0700 (PDT)
Received: from [192.168.0.199] (89-71-83-146.dynamic.chello.pl. [89.71.83.146])
        by smtp.gmail.com with ESMTPSA id 22-20020ac25f56000000b0048b18700dddsm1505595lfz.106.2022.08.29.23.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 23:14:21 -0700 (PDT)
Message-ID: <85fa3a0c-cee9-3aaa-cd41-7d4ca9d90235@semihalf.com>
Date:   Tue, 30 Aug 2022 08:14:19 +0200
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
From:   =?UTF-8?Q?Marek_Ma=c5=9blanka?= <mm@semihalf.com>
In-Reply-To: <CAJZ5v0gHMO42xiKsN5+QRM0FBN=Z1NfEQFCTzRWdwGuOmd+PZg@mail.gmail.com>
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

On 29.08.2022 16:12, Rafael J. Wysocki wrote:
> On Mon, Aug 29, 2022 at 12:21 PM Marek Maślanka <mm@semihalf.com> wrote:
>>
>> The GPE interrupts that are the wake-up source are "turned off" by clear
>> the “enable_for_wake” flag when the kernel resumes (suspend_enter() ->
>> acpi_s2idle_restore() -> acpi_disable_wakeup_devices() ->
>> acpi_set_gpe_wake_mask()). On the resume path the kernel also resumes
>> the interrupts (suspend_enter() -> dpm_resume_noirq() -> resume_irqs())
>> which process the GPE interrupt that woke-up the kernel (... ->
>> acpi_irq() -> acpi_ev_sci_xrupt_handler() -> acpi_ev_gpe_detect() -> …).
>> The GPE interrupt routine stops in the acpi_ev_gpe_detect () function
>> when the "enable_for_wake" flag is cleared.
>>
>> As the interrupt servicing might work simultaneously on SMP, it’s
>> possible that the “enable_for_wake” flag can be cleared before the GPE
>> interrupt gets chances to be processed. It might happen when the CPU
>> processed other IRQ before the GPE IRQ that woke up the device.
>>
>> This issue is seen on low-end Chromebooks with two cores CPU when HPET
>> IRQ is triggered while resuming the device and is processed before the
>> ACPI GPE interrupt on the same CPU core.
>>
>> Before clear the enable_for_wake flag we need to make sure that the
>> specific wake-up GPE IRQ block was processed.
>>
>> Signed-off-by: Marek Maslanka <mm@semihalf.com>
> 
> First off, if you want to modify ACPICA code, the way to do that is
> via the upstream ACPICA project on GitHub.
> 
> Second, I'm not sure what the problem is.
> 
> Yes, acpi_ev_gpe_detect() will bail out early when none of the GPEs in
> the given block is enabled either for wake or for run, but since the
> system has been woken up already and the GPE is now disabled, it will
> not trigger again until enabled next time.
> 
> Is the problem that the GPE will signal wakeup spuriously on the next
> suspend or is it something else?

In my cases the problem is the GPE STS flag that cannot be cleared
(acpi_ev_gpe_detect() -> acpi_ev_detect_gpe() -> acpi_ev_gpe_dispatch()
-> acpi_hw_clear_gpe()). If the status bit is not cleared before the
next suspend, the device will not wake up.

