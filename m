Return-Path: <linux-acpi+bounces-1440-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E18D07E963C
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 05:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8571C20926
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 04:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767E21A59A
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 04:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUvvdqty"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C47BC2D9
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 04:16:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27FD1735
	for <linux-acpi@vger.kernel.org>; Sun, 12 Nov 2023 20:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699849002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aB5COy4QAe+eFccHV1YqyKzO84zBoVzPy0R2GMj01o=;
	b=hUvvdqtyCi5jfCJAKsSc3amNcmqs75DzyhnEXm2yR4dCpZbhn2M+esF3MxLinCeDvm2Phx
	NgVLtePNho+Yaj3S842B+tbcaqKxflS85S+am333fUu0TFTGLPMVNpkut5hfaHPsYQeHrb
	3QMH8fcLL7iTc0t15ClwyWDCW2Vykxw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-9ssiPHRwMQecAh9wlWZZZA-1; Sun, 12 Nov 2023 23:16:40 -0500
X-MC-Unique: 9ssiPHRwMQecAh9wlWZZZA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5bda015587bso3505939a12.0
        for <linux-acpi@vger.kernel.org>; Sun, 12 Nov 2023 20:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848999; x=1700453799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aB5COy4QAe+eFccHV1YqyKzO84zBoVzPy0R2GMj01o=;
        b=P+fqLKBB6MnnX+vntbP1G8ocb003rv8hjcf03bA7d4mDJv+BRPQnvnkY29iICXvKVJ
         3flkhuaYqzfUwzYoWYX66faS142nI43yWADSK11wVXYNijt1+X+0zfuofc5BwAGforkk
         myZ7rVXBeg+R7w3KvDqK7LcNtjcNLB1JEJsmx3rvW7Dwj+QDcLF0t+a1RDYBjjim/Ftw
         H2/L3lDgMHVjLEeVh0TFpzzLAdCUPWRdTNnvn+j+dd0+zj4VINvmIbAVgSG9KeH6eZ1L
         smXXh3KwFJdvCZ1i0CYNlKJ0qcqUk9JOqT28NwIuyElX7nzwdLEDLcFxnTxp1f7jExMG
         al9A==
X-Gm-Message-State: AOJu0YyKZBHoqxAv0g/D/J1r5mJr3MScy5ZyXyRBuWjFivS2mX/LGszQ
	+4+ZtkHt0UvEKqKQv7JS1bFIIkN74pnZiaFWUK0QnaQJ7t0cN+YB/qJLyeoH8ib1krJk7h4Zc5O
	BitaiG2W4CVJlC8dsggHxtw==
X-Received: by 2002:a17:90b:4b90:b0:27f:fc2f:4831 with SMTP id lr16-20020a17090b4b9000b0027ffc2f4831mr3808828pjb.13.1699848999534;
        Sun, 12 Nov 2023 20:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExSJF7Sr4fxZ4SaXBfj45m19uu6J8O0+tvnJdz59Xz+72h6hZwy5AtBFfiTF4Ru6jPNTRc+w==
X-Received: by 2002:a17:90b:4b90:b0:27f:fc2f:4831 with SMTP id lr16-20020a17090b4b9000b0027ffc2f4831mr3808799pjb.13.1699848999237;
        Sun, 12 Nov 2023 20:16:39 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id mg5-20020a17090b370500b00282ec3582f1sm2976159pjb.34.2023.11.12.20.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:16:38 -0800 (PST)
Message-ID: <fa717944-2f92-48f6-ad70-1c58ffe61b86@redhat.com>
Date: Mon, 13 Nov 2023 14:16:29 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 16/22] x86/topology: use weak version of
 arch_unregister_cpu()
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org,
 linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com,
 justin.he@arm.com, James Morse <james.morse@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JM0-00CTy7-NL@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JM0-00CTy7-NL@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 20:30, Russell King (Oracle) wrote:
> Since the x86 version of arch_unregister_cpu() is the same as the weak
> version, drop the x86 specific version.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v3:
>   * Adapt to removal of EXPORT_SYMBOL()s
> ---
>   arch/x86/kernel/topology.c | 5 -----
>   1 file changed, 5 deletions(-)
> 

PATCH[16/22] can be folded to PATCH[15/22] since arch_unregister_cpu() was just
added in PATCH[15/22]. Anyway, the changes make sense to me.

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
> index c2ed3145a93b..211863cb5b81 100644
> --- a/arch/x86/kernel/topology.c
> +++ b/arch/x86/kernel/topology.c
> @@ -43,9 +43,4 @@ int arch_register_cpu(int cpu)
>   	c->hotpluggable = cpu > 0;
>   	return register_cpu(c, cpu);
>   }
> -
> -void arch_unregister_cpu(int num)
> -{
> -	unregister_cpu(&per_cpu(cpu_devices, num));
> -}
>   #endif /* CONFIG_HOTPLUG_CPU */


