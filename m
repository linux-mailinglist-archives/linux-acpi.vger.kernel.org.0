Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBFB2EBE95
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jan 2021 14:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAFNZI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jan 2021 08:25:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726590AbhAFNZH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2021 08:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609939420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6g8pc80Zh88jSsalh0Ly92TU64sV883QH7QLbJdwwo4=;
        b=fWiQPFNN+3EvZJQqJkzKhvQUaKenHkE2T9smPcJ8n4vGvKuBYdaGGwrVpwLcEbj2jaAdXf
        a8my9Tmt/eyZbnt18WAui8/J2f3vm2QI6ADhP0BQN8VjA1xK/rOlyL7TTrn+k2dsc7gPUE
        x1H9SNIBjSBHC7LzyFX4PhVgWdie/0E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-f8jkPjDQO0q4tUbngtx-YA-1; Wed, 06 Jan 2021 08:23:37 -0500
X-MC-Unique: f8jkPjDQO0q4tUbngtx-YA-1
Received: by mail-ed1-f71.google.com with SMTP id dc6so1901500edb.14
        for <linux-acpi@vger.kernel.org>; Wed, 06 Jan 2021 05:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6g8pc80Zh88jSsalh0Ly92TU64sV883QH7QLbJdwwo4=;
        b=l73XRN4nP4wY2WLFmipB5efwudAM3caZHBajRb29hvzZHiTq6GjpPh17lr6JYHjTsy
         QlmEDd+cgvF6cI+pNxFBo7B0spOu4Sk0exli7WbeoyqPMNaeO6sDPP9zrINagq53wrCG
         /rkEFijKGJi3sgX2o4M42m/DGjDpXJz+C3xQbw/N4gaZnUE26VFly4BXjXs215oVthTo
         RJlCR/WM5FSYjdF+rhdyMsAJFjCoeAP2E7m0bGgiakYRXJ4dI0wSmS/5iuD1Vw2cUZng
         CLjkuRZnFkjaj5XcY4cReyng51odvAyibdahXc9o1D/09k6wP+fmGdmvT2gWlT/I9vQT
         RquA==
X-Gm-Message-State: AOAM5311LWAc4XPkTdVpKTBIy4csV8c9RIpSP9owLRUjd5hU8PznHBFT
        ZR+HCHlCTrWjc7SZ1Aau6e1lF6KJFyYJz0w0JR8N+jvMi3Fz+rJ6oltrpoXXMyFkIFjSruaK2OQ
        6bbzMHgIvILggTR/uE1lp6w==
X-Received: by 2002:a50:9f4e:: with SMTP id b72mr4023831edf.200.1609939416099;
        Wed, 06 Jan 2021 05:23:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAzKgPz1PrJOJEX3oI3C1wOhgNaawfaAx97N14SyYvsjAo5ZAkt2M9hegl6/mwshbn8246jw==
X-Received: by 2002:a50:9f4e:: with SMTP id b72mr4023817edf.200.1609939415864;
        Wed, 06 Jan 2021 05:23:35 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id e1sm1470443edk.51.2021.01.06.05.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 05:23:35 -0800 (PST)
Subject: Re: [PATCH 1/2] ACPICA: Fix race in GenericSerialBus (I2C) and GPIO
 OpRegion parameter handling
To:     "Moore, Robert" <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
References: <20201226142830.48818-1-hdegoede@redhat.com>
 <20201226142830.48818-2-hdegoede@redhat.com>
 <BYAPR11MB3256C957AA72754D07D6583F87D20@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4092ffb4-9900-19d3-2d59-40cf22553295@redhat.com>
Date:   Wed, 6 Jan 2021 14:23:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB3256C957AA72754D07D6583F87D20@BYAPR11MB3256.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/4/21 11:17 PM, Moore, Robert wrote:
> Hans,
> Could you make a pull request for this (and any related patches) on our github?

Done:

https://github.com/acpica/acpica/pull/658

Regards,

Hans



> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com> 
> Sent: Saturday, December 26, 2020 6:28 AM
> To: Rafael J . Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>; linux-acpi@vger.kernel.org; devel@acpica.org
> Subject: [PATCH 1/2] ACPICA: Fix race in GenericSerialBus (I2C) and GPIO OpRegion parameter handling
> 
> The handling of the GenericSerialBus (I2C) and GPIO OpRegions in
> acpi_ev_address_space_dispatch() passes a number of extra parameters to the address-space handler through the address-space context pointer (instead of using more function parameters).
> 
> The context is shared between threads, so if multiple threads try to call the handler for the same address-space at the same time, then a second thread could change the parameters of a first thread while the handler is running for the first thread.
> 
> An example of this race hitting is the Lenovo Yoga Tablet2 1015L, where there are both AttribBytes accesses and AttribByte accesses to the same address-space. The AttribBytes access stores the number of bytes to transfer in context->access_length. Where as for the AttribByte access the number of bytes to transfer is always 1 and field_obj->field.access_length is unused (so 0). Both types of accesses racing from different threads leads to the following problem:
> 
> 1. Thread a. starts an AttribBytes access, stores a non 0 value from field_obj->field.access_length in context->access_length 2. Thread b. starts an AttribByte access, stores 0 in
> context->access_length
> 3. Thread a. calls i2c_acpi_space_handler() (under Linux). Which sees that the access-type is ACPI_GSB_ACCESS_ATTRIB_MULTIBYTE and calls acpi_gsb_i2c_read_bytes(..., context->access_length) 4. At this point context->access_length is 0 (set by thread b.) rather then the field_obj->field.access_length value from thread a.
> This 0 length reads leads to the following errors being logged:
> 
>  i2c i2c-0: adapter quirk: no zero length (addr 0x0078, size 0, read)  i2c i2c-0: i2c read 0 bytes from client@0x78 starting at reg 0x0 failed, error: -95
> 
> Note this is just an example of the problems which this race can cause.
> There are likely many more (sporadic) problems caused by this race.
> 
> This commit adds a new context_mutex to acpi_object_addr_handler and makes acpi_ev_address_space_dispatch() take that mutex when using the shared context to pass extra parameters to an address-space handler, fixing this race.
> 
> Note the new mutex must be taken *after* exiting the interpreter, therefor the existing acpi_ex_exit_interpreter() call is moved to above the code which stores the extra parameters in the context.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpica/acobject.h  |  1 +
>  drivers/acpi/acpica/evhandler.c |  6 ++++  drivers/acpi/acpica/evregion.c  | 61 ++++++++++++++++++++++++---------  drivers/acpi/acpica/evxfregn.c  |  1 +
>  4 files changed, 52 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h index 9f0219a8cb98..dd7efafcb103 100644
> --- a/drivers/acpi/acpica/acobject.h
> +++ b/drivers/acpi/acpica/acobject.h
> @@ -284,6 +284,7 @@ struct acpi_object_addr_handler {
>  	acpi_adr_space_handler handler;
>  	struct acpi_namespace_node *node;	/* Parent device */
>  	void *context;
> +	acpi_mutex context_mutex;
>  	acpi_adr_space_setup setup;
>  	union acpi_operand_object *region_list;	/* Regions using this handler */
>  	union acpi_operand_object *next;
> diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c index 5884eba047f7..347199f29afe 100644
> --- a/drivers/acpi/acpica/evhandler.c
> +++ b/drivers/acpi/acpica/evhandler.c
> @@ -489,6 +489,12 @@ acpi_ev_install_space_handler(struct acpi_namespace_node *node,
>  
>  	/* Init handler obj */
>  
> +	status = acpi_os_create_mutex(&handler_obj->address_space.context_mutex);
> +	if (ACPI_FAILURE(status)) {
> +		acpi_ut_remove_reference(handler_obj);
> +		goto unlock_and_exit;
> +	}
> +
>  	handler_obj->address_space.space_id = (u8)space_id;
>  	handler_obj->address_space.handler_flags = flags;
>  	handler_obj->address_space.region_list = NULL; diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c index 21ff341e34a4..8e84eb0641e0 100644
> --- a/drivers/acpi/acpica/evregion.c
> +++ b/drivers/acpi/acpica/evregion.c
> @@ -112,6 +112,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>  	union acpi_operand_object *region_obj2;
>  	void *region_context = NULL;
>  	struct acpi_connection_info *context;
> +	acpi_mutex context_mutex;
> +	bool context_locked;
>  	acpi_physical_address address;
>  
>  	ACPI_FUNCTION_TRACE(ev_address_space_dispatch);
> @@ -136,6 +138,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>  	}
>  
>  	context = handler_desc->address_space.context;
> +	context_mutex = handler_desc->address_space.context_mutex;
> +	context_locked = false;
>  
>  	/*
>  	 * It may be the case that the region has never been initialized.
> @@ -204,6 +208,23 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>  	handler = handler_desc->address_space.handler;
>  	address = (region_obj->region.address + region_offset);
>  
> +	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
> +			  "Handler %p (@%p) Address %8.8X%8.8X [%s]\n",
> +			  &region_obj->region.handler->address_space, handler,
> +			  ACPI_FORMAT_UINT64(address),
> +			  acpi_ut_get_region_name(region_obj->region.
> +						  space_id)));
> +
> +	if (!(handler_desc->address_space.handler_flags &
> +	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
> +		/*
> +		 * For handlers other than the default (supplied) handlers, we must
> +		 * exit the interpreter because the handler *might* block -- we don't
> +		 * know what it will do, so we can't hold the lock on the interpreter.
> +		 */
> +		acpi_ex_exit_interpreter();
> +	}
> +
>  	/*
>  	 * Special handling for generic_serial_bus and general_purpose_io:
>  	 * There are three extra parameters that must be passed to the @@ -212,6 +233,11 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>  	 *   2) Length of the above buffer
>  	 *   3) Actual access length from the access_as() op
>  	 *
> +	 * Since we pass these extra parameters via the context, which is
> +	 * shared between threads, we must lock the context to avoid these
> +	 * parameters being changed from another thread before the handler
> +	 * has completed running.
> +	 *
>  	 * In addition, for general_purpose_io, the Address and bit_width fields
>  	 * are defined as follows:
>  	 *   1) Address is the pin number index of the field (bit offset from
> @@ -221,6 +247,13 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>  	if ((region_obj->region.space_id == ACPI_ADR_SPACE_GSBUS) &&
>  	    context && field_obj) {
>  
> +		status = acpi_os_acquire_mutex(context_mutex, ACPI_WAIT_FOREVER);
> +		if (ACPI_FAILURE(status)) {
> +			goto re_enter_interpreter;
> +		}
> +
> +		context_locked = true;
> +
>  		/* Get the Connection (resource_template) buffer */
>  
>  		context->connection = field_obj->field.resource_buffer; @@ -230,6 +263,13 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>  	if ((region_obj->region.space_id == ACPI_ADR_SPACE_GPIO) &&
>  	    context && field_obj) {
>  
> +		status = acpi_os_acquire_mutex(context_mutex, ACPI_WAIT_FOREVER);
> +		if (ACPI_FAILURE(status)) {
> +			goto re_enter_interpreter;
> +		}
> +
> +		context_locked = true;
> +
>  		/* Get the Connection (resource_template) buffer */
>  
>  		context->connection = field_obj->field.resource_buffer; @@ -239,28 +279,14 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>  		bit_width = field_obj->field.bit_length;
>  	}
>  
> -	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
> -			  "Handler %p (@%p) Address %8.8X%8.8X [%s]\n",
> -			  &region_obj->region.handler->address_space, handler,
> -			  ACPI_FORMAT_UINT64(address),
> -			  acpi_ut_get_region_name(region_obj->region.
> -						  space_id)));
> -
> -	if (!(handler_desc->address_space.handler_flags &
> -	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
> -		/*
> -		 * For handlers other than the default (supplied) handlers, we must
> -		 * exit the interpreter because the handler *might* block -- we don't
> -		 * know what it will do, so we can't hold the lock on the interpreter.
> -		 */
> -		acpi_ex_exit_interpreter();
> -	}
> -
>  	/* Call the handler */
>  
>  	status = handler(function, address, bit_width, value, context,
>  			 region_obj2->extra.region_context);
>  
> +	if (context_locked)
> +		acpi_os_release_mutex(context_mutex);
> +
>  	if (ACPI_FAILURE(status)) {
>  		ACPI_EXCEPTION((AE_INFO, status, "Returned by Handler for [%s]",
>  				acpi_ut_get_region_name(region_obj->region.
> @@ -277,6 +303,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>  		}
>  	}
>  
> +re_enter_interpreter:
>  	if (!(handler_desc->address_space.handler_flags &
>  	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
>  		/*
> diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c index da97fd0c6b51..74d0ee8a5736 100644
> --- a/drivers/acpi/acpica/evxfregn.c
> +++ b/drivers/acpi/acpica/evxfregn.c
> @@ -201,6 +201,7 @@ acpi_remove_address_space_handler(acpi_handle device,
>  
>  			/* Now we can delete the handler object */
>  
> +			acpi_os_release_mutex(handler_obj->address_space.context_mutex);
>  			acpi_ut_remove_reference(handler_obj);
>  			goto unlock_and_exit;
>  		}
> --
> 2.28.0
> 

