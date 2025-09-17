Return-Path: <linux-acpi+bounces-17056-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A68AB7F9B5
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 15:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBDF1C038BA
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 07:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151EB2BDC3B;
	Wed, 17 Sep 2025 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHrS4tJg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEF929B8D9
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092585; cv=none; b=lWyOvzYyBTuPrhhpikpAUA1ADmLh/xBpMbkBqkgFEAnkEJ0E2YdQlfdayR4Y50gC5x9O4I5j1AzK1tELsfJXg8heCHQCOMjv1psc21UunxJj5Wjqjeg3fOQ6quWHJCaQrNHyuRqsKO5lWKKge/ZbQRQwVInW9m1/auJ3GiQAxSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092585; c=relaxed/simple;
	bh=ko/99fPEHJQwgLb5nCPWVD8uy5wLTxH5KAinDw/smNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdjzgiGUvTkLGHeKYxhJGeDUMZg/KyeSBGAlFQFDiQFBzR39/Pg8/zjWbdP0d8SOYRvEyJnwbCLXU3YditShASxu8nX6cTZLmiFu4sDlwF6khL6XLY61ZKQ2UFi7W4LU4N7KjRM6BKyW5IR2xlfxJe0gYPGwLQUImbwkwIxQUao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHrS4tJg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758092582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nawTqrlEeqSv7zVujc+JzfalbuSXfxtcl1SSEsQficc=;
	b=bHrS4tJg3eEGBnSjEfnyVVKvW5Uewo43q6ZB93u/rQzfCjO0uJcVphHnZ1fN1Gdx/DRVpx
	4n6neFiilnrIetvNGjE6lIO8KBE/Ivgn1sh4kbVVWJ0akPt941/t23nan0dDjZImiwYRMX
	WDAFNbxpqR9p6kt85f1xpiUrzAVnhWE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-3xVXTg45PZSEiq62sLGnyg-1; Wed, 17 Sep 2025 03:03:00 -0400
X-MC-Unique: 3xVXTg45PZSEiq62sLGnyg-1
X-Mimecast-MFC-AGG-ID: 3xVXTg45PZSEiq62sLGnyg_1758092579
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de27bf706so35424905e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 00:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758092579; x=1758697379;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nawTqrlEeqSv7zVujc+JzfalbuSXfxtcl1SSEsQficc=;
        b=DSO4AiK/JpC+R+9mb5Sv3/0cRRsSAiozrMv4w1tY1wXKWKYnV+yebPLBg3c41FKHea
         r2lYyu8mGX0uvTjvdVmxkWrYsHedmES8kfJ8SByNuyJHtKqmO+BWZRph/C4paXkmjHrC
         bpMFDZbhbjgVQhJAA31iskNZz8YLDoldl0/j/+WE4VqQlMksTRDGL7K0ojG88EsBjyVn
         12mg+fmXGOw8XMSv3SSCsGlRyCseNBw5Rnyc7MvFIMSY8CoKXFnwoBXFnWlxtZRc+ZBB
         RIzRd38eme3AyzuwRBo6dAaf19QVM9sv1ElsI4oO5JTuChv6aOKDuge2Q9I6vCUTvIMa
         5JWA==
X-Forwarded-Encrypted: i=1; AJvYcCU0hTQP4ONcftPl6115W/aoi7yH1+RZ5aK6ZD8hmsLbwA+B6QunFfrSGquMc79SEUzdbVKNwOZ1FGUV@vger.kernel.org
X-Gm-Message-State: AOJu0YxAfIzbwQ8+wscJuCUJkFIN+srJWtTHYX2wy2VLeLlmFDdW+Uad
	1I2aH0rekK4VBXyz4nZln8lwNE69PgGFvQbqQxZPA4h+DyQz692K2CVrTcu1Qim+UFMRFSCRbY5
	cOfOXLkaFWs+vBh9fKINlpKDG9lQuwuiOf0mO7qJrpUKY6jeNEWRLqFpxAX4WB6M=
