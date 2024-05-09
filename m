Return-Path: <linux-acpi+bounces-5690-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CAC8C0E42
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 12:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD44C283A6A
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C2812E1EB;
	Thu,  9 May 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWQJ/jPm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FA25339A
	for <linux-acpi@vger.kernel.org>; Thu,  9 May 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715250969; cv=none; b=OVGPANbcc1JTLQiMdwPbam29xgWSIOf7vtKN+rIQXHDUrsmZZE8kbVUgCnbi2sXpNvaqPp2UDsW7lKjoPGs6ZRqMVaLFaoumF2B/cacxZcWXaNmGjTpIZBgR3xQaLmt76NLdR5MEzCXPMyAA+UXUMNEg7V1N/3sELnAuyNd1RwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715250969; c=relaxed/simple;
	bh=VgY3WPMcs3fZWS0UhB0VJaAmb3kugbWtcc2ToJcBZW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dwl+L7ud2eef6/+B167rD+rEQTmPcKdS6TDpuP0lkNdT5VUZ2mu2Kk5V1r2fWMhzcvY/GlLML2TCkPa+fuMapFC8iYRwDCPBGN19JYBHOlBw7goFV002yDKM+WJNf1u77m0707Iq97ThS6kCEAcMX6NvLhXHXahkYzTtt80m+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWQJ/jPm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715250966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHP7W5pddTWL8qN4NDGiDxw3vbht8EqFUlloQhPGCaQ=;
	b=IWQJ/jPmLEkNvICY0z6H35uR8np9VgBctD/GwYQxC/ZrxxUb5fjsFc2trjYSbG5MrrRYUR
	3mUv7VF4srh2DOLmafmvOgqyv6c1165+SHiBwatrhEyXXklAfUQ+lq1sAhluUi2Vn2VzsE
	PyQ7DE7TgTAr6F28k0tktzv+HqEtoU0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-gv5zLJO5PECwnjwmrCeD1g-1; Thu, 09 May 2024 06:36:02 -0400
X-MC-Unique: gv5zLJO5PECwnjwmrCeD1g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a59c3cf5f83so45980466b.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 May 2024 03:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715250961; x=1715855761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHP7W5pddTWL8qN4NDGiDxw3vbht8EqFUlloQhPGCaQ=;
        b=YtnPckz6yY7XHfGe63lLWWn0XKufB0XOlmxMrVt4mGCVJ3X8Qm7lv1Zjm6QAihXn33
         TGcLLSglDsnZqT0TKmHHgbWkt57w9eEDRccKNhKON3xyThJJw9aPnf/YntZmXaG0zTJ8
         ojNKnO3mcRhZnWhTf6QbZVweK9taDfPcvU6f1ACDD8K89ONIAylgi/N7V73i4iWSw8np
         EKKH9FB4wrPZsJXn6zDBYWFia7/s6GcMRktkTdnZ55AHRWJktv4tZbso8WJiZnvKumzA
         OhOztl2E9g67NmdqhR2izY6z4RPYMCgQQSXErsr5D9TTNEd59DhWIHOp0TveROY8X/0O
         UG6w==
X-Forwarded-Encrypted: i=1; AJvYcCVNy3KwRLIOyulZBNsfVfFKrDcCUXJAoFDbRFofr7xAKrnhwO/IclmetlHMH8kAiTfG8UivaPnPQ924GzXpS6nuNshvHwpiNWmO3g==
X-Gm-Message-State: AOJu0Yx01uBP8U+cuLl6589IpdSClt8tEa3FX0nAEGDWf821RESyH1KQ
	Thhde+Y+0w3Cc8YvFeQAFF0Zf6FeS+NHmzEhYCUsRwsGtU7icG4i8OYr0SoNjpgiWLgHS3Qw+T0
	YySP5fu0wgjvJe6v2nGuou0/G9tQmt8UnalsqfWdPXGSzb9EA1RRQ8VaXI9Q=
X-Received: by 2002:a17:906:7c4f:b0:a59:c52b:9933 with SMTP id a640c23a62f3a-a59fb941feemr345559266b.30.1715250961610;
        Thu, 09 May 2024 03:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtoEQm7AdE+bNBLsaGRsy7ychBqHct5AkOFftQoR/VGAJentviCtkGOAF/M1mBzVQW/kuKgg==
X-Received: by 2002:a17:906:7c4f:b0:a59:c52b:9933 with SMTP id a640c23a62f3a-a59fb941feemr345557966b.30.1715250961154;
        Thu, 09 May 2024 03:36:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b1804esm59102366b.223.2024.05.09.03.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 03:36:00 -0700 (PDT)
Message-ID: <27722d8b-ecdc-40d4-af47-8150a8a0a2e6@redhat.com>
Date: Thu, 9 May 2024 12:35:59 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing default handler for the EmbeddedControl OpRegion
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
References: <Zi+0whTvDbAdveHq@kuha.fi.intel.com>
 <CAJZ5v0iAMG251n6yg-h6KCUywK2vSg4sX3FTnOuxcLaEvUwFPQ@mail.gmail.com>
 <ZjtuKzqpfKFbRaUi@kuha.fi.intel.com> <5781917.DvuYhMxLoT@kreacher>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <5781917.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 5/8/24 2:50 PM, Rafael J. Wysocki wrote:
> [Resending because it appears to have got lost, sorry for duplicates.]
> 
> On Wednesday, May 8, 2024 2:20:59 PM CEST Heikki Krogerus wrote:
>> On Mon, May 06, 2024 at 07:45:07PM +0200, Rafael J. Wysocki wrote:
>>> Hi,
>>>
>>> On Mon, Apr 29, 2024 at 4:55 PM Heikki Krogerus
>>> <heikki.krogerus@linux.intel.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> There's a bug that is caused by an EmbeddedControl OpRegion which is
>>>> declared inside the scope of a specific USB Type-C device (PNP0CA0):
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=218789
>>>
>>> And in this bug you are essentially proposing to install the EC
>>> OpRegion handler at the namespace root instead of the EC device.
>>>
>>> This sounds reasonable, although AFAICS this is a matter of modifying
>>> the EC driver (before the EC OpRegion handler is installed by the EC
>>> drvier, ACPICA has no way to handle EC address space accesses anyway).
>>>
>>>> It looks like that's not the only case where that OpRegion ID is used
>>>> outside of the EC device scope. There is at least one driver in Linux
>>>> Kernel (drivers/platform/x86/wmi.c) that already has a custom handler
>>>> for the EmbeddedControl OpRegion, and based on a quick search, the
>>>> problem "Region EmbeddedControl (ID=3) has no handler" has happened
>>>> with some other devices too.
>>>
>>> AFAICS, installing the EC address space handler at the EC device
>>> object itself is not based on any sound technical arguments, it's just
>>> been always done this way in Linux.  It's quite possible that the EC
>>> address space handler should have been installed at the namespace root
>>> from the outset.
>>
>> Okay, thank you for the explanation. So can we simply change it like
>> this (I may have still misunderstood something)?
> 
> Roughly speaking, yes, but it is missing an analogous change around
> the removal.
> 
> Please see the appended patch (which I have created independently in
> the meantime).  It doesn't break stuff for me and Andy points out that
> there are examples of EmbeddedControl OpRegions outside the EC device
> scope in the spec (see Section 9.17.15 in ACPI 6.5, for instance).
> 
> So I think that this change can be made relatively safely (but adding Hans and
> Mario to the CC in case they know something that might be broken by it).

+Cc Armin for WMI EC handler 

No objections from me against registering the EC handler at the root,
when I saw that the WMI driver was registering its own handler I was
already wondering why we did not just register the acpi/ec.c handler at
the root level but I did not have time to pursue this further.

One question which I have is does the drivers/acpi/ec.c version handle
read/writes of a width other then 8 bits ? Armin recently added support
for other widths to the WMI version of the OpRegion handler to fix
issues on some laptop models:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c663b26972eae7d2a614f584c92a266fe9a2d44c

Regards,

Hans



>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> index 02255795b800..6b9dd27171ee 100644
>> --- a/drivers/acpi/ec.c
>> +++ b/drivers/acpi/ec.c
>> @@ -1488,7 +1488,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
>>  
>>         if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>>                 acpi_ec_enter_noirq(ec);
>> -               status = acpi_install_address_space_handler_no_reg(ec->handle,
>> +               status = acpi_install_address_space_handler_no_reg(ACPI_ROOT_OBJECT,
>>                                                                    ACPI_ADR_SPACE_EC,
>>                                                                    &acpi_ec_space_handler,
>>                                                                    NULL, ec);
>> @@ -1497,7 +1497,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
>>                         return -ENODEV;
>>                 }
>>                 set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>> -               ec->address_space_handler_holder = ec->handle;
>> +               ec->address_space_handler_holder = ACPI_ROOT_OBJECT;
>>         }
>>  
>>         if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
>>
> 
> ---
>  drivers/acpi/ec.c       |   10 +++++-----
>  drivers/acpi/internal.h |    1 -
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/acpi/ec.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -1488,7 +1488,7 @@ static int ec_install_handlers(struct ac
>  
>  	if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>  		acpi_ec_enter_noirq(ec);
> -		status = acpi_install_address_space_handler_no_reg(ec->handle,
> +		status = acpi_install_address_space_handler_no_reg(ACPI_ROOT_OBJECT,
>  								   ACPI_ADR_SPACE_EC,
>  								   &acpi_ec_space_handler,
>  								   NULL, ec);
> @@ -1497,11 +1497,10 @@ static int ec_install_handlers(struct ac
>  			return -ENODEV;
>  		}
>  		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
> -		ec->address_space_handler_holder = ec->handle;
>  	}
>  
>  	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
> -		acpi_execute_reg_methods(ec->handle, ACPI_ADR_SPACE_EC);
> +		acpi_execute_reg_methods(ACPI_ROOT_OBJECT, ACPI_ADR_SPACE_EC);
>  		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
>  	}
>  
> @@ -1555,8 +1554,9 @@ static void ec_remove_handlers(struct ac
>  {
>  	if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>  		if (ACPI_FAILURE(acpi_remove_address_space_handler(
> -					ec->address_space_handler_holder,
> -					ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
> +						ACPI_ROOT_OBJECT,
> +						ACPI_ADR_SPACE_EC,
> +						&acpi_ec_space_handler)))
>  			pr_err("failed to remove space handler\n");
>  		clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>  	}
> Index: linux-pm/drivers/acpi/internal.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -186,7 +186,6 @@ enum acpi_ec_event_state {
>  
>  struct acpi_ec {
>  	acpi_handle handle;
> -	acpi_handle address_space_handler_holder;
>  	int gpe;
>  	int irq;
>  	unsigned long command_addr;
> 
> 


