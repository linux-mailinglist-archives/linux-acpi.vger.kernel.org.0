Return-Path: <linux-acpi+bounces-6871-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDC792FD14
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 16:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F131C20E52
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FF8171E74;
	Fri, 12 Jul 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCIEgAZq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EED16F27E
	for <linux-acpi@vger.kernel.org>; Fri, 12 Jul 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796395; cv=none; b=ZRn45ALZYeNepciPsDmCfaOqqVj3m1itvIiCs6ex4uZ4PCQ4CFePaHLHX+BWn9Gr7HjpS0CHAyuc1Q82iaAe7+/5IUFT6Vrsr6RSh+KtNIdjFY5uMsc2FNiHHcwyrI/E20QHfw29/l8bXqCmTSYO/7mOUckBMijyIT4Rc/4jNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796395; c=relaxed/simple;
	bh=njc0Tryaj+gnTabFhoUKQb0tdpkfmgAYkSWyWDBz2hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQ/nGuXGhDFzwnldVVhbPWNcbNWimr0au7f6k84Qq6NiOiwdP8tSc8h0Hb0MK4U5m2q/xQqbHmUeJRxVRw1JtiPWi2xy8gl1UTFsqfGZ4WC4L/EfNuFUC6n4c1gnDO8FdBRY7NPv9mslg7tzeXQV3cYTPFOyB19Oz7e7+Sj1cPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCIEgAZq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720796392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1pbDIwqRwH2CzZyij/gklhjZFHA6b2MOhWlqjxKvJ0=;
	b=OCIEgAZqdV7X1x6Agvb9GENnfGVN43iD4OtODXf9MJS0fyhj0SbrdihyM46ytJdOsASIoV
	o1SPMThDFx3q3ZetlUYINHEwGvtLEGjzyR9H9MpY0jvAl+T91pGWmXie2CfH8YmIfDDlEs
	amor8NDFRRH/DpMnjedB5U8o7boeLJ8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-1uyW1fAUMYq8hW3mIPCFHw-1; Fri, 12 Jul 2024 10:59:50 -0400
X-MC-Unique: 1uyW1fAUMYq8hW3mIPCFHw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a77e499d040so141420866b.1
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jul 2024 07:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720796389; x=1721401189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1pbDIwqRwH2CzZyij/gklhjZFHA6b2MOhWlqjxKvJ0=;
        b=BeabfVGGGXzvVq5z7AcaGWzLXFYavhhYdUjEcFPXcvH65crx51NO1IaJoNdstKPtKn
         9j+fTKUgyab3omMoajVzkpJV/ZBcrYiykPJqvEcFbHrnN15VuhG7jGopZvdyDdoVA7E0
         rswGExgHmFJYLsxwh2LcbuzFSceUN9IHTTGZCytEUVifkltKsHfUqkwg0tsgiSGsBTxM
         XUwmxhBxzeSZzv5RLMHJfNmBcrwBhpHO0WA/pXnq5IhbN0EbFXTUrKb2+cXo6pj2DS5B
         PXtl84YMXRATJocKGJazAsX92kTFgGMmAIvBTXPxV4cnozraz9l8PFOcqmMkheLJC92H
         RoZw==
X-Forwarded-Encrypted: i=1; AJvYcCUpcJNts8t/J+kM8n3fghJ6rTbVRxO6E+yF7cRq2OjHseGiQ8BewUUCb/Nz1Q2gQzVEzdwytAUYTkW+iHiusG2KqQVVLdCwlJZT6g==
X-Gm-Message-State: AOJu0YxnyxD4NjqwW8dbOSjgCLqnpEmZiZ/gIF/gai2h70gGXwPIgIct
	s1R0Sz3TBZy2NcAeu3dZ88UNIhxsqxdohhuKMaouULScYXP2BkFysStfZJPcVckR2BjS0x5x8Bh
	bTZXEC6Hee2/GWxoCqG6AjrNLhCaP85uB45cnCa9MkPqfEVrAj+usuVdr1bk=
X-Received: by 2002:a17:907:6d26:b0:a77:e0ed:8b8 with SMTP id a640c23a62f3a-a780b6891c0mr1165752266b.9.1720796389619;
        Fri, 12 Jul 2024 07:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjvOoLvnH8hxFK6vCDs4ol5qAbiKmziXZz+dsbtgEWxwWXDvs1Kzyh6Z49EzYanK92V2IYqQ==
X-Received: by 2002:a17:907:6d26:b0:a77:e0ed:8b8 with SMTP id a640c23a62f3a-a780b6891c0mr1165750266b.9.1720796389171;
        Fri, 12 Jul 2024 07:59:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a871ea8sm352811666b.193.2024.07.12.07.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 07:59:48 -0700 (PDT)
