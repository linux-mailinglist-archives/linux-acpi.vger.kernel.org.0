Return-Path: <linux-acpi+bounces-15796-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 574FAB29E5B
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 11:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCC43A79AC
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7497A30F55F;
	Mon, 18 Aug 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUmVXqYD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5AC21CA0C
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510589; cv=none; b=VITQrDX3DmLcajZS0dXcDDjlch6MkkY0rGZ0ImhHdDcxL57muMbxEgxO6aPGpTqjminpyo0LTN9LSpw3MLBirEA7KmAR3tE93R7OwuxV+KAzcCwrgg08TdeV08rMlf7gqZkjBuB6SCQ5JFbPDkqwKXAjHCVk37gkRMq5NZni2pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510589; c=relaxed/simple;
	bh=ruD90fmD45BZjpBmCszzza9dEygahhyzuZFLh8fMlYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwPuUWjxDm0IfExkBrhq0sEyE4Qsvyi39OkoOdboymwb/kGk7q79lJ24EtOXFPacnxNkFhPQYKGZG437laXpKzXIHz0JDBqLkh4zpJUfngw6T/HjPj22+RccNW3F/qxkMMr2Yt2uvOpYXXCwoK34Hc6N6LSRlzeVpx34z2fb2jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUmVXqYD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755510586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lJ19cF2qHS7qAecDWBARhPKr/77IMYO29rQr0c/HTVQ=;
	b=CUmVXqYD5aIgf9cLjvSQYn/tqTwjdKbBh09hA9YRrXHK2y6E82ENHNuLqCRcVLnEb96/Ki
	Xj5WuuFo6ZZt4BW8em0uQ0mothIhlq+7DPxefZbzO3TXWNpGmaaVVJKCs/NAtnweLL77OX
	t0ByQfhM1LAACXAre1UHis5p6merv78=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-8X_4usHWOnCAkcUk-8flrA-1; Mon, 18 Aug 2025 05:49:45 -0400
X-MC-Unique: 8X_4usHWOnCAkcUk-8flrA-1
X-Mimecast-MFC-AGG-ID: 8X_4usHWOnCAkcUk-8flrA_1755510584
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9e4134a34so2432598f8f.3
        for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 02:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755510584; x=1756115384;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJ19cF2qHS7qAecDWBARhPKr/77IMYO29rQr0c/HTVQ=;
        b=QBei5+YdeKmX22a2qFcInP5fAPRoJq171g4FTh2bUbiBbfFUTgfmkbNJg+SYvq1DoZ
         OVwbLaOW2nyDLUTJhvBe1Gshs4a1YfQDSx2ioU75zpdfUlHvroR90d6vhpgRkWIwd+1A
         bRBGf0P+IY9rs0C0uxWRascEiRgfKxED7nokRfTP7fPZMj3+HHYqEsI3kwstG+RFfoiP
         de1xwSqdxS1UcCHdjLhHW4VEKcPgC9flhQ6jliV7QgiaX12CppNGiuMLm7A+p/oFCG79
         tZi+LkOeeDedzKHy1qkgWzQzaRRcDfiFIr0aEteqJ7CVs1MClY90q3GxgFaVLM75hQpw
         YvwA==
X-Forwarded-Encrypted: i=1; AJvYcCVszmrrG7zYSGiGSlwdspMhZjyHTNOTP8bFJowl4m4iIEHdRht3v6D5SA2VfbKU0XO1NM8N6INT5F7G@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkf9pA0VXxROE2AwLzGFTnrxp8Q2u8YelrnkjBYu5kJA/0I7UH
	8+f5IQfbswtpPoqTbu8y7sqO9XJ+SY2hu+OYtk1Tx6/gJCLm2E+SnoERTKYRK2EFyIF2n5yQpNh
	2ry17jZaH5te5B/S9AXvjlAlDrg/zmshWnhWQttFuM5YdH5wfKPoU6ymKvRS8PRI=
