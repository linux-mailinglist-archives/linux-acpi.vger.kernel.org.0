Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346F14D7E18
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 10:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiCNJGz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 05:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiCNJGy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 05:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70D333B00B
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 02:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647248744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNnakkfdJ9Lasc1IoOcW9kwJRw1PdtrjHI5Z6u5ZFUA=;
        b=KQ+BoIIHii1omIexc33fckcfHVyRG2femUb3yWYBqvfaK/9YUcmeCsQ73n7yykktToPblc
        MUsi6UNVfn4y2yIUzERl68+lbcD2EvHKXW6QKcsnK1JshG6VQXZ89T6GWFwTyKtL4gJa04
        11mCKXS5DQvnOZ9ugSCjSAwJbND1TxE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-Kmn8-0lpM5uS4WZTWRw4NA-1; Mon, 14 Mar 2022 05:05:43 -0400
X-MC-Unique: Kmn8-0lpM5uS4WZTWRw4NA-1
Received: by mail-ed1-f72.google.com with SMTP id o20-20020aa7dd54000000b00413bc19ad08so8314535edw.7
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 02:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mNnakkfdJ9Lasc1IoOcW9kwJRw1PdtrjHI5Z6u5ZFUA=;
        b=361KgNVu/riJhduhISYT0oMzqXg6aSQdpeREBTV7PDMuiNE42q5iU0FIrUjCmHY+k8
         Fii6wogn8+6KSim+UbV7kqO3c4L1L0MsI0/+cQC0eZsUs/kk+xE2PXMqXsWRVg5h22Oq
         +cPSj0/3QPNqHJi44hlMfJbXLEE5pfYs74FbdTyIK35v6MHkw8JaXlM20cyeyJ2A8b/l
         mdqfYWTzQYYh8KxKmzEjXR6m+kKeXDuJEIKkY9G41UNiaHDhcz/wECMbP3SRwj0MlLkc
         4dKB41wuPc9aNpf+nvKstv7oAGdUFGtM/sm6HcelAf5wiX3cFtGu2eZ5ClbsVbCQ2Q2K
         5s6w==
X-Gm-Message-State: AOAM530XOP1B6EvhwbRvWmDZuzEujjqDIMtc70KLj5iqGbpINwPenEqp
        luMtzJCRvJbu9LJ5loIfd61eTs3Oc9RwmNpcCKuzQVr8kOU/YmsEBn50v+MLLLV6xYbCRHMvUKx
        bNnzzd6t43WOkHZttIqoNLQ==
X-Received: by 2002:a17:907:76f7:b0:6d6:e922:3cd with SMTP id kg23-20020a17090776f700b006d6e92203cdmr18758156ejc.386.1647248741542;
        Mon, 14 Mar 2022 02:05:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwDoN5p+KQEZBjs/1BJJWj6wOW+Balpf52Eb89m2VsM10UseT41DvX6VtOfZI1GlUNW2ONyw==
X-Received: by 2002:a17:907:76f7:b0:6d6:e922:3cd with SMTP id kg23-20020a17090776f700b006d6e92203cdmr18758137ejc.386.1647248741250;
        Mon, 14 Mar 2022 02:05:41 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id w15-20020a056402268f00b00416474fbb42sm7666124edd.19.2022.03.14.02.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 02:05:40 -0700 (PDT)
Message-ID: <0101142d-3ea6-a47b-be26-76aaaac46b0a@redhat.com>
Date:   Mon, 14 Mar 2022 10:05:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, linux-acpi@vger.kernel.org,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Goswami Sanket <Sanket.Goswami@amd.com>
References: <20220314050340.1176-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220314050340.1176-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mario,

