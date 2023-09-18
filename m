Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52497A4965
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Sep 2023 14:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbjIRMQq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Sep 2023 08:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240119AbjIRMQ3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Sep 2023 08:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C819EA0
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695039338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLQP8ymBv8WYGYUV0p0EWAvpDFWaTDPT4dt30n9P+aU=;
        b=dlh5Tf0Pk/gFsCX1hm4bThlvFMdjHCvqvYWgPqDR08UdVOORUHu0Qr93Lv7vjX7Ty61ose
        vi9XDdFclCKyZHeol1KvEvPm4JVnYNS2BFc5zIaThXaHawEKM5gEVeAYEUttKiSBFxM3Ib
        tchqEqKn1ma4ZOGS7UybpJRgl6pnNAg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-LwV9JVvVP5iu5vsKMbIUpA-1; Mon, 18 Sep 2023 08:15:36 -0400
X-MC-Unique: LwV9JVvVP5iu5vsKMbIUpA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3172a94b274so2965015f8f.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 05:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695039335; x=1695644135;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLQP8ymBv8WYGYUV0p0EWAvpDFWaTDPT4dt30n9P+aU=;
        b=Q9CrnR0ljU4wtCcuDMUqbrmfcSP6gGcaUs2pKbJPtLHJPeu7Rs9gkMvNpe2DjraOG+
         6odyd/uR3M4qgSVvDerX5xkh6p65Nmim/b8MrBHlIG7kWYXrlNnAe20nRBRBIpra3VpO
         jPLGml7QdfRi7uZQPU2+KGWEta29C3asRsaEW8wG5wTqAny5hZUR/OIGBXatH62TLPHw
         cmEjpd9+T6VoMe1mJpwWI+ojl4GzPidmxbomIUSNtIm7KO8e8x5SWhu6dxnbVTUpoKhS
         xUW4ZjmL4r/SieBU9zCv4sdBmiLW8tJT3uefR2ePcHH3WeNTfwtwhA2S5+OI7tL8+4ft
         7l4w==
X-Gm-Message-State: AOJu0YxvvOa/g6VIVld/IYnjJbPF7sKNMoxgV0av0Jtc6Vo+Pev0w9WD
        zLeAp5AqIE/kPDf8cVrW9CmU5ZlDeyniLJF7YkTiQw8ljKKGcsxd1jGu+ZMWK+REp12OJpzFO9j
        Gpx2KWMP0LpcbhSLl+BXSq9NCSHBPuA==
X-Received: by 2002:adf:a3c4:0:b0:31f:f664:d87 with SMTP id m4-20020adfa3c4000000b0031ff6640d87mr6993011wrb.20.1695039335557;
        Mon, 18 Sep 2023 05:15:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiPzVINpDFunwk9RW0aGFYMYz2VP26Mb7bcSOQByHhJW+M0WEKDin38PjK49YHEn7Lq+uRxA==
