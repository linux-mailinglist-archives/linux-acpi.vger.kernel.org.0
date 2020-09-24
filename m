Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1091E2774D2
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 17:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgIXPIf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Sep 2020 11:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgIXPIf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2020 11:08:35 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EEBC0613D3
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2020 08:08:34 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id y5so3463822otg.5
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2020 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oKut7+ZE8Cwg1H0GjJjlU6QFhq4QfWKGoaWrzXaMdPQ=;
        b=VeYYf3vkSJaJTKjSHt+ahxijhfiWy07sbqhRFNB0b5LvH7k+8GTTQfwTPDvbJG9hs4
         nvNOxUL/BWQokmlPGL12ud/TUqbXsogCeqT2zRDRnKKm1WZnqdsay9Lr/iVjiexNTHh4
         p9Mhd9dQ71pSQlXJ7uIXGNVQZekU7vvWLupZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oKut7+ZE8Cwg1H0GjJjlU6QFhq4QfWKGoaWrzXaMdPQ=;
        b=FgQFMwMm3eALg4MQB+I1ePiZtQX/thxAfYToz6bKHEgGsNHKK3GwfAibxdCUEyEYOG
         KbbB3dniGcgf6ukowv7etCcesfkHLagEp+rE/u1XtGL48qxGDTKsj+M8/cDdTvdIuI3C
         2mHtKoUiau7xGmQLksIih5y8OVg4YMmxhq/ISMHvERWSxOGcOWp7eWNO8YN4vUVTU5et
         uy3dRep4E9LIBU/C+x7RhfSTsivfVCJ7rsUb7u/ichPQZpDtKBDceNDgM0ZtoyWRKGEu
         VZy0KMJlsQwC/KsXfzoXe413PXFZBj5oX3Kj2nTfUkslFM/pPsHCN4cUKRnlJLAQ/l/k
         D9+Q==
X-Gm-Message-State: AOAM530xiVUbJUDscPEW8KtWv34F5qW8FxuKZ+kYkbBDBbWYMoK7qCth
        BLX15h9JQ86TxF92xHl6XtdBrg==
X-Google-Smtp-Source: ABdhPJwcaYObD6Zecw0a5f2Axhe2/u582XLt8J7QRbvkVnxZhcDq7TBRAeSuG1P7AzLJ2JFGI7vqOA==
X-Received: by 2002:a9d:128d:: with SMTP id g13mr52032otg.245.1600960114168;
        Thu, 24 Sep 2020 08:08:34 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x15sm869317oor.33.2020.09.24.08.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 08:08:33 -0700 (PDT)
Subject: Re: [RFC PATCH 05/11] drivers/acpi: convert seqno counter_atomic
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
 <9e2c6cccabc96fe1e5304e2fa2dfdad28ca5ac9c.1600816121.git.skhan@linuxfoundation.org>
 <CAJZ5v0iS2wpvvJGLsEJSSdCJ0tf4DmJ9fQWVU3PzFuMB7Zbkjw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3cc1e840-6525-e125-499a-03b9c86c0243@linuxfoundation.org>
Date:   Thu, 24 Sep 2020 09:08:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iS2wpvvJGLsEJSSdCJ0tf4DmJ9fQWVU3PzFuMB7Zbkjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/24/20 5:13 AM, Rafael J. Wysocki wrote:
> On Wed, Sep 23, 2020 at 3:44 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> counter_atomic is introduced to be used when a variable is used as
>> a simple counter and doesn't guard object lifetimes. This clearly
>> differentiates atomic_t usages that guard object lifetimes.
>>
>> counter_atomic variables will wrap around to 0 when it overflows and
>> should not be used to guard resource lifetimes, device usage and
>> open counts that control state changes, and pm states.
>>
>> seqno is a sequence number counter for logging. This counter gets
>> incremented. Unsure if there is a chance of this overflowing. It
>> doesn't look like overflowing causes any problems since it is used
>> to tag the log messages and nothing more.
>>
>> Convert it to use counter_atomic.
>>
>> This conversion doesn't change the oveflow wrap around behavior.

I see typo here. Will fix it.

>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Both this change and the next patch are fine by me.
> 

Thanks Rafael. Okay to add your Acked-by?

thanks,
-- Shuah