On 3/14/22 06:03, Mario Limonciello wrote:
> Currenty the latest thing run during a suspend to idle attempt is
> the LPS0 `prepare_late` callback and the earliest thing is the
> `resume_early` callback.
> 
> There is a desire for the `amd-pmc` driver to suspend later in the
> suspend process (ideally the very last thing), so create a callback
> that it or any other driver can hook into to do this.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> changes from v2->v3:
>  * Check that callbacks exist before calling
> changes from v1->v2:
>  * Change register/unregister arguments to be struct
> 
>  drivers/acpi/x86/s2idle.c | 68 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/acpi.h      | 11 ++++++-
>  2 files changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index abc06e7f89d8..69008c4a86ea 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -86,6 +86,9 @@ struct lpi_device_constraint_amd {
>  	int min_dstate;
>  };
>  
> +static LIST_HEAD(lps0_callback_handler_head);
> +static DEFINE_MUTEX(lps0_callback_handler_mutex);
> +
>  static struct lpi_constraints *lpi_constraints_table;
>  static int lpi_constraints_table_size;
>  static int rev_id;
> @@ -444,6 +447,9 @@ static struct acpi_scan_handler lps0_handler = {
>  
>  int acpi_s2idle_prepare_late(void)
>  {
> +	struct lps0_callback_handler *handler;
> +	int rc = 0;
> +
>  	if (!lps0_device_handle || sleep_no_lps0)
>  		return 0;
>  
> @@ -474,14 +480,34 @@ int acpi_s2idle_prepare_late(void)
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
>  				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
>  	}
> -	return 0;
> +
> +	mutex_lock(&lps0_callback_handler_mutex);
> +	list_for_each_entry(handler, &lps0_callback_handler_head, list_node) {
> +		if (handler->prepare_late_callback) {
> +			rc = handler->prepare_late_callback(handler->context);
> +			if (rc)
> +				goto out;
> +		}
> +	}
> +out:
> +	mutex_unlock(&lps0_callback_handler_mutex);
> +
> +	return rc;
>  }
>  
>  void acpi_s2idle_restore_early(void)
>  {
> +	struct lps0_callback_handler *handler;
> +
>  	if (!lps0_device_handle || sleep_no_lps0)
>  		return;
>  
> +	mutex_lock(&lps0_callback_handler_mutex);
> +	list_for_each_entry(handler, &lps0_callback_handler_head, list_node)
> +		if (handler->restore_early_callback)
> +			handler->restore_early_callback(handler->context);
> +	mutex_unlock(&lps0_callback_handler_mutex);
> +
>  	/* Modern standby exit */
>  	if (lps0_dsm_func_mask_microsoft > 0)
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
> @@ -524,4 +550,44 @@ void acpi_s2idle_setup(void)
>  	s2idle_set_ops(&acpi_s2idle_ops_lps0);
>  }
>  
> +int acpi_register_lps0_callbacks(struct lps0_callback_handler *arg)
> +{
> +	struct lps0_callback_handler *handler;
> +
> +	if (!lps0_device_handle || sleep_no_lps0)
> +		return -ENODEV;
> +
> +	handler = kmalloc(sizeof(*handler), GFP_KERNEL);
> +	if (!handler)
> +		return -ENOMEM;
> +	handler->prepare_late_callback = arg->prepare_late_callback;
> +	handler->restore_early_callback = arg->restore_early_callback;
> +	handler->context = arg->context;
> +
> +	mutex_lock(&lps0_callback_handler_mutex);
> +	list_add(&handler->list_node, &lps0_callback_handler_head);
> +	mutex_unlock(&lps0_callback_handler_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_register_lps0_callbacks);

Typically with calls like these we simply let the caller own the struct lps0_callback_handler
and only make the list_add() call here. Typically the struct lps0_callback_handler will
be embedded in the driver_data of the driver registering the handler and it will
call the unregister function before free-ing its driver_data.

> +
> +void acpi_unregister_lps0_callbacks(struct lps0_callback_handler *arg)
> +{
> +	struct lps0_callback_handler *handler;
> +
> +	mutex_lock(&lps0_callback_handler_mutex);
> +	list_for_each_entry(handler, &lps0_callback_handler_head, list_node) {
> +		if (handler->prepare_late_callback == arg->prepare_late_callback &&
> +		    handler->restore_early_callback == arg->restore_early_callback &&
> +		    handler->context == arg->context) {
> +			list_del(&handler->list_node);
> +			kfree(handler);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&lps0_callback_handler_mutex);
> +}
> +EXPORT_SYMBOL_GPL(acpi_unregister_lps0_callbacks);

And this then becomes just lock, list_del, unlock.

Regards,

Hans



> +
>  #endif /* CONFIG_SUSPEND */
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6274758648e3..df105f5e03e5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1023,7 +1023,16 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
>  
>  acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>  					   u32 val_a, u32 val_b);
> -
> +#ifdef CONFIG_X86
> +struct lps0_callback_handler {
> +	struct list_head list_node;
> +	int (*prepare_late_callback)(void *context);
> +	void (*restore_early_callback)(void *context);
> +	void *context;
> +};
> +int acpi_register_lps0_callbacks(struct lps0_callback_handler *arg);
> +void acpi_unregister_lps0_callbacks(struct lps0_callback_handler *arg);
> +#endif /* CONFIG_X86 */
>  #ifndef CONFIG_IA64
>  void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
>  #else

