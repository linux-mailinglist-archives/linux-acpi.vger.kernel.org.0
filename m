Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA27677EB6
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 16:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjAWPG0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 10:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAWPG0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 10:06:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9BD29154
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 07:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674486329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fTYVbkyKdvuEmrdt1Pb2ChZH1pUOd1K3CR8rzj7RrTc=;
        b=E6jCVbLpIIaeXD8Qak1Msgp/XC2QIPAayXqHPOwv3wG+5mE4kbxb1XTz782Bv3Oxc7LrDx
        iriICmnsq5Jgn8w6uHvQLrIgnCaGdlei34fq17/UE3kWmOk9dvXN+wJBzeTWL2GV2lXwds
        guZiScQdIjdXy1LuN4eoTNERpluGFVs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-323-NKoqlacFP9yMf29SWP-wxA-1; Mon, 23 Jan 2023 10:05:27 -0500
X-MC-Unique: NKoqlacFP9yMf29SWP-wxA-1
Received: by mail-ed1-f70.google.com with SMTP id s3-20020a50ab03000000b0049ec3a108beso6143004edc.7
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 07:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTYVbkyKdvuEmrdt1Pb2ChZH1pUOd1K3CR8rzj7RrTc=;
        b=Azv7TPPDw3PBijJDDdxVIuoXYFRRfOMqL3GjGN/iNxi/lXyS1DzP1v1k6XWjE7qLSl
         WuLQVpdiVaKq9P34/XM4r7frU/eWDq+1oN0LEIDMiZSPDkeMLX2Pc9oaTfKBCbFR9igm
         KPrxb8jT6b63cvsSOmrZjSpMut7FqOWCVCiV1/A4F5sP+RWgbIVDVdBB+2CRPZaNSckw
         aqyPApTCSnynXWqyuP6MNSptNmJH2ubYZPwCkVnRV1/mJNBE+pVk9p24wRSlARDqYZ8L
         h9Ni+PwV8IgIyCSjxFzQNW5icBaDOSd7UVWs3kcplHZUrELWct6zKttYo4+VAFDlBuv4
         yGRA==
X-Gm-Message-State: AFqh2krCJFjQyCWsindcZZQmixe9Pobamwp1DvG6QIDZJ7fC+CHyr9CY
        InH3EODdI8HWtRS4lJOG8EOUaUEaDPnxop2DPPT1IUgh/1FbB1Jl/Uy55Gv3hRN9oIeNdzaQyde
        eDQzOLu9bMYU1c+yA1Gcjeg==
X-Received: by 2002:a17:906:6d9:b0:7c0:bbab:22e5 with SMTP id v25-20020a17090606d900b007c0bbab22e5mr26447567ejb.16.1674486326734;
        Mon, 23 Jan 2023 07:05:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtaGb80KCnrGSq57l2+0T4QNJMwpzSTqJEVKoqBS/+WGl59/L/q9++NXn4Ao5pSBcZKRJIYwA==
X-Received: by 2002:a17:906:6d9:b0:7c0:bbab:22e5 with SMTP id v25-20020a17090606d900b007c0bbab22e5mr26447546ejb.16.1674486326442;
        Mon, 23 Jan 2023 07:05:26 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id y19-20020a1709060a9300b0084debc351b3sm18942475ejf.20.2023.01.23.07.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 07:05:25 -0800 (PST)
Message-ID: <8d087bd5-175a-67ab-22c6-1eb8e72c0485@redhat.com>
Date:   Mon, 23 Jan 2023 16:05:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/3] ACPI: video/apple-gmux: Improve apple-gmux backlight
 detection
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-acpi@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Emmanouil Kouroupakis <kartebi@gmail.com>
References: <20230123113750.462144-1-hdegoede@redhat.com>
 <20230123120900.GA1924@wunner.de>
 <255bf66e-eb27-af2b-9a13-8b7d4b7b3c46@redhat.com>
 <20230123135827.GB2649@wunner.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230123135827.GB2649@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/23/23 14:58, Lukas Wunner wrote:
> On Mon, Jan 23, 2023 at 01:38:37PM +0100, Hans de Goede wrote:
>> On 1/23/23 13:09, Lukas Wunner wrote:
>>> On Mon, Jan 23, 2023 at 12:37:47PM +0100, Hans de Goede wrote:
>>>> Some apple laptop models have an ACPI device with a HID of APP000B
>>>> and that device has an IO resource (so it does not describe the new
>>>> unsupported MMIO based gmux type), but there actually is no gmux
>>>> in the laptop at all.
>>>>
>>>> This patch-series improves the drivers/acpi/video_detect.c so that
>>>> it no longer tries to use the non present gmux in this case.
>>>>
>>>> Note I'm still waiting for testing feedback from the reporter of
>>>> this problem. But from the logs the problem is clear
>>>> (the logs show: "apple_gmux: gmux device not present")
>>>
>>> Please provide a link to the original report.  I would also like to
>>> know the exact MacBook model used and I would like to see full dmesg
>>> output as well as an acpidump.
>>
>> I only have a report by private email. This does include full dmesg
>> output and an acpidump. I will forward this to you in a private
>> email.
>>
>> The reporter describes their model as a macbookpro8,1.
>>
>>> What you're saying here is that there's a fake APP000B device present
>>> in DSDT
>>
>> Yes that is exactly what I'm saying.
> 
> That's a 2011 13" MacBook Pro which indeed does not have dual GPUs.
> 
> I searched for other affected models and this seems to be more common
> than I thought:
> 
> MacBookPro5,4
> https://pastebin.com/8Xjq7RhS
> 
> MacBookPro8,1
> https://linux-hardware.org/?probe=e513cfbadb&log=dmesg
> 
> MacBookPro9,2
> https://bugzilla.kernel.org/attachment.cgi?id=278961
> 
> MacBookPro10,2
> https://lkml.org/lkml/2014/9/22/657
> 
> MacBookPro11,2
> https://forums.fedora-fr.org/viewtopic.php?id=70142
> 
> MacBookPro11,4
> https://raw.githubusercontent.com/im-0/investigate-card-reader-suspend-problem-on-mbp11.4/master/test-16/dmesg
> 
> These are 13" and 15" models from the pre-retina and retina era
> (2009 - 2015).  None of them have dual GPUs.  (Only a subset of
> the 15" and 17" models had dual GPUs.)  Apple sloppily included
> a GMUX device on all of them and it wasn't a problem so far
> because the gmux driver detects non-presence and bails out,
> but it throws off the new backlight algorithm.
> 
> This is really sad. :(
> 
> Please add a Reported-by to your commits

I was about to say that Emmanouil may want to keep their email
private. But I see you've already added them to the Cc, so
now the email is part of the platform-driver-x86 archives.

Emmanouil, is it ok if I add a line like this:

Reported-by: Emmanouil Kouroupakis <kartxxx@gmail.com>

to the commit message of v2 of the patches ? This gives you credit
for reporting the bug, but it also exposes your email address
in public places.

> as well as the list I've
> provided above so that we've got a complete record in the git history.

Ack, I'll add the list of devices to v2 of the patches.

Regards,

Hans


