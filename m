Return-Path: <linux-acpi+bounces-10539-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78A8A0B2AD
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 10:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98B73A3916
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 09:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27232397AB;
	Mon, 13 Jan 2025 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNVsjbnN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4D1239787
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760355; cv=none; b=hzdQS8hll0zimYBLCryKeC/d/XNeKH8d069/QTNhUtdtbf+cUvCX0Cuy6JvADr4FqQD3a8/dr9+N3hc/QnhTKzyopvrzqbgCG8gWK6bOraejLO4b9Wu9Xsqyou/Og1OsYPnbQwEMAienqQtszj6P8PvBRu6JF06CXxx4TL2BFtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760355; c=relaxed/simple;
	bh=I7jtrYFX8NwyBNgoJwjFGDHlT+nlofEimAek6xAmWuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzY+pCWMHcPgW+XM3BxR5F98I+I1pHEwopEikEuUHDV2hSNbf4nJrs9W4MicGKFiM0FmYsP6Z+wRysmaFQ89NTeRZq/b7jHFcKGFHWOY2yT24TaKWCsMjjI4ajG1taOv9yO+ZAD3FXefm3hJYH6FdAUdyyPXNqwoISuOgIOx9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNVsjbnN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736760353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Anfkmk5eIXHRBtHcAoLzGmn+FA7n8XKUaOMpxGXT8us=;
	b=WNVsjbnNFe49d26YdXLkcTiczGm2VmRM5HLl67nUh2Bo3v1VOaXdNB497pnE36aYlSva8O
	2YlB4QAUlacFk2ZaTteEltmXuAskkn8S0LF+l4dBaHuOc6XpvcCeZIlgiA7jeVF54GQPH1
	/r5MAdK0jHTOSTb4+lHPtK8zF86D/5g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-Zy853x64M1mdMEpL5t5tug-1; Mon, 13 Jan 2025 04:25:51 -0500
X-MC-Unique: Zy853x64M1mdMEpL5t5tug-1
X-Mimecast-MFC-AGG-ID: Zy853x64M1mdMEpL5t5tug
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d3d9d6293fso3436489a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2025 01:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760350; x=1737365150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Anfkmk5eIXHRBtHcAoLzGmn+FA7n8XKUaOMpxGXT8us=;
        b=YsZYfzPyLdfMjx5xdDu1NRw2JsmjkUVfHFdqgkm3hygX0lLrJCInHDnu3bw0y0BXDz
         AnPXTmhP3bkYk8dTdjJ/TCw3difTf3XGDNnnJerYzxtmQN8PAh5q1R4KjNi0T1qgpVdx
         fZ7jPtkCB4g6wI4fD2KuqKeNB78WKjKKY8fqno04Vf06dK0uu6AOCtL8onKa3A9zTELB
         1fLi5uR0VcgAtl4wYX8NB7va/IBQCgCkwoPVmXwYcbpQBFN8Jr/YVnsceeYmfwEf9Mit
         evHhLa0JqPf6c5VVhJ/YeBT+/7UwpJt8fNKHt8AkaA4yaztsZMfoECUvLeheC2O82nxL
         Mi6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5U7XoPPlGhKY+TMPNbismhsSC8wD33OBzOpY8EMHeShup8H/NuV5T+LLEtfw2Wv1XTA8UI3h5HkGc@vger.kernel.org
X-Gm-Message-State: AOJu0YwK5dFsJdFfselbsYbL4eH8n4uyp3bM1MSMPQ1gwYBYqHXlF7p1
	eXJxS5blql3MtQFYQiMs88OEPFC8ERls05bQPanyXiofKiizd2I4CxsR2uCzGoDBrR3GyURIFGs
	woP3R3ulx07oDJ66iFrPDsnmsv2sR9QelEy8chDB1WvTIsCXlEyIPqFUwx34=
X-Gm-Gg: ASbGncvF0g6aBPWXMmnXO2r0KLj9MBY7FOZw2u9Egy1zttG6nQsmH4XXSI6MLR9ouLB
	BVzJEkiaJ++SYOlgomlhCk48hIN2cYUjbzssvX46An13HMFW0aqYahekVToKCJTBwjszC13fz1H
	1ObPW3Le6UreWgn1szwMkc81BOn0mvaQETZcood1kELZjwedjQJTLfzU4hKfFu83JAr0MzZ7SzF
	x+MBOmVSk+V5k46PKDYxzWOmnA32ejXNefYUHQ7J0iy2ZkYqk9q0hRQQPSV
X-Received: by 2002:a05:6402:360c:b0:5d0:e826:f0da with SMTP id 4fb4d7f45d1cf-5d972e1683fmr19533140a12.16.1736760350250;
        Mon, 13 Jan 2025 01:25:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG78H0pXhzhxaOz7jwatHbOLLwf8gzKXFnmuzkS+oexEXq4wWGsB1QoLdJwllz3q9jZAAjDsQ==
X-Received: by 2002:a05:6402:360c:b0:5d0:e826:f0da with SMTP id 4fb4d7f45d1cf-5d972e1683fmr19533112a12.16.1736760349793;
        Mon, 13 Jan 2025 01:25:49 -0800 (PST)
