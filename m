Return-Path: <linux-acpi+bounces-6238-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D268FF46C
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 20:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04AF288CA7
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 18:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C138199EAA;
	Thu,  6 Jun 2024 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzwmAboF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D443B1993AB
	for <linux-acpi@vger.kernel.org>; Thu,  6 Jun 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697568; cv=none; b=AVLbEGH/1bYRpUoXIcVA5P20aPSJ5WjYm4rrm81WFlqka851/BcBYAvoqzqNt2klWQlfs6EJdeXSNTvQWsCWIu80R88KWP+0fuyI8dN9Ovw+tkDGgSGQvX3bJ3yURLgN/AU9aCg66BAZNntY3Wcn1oWOWsdp0Bw4FPVm4s6dFZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697568; c=relaxed/simple;
	bh=g18wcZ4Vrm3OPpEKR5GaSFXC3qL8zJOqLvXNZzYFeuM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LbhCKtTG59l/LgG2H66fvhkbS6qOA8nMMBd2qviRchWEUANBTzhoWMiwLV9gMjexbJCGGrE3mmMXwW2remNpAVqpX1+Toq7m5LoqddSa+moyNemf1Y9w3NmGm77AMmW6DajTedmY58NTT/MYbFn3Q5liiL5yqr3sszUdV7pHrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzwmAboF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717697564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeMRLeH8AVI7a9rTTiY6E9/CXZa2WPt/Gto/LcU6z5E=;
	b=RzwmAboFlUSkiM+trl8qwAkVK+wiQEtAeaVMzuABe9p3KOszICqYtlzgWLbw2E9lNaFVRx
	PywJw/nBU2I76WL+huhLjgzd7N/Zj4GOe+fGOfbN7zsCL6TzaC5undJoDSMlTaniTzQJqo
	lW6LxOS0VcZUYPOZYY8YlrS8jXe7Q/A=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-8RDpnzztORy1ff84etKe_w-1; Thu, 06 Jun 2024 14:12:41 -0400
X-MC-Unique: 8RDpnzztORy1ff84etKe_w-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ea93bbf517so9858851fa.0
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jun 2024 11:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717697560; x=1718302360;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeMRLeH8AVI7a9rTTiY6E9/CXZa2WPt/Gto/LcU6z5E=;
        b=t2BtVQ5rOHmY7jBQpC7C9PRxwxRlnnPZVv34rrX+YtVXV6/m58QjGnE/lZq/H/mvPe
         OsH6E0MCO/M9bbMosNK075P1rpfPOYJ4j63QQeC/t8fh89E45bQ87O4z+p/+gDIb/eiG
         itwrkeZid6s3txW/cp9VS477/sYeOsc042L71YLMz0bhqZvoPe2uCj+d9irpC6xEL+A1
         LhE2AanYHVcC4gxKqI5lpIXCNMP3nXONOw6NO0l/iQgHOHZivsZSRkfPIjBO1Mnaui8a
         S7QSKpanbX5Z53MHspivw84qixMaFvEgOukILAofTJi3O9lGlUpJcs1IYLpQs9ovqNNs
         Q5Og==
X-Forwarded-Encrypted: i=1; AJvYcCWlbb09AyG+1D+9bsgJE+9WGdGDvWbNokFEU73zUiYbZRd8Cyvbc3tjJbWKlY3wclMxNRf6EYQI0eWKhIplHtRH+WGpb9slL/xMdA==
X-Gm-Message-State: AOJu0Yylqp+PmbtDTNnSg3zH5gPUlA7Xx8Kyqw91/Lrv7501jS/H65q5
	5pFAUAgUCfr+IOkC67oHRv16ZwSioPJtEFYjyjgiFM/MplCm0RaQhl+UApbZBQOvJU7G3GvdmTZ
	AlM0HXPjz4lN5+UnPlL3cabp680XqRrJhYCXNWK92jUc/rJwf3Io067L++4U=
X-Received: by 2002:a2e:be0d:0:b0:2ea:bc04:9876 with SMTP id 38308e7fff4ca-2eadce712d0mr3647981fa.38.1717697560053;
        Thu, 06 Jun 2024 11:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA8ZzHNP1/hcWkbYv2OrPty7pGVWuhlHWVUFyoEu0CW/LdPcqaEzki1tsMBhjPdaeTrSwq3Q==
X-Received: by 2002:a2e:be0d:0:b0:2ea:bc04:9876 with SMTP id 38308e7fff4ca-2eadce712d0mr3647841fa.38.1717697559679;
        Thu, 06 Jun 2024 11:12:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae13dc46sm1465248a12.52.2024.06.06.11.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 11:12:38 -0700 (PDT)
Message-ID: <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
Date: Thu, 6 Jun 2024 20:12:37 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
From: Hans de Goede <hdegoede@redhat.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Genes Lists <lists@sapience.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
 wentong.wu@intel.com, linux-media@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
 <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

+To: Rafael since this was Cc-ed to linux-acpi but never send
to Rafael directly.

Rafael this fixes a crash in 6.10-rc1 for some users and is necessary
to make the cameras work on the Dell XPS 13 plus 9320 .

On 5/28/24 7:09 PM, Hans de Goede wrote:
> Hi Sakari,
> 
> On 5/28/24 10:44 AM, Sakari Ailus wrote:
>> Ignore camera related graph port nodes on Dell XPS 9320. They data in BIOS
>> is buggy, just like it is for Dell XPS 9315. The corresponding software
>> nodes are created by the ipu-bridge.
>>
>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> ---
>> Hi,
>>
>> Could you test this and see whether it fixes the warning?
>>
>> The camera might work with this change, too.
> 
> Thank you I just received a Dell XPS 13 plus 9320 myself to use
> for VSC testing and I can confirm that with this patch 6.10.0-rc1
> works, including giving a picture with the libcamera software ISP +
> 3 small libcamera patches.

I forgot to add:

Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




>>  drivers/acpi/mipi-disco-img.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
>> index d05413a0672a..bf9a5cee32ac 100644
>> --- a/drivers/acpi/mipi-disco-img.c
>> +++ b/drivers/acpi/mipi-disco-img.c
>> @@ -732,6 +732,12 @@ static const struct dmi_system_id dmi_ignore_port_nodes[] = {
>>  			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
>>  		},
>>  	},
>> +	{
>> +		.matches = {
>> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9320"),
>> +		},
>> +	},
>>  	{ }
>>  };
>>  


