Return-Path: <linux-acpi+bounces-6435-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC92B909CD5
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jun 2024 11:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D61281387
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jun 2024 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF271850AC;
	Sun, 16 Jun 2024 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gb0w4uow"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3716C17F4F6
	for <linux-acpi@vger.kernel.org>; Sun, 16 Jun 2024 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718531247; cv=none; b=A0si5rI5s66x+EzitzXE38WHZqdMPVwOunlmuAnJva6kEOQD3ApDk2OuoU8Tn2U0WF35R+5oJ7v0Q4zy90EyGCJV3qX2E1s4QSMetjtEfbbHOIkizghcEBdoQYlgXwosNcBHUOjf0JbxtikPDQJeIo9kRin2cCRd3Hjk/9GyuaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718531247; c=relaxed/simple;
	bh=Rol9GgNlsITas4SWbXbLwpkDf5htEtZtG+fTBdMpv0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uy+ZKIy5OqbO32Rn8B/sGCYpG8inZHexF0oCXIrO6EAdY0+I50YyTqE2mcgCzmVul1fiMpgcq6HPV87p4Ih1/u/h4FG3AW3lXXgTbL56At/C0EJ5CPhqZhHvdElvA/lHyH/bX3p2WcRAGCVr3H5qhPB5QcIzVocj8V891yun5TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gb0w4uow; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718531243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srnLF9ysHPMfgdFHSrTBUGTBWZjX5ovwIz2l9bhJ8e8=;
	b=Gb0w4uow/WTnhq+bKVP7WtP2mmk112RLOe9+rOwc0avapwQ0kbg7s4YeJ0QB6ucthDeBtE
	mvpxMFr2T8r2t73lZ9ep5NI0lVaaMIcvyFj0XCcHsgzFT2fJRExSWjrlei+O/sMIjpCKsR
	fME759rZG/0bcCRxaQPeodx8sIwQUBo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-tdfhwa1vNBeJzB3LKYdyAw-1; Sun, 16 Jun 2024 05:47:21 -0400
X-MC-Unique: tdfhwa1vNBeJzB3LKYdyAw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57cb9684229so1577472a12.0
        for <linux-acpi@vger.kernel.org>; Sun, 16 Jun 2024 02:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718531240; x=1719136040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srnLF9ysHPMfgdFHSrTBUGTBWZjX5ovwIz2l9bhJ8e8=;
        b=Ph+7Mzrx+jslPmEazqWO+GdfkWvlganSdS+4J5XZzxMsKQcxp9a1Mj06IUG2zfQtg1
         mbaCRam6V3Y18LNfavRH70DUk0QF4dWeRsHqwtuvp98YOX07NkWRKKt9o/kfBHar5ABf
         flryvjWglp4JYAvPhAirTQrQ7F2mJtPJvSXhS9RauKsg9Ix9rsQs2ZWat2LYyLNRqtwh
         bCjzl/Z+vzf3wLjm+hhw3oPsRVvyg/nBKUyi6utS29U2i3i1TMKMz6llBzZUzSkNnUn5
         xJqT2KTXN6DtiqlDSiaqH8oyhVAyxSd2xC2waq+5vFRat3SJ9gtgO1yQJKcmHF3DiW6p
         S7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9Ud1eo+bo/UaBdlDMfpWS8Qz8Gm3YuDtLp7yBMthcAdu0AKzg5WgXV7Y+pEJlUa8RWJ4wU+782+DYg4kC393qsCrJZIqlw0rA2w==
X-Gm-Message-State: AOJu0YwfxcItOpjS1MWlohVMCHNOLAVyZ5cId0bZD3Wq0v49vpACPKUJ
	9Y5/NcAik32PEqLeOV6JOH0l5BKTcw7wOwqTz/m/9Wke3MWjM3kTQrALdF6RF5pOkanHbGHOgUL
	T/ciPn/XrwQLiXvVdw+G39BObELrKreY1taNVwbhJNV4R9bVZgniRMBORiYg=
X-Received: by 2002:a50:9557:0:b0:57c:6afc:d2a9 with SMTP id 4fb4d7f45d1cf-57cbd8f2a3emr4420993a12.26.1718531240384;
        Sun, 16 Jun 2024 02:47:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBbeqHFITU6vgc5Vt0CWvDzTYevbhAXkzwpGDS+dC17bkrOy3gfURzd0EjvYaE0u+N9+qASQ==
