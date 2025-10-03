Return-Path: <linux-acpi+bounces-17524-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E60BB5A98
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 02:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FB63C5E50
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 00:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1FB288D2;
	Fri,  3 Oct 2025 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbmKuy/E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD13F20330
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759450659; cv=none; b=qjuqk5bJ1wXZ4Ib5+VQCA6KWxI6GdkjQSUIDHsF2Nmax5S9Ks9742pfSya3TDlK59SQGpJEmPMBWB6zenoRvVQZEN8AwkRjaI/jJ2mRFRlAvX1p6Q1OdlLQtD42xENXqexHm5/+imX0PmEpy9TaMRqOh5nE0FC1ZMRI7C2KhCao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759450659; c=relaxed/simple;
	bh=vMDFerzdP8VHE03joxXkumgXWrhNKPGaMdosOIrdU+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MT2lFU2JgK99hRO9gJucEZzcMnWdKaQ9h7mmtNqOcmto57EJZl3WwN0bOnscNBrDsNJtPMDGDE5toCNsI4nEr5Wd3iRlOT6Fx1vtnvvGSl7CZAuZTbFZrzlpWTd+dJKp9Ih6bUjIdkkClVfu/aBOA7e8M7dn74kqJMj+tHn419M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbmKuy/E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759450656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxESuiqnyWWA26ID9dPTIMFHWjBzQCaSkf0/moxm4ak=;
	b=DbmKuy/EHGaJVUh9fmRm3fExUsBWnIUPHlZb173irOlnPOCx2CZNmcFSqfZo3Tvux08JQu
	V8BZICy54M/jzIXbAPqtrRytVSA2Aw3Q6x5FeoNh90bSFDiWCFxFqSguYrJnkjpU6KFngi
	v6mI5VzgQmwNOaLHSRHjmpYBfwxAxww=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-dtVkD2gYOAWH_rhnmB-WGA-1; Thu, 02 Oct 2025 20:17:35 -0400
X-MC-Unique: dtVkD2gYOAWH_rhnmB-WGA-1
X-Mimecast-MFC-AGG-ID: dtVkD2gYOAWH_rhnmB-WGA_1759450654
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-286a252bfbfso34603255ad.3
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2025 17:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759450653; x=1760055453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxESuiqnyWWA26ID9dPTIMFHWjBzQCaSkf0/moxm4ak=;
        b=I3Shi3yppc6e1i4O0EClNyYqptBEn1M/XXQIR2Oj+DQO9fl/ZJ+4d3B1ImonSRlX7g
         7V+688A+XZ9qIsUeR51KfSWYwPx6GfH8g+egayAKXJ3/mhUwQ5HYwaaLw5sfCNdWIshL
         ZmZIc7YjKafIrsaDZt2zx0vviy/8gJNN9RBRtWN6z1WWRPDTVzLK5283AOTEHNMO/4Ut
         sx+6SgUoCHWkRJ8/wWRTNEPVlWcabCo9T7KjSfYxbM7AziJR8vXUkhQ/1xIrgOeBNPwY
         wTzoCrD8dVMBBS6MMqsQZNQr5939Z+Ksq35MtTzw1O/tfhv0hXATGxP4LSGcpJYPK37v
         Nuww==
X-Forwarded-Encrypted: i=1; AJvYcCVgkb7RYUW6rYKVJw3M9mPPhx4iOdg2o/2OIZ+gURpesMwdcft3MVEvS2IyyxvtTM39ZjNNE5IUzU52@vger.kernel.org
X-Gm-Message-State: AOJu0YyWy6GMUUUweGrGFO8iGPvsNzlB47y1x/I0OfDX45cIJRdt7hoO
	NXkCLIQMj6Iy5q5zncM8UgBRq+iWF13BAwQ4jKD9kFeuydKe7QcWyc8KItudYaA+CS1x19piq6u
	TJjf3+BgpE1gDX/ljFx150qTD8KiKZNnFkF25nZ0OogFzwAKc8ZHXSMo/e9tTN0M=
X-Gm-Gg: ASbGncsdFxVdk7e6Si7sZkdz0Fyry1utK5nRnwaL0lvUzn/92NeevPaZdTSqznbs3nd
	VjyiO6w05RrXHhVxMrFJ5U4zn6NOq5NnQk1laByBBkGuaSSFpOjST0xPU12cUDRbfbGjXRAuyli
	/C1NkaWuDomUDYa4nnS1Q5NRDatVKcRL1Y2dFiT0/u+gHVs2hxB//f7ha744DZlI0W5rRHS0Vp+
	y8rG43zRW6rSoYVI7sfr4jpeAFutxP4kCm1klS7paK15BqjUm6LtkHin1mzCj5biIPyerjQKmhy
	gfZ+cEo0nD9a+OgpT0opKKzG8/HC3Gd8EbCJCE8wRL0hkH01QBR1gldVkvKtbzYYCicczayYooY
	kUojP8Obm6w==
X-Received: by 2002:a17:902:cecd:b0:27d:6f49:febc with SMTP id d9443c01a7336-28e9a56096amr14497435ad.1.1759450653591;
        Thu, 02 Oct 2025 17:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZHBudX+t5P5dhIAoHtlCGZ+jK1znqx2KJ3DZHFAw2+dbJ6/l4LnIeuh47XhZ6VySQT/LLTA==
X-Received: by 2002:a17:902:cecd:b0:27d:6f49:febc with SMTP id d9443c01a7336-28e9a56096amr14497255ad.1.1759450653268;
        Thu, 02 Oct 2025 17:17:33 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b8444sm32362015ad.86.2025.10.02.17.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 17:17:32 -0700 (PDT)
Message-ID: <37614dc9-91dc-445d-b289-1346e216dcae@redhat.com>
Date: Fri, 3 Oct 2025 10:17:20 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/29] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-3-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250910204309.20751-3-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 6:42 AM, James Morse wrote:
> In acpi_count_levels(), the initial value of *levels passed by the
> caller is really an implementation detail of acpi_count_levels(), so it
> is unreasonable to expect the callers of this function to know what to
> pass in for this parameter.  The only sensible initial value is 0,
> which is what the only upstream caller (acpi_get_cache_info()) passes.
> 
> Use a local variable for the starting cache level in acpi_count_levels(),
> and pass the result back to the caller via the function return value.
> 
> Gid rid of the levels parameter, which has no remaining purpose.
> 
> Fix acpi_get_cache_info() to match.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> ---
> Changes since v1:
>   * Rewritten commit message from Dave.
>   * Minor changes to kernel doc comment.
>   * Keep the much loved typo.
> 
> Changes since RFC:
>   * Made acpi_count_levels() return the levels value.
> ---
>   drivers/acpi/pptt.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>



