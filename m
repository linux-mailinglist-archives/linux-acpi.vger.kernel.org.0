Return-Path: <linux-acpi+bounces-6331-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC59054C5
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 16:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040C21C2107F
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6127217DE04;
	Wed, 12 Jun 2024 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmtsiaQd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE716FF27
	for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2024 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201306; cv=none; b=OAL5nBLi7Yx/ib8Da773bHsBopaSk1SFil9CnWxmG6jnMWC/ZYWuafEMeb7cQPVStjVWs3Z3TC8GMP8FuAgrRJikElytVXWv/YA32nDiW3xWurQbK4WOPfpyBvhYJxwSXDKDXzEgC4RmW3QKNCqltePkH4FQN3BX2MaTo4gqeLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201306; c=relaxed/simple;
	bh=pwvrFhpCY7DxMwnSSLPEF6qWOO6Z0bsLj8T2/zuW9cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUdw0g19pE9LOYe6YHr8kiliSQIEOUaCR9qDC2gkQqjlbGSt429T+yrgSXTdneAFD1Rif+TlGHLLkkF0zIEaIOU+LOadiD0gztlOLRxoipB8tAeXj7y83oybY54RoY8PIolZA76CjEUOBJNtqFyh90JB2CK60UgbeHOqjIMj0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmtsiaQd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718201303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TeQh9DUtZJovG0baLO1M8zjHfkTTuaY3aJ7r5KD/tpU=;
	b=UmtsiaQd1MZU0bLdIRStUwShnvjlEI0FYT+ZXM1TNBggf64SVKmdRqv3YEFZDIah4gdXku
	fhiu53s8w99+XTWugw8mNHxv6ck5ruQ8iAR1NhIftiB4JmRrKebVcw1dafPKS5KnBrf7H6
	BI1Ikvt0f8UuDMq4JST1lRR2iRePdfs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-95SsQLaDM0q73BEwPs9eBA-1; Wed, 12 Jun 2024 10:08:22 -0400
X-MC-Unique: 95SsQLaDM0q73BEwPs9eBA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6e8aa42033so254882866b.1
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2024 07:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201301; x=1718806101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeQh9DUtZJovG0baLO1M8zjHfkTTuaY3aJ7r5KD/tpU=;
        b=OMeodp0XEJ4sQBAhWS+4jD8e+dOmTKK1Su0bP5f66JpUcON+wyO+bufwfUzTkwRkWP
         dBGw/raQ/jTjz1qrk9UKzOSyVtNNzBYI44MDgt2FrtRV4pdviUz1P2SmLhuWZh89We62
         clTvot2l04z39UOpyvatclQLu4SslKl9I5pe/HW1K0OoGgNX8kkwUuYyfNj1fKdU7e0F
         1kR4yURW8kQRKiIHTMDDaE4xDxHIyMQh2jeOqObW8ABE6SxxZueyZ+cWgXmub3HrbsR1
         XI9CSqn38ry2d5MiQCWZ9F0BWYayhcOp8SmX13IQRt2EDck3iy4M+YFkf5zhvPY/1Xc/
         Rh8A==
X-Forwarded-Encrypted: i=1; AJvYcCWOApMSMxoHgUKaXQ+RvCvfRu4vQff5FvFJi5BexQEOHGQT94sLjWQbXOl92wh/eTIHeq7F9a+LqdowjvhRbJWKclNmeiV2M3jaRQ==
X-Gm-Message-State: AOJu0Yy1hXZvqeTxyCjLmz9JoVIQGjIB3R9FtpR5JGvsuyTI3P4xASua
	jVdVQbDI2wNzipbgZRK2m7hkPU0ruBeS/4yKlDmvWZ0SOgxdkAml89IaAAPN5A63D3D+VnTJT9G
	FEdqPIYfRFqjZnE3L8AQSVBGcffoWnW1M9Z0mV3YBfitCfVMNVuYbe7nHTZQ=
X-Received: by 2002:a17:906:bfc9:b0:a68:a843:9014 with SMTP id a640c23a62f3a-a6f47f88b59mr126937166b.18.1718201301126;
        Wed, 12 Jun 2024 07:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbAO8dLPDKFPefRJbpFWySbaJbmIPQuBe3iqTShCNyrBP2yZG1gDfUVcUFPYCcrPx5rdzZFw==
X-Received: by 2002:a17:906:bfc9:b0:a68:a843:9014 with SMTP id a640c23a62f3a-a6f47f88b59mr126935566b.18.1718201300578;
        Wed, 12 Jun 2024 07:08:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1226c190sm509139866b.93.2024.06.12.07.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 07:08:20 -0700 (PDT)
Message-ID: <667b8659-5667-4ecf-902b-f621db5ab8c6@redhat.com>
Date: Wed, 12 Jun 2024 16:08:19 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ACPI: scan: Ignore camera graph port nodes on all
 Dell Tiger, Alder and Raptor Lake models
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
 stable@vger.kernel.org
