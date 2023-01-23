Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE3A677DBB
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 15:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjAWOOQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 09:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAWOOP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 09:14:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AC1211F
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 06:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674483212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZz8BdgK6sfUTOZKhpEpXLCQ+Rw2U6B6i+6N1kI3VuM=;
        b=AJoFY6XdzUWbLN+czcjfEBCcrB2GqH1b6ppIDAv1DuO1XkYZARPWkDVluTTrYeCtBwKCWc
        vhpoeX0bUqQsJQ0MAMZPFR+af0J/Ld6yOUKaPEGtpQSKCYhpqrsjcbDBzxmOOpBqbZxmQX
        xC/vL3ICN8WbBEETzzNNPhoCdN14dnQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-58-lE8UOl4TP6CbV41UgkSbjg-1; Mon, 23 Jan 2023 09:13:31 -0500
X-MC-Unique: lE8UOl4TP6CbV41UgkSbjg-1
Received: by mail-ed1-f70.google.com with SMTP id y20-20020a056402271400b0046c9a6ec30fso8539111edd.14
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 06:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZz8BdgK6sfUTOZKhpEpXLCQ+Rw2U6B6i+6N1kI3VuM=;
        b=1lDCM2o2g21FRPDorVRer9aCYizcBsW2t2WAAf7wJE0Y1Ov89+jzrGBfWP47HxhFmU
         8xLCKdRO+jFW32q6xXae9XB3d3WjEAV7wIFIpkwPKd4Qhbqd2iukng67OMCFeXjsYeV0
         5u/Yv3CPzFjA/CS3MgWmSDw6uhmtd5bvQSX4iqOA3EzirQhso//qakHK6QWgLRkP1wkj
         64WLgYXIL2YHdtj4k+II6wwExcsfgi2Am+d5rxwW6AYOky66gUFTAFVXky+vK/arS66P
         Q2j5YfulB6eEi7lGGm3F0nDvlCNyeUCUENe0FmSmQz3UNTTutXk02v/38CiJKSt7XW7b
         bATA==
X-Gm-Message-State: AFqh2kqW9JfL/qBihBr0EpYHeft7pa9LPNfYhg+syEj3yZSiqEnrqGdB
        07/VjyEe+696w+uiFmg05Ujy8kmtWoYKKuF2XJB+akJtYfn7hFHYf2836Bx2kDfstmZ/KzVQWhB
        1dFSEf3kRqwfVnHcaJq9nCQ==
X-Received: by 2002:a17:906:d8ad:b0:875:54f5:740d with SMTP id qc13-20020a170906d8ad00b0087554f5740dmr23339706ejb.51.1674483209986;
        Mon, 23 Jan 2023 06:13:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuQD/A1S0YXI4aZxUABdzViHzZGEd90qIw7pFjkej8e/nIub+qc2Edhv5J5Uuht+tjXoLGtrQ==
X-Received: by 2002:a17:906:d8ad:b0:875:54f5:740d with SMTP id qc13-20020a170906d8ad00b0087554f5740dmr23339686ejb.51.1674483209785;
        Mon, 23 Jan 2023 06:13:29 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b00770812e2394sm19853759ejg.160.2023.01.23.06.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 06:13:29 -0800 (PST)
Message-ID: <9fc84f34-669e-a89c-52d9-c714fe8e4e49@redhat.com>
Date:   Mon, 23 Jan 2023 15:13:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/3] platform/x86: apple-gmux: Add apple_gmux_detect()
 helper
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-acpi@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20230123113750.462144-1-hdegoede@redhat.com>
 <20230123113750.462144-3-hdegoede@redhat.com>
 <20230123134907.GA2649@wunner.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230123134907.GA2649@wunner.de>
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

Hi,

On 1/23/23 14:49, Lukas Wunner wrote:
> On Mon, Jan 23, 2023 at 12:37:49PM +0100, Hans de Goede wrote:
>> --- a/include/linux/apple-gmux.h
>> +++ b/include/linux/apple-gmux.h
> [...]
>> +static inline bool apple_gmux_is_indexed(unsigned long iostart)
>> +{
>> +	u16 val;
>> +
>> +	outb(0xaa, iostart + 0xcc);
>> +	outb(0x55, iostart + 0xcd);
>> +	outb(0x00, iostart + 0xce);
>> +
>> +	val = inb(iostart + 0xcc) | (inb(iostart + 0xcd) << 8);
>> +	if (val == 0x55aa)
>> +		return true;
>> +
>> +	return false;
>> +}
> 
> Something like this, and especially the large apple_gmux_detect() below,
> should not live in a header file.

