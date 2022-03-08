Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472DC4D1CDD
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Mar 2022 17:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244868AbiCHQLx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Mar 2022 11:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348231AbiCHQLv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2022 11:11:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C48550B0E
        for <linux-acpi@vger.kernel.org>; Tue,  8 Mar 2022 08:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646755851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dv+uw+2rrXTMM+vcd9FCY5PV+xXeY+hl2kQeSGF/NeI=;
        b=VwjzjtDHxKjT7vuken1x2gDavw5QdxZpJohGVP1wSqz2BffEk9pMUB34O1QnfjFuSXmay0
        gHxuBTFWzq/BSEs6l62m/KHeiJhzDzRAiRJFB/Eh7uiqkRSg2Zf7DWQE5hZC+dkJ/itLDa
        HPCcRaN82bUyYUeCRTRfSfawlFGINJs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-pmj7kqd7ODesPc_fJtrcrA-1; Tue, 08 Mar 2022 11:10:50 -0500
X-MC-Unique: pmj7kqd7ODesPc_fJtrcrA-1
Received: by mail-ej1-f69.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so8931208ejk.16
        for <linux-acpi@vger.kernel.org>; Tue, 08 Mar 2022 08:10:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Dv+uw+2rrXTMM+vcd9FCY5PV+xXeY+hl2kQeSGF/NeI=;
        b=CXUDqO6RIMjzDW2sLMW/H7V2Rrz8dG0XIPz3xPMxBKq5HP2mMNo2mNA7s3eNkFifwf
         4Dl6cKdskruiA6jUegsh7oQQLuZTw4dEkVdx0ySbO/P89RAWMDHXXzZfoyaVkm8GF5/Q
         qLq2VhFRwmJ1+12jqLwqsnVLrAq3GBk2ZtKc7e5xeWJeILClQZmDXhdGgs5ioCPYTk0G
         exnxjcUida20/u+FwEDx9ni6Zo+AQELkozfnln/sj+gCUdSNkjASfXK2Gg8Uw0NszePw
         bT7tWrwcYTDzamAGXCdR6YKoFX7VAKMJ7hfXC4AbElctEBCqJTRKvcvAvEUbEOnfOUzE
         Kr+w==
X-Gm-Message-State: AOAM5328M0Jrx/D6qIIuv0/ZpPmnQbezNHMy1pwQ4dUg8ib5f5PSpwhg
        OuH0C56bWnD6ZAvTisgimcQi+yXPJdczcK3a9MK2DUOW6avnnwMkoUUlxYIg1cboGqJtanHSPlU
        y5bVNHbOXvzT9bDawr4xlYg==
X-Received: by 2002:a50:9fa6:0:b0:415:fd95:6afa with SMTP id c35-20020a509fa6000000b00415fd956afamr16882249edf.200.1646755848512;
        Tue, 08 Mar 2022 08:10:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdxEBpiTYSM+aqpN0SbP0mQe7lFZ2I69ZtomHgIraDoSzTJTphY3a4RfGcRHBEcKzP1LVB1w==
X-Received: by 2002:a50:9fa6:0:b0:415:fd95:6afa with SMTP id c35-20020a509fa6000000b00415fd956afamr16882225edf.200.1646755848249;
        Tue, 08 Mar 2022 08:10:48 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906354800b006da9dec91f2sm5734379eja.163.2022.03.08.08.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 08:10:47 -0800 (PST)
Message-ID: <1cd4ae24-ae92-302e-ac87-76ef15472a9f@redhat.com>
Date:   Tue, 8 Mar 2022 17:10:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC] ACPI: platform-profile: support for AC vs DC modes
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <markpearson@lenovo.com>
 <20220301201554.4417-1-markpearson@lenovo.com>
 <65d8cf3b-0eea-0583-fa23-e2c71287fb85@redhat.com>
 <BL1PR12MB5157CDB77675859B7F279578E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
 <7b281a37-5163-6cd7-360e-1c63bde714a8@redhat.com>
 <BL1PR12MB5157125246817A70649C12F7E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BL1PR12MB5157125246817A70649C12F7E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/8/22 16:55, Limonciello, Mario wrote:
> [AMD Official Use Only]
> 
>>> I don't think that's right for the PSC Thinkpads.  They have dedicated
>>> different tunings for each of the slider positions on AC vs DC.
>>>
>>> So "balanced" on AC will not be the same as "balanced" on DC.
>>
>> I see, but it is not like balanced on AC is closer to performance
>> on DC then it is to balanced on DC, right? IOW in the UI we should
>> still call them both balanced ?
> 
> I feel that's a gross oversimplification to say balanced on AC is close
> to performance on DC.  There are *so many* other (otherwise invisible)
> tuning knobs behind what PSC does that Lenovo has weighed out the benefits
> of using for different circumstances.  
> 
> You nerf all this by just having one user space facing knob and let userspace
> change to performance mode when you on charger.

The way I see this there are 2 ways this can work on the kernel to fw/ec
boundary:

1. There are actually 6 values we can write to a single slot:
   ac-low-power,dc-lowpower,ac-balanced,dc-balanced,ac-performance,dc-performance

2. There are separate ac-setting + dc-setting slots to which we can
   write one of 3 values: low-power, balanced, performance; and the fw/ec
   automatically picks which slot to used based on ac vs battery status

If 1 is the case for PSC then I agree that the kernel should indeed get involved
and it should automatically write either the ac or dc variant of the last
userspace requested value so that things behave as expected.

If 2 however is the case then I think all that is necessary is for the
driver to just write the last userspace selected value to both slots.

Note that neither case requires a userspace API change when solved
as I suggest.

> At least the way Windows does this is that it offers "one" UI slider but you
> have last selected values based on if you're plugged in or on battery.
> 
> 1) So on battery I might have balanced selected to start out.
> 2) Then I plug in a charger, and balanced is still selected but this has
> different characteristics from balanced on battery.
> 3) Now I change to performance while on charger.
> 4) Then I unplug charger and it goes back to my selection for battery: "balanced".

The above is more about policy then it is about mechanism, userspace
can easily remember 2 separate settings for ac vs battery and restore
the last set value for ac or battery when changing between the 2.

Since this mostly about the policy which profile to set when this
really belongs in userspace IMHO and solving this in userspace means that
we will have a single universal solution for all the different
platform_profile implementations, and we seem to have quite a lot of
those (at least one per laptop vendor, Lenovo currently has 2)

>> If that is right then I think my point still stands, if PSC
>> has 2 separate slots (one AC one DC) for the performance
>> setting, then we can just set both when userspace selects a
>> performance level and have the actual e.g. balanced -> performance
>> change be done by userspace when userspace select the machine
>> has been connected to a charger.
> 
> But you *don't want to* actually select performance when you switch to a
> charger.  If you have 3 value slots for AC and 3 value slots for DC you
> should only be swapping between what is in those 3 values slots.

That only works if all implementation have separate AC and DC profile
slots, which most won't have. If we just sync the 2 slots for implementations
which do have 2 slots and then always "fake" 2 slots in userspace we
have a universal implementation which will work well everywhere, without
any significant downside to the implementations which do have 2 slots.

Regards,

Hans

