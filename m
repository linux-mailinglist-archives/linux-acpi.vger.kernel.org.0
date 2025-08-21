Return-Path: <linux-acpi+bounces-15899-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7BB30840
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 23:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3817B17A4E1
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 21:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2EC2D7DC0;
	Thu, 21 Aug 2025 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zdypjq0J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63202C0283
	for <linux-acpi@vger.kernel.org>; Thu, 21 Aug 2025 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811066; cv=none; b=rZzeBeZBiKQaaUhrKgkwJuZ8drNwNuGI7dMr+AuILuXqcwTjBXE5lF81Q9+DZTHGTVpdqAY9lmPZht0jLHtktfxwTVWPvXlBO/nLan6dYIysYq3We8GPrr6TGJiZpBgwLmiSypCgXwJFz4iybOpBHBGD3ZbwBrnYdDNpoxeQy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811066; c=relaxed/simple;
	bh=Bf2lkJTzia6rp6eqbB2BpOAYcLR/LaQxryC/u1QpIJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrMLeudxuD8ZYuI5IKJPzcBAYfgAEXFirrBBHgRt2s4i40AHJmzi1xbUN84+MHZcZwUryH53fBQzrlKcw5T15f2LUN3JfnlMtTSst+/rx3Y8NGpOX6lWu7HYCpYNXcYiD6NZgI8LXQ4W9e9rbpolTiaT+U7XpaGADzJeKefCE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zdypjq0J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755811062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sBq1GXuyu1bfPR2a5gIBWELZcbU22YtlmG431fTdv50=;
	b=Zdypjq0J0uJ7v4RYx5Z6OKDGm/IybPBbVP0pCL6ZnlencyOT8lc9SJfNnS9OoZBUjfRhRs
	/6EFyyDh8QZvILUD4wq7VQucvRyOgXFSERgYfu+phPSelIkAwmSilDIAeL+QcudDUSZXd7
	ubCeAXSFqOqXa0QKucQRSaZ4Tjv5+Wk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-RmH0ZB5DNIG8B93GlAYJOQ-1; Thu, 21 Aug 2025 17:17:41 -0400
X-MC-Unique: RmH0ZB5DNIG8B93GlAYJOQ-1
X-Mimecast-MFC-AGG-ID: RmH0ZB5DNIG8B93GlAYJOQ_1755811060
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1ad21752so6369625e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 21 Aug 2025 14:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755811060; x=1756415860;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBq1GXuyu1bfPR2a5gIBWELZcbU22YtlmG431fTdv50=;
        b=MSYKZu8LHhyvyK4CzUfWNVfPswXSj93ehrSs51JgQ2e/dzL2qIiB5TPHWb4hLPoK8z
         19zP2hU2siFQEXyNKysfTlf4Sj3VKpzJaaCdjaPlhAvdA8B9FF3aYNCUkZVFqplhZlZm
         BpA5F0K9QxtNhvq9CkUqqfqWrG1TWdG8bhEB8fWVJsuFtGk/eTmKkyWVZvukva4VpiWR
         txEqJZcS78p7YJPMq8xl849QIsSh/OpVU/iTUGtJV8Ftoow2flH+VNBuSGeBygwmIsUU
         51mhdWv/ew4ci+qn+x9miUBu+dE+V8nVxQIMig3KJ5G+Xv0Sceu/+V6Bvg83Cywpgxwn
         rtUw==
X-Forwarded-Encrypted: i=1; AJvYcCVHS6gYoZ0iXYlcEP4n38fzxuCJ1i060Zha0BkasMNQT6YCuGyvLekP1cHIqmTBR1uaLHpp/UvUj/MQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFmProPjxGtcePVK214wvX536dVeynEtl/ZG+nlveBUDx+2L+
	eunj6fqk3pOi1R5fvCsLr9mO6vbTnJQDn24/xXI8gfrf1EBs2X/k6mYbfIqtiqqLb3MrW+4EAq6
	yZmgz2SkTJSZWULGKYDclaZtv2zIAzFaYziK+hzoH0kLo7l6o/sQDuh+ybpfxMaA=
X-Gm-Gg: ASbGncvtrD/ekU7GFS9bBa+eNJeoss8K8xEgQoVjvqhZtlktbILqi01L0p4Pb0YAnIG
	lsxyZ1VXKwkY66RFroiO0ssdv3codkKeFT4AAvQmspwd1xrQQKHLR9LB/QWp6vSGqTvUKTLFypC
	SqOOsM3EcaIzBDdvYjDGmDuPkv08k6NGDogPMsfePYueZ4W/Zm8JdImZWQmvnCDhCQcsWzQql8v
	D/USPRL/c5zRwdSTLyZ6wNqI99Uhx2817ZCO0PRM0K8uGL42LK2XACZD7Vb8i9yfdOAeoFAofuQ
	O6CKQdtBvedt9Y4gHJe/sITysbzdoIc5YCualvXnf7xF12X7rC/562nZfSOS543XFCdvHeALqgi
	VNsHZYHsv8tMR8Vlq2kDNyLwL9FqyzswznDOc8pEUah2a8vZ7v3PB8S5YcuJIYw==
X-Received: by 2002:a05:600d:103:b0:459:eeee:2759 with SMTP id 5b1f17b1804b1-45b4d7ff5a3mr20457415e9.14.1755811060073;
        Thu, 21 Aug 2025 14:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvgqefoRLnA/bfxgpVXZVQTDNLNgVxTUS43Go75UVVxQRjwxcQQmsmIjWRnwgQKHT6pUYi0A==
X-Received: by 2002:a05:600d:103:b0:459:eeee:2759 with SMTP id 5b1f17b1804b1-45b4d7ff5a3mr20457265e9.14.1755811059623;
        Thu, 21 Aug 2025 14:17:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f26:ba00:803:6ec5:9918:6fd? (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50d5dd4asm11221735e9.0.2025.08.21.14.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 14:17:39 -0700 (PDT)
Message-ID: <14a0e842-8616-4bd3-8e11-7d8521c81cb0@redhat.com>
Date: Thu, 21 Aug 2025 23:17:38 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm/memory_hotplug: Update comment for hotplug
 memory callback priorities
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 marc.herbert@linux.intel.com, akpm@linux-foundation.org
References: <20250820194704.4130565-1-dave.jiang@intel.com>
 <20250820194704.4130565-2-dave.jiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250820194704.4130565-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.08.25 21:47, Dave Jiang wrote:
> Add clarification to comment for memory hotplug callback ordering as the
> current comment does not provide clear language on which callback happens
> first.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Clearer comment suggestion from DavidH.
> ---
>   include/linux/memory.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 40eb70ccb09d..de5c0d8e8925 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -115,8 +115,8 @@ struct notifier_block;
>   struct mem_section;
>   
>   /*
> - * Priorities for the hotplug memory callback routines (stored in decreasing
> - * order in the callback chain)
> + * Priorities for the hotplug memory callback routines. Invoked from
> + * high to low. Higher priorities corresponds to higher numbers.

Minor nit: s/corresponds/correspond/

-- 
Cheers

David / dhildenb