Received: from [10.40.98.179] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d990469ee8sm4720711a12.70.2025.01.13.01.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 01:25:49 -0800 (PST)
Message-ID: <809d617e-b0e5-4322-a6fe-00923babe5f3@redhat.com>
Date: Mon, 13 Jan 2025 10:25:47 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: video: Fix random crashes due to bad kfree
To: Chris Bainbridge <chris.bainbridge@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
 regressions@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Z2yQvTyg_MWwrlj3@debian.local>
 <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
 <Z2yw_eJwR5ih1Npr@debian.local>
 <CAJZ5v0i=ap+w4QZ8f2DsaHY6D=XUEuSNjyQ-2_=DGOLfZjdn+w@mail.gmail.com>
 <Z4K_oQL7eA9Owkbs@debian.local>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z4K_oQL7eA9Owkbs@debian.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11-Jan-25 7:59 PM, Chris Bainbridge wrote:
> Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
> available for eDP") added function dm_helpers_probe_acpi_edid, which
> fetches the EDID from the BIOS by calling acpi_video_get_edid.
> acpi_video_get_edid returns a pointer to the EDID, but this pointer does
> not originate from kmalloc - it is actually the internal "pointer" field
> from an acpi_buffer struct (which did come from kmalloc).
> dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
> resulting in memory corruption which leads to random, intermittent
> crashes (e.g. 4% of boots will fail with some Oops).
> 
> Fix this by allocating a new array (which can be safely freed) for the
> EDID data, and correctly freeing the acpi_buffer pointer.
> 
> The only other caller of acpi_video_get_edid is nouveau_acpi_edid:
> remove the extraneous kmemdup here as the EDID data is now copied in
> acpi_video_device_EDID.
> 
> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
> ---> Changes in v2:
> 	- check kmemdup() return value
> 	- move buffer management into acpi_video_device_EDID()
> 	- return actual length value of buffer

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/acpi_video.c              | 50 ++++++++++++++------------
>  drivers/gpu/drm/nouveau/nouveau_acpi.c |  2 +-
>  2 files changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 8274a17872ed..3c627bdf2d1b 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -610,16 +610,29 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
>  	return 0;
>  }
>  
> +/*
> + *  Arg:
> + *	device	: video output device (LCD, CRT, ..)
> + *	edid    : address for returned EDID pointer
> + *	length  : _DDC length to request (must be a multiple of 128)
> + *
> + *  Return Value:
> + *	Length of EDID (positive value) or error (negative value)
> + *
> + *  Get EDID from ACPI _DDC. On success, a pointer to the EDID data is written
> + *  to the edid address, and the length of the EDID is returned. The caller is
> + *  responsible for freeing the edid pointer.
> + */
> +
>  static int
> -acpi_video_device_EDID(struct acpi_video_device *device,
> -		       union acpi_object **edid, int length)
> +acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length)
>  {
> -	int status;
> +	acpi_status status;
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  	union acpi_object *obj;
>  	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
>  	struct acpi_object_list args = { 1, &arg0 };
> -
> +	int ret;
>  
>  	*edid = NULL;
>  
> @@ -636,16 +649,17 @@ acpi_video_device_EDID(struct acpi_video_device *device,
>  
>  	obj = buffer.pointer;
>  
> -	if (obj && obj->type == ACPI_TYPE_BUFFER)
> -		*edid = obj;
> -	else {
> +	if (obj && obj->type == ACPI_TYPE_BUFFER) {
> +		*edid = kmemdup(obj->buffer.pointer, obj->buffer.length, GFP_KERNEL);
> +		ret = *edid ? obj->buffer.length : -ENOMEM;
> +	} else {
>  		acpi_handle_debug(device->dev->handle,
>  				 "Invalid _DDC data for length %d\n", length);
> -		status = -EFAULT;
> -		kfree(obj);
> +		ret = -EFAULT;
>  	}
>  
> -	return status;
> +	kfree(obj);
> +	return ret;
>  }
>  
>  /* bus */
> @@ -1435,9 +1449,7 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
>  {
>  	struct acpi_video_bus *video;
>  	struct acpi_video_device *video_device;
> -	union acpi_object *buffer = NULL;
> -	acpi_status status;
> -	int i, length;
> +	int i, length, ret;
>  
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> @@ -1477,16 +1489,10 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
>  		}
>  
>  		for (length = 512; length > 0; length -= 128) {
> -			status = acpi_video_device_EDID(video_device, &buffer,
> -							length);
> -			if (ACPI_SUCCESS(status))
> -				break;
> +			ret = acpi_video_device_EDID(video_device, edid, length);
> +			if (ret > 0)
> +				return ret;
>  		}
> -		if (!length)
> -			continue;
> -
> -		*edid = buffer->buffer.pointer;
> -		return length;
>  	}
>  
>  	return -ENODEV;
> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> index 8f0c69aad248..21b56cc7605c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> @@ -384,7 +384,7 @@ nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
>  	if (ret < 0)
>  		return NULL;
>  
> -	return kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
> +	return edid;
>  }
>  
>  bool nouveau_acpi_video_backlight_use_native(void)


