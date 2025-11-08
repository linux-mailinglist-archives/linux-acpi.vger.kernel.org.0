Return-Path: <linux-acpi+bounces-18685-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECBBC42795
	for <lists+linux-acpi@lfdr.de>; Sat, 08 Nov 2025 06:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161093B48CA
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Nov 2025 05:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476072D8393;
	Sat,  8 Nov 2025 05:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYCrA5kS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEnSjoAP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83AF22A4DB
	for <linux-acpi@vger.kernel.org>; Sat,  8 Nov 2025 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762578712; cv=none; b=lynaHotrquNFDU+Ws5Kl/L8GpNF/TsAPS7J6HkPMFImOrbVeVJx1tiIPjGmVBzFQqOG9J+jtEuFllyY8ojBwnrnxe0px6bRmiurxMPDksaODdzFhCY6SvbdaEJG7BQqoWVfxgwnsFTWY15nXXQajW1YAabh7kczoECSfx6cyJ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762578712; c=relaxed/simple;
	bh=e8PL3/IjwNaM0nfn0Cp/ejL3eQnuWmqm1bSvuemwGXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fr63M3fyiJ0uht7n8rO0g9MzItnKNjeQ/SvjGNGqjBdAmbZmWPrLHYbmAEgG4pYUVMfqOmgeBsOgkrM5G8lP43b4eFBuuc5plfpIgtpRbZDjdZAQ1TkxTxhQysH4Yq7pHS+sSoKtfHjcGjvEA3EyOoH3TbNze9LcxU4vcJqSXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYCrA5kS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEnSjoAP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762578709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1V/1rTXsgtj3QBQHdAmhw8bkhg1LjYt1yuOVtS3CGk=;
	b=OYCrA5kSUiCF0bS4DM5NjHX9PQllUJn+5srZ1oZ7RKWsl8GuvpiVssjXq6UVdN7bZ97Q5u
	ZtyObTktcEp6QQRmRvh5jshllZ07Xlu6JTF4bJ11gnbbRob0Cxem82oZpTk8vLhjHsCqY5
	F+GUcZjU+QYZVyOTqDWWR58E2e/+kGo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-_v8IdeoPMXGxobybdRYu5Q-1; Sat, 08 Nov 2025 00:11:48 -0500
X-MC-Unique: _v8IdeoPMXGxobybdRYu5Q-1
X-Mimecast-MFC-AGG-ID: _v8IdeoPMXGxobybdRYu5Q_1762578707
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297e66542afso7670935ad.3
        for <linux-acpi@vger.kernel.org>; Fri, 07 Nov 2025 21:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762578707; x=1763183507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1V/1rTXsgtj3QBQHdAmhw8bkhg1LjYt1yuOVtS3CGk=;
        b=DEnSjoAPcgTJNRbD9/+3AEeiTzixX9t8yqC9WlmA6lCxC3pUra8/FwiMxcCcqZLa9m
         pDEJYDsyMmo0j4FqHKxf2z7Mc3aI39t5dkeVC8cTS9BHv07ofNQ+2M+GkhZ/45Gvr0gd
         YgLw0rdoSLXLAeK9EY+JlAZssqmwEATBZEayWLWWcOauE2ESFNJ9PeYefMH5V5vEXs8L
         yU1XYYRW4z7DnuzyrIlCAiixT7PbYqc3Z4sdsiEmGsSAZWpXTRzAfMf+E4yH2Xlnnuqo
         VdsBtOEfYWQb7deMlW1eW3esUzdWYgOJa3L6LeKCHNHXN2PYHdH8avXBaW2WDlkdYUuQ
         C0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762578707; x=1763183507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1V/1rTXsgtj3QBQHdAmhw8bkhg1LjYt1yuOVtS3CGk=;
        b=r1wUDK4M+0FwjOkjRxejW14XiUwaynIgFjDR5ljgIoVw5NHPidP7tVQCmElVIlQ7Cd
         Ed6x3vzJwHlH5jHj6nQMC54SfDk1g0JRnBmHfLSW6XJCF5Qfu+P8rJRN6+6z8SGBFTOv
         sRDkmRnI6HIgMQJX9IATcSs9Hd+yjtvN3ZoKZJtH5MtUvQ2FQPgHLgldqUtaB06UBH1w
         HQbppPTsFLqVXNQG3n1bFTLKUBWG78BWf+eoQ1cMxxsD8qtXqcakWb98k1Q3tvCSqjU8
         yL08iZ5SoZazYpKXyltyMK5aUSGgj94mbtDUNtixsqhBbSUDL1s3KGvcptAH+colyY8O
         Tk6A==
