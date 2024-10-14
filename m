Return-Path: <linux-acpi+bounces-8750-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F6D99C959
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2024 13:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A0E293F37
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2024 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D3719E982;
	Mon, 14 Oct 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijUIuulF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEBC1684B4
	for <linux-acpi@vger.kernel.org>; Mon, 14 Oct 2024 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906613; cv=none; b=ePsj1k8BOrROoyiIt4vBj4IgYpsUfWnVoO5p3ZOmWEA03bb+OH6/GXIoBDvpo/Sq1sjEsAy1nbcH1MGU68/rtzKJ7kCjSVjZx/FgD1alQKxjcikVnUDAzVqNFGIWWMotSuOB8oDSxX6lu7PA6Oklak8fnc6msfaYTPuUkB4/1og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906613; c=relaxed/simple;
	bh=ej2oJo7FjWLjwyn8EarcLeDwAHzM0k8oP27ePKxkGF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONOvlUUS26mNcOvUocig2Wj7WdpEmeKjMW/szvDbuwpYR/bj2fR097om+9d1Z5zfCIp5D23lp8M6ZExCudV1QPqNN31ynzmfCj/Wy8RL3FcCvqKqTHVfIfrXJ4yqD2Br+/1gg1f6ExMvbmFwhxFlEwNbQdZN6KEVif3ZlL1NJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijUIuulF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728906610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bHKRdzrsASSDCDG09qNrYYOs1yqvFqCl/DrkRyuPvzs=;
	b=ijUIuulFjqQrm/OwymKY55EfYZ+t7nhbFv80hT6npemUNeR1qTNtv/L5C9mfS+vzv19rLB
	pIev47TNP+msGb5ygJZ0PKIMA97oObrKrAkxAFQlMOVCIhyGrGJgb7yiTm38q23gd7ocQf
	aQMxS+pvMy+YseRmSifq+qdeJlUTUSg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-gFTcB0aKNqeV9MRXHjl5YQ-1; Mon, 14 Oct 2024 07:50:09 -0400
X-MC-Unique: gFTcB0aKNqeV9MRXHjl5YQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4312935010fso14634395e9.3
        for <linux-acpi@vger.kernel.org>; Mon, 14 Oct 2024 04:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728906608; x=1729511408;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bHKRdzrsASSDCDG09qNrYYOs1yqvFqCl/DrkRyuPvzs=;
        b=AvtY66t99a6hS12am0eMOfmEP7ObdGx/DYSf1gmyLdZfLMPpeluAA0ghmFMQI74760
         nNyX6rXZui+crEnRLxZbdIYsfy6uAP1y7vtkIU0c1SEfmXVjDMA6pjMgB28d1aDzjr0L
         C3OwkLZyGGxwGd+MDCFs96CxESdoVgLNgBduLkl4cAa1AtNVtaBBu+1XX1pSfUuhbSNN
         ZxszJxTVQ/pm16uwobJhgi77yk0HKe1TUOlFA4zSKc0yFgbVohMPEM0CrjD1WjxhDZdK
         wpcVUSvb3RDO62ThB31K054x15h1MpkAMCq/9hNKJGVgo3MjiBurOoosGD9h4LrJOrP3
         pwsg==
X-Forwarded-Encrypted: i=1; AJvYcCX8SliNbAhTWQ5WDlUY4r7VVx3dVNnMt2QXHF6gKMNGa904AntiaA4PrGNPa832wKlaoPngyKXUMoV2@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOx6tK2SuWzCCh/Sl/DL93I8XbGY5axLysrRK2rjLtTX+T/DX
	DXcchCnupYJ1RfLPrTY/ZgwICuUS/pvS3WIOtMG7BCTVvOzEKJDaHnBkpP8INooRlF80AurbO+5
	G0pWTo1Ye7thUr3n/AUlrox92I1lNBhJ4KDu9mEn576TZgWEFZMDqan7DIWI=
