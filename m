Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63B8678308
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 18:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjAWRZy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 12:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjAWRZt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 12:25:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63375527B
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 09:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674494704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wz1OQUv/j5OjNY7PR057jS3xXH6p04f6vsRF7QSNmRE=;
        b=Z/Qm8ttivyoh+0wD15d9XR/5pxZekbEsBqtGcFCd0IAZpKe1KyBD1RmCVwADjNDzanrW2n
        /YL03RdBliB5VnWbhE+crs1IHmafGfHT+oe1GpggGbFU/MSxYycwmUV0TqlvWL0czrJb/u
        nqHw5FBh7RsAUxFlkuwMkOOJfyqnZWA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-390-S-Mm1LNHNHy__oSGbTs8_A-1; Mon, 23 Jan 2023 12:25:03 -0500
X-MC-Unique: S-Mm1LNHNHy__oSGbTs8_A-1
Received: by mail-ed1-f69.google.com with SMTP id z2-20020a056402274200b0049e48d86760so8858710edd.4
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 09:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz1OQUv/j5OjNY7PR057jS3xXH6p04f6vsRF7QSNmRE=;
        b=r2d5Fyx4di97AOxZiumGtrjKzNVJgkEme0G0L40wICFAoKVqw/VbeqxCi4XMrlVtii
         I0TtGZrISzGy7IfPXNmHiWURIQaKSKp5WzJmtS3/b4XxSFFncarhBRtT68OFwL8KN3FE
         Y4m6Iwr1l61hGPVeX2xdRxSCkmjaZLGnb7lfrZ84xgp+r/IHfQH2rgM8y3/EIuz0EJ6Q
         +8acAZvuWfIzfttiY2OWDTvIRR8orsjqvAZFmFFMVsewbDTd2RLr6CXW7m5yroeFgBcK
         kVMyhEvVxBrcD0PKzDBslFJl8f8cCfeKPP9bvJlQilrTlcYC7MPPoW3yVtAaLJhwMqXu
         LpJw==
X-Gm-Message-State: AFqh2kqOvg5Ss/NdxGQwAOyK+DlDN5qY8m67XVxNLGVtseyQp+x0eYVu
        RLrQCkmL70Sli5Kj5zID7Fu4W+JYgldQHvRqgxqpJnZpsLMMSYrn3xJMz1I8VoUSq1oCcwlGzZp
        sb7+i/Dx7QuY+ScIfVhdekg==
X-Received: by 2002:a05:6402:449a:b0:499:d1ca:6d83 with SMTP id er26-20020a056402449a00b00499d1ca6d83mr27093099edb.2.1674494702201;
        Mon, 23 Jan 2023 09:25:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXto0/TI8VlAL9+qXM0cqei21dkUh2muTMa11VUJgwp1CxCZyNK/3zVFo3HmcngnDhSqA+SGCw==
X-Received: by 2002:a05:6402:449a:b0:499:d1ca:6d83 with SMTP id er26-20020a056402449a00b00499d1ca6d83mr27093095edb.2.1674494701995;
        Mon, 23 Jan 2023 09:25:01 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u9-20020aa7d889000000b00457b5ba968csm21625416edq.27.2023.01.23.09.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 09:25:01 -0800 (PST)
Message-ID: <7c0ae129-a737-5b7a-ed28-9a597d4170b8@redhat.com>
Date:   Mon, 23 Jan 2023 18:25:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/3] ACPI: video: Fix apple gmux detection
Content-Language: en-US, nl
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Mark Gross <mgross@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20230123113750.462144-1-hdegoede@redhat.com>
 <20230123113750.462144-4-hdegoede@redhat.com>
 <CAHp75VeKfVVxfcWkiz1oHigryNNAy1PZYbbfh+OycViODV-jHg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VeKfVVxfcWkiz1oHigryNNAy1PZYbbfh+OycViODV-jHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On 1/23/23 17:37, Andy Shevchenko wrote:
> On Mon, Jan 23, 2023 at 1:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Some apple laptop models have an ACPI device with a HID of APP000B
>> and that device has an IO resource (so it does not describe the new
>> unsupported MMIO based gmux type), but there actually is no gmux
>> in the laptop at all.
>>
>> The gmux_probe() function of the actual apple-gmux driver has code
>> to detect this, this code has been factored out into a new
>> apple_gmux_detect() helper in apple-gmux.h.
>>
>> Use this new function to fix acpi_video_get_backlight_type() wrongly
>> returning apple_gmux as type on these new laptops.
> 
> ...
> 
>> -static bool apple_gmux_backlight_present(void)
>> -{
>> -       struct acpi_device *adev;
>> -       struct device *dev;
>> -
>> -       adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
>> -       if (!adev)
>> -               return false;
>> -
>> -       dev = acpi_get_first_physical_node(adev);
>> -       if (!dev)
>> -               return false;
>> -
>> -       /*
>> -        * drivers/platform/x86/apple-gmux.c only supports old style
>> -        * Apple GMUX with an IO-resource.
>> -        */
>> -       return pnp_get_resource(to_pnp_dev(dev), IORESOURCE_IO, 0) != NULL;
>> -}
> 
> Oh, the leak is already somewhere... Lemme cook a patch...

This code is very likely going away, with a Fixes tag
for the original commit which introduced it.

So IMHO it is best to let the leak be (I will fix it
in the replacement in this patch-set).

This patch-set fixes an actual regression and is intended
for stable. So also having a leak fix "flying around" is
only going to confuse things.

Regards,

Hans


