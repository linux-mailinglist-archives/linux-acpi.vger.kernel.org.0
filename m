Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027144D860E
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 14:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiCNNii (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 09:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbiCNNih (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 09:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C79F225C59
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647265045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fxHoNeE11W8hZyweHGUIsGptY2J5j/f4BYmmeyPExsU=;
        b=ULyO6jJdvq2z4KUbfchChcx93VqAS3lZYKWR2GWrokmsx6wHwGdebAgXTjBSi5Ak4t5pPj
        skxrPBkjo9AJxxZ9bwyvdQ8e9o0yWB2J+w+jQERXbydLdhAHYx+XpOGIXwTyouOJKV95UP
        +Fa5X5mmqitTywWhJQIDOu+MlAFZmbI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-2_mrIHE2OG2jRE869nLP8w-1; Mon, 14 Mar 2022 09:37:24 -0400
X-MC-Unique: 2_mrIHE2OG2jRE869nLP8w-1
Received: by mail-ed1-f70.google.com with SMTP id b24-20020a50e798000000b0041631767675so8757494edn.23
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 06:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fxHoNeE11W8hZyweHGUIsGptY2J5j/f4BYmmeyPExsU=;
        b=Uy9L329pVafZEyLv0WJWBPXzBFSbuy7aWjAAf4VPXZ8/Z/Vs1mCBdX57Fab4LEB2gp
         nosM2llxUc+2G49tGmV3xsAwR9/c3sROp4lqTe52TAk65M5hlieFV6FpxlfJMN4EpeDn
         WjWI0kCtFuUrtr+56/Wx5zB5Lq5KI79zyfx05HOnV9EsAVNaOpOTTQw984VGZrZR/fIC
         96oMJgS9JKImZH3Vw4OUFOAsLY2zUbcE7s0iCpSNkZ4l2bKLlgpomm+wlvrSHCYBqHLX
         WFHByLS0u/Uu29FkVakQHM2ZNnMbS4t76IKPQTOsEOGAE1WdWJVNeUAU85eD7epCh8Jk
         9gjg==
X-Gm-Message-State: AOAM531QOFs+75US7ILhuopNTVfIuNGJXo7w5XGsrWAKssLWhBQM6Tvk
        T1USZCd4Zq+ZxUXY5Dhc6g0bk4ATVSO2y3N898UZ2BjKbAkJLvcx7Z1B2EGNOrKjStOTGrqH76f
        pLR6fwXI2k65PMwHFcj7FDw==
X-Received: by 2002:a17:906:a1c8:b0:6da:a635:e402 with SMTP id bx8-20020a170906a1c800b006daa635e402mr19257810ejb.598.1647265041472;
        Mon, 14 Mar 2022 06:37:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygu5xZgHzaUkqPTc0AEg9k3BjV/RsxnBWm69P8qGX5Z8pyo6g3n1veNX1GSs2iGsfGeri5NQ==
X-Received: by 2002:a17:906:a1c8:b0:6da:a635:e402 with SMTP id bx8-20020a170906a1c800b006daa635e402mr19257796ejb.598.1647265041246;
        Mon, 14 Mar 2022 06:37:21 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id t22-20020a056402525600b00416cb5fdc56sm6029324edd.57.2022.03.14.06.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 06:37:20 -0700 (PDT)
Message-ID: <8841ecb6-6c2c-164f-76df-54c4410faa20@redhat.com>
Date:   Mon, 14 Mar 2022 14:37:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>
References: <20220314050340.1176-1-mario.limonciello@amd.com>
 <0101142d-3ea6-a47b-be26-76aaaac46b0a@redhat.com>
 <BL1PR12MB5157664C2AA7D80E7DF48EC9E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BL1PR12MB5157664C2AA7D80E7DF48EC9E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/14/22 14:32, Limonciello, Mario wrote:
> [Public]
> 
>>> +int acpi_register_lps0_callbacks(struct lps0_callback_handler *arg)
>>> +{
>>> +	struct lps0_callback_handler *handler;
>>> +
>>> +	if (!lps0_device_handle || sleep_no_lps0)
>>> +		return -ENODEV;
>>> +
>>> +	handler = kmalloc(sizeof(*handler), GFP_KERNEL);
>>> +	if (!handler)
>>> +		return -ENOMEM;
>>> +	handler->prepare_late_callback = arg->prepare_late_callback;
>>> +	handler->restore_early_callback = arg->restore_early_callback;
>>> +	handler->context = arg->context;
>>> +
>>> +	mutex_lock(&lps0_callback_handler_mutex);
>>> +	list_add(&handler->list_node, &lps0_callback_handler_head);
>>> +	mutex_unlock(&lps0_callback_handler_mutex);
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(acpi_register_lps0_callbacks);
>>
>> Typically with calls like these we simply let the caller own the struct
>> lps0_callback_handler
>> and only make the list_add() call here. Typically the struct
>> lps0_callback_handler will
>> be embedded in the driver_data of the driver registering the handler and it
>> will
>> call the unregister function before free-ing its driver_data.
>>
> 
> When I put this together I was modeling it off of `struct acpi_wakeup_handler`
> which the handling and the use in the kernel doesn't seem to follow the design pattern
> you describe.

Ah, fair enough. Whatever Rafael prefers works for me.

I pointed this out, because making this change would also make 4/5 a bit
cleaner. You are recreating the same struct lps0_callback_handler on
stack twice there, which looked weird to me.

Note if Rafael wants to stick with the approach from this v3, then
I guess that the approach in 4/5 is fine. 
> Rafael - can you please confirm which direction you want to see here for this?

Regards,

Hans



> 
>>> +
>>> +void acpi_unregister_lps0_callbacks(struct lps0_callback_handler *arg)
>>> +{
>>> +	struct lps0_callback_handler *handler;
>>> +
>>> +	mutex_lock(&lps0_callback_handler_mutex);
>>> +	list_for_each_entry(handler, &lps0_callback_handler_head,
>> list_node) {
>>> +		if (handler->prepare_late_callback == arg-
>>> prepare_late_callback &&
>>> +		    handler->restore_early_callback == arg-
>>> restore_early_callback &&
>>> +		    handler->context == arg->context) {
>>> +			list_del(&handler->list_node);
>>> +			kfree(handler);
>>> +			break;
>>> +		}
>>> +	}
>>> +	mutex_unlock(&lps0_callback_handler_mutex);
>>> +}
>>> +EXPORT_SYMBOL_GPL(acpi_unregister_lps0_callbacks);
>>
>> And this then becomes just lock, list_del, unlock.
>>
>> Regards,
>>
>> Hans

