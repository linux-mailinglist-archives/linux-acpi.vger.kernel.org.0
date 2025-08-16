Return-Path: <linux-acpi+bounces-15750-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8B3B28B6F
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Aug 2025 09:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D107A9DA5
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Aug 2025 07:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C456122759D;
	Sat, 16 Aug 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBjnl2Rv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E77223DCE
	for <linux-acpi@vger.kernel.org>; Sat, 16 Aug 2025 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755329401; cv=none; b=GhjrRgGzpXKPdNDB+PUp6HKup5atXh58a39TLsJhQB9sS/3+LtaZpZVJec+v4VhxCv5+OQFCPdaCfJk/H7q6n56JzPOtn8aj0Wu3GJKFX3q75F7Pwp6ZkmA7RcPJ96W7i10puX+5t9YXLOtCq9fXqS3JN6Q1RJkdYxBcwbUvn+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755329401; c=relaxed/simple;
	bh=cW6/Kk6xhPjcm6HHtbxNdbs/mfaUPd0lad7M/sDHp+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hj2aPTlArU/p4TFk3AELXzUoBTUD5ZKceaAqZfsLWJI74Ai7HDbE6x8nRRogmABHkUPkKoy/iV5WBDX3sN4DslkxJxfNugshvBkO9RNm4kNpXqwLKc4HZZqWoWw+z4mvKcg0TdAP9C7Yy+Zv5ZocXr6VBaDnYsaCmP7iFwuoaSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBjnl2Rv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755329399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R5YdMvftyyNcqXdxEvGbyCjnA5x9aBSv+Dou4SkBOqo=;
	b=gBjnl2RvSQkpnuXvcIAOxs1/ISLwareaa4rYJPeEurYz8caOa4aD57abW/scynxZEiMbsP
	mN+WX1nH8hwmonniDt1uWGy4KqAaiXET6UzwQxfX94rBkikJS8uqIhDYVn4tZKFasdJM7B
	UQJINQina7j42PVaQjyS2kHFFfXPNoA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-j1BquNIMOMyc_NomZN1HuA-1; Sat, 16 Aug 2025 03:29:57 -0400
X-MC-Unique: j1BquNIMOMyc_NomZN1HuA-1
X-Mimecast-MFC-AGG-ID: j1BquNIMOMyc_NomZN1HuA_1755329396
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9dc553704so1980872f8f.1
        for <linux-acpi@vger.kernel.org>; Sat, 16 Aug 2025 00:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755329396; x=1755934196;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5YdMvftyyNcqXdxEvGbyCjnA5x9aBSv+Dou4SkBOqo=;
        b=CJP8KGiZorEXSZCeo7UoYS8CQsNQZEVTFkl4xZb35sxwu7YZyJg8tsfkcj3oOjy4iC
         WJJNyfm6r06Y9+RRDH9V1J3a1JHgUfgREDblvyzUfIj3WwxPluODU0WwJnWUzSyo9++G
         bEhuDicOGgh2v6ppxtFI+mUv/i15M/s+q7gk5hCLaQxzfLqnhp7h7ORuzV0/zDwFQcLs
         ODLATR5ScoFZxp3qxmZBziTCzKhsclUwWYSM/hRQobwxFL5MrTnSX8bTQ0hIlYaVwugc
         q736205JMomUx6Lui99DuVq1QMhu1+H9aXvLfR/PGq4tQ/rge9Z9UzasXjuyCpVnyOlE
         AyLA==
X-Forwarded-Encrypted: i=1; AJvYcCVg92yC5g8/eKBzx2Layj/8Ak0DfqbirC0/HRbmlXuxS4b++GXg7wPVJmVmFN8ASoezJIY8Zz4sn95z@vger.kernel.org
X-Gm-Message-State: AOJu0YytrsXhgEn1o+m8SqUjtXx9PBCeFVCY/EDX46GOPIMKFleSo128
	n4wowgY/l3a9ILXDqOKvE10ShvzyR+fEawdJm6nbnF8sNM8kodAJoxGK1iSnK6BoY79FgGfQqtP
	L+pAhtnE3ewY+z77zjYAynnD+xUdcr1NKIhaw1vqYHDVGs3I0v4HjbyeY5P3nrfk=
X-Gm-Gg: ASbGncsmeHVFdZrUbuUb8/SG/Z/WxadbPXdNLW+7mj9sgM2DUW2fs5mcnSQ3ObKQXzU
	FC2O5S35RgHcO1ETYpsJ5eokHQCWohGk2Xu/t5JHhXto7Vf9zEaLauSfpZ3dqfbVIYePK6TP2E4
	9Jbby9nzAyXDC0PJz67D+8Uje6QV+Q5BWYc7jJbE8ZAtsFZxCOK04mNhdklKc72Yqgeaow/tWuU
	crMUdddtj1LyXtM3EdzDLtYUeX6uEzDC1gIQ0XgMNFCt7PhUCu0g7nsT0dLD6FaEMopE5WGjqHN
	OqFhkVi+VF90Kmj3OdZI6w0CUog8M7w9Z5fRqkWxLRaPzcOytnnIWNaOFScMIlDcOaPJPsw/Xwf
	hyAui5l1Jo5qQSO3ANlNjblG7l7kiuf2NttyBoBZ8G5X+FpK5upab/77EL5NfF4sihNM=
X-Received: by 2002:a05:6000:250e:b0:3b7:6205:25c7 with SMTP id ffacd0b85a97d-3bc684d7a6amr1161458f8f.13.1755329396424;
        Sat, 16 Aug 2025 00:29:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdeZbLYVw/9iFVb7Qe06uYvO+L+q1zunUurrOjukRyliqvXYO4XKk8xjLSqGpY6omDRyef/A==
X-Received: by 2002:a05:6000:250e:b0:3b7:6205:25c7 with SMTP id ffacd0b85a97d-3bc684d7a6amr1161440f8f.13.1755329396041;
        Sat, 16 Aug 2025 00:29:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:c700:d8ae:41bf:492a:9e4c? (p200300d82f23c700d8ae41bf492a9e4c.dip0.t-ipconnect.de. [2003:d8:2f23:c700:d8ae:41bf:492a:9e4c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6475863dsm4747109f8f.5.2025.08.16.00.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 00:29:55 -0700 (PDT)
Message-ID: <c3e30bf7-403a-4105-8e04-a73b80039ea5@redhat.com>
Date: Sat, 16 Aug 2025 09:29:54 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/memory_hotplug: Update comment for hotplug memory
 callback priorities
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 marc.herbert@linux.intel.com, akpm@linux-foundation.org
References: <20250814171650.3002930-1-dave.jiang@intel.com>
 <20250814171650.3002930-2-dave.jiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250814171650.3002930-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.08.25 19:16, Dave Jiang wrote:
> Add clarification to comment for memory hotplug callback ordering as the
> current comment does not provide clear language on which callback happens
> first.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   include/linux/memory.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 40eb70ccb09d..02314723e5bd 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -116,7 +116,7 @@ struct mem_section;
>   
>   /*
>    * Priorities for the hotplug memory callback routines (stored in decreasing
> - * order in the callback chain)
> + * order in the callback chain). The callback ordering happens from high to low.
>    */
>   #define DEFAULT_CALLBACK_PRI	0
>   #define SLAB_CALLBACK_PRI	1

"stored in decreasing order in the callback chain"

is pretty clear? It's a chain after all that gets called.

-- 
Cheers

David / dhildenb


