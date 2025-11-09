Return-Path: <linux-acpi+bounces-18689-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD48C436D4
	for <lists+linux-acpi@lfdr.de>; Sun, 09 Nov 2025 01:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495C33A48A5
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 00:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A57143C61;
	Sun,  9 Nov 2025 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPhDoLzw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A41g/iDT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74502F872
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762647929; cv=none; b=rDjlQ1XOVXimfaw9ew0zbsIVv+Jwx6hlLpXtxV0S0YU5NvDiaNfVvkO2YA8zgFVnRn1HqOTbs5LTHlJEU0sHpxbTVplcZ5xgxU9IUQxmxHtQhpH3q/5HoGkoJzMWh61DN5qbTler1RH09ZQL/a84+btXdqEBkgfckz3JOlZlvCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762647929; c=relaxed/simple;
	bh=ZhTnpJkzp9b9OpiEjTRFs06DDFrVsei3iY10Nu8Q1eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCH1SQqjVRB+rj3yQzoph/59VKwUsimezWmuZKBI1pvqaImhD9Q+eecYKs3fF/C3YZaWS95NqBqSXFZlxiLN7yjiCXQ4ZYdI1TxjB3vKIJoilbPTEIfZhukQd5SBsSwmOeU/AB6dz/hcQ9eDxjEyfEv5ekAQPvd3Q+VjEUTnNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPhDoLzw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A41g/iDT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762647926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GjM2gkzQil19AomxuDInwTt2gkWOAouhNdKUHEv8N+w=;
	b=RPhDoLzwJh/LchEljvqQFEJoeBsGq+f/OkkqOZ+vwpuSpgo3+pv+ZjSJd06tF8YD371N64
	mbu7Koci9bE+i8QF23EjEz9cge/IXt8cX04Qp8RBFeTSws+77ro1PLxQAzRzZBaeNAKtBw
	vfNV068xZ4sVXcovfJut9JXQTY624So=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-bsqnGYqTPHSy-NzccCtRDg-1; Sat, 08 Nov 2025 19:25:25 -0500
X-MC-Unique: bsqnGYqTPHSy-NzccCtRDg-1
X-Mimecast-MFC-AGG-ID: bsqnGYqTPHSy-NzccCtRDg_1762647925
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2956a694b47so25201825ad.1
        for <linux-acpi@vger.kernel.org>; Sat, 08 Nov 2025 16:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762647924; x=1763252724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GjM2gkzQil19AomxuDInwTt2gkWOAouhNdKUHEv8N+w=;
        b=A41g/iDTp/JRzGsS3khF/3HnTEHaMb7MiwGNqOSc9HpYyE1B9+S745Jy+ar2vvMCiA
         8Id5+38hfGWKKsZkkpcsXYyLepF/GYyvqVVclms/bFlxdWOBG4PLnU+cRfbpW/dQqQU9
         OEyuTbowZHeVyR5NiU84AvYKCzv+/MZD8zAOlAvFlWguZjOYg/55FWq6S7OoBA4s73nN
         L+L1Of7M8U2c6jSSzNqV4eqKgeL2N+LLWzQB0PzFLI/zp4AwozYB4TvzD5AOqLJH6+uf
         NwtV2wl1S6rJS0PIJDYIcl6KiLLxrEGdmwLK/kZBPCxGQOai+Vdr6JXRSYha5vsBOrpF
         VVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762647924; x=1763252724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjM2gkzQil19AomxuDInwTt2gkWOAouhNdKUHEv8N+w=;
        b=N6pGlOfvm0S7EmThQNyDTDydPNC9PnG9UMe+JTRK/kRKl5YnSn9SqnHD2jVQ4xvqyG
         LvnMh+YH/1v5VzJ3oWdKD2qlLeGGvctnQOMxTVzDVTEn8z/aYhSz14qHY16VVMH1kEBB
         BoBpzGgG4OA3I1KwHL5X6a+6ttX/x97as1aiRDLPQLxoQBXDZ3KX9Lc/JMRgjoOLvJ8z
         4vccG8Xp8js7c+qRIjAgZJZQPmMN0DxwvJIeD93n5S63hoTzJ4TG/S/zk3E7eJE4kTRo
         kSgAnOaaohGX/k9X7WVqMwG3GJOihifixlO3hbjesI84sK1ZJYeNaGkmhWqfJKmo8OD+
         jNIA==
X-Forwarded-Encrypted: i=1; AJvYcCUPal1/oURb5CsaLfyRfmg+O4f1TUtlbmCG90R1amjCHYNEfaecoqzEnewOxEf9R7CQsr4iY9/3vAlr@vger.kernel.org
X-Gm-Message-State: AOJu0YzzTrUfCf7amezvmM+obCk09SWSAGDkHeNVDmuUZuurbUwc9IFd
	wMQvVRCpvt0VIA8RMmNOw+LCq+ukG87wDTSPfrG5t4DtgnWDS1uLzQCfVuKw9/AbpkTY4tfpifW
	IZNvB+T6jV3OHh7QIkaAml7/aXBtfEaySMPZogqZbqCAn5fq7A28bHhtHK479u0I=
X-Gm-Gg: ASbGnctCQnTGacHBeQsCAJ/oAwRiRhNbzIKELKpzqe/EWhWzJu3v1ya7HtkkPNZOCKa
	IXLMYLX6n1XgzbiKG5HO9vSjgRbA1otadeAumsRv7WQIvJHPU9l1ajtF2CbugDE0ms4jXkTCMu+
	UnwX0pvRsdJ5BVgB2KkH9DC8j5DurqADOkKAaW7LdOQHZ1+Ju5YNsGiQ8klFQekToWPCkznHkRa
	Z/9qNVDnzpUqj5MiSCx9YidYJAqb9T4Vy9/hNh32T27d+rN3R6ypmYu2GPCagpXURFax/0OVahX
	QrBC48KGQof3wrFzKk87fTEkf5xO5No6zK5uGtgU7hmsvsz9zkLpWtyK8+z0LCQ5qE5k6nbazoy
	W+L/nMJXHAgx5GPmsOy2cwNUU0FHUU2StOYFVI6g=
X-Received: by 2002:a17:903:3848:b0:295:3ad7:948a with SMTP id d9443c01a7336-297e5623f04mr54415005ad.16.1762647924329;
        Sat, 08 Nov 2025 16:25:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjT7Owo8XJeJOTrgWjvPtiXgZ1vBfz4lfqIxSQIjV8vhLk1OAJS8nDYaFPSxNIg+nMeJmM4w==
X-Received: by 2002:a17:903:3848:b0:295:3ad7:948a with SMTP id d9443c01a7336-297e5623f04mr54414545ad.16.1762647923976;
        Sat, 08 Nov 2025 16:25:23 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968253sm99440425ad.20.2025.11.08.16.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 16:25:23 -0800 (PST)
Message-ID: <6aae3021-4e0f-44a4-b842-8b8f952031d7@redhat.com>
Date: Sun, 9 Nov 2025 10:25:10 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] arm_mpam: Add MPAM MSC register layout definitions
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
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-13-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-13-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
> (MSCs) with an identity/configuration page.
> 
> Add the definitions for these registers as offset within the page(s).
> 
> Link: https://developer.arm.com/documentation/ihi0099/aa/
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Add tags - thanks!
> Consistent naming of long counter variants (Jonathan)
> ---
>   drivers/resctrl/mpam_internal.h | 267 ++++++++++++++++++++++++++++++++
>   1 file changed, 267 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