References: <20240612104220.22219-1-hdegoede@redhat.com>
 <ZmmPjt2cCz-z7B1q@kekkonen.localdomain>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZmmPjt2cCz-z7B1q@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sakari,

On 6/12/24 2:07 PM, Sakari Ailus wrote:
> Hi Hans,
> 
> Thanks for the set.
> 
> On Wed, Jun 12, 2024 at 12:42:20PM +0200, Hans de Goede wrote:
>> It seems that all Dell laptops with IPU6 camera or the Tiger Lake,
> 
> "Seems that"? I don't argue against though as I have little information on
> this, in fact only two systems.

Well it seems that all Dell laptops have the ACPI MIPI DISCO and
at least for all of them there is no "mipi-img-clock-frequency" and
since all our sensor drivers check for a "clock-frequency" attribute now
this is breaking things everywhere AFAICT.

At least that is what is happening on the Dell Latitude 9420 (Tiger Lake)
which I noticed was also broken since ACPI MIPI DISCO support landed in 6.8.

>> Alder Lake and Raptor Lake generations have broken ACPI MIPI DISCO
>> information.
>>
>> Instead of adding a lot of DMI quirks for this, check for these CPU
>> generations and disable ACPI MIPI DISCO support on all Dell laptops
>> with these CPU generations.
> 
> Is there still a need to include linux/dmi.h?

Yes for the dmi_name_in_vendors() check.

>> Fixes: bd721b934323 ("ACPI: scan: Extract CSI-2 connection graph from _CRS")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/internal.h       |  4 ++++
>>  drivers/acpi/mipi-disco-img.c | 28 +++++++++++++++++++---------
>>  2 files changed, 23 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
>> index 2a0e9fc7b74c..601b670356e5 100644
>> --- a/drivers/acpi/internal.h
>> +++ b/drivers/acpi/internal.h
>> @@ -302,6 +302,10 @@ void acpi_mipi_check_crs_csi2(acpi_handle handle);
>>  void acpi_mipi_scan_crs_csi2(void);
>>  void acpi_mipi_init_crs_csi2_swnodes(void);
>>  void acpi_mipi_crs_csi2_cleanup(void);
>> +#ifdef CONFIG_X86
>>  bool acpi_graph_ignore_port(acpi_handle handle);
>> +#else
>> +static inline bool acpi_graph_ignore_port(acpi_handle handle) { return false; }
>> +#endif
>>  
>>  #endif /* _ACPI_INTERNAL_H_ */
>> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
>> index d05413a0672a..0ab13751f0db 100644
>> --- a/drivers/acpi/mipi-disco-img.c
>> +++ b/drivers/acpi/mipi-disco-img.c
>> @@ -725,14 +725,20 @@ void acpi_mipi_crs_csi2_cleanup(void)
>>  		acpi_mipi_del_crs_csi2(csi2);
>>  }
>>  
>> -static const struct dmi_system_id dmi_ignore_port_nodes[] = {
>> -	{
>> -		.matches = {
>> -			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> -			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
> 
> I believe the patch adding XPS 9320 has been merged so reverting that first
> might help backporting. Or maybe it's only in Rafael's testing/for-next
> branches and so can be dropped easily?

I already asked Rafael to drop that since it has not been send to
Linus yet. The idea was that backporting would actually be easier
without adding that to the mix.

Regards,

Hans


> 
>> -		},
>> -	},
>> -	{ }
>> +#ifdef CONFIG_X86
>> +#include <asm/cpu_device_id.h>
>> +#include <asm/intel-family.h>
>> +
>> +/* CPU matches for Dell generations with broken ACPI MIPI DISCO info */
>> +static const struct x86_cpu_id dell_broken_mipi_disco_cpu_gens[] = {
>> +	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
>> +	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
>> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
>> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
>> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
>> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
>> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
>> +	{}
>>  };
>>  
>>  static const char *strnext(const char *s1, const char *s2)
>> @@ -761,7 +767,10 @@ bool acpi_graph_ignore_port(acpi_handle handle)
>>  	static bool dmi_tested, ignore_port;
>>  
>>  	if (!dmi_tested) {
>> -		ignore_port = dmi_first_match(dmi_ignore_port_nodes);
>> +		if (dmi_name_in_vendors("Dell Inc.") &&
>> +		    x86_match_cpu(dell_broken_mipi_disco_cpu_gens))
>> +			ignore_port = true;
>> +
>>  		dmi_tested = true;
>>  	}
>>  
>> @@ -794,3 +803,4 @@ bool acpi_graph_ignore_port(acpi_handle handle)
>>  	kfree(orig_path);
>>  	return false;
>>  }
>> +#endif
> 


