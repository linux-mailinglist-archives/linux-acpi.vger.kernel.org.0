Return-Path: <linux-acpi+bounces-12321-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10B0A676A4
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 15:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD383AE51F
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 14:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6FD20E018;
	Tue, 18 Mar 2025 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPZ4/oc3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D5F20C47B
	for <linux-acpi@vger.kernel.org>; Tue, 18 Mar 2025 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308761; cv=none; b=V9T4Uuec3sc5bt4jyJc6R/aRbruZVjUgDzgEnxo3vzU21DJwfCMddmJHoOrxNGnjNRbr77hXQwnH1TrDLfTddj1pMBzgLyjulF/xAbb1etaC1TODMTLE7QP+o1iPr5tcMAdNm8YGgBvwgsiNpw0a7RSg5vDBDaJemC6OvexFcfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308761; c=relaxed/simple;
	bh=VlmrhLeJPUEFA+lzg8T6jHkvVs+Rt91krv8MHtKaYng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iypf61DmDt0oNKzFvuBQcfcdLof2dq5jd7U5a34POwvi8d5/H1dHCy/I9EYrtXXUXcjAXZ27O5VaMEDmw4FVzq7HIY6cxq67u640aYnwCLXzaky6pwXl4IQA+BtiSEdyWgusD9px7cKjfPhZ7R/US6Bk6R+OLuLdAeddx0zdITo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPZ4/oc3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742308758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PsQlwRAe+Vfyt5oYdUWSq8JNPzE0Apo55NHwyi1kdq0=;
	b=YPZ4/oc3qQkd8NDHnt+27Xqv8TY5SjNZEUZhxH3Um6/AQaZUC4RdG4Z5vGJvpKuMTKnVAn
	CIAKVjpWNp9NUQfXZsAyy4LfWwfAkgSojb2Q+kCz3NjV5ykbA7SMeMaYtEMBZOlMVjUlXf
	wLn1K0Bnbf53vqOqo2e9MyJy6IFiUhA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-20hFt16cMsaG_ufVnaLLOw-1; Tue, 18 Mar 2025 10:39:16 -0400
X-MC-Unique: 20hFt16cMsaG_ufVnaLLOw-1
X-Mimecast-MFC-AGG-ID: 20hFt16cMsaG_ufVnaLLOw_1742308755
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so20091915e9.1
        for <linux-acpi@vger.kernel.org>; Tue, 18 Mar 2025 07:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308755; x=1742913555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsQlwRAe+Vfyt5oYdUWSq8JNPzE0Apo55NHwyi1kdq0=;
        b=d1Xl3mixM9fYwNgD6mrHT1ShOI9B+KkTkJvHqxmIiXZIcR6gWtBqZvnSGINRxE54Sc
         IihB8WcyuvYi7vWTybkwzRtIdepUipp1+VaLx//bx8weLP17pa7Uz4w5hGiJIF5wpCoy
         qTbN8EAnzfxnxHK0U+oQ7JQPR3AgtvmGAur4P7UbLW/tb4f91hQfCc+C/2lMRxqb0wcF
         4FpiETMaXhZBAObPCruAFD/vPMMRWt7o0eKqwaAV7b5WCXT+KBYborxMyynSk3wN6eIp
         WFLlvSVfXXWklPVIc1YXeZU72Tu7NrenCV2wlVZEaqbquD8fnJxyTnZE4RuWy+aOwuDN
         8D1g==
X-Forwarded-Encrypted: i=1; AJvYcCXdSh/18e2lYuzxf1mITg3MYwqHDsOzxk2bngtaKVoVw+CFAmh8tn4Sm10u/qbxgQZBmn8pjKJXLmxb@vger.kernel.org
X-Gm-Message-State: AOJu0YyoZyOIdpk+i4w9Cvh8W62f3FMQPjiXdMyGUDR/G7iJ7LdjrjkD
	l22i4ZPWw38S2KVV/emqpA79/1f5UTwUYolqRO0H++2md85elOdpsHKVAbw8IsEIpGBjpzkA+5D
	lMCiEsQf579IyWz+50QtDuMuusrdmJzeb3u6qgPds9TRlRnI03nqsfiUW4H4=
X-Gm-Gg: ASbGnctVk6fVUwPnUG1GZUY16pcEMgUtAtU0f7Vkz8vd1vc5jXkVfESnDEyQjY1kla2
	RT7bfYB2i1vXyapiJE8GVXiBRNV5Mb6VDgBHJK5nY3BQAbdT9VE112KAJmIlBjQaAUQR1e+nhoM
	v53AT4PtRGvA0dpr/w6PafKvgHd76DxmBcdtJ4tMo4ClO1T0mPmf73qOK05YK1Y3VhXxeFaTewi
	QyttC/qx//hQ6F4V+oxcccGUd40knCF6ChBshv2FE9PEmunJ2YopLOf5UnjmLWNC6UGgfuxf87c
	5FbzHPUkjAmHt7giG1Fn7pAz2miUFKTzLAU1J4sDIzDqBg==
X-Received: by 2002:a05:600c:138a:b0:439:873a:1114 with SMTP id 5b1f17b1804b1-43d3bc12751mr24184625e9.6.1742308755368;
        Tue, 18 Mar 2025 07:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWUKBTOZHulBPKccJIMkih2ejX9HgOTZC6YQk6IraOUM0a3ImJsw3fgLjtFZUV+DmHGg37Vw==
X-Received: by 2002:a05:600c:138a:b0:439:873a:1114 with SMTP id 5b1f17b1804b1-43d3bc12751mr24184395e9.6.1742308754930;
        Tue, 18 Mar 2025 07:39:14 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d393bb288sm27247155e9.29.2025.03.18.07.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:39:14 -0700 (PDT)
Message-ID: <d67a6f99-3d67-4843-8a32-83b086952ab2@redhat.com>
Date: Tue, 18 Mar 2025 15:39:13 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: remove sb1000 cable modem driver
To: Arnd Bergmann <arnd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
References: <20250312085236.2531870-1-arnd@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312085236.2531870-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 9:51 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This one is hilariously outdated, it provided a faster downlink over
> TV cable for users of analog modems in the 1990s, through an ISA card.
> 
> The web page for the userspace tools has been broken for 25 years, and
> the driver has only ever seen mechanical updates.
> 
> Link: http://web.archive.org/web/20000611165545/http://home.adelphia.net:80/~siglercm/sb1000.html
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../networking/device_drivers/cable/index.rst |   18 -
>  .../device_drivers/cable/sb1000.rst           |  222 ----
>  .../networking/device_drivers/index.rst       |    1 -
>  arch/powerpc/configs/ppc6xx_defconfig         |    1 -
>  drivers/acpi/acpi_pnp.c                       |    2 -
>  drivers/net/Kconfig                           |   24 -
>  drivers/net/Makefile                          |    1 -
>  drivers/net/sb1000.c                          | 1179 -----------------
>  include/uapi/linux/if_cablemodem.h            |   23 -
>  9 files changed, 1471 deletions(-)
>  delete mode 100644 Documentation/networking/device_drivers/cable/index.rst
>  delete mode 100644 Documentation/networking/device_drivers/cable/sb1000.rst
>  delete mode 100644 drivers/net/sb1000.c
>  delete mode 100644 include/uapi/linux/if_cablemodem.h

I'll wait a little more before applying this one, to possibly allow
explicit ack for the ACPI and powerPC bits.

/P


