Return-Path: <linux-acpi+bounces-6166-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467FB8FAE37
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jun 2024 11:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F411F2608D
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jun 2024 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FC414374B;
	Tue,  4 Jun 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKkfFpk2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31725140380
	for <linux-acpi@vger.kernel.org>; Tue,  4 Jun 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491618; cv=none; b=Y19XEo8+ZMtadLlF2U2Rxlv74OaJOUjX/vC2yhexcydbEHc8q06pW9/gXSbUCwgW1jD7ArP0qdlJTFsvrsud86OM8/AZXrBev92S0v4knWwq33w+3q88Q7eNDtPbuWwZlZOzGzNCfTjiF7Xr7cL9of6aCVxmnyTDYjWfBZr/LJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491618; c=relaxed/simple;
	bh=new+pNwLcD9lH3T0u5RvU2+JVeenHDibA7HvZ7u23XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPuFmU/RCPhyBvMKsnKLCSlVrn4TtTdN1PN82d08MRMqpEFacmHCO5u8ctvO7ufXC7VjGiJBIatob3PG4jwxxqAn4L4MFwB9gxnXCLoiapDvP9RHKobF8BYs/aM9/GtjHaAltMoAF9VcY+C1r10mTAEkyLNrq6E1R+mcfhFB5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKkfFpk2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717491616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFpT3QUEMx9J9L0LrxzioAQBetBLlwnPOzlf7N14yZU=;
	b=LKkfFpk2pCyCgdAGp7n/05YFADkL0H6tSGZVLGyzGAwOn92/WknqcDftWJZEOgdVKQigeT
	af5zeAhS+aNCsyaz/FyUt+Dl56SrtgSslbvhxTMqqJ5vIITXhw2ZefX2ZUXlujzuvv2akI
	tEofh/6A93mvtFykqGuhltGKvQbvO7M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-PNAhSyrDMQe8TLRkL8S0Ww-1; Tue, 04 Jun 2024 05:00:12 -0400
X-MC-Unique: PNAhSyrDMQe8TLRkL8S0Ww-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-57a49b8a27eso346074a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 04 Jun 2024 02:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717491611; x=1718096411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFpT3QUEMx9J9L0LrxzioAQBetBLlwnPOzlf7N14yZU=;
        b=XJT8JrD3NDgjTn0upH20YYsuQXYgC3w4CkSIJ6F8gqJF9zx/bQlUyCwybopLH8qezj
         nE1Z5bBlbUcRnZIfE1KDmiYkQeWRn6zeCnqV7C1YR4P3WY9GFoMkdSlQ1SB/kvEjeXNT
         X2SB+W4Bl/aWOnka5qHZe868Zow8kQA5ACrQYBplHFRTa9gNhWOMcTezAbBV3TbtmT0V
         htg+/54gx+QXk3dZcdZU3hqUFhjinqnM3d46WzsUG0Yndm2iHWR19rfMDG371WsIRDvb
         PkiJf88qQwVM0zkOkgWntrhlKA7esAPWlGx8gMxMD0zRmvFs2ig5CKMJ88nrUXKTD0vC
         Zsng==
X-Forwarded-Encrypted: i=1; AJvYcCXt/9qZhHgGVpT1kMoisnKCmiw9fOa0nSfU2hVv5fA5W6mbhpGnORGi6/6bJ0nfQ65yqkJoR1HVMGai49WwrOBLpej6KO8wPvxjNA==
X-Gm-Message-State: AOJu0Yz/c/TYhJLrCnp6HP7jtD6ua61i0P7AKm3cX+GZ/7pW6ryKZ0wS
	gkseWsttL2lwJufW+W8OIpwA9xL7fAclwbVswTZcgmVCdFv49cyE75eoSPXp2kwexS+LkiPtjSX
	MUr7aANoJJd1Dq9b88/xptFE9q1iRBJ9vOYPEIyxvK47ZfSQNaXH9gD7xqnw=
X-Received: by 2002:a50:9fe1:0:b0:57a:2fd7:c2d1 with SMTP id 4fb4d7f45d1cf-57a365724d6mr5996653a12.40.1717491611611;
        Tue, 04 Jun 2024 02:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9HxdDDjXBkoNajgBxrl8Zq0njsbIpxZMJnVCH9evLqXT+aGsPpAtbO5jLY5O3yvm6yuy6WA==
