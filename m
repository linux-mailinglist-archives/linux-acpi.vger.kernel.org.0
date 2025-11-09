Return-Path: <linux-acpi+bounces-18712-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CB6C449E7
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 00:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277313A05BD
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 23:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97ED270ED2;
	Sun,  9 Nov 2025 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEJyYg8G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VB9kLryJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570FB23D28B
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730211; cv=none; b=fLiV+1vVaXgnX9fdAm7gMckRnhArrviAZ7unefzuAgkui3PcpeS3E06+Ggs8s7TkikBtt3yZ5Ggj5mqPf5+KSH5jJRWEp7quEoX6sAnCqd8OcogWa4wf2AiPCGDyk3cQssrb82YR4Azzd5Fd6cEoLX2jPlI9qNPqnY9ptvUYGi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730211; c=relaxed/simple;
	bh=eQzZIUSfykKTnBoKIiXY7tR2Sa2ZPN7TE0zOJotU6uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAptGo6a6hxcUq+gUg/yzRZviZE+ER9UjAMaTC119q3hyepznzhyg6DsWSmGxywBnOoBUupwohSiLDuIbqLHHm4e79l5N+hiv5U3vhv5jHAWuro6bDGhSPWA0/NRUwmQjB5DzL8MQZztNjadsFvpEqAAKmpWmRVUtOslOpuCbyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NEJyYg8G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VB9kLryJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762730209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTqh8jmOS93oohVyFSekWpawat5RQCgtELIur79S/mY=;
	b=NEJyYg8GmjWpaMf+0zzp6BTp73Z+FXZa/6QRXxhx469iwbJG/pY7HeR/oweoea1EFQ2mvP
	HCQHP0e+qq/cuYPer/qq4Ja/3tzJXOnGDZ978tWYzBuXucZzYLMdfmaq3cvHn31AmAoQv9
	LBgZKk6/Dx5JcHlAS/v+wAGJFcrz4mw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-xiOXuX0-ODCuT8v6Ss7uHA-1; Sun, 09 Nov 2025 18:16:46 -0500
X-MC-Unique: xiOXuX0-ODCuT8v6Ss7uHA-1
X-Mimecast-MFC-AGG-ID: xiOXuX0-ODCuT8v6Ss7uHA_1762730206
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6097ca315bso5936425a12.3
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 15:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762730205; x=1763335005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTqh8jmOS93oohVyFSekWpawat5RQCgtELIur79S/mY=;
        b=VB9kLryJ69zXcXsQKMz39y31NJFls1vu/TV70qNrGud3b3+8kLCZtiC7H8s+d4qnC+
         2ziJgXi+n1KeTg2HUYAGbjEJ9EShAIeY4HA2k6LYaZB4/NeZnZWCfJ6PSlBTMn+/xS1g
         vNvu1l+XvndocRwp89vGoH4WQOhCr1ZDOwzlV4J9Q2XEExCSAHQSoP5kQwBObnWINuMJ
         +TLXp8KQSLI4JjXddIvDqYie1ymy7z1B/Fo1/x5aeF5hDecpG3UQbI2KxXdsezNzYkX0
         UDNicBQFghYahSotnOkKjCIqXJsJ7ZikV0XS3viYtrq5twZ+9diTFgGRcqKYwG8YFNA2
         9W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730205; x=1763335005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTqh8jmOS93oohVyFSekWpawat5RQCgtELIur79S/mY=;
        b=xKookwgHt89YvPJBspwH4P/9GrBMD4c4duhtmvr+XHEyeWEKHZvw2UGkyr0st84opS
         BEg4wFgHfVlZQKrUFkgoDo4jlxmSNS3ppR+9gZx7x6P4fnQ1KQwDo7I7H7AHGhY8CQOM
         trJNMyw0Dab+/PZgoymdLHSfAzO20dUeCGyvrMx3EXeTPjo+6PLyt4AgsoGlShAtlZ+U
         NsovgJJnOpQrjDnZeYpABTkLRw4bR4s9jLvxpnrm8Qg9Xf17zdO8hnGifRzx4G1gtI1w
         W8OKwr7VPRlDydGZtktL5GonoZYtGmRj8PVcx7hOIsRTBmqFg542TxXwm3SLZQSCBV/e
         Jouw==
