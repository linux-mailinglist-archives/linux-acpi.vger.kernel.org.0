Return-Path: <linux-acpi+bounces-1436-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7CE7E9638
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 05:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3FE1B207A3
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 04:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2620D11700
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 04:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKTgeOFN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139588F4D
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 04:04:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA53172B
	for <linux-acpi@vger.kernel.org>; Sun, 12 Nov 2023 20:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699848284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tws2IAPG/pAuM74CEbXNr6MwlBLqAXS5OKA1cYLHSOM=;
	b=gKTgeOFNfraf444v85mYjNzi6usPb90nRId2v1OdGnZhfCmRiadIWTYlI894C7gqd0J1zS
	teEpXc0U8t5amj8Z/k5ED1COKpf/UFw+7+I9j35gz4SdxpR8hDfVTg8cvMkni7Api6Vypx
	UVSY5Mi6cdpeilcd54jQzw95nT6floc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-6zBl6L8tNXiDRMNhhJZoWQ-1; Sun, 12 Nov 2023 23:04:42 -0500
X-MC-Unique: 6zBl6L8tNXiDRMNhhJZoWQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc482cc026so54412345ad.2
        for <linux-acpi@vger.kernel.org>; Sun, 12 Nov 2023 20:04:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848281; x=1700453081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tws2IAPG/pAuM74CEbXNr6MwlBLqAXS5OKA1cYLHSOM=;
        b=oEvhCrpFyF35llF39iqCcMK7En2TOk63hazeb3DPsA5R2PsSSafa2pfd/znKrJic2V
         dxJ6yhftS0BUsh/8ch89XvgT1S2IkMMqdoS3lRFU5eSoVKqHGHn8n3GrXFqds2cY1IZP
         65DjO5N3aPvcm5Uirgdn8Xh5cBxTrF80jKpZm0i8qJLw1Ihz+I7dgQO52vmYXnpmfZ5t
         SDilIUBD2c19ulPzs5o6aEr6c5RkzF/Pc7U/6vVzGq9jNEoV89/r8MuOYKG8AdE5EYyc
         TZVFG+d+4P8ESK0b5651nTzUHVqMRlyE/yvW4utWbWYGJISZrXm2uYpe+WwKE62fUap6
         tNxg==
X-Gm-Message-State: AOJu0Yydo7lfcM/v+bKVQKSuMHZ8/rZkm4S6ISJmEMkNeVKsQSruJcSa
	4/a7oCmn4JBkpReUDblPIR/blf5wIhTc8btzGAPXyVN3T5v8IG+Kn0llcIl9SnO/b4Z+HPF/6ad
	XsnkdBpSFI6rRp4CkjhLUPg==
X-Received: by 2002:a17:902:c40d:b0:1b0:f8:9b2d with SMTP id k13-20020a170902c40d00b001b000f89b2dmr6898999plk.29.1699848281707;
        Sun, 12 Nov 2023 20:04:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYR2VwJDEptBEIbrqjgd8Zx/CSzLVMmBQUVzyl+4ab4Yq5iFKzjqaERsoMDmohw8xGXwqYvw==
X-Received: by 2002:a17:902:c40d:b0:1b0:f8:9b2d with SMTP id k13-20020a170902c40d00b001b000f89b2dmr6898988plk.29.1699848281368;
        Sun, 12 Nov 2023 20:04:41 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902eb4600b001c61073b076sm3230467pli.144.2023.11.12.20.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:04:41 -0800 (PST)
Message-ID: <955f2b95-76e4-4e68-830b-e6dd9f122dc1@redhat.com>
Date: Mon, 13 Nov 2023 14:04:32 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 11/22] drivers: base: remove unnecessary call to
 register_cpu_under_node()
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
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLa-00CTxY-Uv@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JLa-00CTxY-Uv@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 20:30, Russell King (Oracle) wrote:
> Since "drivers: base: Move cpu_dev_init() after node_dev_init()", we
> can remove some redundant code.
> 
> node_dev_init() will walk through the nodes calling register_one_node()
> on each. This will trickle down to __register_one_node() which walks
> all present CPUs, calling register_cpu_under_node() on each.
> 
> register_cpu_under_node() will call get_cpu_device(cpu) for each, which
> will return NULL until the CPU is registered using register_cpu(). This
> now happens _after_ node_dev_init().
> 
> Therefore, calling register_cpu_under_node() from __register_one_node()
> becomes a no-op, and can be removed.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   drivers/base/node.c | 7 -------
>   1 file changed, 7 deletions(-)
> 

__register_one_node() can be called in memory hot add path either. In that path,
a new NUMA node can be presented and becomes online. Does this become a problem
after the logic of associating CPU with newly added NUMA node?

Thanks,
Gavin

> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 493d533f8375..4d5ac7cf8757 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -867,7 +867,6 @@ void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
>   int __register_one_node(int nid)
>   {
>   	int error;
> -	int cpu;
>   
>   	node_devices[nid] = kzalloc(sizeof(struct node), GFP_KERNEL);
>   	if (!node_devices[nid])
> @@ -875,12 +874,6 @@ int __register_one_node(int nid)
>   
>   	error = register_node(node_devices[nid], nid);
>   
> -	/* link cpu under this node */
> -	for_each_present_cpu(cpu) {
> -		if (cpu_to_node(cpu) == nid)
> -			register_cpu_under_node(cpu, nid);
> -	}
> -
>   	INIT_LIST_HEAD(&node_devices[nid]->access_list);
>   	node_init_caches(nid);
>   