X-Received: by 2002:a50:9fe1:0:b0:57a:2fd7:c2d1 with SMTP id 4fb4d7f45d1cf-57a365724d6mr5996635a12.40.1717491611111;
        Tue, 04 Jun 2024 02:00:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d594sm7045909a12.69.2024.06.04.02.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 02:00:10 -0700 (PDT)
Message-ID: <77625f15-e183-49e8-8496-b12002cc7dbb@redhat.com>
Date: Tue, 4 Jun 2024 11:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mei: vsc: Fix wrong invocation of ACPI SID method
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Wentong Wu <wentong.wu@intel.com>, Tomas Winkler <tomas.winkler@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org,
 Kate Hsuan <hpa@redhat.com>, linux-kernel@vger.kernel.org
References: <20240603205050.505389-1-hdegoede@redhat.com>
 <Zl42vYs40MJiPxl7@kekkonen.localdomain>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Zl42vYs40MJiPxl7@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/3/24 11:33 PM, Sakari Ailus wrote:
> Hi Hans,
> 
> Thanks for the patch.
> 
> On Mon, Jun 03, 2024 at 10:50:50PM +0200, Hans de Goede wrote:
>> When using an initializer for a union only one of the union members
>> must be initialized. The initializer for the acpi_object union variable
>> passed as argument to the SID ACPI method was initializing both
>> the type and the integer members of the union.
>>
>> Unfortunately rather then complaining about this gcc simply ignores
>> the first initializer and only used the second integer.value = 1
>> initializer. Leaving type set to 0 which leads to the argument being
>> skipped by acpi acpi_ns_evaluate() resulting in:
>>
>> ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments -
>> Caller passed 0, method requires 1 (20240322/nsarguments-232)
>>
>> Fix this by initializing only the integer struct part of the union
>> and initializing both members of the integer struct.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Even though this is a one-liner, figuring out what was actually going
>> wrong here took quite a while.
> 
> I was wondering this with Wentong, too...!
> 
>> ---
>>  drivers/misc/mei/vsc-fw-loader.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/mei/vsc-fw-loader.c b/drivers/misc/mei/vsc-fw-loader.c
>> index ffa4ccd96a10..596a9d695dfc 100644
>> --- a/drivers/misc/mei/vsc-fw-loader.c
>> +++ b/drivers/misc/mei/vsc-fw-loader.c
>> @@ -252,7 +252,7 @@ static int vsc_get_sensor_name(struct vsc_fw_loader *fw_loader,
>>  {
>>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER };
>>  	union acpi_object obj = {
>> -		.type = ACPI_TYPE_INTEGER,
>> +		.integer.type = ACPI_TYPE_INTEGER,
>>  		.integer.value = 1,
> 
> I guess initialising integer.value implies that all integer fields are set
> to zero (and so zeroing type set the line above)?

Yes I was thinking that might be happening too.

> Maybe moving setting type
> below setting integer.value might do the trick as well? ;-)

I was wondering the same thing, but that seems error-prone /
something which may break with different compiler versions.

Actually most code using union acpi_object variables simply
does not initialize them at declaration time.

So I was also considering to maybe change the code like this:

        struct acpi_object_list arg_list;
        union acpi_object *ret_obj;
        union acpi_object param;

	...

        param.type = ACPI_TYPE_INTEGER;
        param.integer.value = 1;

        arg_list.count = 1;
        arg_list.pointer = &param;

        status = acpi_evaluate_object(handle, "SID", &arg_list, &buffer);

Slightly more verbose, but this is basically what all other
callers of acpi_evaluate_object() (with a non NULL arg_list) do.

> It'd be useful to be warned by the compiler in such a case. There are much
> less useful warnings out there.

Ack.

> Excellent finding indeed.
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> This could be cc'd to stable, this warning will display for a lot of
> systems. I.e. I think:
> 
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Cc: stable@vger.kernel.org # for 6.8 and later

Ack.

Regards,

Hans



>>  	};
>>  	struct acpi_object_list arg_list = {
> 


