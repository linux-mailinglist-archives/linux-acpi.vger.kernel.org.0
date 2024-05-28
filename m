Return-Path: <linux-acpi+bounces-6056-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B1E8D222A
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 19:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11DA11F23970
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 17:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8912C173336;
	Tue, 28 May 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7UjQLMH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01211171074
	for <linux-acpi@vger.kernel.org>; Tue, 28 May 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916200; cv=none; b=YuNrbKjJ7sFGlhwXX+roKXt0rm1EKJooFVx1gPEvMBG2jptX2w6fgI5nWLUr+LJc3zGw5DB8eYYE95xLLM1dfs+U9El5HrLtW81JlSKCnvm2myxMvGqtchSjUiGW/8d5ooN66X/hHJal25j/RfdX5EowvSE99pmOxxsG3nQZPPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916200; c=relaxed/simple;
	bh=AR6U/qaELEoqk8nQWg6NpFQNeo717uJTQM3pryiZM2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tR4sfeNEDi6HuIeITRI2Y9wJdlBLFU0HLvJtiTixe5CC46PCf4xdC2Lr/QD+zpr3a9QHgQBuzekDpN72tksGzVyjy7TOrGOSFD8NoZ+wIuRB3xoBifCTWMSf0F1d9rWjpHaxcx1iS9TdiKyZxMoUTwIn11lFW4qMm8QsJJXGpsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7UjQLMH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716916197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35VQHwWk0//mBlvImqaujEfVCW2jrOIkEafBbzr68rM=;
	b=B7UjQLMH5cK6vFxswavgaURIq0RL9jmzVc7sFLzXChaPWkXwWantJa6hl5vYZdm6tN/aTa
	uCvJXH/pv0GVO7O0MIxk4GleOW5T0zGy21Qonhltb3WX85RzLt2LsdZOp59NYUMryp7F0A
	ABWzfQ32QNvi5JGerqlccBX2iaPK0G8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-nzZOsMkDPTOoBgoNg6JzSg-1; Tue, 28 May 2024 13:09:56 -0400
X-MC-Unique: nzZOsMkDPTOoBgoNg6JzSg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5785c7f4d46so686741a12.3
        for <linux-acpi@vger.kernel.org>; Tue, 28 May 2024 10:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716916195; x=1717520995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35VQHwWk0//mBlvImqaujEfVCW2jrOIkEafBbzr68rM=;
        b=hgMTYtErQHEw4Lw+SMpCL7B7tlO/YZGkhIrxC7RlMBRBSmF6t5hhHU1FO2SuLDAXek
         WhCR83l9RHfBlL+MEbhdX+GFe76ptB3TRudcSf6m64LYjgraCXRzMGkWkn2e4x0ZxgNu
         oaoB52ZKDtF4pcEIaEDEwderkPcIoIKjNJJ/dYQMYYNVuhhBGKzdZ3SSZBfCwihK+Upc
         Dz5csPVrmeWroMNnxPDN+LgSdxMPhL98W6c5BwvC6fZbpDBOXvoX9IFG9QQChaiIoH0c
         Mq0VO+3AOH5T7HyEHuJy43bhXyEQvQzqtpL7gcxHGY8wAMoCDLmC0QRuntbWCC+4tXlK
         VopQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAI//a8PltMy91oEClcZjsRwcHSQEWumfZXSWK7AH68iE6ubw/iAJuY4t9lqq0smxxzXu5PjnfmDZ3/MhArvGB1lfMvhl3rqAFpg==
X-Gm-Message-State: AOJu0YyJ8ZzllsqnmowNtv5DnjTez3xisWZLPhLcKgQTD92NLM/jsRBh
	eHya0Xg1+IqbuInYBrBMosN6H+FuNVzsclG2yiRbgPmRSK+zXKVoSLcLgVf1mUnHPwJTn6Hs1Wr
	vZjCr0L8q9uIP8L0Hl8qA27vfu++meub1sgSelILHN2I2p3MiNKHZ/RErlOs=
X-Received: by 2002:a50:998e:0:b0:572:7bda:1709 with SMTP id 4fb4d7f45d1cf-578518f04ddmr8884726a12.9.1716916195148;
        Tue, 28 May 2024 10:09:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHisjcCOLlmts/18OlmSuIGYLeswwiHjRkyoWnS+26pyPDJbbrZR2whGmmavfsDxJfHysbVGg==
X-Received: by 2002:a50:998e:0:b0:572:7bda:1709 with SMTP id 4fb4d7f45d1cf-578518f04ddmr8884705a12.9.1716916194690;
        Tue, 28 May 2024 10:09:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:e7a9:b143:57e6:261b? (2001-1c00-2a07-3a01-e7a9-b143-57e6-261b.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:e7a9:b143:57e6:261b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579deb8f406sm2324565a12.34.2024.05.28.10.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 10:09:54 -0700 (PDT)
Message-ID: <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
Date: Tue, 28 May 2024 19:09:53 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Genes Lists <lists@sapience.com>
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
 wentong.wu@intel.com, linux-media@vger.kernel.org, linux-acpi@vger.kernel.org
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sakari,

On 5/28/24 10:44 AM, Sakari Ailus wrote:
> Ignore camera related graph port nodes on Dell XPS 9320. They data in BIOS
> is buggy, just like it is for Dell XPS 9315. The corresponding software
> nodes are created by the ipu-bridge.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Hi,
> 
> Could you test this and see whether it fixes the warning?
> 
> The camera might work with this change, too.

Thank you I just received a Dell XPS 13 plus 9320 myself to use
for VSC testing and I can confirm that with this patch 6.10.0-rc1
works, including giving a picture with the libcamera software ISP +
3 small libcamera patches.

Regards,

Hans




> 
> - Sakari
> 
>  drivers/acpi/mipi-disco-img.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
> index d05413a0672a..bf9a5cee32ac 100644
> --- a/drivers/acpi/mipi-disco-img.c
> +++ b/drivers/acpi/mipi-disco-img.c
> @@ -732,6 +732,12 @@ static const struct dmi_system_id dmi_ignore_port_nodes[] = {
>  			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
>  		},
>  	},
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9320"),
> +		},
> +	},
>  	{ }
>  };
>  


