Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883025B3F62
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Sep 2022 21:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiIITUj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Sep 2022 15:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiIITUh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Sep 2022 15:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511588E46F
        for <linux-acpi@vger.kernel.org>; Fri,  9 Sep 2022 12:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662751235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z80GBq+4p3RaBX9sDJUAwZlDncGLxsS7IqijyE03ut0=;
        b=Vt5kAtmMruxFlaEqgfqUaYpVgYEAnBTcjFpapUyqqXJI4OV9rpQOksdpPuHC7C5U4NM4Di
        cbG3V46F9If60tna60QNc+YY7Q86xY0VDUpzcqhTPc1p6lQr2y/LFjvjHMFi3dYeatWFgU
        vME8NCugBrcTt65xgP/vdR0wX7Yz6dw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-508--5KFfLD0Or-PggK8And7Bw-1; Fri, 09 Sep 2022 15:20:33 -0400
X-MC-Unique: -5KFfLD0Or-PggK8And7Bw-1
Received: by mail-ed1-f72.google.com with SMTP id q32-20020a05640224a000b004462f105fa9so1907770eda.4
        for <linux-acpi@vger.kernel.org>; Fri, 09 Sep 2022 12:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=z80GBq+4p3RaBX9sDJUAwZlDncGLxsS7IqijyE03ut0=;
        b=O0mhqazH08/zLKv2TBhWtqUSkr++1Nz49ppfN7wNKkrHkp7yVVtTl2rHi8uB5ohMwv
         bclCtRBe/EXYg5EfCjfw6+KHAqpAnsIs+VfWzXdp+0bbz2MkOiUcKwTW3XW8X9PRe+lM
         ClrZxtwgXloR1OaeObtZ6wVBgUBBfL23RL1k2fzzzshw/wa/iXfvFb77CMV842glrNFP
         0QS3fzISH2LiiXl8XvKKamt8s3FVmVcW5i7dIuH0fvRO3paGhHQ+eN3t6ZOkV5Jou1UN
         S53649xZYjG4aQgZekOgKrYrUtEbuJrMcSIJEAHwO84fmuQ/2ouPvmExym6nP2hGM8I2
         Kz6g==
X-Gm-Message-State: ACgBeo0SStiWooZ2mTw7IzuV0NePmv0TpVw0aFxMsZGBq0EEf30q78Vi
        NgU+JLlMhbegGtj6XqG0imQmfEplp2jdeNsgDfU0FhbJkaYmgP1UzGKNPK+Q15YnQLk37TUO2fS
        btWLtIRkDux34QRsJtn1lEw==
X-Received: by 2002:a17:907:6d8c:b0:731:6c60:eced with SMTP id sb12-20020a1709076d8c00b007316c60ecedmr11032955ejc.266.1662751232894;
        Fri, 09 Sep 2022 12:20:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5unqrp65eTppxFrO3LmvqOIkTTKQKCAMZkgaDyAaBNUvBuMdMwXk0sdWR8vGtcvIW6r7EGpg==
X-Received: by 2002:a17:907:6d8c:b0:731:6c60:eced with SMTP id sb12-20020a1709076d8c00b007316c60ecedmr11032948ejc.266.1662751232717;
        Fri, 09 Sep 2022 12:20:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709063b5300b0074134543f82sm648713ejf.90.2022.09.09.12.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 12:20:32 -0700 (PDT)
Message-ID: <0a3cc313-2f7d-ed99-392f-92cad2838a1d@redhat.com>
Date:   Fri, 9 Sep 2022 21:20:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/2] drivers/platform: toshiba_acpi: Call
 HCI_PANEL_POWER_ON on resume on some models
Content-Language: en-US
To:     Arvid Norlander <lkml@vorpal.se>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20220909153239.34606-1-hdegoede@redhat.com>
 <ee77aadf-8adc-c812-55ae-c534fb523de5@vorpal.se>
 <cc8ae460-9ebd-6c47-a938-eb515ce42104@redhat.com>
 <de8a1f37-414d-3a06-0b56-54b0daa4a250@vorpal.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <de8a1f37-414d-3a06-0b56-54b0daa4a250@vorpal.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/9/22 20:32, Arvid Norlander wrote:
> Hi,
> 
> On 2022-09-09 19:42, Hans de Goede wrote:
>> Hi,
>>
>> On 9/9/22 19:29, Arvid Norlander wrote:
>>> Hi,
>>>
>>> Given the changes, do you want me to test this again? If so, on what branch?
>>
>> I have just pushed this new version + all your pending toshiba_acpi patches
>> to my review-hans branch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans\
>>
>> If you can give this branch a quick test and let me know if everything works
>> as expected that would be great.
> 
> My changes (battery charge threshold, fan HWMON support, ECO LED work as
> expected.
> 
> Display does come on after resume. Unfortunately the computer also
> completely locks up (I can't even switch from X to a VT). SSH is dead.
> When I suspend with a VT active the cursor is no longer blinking on resume.
> So something else is severly broken in this version and I cannot fully test
> this.
> 
> I notice your tree is based on rc1. I was previously testing with 5.19 as
> well as rc2 and newer. Is it possible this is a bug from mainline?

Ah yes, sorry about that. There is a scsi bug which causes any sata
disks to become inaccessible after suspend/resume in rc1.

If you cherry pick this commit on top of my tree the problem should be gone:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=785538bfdd682c8e962341d585f9b88262a0475e

> Or is
> it something introduced by your tree? I'm wondering it it would be easier
> to first rebase your tree on the latest RC rather than trying to bisect it
> as is.
> 
> Or the easiest test is perhaps: Does suspend and resume with this tree work
> on your computer? I remember hearing that there were SATA issues in early
> 6.0-rcs (don't remember the details), the Toshiba uses mSATA.

Right, see above.

Regards,

Hans

