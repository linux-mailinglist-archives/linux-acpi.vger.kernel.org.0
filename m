Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CD862C948
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Nov 2022 20:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiKPTxT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Nov 2022 14:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbiKPTxR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2022 14:53:17 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85AC4D5D0
        for <linux-acpi@vger.kernel.org>; Wed, 16 Nov 2022 11:53:16 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id r2so9696367ilg.8
        for <linux-acpi@vger.kernel.org>; Wed, 16 Nov 2022 11:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCykNX32gvCxKdIcReGDOnFwaVXOtSeXbWqUs4fkq6E=;
        b=cC8uPmk8VC/AN8Vh/LyKBcf+7l+ri7qJKhhTBNBHj50TctH2FsIbmebyJST+1Ps1SP
         otiEiZOB0QzhUAwwYs2lQadVWFmYgqHkJCHswqPI8/YdRw1G875PWcDYl/+52SqyF65J
         Nhiy9tkBR8DoILUOhQAhAiKvWc6wP31FmWf7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCykNX32gvCxKdIcReGDOnFwaVXOtSeXbWqUs4fkq6E=;
        b=H80r9GBWOTzmFsUFvJB/CCuCgHKhISmZDrBdOKNLGNG5xS0GwgdjItBPHL7LPMNiuS
         qFzOO8a9SGi34LXdIUDVXXG/aEEM8SWzd7/8tsVXtzfoEh/E4AWAHy4KHE/hFDCoAB6E
         0p8FEywCrFbHCC87TYmCLrx0FzzF8YRIto46rKgR3BD/wOgClyP0qQtbZZd+2gA9POpn
         3xTnyJELT+RK5481ANqXlpJ+eRcmWxDQ4rnjg0eBEYw/8S/e7JU896j2EvfM9XVgx4j1
         ODIXPMRNjUycU8D5ab0pZPWr9jVu5z1XtVWZYEYX+FP0X3BRPJwZPMAnslhLFKdZPpCZ
         AB3g==
X-Gm-Message-State: ANoB5pkDg5LQDaiukweyaKU/vSBsj3gbdJMYF5YHON8C1VIdOUSer2/H
        AlTozDV+L6kA/qB8M9SPaSNaNw==
X-Google-Smtp-Source: AA0mqf7Ntoo14DB9Q9zMd8ZrTU1YDLJZFvdf9uEXWN8ezR7bWryAAnNLxKDVL+xkWpv269o1dm3B7A==
X-Received: by 2002:a92:b74a:0:b0:2f9:4402:9c77 with SMTP id c10-20020a92b74a000000b002f944029c77mr11703851ilm.145.1668628395981;
        Wed, 16 Nov 2022 11:53:15 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a8-20020a92ce48000000b002ffa449535asm6567466ilr.74.2022.11.16.11.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 11:53:15 -0800 (PST)
Message-ID: <f47aee52-b826-9f84-3731-ca829064e70e@linuxfoundation.org>
Date:   Wed, 16 Nov 2022 12:53:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ACPICA: Fix sprintf() INT_MAX -Wformat-truncation= warn
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221116152258.28772-1-skhan@linuxfoundation.org>
 <CAJZ5v0jsSmfMAdtTfhGxD7LP0WoCT8sSeCJ6BRY3ncRuj4yTmQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAJZ5v0jsSmfMAdtTfhGxD7LP0WoCT8sSeCJ6BRY3ncRuj4yTmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/16/22 12:05, Rafael J. Wysocki wrote:
> On Wed, Nov 16, 2022 at 4:23 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> utprint module is included in tools/acpidump and when acpidump is built,
>> the following warning occurs.
>>
>>   CC       tools/acpidump/utprint.o
>> /usr/include/x86_64-linux-gnu/bits/stdio2.h: In function ‘sprintf’:
>> ../../../../../drivers/acpi/acpica/utprint.c:602:18: warning: specified bound 4294901760 exceeds ‘INT_MAX’ [-Wformat-truncation=]
>>    602 |         length = vsnprintf(string, ACPI_UINT32_MAX-ACPI_UINT16_MAX,
>>        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    603 |                         format, args);
>>        |                         ~~~~~~~~~~~~~
>>
>> Fix sprintf() to use ACPI_UINT32_MAX/2 to get rid of the truncate problem.
>> This change is inline other sprintf() implementations.
>>
>> If using ACPI_UINT32_MAX is necessary in the kernel, acpidump might require
>> special case to get rid of this truncate problem.
> 
> As ACPICA material, this should be submitted to the upstream project
> on GitHub and honestly I'm not sure if it is going to be resolved this
> way there.

Thank you for your review. I will send this ACPICA upstream project.

thanks,
-- Shuah