X-Gm-Gg: ASbGnctFOZutzqtCUEDq2bpVH6KCRZGT6WGqUr1iJQYPg52Sei1RRefjo6P2NFu63fP
	b7wq756DqMAprsWgmQt8l+hl/la/4ZaMEeCKIi85BsWX+g3SHhb7R1+1i0LIRkttZNFsha+wz0z
	BQ+qrDwDOpsE0U5vh2/ePpCUCIiJ5GhlA56fNVkNMyrAsbXiwajJV0qdrmKmNeSJtUP9STvYMup
	TDSoQchcEXHsbPJNTrU7uhlHuh5FxKKE091TspEhQEBwWsxy+aRPWYKx4g+o46EBUYYquxAm5T7
	vCGNhpkwIoL46X3wXVd8XX6VTwoBRbqFjTVcMOmj3Nf7VAzyJx05H4mo9CaFirXMKz7S9zLmzLs
	QoMSkjHxHQ0bfWeyxYYs0MjyI7u39NL5ihcJSt1X70BCQOIXkAACMLqh+1LDt2UyR
X-Received: by 2002:a05:600c:1e88:b0:45c:b56c:4183 with SMTP id 5b1f17b1804b1-46205adf753mr8271005e9.18.1758092579164;
        Wed, 17 Sep 2025 00:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCHXqLZgubOsFpSEryXy6qEwTu5TBAMNWT2kDUAPReOb9ESdWMxgF+theDpncx+aIUqSILpQ==
X-Received: by 2002:a05:600c:1e88:b0:45c:b56c:4183 with SMTP id 5b1f17b1804b1-46205adf753mr8270405e9.18.1758092578660;
        Wed, 17 Sep 2025 00:02:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46137a252fasm23338645e9.7.2025.09.17.00.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 00:02:58 -0700 (PDT)
Message-ID: <8c3188da-7078-4099-973a-1d0d74db2720@redhat.com>
Date: Wed, 17 Sep 2025 09:02:55 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Kyle Meyer <kyle.meyer@hpe.com>, akpm@linux-foundation.org, corbet@lwn.net,
 linmiaohe@huawei.com, shuah@kernel.org, tony.luck@intel.com,
 jane.chu@oracle.com, jiaqiyan@google.com
Cc: Liam.Howlett@oracle.com, bp@alien8.de, hannes@cmpxchg.org, jack@suse.cz,
 joel.granados@kernel.org, laoar.shao@gmail.com, lorenzo.stoakes@oracle.com,
 mclapinski@google.com, mhocko@suse.com, nao.horiguchi@gmail.com,
 osalvador@suse.de, rafael.j.wysocki@intel.com, rppt@kernel.org,
 russ.anderson@hpe.com, shawn.fan@intel.com, surenb@google.com,
 vbabka@suse.cz, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
References: <aMiu_Uku6Y5ZbuhM@hpe.com>
 <a99eb11f-a7ac-48a3-a671-c5f0f6b5b491@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <a99eb11f-a7ac-48a3-a671-c5f0f6b5b491@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> +
>> +	0 - Enable soft offline
>> +	1 - Disable soft offline for HugeTLB pages
>> +
>> +Supported values::
>> +
>> +	0 - Soft offline is disabled
>> +	1 - Soft offline is enabled
>> +	3 - Soft offline is enabled (disabled for HugeTLB pages)
> 
> This looks very adhoc even though existing behavior is preserved.
> 
> - Are HugeTLB pages the only page types to be considered ?
> - How the remaining bits here are going to be used later ?
> 

What I proposed (that could be better documented here) is that all other 
bits except the first one will be a disable mask when bit 0 is set.

2 - ... but yet disabled for hugetlb
4 - ... but yet disabled for $WHATEVER
8 - ... but yet disabled for $WHATEVERELSE

> Also without a bit-wise usage roadmap, is not changing a procfs
> interface (ABI) bit problematic ?

For now we failed setting it to values that are neither 0 or 1, IIUC 
set_enable_soft_offline() correctly?

So there should not be any problem, or which scenario do you have in mind?


-- 
Cheers

David / dhildenb