X-Received: by 2002:a50:9557:0:b0:57c:6afc:d2a9 with SMTP id 4fb4d7f45d1cf-57cbd8f2a3emr4420973a12.26.1718531239890;
        Sun, 16 Jun 2024 02:47:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cba492acfsm4405008a12.15.2024.06.16.02.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 02:47:19 -0700 (PDT)
Message-ID: <533a5778-3d68-4b61-b4ca-e82c37d65b33@redhat.com>
Date: Sun, 16 Jun 2024 11:47:18 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: EC: Evaluate orphan _REG under EC device
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 VitaliiT <vitaly.torshyn@gmail.com>, Armin Wolf <w_armin@gmx.de>
References: <12466682.O9o76ZdvQC@kreacher>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <12466682.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/12/24 4:15 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After starting to install the EC address space handler at the ACPI
> namespace root, if there is an "orphan" _REG method in the EC device's
> scope, it will not be evaluated any more.  This breaks EC operation
> regions on some systems, like Asus gu605.
> 
> To address this, use a wrapper around an existing ACPICA function to
> look for an "orphan" _REG method in the EC device scope and evaluate
> it if present.
> 
> Fixes: 60fa6ae6e6d0 ("ACPI: EC: Install address space handler at the namespace root")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218945
> Reported-by: VitaliiT <vitaly.torshyn@gmail.com>
> Tested-by: VitaliiT <vitaly.torshyn@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Yes, this includes ACPICA changes that are obviously not upstream
> and I am going to take care of pusing them to upstream, but for
> now there is a regression to fix and it is relatively late in the
> cycle.
> 
> ---
>  drivers/acpi/acpica/acevents.h |    4 +++
>  drivers/acpi/acpica/evregion.c |    6 ----
>  drivers/acpi/acpica/evxfregn.c |   54 +++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/ec.c              |    3 ++
>  include/acpi/acpixf.h          |    4 +++
>  5 files changed, 66 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpica/evxfregn.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/evxfregn.c
> +++ linux-pm/drivers/acpi/acpica/evxfregn.c
> @@ -306,3 +306,57 @@ acpi_execute_reg_methods(acpi_handle dev
>  }
>  
>  ACPI_EXPORT_SYMBOL(acpi_execute_reg_methods)
> +
> +/*******************************************************************************
> + *
> + * FUNCTION:    acpi_execute_orphan_reg_method
> + *
> + * PARAMETERS:  device          - Handle for the device
> + *              space_id        - The address space ID
> + *
> + * RETURN:      Status
> + *
> + * DESCRIPTION: Execute an "orphan" _REG method that appears under an ACPI
> + *              device. This is a _REG method that has no corresponding region
> + *              within the device's scope.
> + *
> + ******************************************************************************/
> +acpi_status
> +acpi_execute_orphan_reg_method(acpi_handle device, acpi_adr_space_type space_id)
> +{
> +	struct acpi_namespace_node *node;
> +	acpi_status status;
> +
> +	ACPI_FUNCTION_TRACE(acpi_execute_orphan_reg_method);
> +
> +	/* Parameter validation */
> +
> +	if (!device) {
> +		return_ACPI_STATUS(AE_BAD_PARAMETER);
> +	}
> +
> +	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
> +	if (ACPI_FAILURE(status)) {
> +		return_ACPI_STATUS(status);
> +	}
> +
> +	/* Convert and validate the device handle */
> +
> +	node = acpi_ns_validate_handle(device);
> +	if (node) {
> +
> +		/*
> +		 * If an "orphan" _REG method is present in the device's scope
> +		 * for the given address space ID, run it.
> +		 */
> +
> +		acpi_ev_execute_orphan_reg_method(node, space_id);
> +	} else {
> +		status = AE_BAD_PARAMETER;
> +	}
> +
> +	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
> +	return_ACPI_STATUS(status);
> +}
> +
> +ACPI_EXPORT_SYMBOL(acpi_execute_orphan_reg_method)
> Index: linux-pm/include/acpi/acpixf.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpixf.h
> +++ linux-pm/include/acpi/acpixf.h
> @@ -663,6 +663,10 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>  						     acpi_adr_space_type
>  						     space_id))
>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> +			    acpi_execute_orphan_reg_method(acpi_handle device,
> +							   acpi_adr_space_type
> +							   space_id))
> +ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>  			    acpi_remove_address_space_handler(acpi_handle
>  							      device,
>  							      acpi_adr_space_type
> Index: linux-pm/drivers/acpi/acpica/acevents.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/acevents.h
> +++ linux-pm/drivers/acpi/acpica/acevents.h
> @@ -191,6 +191,10 @@ void
>  acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
>  			    acpi_adr_space_type space_id, u32 function);
>  
> +void
> +acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *node,
> +				  acpi_adr_space_type space_id);
> +
>  acpi_status
>  acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function);
>  
> Index: linux-pm/drivers/acpi/acpica/evregion.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/evregion.c
> +++ linux-pm/drivers/acpi/acpica/evregion.c
> @@ -20,10 +20,6 @@ extern u8 acpi_gbl_default_address_space
>  
>  /* Local prototypes */
>  
> -static void
> -acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *device_node,
> -				  acpi_adr_space_type space_id);
> -
>  static acpi_status
>  acpi_ev_reg_run(acpi_handle obj_handle,
>  		u32 level, void *context, void **return_value);
> @@ -818,7 +814,7 @@ acpi_ev_reg_run(acpi_handle obj_handle,
>   *
>   ******************************************************************************/
>  
> -static void
> +void
>  acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *device_node,
>  				  acpi_adr_space_type space_id)
>  {
> Index: linux-pm/drivers/acpi/ec.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -1507,6 +1507,9 @@ static int ec_install_handlers(struct ac
>  
>  	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
>  		acpi_execute_reg_methods(scope_handle, ACPI_ADR_SPACE_EC);
> +		if (scope_handle != ec->handle)
> +			acpi_execute_orphan_reg_method(ec->handle, ACPI_ADR_SPACE_EC);
> +
>  		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
>  	}
>  

TL;DR: this change made me wonder about a possible issue, but all is
fine, except that the code flow leading to "fine" is a bit convoluted.

I noticed this landing in Linus' tree and this got me thinking about
if the "if (scope_handle != ec->handle)" would not cause the orphan
_REG method to not get called for the case where the EC is created
by parsing the ECDT early on, since then we set
ec->handle = ACPI_ROOT_OBJECT for the ec object.

So I checked and acpi_ec_ecdt_probe() calls acpi_ec_setup(ec, NULL, false)
with the false making call_reg above false, so the _REG methods do not
get executed at this point.

Instead they should get executed when parsing the DSDT finds the EC ACPI
device by acpi_ec_add() calling acpi_ec_setup(ec, device, true).

acpi_ec_add() updated ec->handle away from ACPI_ROOT_OBJECT to the actual
acpi_device's handle before calling acpi_ec_setup(ec, device, true) so
all should be well.

But while checkimg this I noticed a pre-existing issue where if the boot_ec
object is created from the ECDT, so with ec->handle == NULL, acpi_ec_add()
does not update ec->handle, which means an orphan _REG method will not get
executed.

Specifically if this if condition evaluated to true, because the !strcmp()
evaluates to true:

        if (boot_ec && (boot_ec->handle == device->handle ||
            !strcmp(acpi_device_hid(device), ACPI_ECDT_HID))) {
                /* Fast path: this device corresponds to the boot EC. */
                ec = boot_ec;
        } else {

then [boot_]ec->handle does not get set to device->handle .

So at a first glance it looks like we need something like this to make sure
that any orphan _REG methods are also run in the described scenario:

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e7793ee9e649..af61b9bb3749 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1635,6 +1635,7 @@ static int acpi_ec_add(struct acpi_device *device)
 	    !strcmp(acpi_device_hid(device), ACPI_ECDT_HID))) {
 		/* Fast path: this device corresponds to the boot EC. */
 		ec = boot_ec;
+		ec->handle = device->handle;
 	} else {
 		acpi_status status;
 


But upon further checking the only place creating an acpi_device
with an ACPI_ECDT_HID is acpi_ec_ecdt_start() which does:

        status = acpi_get_handle(NULL, ecdt_ptr->id, &handle);
        if (ACPI_SUCCESS(status)) {
                boot_ec->handle = handle;

                /* Add a special ACPI device object to represent the boot EC. */
                acpi_bus_register_early_device(ACPI_BUS_TYPE_ECDT_EC);
        }

So boot_ec->handle gets updated in this case before acpi_ec_add() runs
and everything is fine.

...

Still I'm wondering if it would not be better to replace this
"boot_ec->handle = handle;" in acpi_ec_ecdt_start() with the change
from my proposed diff above, so that we consistently about the
[boot_]ec->handle with device->handle for the being added acpi_device
in both branches of the if ... else ... in acpi_ec_add() ?

Regards,

Hans


