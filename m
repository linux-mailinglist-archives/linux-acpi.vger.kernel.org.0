Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD6429C807
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 20:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902137AbgJ0TAq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 15:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S371347AbgJ0S7w (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Oct 2020 14:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603825189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIo5+LE68HVizFPuOjt55N+9v+R6ttsPMZGe5RYy+IU=;
        b=RQuLxvQ944EMRaDxj3wWMCDWBi5EdhguROIUlZ0T/deVYHmkybCz7P0lVZmtMtk/ohmAUw
        dt/sYkwe47Mu1f23lrj3HPpfOUIpx93i89EBLF/txKOr9n+cXU1X+LPYg0377UQ2DqugtI
        NXre+p7rxLoKhFP1ctBeZcHIu8WFsKE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-yqwo2CoPNWacvN08VeSaEA-1; Tue, 27 Oct 2020 14:59:46 -0400
X-MC-Unique: yqwo2CoPNWacvN08VeSaEA-1
Received: by mail-ed1-f69.google.com with SMTP id a15so1074861eda.15
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2020 11:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wIo5+LE68HVizFPuOjt55N+9v+R6ttsPMZGe5RYy+IU=;
        b=ltYSQJ72BZsDrquDGc1R1ApRnI/IjYs7jSfdFmgN6mlJVlLhTJ4k4kWTO73yQmYSVQ
         jbdXeFVDk0k0ZfeQO0gsSPb7ti7RYPktr+tb8G9Zaas5Cd98nk12tt1Nmno3JhCIEyVv
         P528vlBnGm6lBaiYhEnd8ljTyrba9rjeBAQJsJ/Ij31G0wqgtg5qR6KfKQIihH/GQWrt
         yubkIRUoXLJMCdfFYXgYapDPUjJ+WN8r0x/7tIpdLKgiXQRTshT4FkQ1TyMh3KsLQ0fk
         GqFwG165VIiDirg6qSm2ID/iadCIzUaIBx2CfU8xZ8XzAeOvKWHTPqvEmaUIvubqlUXb
         eLaQ==
X-Gm-Message-State: AOAM533kmhLfcq3SCCdxXi5vxmJgUTePY+Kzmfc1IieRT0SJ1JaNDSpB
        Uh0/Uxvuywui/wHRJtb9J+HU969rLtkPXHz4XYgNzIUfvFjP7Y5i5pysi7ri71f3hAbXRrus9St
        1pmBGi1gG3NXrrilXgFn27Q==
X-Received: by 2002:a17:907:204c:: with SMTP id pg12mr3673824ejb.464.1603825184857;
        Tue, 27 Oct 2020 11:59:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXRTOXNQJnFtqD7xfiq/0WuPEf3+h5+bAFD2ALDbG0xJ/CdJL7zKx6tPwR61xKRVeyT+aapw==
X-Received: by 2002:a17:907:204c:: with SMTP id pg12mr3673812ejb.464.1603825184632;
        Tue, 27 Oct 2020 11:59:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v18sm1614443ejj.10.2020.10.27.11.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 11:59:43 -0700 (PDT)
Subject: Re: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
 OpRegions
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
References: <20201025094542.3669-1-hdegoede@redhat.com>
 <MWHPR11MB159947FE046515CE985CA571F0190@MWHPR11MB1599.namprd11.prod.outlook.com>
 <BYAPR11MB32563BD4E4ABB7BEF135ABFB87160@BYAPR11MB3256.namprd11.prod.outlook.com>
 <MWHPR11MB15990ABB3778816E4831FDF9F0160@MWHPR11MB1599.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d8330e68-c0ab-ab3c-ee13-3d9dc58ade7b@redhat.com>
Date:   Tue, 27 Oct 2020 19:59:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB15990ABB3778816E4831FDF9F0160@MWHPR11MB1599.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/27/20 6:43 PM, Kaneda, Erik wrote:
> 
> 
>> -----Original Message-----
>> From: Moore, Robert <robert.moore@intel.com>
>> Sent: Tuesday, October 27, 2020 7:17 AM
>> To: Kaneda, Erik <erik.kaneda@intel.com>; Hans de Goede
>> <hdegoede@redhat.com>; Rafael J . Wysocki <rjw@rjwysocki.net>; Len
>> Brown <lenb@kernel.org>
>> Cc: linux-acpi@vger.kernel.org; devel@acpica.org
>> Subject: RE: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
>> OpRegions
>>
>> Looks OK to me.
> 
> Ok, I'll make a pull request of this to ACPICA on behalf of Hans and it will be in the next ACPICA release.

Great, thank you.

Regards,

Hans



>> -----Original Message-----
>> From: Kaneda, Erik <erik.kaneda@intel.com>
>> Sent: Monday, October 26, 2020 1:56 PM
>> To: Hans de Goede <hdegoede@redhat.com>; Rafael J . Wysocki
>> <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Moore, Robert
>> <robert.moore@intel.com>
>> Cc: linux-acpi@vger.kernel.org; devel@acpica.org
>> Subject: RE: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
>> OpRegions
>>
>>
>>
>>> -----Original Message-----
>>> From: Hans de Goede <hdegoede@redhat.com>
>>> Sent: Sunday, October 25, 2020 2:46 AM
>>> To: Rafael J . Wysocki <rjw@rjwysocki.net>; Len Brown
>>> <lenb@kernel.org>; Moore, Robert <robert.moore@intel.com>; Kaneda,
>>> Erik <erik.kaneda@intel.com>
>>> Cc: Hans de Goede <hdegoede@redhat.com>; linux-acpi@vger.kernel.org;
>>> devel@acpica.org
>>> Subject: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
>>> OpRegions
>>>
>>> Before this commit acpi_ev_execute_reg_methods() had special handling
>>> to handle "orphan" (no matching OpRegion declared) _REG methods for EC
>>> nodes.
>>>
>>> On Intel Cherry Trail devices there are 2 possible ACPI OpRegions for
>>> accessing GPIOs. The standard GeneralPurposeIo OpRegion and the Cherry
>>> Trail specific UserDefined 0x9X OpRegions.
>>>
>>> Having 2 different types of OpRegions leads to potential issues with
>>> checks for OpRegion availability, or in other words checks if _REG has
>>> been called for the OpRegion which the ACPI code wants to use.
>>>
>>> Except for the "orphan" EC handling, ACPICA core does not call _REG on
>>> an ACPI node which does not define an OpRegion matching the type being
>>> registered; and the reference design DSDT, from which most Cherry
>>> Trail DSDTs are derived, does not define GeneralPurposeIo, nor
>>> UserDefined(0x93)
>>> OpRegions for the GPO2 (UID 3) device, because no pins were assigned
>>> ACPI controlled functions in the reference design.
>>>
>>> Together this leads to the perfect storm, at least on the Cherry Trail
>>> based Medion Akayo E1239T. This design does use a GPO2 pin from its
>>> ACPI code and has added the Cherry Trail specific UserDefined(0x93)
>>> opregion to its GPO2 ACPI node to access this pin.
>>>
>>> But it uses a has _REG been called availability check for the standard
>>> GeneralPurposeIo OpRegion. This clearly is a bug in the DSDT, but this
>>> does work under Windows. This issue leads to the intel_vbtn driver
>>> reporting the device always being in tablet-mode at boot, even if it
>>> is in laptop mode. Which in turn causes userspace to ignore touchpad
>>> events. So iow this issues causes the touchpad to not work at boot.
>>>
>>> This commit fixes this by extending the "orphan" _REG method handling
>>> to also apply to GPIO address-space handlers.
>>>
>>> Note it seems that Windows always calls "orphan" _REG methods so me
>>> may want to consider dropping the space-id check and always do
>>> "orphan" _REG method handling.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>  drivers/acpi/acpica/evregion.c | 54
>>> +++++++++++++++++-----------------
>>>  1 file changed, 27 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/acpi/acpica/evregion.c
>>> b/drivers/acpi/acpica/evregion.c index 738d4b231f34..21ff341e34a4
>>> 100644
>>> --- a/drivers/acpi/acpica/evregion.c
>>> +++ b/drivers/acpi/acpica/evregion.c
>>> @@ -21,7 +21,8 @@ extern u8 acpi_gbl_default_address_spaces[];
>>>  /* Local prototypes */
>>>
>>>  static void
>>> -acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node
>>> *ec_device_node);
>>> +acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node
>>> *device_node,
>>> +				  acpi_adr_space_type space_id);
>>>
>>>  static acpi_status
>>>  acpi_ev_reg_run(acpi_handle obj_handle, @@ -684,10 +685,12 @@
>>> acpi_ev_execute_reg_methods(struct
>>> acpi_namespace_node *node,
>>>  				     ACPI_NS_WALK_UNLOCK,
>>> acpi_ev_reg_run, NULL,
>>>  				     &info, NULL);
>>>
>>> -	/* Special case for EC: handle "orphan" _REG methods with no region
>>> */
>>> -
>>> -	if (space_id == ACPI_ADR_SPACE_EC) {
>>> -		acpi_ev_orphan_ec_reg_method(node);
>>> +	/*
>>> +	 * Special case for EC and GPIO: handle "orphan" _REG methods with
>>> +	 * no region.
>>> +	 */
>>> +	if (space_id == ACPI_ADR_SPACE_EC || space_id ==
>>> ACPI_ADR_SPACE_GPIO) {
>>> +		acpi_ev_execute_orphan_reg_method(node, space_id);
>>>  	}
>>>
>>>  	ACPI_DEBUG_PRINT_RAW((ACPI_DB_NAMES,
>>> @@ -760,31 +763,28 @@ acpi_ev_reg_run(acpi_handle obj_handle,
>>>
>>>
>>>
>> /**********************************************************
>>> *********************
>>>   *
>>> - * FUNCTION:    acpi_ev_orphan_ec_reg_method
>>> + * FUNCTION:    acpi_ev_execute_orphan_reg_method
>>>   *
>>> - * PARAMETERS:  ec_device_node      - Namespace node for an EC device
>>> + * PARAMETERS:  device_node     - Namespace node for an ACPI device
>>> + *              space_id        - The address space ID
>>>   *
>>>   * RETURN:      None
>>>   *
>>> - * DESCRIPTION: Execute an "orphan" _REG method that appears under
>>> the EC
>>> + * DESCRIPTION: Execute an "orphan" _REG method that appears under
>> an
>>> ACPI
>>>   *              device. This is a _REG method that has no corresponding region
>>> - *              within the EC device scope. The orphan _REG method appears to
>>> - *              have been enabled by the description of the ECDT in the ACPI
>>> - *              specification: "The availability of the region space can be
>>> - *              detected by providing a _REG method object underneath the
>>> - *              Embedded Controller device."
>>> - *
>>> - *              To quickly access the EC device, we use the ec_device_node used
>>> - *              during EC handler installation. Otherwise, we would need to
>>> - *              perform a time consuming namespace walk, executing _HID
>>> - *              methods to find the EC device.
>>> + *              within the device's scope. ACPI tables depending on these
>>> + *              "orphan" _REG methods have been seen for both EC and GPIO
>>> + *              Operation Regions. Presumably the Windows ACPI
>> implementation
>>> + *              always calls the _REG method independent of the presence of
>>> + *              an actual Operation Region with the correct address space ID.
>>>   *
>>>   *  MUTEX:      Assumes the namespace is locked
>>>   *
>>>
>>>
>> **********************************************************
>>> ********************/
>>>
>>>  static void
>>> -acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node
>>> *ec_device_node)
>>> +acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node
>>> *device_node,
>>> +				  acpi_adr_space_type space_id)
>>>  {
>>>  	acpi_handle reg_method;
>>>  	struct acpi_namespace_node *next_node; @@ -792,9 +792,9 @@
>>> acpi_ev_orphan_ec_reg_method(struct
>>> acpi_namespace_node *ec_device_node)
>>>  	struct acpi_object_list args;
>>>  	union acpi_object objects[2];
>>>
>>> -	ACPI_FUNCTION_TRACE(ev_orphan_ec_reg_method);
>>> +	ACPI_FUNCTION_TRACE(ev_execute_orphan_reg_method);
>>>
>>> -	if (!ec_device_node) {
>>> +	if (!device_node) {
>>>  		return_VOID;
>>>  	}
>>>
>>> @@ -804,7 +804,7 @@ acpi_ev_orphan_ec_reg_method(struct
>>> acpi_namespace_node *ec_device_node)
>>>
>>>  	/* Get a handle to a _REG method immediately under the EC device
>> */
>>>
>>> -	status = acpi_get_handle(ec_device_node, METHOD_NAME__REG,
>>> &reg_method);
>>> +	status = acpi_get_handle(device_node, METHOD_NAME__REG,
>>> &reg_method);
>>>  	if (ACPI_FAILURE(status)) {
>>>  		goto exit;	/* There is no _REG method present */
>>>  	}
>>> @@ -816,23 +816,23 @@ acpi_ev_orphan_ec_reg_method(struct
>>> acpi_namespace_node *ec_device_node)
>>>  	 * with other space IDs to be present; but the code below will then
>>>  	 * execute the _REG method with the embedded_control space_ID
>>> argument.
>>>  	 */
>>> -	next_node = acpi_ns_get_next_node(ec_device_node, NULL);
>>> +	next_node = acpi_ns_get_next_node(device_node, NULL);
>>>  	while (next_node) {
>>>  		if ((next_node->type == ACPI_TYPE_REGION) &&
>>>  		    (next_node->object) &&
>>> -		    (next_node->object->region.space_id ==
>>> ACPI_ADR_SPACE_EC)) {
>>> +		    (next_node->object->region.space_id == space_id)) {
>>>  			goto exit;	/* Do not execute the _REG */
>>>  		}
>>>
>>> -		next_node = acpi_ns_get_next_node(ec_device_node,
>>> next_node);
>>> +		next_node = acpi_ns_get_next_node(device_node,
>>> next_node);
>>>  	}
>>>
>>> -	/* Evaluate the _REG(embedded_control,Connect) method */
>>> +	/* Evaluate the _REG(space_id, Connect) method */
>>>
>>>  	args.count = 2;
>>>  	args.pointer = objects;
>>>  	objects[0].type = ACPI_TYPE_INTEGER;
>>> -	objects[0].integer.value = ACPI_ADR_SPACE_EC;
>>> +	objects[0].integer.value = space_id;
>>>  	objects[1].type = ACPI_TYPE_INTEGER;
>>>  	objects[1].integer.value = ACPI_REG_CONNECT;
>>>
>>> --
>>> 2.28.0
>>
>> This looks good to me. Bob, any thoughts?
>>
>> Erik
> 

