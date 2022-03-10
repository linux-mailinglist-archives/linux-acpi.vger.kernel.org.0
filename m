Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CCA4D46C4
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 13:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241975AbiCJMYC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 07:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbiCJMYB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 07:24:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5C7063F4
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 04:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646914978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hF4IPwDjQWvTDGnUGpdqamcykshZ8gvGsFBFPC99SW4=;
        b=I+qjr60cX4g+J5XwNKfXa4WpYmp3z0u9h5k9QHiO0IeNORovP89xFJvFQY5yVWXQAsraf+
        ZZAleveVhvXiJhfsaR9sxBM+cDMp6mAnBWyKOdzK+zzV3XMu23D3Y4fCtAs6UoAtq9pJ8k
        2VB+I1rAWVlxQBPrWLH6NBhnkunHIKM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-yNTi4pZxNyWZKAiXcBgLpg-1; Thu, 10 Mar 2022 07:22:57 -0500
X-MC-Unique: yNTi4pZxNyWZKAiXcBgLpg-1
Received: by mail-ej1-f70.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso2994189eje.20
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 04:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hF4IPwDjQWvTDGnUGpdqamcykshZ8gvGsFBFPC99SW4=;
        b=SJJob5ns6wp7/TPOYD9kX1lqnnialv67SaiuRmO/5wFKDrEjtctUxgBjb8NSTxjhbP
         /w1bgb6kd4A0zwGC3MCjJ4eHP9IHRP54unB0/dHJuHS2Wpl8Hd8QBj9B9oZnaUWr0kA6
         s6mZaDkZzeWXWL9z0a+TdCM750/v+wQIm3GFTEitgAj9wNcHzQUiJEQ20lmIe7p/xyxX
         CfxCmkbXWmpe4b+HRkxfj9tc6aYUE5jaJp0AJiUjZDGdXce8csmx5AaW19G63qE7vi3D
         V/rhcDpNttB9Gcx9ZxE+04+z/7IGwiAm5I++93lciLBuKHAfyN3YkIlJSpWD3dwmPJ8y
         Qngw==
X-Gm-Message-State: AOAM533Z1SCgHb4OUR9cib/PDmmSKQzMO6g7WGlarXtcoKSXkAFP65M0
        fhGWqRciq4jisbbW/9kqQ6DFhlI6Sx0a9zcp1g5aPfE6legxdrlPym+g5lTxdw1kTMs2vZCF1aU
        nGz6Z9gBJlGwcX+aRl7CMbw==
X-Received: by 2002:a05:6402:1042:b0:416:5b93:eae7 with SMTP id e2-20020a056402104200b004165b93eae7mr4209463edu.84.1646914976359;
        Thu, 10 Mar 2022 04:22:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1SJYWP5VagFvpoCai07rkPdd2gkWTXVX2uM0BwwPXPrEqCxxmQCRAMR9+jCyc1DCsqfY8pQ==
X-Received: by 2002:a05:6402:1042:b0:416:5b93:eae7 with SMTP id e2-20020a056402104200b004165b93eae7mr4209442edu.84.1646914976093;
        Thu, 10 Mar 2022 04:22:56 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id i22-20020a170906251600b006d6d9081f46sm1730858ejb.150.2022.03.10.04.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:22:55 -0800 (PST)
Message-ID: <5fb0cbe8-5f9d-1c75-ae0a-5909624189d3@redhat.com>
Date:   Thu, 10 Mar 2022 13:22:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Many reports of laptops getting hot while suspended with kernels
 >= 5.16.10 || >= 5.17-rc1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Mark Pearson <markpearson@lenovo.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <31b9d1cd-6a67-218b-4ada-12f72e6f00dc@redhat.com>
 <CAJZ5v0hQifvD+U8q1O7p_5QeicG_On4=CrgNj0RsbPSbkY8Hww@mail.gmail.com>
 <ad3b77f8-7e75-1dfa-8ee4-1077336911aa@redhat.com>
 <CAJZ5v0js8Vr7dW09WGyR_JTn4kMybDhaTWt4yziqwSM+oAXUNA@mail.gmail.com>
 <CAJZ5v0imJfOp-Uw=tH2dimSQzb-EgHu_yEU_0LScmrQ43t3pbw@mail.gmail.com>
 <c9a1adb5-17b7-c7ed-d23f-6b6523a4771a@redhat.com>
 <CAJZ5v0gB2ZCWe3MeGnw6_CNu_Ds0QEPZ6X6jnA7dQbZe6gKZ8w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0gB2ZCWe3MeGnw6_CNu_Ds0QEPZ6X6jnA7dQbZe6gKZ8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/10/22 11:56, Rafael J. Wysocki wrote:
> On Thu, Mar 10, 2022 at 10:07 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 3/9/22 19:27, Rafael J. Wysocki wrote:
>>> On Wed, Mar 9, 2022 at 5:34 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>
>>>> On Wed, Mar 9, 2022 at 5:33 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 3/9/22 14:57, Rafael J. Wysocki wrote:
>>>>>> On Wed, Mar 9, 2022 at 2:44 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>>
>>>>>>> Hi Rafael,
>>>>>>>
>>>>>>> We (Fedora) have been receiving a whole bunch of bug reports about
>>>>>>> laptops getting hot/toasty while suspended with kernels >= 5.16.10
>>>>>>> and this seems to still happen with 5.17-rc7 too.
>>>>>>>
>>>>>>> The following are all bugzilla.redhat.com bug numbers:
>>>>>>>
>>>>>>>    1750910 - Laptop failed to suspend and completely drained the battery
>>>>>>>    2050036 - Framework laptop: 5.16.5 breaks s2idle sleep
>>>>>>>    2053957 - Package c-states never go below C2
>>>>>>>    2056729 - No lid events when closing lid / laptop does not suspend
>>>>>>>    2057909 - Thinkpad X1C 9th in s2idle suspend still draining battery to zero over night , Ap
>>>>>>>    2059668 - HP Envy Laptop deadlocks on entering suspend power state when plugged in. Case ge
>>>>>>>    2059688 - Dell G15 5510 s2idle fails in 5.16.11 works in 5.16.10
>>>>>>>
>>>>>>> And one of the bugs has also been mirrored at bugzilla.kernel.org by
>>>>>>> the reporter:
>>>>>>>
>>>>>>>  bko215641 - Dell G15 5510 s2idle fails in 5.16.11 works in 5.16.10
>>>>>>>
>>>>>>> The common denominator here (besides the kernel version) seems to
>>>>>>> be that these are all Ice or Tiger Lake systems (I did not do
>>>>>>> check this applies 100% to all bugs, but it does see, to be a pattern).
>>>>>>>
>>>>>>> A similar arch-linux report:
>>>>>>>
>>>>>>> https://bbs.archlinux.org/viewtopic.php?id=274292&p=2
>>>>>>>
>>>>>>> Suggest that reverting
>>>>>>> "ACPI: PM: s2idle: Cancel wakeup before dispatching EC GPE"
>>>>>>>
>>>>>>> which was cherry-picked into 5.16.10 fixes things.
>>>>>>
>>>>>> Thanks for letting me know!
>>>>>>
>>>>>>> If you want I can create Fedora kernel test-rpms of a recent
>>>>>>> 5.16.y with just that one commit reverted and ask users to
>>>>>>> confirm if that helps. Please let me know if doing that woulkd
>>>>>>> be useful ?
>>>>>>
>>>>>> Yes, it would.
>>>>>>
>>>>>> However, it follows from the arch-linux report linked above that
>>>>>> 5.17-rc is fine, so it would be good to also check if reverting that
>>>>>> commit from 5.17-rc helps.
>>>>>
>>>>> Ok, I've done Fedora kernel builds of both 5.16.13 and 5.17-rc7 with
>>>>> the patch reverted and asked the bug-reporters to test both.
>>>>
>>>> Thanks!
>>>
>>> Also, in the cases where people have not tested 5.17-rc7 without any
>>> reverts, it would be good to ask them to do so.
>>
>> Ok, done.
>>
>>> I have received another report related to this issue where the problem
>>> is not present in 5.17-rc7 (see
>>> https://lore.kernel.org/linux-pm/CAJZ5v0hKXyTtb1Jk=wqNV9_mZKdf3mmwF4bPOcmADyNnTkpMbQ@mail.gmail.com/).
>>
>> The first results from the Fedora test kernel builds are in:
>>
>> "HP Envy Laptop deadlocks on entering suspend power state when plugged in. Case gets very hot and requires a power button hold to restart"
>> https://bugzilla.redhat.com/show_bug.cgi?id=2059668
>>
>> 5.16.9: good
>> 5.16.10+: bad
>> 5.16.13 with "ACPI: PM: s2idle: Cancel wakeup before dispatching EC GPE" reverted: good
>> 5.17-rc7 with "ACPI: PM: s2idle: Cancel wakeup before dispatching EC GPE" reverted: good
>> 5.17-rc7 (plain): good
>>
>> So this seems to match the arch-linux report and the email report
>> you linked. There is a problem with the backport in 5.16.10+,
>> while 5.17-rc7 is fine.
>>
>>> It is likely that the commit in question actually depends on some
>>> other commits that were not backported into 5.16.y.
>> I was thinking the same thing, but I've no idea which commits
>> that would be.
> 
> I do have an idea, but regardless of this, IMO the least risky way
> forward would be to request "stable" to drop "ACPI: PM: s2idle: Cancel
> wakeup before dispatching EC GPE" which has been backported, because
> it carried a Fixes tag and not because it was marked for "stable".
> 
> Let me do that.

Ok, that sounds good, thank you.

Regards,

Hans

