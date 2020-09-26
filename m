Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1435427956E
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Sep 2020 02:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725272AbgIZANn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 20:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbgIZANk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 20:13:40 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9046C0613CE
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 17:13:40 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o8so3988625otl.4
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 17:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uV0OqNe6fNGB9fHblrzHw8cV18adwvrkpgLxsiNP0V0=;
        b=Itebs+wDAb4wpBvU4vPbCiLJnqG1udHed3DIfGnE4q+RUOWLMv3mGel8E4yijdBKEY
         I9B5MlW3NcLxPV4yZNs0MN9CUGtiqpVaXBemJ5vvVwM93NCjMqEEtaE3pMrenijGh90R
         nX3nRIJ5N6mKMl8WCK7FP09bwZBnRfzV9FTzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uV0OqNe6fNGB9fHblrzHw8cV18adwvrkpgLxsiNP0V0=;
        b=TYOxQJxxM/4bGgD4O4nudOnuve2YuNdcjR+zqljpX3UnmBQvzosH0mverTCZZo9CIO
         3y4KHzXX2y70Vwcuiv1xgKzCUk3RIlbh68UJIaHesJ6U2/cMEVKR+5p/xP7Rb2V/o+FU
         Be3T7SlB9F9gCbKddggmlYZJnERvDBDROZMxg8vu1gOQMPpcmUYAYx8pYBwwXFBkgL4Q
         LQb0fv6MgBjnnxuKljsF3on3F8V8gLlKoZjiQcg89WlvzryrQ+K2+BiWCTTR0wIfo+d3
         lwCUexiQoAJb2I2WHEwyiZS6PRbc7Ow8+c6wlI0JUHvC6YiAyQOpvsLocvz3ZGIAsuyX
         AnmA==
X-Gm-Message-State: AOAM531pblvtaqfhU5JwIiVQpgxntNbzM3VUALdPcYpvAeijspPRqz9h
        Y0gG5KbvOpWTIbh95RoJ9ajcTA==
X-Google-Smtp-Source: ABdhPJy+UJfLmw1XfbHObY0B1wHdW9//e0AKIl4aAw2lTnknEdN9TO9NnMLa3wvcpjkRI2FBogyCmA==
X-Received: by 2002:a9d:6e1:: with SMTP id 88mr1876214otx.279.1601079219831;
        Fri, 25 Sep 2020 17:13:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d63sm958205oig.53.2020.09.25.17.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 17:13:39 -0700 (PDT)
Subject: Re: [PATCH 00/11] Introduce Simple atomic and non-atomic counters
To:     Kees Cook <keescook@chromium.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, shuah@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, minyard@acm.org, arnd@arndb.de,
        mchehab@kernel.org, rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
 <202009251650.193E2AD@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7d8f86ab-4333-afa1-6523-e42ae5c7d9b2@linuxfoundation.org>
Date:   Fri, 25 Sep 2020 18:13:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202009251650.193E2AD@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/25/20 5:52 PM, Kees Cook wrote:
> On Fri, Sep 25, 2020 at 05:47:14PM -0600, Shuah Khan wrote:
>> -- Addressed Kees's comments:
>>     1. Non-atomic counters renamed to counter_simple32 and counter_simple64
>>        to clearly indicate size.
>>     2. Added warning for counter_simple* usage and it should be used only
>>        when there is no need for atomicity.
>>     3. Renamed counter_atomic to counter_atomic32 to clearly indicate size.
>>     4. Renamed counter_atomic_long to counter_atomic64 and it now uses
>>        atomic64_t ops and indicates size.
>>     5. Test updated for the API renames.
>>     6. Added helper functions for test results printing
>>     7. Verified that the test module compiles in kunit env. and test
>>        module can be loaded to run the test.
> 
> Thanks for all of this!
> 
>>     8. Updated Documentation to reflect the intent to make the API
>>        restricted so it can never be used to guard object lifetimes
>>        and state management. I left _return ops for now, inc_return
>>        is necessary for now as per the discussion we had on this topic.
> 
> I still *really* do not want dec_return() to exist. That is asking for
> trouble. I'd prefer inc_return() not exist either, but I can live with
> it. ;)
> 

Thanks. I am equally concerned about adding anything that can be used to
guard object lifetimes. So I will make sure this set won't expand and
plan to remove dec_return() if we don't find any usages.

thanks,
-- Shuah
