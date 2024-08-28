Return-Path: <linux-acpi+bounces-7921-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3512896230B
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 11:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B638D1F2170E
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B077415E5AB;
	Wed, 28 Aug 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdu/dfRV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7617158543;
	Wed, 28 Aug 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836249; cv=none; b=fR6F5oTVpoY5VSdFqGkxpdUG8+u86bOo7/OeKHm6gAg2qIwvP8UcW2kcrryXHifzRtjDeRGOhSMcDCoVjiSPQiv9EIvT47g531ELj+Wqp8KF4Oal0ElpKNc9E8Gvnzl63KH6yWQvO2pJb6BrmA0XSEDUl5cjc3Tm7EvRXasVRfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836249; c=relaxed/simple;
	bh=zSHKO3j33Ria7zyczy79YyyVNqfKsgActvy2LbiGQV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMpFiJ9ARmFaQQGRod258pIEp0GA6yhKfPJi86hnneC0QCon7f2EtRYFeqFk5MD6YMph5XOREDHOtMzCmrDm/rZn13DehMsWZZiCxR/zl0kI4Zup7mSM4JROZYN2htZ35DIwcd5dSOFA95q4qF519Xgh1/K61TbHWYDEgeAv8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdu/dfRV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3719753d365so3592136f8f.2;
        Wed, 28 Aug 2024 02:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724836246; x=1725441046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x3niQjXZJR5D3vooE/mqJ9Cy41uU536hIxUZ/GtxSL8=;
        b=gdu/dfRVZFpumaFqQEvACr+rscBpBbtdHBoaQwGJ3gfV9woODBKLe6CbaPdoyF7gJN
         Eh4Jkpvd3Mkf1wZG2uwBCzPW1zxiQjDd9BJaO3SpL1PA82Nkf2yThMd7ALIx+pzciDnP
         WgODzsElulGQ60wU4l6bfGbPEk+SQFHW6ZEg/2MzCb/3SSRfkobb1shXgtvHmSNfd9dY
         ODarThN/XIg1Xe6KTod/mtI0RoyQsnPxpcbmSUIVp2EvfPFM+317lE6OC6XtDMfsISDw
         YQAIGtB7J4lsln4ECh14IUhvRm6305pZiW1/EF9LZc+h1UZbvkaCbGwvBAFodAbFB8GA
         tC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724836246; x=1725441046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3niQjXZJR5D3vooE/mqJ9Cy41uU536hIxUZ/GtxSL8=;
        b=CMnPNaWkK9wHXcUCKfcgokqqQEk7NLICn5FQ4nX8FFc9uxhtP9lEhL/tiMBFu/cwld
         +mTuFxmw00de13WoyBVh8tloKWRxLdhrulHmxgw3tK/My6MKB6LQEX/EoUlqBmGFirOw
         PwsuEUu4KStoxh+4Mpchi/VJ+sM7C47SyAMc901HoUxyda82XDnTtPaXdsze2D/U806A
         1w4VgxxpcjTEjBuFhP/XjKyQt8TbC9QIDXPtWyu9gMvyIPCscD9diDjYE+XOniNuASbH
         /FY0JHkvDclWTCzbVmKmgjQiFB+kOZp/A7gbglARwgs9opkTt7UmHOtGc4nxUA6QuNvt
         1I+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDTbALPawLNrHvu3ewZn3pxdkB7JuSX1rJzcH98llmryizVtqIUC2drVl9nS9K215ep84oYTmScBtTt90utV+/zw1qRA==@vger.kernel.org, AJvYcCVROz0/b0e+dXnIIuLTT43aKWY4hMdGy5IKru6xQWyhwMQ1Mxo7L8SJzdiG60mpJg1zPumdXPD+lhYK@vger.kernel.org, AJvYcCVw8/nRc3KkMpNBA6GZfexs63cg4g9VXvazZuvTm/ow2FaIyYACB1gOhRDduw64JCL6sD68r7PJHlghPOF2@vger.kernel.org, AJvYcCW+kvfZZWH3pOLloutrcddKTdUterGzFVr/NRNaiabK4BQpIR9VAmYFcqwRUXnV+1adIPdmrGeMqFXpYQ==@vger.kernel.org, AJvYcCWqb8IoshiENJD9xaCpSzWpS7kv0hKibMVaZnvZEArEwPHMJj5rNaP9CdPal4g+cGkd3KoQcs3bH7qdXWVi@vger.kernel.org
