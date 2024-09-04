Return-Path: <linux-acpi+bounces-8154-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4926A96C5D1
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 19:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE28CB2201E
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 17:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D041E133D;
	Wed,  4 Sep 2024 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFs/4z4N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA221E008D
	for <linux-acpi@vger.kernel.org>; Wed,  4 Sep 2024 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472514; cv=none; b=W/cKYAEjR7mnH2t6TqmxltzVRfBDSJ+6Gdvdi4j934RKIqykP2arxJ6O3+1LFPYdTXalBeFIG5AUNunAMgIOV1J7h7T2cKzf0XNrjNTQhxO6X5tdyJCT8Jv+SMnZbZ/SM3SICXoYhEjP9zWOdlj/8x0Iq0A6c6LdX5Jt7dk/7vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472514; c=relaxed/simple;
	bh=VWzM6EtUmeeVBM+CvbOkVNtoVZCunbQNZn5u3JdbtV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzK2j38DY3fNHCfly1A5z3LuR5lEacN7UsUM9PjRwK6zGZdTPg38xRhQoKIeABqMRJZy8Nc3tnMi57VkM//DIUzOsotag8Ly14DyZBWMTqJbY717tBV85g7tkCw9SPvK1O6Loya4fwizwvrnVBbZoC90oe/qXSU/qfTckOps2R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFs/4z4N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725472511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpULzeoOquLLnjVucbF5xnPEVwj274syMFrmrkoRAMM=;
	b=YFs/4z4NhjjgWUoXtCaUhLEVQV7WaFYP1Ohh6NATroLdj4/T30H97+n/GB2vnbTJkIJMcL
	8ubNIn+Jpgld/pgAPsZlQjD+IMjxkO12ROpqdwU6cJEN93p/siDVv3vN4B4V5M8FboE4mo
	T3bvFoOiqPz77pW0Swimib5WBNfqe1g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-7kbEIXX2MN6-Ak0SvLUIBA-1; Wed, 04 Sep 2024 13:55:10 -0400
X-MC-Unique: 7kbEIXX2MN6-Ak0SvLUIBA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8683bd9e67so594189566b.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Sep 2024 10:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472509; x=1726077309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpULzeoOquLLnjVucbF5xnPEVwj274syMFrmrkoRAMM=;
        b=Vu8EnNfbWZS6OC25UwjR68IzxsEQFGf2IPssbOUvcIm0IXxhIGlla9H5Pk+IarUk/K
         Y0yvFA6SxbKEL6gteURneIWB5KC7cvfSA0jux2OEaakU+Mos+QCPYB9WGX5/lIMDOmgu
         5N893aIWaVDquvgEyBMX5gQx2wS5GrefL4DCIxOZmXjKoiPy6lEZCi1wj9N2KNn/r/95
         6/GG4nz50WpTGvoBRNBSeKht2xj6GVbVKq3pAEScCyq/Og69T5eXQ0l0cG14dsx7l3ZW
         AvGDnI1rBvA7JrB8udQ6V3n7VC8HtAU/jIJPRHEfb/BiU/6O9/NDd0eGbgrwHnt/8SQ8
         +6rA==
X-Forwarded-Encrypted: i=1; AJvYcCXpxgs//kLDZrWxZcuYMBWMEXnSgZa49NBLkhoyhAOdVCjiqVumhelUKV29CnvYtIsP+y6J2IEmbSuH@vger.kernel.org
X-Gm-Message-State: AOJu0YzUZUY694NsXwKirHJmwoGawg+cE3nb1jtYtcr71VRLtr2AKZGU
	cYTDxufIxvJUzHUmKZ+9LY1XWIExrQEEid02bjPphN+plbOG6i7U1HrwigQrL80VbeiL1g/7HEQ
	vA7GLpTFoLhueMUntVpKO6CMPVYHbDzXGzNkkTrd4bSWHjwB9PRtn6sROJaI=
X-Received: by 2002:a17:907:948f:b0:a86:a417:72d2 with SMTP id a640c23a62f3a-a8a1d32689cmr535400566b.35.1725472509353;
        Wed, 04 Sep 2024 10:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2LPU0ING+4KbER6sgAUpEBU4Mq4znqdOnm47Qu/gv2s5OprciWuiK45hfXxAt/jYUlq4jbQ==
X-Received: by 2002:a17:907:948f:b0:a86:a417:72d2 with SMTP id a640c23a62f3a-a8a1d32689cmr535397266b.35.1725472508858;
        Wed, 04 Sep 2024 10:55:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623c2b00sm18489466b.162.2024.09.04.10.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 10:55:08 -0700 (PDT)
Message-ID: <bf7910d7-395a-4d01-960e-46789d836da4@redhat.com>
Date: Wed, 4 Sep 2024 19:55:07 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] hwmon: (hp-wmi-sensors) Check if WMI event data
 exists
To: Guenter Roeck <linux@roeck-us.net>, Armin Wolf <W_Armin@gmx.de>
Cc: james@equiv.tech, jlee@suse.com, corentin.chary@gmail.com,
 luke@ljones.dev, matan@svgalib.org, coproscefalo@gmail.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com, rafael@kernel.org,
 lenb@kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240901031055.3030-1-W_Armin@gmx.de>
 <20240901031055.3030-2-W_Armin@gmx.de>
 <e90b40e9-b3a5-4228-8f12-b02a77b7789d@roeck-us.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <e90b40e9-b3a5-4228-8f12-b02a77b7789d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

On 9/2/24 4:28 PM, Guenter Roeck wrote:
> On Sun, Sep 01, 2024 at 05:10:51AM +0200, Armin Wolf wrote:
>> The BIOS can choose to return no event data in response to a
>> WMI event, so the ACPI object passed to the WMI notify handler
>> can be NULL.
>>
>> Check for such a situation and ignore the event in such a case.
>>
>> Fixes: 23902f98f8d4 ("hwmon: add HP WMI Sensors driver")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Applied.

Thank you.

Unfortunately patch 2/5 touches the same part of the file,
so I cannot apply the rest of the series without first
bringing this patch into platform-drivers-x86/for-next .

Guenter, can you provide an immutable branch/tag with
this patch on it; or drop this patch that I merge
the entire series through platform-drivers-x86/for-next ?

Regards,

Hans



