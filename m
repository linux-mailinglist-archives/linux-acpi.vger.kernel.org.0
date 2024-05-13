Return-Path: <linux-acpi+bounces-5787-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FFB8C3D6B
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 10:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0AC1C21476
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 08:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003B21487CC;
	Mon, 13 May 2024 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBcGlOvJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919D147C84
	for <linux-acpi@vger.kernel.org>; Mon, 13 May 2024 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589564; cv=none; b=W6pOCwQQAQJFooRzN/eswm9e7gTTHB/ht3dWDMH9y+frdt7UaULFtlDI0oeo3U47x2eCAvUqdN0lcrO0VDm+cKuDlwqssi2nk5JycwyIfVci4yQxwUca+zTNlH2/Y+sbbMiy2RtSX+N4BOub2lZ6Cm/HglV02q+7gxYzWXbV90c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589564; c=relaxed/simple;
	bh=xu3qLH3KAqGeXAe+wySJk/AxLkLnUen062a0S8lS+5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M3GKYxKO835n79rbon7tgFGDrMP3TOek2H2zCQqScG0+W/sizbMPlMfz44OWbWuVYcJLu2Fp96IPBG+A2E35TTrPIBYwTvlc/8r3WgUk6ClPxOh9ziwtmY+j2vdJIbPCwtnb6jMVanjawjd0UQNCPB9w/Xa0wmBIKa0LkXIlyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBcGlOvJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715589562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFXGqSIkyTAMybQe23aWDxPcyyUfYDtwAeH1eyZFLGs=;
	b=KBcGlOvJqrJ77FB/yRaPA5wwBtus7FrA4fkFS6rbaoL5AAdbuvZAB5//GZVYyTcSNi/FT6
	zFh0EYyl4y2FSubdBULxKvTtzgwqJebxI9AMK7w1Hb6ah0tJL7JYp3U9xpBB3v+UjtVaMw
	AcFaSTBynl+0kqJ2yzGt8mYTuRAEByg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-FiMPDQkZOBSs78lL7cmPIg-1; Mon, 13 May 2024 04:39:20 -0400
X-MC-Unique: FiMPDQkZOBSs78lL7cmPIg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a59cbb6f266so278035966b.3
        for <linux-acpi@vger.kernel.org>; Mon, 13 May 2024 01:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715589559; x=1716194359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFXGqSIkyTAMybQe23aWDxPcyyUfYDtwAeH1eyZFLGs=;
        b=M3QD86XI9Q0DGWzUfLeRaDDn8m6Z+EIe2HUsRMwFs27xObyHIx/eCfiTy24mejajq9
         H4j2YteNM1ofsWkO5T89xxx2evDryi7uzSAzxIzlB88Ua/2VkAS34lgoW8wHgP80MnGm
         6I1NClpN4MzzOt76U6SAxgdCSZQyy+JRE25AdQ42ErU969cDi7hxZBiEyykg9zCYw4A5
         wQMCU4zWHjsbl+8687rK/yXh5siza9jkuJq8s4vVjypb4UHAYEqDPNpfZT5KdjRh27ZT
         yjJUMZijnBu3YfAC0Zkmg5C5BvChFND0BxhuSCYDzukMqoBF2ve5DHtCTlIDb4C3UDNp
         eWcg==
X-Forwarded-Encrypted: i=1; AJvYcCWdUiSXyRGKhwbni5XWSvyzzO0CVMUheo+YaqNzdD1Gt/HnEKlZRGrCYrM5kRLQ3UPrnlicyWQ5ceRQ1uYo4cHRwVR+gB6sAvpHFA==
X-Gm-Message-State: AOJu0YzrVdfRBallUVYMLXd5MBW1UTJnng6sWz71jknTH0L5cHg7wf0n
	cGQ8s8AiMJY4teVhd0WefjczIwg2DOMV2WfmQ0HN1IVJMlJSTGOQgkXV4OT72d1wbSngJ83WYKb
	hBAa6XS35xr9N2PBUlaGDP18KC8EGM2bUu/CT/DbzoAatnVqb0BV7qZ7Wwde9PKR3xZ0=
X-Received: by 2002:a17:906:66ca:b0:a59:c2c3:bb4c with SMTP id a640c23a62f3a-a5a2d675a9dmr803342266b.70.1715589558854;
        Mon, 13 May 2024 01:39:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAYMUvPAgKG1/Dn2DN+IH/Xl+9GnDev7DUS8ig8zq3P229TKqP/dEy/Pr/PBub/ElY0kVDnw==
X-Received: by 2002:a17:906:66ca:b0:a59:c2c3:bb4c with SMTP id a640c23a62f3a-a5a2d675a9dmr803340466b.70.1715589558430;
        Mon, 13 May 2024 01:39:18 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894da1sm565624066b.89.2024.05.13.01.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 01:39:18 -0700 (PDT)
Message-ID: <2db5beba-500b-458e-9fc3-f05bb982172c@redhat.com>
Date: Mon, 13 May 2024 10:39:17 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Use vendor backlight on Lenovo X1 Carbon.
To: dengxiang <dengxiang@nfschina.com>, lenb@kernel.org, rafael@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 wanghuiqiang@huawei.com, prime.zeng@hisilicon.com, tony.luck@intel.com
References: <20240513033834.9174-1-dengxiang@nfschina.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240513033834.9174-1-dengxiang@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi dengxiang,


On 5/13/24 5:38 AM, dengxiang wrote:
> Lenovo X1 Carbon advertises both native and vendor backlight
> control interfaces.But Linux defaults to picking the native ACPI
> video backlight interface, which will make that the vendor
> zx_backlight interface to not work.

A couple of remarks / questions:

1. Looking at the strings you match on this is not for a Lenovo X1 Carbon,
but rather for a Lenovo Kaitan model ?  So it seems that the commit message
and the comment for the quirk need some work.
	
2. I have never heard of a zx_backlight interface before and there certainly
is no upstream driver providing this. I believe you need to explain what
is going on in a bit more detail here and then we can see if this really is
the best way to fix this. It seems that these Lenovo Kaitan laptops are
using Zhaoxin Kaixian x86 processors with integrate graphics. I would expect
the zx_backlight interface to be provided by the driver for the Zhaoxin Kaixian
integrated graphics in this case. And if that is the case then the integrated
graphics driver should use BACKLIGHT_RAW (aka native) for the backlight type
and with that change this quirk should not be necessary .

3. Vendor specific backlight interfaces are normally only found on really
old laptops. Since Windows XP laptops typically use the ACPI backlight
interface and since Windows 8 they typically use the GPU's native
backlight driver. So adding a quirk to use a vendor interface in 2024 is
weird. Again can you explain in a lot more detail what is going on here,
but I guess the backlight class device is provided by the driver for the
integrated graphics and in that case the fix is to simply change the type
of the backlight device registered by the igfx driver to BACKLIGHT_RAW.

4. You posted the same patch twice ?

Regards,

Hans





> 
> Add a DMI quirk to force use of the vendor interface.
> 
> Signed-off-by: dengxiang <dengxiang@nfschina.com>
> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 2cc3821b2b16..e647186b4e83 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -875,6 +875,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
>  		},
>  	},
> +	{
> +	 .callback = video_detect_force_vendor,
> +	 /* Lenovo X1 Carbon */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "KaiTian"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "KaiTian X1 G1d"),
> +		},
> +	},
>  	{ },
>  };
>  


