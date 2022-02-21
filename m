Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695754BE8D4
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 19:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354687AbiBUKbh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Feb 2022 05:31:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354963AbiBUKar (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 05:30:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB77669CE8
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 01:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645437075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hB9b8zcCF73wPaCqrb6w4xSegPlVd9cxYTgtjhyicfw=;
        b=McEW6Q1WXf/kpgWZFcryfOuHoDm14Iec/uXv8x9s1RvhiRwmzfe23lPiKLlvNy0OaOw94z
        M5PiDnfqCBryIO85xQNOAkp6ipyVqfuuCfLnVSQRIpMbyb9csob5S652eXg3DE+B3iL87P
        f1YRi7V5HPSN79FjQwotd41UmBrR4g8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-2P7cIBcWMDeic23hfwpkUQ-1; Mon, 21 Feb 2022 04:51:14 -0500
X-MC-Unique: 2P7cIBcWMDeic23hfwpkUQ-1
Received: by mail-ed1-f71.google.com with SMTP id j29-20020a508a9d000000b00412aa79f367so7001945edj.0
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 01:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=hB9b8zcCF73wPaCqrb6w4xSegPlVd9cxYTgtjhyicfw=;
        b=ro06Y/Hcj6cO1w8sf+XBILmHeEuT4CIY8FOyCBACKJcFYvmyxRe4Qz7Z78cRe29zSz
         lxIVbngIfn9zvOi+imKusirGMmZ6F2qSGx6FEo517qPDQcUfumlib654Dy0SYGx2wh1n
         fWOiX7S9t3WsmJ162izYMA+HZ/2gq1lczINZcnUjZ5rBb54caurylE52gnZcorPtvd13
         E5x78fOYUox7yJ5nAvkkYR4GRShTxOqmN4A0Xwdxv/+/eATJGaMqbGUo/FGw40c87mR3
         hUx66tY939Dk0LoL/E8MPZW8r07mgYlHXtgd8aSKyeCwXipxjWmyxJRsrAX2IYUWKjsz
         tTOw==
X-Gm-Message-State: AOAM533u/kYy6qhNgYqXBgzo3kXeVi/+8TieXGLjoC4AJ2W9rmNkHmLT
        tioR9pDD5iwh7IHXW4WO5lf/f8erVn/UuujDG8uqSTGbtYN6qwzoNEz7l07FnZL9+NEa8WSvkQO
        s7dio2h6YKmKGlrsaJE7iPw==
X-Received: by 2002:a05:6402:11cd:b0:410:d432:2e30 with SMTP id j13-20020a05640211cd00b00410d4322e30mr20320047edw.119.1645437073036;
        Mon, 21 Feb 2022 01:51:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJye1adEJ8Kmx47qBL6X7KG+mjDUvnk5CjNgYTII8w0TE68ywE4uMzzzWMSbEL0amjS7NvTVDg==
X-Received: by 2002:a05:6402:11cd:b0:410:d432:2e30 with SMTP id j13-20020a05640211cd00b00410d4322e30mr20320028edw.119.1645437072792;
        Mon, 21 Feb 2022 01:51:12 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id c29sm4971862ejj.117.2022.02.21.01.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 01:51:12 -0800 (PST)
Message-ID: <26dfe4f3-a9b3-60dc-19a7-7707afea552b@redhat.com>
Date:   Mon, 21 Feb 2022 10:51:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/6] ACPI: scan: Add acpi_dev_get_next_consumer_dev()
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, markgross@kernel.org, robert.moore@intel.com
References: <20220216225304.53911-1-djrscally@gmail.com>
 <20220216225304.53911-2-djrscally@gmail.com>
 <74f89182-1699-f4a7-85e0-66976021913d@redhat.com>