I understand where you are coming from, but these functions really
are not that large.

> Why can't apple_gmux.ko just export a detection function which is used
> both internally and as a helper by the backlight detection?

Both the acpi-video code and the apple-gmux code can be built as
modules. So this will break if the acpi-video code get builtin
and the apple-gmux code does not.

This can be worked around in Kconfig by adding something like:

	depends on APPLE_GMUX || APPLE_GMUX=n

to the ACPI_VIDEO Kconfig bits and then cross our fingers
we don't get some Kconfig circular dep thing causing things
to error out.

The whole idea behind the video-detect.c code is that it does
as little as possible to figure out which backlight control
method to use. It e.g. on purpose does not depend on
the GPU drivers to see if native GPU backlight control is
available that would bring in a whole lot of dependencies.

So the do not depend on other kernel-modules / driver-code
is part of the design of video-detect.c (in so far as it
was ever designed, since it also very much has organically
grown / evolved into its current code).

If we forgo this design principle then we evt would end
adding similar Kconfig snippets  for each backlight device-type
which the video-detect code supports this quickly gets unwieldly.

And doing this also means that video.ko now starts depending
on not just apple-gmux.ko but also on its dependencies, although
in this case that would not bring in any extra dependencies.
But for ohter types there might very well be significant
dependencies.

So waying the cons and pros here, as well as trying to be
consistent and not add dependencies on other kernel-modules
just for detection purposes, I would prefer to keep using
the static inline approach for this.

Regards,

Hans



>>  
>>  /**
>> - * apple_gmux_present() - detect if gmux is built into the machine
>> + * apple_gmux_detect() - detect if gmux is built into the machine
>> + *
>> + * @pnp_dev:     Device to probe or NULL to use the first matching device
>> + * @indexed_ret: Returns (by reference) if the gmux is indexed or not
>> + *
>> + * Detect if a supported gmux device is present by actually probing it.
>> + * This avoids the false positives returned on some models by
>> + * apple_gmux_present().
>> + *
>> + * Return: %true if a supported gmux ACPI device is detected and the kernel
>> + * was configured with CONFIG_APPLE_GMUX, %false otherwise.
>> + */
>> +static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
>> +{
>> +	u8 ver_major, ver_minor, ver_release;
>> +	struct resource *res;
>> +	bool indexed = false;
>> +
>> +	if (!pnp_dev) {
>> +		struct acpi_device *adev;
>> +		struct device *dev;
>> +
>> +		adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
>> +		if (!adev)
>> +			return false;
>> +
>> +		dev = acpi_get_first_physical_node(adev);
>> +		if (!dev)
>> +			return false;
>> +
>> +		pnp_dev = to_pnp_dev(dev);
>> +	}
>> +
>> +	res = pnp_get_resource(pnp_dev, IORESOURCE_IO, 0);
>> +	if (!res)
>> +		return false;
>> +
>> +	if (resource_size(res) < GMUX_MIN_IO_LEN)
>> +		return false;
>> +
>> +	/*
>> +	 * Invalid version information may indicate either that the gmux
>> +	 * device isn't present or that it's a new one that uses indexed io.
>> +	 */
>> +	ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
>> +	ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
>> +	ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
>> +	if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
>> +		indexed = apple_gmux_is_indexed(res->start);
>> +		if (!indexed)
>> +			return false;
>> +	}
>> +
>> +	if (indexed_ret)
>> +		*indexed_ret = indexed;
>> +
>> +	return true;
>> +}
>> +
>> +/**
>> + * apple_gmux_present() - check if gmux ACPI device is present
>>   *
>>   * Drivers may use this to activate quirks specific to dual GPU MacBook Pros
>>   * and Mac Pros, e.g. for deferred probing, runtime pm and backlight.
>>   *
>> - * Return: %true if gmux is present and the kernel was configured
>> + * Return: %true if gmux ACPI device is present and the kernel was configured
>>   * with CONFIG_APPLE_GMUX, %false otherwise.
>>   */
>>  static inline bool apple_gmux_present(void)
>> @@ -57,6 +133,11 @@ static inline bool apple_gmux_present(void)
>>  	return false;
>>  }
>>  
>> +static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
>> +{
>> +	return false;
>> +}
>> +
>>  #endif /* !CONFIG_APPLE_GMUX */
>>  
>>  #endif /* LINUX_APPLE_GMUX_H */
>> -- 
>> 2.39.0
> 

