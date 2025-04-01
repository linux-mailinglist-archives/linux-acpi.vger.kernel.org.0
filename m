Return-Path: <linux-acpi+bounces-12622-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF83AA7829A
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 21:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6697A40D3
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 19:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8C520FA97;
	Tue,  1 Apr 2025 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQMrgyTQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951881F098E
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743534519; cv=none; b=rNBwOPwDpiU3nvxVQTJtFHpiNjEIwcOgd5X2nzKovnSHaadPq9PkG8X7plcE6UIyaBgIGrNfBNJdBS2+UR6dSZVjXmovCyuRq0HBXU/n105Kox2fR/i7VefczZrcUNTtsceYwpqmUzeR0RR9kqw3eMjtv22oa2AV/V6jMWEv4sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743534519; c=relaxed/simple;
	bh=IWxwJsBxR2EWA2m7W5AIeFlN1HiOfYOHJhVk1cez7Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3OlRDKp3FpPRjZmEPHG+pB0SPUMIe3MqKTnaNLgVl0Q7gqrYE0MEW4C32qnjoHQ5deoYJvCXgqkQiAbE9msFFix7Uvz+TQkaBHSxD29/jUKnXzTl0/xlgUaf4z8HdHsE7FbOGzAWXu/+gJJUUdhCaFyew+TP5ivZxIeTOFKQ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQMrgyTQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743534516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fxfy856GNIhyOdAQoTwaZx+92PBM4Gwrv0kzsynTgt8=;
	b=OQMrgyTQufP9b+7WvaFnHox2pL27Y4hI+LPRvgctjY2aWeca10SfLA2Sh9horSQRuwKJ/V
	J4msiQpU9XgD27kmak/txsVBPT7NxaU4DlUKFhe5op2b0NMn7dL4Xq3U/CkfyenPk3adHm
	Q3zc3DfgbWgWOQuA4sGUx8twLfmjV9U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-1lrriMgfNcCmhrHY4dGEdA-1; Tue, 01 Apr 2025 15:08:35 -0400
X-MC-Unique: 1lrriMgfNcCmhrHY4dGEdA-1
X-Mimecast-MFC-AGG-ID: 1lrriMgfNcCmhrHY4dGEdA_1743534514
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bd0586b86so34762315e9.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Apr 2025 12:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743534514; x=1744139314;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fxfy856GNIhyOdAQoTwaZx+92PBM4Gwrv0kzsynTgt8=;
        b=pw2wY1niOZ/YPVRuT6sxVz8Y0Y5YDScSdmlcdaz7w33r/Wqr1IljtN0oFvWYus1UYH
         xA5qxOlHkbsf893jrfHpISjmVAhn21GEJg2YzxCR2EkK0djmAI/H4szWp+YAO2J/JUhk
         p6lJzUHCrm4kcgLP15n4o2cJULZmMYiCdnRFf+YqygtoYZgZEJI8G+sMwcgWSpESDWmR
         Uq8u0fBaNCw5OsSUJYGQZauPy62IZGfFOxtKELUenYTwXYThho79Ml3RC/tLMqTEkOJF
         fYlFNP+QAE7fmlBWQkhDWnRySgfn3hECMn6nSAQ0q1cETDT+U5zAZsSFJBH/YeE4d/Ht
         obYw==
X-Forwarded-Encrypted: i=1; AJvYcCXmVmE4X48ye4cFbOPjgRJsPC1Tjw/Q6x/DnNSNVnmaj8NkJm/y4zoLJ396H7D6XcylCv0SX4wNQysM@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTktzGIiOFl79mWEaod9sbOCpkvuKFiyUvoE/OIshdMTUgQrt
	LaVIP/p61AdygBTILQg36UI2jiglF3bNJD9H47vBs4oKOYi906y/nZyw1kMY4uyJtaa2kewTyoK
	sgKQExXTN2zxHNznPdkp1AUzCRQQ4NTFGXEy3a0OZ/RuqHi2M5Hox8mdttuI=
X-Gm-Gg: ASbGncvkLJ4ovV8I5M1QSMC4eiS4TFOB5peV751WNcV8SWJM97tI774+GQks+DMzNX/
	FOJIkDz/oa2f2vo/dYsFZ+AuE1nrkd1CMIlVMiH4msKLMJ7nhZ+Gcd+TmL3l699WsZtyQ3CqCEx
	Yi15M45XI/IeSnEmj1e2CKuxSqt+gOda9Dvr3/59QQqQdoaq6q7DhXxTibrG5H4IieXhOdS+fTn
	HajecPe9OjcUV2xO5U3LveJuDfATls1jDEwP5QyVXTJ/hTHgcwIZ2iTB1/mZG9AolFY4pr8kgak
	7FtH8FQGGYGMOS+ZAiuqrhft7ImNnlrmxoBz4rdb5fqbfHuSwTjvb1xdn2tkjuyoLy0sPka7cBk
	ABS2MPBjaUytlN7QsQeBKSVUIlwvCRrpVeS2vd2A7
X-Received: by 2002:a5d:5f48:0:b0:390:ee01:68fa with SMTP id ffacd0b85a97d-39c120e33b0mr13078526f8f.24.1743534514182;
        Tue, 01 Apr 2025 12:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGUxL/nh7ZW7LNpGArseN01CHfYilBol5AF2k4FX+MHf0fTGwQf9dhMv22L83XPncC9Bz1cA==
X-Received: by 2002:a5d:5f48:0:b0:390:ee01:68fa with SMTP id ffacd0b85a97d-39c120e33b0mr13078498f8f.24.1743534513798;
        Tue, 01 Apr 2025 12:08:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:4d00:6ac5:30d:1611:918f? (p200300cbc7074d006ac5030d1611918f.dip0.t-ipconnect.de. [2003:cb:c707:4d00:6ac5:30d:1611:918f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82dede5csm212272835e9.8.2025.04.01.12.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 12:08:32 -0700 (PDT)
Message-ID: <01d8cde7-0973-4303-bb5d-3d377a6862cb@redhat.com>
Date: Tue, 1 Apr 2025 21:08:31 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] memory,x86,acpi: hotplug memory alignment
 advisement
To: Oscar Salvador <osalvador@suse.de>, Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-acpi@vger.kernel.org, kernel-team@meta.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
 alison.schofield@intel.com, rrichter@amd.com, rppt@kernel.org,
 bfaccini@nvidia.com, haibo1.xu@intel.com, dave.jiang@intel.com,
 Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>
References: <20250127153405.3379117-1-gourry@gourry.net>
 <Z-w2O8O9MGJ1Ok78@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z-w2O8O9MGJ1Ok78@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.04.25 20:53, Oscar Salvador wrote:
> On Mon, Jan 27, 2025 at 10:34:02AM -0500, Gregory Price wrote:
>> v8: nits and tag pickups
>>
>> When physical address regions are not aligned to memory block size,
>> the misaligned portion is lost (stranded capacity).
>>
>> Block size (min/max/selected) is architecture defined. Most architectures
>> tend to use the minimum block size or some simplistic heurist. On x86,
>> memory block size increases up to 2GB, and is otherwise fitted to the
>> alignment of non-hotplug (i.e. not special purpose memory).
> 
> I wonder if something like this could help us in improving the
> ridiculous situation of having 16MB memory-block size on powerpc.

They have this granularity because ... they want to add/remove memory in 
16MiB on some powerpc dlpar machines :(

probe_memory_block_size() can query the hypervisor on the actual 
hot(un)plug size. IIRC, QEMU sets it to 256 MiB.

-- 
Cheers,

David / dhildenb


