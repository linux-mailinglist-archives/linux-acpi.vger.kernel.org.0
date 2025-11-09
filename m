Return-Path: <linux-acpi+bounces-18700-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E6EC44892
	for <lists+linux-acpi@lfdr.de>; Sun, 09 Nov 2025 22:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4BB188B511
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 22:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35390262D0C;
	Sun,  9 Nov 2025 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOQ4A1a/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MglZBJ2a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF91EDA03
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762725592; cv=none; b=mlSXuwgvpEmMgMrd7iocqboavpMTJn0+uILLzNdiB/quKvoIUX67I4wYDQft2jf7cBCRV0dsFkuEtBv3pzD9giAocT/MWhG+KyNceGQXY1Lh4RIo3zzcDM3qSF455WGhUyERrt1xlpJP1NMmod2G+wZ6Qkxgy4YqbrJtwagCACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762725592; c=relaxed/simple;
	bh=IU3Eeybi/pAl8nQm4Ma+Clpr7lyLy/AS2VPSGSRA6Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMRNaiiqX0NbtfMY5KEr1GVL0VaaePbqduy55zFQH8ktF833oBuqUKu/TMsS0JmB7ssyu7fwbF2WsLn/B+din4hh/rOp13r1VHWVULNNLzxMiXKWs3WyUDkN4HGps9Lql90w1SD9iUPStGbt45QKJ0rQfR2OA81/d6TxJjJztGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOQ4A1a/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MglZBJ2a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762725589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vrkp13U75D5ocju9TrltPfjNVc3UEKucGVy+HHM/EeY=;
	b=gOQ4A1a/UAuGOK5LcwsV/NZYUX4ILfNNRnLZFnCSFGk98XcVWIW5iPRnt8DaYGpqj/9Tvi
	X6N15TEIbC22Kkdnr+ik4NcKqaGfsHvMwm5Ii/WucvYsxJ5zqgkBerDJRUEAdnEn9JkL+r
	ALO0tgNZlmzdkCEmiIk6jKXndu0ZJX8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-Sp1rnqATPgKjaiqmUXEF2w-1; Sun, 09 Nov 2025 16:59:48 -0500
X-MC-Unique: Sp1rnqATPgKjaiqmUXEF2w-1
X-Mimecast-MFC-AGG-ID: Sp1rnqATPgKjaiqmUXEF2w_1762725587
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340c07119bfso5822035a91.2
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 13:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762725587; x=1763330387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vrkp13U75D5ocju9TrltPfjNVc3UEKucGVy+HHM/EeY=;
        b=MglZBJ2aOxaDK6Oyfpd/BMUZz1n7fd345BUxyNBXOrHTYXDkxQCULW2b3CLUrcS/mJ
         G81pMDYRrly2/87ucqloIyiX1iM6ZQvUMGBltSyWdSDMNgtssB6rPiZq84Zbcvcn7WpY
         iUeJSWm0EWbRgKcGoAxMU5VeAJB5J3hRUq6OGH1oqBbCVmjBGwFtRYqdLGB/7X51IN4U
         D5rEsbBYPvnJ4zS4s06mo5rvCtyWJ2U5+E28carkujVJrTAvEq8btCaPQx7uiDzksBUh
         Kc/slDUaQScCSj5AiPLJBhqVU9qp1LZ121h0jzJgUvpDLsAuXIP8TrQVEeNDhqSL/vPz
         qAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762725587; x=1763330387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vrkp13U75D5ocju9TrltPfjNVc3UEKucGVy+HHM/EeY=;
        b=DtAvyTYy76w2eecIXgWD7I8zowNCrvhf0c9gj1+PHcp9DxEeGAkORpH2U3sWog+qah
         Z/5LEGGYBWRWkTORHAefN9SXOCyTbp3+Bs0RWAyNLxWoEO5vMPm49CP2DJ7n98XKB+eO
         715Megsv9Zh8zNvZ9CuEGege+dF8Z1OFQvIq9vh+aHQ/4HWev0+LJZHsdbqsvfmoU8u9
         zhDRbJBgPTERZ7Mf6L6O6iHM9/VOgTyutf4TN0V+Sx9NLzCMKTn/aZYIHwX5TcTPMSOr
         jIV01W1keehY9NYPZghtR+KeBYvuksUAE5tcv6z7bSQtnGxSv6bGSyXKYOGsqdCRAv/L
         1n/w==
X-Forwarded-Encrypted: i=1; AJvYcCUf/lZa7VogojgFDUPMetuIzkoUXL9onr3DCl+yKLGuN0gra+TX1VUkN5J6H0TffLyMm1h05ckw437x@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++PXBQvZImjKnajjXbzweb/Y3IuamUdO7YdIMfQd5V+kI/Qyd
	RPKcQ5matI6t0tLQgltWxgqyjPOE677Cr5P0+sBi/PHWJGtwVXa0Xq3Z0fCo0v9UVIE1QMU4In6
	hf316dKwQkIBv0G63g1RjKeFhSgiam6ppKoFKeWzq8St0+ixdyueT7yDdMuIx5KA=
X-Gm-Gg: ASbGncuKGU5tc/NqfAElFnwe9dMNHvgPaUIzWyZDzh2NZ41z0msT8KReGE5gDizHPzN
	g+UMej39rClzZh0NFskGcjG1cXBaN7Lz4Ua3OyDaFKC0Q35BwdlplbLXFv0rPoLWW9Xwko96Obi
	35cO4gCWIICmeOBoDrrlzBDtiEULHrSGxSwQMpdEaR4bM60tY1bZjmGQMCbgAOCrDHwQVpEC8K0
	xA3ycca9FCgVp3NwQsBJLwehYLp7grssMduKsgjw8WSZRPuqXnB/9syFRTbrNQBJL34wSmBR94/
	PFnJhOar1OiR/5+QKcoZ9s51uoZJxyg3iNc0p6QHe2zDrp7tvx0oCd6icEidK0cpiVZXAYlxN68
	yA7bgptTDp6o4XViWWiP1Xi03tJ6lQjT6ugeEYqI=
X-Received: by 2002:a17:90a:ec84:b0:340:b86b:39c7 with SMTP id 98e67ed59e1d1-3436cb91cdbmr8688586a91.11.1762725587161;
        Sun, 09 Nov 2025 13:59:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3A3I4/3RLhYe1QQYreru6FNEuBJIm7pFjvEZOnSNhvwUxUwbVCr6B7zDVjGaDu7x0cbLDOA==
X-Received: by 2002:a17:90a:ec84:b0:340:b86b:39c7 with SMTP id 98e67ed59e1d1-3436cb91cdbmr8688543a91.11.1762725586835;
        Sun, 09 Nov 2025 13:59:46 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a699d6dfsm15532033a91.16.2025.11.09.13.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 13:59:46 -0800 (PST)
Message-ID: <f7b7ffd7-8674-4368-aee4-4376d127b0da@redhat.com>
Date: Mon, 10 Nov 2025 07:59:33 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/33] arm_mpam: Merge supported features during
 mpam_enable() into mpam_class
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
 <20251107123450.664001-18-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-18-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> To make a decision about whether to expose an mpam class as
> a resctrl resource we need to know its overall supported
> features and properties.
> 
> Once we've probed all the resources, we can walk the tree
> and produce overall values by merging the bitmaps. This
> eliminates features that are only supported by some MSC
> that make up a component or class.
> 
> If bitmap properties are mismatched within a component we
> cannot support the mismatched feature.
> 
> Care has to be taken as vMSC may hold mismatched RIS.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c  | 214 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |   3 +
>   2 files changed, 217 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>