X-Forwarded-Encrypted: i=1; AJvYcCXYYK0lwe4Z2nl3WKJkrYDKvyGsD5iE3vILFa6uQvRv8dkRQjd1y8PD7gkjQxX7DA84wJpMj+dNKMWe@vger.kernel.org
X-Gm-Message-State: AOJu0YxLvFyBN0o3h3VZQTDRrn2y7JjL3H9AlI0YXAFHUp+f3WZvUBR6
	aZDbx3TUpfo/b2UjZir/jOLsZ+eVhW/RokusfsXw7dWPf07Apl6LmRnD94I66KE5nX9+lC82H30
	CyES129ntLNZOihWJ/xu+vPDEs/Jmr5mSmFGUCuxmVXHhFJfNKeW7/QenIToZycQ=
X-Gm-Gg: ASbGnctxIbVZWe35oXsujx6vr+b8Ua2G80ti3YHgzWnNfVq7P6f5qwc6DLrPv0Sk3Vz
	/ZzDg2VhT3LRH/aB35thyRKhbos0L08VsNn4G/RQFXvwI6MSt4Aja3IofO6KkufyeWuqr09GO6V
	EHOwF1XT6VQbe9LGcP+6s6U6/ZyeYywrJQg/csh5iAWDfIni/tOEFsIOj8sMIO9Lwb9jWfZURKg
	XIk3R1lEqCVMu5j7nNZQHNAkrXMsP7Ry3UduOV30oQou5p+4EEQGLT2IDafSCm5ggHNpUyV/Li8
	jJLM598KLDwMToruGIbaTffb9BC89V44VEfuqig+VMS+KlKbZZvHiKrA1xtccQFTjD7DJHv0dYm
	GMZ/3gDiCn32w+lV6DyJYdSWx2pomgENHCGxiKCc=
X-Received: by 2002:a17:903:4b46:b0:295:2d2c:1ba6 with SMTP id d9443c01a7336-297e56d9079mr19923825ad.36.1762578707135;
        Fri, 07 Nov 2025 21:11:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGG5TfB74TNBIs24Dy9Vey8IldOETsxY1qXOyTg5VAa4miIQ2NU9mONOOqeH9RkJkWCKKblRA==
X-Received: by 2002:a17:903:4b46:b0:295:2d2c:1ba6 with SMTP id d9443c01a7336-297e56d9079mr19923395ad.36.1762578706736;
        Fri, 07 Nov 2025 21:11:46 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096825esm78299005ad.3.2025.11.07.21.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 21:11:46 -0800 (PST)
Message-ID: <b87ef0cb-5859-4cd1-a0b0-3f0444484ffc@redhat.com>
Date: Sat, 8 Nov 2025 15:11:33 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/33] ACPI / PPTT: Find cache level by cache-id
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-5-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-5-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> The MPAM table identifies caches by id. The MPAM driver also wants to know
> the cache level to determine if the platform is of the shape that can be
> managed via resctrl. Cacheinfo has this information, but only for CPUs that
> are online.
> 
> Waiting for all CPUs to come online is a problem for platforms where
> CPUs are brought online late by user-space.
> 
> Add a helper that walks every possible cache, until it finds the one
> identified by cache-id, then return the level.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Tags dropped due to rework
> Fallout/simplification from adding acpi_pptt_cache_v1_full
> Look for each cache type before incrementing level
> ---
>   drivers/acpi/pptt.c  | 63 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h |  5 ++++
>   2 files changed, 68 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


