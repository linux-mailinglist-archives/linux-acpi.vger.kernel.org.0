Return-Path: <linux-acpi+bounces-6436-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EDC909CE4
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jun 2024 12:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F931F21177
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jun 2024 10:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF88A1862AD;
	Sun, 16 Jun 2024 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htnA1+66"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A86E5FD
	for <linux-acpi@vger.kernel.org>; Sun, 16 Jun 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718532031; cv=none; b=kGCskRgyg8PgN+mWd1jRUPvfgzV+jdhr4ufeZLP28Dqh58tLJaDIy2qP/jVq2qJBFWcXZVIjNE4psurlqM4JAK7sekfKxBh0z5b2hij9Aq3LjA4s1qmGHFrpiLN5D1o2PJ4SCNfzaj6V51Z7fvXyACxYYAoNzoZVSwVPiz7TTv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718532031; c=relaxed/simple;
	bh=fn26IYYsVjQN1qVKMkB2K/oCzXSdfzYaRpVPMFKjHNk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DkOA7+SjbCadQ1+YQd7k5Y6xa1CHzwVOCWYuge1mGbsXIfkQTRyJKHxpbT1lv2UYNPidTC2Vn7LStkrH1XgY1uuHFOZKeYufSYfzjzHrd8gnOY2n4DG+IXsA4Nkt5MKRxVBX16LVfnWEaNelX12o54vmr4Knw/hFVJpmfQm3/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htnA1+66; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718532029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14ev4XXs24GzM2Zvxm0xypGR8QNykGnP5Gnb2uyHzdY=;
	b=htnA1+66mj1QFM67d6v/5vXdIGDUaeUZe9gpafvkdNWFkGBdWPk+ubiRj7xMfzhWZ9gKZv
	mYQXCEu2etuWptln7Kjkc2V+OpHQ6hAPxa7CG1OI/1xWurQ7tYtZQ1emVcWakIHrepKO1l
	pRYGsiQGyKijUQoXeidMYfWcX0tvpiI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-55AAmTO6OpyjMyc15KysCg-1; Sun, 16 Jun 2024 06:00:27 -0400
X-MC-Unique: 55AAmTO6OpyjMyc15KysCg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57caaaecc6fso2091669a12.2
        for <linux-acpi@vger.kernel.org>; Sun, 16 Jun 2024 03:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718532026; x=1719136826;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14ev4XXs24GzM2Zvxm0xypGR8QNykGnP5Gnb2uyHzdY=;
        b=BgMsuZ/zKkucVnS/mqJnF4OrkY3UI8TNJPZqjlg26a/T+Xk41UGU2Nr8bExOzXO6DN
         InFDP7BRaLUvKeVIfZRmiXzEFUDkLUFOV4gEq/EahIIANiSGzCUQCMMX8D9tG+XRScje
         iolmGbMQ8UVXeGt7t3IOF43hxD2HWHYfB8WJQsVmwlX6AKE+aNZy4qxZU0GiU0Aa1x0p
         jwowD+yw/+xuLEHJDK0A8B2v3Nuzh9x0npaSzvBzIgKKZuIs4r+iswpzpdEOq7c4edt/
         TqYT+KBezlSy9k/W3RCyq3nIg04EFYJIB0YSLWQ88syF6CdfFUcdZRsqhzXdqx3wFrgg
         NroA==
X-Forwarded-Encrypted: i=1; AJvYcCXkLEKBqaL2BLdH60hXWEC8MbZmCN+lG6XsodatkDAE67E8JNS2Bajxp6O1t87xigsTkmoo8NoEheooakmnnPHbyzwIOTq319h1wQ==
X-Gm-Message-State: AOJu0YybSXHTmbtJPfVqddBhTuKRQHqYdu4XcIakkMN2qQ7tTqnu1IPn
	YRinKvVaXlzbkyjvnvmZdaveHvbGnCVTeiRl4wO5bfPqED09PmWKoEBFaHANKEMwQnyFYHwe7vz
	kwJROOwKureYVCBOd/3K4gLh6BcZmFJq7o/dWVixOx3xxXeq/mhmCsHl93d8=
X-Received: by 2002:a50:d746:0:b0:57a:33a5:9b78 with SMTP id 4fb4d7f45d1cf-57cbd69c3f9mr4603120a12.34.1718532026069;
        Sun, 16 Jun 2024 03:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9F0vsjZ1zn2WJXnEpGpivAMWyKkWYmPC7faj8ld5ew4JWVkiQgyDSvNN3Peq+0cIZe5ssTQ==
X-Received: by 2002:a50:d746:0:b0:57a:33a5:9b78 with SMTP id 4fb4d7f45d1cf-57cbd69c3f9mr4603109a12.34.1718532025517;
        Sun, 16 Jun 2024 03:00:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e70dsm4787562a12.62.2024.06.16.03.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 03:00:25 -0700 (PDT)