X-Gm-Gg: ASbGncvDCML0TTj2NcUFmh0egwi7j25AVwrzgjWJakPLJG/hqDW+IJygFoAC0mdDMcW
	XLKRyZTxSgYPbgFp9H9yIJ8ZMbPv/NR5wtlj37lAKU4EB0vg7t0zkslHN9X2msRYcs4KMYbEOlv
	Vwl0C+OcgniK3ipFZ5e+YNrPzIwEt8Tydykv3ob8CmIanJJJeNKCHj11Hxwv6yHeCzO6BPt5Vty
	iUFQaCeUPtsIXt2o6COlGMImw8m2S1FyJ4T+7tpkgzvzm+AJRoT953mEdVRe1ljYI2DbKmcOkjI
	kzMAGc/pdmahoDrX0A0ewTkWlgn8csU0OfdU3Uxopq+SRsSTAOA61r8oPfk3VmV0mlziGlWAhos
	vsW1rnWN8lT8xMwgEyO3Aj5bhfXkIoEDyGae6PCwt8jc0+iDBsqCxLL7Y+VQAEyJ9
X-Received: by 2002:a05:6000:2310:b0:3b7:8b64:3107 with SMTP id ffacd0b85a97d-3bc688ab9a7mr5661637f8f.26.1755510583736;
        Mon, 18 Aug 2025 02:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJaAWqgw5QTC3l/jewXPtJbxd2DyXWRBJjgRtYobnv0HyqwBobL37m1mf4apF3o86Qm2R/cA==
X-Received: by 2002:a05:6000:2310:b0:3b7:8b64:3107 with SMTP id ffacd0b85a97d-3bc688ab9a7mr5661608f8f.26.1755510583279;
        Mon, 18 Aug 2025 02:49:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm174744525e9.6.2025.08.18.02.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 02:49:42 -0700 (PDT)
Message-ID: <c0600abd-18fd-4bfa-ba8d-45303ee3a9ee@redhat.com>
Date: Mon, 18 Aug 2025 11:49:41 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drivers/base/node: Add a helper function
 node_update_perf_attrs()
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 marc.herbert@linux.intel.com, akpm@linux-foundation.org
References: <20250814171650.3002930-1-dave.jiang@intel.com>
 <20250814171650.3002930-3-dave.jiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20250814171650.3002930-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.08.25 19:16, Dave Jiang wrote:
> Add helper function node_update_perf_attrs() to allow update of node access
> coordinates computed by an external agent such as CXL. The helper allows
> updating of coordinates after the attribute being created by HMAT.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/base/node.c  | 39 +++++++++++++++++++++++++++++++++++++++
>   include/linux/node.h |  8 ++++++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 3399594136b2..cf395da18c9b 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -248,6 +248,45 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>   }
>   EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>   
> +/**
> + * node_update_perf_attrs - Update the performance values for given access class
> + * @nid: Node identifier to be updated
> + * @coord: Heterogeneous memory performance coordinates
> + * @access: The access class the for the given attributes

"the for": there is probably something missing

> + */
> +void node_update_perf_attrs(unsigned int nid, struct access_coordinate *coord,
> +			    enum access_coordinate_class access)
> +{
> +	struct node_access_nodes *access_node;
> +	struct node *node;
> +	int i;
> +
> +	if (WARN_ON_ONCE(!node_online(nid)))
> +		return;
> +
> +	node = node_devices[nid];
> +	list_for_each_entry(access_node, &node->access_list, list_node) {
> +		if (access_node->access != access)
> +			continue;
> +
> +		access_node->coord = *coord;
> +		for (i = 0; access_attrs[i]; i++) {
> +			sysfs_notify(&access_node->dev.kobj,
> +				     NULL, access_attrs[i]->name);
> +		}
> +		break;
> +	}
> +
> +	/* When setting CPU access coordinates, update mempolicy */
> +	if (access == ACCESS_COORDINATE_CPU) {
> +		if (mempolicy_set_node_perf(nid, coord)) {
> +			pr_info("failed to set mempolicy attrs for node %d\n",
> +				nid);
> +		}
if (access == ACCESS_COORDINATE_CPU &&
     mempolicy_set_node_perf(nid, coord))
	pr_info("failed to set mempolicy attrs for node %d\n", nid);

or

if (access != ACCESS_COORDINATE_CPU)
	return
if (mempolicy_set_node_perf(nid, coord))
	pr_info("failed to set mempolicy attrs for node %d\n", nid);


With both things sorted

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


