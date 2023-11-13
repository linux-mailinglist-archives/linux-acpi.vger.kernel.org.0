Return-Path: <linux-acpi+bounces-1441-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 758AF7E963D
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 05:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 065CAB20A7C
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 04:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E4D1A587
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 04:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1K1WA2C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C08C8EA
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 04:18:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8AF1729
	for <linux-acpi@vger.kernel.org>; Sun, 12 Nov 2023 20:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699849128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h62ZSBXNIpXAn1RjkyzytMnuk1I7FWNselF1cBuUf4A=;
	b=Q1K1WA2CDS+w0P67pzrdq2laEd8TALwxUOfYbuJ22jz7ZzbPMoqy3BVpL4nywomnLfPbN5
	eLa4WYvRcpRMffL+AADrMwEw8kvER0APq0x12eN3/h7NyI6WUFLGoRD9DJUmzsN55bG48Q
	dYvhbygfDPZoNapd+i43DbKpj8XWU5c=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-w_4Sd4laNfqXVhr48bDztw-1; Sun, 12 Nov 2023 23:18:46 -0500
X-MC-Unique: w_4Sd4laNfqXVhr48bDztw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5b79f5923b2so5033269a12.2
        for <linux-acpi@vger.kernel.org>; Sun, 12 Nov 2023 20:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699849125; x=1700453925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h62ZSBXNIpXAn1RjkyzytMnuk1I7FWNselF1cBuUf4A=;
        b=hBYM2CCuhup0AbVcI9rdADyMstvLXp2S3gxj7EpJvR5kVoBq+9laA5SLcdTAHtHF1Q
         krvEBM7vAfUy+mWYyuphjJ9mQHJkwoBJUriV00nqITwEwnUBE9VAyZREdPHTCNLRhK+B
         ijtDP1c3TQkx1om42zMQ+X/sS69rsjrtNopKH7sIHK1EUWfaPcqgHyBzE+3wU6OGoRdb
         /txuPUdXmOabkLutWrZ6DUIBebjiT9jpOMpBS4U0USLgZsi+aGF/RHMqdo0oL9wo7/JD
         bVRbJZxweJ+mVuq2nk8uW386KyaGBYqCWXWQA9NxEwbvNWChEDNPMXKq3a96IFa5iLSI
         uIoQ==
X-Gm-Message-State: AOJu0Yy3C8f5DboU5W/7urxqXfZQAHBuxi/w5N1lj0O6mqF8vx6btjug
	5g+1qRP826B8ccs9097NwNdV1bLsmcBq2Y8Lst7MesjGJpEUq1xSGvGX73zTpvOERnGl1T6CI/J
	1hviOUUAj0+INiEnvYM3QjA==
X-Received: by 2002:a05:6a20:42a4:b0:186:4def:ccc9 with SMTP id o36-20020a056a2042a400b001864defccc9mr3622165pzj.10.1699849125606;
        Sun, 12 Nov 2023 20:18:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFobxPewEpgXbDDZKt4dnfeBouA3YHhqrzoLtSI/jkAmOjDXYCHvtcrl7wlb5s/tPAkxp4efQ==
X-Received: by 2002:a05:6a20:42a4:b0:186:4def:ccc9 with SMTP id o36-20020a056a2042a400b001864defccc9mr3622141pzj.10.1699849125345;
        Sun, 12 Nov 2023 20:18:45 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id n24-20020a170902969800b001cc50146b43sm3198590plp.202.2023.11.12.20.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:18:45 -0800 (PST)
Message-ID: <b6f833a5-49be-4bd9-b31e-143e2fbec2ca@redhat.com>
Date: Mon, 13 Nov 2023 14:18:35 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 17/22] x86/topology: convert to use
 arch_cpu_is_hotpluggable()
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
 <E1r0JM5-00CTyD-Ri@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JM5-00CTyD-Ri@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 20:30, Russell King (Oracle) wrote:
> Convert x86 to use the arch_cpu_is_hotpluggable() helper rather than
> arch_register_cpu().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   arch/x86/kernel/topology.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>