Message-ID: <3e902b05-40be-4f59-bafa-9f1d7b415064@redhat.com>
Date: Sun, 16 Jun 2024 12:00:24 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: EC: Evaluate orphan _REG under EC device
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 VitaliiT <vitaly.torshyn@gmail.com>, Armin Wolf <w_armin@gmx.de>
References: <12466682.O9o76ZdvQC@kreacher>
 <533a5778-3d68-4b61-b4ca-e82c37d65b33@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <533a5778-3d68-4b61-b4ca-e82c37d65b33@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/16/24 11:47 AM, Hans de Goede wrote:
> Hi,
> 
> On 6/12/24 4:15 PM, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> After starting to install the EC address space handler at the ACPI
>> namespace root, if there is an "orphan" _REG method in the EC device's
>> scope, it will not be evaluated any more.  This breaks EC operation
>> regions on some systems, like Asus gu605.
>>
>> To address this, use a wrapper around an existing ACPICA function to
>> look for an "orphan" _REG method in the EC device scope and evaluate
>> it if present.
>>
>> Fixes: 60fa6ae6e6d0 ("ACPI: EC: Install address space handler at the namespace root")
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218945
>> Reported-by: VitaliiT <vitaly.torshyn@gmail.com>
>> Tested-by: VitaliiT <vitaly.torshyn@gmail.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> Yes, this includes ACPICA changes that are obviously not upstream
>> and I am going to take care of pusing them to upstream, but for
>> now there is a regression to fix and it is relatively late in the
>> cycle.
>>
>> ---
>>  drivers/acpi/acpica/acevents.h |    4 +++
>>  drivers/acpi/acpica/evregion.c |    6 ----
>>  drivers/acpi/acpica/evxfregn.c |   54 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/acpi/ec.c              |    3 ++
>>  include/acpi/acpixf.h          |    4 +++
>>  5 files changed, 66 insertions(+), 5 deletions(-)
>>
>> Index: linux-pm/drivers/acpi/acpica/evxfregn.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/acpica/evxfregn.c
>> +++ linux-pm/drivers/acpi/acpica/evxfregn.c
>> @@ -306,3 +306,57 @@ acpi_execute_reg_methods(acpi_handle dev
>>  }
>>  
>>  ACPI_EXPORT_SYMBOL(acpi_execute_reg_methods)
>> +
>> +/*******************************************************************************
>> + *
>> + * FUNCTION:    acpi_execute_orphan_reg_method
>> + *
>> + * PARAMETERS:  device          - Handle for the device
>> + *              space_id        - The address space ID
>> + *
>> + * RETURN:      Status
>> + *
>> + * DESCRIPTION: Execute an "orphan" _REG method that appears under an ACPI
>> + *              device. This is a _REG method that has no corresponding region
>> + *              within the device's scope.
>> + *
>> + ******************************************************************************/
>> +acpi_status
>> +acpi_execute_orphan_reg_method(acpi_handle device, acpi_adr_space_type space_id)
>> +{
>> +	struct acpi_namespace_node *node;
>> +	acpi_status status;
>> +
>> +	ACPI_FUNCTION_TRACE(acpi_execute_orphan_reg_method);
>> +
>> +	/* Parameter validation */
>> +
>> +	if (!device) {
>> +		return_ACPI_STATUS(AE_BAD_PARAMETER);
>> +	}
>> +
>> +	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
>> +	if (ACPI_FAILURE(status)) {
>> +		return_ACPI_STATUS(status);
>> +	}
>> +
>> +	/* Convert and validate the device handle */
>> +
>> +	node = acpi_ns_validate_handle(device);
>> +	if (node) {
>> +
>> +		/*
>> +		 * If an "orphan" _REG method is present in the device's scope
>> +		 * for the given address space ID, run it.
>> +		 */
>> +
>> +		acpi_ev_execute_orphan_reg_method(node, space_id);
>> +	} else {
>> +		status = AE_BAD_PARAMETER;
>> +	}
>> +
>> +	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
>> +	return_ACPI_STATUS(status);
>> +}
>> +
>> +ACPI_EXPORT_SYMBOL(acpi_execute_orphan_reg_method)
>> Index: linux-pm/include/acpi/acpixf.h
>> ===================================================================
>> --- linux-pm.orig/include/acpi/acpixf.h
>> +++ linux-pm/include/acpi/acpixf.h
>> @@ -663,6 +663,10 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>>  						     acpi_adr_space_type
>>  						     space_id))
>>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>> +			    acpi_execute_orphan_reg_method(acpi_handle device,
>> +							   acpi_adr_space_type
>> +							   space_id))
>> +ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>>  			    acpi_remove_address_space_handler(acpi_handle
>>  							      device,
>>  							      acpi_adr_space_type
>> Index: linux-pm/drivers/acpi/acpica/acevents.h
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/acpica/acevents.h
>> +++ linux-pm/drivers/acpi/acpica/acevents.h
>> @@ -191,6 +191,10 @@ void
>>  acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
>>  			    acpi_adr_space_type space_id, u32 function);
>>  
>> +void
>> +acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *node,
>> +				  acpi_adr_space_type space_id);
>> +
>>  acpi_status
>>  acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function);
>>  
>> Index: linux-pm/drivers/acpi/acpica/evregion.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/acpica/evregion.c
>> +++ linux-pm/drivers/acpi/acpica/evregion.c
>> @@ -20,10 +20,6 @@ extern u8 acpi_gbl_default_address_space
>>  
>>  /* Local prototypes */
>>  
>> -static void
>> -acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *device_node,
>> -				  acpi_adr_space_type space_id);
>> -
>>  static acpi_status
>>  acpi_ev_reg_run(acpi_handle obj_handle,
>>  		u32 level, void *context, void **return_value);
>> @@ -818,7 +814,7 @@ acpi_ev_reg_run(acpi_handle obj_handle,
>>   *
>>   ******************************************************************************/
>>  
>> -static void
>> +void
>>  acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *device_node,
>>  				  acpi_adr_space_type space_id)
>>  {
>> Index: linux-pm/drivers/acpi/ec.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/ec.c
>> +++ linux-pm/drivers/acpi/ec.c
>> @@ -1507,6 +1507,9 @@ static int ec_install_handlers(struct ac
>>  
>>  	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
>>  		acpi_execute_reg_methods(scope_handle, ACPI_ADR_SPACE_EC);
>> +		if (scope_handle != ec->handle)
>> +			acpi_execute_orphan_reg_method(ec->handle, ACPI_ADR_SPACE_EC);
>> +
>>  		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
>>  	}
>>  
> 
> TL;DR: this change made me wonder about a possible issue, but all is
> fine, except that the code flow leading to "fine" is a bit convoluted.
> 
> I noticed this landing in Linus' tree and this got me thinking about
> if the "if (scope_handle != ec->handle)" would not cause the orphan
> _REG method to not get called for the case where the EC is created
> by parsing the ECDT early on, since then we set
> ec->handle = ACPI_ROOT_OBJECT for the ec object.
> 
> So I checked and acpi_ec_ecdt_probe() calls acpi_ec_setup(ec, NULL, false)
> with the false making call_reg above false, so the _REG methods do not
> get executed at this point.
> 
> Instead they should get executed when parsing the DSDT finds the EC ACPI
> device by acpi_ec_add() calling acpi_ec_setup(ec, device, true).
> 
> acpi_ec_add() updated ec->handle away from ACPI_ROOT_OBJECT to the actual
> acpi_device's handle before calling acpi_ec_setup(ec, device, true) so
> all should be well.
> 
> But while checkimg this I noticed a pre-existing issue where if the boot_ec
> object is created from the ECDT, so with ec->handle == NULL, acpi_ec_add()
> does not update ec->handle, which means an orphan _REG method will not get
> executed.
> 
> Specifically if this if condition evaluated to true, because the !strcmp()
> evaluates to true:
> 
>         if (boot_ec && (boot_ec->handle == device->handle ||
>             !strcmp(acpi_device_hid(device), ACPI_ECDT_HID))) {
>                 /* Fast path: this device corresponds to the boot EC. */
>                 ec = boot_ec;
>         } else {
> 
> then [boot_]ec->handle does not get set to device->handle .
> 
> So at a first glance it looks like we need something like this to make sure
> that any orphan _REG methods are also run in the described scenario:
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index e7793ee9e649..af61b9bb3749 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1635,6 +1635,7 @@ static int acpi_ec_add(struct acpi_device *device)
>  	    !strcmp(acpi_device_hid(device), ACPI_ECDT_HID))) {
>  		/* Fast path: this device corresponds to the boot EC. */
>  		ec = boot_ec;
> +		ec->handle = device->handle;
>  	} else {
>  		acpi_status status;
>  
> 
> 
> But upon further checking the only place creating an acpi_device
> with an ACPI_ECDT_HID is acpi_ec_ecdt_start() which does:
> 
>         status = acpi_get_handle(NULL, ecdt_ptr->id, &handle);
>         if (ACPI_SUCCESS(status)) {
>                 boot_ec->handle = handle;
> 
>                 /* Add a special ACPI device object to represent the boot EC. */
>                 acpi_bus_register_early_device(ACPI_BUS_TYPE_ECDT_EC);
>         }
> 
> So boot_ec->handle gets updated in this case before acpi_ec_add() runs
> and everything is fine.
> 
> ...
> 
> Still I'm wondering if it would not be better to replace this
> "boot_ec->handle = handle;" in acpi_ec_ecdt_start() with the change
> from my proposed diff above, so that we consistently about the
> [boot_]ec->handle with device->handle for the being added acpi_device
> in both branches of the if ... else ... in acpi_ec_add() ?

Never mind that will not work because then we would set boot_ec->handle
to the handle of the special / fake ACPI device object added to
represent the boot EC, rather then to the handle corresponding to
ecdt_ptr->id, so this is a bad idea.

Regards,

Hans