X-Forwarded-Encrypted: i=1; AJvYcCVVH7B5Wba4/oo3tGTBnBgsf3aQb/c8ABm3+YNBq4lTlzwSTE/+KnT3HWon+59PrhdeWMg2AWAzbZiZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwTtwbCX70AhHrJl6oBd5HeqWb544BMfck6rSlZ8kD84Q1Ur67H
	Ml0KHopX4OqTkTmWB7/tgDR/tGUui6Am3AbCFqG+IUq1knki17jAh1dUHCOfciCZvzPqQXvd2Dq
	0feEP/5xiw9/TD4eyo6WWi+s2rHSyaXpJpBKDgbsGgInHslr/4AnqFK+0FCTsTJE=
X-Gm-Gg: ASbGncs5H+9FDFFQpAOYRiwHJMEdRfUOHRUA3IwjsH+Pc8l7ySV0G4nZV+LyaSdQsa7
	owUs/nUX4ZTEJBGqiCuF65HCdUHlAVj2bqI3Kh77jC0eW2kxOZeu09/GXYP3iVxN6esC1qHivsR
	+i3NEeEr+KVr5BpgW2nY77/wTw+SPelEI3XXUHH4DmZiq5G2fmwGXczIyiWiN9W8ZDXGUM7UPKv
	SfBITGTuhbh9HZ2c/1MJn9/zgt25ungjS2bRWc7NwLLKWHxYtdMtj75O+KeftTxc4mOmTRVchH3
	2G56T9DJiyrazfHu2iiFEWgpqCkIjwiKP1Gu9HyOWsrJ2NJXJehAAEEN7MvKaAhL/jj40JYHjp9
	NPcqLKM/9WTwDbzdN3UH4mRp2bJT/6WpN3J6oQkY=
X-Received: by 2002:a17:902:ec82:b0:295:4d62:61a9 with SMTP id d9443c01a7336-297e56aef0fmr84827525ad.38.1762730205523;
        Sun, 09 Nov 2025 15:16:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNnY/CNaLSySWvx3SVi4rlFrYuCp9os4fjr50iYp2+FkzGPAxbALNV0IsAj3LaGTB1bS3PNQ==
X-Received: by 2002:a17:902:ec82:b0:295:4d62:61a9 with SMTP id d9443c01a7336-297e56aef0fmr84827125ad.38.1762730205135;
        Sun, 09 Nov 2025 15:16:45 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cc1833sm123856145ad.97.2025.11.09.15.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:16:44 -0800 (PST)
Message-ID: <3448db42-cc36-4d2c-b6f9-b2ed85bf9227@redhat.com>
Date: Mon, 10 Nov 2025 09:16:31 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/33] arm_mpam: Probe for long/lwd mbwu counters
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
 <20251107123450.664001-30-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-30-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: Rohit Mathew <rohit.mathew@arm.com>
> 
> mpam v0.1 and versions above v1.0 support optional long counter for
> memory bandwidth monitoring. The MPAMF_MBWUMON_IDR register has fields
> indicating support for long counters.
> 
> Probe these feature bits.
> 
> The mpam_feat_msmon_mbwu feature is used to indicate that bandwidth
> monitors are supported, instead of muddling this with which size of
> bandwidth monitors, add an explicit 31 bit counter feature.
> 
> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
> [ morse: Added 31bit counter feature to simplify later logic ]
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Only set the exact counter length that is supported
> ---
>   drivers/resctrl/mpam_devices.c  | 34 +++++++++++++++++++++------------
>   drivers/resctrl/mpam_internal.h |  3 +++
>   2 files changed, 25 insertions(+), 12 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