Message-ID: <bfe71ef4-2fa2-406b-927d-5b045204dacc@redhat.com>
Date: Fri, 12 Jul 2024 16:59:48 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: EC: Do not release locks during operation region
 accesses
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>
References: <12473338.O9o76ZdvQC@rjwysocki.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <12473338.O9o76ZdvQC@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/4/24 6:26 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is not particularly useful to release locks (the EC mutex and the
> ACPI global lock, if present) and re-acquire them immediately thereafter
> during EC address space accesses in acpi_ec_space_handler().
> 
> First, releasing them for a while before grabbing them again does not
> really help anyone because there may not be enough time for another
> thread to acquire them.
> 
> Second, if another thread successfully acquires them and carries out
> a new EC write or read in the middle if an operation region access in
> progress, it may confuse the EC firmware, especially after the burst
> mode has been enabled.
> 
> Finally, manipulating the locks after writing or reading every single
> byte of data is overhead that it is better to avoid.
> 
> Accordingly, modify the code to carry out EC address space accesses
> entirely without releasing the locks.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
> 
> For 6.12.
> 
> ---
>  drivers/acpi/ec.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/acpi/ec.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -783,6 +783,9 @@ static int acpi_ec_transaction_unlocked(
>  	unsigned long tmp;
>  	int ret = 0;
>  
> +	if (t->rdata)
> +		memset(t->rdata, 0, t->rlen);
> +
>  	/* start transaction */
>  	spin_lock_irqsave(&ec->lock, tmp);
>  	/* Enable GPE for command processing (IBF=0/OBF=1) */
> @@ -819,8 +822,6 @@ static int acpi_ec_transaction(struct ac
>  
>  	if (!ec || (!t) || (t->wlen && !t->wdata) || (t->rlen && !t->rdata))
>  		return -EINVAL;
> -	if (t->rdata)
> -		memset(t->rdata, 0, t->rlen);
>  
>  	mutex_lock(&ec->mutex);
>  	if (ec->global_lock) {
> @@ -847,7 +848,7 @@ static int acpi_ec_burst_enable(struct a
>  				.wdata = NULL, .rdata = &d,
>  				.wlen = 0, .rlen = 1};
>  
> -	return acpi_ec_transaction(ec, &t);
> +	return acpi_ec_transaction_unlocked(ec, &t);
>  }
>  
>  static int acpi_ec_burst_disable(struct acpi_ec *ec)
> @@ -857,7 +858,7 @@ static int acpi_ec_burst_disable(struct
>  				.wlen = 0, .rlen = 0};
>  
>  	return (acpi_ec_read_status(ec) & ACPI_EC_FLAG_BURST) ?
> -				acpi_ec_transaction(ec, &t) : 0;
> +				acpi_ec_transaction_unlocked(ec, &t) : 0;
>  }
>  
>  static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 *data)
> @@ -873,6 +874,19 @@ static int acpi_ec_read(struct acpi_ec *
>  	return result;
>  }
>  
> +static int acpi_ec_read_unlocked(struct acpi_ec *ec, u8 address, u8 *data)
> +{
> +	int result;
> +	u8 d;
> +	struct transaction t = {.command = ACPI_EC_COMMAND_READ,
> +				.wdata = &address, .rdata = &d,
> +				.wlen = 1, .rlen = 1};
> +
> +	result = acpi_ec_transaction_unlocked(ec, &t);
> +	*data = d;
> +	return result;
> +}
> +
>  static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
>  {
>  	u8 wdata[2] = { address, data };
> @@ -883,6 +897,16 @@ static int acpi_ec_write(struct acpi_ec
>  	return acpi_ec_transaction(ec, &t);
>  }
>  
> +static int acpi_ec_write_unlocked(struct acpi_ec *ec, u8 address, u8 data)
> +{
> +	u8 wdata[2] = { address, data };
> +	struct transaction t = {.command = ACPI_EC_COMMAND_WRITE,
> +				.wdata = wdata, .rdata = NULL,
> +				.wlen = 2, .rlen = 0};
> +
> +	return acpi_ec_transaction_unlocked(ec, &t);
> +}
> +
>  int ec_read(u8 addr, u8 *val)
>  {
>  	int err;
> @@ -1323,6 +1347,7 @@ acpi_ec_space_handler(u32 function, acpi
>  	struct acpi_ec *ec = handler_context;
>  	int result = 0, i, bytes = bits / 8;
>  	u8 *value = (u8 *)value64;
> +	u32 glk;
>  
>  	if ((address > 0xFF) || !value || !handler_context)
>  		return AE_BAD_PARAMETER;
> @@ -1330,13 +1355,25 @@ acpi_ec_space_handler(u32 function, acpi
>  	if (function != ACPI_READ && function != ACPI_WRITE)
>  		return AE_BAD_PARAMETER;
>  
> +	mutex_lock(&ec->mutex);
> +
> +	if (ec->global_lock) {
> +		acpi_status status;
> +
> +		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
> +		if (ACPI_FAILURE(status)) {
> +			result = -ENODEV;
> +			goto unlock;
> +		}
> +	}
> +
>  	if (ec->busy_polling || bits > 8)
>  		acpi_ec_burst_enable(ec);
>  
>  	for (i = 0; i < bytes; ++i, ++address, ++value) {
>  		result = (function == ACPI_READ) ?
> -			acpi_ec_read(ec, address, value) :
> -			acpi_ec_write(ec, address, *value);
> +			acpi_ec_read_unlocked(ec, address, value) :
> +			acpi_ec_write_unlocked(ec, address, *value);
>  		if (result < 0)
>  			break;
>  	}
> @@ -1344,6 +1381,12 @@ acpi_ec_space_handler(u32 function, acpi
>  	if (ec->busy_polling || bits > 8)
>  		acpi_ec_burst_disable(ec);
>  
> +	if (ec->global_lock)
> +		acpi_release_global_lock(glk);
> +
> +unlock:
> +	mutex_unlock(&ec->mutex);
> +
>  	switch (result) {
>  	case -EINVAL:
>  		return AE_BAD_PARAMETER;
> 
> 
> 