X-Received: by 2002:a5d:540a:0:b0:37d:47e0:45fb with SMTP id ffacd0b85a97d-37d5ff86f1dmr6891409f8f.21.1728906608352;
        Mon, 14 Oct 2024 04:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYAyoizc1NBJkIlcYaJ0Tc0Q7WNTy3sLLGVuc57+TUYOtZJGmKImzG++BPWmFtWkxeDYuE2w==
X-Received: by 2002:a5d:540a:0:b0:37d:47e0:45fb with SMTP id ffacd0b85a97d-37d5ff86f1dmr6891372f8f.21.1728906607930;
        Mon, 14 Oct 2024 04:50:07 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ffc51sm118499215e9.15.2024.10.14.04.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 04:50:06 -0700 (PDT)
Message-ID: <1791f0e4-1c4e-41cd-b34b-cf63dedec912@redhat.com>
Date: Mon, 14 Oct 2024 13:50:04 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] acpi,srat: reduce memory block size if CFMWS has a
 smaller alignment
To: Dan Williams <dan.j.williams@intel.com>, Gregory Price
 <gourry@gourry.net>, Ira Weiny <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 akpm@linux-foundation.org, Jonathan.Cameron@huawei.com,
 alison.schofield@intel.com, rrichter@amd.com, terry.bowman@amd.com,
 lenb@kernel.org, dave.jiang@intel.com
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-4-gourry@gourry.net>
 <6705489bdc79b_125a729415@iweiny-mobl.notmuch>
 <ZwVNAYiyUaoc8Pax@PC2K9PVX.TheFacebook.com>
 <670561ebe74b7_964fe29460@dwillia2-xfh.jf.intel.com.notmuch>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <670561ebe74b7_964fe29460@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.24 18:46, Dan Williams wrote:
> Gregory Price wrote:
>> On Tue, Oct 08, 2024 at 09:58:35AM -0500, Ira Weiny wrote:
>>> Gregory Price wrote:
>>>> The CXL Fixed Memory Window allows for memory aligned down to the
>>>> size of 256MB.  However, by default on x86, memory blocks increase
>>>> in size as total System RAM capacity increases. On x86, this caps
>>>> out at 2G when 64GB of System RAM is reached.
>>>>
>>>> When the CFMWS regions are not aligned to memory block size, this
>>>> results in lost capacity on either side of the alignment.
>>>>
>>>> Parse all CFMWS to detect the largest common denomenator among all
>>>> regions, and reduce the block size accordingly.
>>>>
>>>> This can only be done when MEMORY_HOTPLUG and SPARSEMEM configs are
>>>> enabled, but the surrounding code may not necessarily require these
>>>> configs, so build accordingly.
>>>>
>>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Gregory Price <gourry@gourry.net>
>>>> ---
> [..]
>>> To help address David's comment as well;
>>>
>>> Is there a way to scan all the alignments of the windows and pass the
>>> desired alignment to the arch in a new call and have the arch determine if
>>> changing the order is ok?
>>>
>>
>> At least on x86, it's only OK during init, so it would probably look like
>> setting a static bit (like the global value in x86) and just refusing to
>> update once it is locked.
>>
>> I could implement that on the x86 side as an example.
>>
>> FWIW: this was Dan's suggestion (quoting discord, sorry Dan!)
>> ```
>>      I am assuming we would call it here
>>          drivers/acpi/numa/srat.c::acpi_parse_cfmws()
>>      which should be before page-allocator init
>> ```
>>
>> It's only safe before page-allocator init (i.e. once blocks start getting
>> populated and used), and this area occurs before that.

Sorry for the late reply. It must also be called before 
memory_dev_init(), which happens after the buddy is up IIRC.

> 
> I will note though that drivers/acpi/numa/srat.c is always built-in, so
> there is no need for set_memory_block_size_order() to be EXPORT_SYMBOL
> for modules to play with, just an extern for NUMA init to access.

That's the magic piece I was missing.

Because it didn't make too much sense for me a call to this function 
would ever makes sense after modules where loaded.

This really only works that early during boot, that modules are not 
loaded yet.

So this patch here should be dropped.

-- 
Cheers,

David / dhildenb