In-Reply-To: <74f89182-1699-f4a7-85e0-66976021913d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/21/22 10:50, Hans de Goede wrote:
> Hi,
> 
> On 2/16/22 23:52, Daniel Scally wrote:
>> In commit b83e2b306736 ("ACPI: scan: Add function to fetch dependent of ACPI
>> device") we added a means of fetching the first device to declare itself
>> dependent on another ACPI device in the _DEP method. One assumption
>> in that patch was that there would only be a single consuming device,
>> but this has not held.
>>
>> Extend the functionality by adding a new function that fetches the
>> next consumer of a supplier device. We can then simplify the original
>> function by simply calling the new one.
>>
>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>> ---
>>  drivers/acpi/scan.c     | 47 ++++++++++++++++++++++++++++++++++-------
>>  include/acpi/acpi_bus.h |  2 ++
>>  2 files changed, 41 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 4463c2eda61e..b3ed664ee1cb 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -2256,9 +2256,21 @@ static void acpi_bus_attach(struct acpi_device *device, bool first_pass)
>>  		device->handler->hotplug.notify_online(device);
>>  }
>>  
>> -static int acpi_dev_get_first_consumer_dev_cb(struct acpi_dep_data *dep, void *data)
>> +static int acpi_dev_get_next_consumer_dev_cb(struct acpi_dep_data *dep, void *data)
>>  {
>> -	struct acpi_device *adev;
>> +	struct acpi_device *adev = *(struct acpi_device **)data;
>> +
>> +	/*
>> +	 * If we're passed a 'previous' consumer device then we need to skip
>> +	 * any consumers until we meet the previous one, and then NULL @data
>> +	 * so the next one can be returned.
>> +	 */
>> +	if (adev) {
>> +		if (dep->consumer == adev->handle)
>> +			*(struct acpi_device **)data = NULL;
>> +
>> +		return 0;
>> +	}
>>  
>>  	adev = acpi_bus_get_acpi_device(dep->consumer);
>>  	if (adev) {
>> @@ -2389,23 +2401,42 @@ bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
>>  EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
>>  
>>  /**
>> - * acpi_dev_get_first_consumer_dev - Return ACPI device dependent on @supplier
>> + * acpi_dev_get_next_consumer_dev - Return the next adev dependent on @supplier
>>   * @supplier: Pointer to the dependee device
>> + * @start: Pointer to the current dependent device
>>   *
>> - * Returns the first &struct acpi_device which declares itself dependent on
>> + * Returns the next &struct acpi_device which declares itself dependent on
>>   * @supplier via the _DEP buffer, parsed from the acpi_dep_list.
>>   *
>>   * The caller is responsible for putting the reference to adev when it is no
>>   * longer needed.
> 
> This bit of the help text seems to not be entirely correct, since the reference to
> start gets consumed by this, so the caller only needs to put the device when it
> does NOT pass it as start to another acpi_dev_get_next_consumer_dev call.
> 
> 
> 
>>   */
>> -struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier)
>> +struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
>> +						   struct acpi_device *start)
>>  {
>> -	struct acpi_device *adev = NULL;
>> +	struct acpi_device *adev = start;
>>  
>>  	acpi_walk_dep_device_list(supplier->handle,
>> -				  acpi_dev_get_first_consumer_dev_cb, &adev);
>> +				  acpi_dev_get_next_consumer_dev_cb, &adev);
>>  
>> -	return adev;
>> +	acpi_dev_put(start);
>> +	return adev == start ? NULL : adev;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_dev_get_next_consumer_dev);
>> +
>> +/**
>> + * acpi_dev_get_first_consumer_dev - Return ACPI device dependent on @supplier
>> + * @supplier: Pointer to the dependee device
>> + *
>> + * Returns the first &struct acpi_device which declares itself dependent on
>> + * @supplier via the _DEP buffer, parsed from the acpi_dep_list.
>> + *
>> + * The caller is responsible for putting the reference to adev when it is no
>> + * longer needed.
>> + */
>> +struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier)
>> +{
>> +	return acpi_dev_get_next_consumer_dev(supplier, NULL);
>>  }
>>  EXPORT_SYMBOL_GPL(acpi_dev_get_first_consumer_dev);
> 
> The only caller of this is skl_int3472_get_sensor_adev_and_name() IMHO it would
> be better to just move that over to acpi_dev_get_next_consumer_dev(..., NULL);
> in this same patch and just drop acpi_dev_get_first_consumer_dev() all together.
> 
> I expect this entire series to get merged through the pdx86 tree, so from
> that pov doing this should be fine..

I forgot to add: that otherwise this looks good to me, so with the above
addressed you may add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index ca88c4706f2b..8b06fef04722 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -720,6 +720,8 @@ bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const ch
>>  
>>  void acpi_dev_clear_dependencies(struct acpi_device *supplier);
>>  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
>> +struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
>> +						   struct acpi_device *start);
>>  struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier);
>>  struct acpi_device *
>>  acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const char *uid, s64 hrv);