X-Gm-Message-State: AOJu0YxKo1W153ioV0ox8JLhZ1KGaCEGSLZli6SYZMb5vNbQr8fj93Ve
	qma1q31KCod0fjoaayUcri6pvJth4BC8FvMW4/3E2hJ407Ef+b5Q
X-Google-Smtp-Source: AGHT+IF7uY9ow2G6xujW69BVfU5b4AZOL2v5nnCZbY71qinhm3c0AqkQo9Sucb8izKf3PWV00S2FKQ==
X-Received: by 2002:adf:a344:0:b0:367:98e6:362b with SMTP id ffacd0b85a97d-37311909018mr10609524f8f.42.1724836245824;
        Wed, 28 Aug 2024 02:10:45 -0700 (PDT)
Received: from [10.126.144.131] (ufr-132-230-194-172.eduroam-nat.uni-freiburg.de. [132.230.194.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810ffb9sm15230364f8f.7.2024.08.28.02.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 02:10:45 -0700 (PDT)
Message-ID: <d08d41ad-edcb-48ad-a848-53edc45ab8eb@gmail.com>
Date: Wed, 28 Aug 2024 11:10:42 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] platform/surface: Add OF support
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
 <20240814-topic-sam-v3-3-a84588aad233@quicinc.com>
 <ZszrjQChQ2aS5YjV@surfacebook.localdomain>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <ZszrjQChQ2aS5YjV@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I thought I should provide some context:

Am 26/08/2024 um 22:54 schrieb Andy Shevchenko:
> Wed, Aug 14, 2024 at 12:27:27PM +0200, Konrad Dybcio kirjoitti:
>> From: Konrad Dybcio <quic_kdybcio@quicinc.com>

[...]

>> +	/*
>> +	 * When using DT, we have to register the platform hub driver manually,
>> +	 * as it can't be matched based on top-level board compatible (like it
>> +	 * does the ACPI case).
>> +	 */
>> +	if (!ssh) {
>> +		struct platform_device *ph_pdev =
>> +			platform_device_register_simple("surface_aggregator_platform_hub",
>> +							0, NULL, 0);
>> +		if (IS_ERR(ph_pdev))
>> +			return dev_err_probe(dev, PTR_ERR(ph_pdev),
>> +					     "Failed to register the platform hub driver\n"); 
>> +	}

[...]

>>   static int ssam_platform_hub_probe(struct platform_device *pdev)
>>   {
>>   	const struct software_node **nodes;
>> +	const struct of_device_id *match;
>> +	struct device_node *fdt_root;
>>   	struct ssam_controller *ctrl;
>>   	struct fwnode_handle *root;
>>   	int status;
>>   
>>   	nodes = (const struct software_node **)acpi_device_get_match_data(&pdev->dev);
> 
> Hmm... Why this doesn't use simple device_get_match_data()?
> 
>> -	if (!nodes)
>> -		return -ENODEV;
>> +	if (!nodes) {
>> +		fdt_root = of_find_node_by_path("/");
>> +		if (!fdt_root)
>> +			return -ENODEV;
>> +
>> +		match = of_match_node(ssam_platform_hub_of_match, fdt_root);
>> +		of_node_put(fdt_root);
>> +		if (!match)
>> +			return -ENODEV;
>> +
>> +		nodes = (const struct software_node **)match->data;
> 
> This is quite strange! Where are they being defined?

Essentially, this whole module is a giant workaround because there
doesn't seem to be a way to auto-discover which functions or subdevices
the EC actually supports. So this module builds a registry of software
nodes and matches against a Surface-model-specific ACPI ID (in ACPI
mode). Based on that ID, we retrieve the tree of software nodes that
define the EC subdevices and register them using a (virtual) platform
hub device.

The snippet way above registers the platform hub device for DT,
because there we don't have an equivalent ACPI device that we can
use. The code here retrieves the respective nodes.

>> +		if (!nodes)
>> +			return -ENODEV;
>> +	}
> 
> ...
> 
>> +MODULE_ALIAS("platform:surface_aggregator_platform_hub");
> 
> Can it be platfrom device ID table instead? But do you really need it?
> 

I think the explanation above already kind of answers this, but the
module is named differently than the driver (so that they reflect the
specific nature of each, registry vs hub device). And the platform hub
device added in the snippet I left above is named after the driver. So
for the registry module to load when the platform hub driver is
requested, it is needed.

Regards,
Max

