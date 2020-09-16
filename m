Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95E326C69C
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 19:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgIPRzX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Sep 2020 13:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbgIPRy3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Sep 2020 13:54:29 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49216C0612F2;
        Wed, 16 Sep 2020 10:54:17 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i1so7238433edv.2;
        Wed, 16 Sep 2020 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n6mrIADyrBQbnLtXXBKUK1oHgyD2rX/EbKv+Og9Z66w=;
        b=MdWmtSxZ+/68Ef3OJpum0X3G5xJJrhYtIiumYYkzc+XTHdRp/DkXrsl3PvSQehD5pb
         N1eMlGDqFrgXueip3v4h8gw+AnGOw6G27Z47a3AshPiEOWiLphhTX2DqrSRTuBHD7thd
         1q9ZVSETqbF63QHQiFkjPiVKziaZF6pN9W3Xov4LtKt8xKa2z2mIOJDqobST5N/k6jDC
         kubpg/9lhrVzCWBhlAP5QenZ6Ob2D/3efN7HFsbIlU+JdjtrsSuzSUyAiSNhhHv92Q+o
         G3dY/aVazEzUZJh1XUkMhguw3XwrOFB6ikhTQ1KGwHfDMRifWW0qoeZcp967xj6HeOsb
         WvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n6mrIADyrBQbnLtXXBKUK1oHgyD2rX/EbKv+Og9Z66w=;
        b=psE2VmH+yK2oxmgRP4RjzwFYwJ76fD+FrjYfWGmdoPXFvCB/aYRzymzIa4NnSVzro5
         FaULukMq2P7b8w427wg4jIiupGdKh3mUM4ix+oaOPe9RJmeTR3ha8l78y4Q7oDy5YFNO
         LFhjBF4G0TETTCeWXAsN/VImY3Hvbm/ZuqPr9RQMBvzMPRfJQxCN7kkbqfgg9Vr/os27
         cyc1Z+Zn+qSZtxnpAi2/clx6j4gH1xFeuO/iXEJYmQmu0IVM4hSyVJCakqoexveKBSAG
         /6bEWduna0a7/0GoBk5anGO3xvjdLdEFsmioJrNhtC8KiVuob+EAgM3r4aVnG5zt0Gi3
         T6gw==
X-Gm-Message-State: AOAM5319H0zcBxf5jzXfbVzv5eyq8pkbqIzjUQdniqSZsUgEBRTJRKNO
        RQ+iV1mQY//3G82Ma2OtSF2mYEZ5+yc=
X-Google-Smtp-Source: ABdhPJz6K38IuTDuacte2yOGDB9aBjUsB2njf/w905tVCZsdCiBTMF524UByyDaDyC5CQtoHej56uA==
X-Received: by 2002:aa7:cb44:: with SMTP id w4mr29216973edt.139.1600278855258;
        Wed, 16 Sep 2020 10:54:15 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a4ba.dip0.t-ipconnect.de. [217.229.164.186])
        by smtp.gmail.com with ESMTPSA id si28sm13083691ejb.95.2020.09.16.10.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 10:54:14 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: Add Driver to set up lid GPEs on MS
 Surface device
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200910211520.1490626-1-luzmaximilian@gmail.com>
 <EMZQgUl1xLN4o0hV9ZkCD563O85SuOYB5kNFZ5_hlxLQXbJCXpQfrM2afyFIr28h31tXMxD1mxE4DkA5Wy60A0Z2mDnstwF17tEdnX4IRas=@protonmail.com>
 <355dae14-2508-706b-53f8-48b78f84e7cc@gmail.com>
 <ID5eml6LsB6tCDrZwhbfin228LE3cor6ZEYbAHj6C3SZ9y0AcL40SWweP-iAjmEpCeEV5NZHJLKBpUo5qw1VR0Q7xOXAVSH7epRjTRkj64Y=@protonmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <5fe41f91-068e-9da8-8308-d71061d378bd@gmail.com>
Date:   Wed, 16 Sep 2020 19:54:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ID5eml6LsB6tCDrZwhbfin228LE3cor6ZEYbAHj6C3SZ9y0AcL40SWweP-iAjmEpCeEV5NZHJLKBpUo5qw1VR0Q7xOXAVSH7epRjTRkj64Y=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/16/20 7:13 PM, Barnabás Pőcze wrote:
...
>>>> +	}s
>>>> +
>>>> +	return 0;
>>>> +}
>>>> [...]
>>>> +static int surface_gpe_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct surface_lid_device *lid;
>>>> +	u32 gpe_number;
>>>> +	int status;
>>>> +
>>>> +	status = device_property_read_u32(&pdev->dev, "gpe", &gpe_number);
>>>> +	if (status)
>>>> +		return -ENODEV;
>>>
>>> 'device_property_read_u32()' returns an error code, you could simply return that
>>> instead of hiding it.
>>
>> My thought there was that if the "gpe" property isn't present or of a
>> different type, this is not a device that we want to/can handle. Thus
>> the -ENODEV. Although I think a debug print statement may be useful
>> here.
>>
> 
> I see, I just wanted to bring to your attention that 'device_property_read_u32()'
> returns various standard error codes and you could simply return those.