X-Received: by 2002:adf:a3c4:0:b0:31f:f664:d87 with SMTP id m4-20020adfa3c4000000b0031ff6640d87mr6992985wrb.20.1695039335149;
        Mon, 18 Sep 2023 05:15:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee? (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de. [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
        by smtp.gmail.com with ESMTPSA id q30-20020adfab1e000000b003177074f830sm11029025wrc.59.2023.09.18.05.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:15:34 -0700 (PDT)
Message-ID: <7282d074-15ba-4fe7-bf62-6a4dd6089817@redhat.com>
Date:   Mon, 18 Sep 2023 14:15:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 3/9] Documentation/scrub-configure.rst: Add
 documentation for scrub driver
Content-Language: en-US
To:     Shiju Jose <shiju.jose@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jiaqiyan@google.com" <jiaqiyan@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>,
        "somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
        "erdemaktas@google.com" <erdemaktas@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "duenwen@google.com" <duenwen@google.com>,
        "Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
        "mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
        "gthelen@google.com" <gthelen@google.com>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
 <20230915172818.761-4-shiju.jose@huawei.com>
 <887344ee-068d-f78f-d5f8-e816b966d875@redhat.com>
 <946f29d2370c41deb7a7c5a6f2bff0f3@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <946f29d2370c41deb7a7c5a6f2bff0f3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 18.09.23 12:25, Shiju Jose wrote:
> Hi David,
> 
> Thanks for looking into this.
> 
>> -----Original Message-----
>> From: David Hildenbrand <david@redhat.com>
>> Sent: 18 September 2023 08:24
>> To: Shiju Jose <shiju.jose@huawei.com>; linux-acpi@vger.kernel.org; linux-
>> mm@kvack.org; linux-kernel@vger.kernel.org
>> Cc: rafael@kernel.org; lenb@kernel.org; naoya.horiguchi@nec.com;
>> tony.luck@intel.com; james.morse@arm.com; dave.hansen@linux.intel.com;
>> jiaqiyan@google.com; jthoughton@google.com; somasundaram.a@hpe.com;
>> erdemaktas@google.com; pgonda@google.com; rientjes@google.com;
>> duenwen@google.com; Vilas.Sridharan@amd.com; mike.malvestuto@intel.com;
>> gthelen@google.com; Linuxarm <linuxarm@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>> Zengtao (B) <prime.zeng@hisilicon.com>
>> Subject: Re: [RFC PATCH 3/9] Documentation/scrub-configure.rst: Add
>> documentation for scrub driver
>>
>> On 15.09.23 19:28, shiju.jose@huawei.com wrote:
>>> From: Shiju Jose <shiju.jose@huawei.com>
>>>
>>> Add documentation for scrub driver, supports configure scrub
>>> parameters, in Documentation/scrub-configure.rst
>>>
>>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>>> ---
>>>    Documentation/scrub-configure.rst | 55
>> +++++++++++++++++++++++++++++++
>>>    1 file changed, 55 insertions(+)
>>>    create mode 100644 Documentation/scrub-configure.rst
>>>
>>> diff --git a/Documentation/scrub-configure.rst
>>> b/Documentation/scrub-configure.rst
>>> new file mode 100644
>>> index 000000000000..9f8581b88788
>>> --- /dev/null
>>> +++ b/Documentation/scrub-configure.rst
>>> @@ -0,0 +1,55 @@
>>> +==========================
>>> +Scrub subsystem driver
>>> +==========================
>>> +
>>> +Copyright (c) 2023 HiSilicon Limited.
>>> +
>>> +:Author:   Shiju Jose <shiju.jose@huawei.com>
>>> +:License:  The GNU Free Documentation License, Version 1.2
>>> +          (dual licensed under the GPL v2) :Original Reviewers:
>>> +
>>> +- Written for: 6.7
>>> +- Updated for:
>>> +
>>> +Introduction
>>> +------------
>>> +The scrub subsystem driver provides the interface for configure the
>>
>> "... interface for configuring memory scrubbers in the system."
>>
>> are we only configuring firmware/hw-based memory scrubbing? I assume so.
> The scrub control could be used for the SW  based memory scrubbing too.

Okay, looks like there is not too much hw/firmware specific in there 
(besides these weird range changes).
[...]

>>> +-------
>>> +
>>> +  The usage takes the form shown in this example::
>>> +
>>> +    # echo 0x300000 > /sys/class/scrub/scrub0/region0/addr_base
>>> +    # echo 0x100000 > /sys/class/scrub/scrub0/region0/addr_size
>>> +    # cat /sys/class/scrub/scrub0/region0/speed_available
>>> +    # 1-60
>>> +    # echo 25 > /sys/class/scrub/scrub0/region0/speed
>>> +    # echo 1 > /sys/class/scrub/scrub0/region0/enable
>>> +
>>> +    # cat /sys/class/scrub/scrub0/region0/speed
>>> +    # 0x19
>>
>> Is it reasonable to return the speed as hex? You set it as dec.
> Presently return speed  as hex to reduce the number of callback function needed
> for reading the hex/dec data because the values for the address range
> need to be in hex.

If speed_available returns dec, speed better also return dec IMHO.

> 
>>
>>> +    # cat /sys/class/scrub/scrub0/region0/addr_base
>>> +    # 0x100000
>>
>> But didn't we set it to 0x300000 ...
> This is an emulated example for testing the RASF/RAS2 definition.
> According to the RASF & RAS2 definition, the actual address range in the
> platform could vary from the requested address range for the patrol scrubbing.
> "The platform calculates the nearest patrol scrub boundary address
> from where it can start". The platform returns the actual address range
> in response to GET_PATROL_PARAMETERS command to the firmware.
> Please see section 5.2.21.2.1 Hardware-based Memory Scrubbing ,
> Table 5.87: Parameter Block Structure for PATROL_SCRUB in the
> ACPI 6.5 specification.
> 

So you configure [0x300000 - 0x400000] and you get [0x100000 - 0x300000]

How does that make any sense? :)

Shouldn't we rather return an error when setting a range that is 
impossible, instead of the hardware deciding to scrub something 
completely different (as can be seen in the example)?

-- 
Cheers,

David / dhildenb

