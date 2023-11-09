Return-Path: <linux-acpi+bounces-1386-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5700B7E6AB1
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 13:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDF2280FB7
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2AA1DDC5
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMokZfVx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7D63B8
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 10:51:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93272702
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 02:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699527114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzXmFfn5zVQ8O2djRIzf4P/RBzxnLFE/MCnf13XN7x8=;
	b=BMokZfVxwLfSamvGK17HmKIHP+NAyAWAUiEi3VDiBXnUZMOtlekbjmxgYhO6AMsUN70XPr
	zNuK0ZSKc+zwMdNhSOSiBeRolZQS3vS3rBs0BSp+84tYO+64gmGoi5YgO4T2iRGmgy9D1Y
	pg5zFYcvQ2kj1zruKkykVi9XN8MwtrI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-pO0qKuDYN_CUV71yO3Ojjg-1; Thu, 09 Nov 2023 05:51:53 -0500
X-MC-Unique: pO0qKuDYN_CUV71yO3Ojjg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc47716c4eso1134915ad.0
        for <linux-acpi@vger.kernel.org>; Thu, 09 Nov 2023 02:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699527112; x=1700131912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzXmFfn5zVQ8O2djRIzf4P/RBzxnLFE/MCnf13XN7x8=;
        b=rHsTwof/hjO5QXZov0U6qlBf2FWpdAi80yT4dvbjUTrkh73je3zscmHCg7wgqJRPs9
         GVSE7xbLIhfsiPgVIcFgY49fq0TJA980vhbpWmvDBsVj+VtARw49JQe8xTPTdDtuGMzM
         v7NZll5cHMQt7PoOl63ntNPLsaSvNZ9hayVPDcJkDTE6gg4/9vAXixr15fieUa8rrsPL
         j5x1RQv7G1Cc+XiivyZBjvW8inlM7AgTB1bA/0KYTgBOei/d6O0IskMNa339cVqmgJJf
         xhAfZNAXgjdDpaaob3IlcPQ6rbQlW7W80P6chK9GHFT0zbMnAyYdu+fnqHnRLlGQPJwO
         5zLQ==
X-Gm-Message-State: AOJu0YzNw9PJiN795YBjtaUnHpIKEsX2EJwqzZ5MsZDILEDgkKZB97N8
	OiNRtOgpI0uFQ6KFH7XoGPEFEXheOnyTVDb6Q2jtYRRxjTIkqjlOceRdPGGN3DOPSy+0uWT+Fd7
	Jle3ehAZh+K9DA1qse9YHPQ==
X-Received: by 2002:a17:902:e5c7:b0:1cc:27fa:1fb7 with SMTP id u7-20020a170902e5c700b001cc27fa1fb7mr4861868plf.5.1699527112435;
        Thu, 09 Nov 2023 02:51:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiDKE4c0Ju3XEU4qcUzBfLHE4odbtCyEmKR/OFqWPBbcxkvIL/TmgSbJ2a8W59JHM952t4Zg==
X-Received: by 2002:a17:902:e5c7:b0:1cc:27fa:1fb7 with SMTP id u7-20020a170902e5c700b001cc27fa1fb7mr4861848plf.5.1699527112117;
        Thu, 09 Nov 2023 02:51:52 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902ed4c00b001b86dd825e7sm3245836plb.108.2023.11.09.02.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 02:51:51 -0800 (PST)
Message-ID: <17dd2b32-079a-101e-e5c1-0166d6dea3b9@redhat.com>
Date: Thu, 9 Nov 2023 18:51:44 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 08/22] drivers: base: Implement weak
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLL-00CTxD-Gc@rmk-PC.armlinux.org.uk>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <E1r0JLL-00CTxD-Gc@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/7/23 18:29, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add arch_unregister_cpu() to allow the ACPI machinery to call
> unregister_cpu(). This is enough for arm64, riscv and loongarch, but
> needs to be overridden by x86 and ia64 who need to do more work.
> 
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
> Changes since v1:
>   * Added CONFIG_HOTPLUG_CPU ifdeffery around unregister_cpu
> Changes since RFC v2:
>   * Move earlier in the series
> ---
>   drivers/base/cpu.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 579064fda97b..58bb86091b34 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -531,7 +531,14 @@ int __weak arch_register_cpu(int cpu)
>   {
>   	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
>   }
> -#endif
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +void __weak arch_unregister_cpu(int num)
> +{
> +	unregister_cpu(&per_cpu(cpu_devices, num));
> +}
> +#endif /* CONFIG_HOTPLUG_CPU */
> +#endif /* CONFIG_GENERIC_CPU_DEVICES */
>   
>   static void __init cpu_dev_register_generic(void)
>   {

-- 
Shaoqin