I think one could also argue that module-loading should have taken care
of filtering out devices that we don't load on, so -ENODEV would be
redundant here. At least if one neglects that a user could try to
manually bind the driver to a device. Following that thought, I guess it
makes more sense to return the actual value here.

>> [...]
>>>> +
>>>> +	lid->gpe_number = gpe_number;
>>>> +	platform_set_drvdata(pdev, lid);
>>>> +
>>>> +	status = surface_lid_enable_wakeup(&pdev->dev, false);
>>>> +	if (status) {
>>>> +		acpi_disable_gpe(NULL, gpe_number);
>>>> +		platform_set_drvdata(pdev, NULL);
>>>
>>> Why is 'platform_set_drvdata(pdev, NULL)' needed?
>>
>> Is this not required for clean-up once the driver data has been set? Or
>> does the driver-base take care of that for us when the driver is
>> removed/fails to probe? My reasoning was that I don't want to leave
>> stuff around for any other driver to trip on (and rather have that
>> driver oops on a NULL-pointer). If the driver-core already takes care of
>> NULL-ing that, that line is not needed. Unfortunately that behavior
>> doesn't seem to be explained in the documentation.
>>
> 
> I'm not aware that it would be required. As a matter of fact, only two x86
> platform drivers (intel_pmc_core, ideapad-laptop) do any cleanup of driver data.
> There are much more hits (536) for "set_drvdata(.* NULL" when scanning all drivers.
> There are 4864 hits for "set_drvdata(.*" that have no 'NULL' in them.
> 
> There is drivers/base/dd.c:really_probe(), which seems to be the place where driver
> probes are actually called. And it calls 'dev_set_drvdata(dev, NULL)' if the probe
> fails. And it also sets the driver data to NULL in '__device_release_driver()',
> so I'm pretty sure the driver core takes care of it.

I see, thanks! Would make sense that the core takes care of that.

>>>> +		return status;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>> [...]
>>>> +static int __init surface_gpe_init(void)
>>>> +{
>>>> +	const struct dmi_system_id *match;
>>>> +	const struct property_entry *props;
>>>> +	struct platform_device *pdev;
>>>> +	struct fwnode_handle *fwnode;
>>>> +	int status;
>>>> +
>>>> +	match = dmi_first_match(dmi_lid_device_table);
>>>> +	if (!match) {
>>>> +		pr_info(KBUILD_MODNAME": no device detected, exiting\n");
>>>
>>> If you put
>>>    #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>> before including any headers, you can simply write 'pr_info("no device...")' and it'll
>>> be prefixed by the module name. This is the "usual" way of achieving what you want.
>>
>> Right, thanks!
>>
>>>> +		return 0;
>>>
>>> Shouldn't it return -ENODEV?
>>
>> How does module auto-loading behave with a -ENODEV return value in init?
>> I know that in the driver's probe callback it signals that the driver
>> isn't intended for the device. Is this the same for modules or would a
>> user get an error message in the kernel log? As I couldn't find any
>> documentation on this, I assumed it didn't behave the same and would
>> emit an error message.
>>
>> The reason I don't want to emit an error message here is that the module
>> can be loaded for devices that it's not intended (and that's not
>> something we can fix with a better MODULE_ALIAS as Microsoft cleverly
>> named their 5th generation Surface Pro "Surface Pro", without any
>> version number). Mainly, I don't want users to get a random error
>> message that doesn't indicate an actual error.
>>
> 
> I wasn't sure, so I tested it. It prints the "no device" message, but that's it,
> no more indication of the -ENODEV error in the kernel log during automatic
> module loading at boot.
> 
> You could print "no compatible Microsoft Surface device found, exitig" (or something
> similar). I think this provides enough information for any user to decide if
> they should be concerned or not.

I ran the same test (with same results) earlier today and also did some
digging: From what I can tell, udev is responsible for auto-loading and
the code doing that can be found at [1]. This code seems to, by default,
log any errors as debug output. Only in verbose mode it logs them as
error, with the exception of -ENODEV, which then is specifically logged
only as notice.

It also seems to be used by a couple of other modules this way. So I
guess that's the expected use-case for -ENODEV in module-init and pretty
much guarantees the behavior I've wanted.

[1]: https://github.com/systemd/systemd/blob/6d95e7d9b263c94e94704e3125cb790840b76ca2/src/shared/module-util.c#L58-L64

Thanks again. If there are no other comments, I'll likely submit a v3
addressing the issues tomorrow.

Regards,
Max

