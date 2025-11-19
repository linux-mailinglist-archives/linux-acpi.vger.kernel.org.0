Return-Path: <linux-acpi+bounces-19055-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B30C2C6CAB3
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 05:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id DD9B9289F8
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 04:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FDE2E7F38;
	Wed, 19 Nov 2025 04:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHTS4HBP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nJixTnht"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14856271A9A
	for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2025 04:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763525224; cv=none; b=KaONGQTG21TxFpZYTGzcGhkkAx6zwo5Xf35s8y0kNDA+5WpL57nFmM25jbR847DDbCyJUtnx7Znw9AD4kSio7hqjl5AzAztAUYSSGwBZIqdRRcDbsWPx006atG+l1V34lSX+Ki4a84ZC48/LNHhaDmUnKHtR+Cl/wmjyzDMeAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763525224; c=relaxed/simple;
	bh=K0zV1TwwPVkS4m61kw1+BDnYxPTC8U1c3vEUwq8bXn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2rAFO4FbkXqWRZ0yBpv9gTxVu0s9P6+ZdrN5lkIrPTw/wFgUIeKlSOdRc4ScRwd76glfCbeAD/RqBWWa4GzsXwH6+noKXfuHb7CJCKZX2wFiag9Zc/fOjp1yLBpCx1Foju6It1tqkHLiI+SzVOlfK0183EkwJkJPebwo5uPz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHTS4HBP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nJixTnht; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763525220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wa5GyeWvpSlizVqAymczK429eN7FLePDGG/H+2skk1E=;
	b=FHTS4HBP844L8Sk9uacX6E3MULeeUltG4BNc1ijkXSvajDXISI8GcguN7D7XTiGIYWUMOO
	UYm5qvkk6IssgFOuyvqp+Z5K1FFqLGu1kFweH0x3fUOwP6maHiHiYeUd5jXYrafh8wzxaX
	JV+CSSlJ/aJdlGH3kLmRLWHR7NSOVEc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-I3GATCl7Pli3a3Brd_K51A-1; Tue, 18 Nov 2025 23:06:58 -0500
X-MC-Unique: I3GATCl7Pli3a3Brd_K51A-1
X-Mimecast-MFC-AGG-ID: I3GATCl7Pli3a3Brd_K51A_1763525217
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3436e9e3569so14320230a91.2
        for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2025 20:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763525217; x=1764130017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wa5GyeWvpSlizVqAymczK429eN7FLePDGG/H+2skk1E=;
        b=nJixTnhtAoOCS69BIHq8zYSd6uwM+IRMJQaKycyV52YPDz83uM7RAngiIz1j5UwsDS
         mgJR7JdOy+ItSywQZl+Jf2uK34lMyLn7M6HDtINnqy4Xi3Q88GQE8WLw4DPAiEwx35w5
         p8qdOS4SS+L73F+Hhgv950nhK0YIgweOhDs9IQ148F6JoKh2wqi/V+w7WBtHSHxY3CJP
         GZHD7250XvHR3fYRDLcNoVZsPowo0A6UM0NtJhe+6hzrD56hpdSI5gFfljTdS6i1wJvO
         lO2Nm5zw9QCJIkGYXDaCo2VUKpv/Z+akpUVjY/SGc7ony5Hgsz8svARB2VQtvCVQlP4n
         6pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763525217; x=1764130017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wa5GyeWvpSlizVqAymczK429eN7FLePDGG/H+2skk1E=;
        b=iqRTMDH75byjrNeoZ9qGcWYm78tnU1UWD2uVsAGUfbC9CLy1HvnpO8Qq3/Vz68CTol
         QDyXyJw/qNBiKh8bTGuHXprCb9a27cpQhlY3k+bMB87tFgq3nVV2AQOGRUrUQ4aP/rVz
         EAgbVvhB1SjsohW+6LqaIdo+uzVoYKMk3WvBaiZqAEF6twcP0o2pqJtbiGwQ75FuAsCl
         OKlLnVIRIVrDLHLp8g8EBvb4SzWc9GMTrhnSl3R2wcgtjhL/TMs3YlPPWGJwGJjZVaGM
         2Oyd7PJpbVYC3LlyiTUf3jd7qhRUahu0/EbMffV5v57oOlC4qA3DnfxnoehwLGX//s2S
         fgyg==
X-Forwarded-Encrypted: i=1; AJvYcCWfavsgFnjAilO7DJT0e+0vfF3fEagxnYbjXVDG5Du3kmfK0zfd3oIEkjG+QF+py6Z4lE7+MW3SJ2Hs@vger.kernel.org
X-Gm-Message-State: AOJu0YwGMTp9IfxZOtHluVQaK/v9K8PwqSG1V03cpk6gDda24+NzNIE/
	j08ayYYNEbTbbV9HctA/zerjeFMhWtJ8FkAYBmlnhyMqTGvSzzN6LEMX8mYa4BCtzwn2QG7a642
	TZMimvlAWDukV9iRID/9hAWDr1dJEwCmhuZcjMuy8EoSlXmXxby6kGk1B69MXcz4=
X-Gm-Gg: ASbGncsM8IsaYwn3L/Sa3Xz7kGdtHErTAKmY9F/EHREEi42uQwxgwxAe7juKde/EvwM
	Ghmo3xuHTBonF+fvUZl6TzDqIU/lyRuMvdfzTHhZTNYKYL8sRwtIG+o9Kw0bbfNly3jHoGZ0U41
	xJDHm/AK09jyd1KB9sHie5Kk8hkoQF63wQSd8Zj58PEl7ZEbpOiTPLPciE3JZKviBkQMe06NHFZ
	ibLhjibVZ6uE3Sw85iBLBflAGrXSnjYTOZo4ZyYMWHTN9lllg21/b+CcFhGAC+LqnK+FA34Txu3
	CmrN2Ks7kq+nlxUEh/07rWvYslsmf4UgwQO7rPrHDO0XRb8Z1gpZjSSFnePLwwUfJ/xf78R6OxS
	XcxGcvFkcCsKXTFlNa0TTJQnD59iwnIVKqzzduesFMrPqWmts1w==
X-Received: by 2002:a17:903:2b07:b0:295:2cb6:f4a8 with SMTP id d9443c01a7336-2986a76a1edmr188721515ad.51.1763525217179;
        Tue, 18 Nov 2025 20:06:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFybKZJ5dfVKQv3kow6RIEu6ZMStfbHdxTnbwIkRbQ4dZJNBjn5fnddYH54ZsnsU2+P3UQoEg==
X-Received: by 2002:a17:903:2b07:b0:295:2cb6:f4a8 with SMTP id d9443c01a7336-2986a76a1edmr188721185ad.51.1763525216817;
        Tue, 18 Nov 2025 20:06:56 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346b8sm190579485ad.16.2025.11.18.20.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 20:06:56 -0800 (PST)
Message-ID: <1a8cd97d-4aa0-44d2-b25e-5e07786b0631@redhat.com>
Date: Wed, 19 Nov 2025 14:06:43 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 34/34] MAINTAINERS: new entry for MPAM Driver
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
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-35-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251117170014.4113754-35-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/25 3:00 AM, Ben Horgan wrote:
> Create a maintainer entry for the new MPAM Driver. Add myself and
> James Morse as maintainers. James created the driver and I have
> taken up the later versions of his series.
> 
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46bd8e033042..ec9b2b255bef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17463,6 +17463,14 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
>   F:	drivers/video/backlight/mp3309c.c
>   
> +MPAM DRIVER
> +M:	James Morse <james.morse@arm.com>
> +M:	Ben Horgan <ben.horgan@arm.com>
> +S:	Maintained
> +F:	drivers/resctrl/mpam_*
> +F:	drivers/resctrl/test_mpam_*

Maybe to squeeze those two lines into one if another respin is needed.
LGTM in either way.

    F:   drivers/resctrl/*mpam*

> +F:	include/linux/arm_mpam.h
> +
>   MPS MP2869 DRIVER
>   M:	Wensheng Wang <wenswang@yeah.net>
>   L:	linux-hwmon@vger.kernel.org

Thanks,
Gavin


