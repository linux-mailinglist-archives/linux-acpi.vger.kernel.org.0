Return-Path: <linux-acpi+bounces-9241-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9A29B94C1
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 16:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386441C20C68
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D761C760A;
	Fri,  1 Nov 2024 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Oc2g9E3M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278E145A17;
	Fri,  1 Nov 2024 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730476350; cv=none; b=iDOE/rBTD6LOIIj8ParX3uBoDD5THL1omPdMq7CqPyhVO2iIrzIuKsDxIo80RLTmNmqdBBtGHMANn3Ko+sF3daODXExEJAituDmCUmexBNHPgZcFOYcOTsP6hzpDHpEY2N6H1bf/4BalLoTJPmRKloJF5w9yANqJsbNA+4fOxtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730476350; c=relaxed/simple;
	bh=y4hE1i+zJgISRor76aWZTr4ShGcYLYZiuG/FdfSlpAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5e5Nw5bugA02xx8gnA6oISnpgMOiSctkHxz7qkLiDZVINCs0g+DnxhH53Bq4g+JpwbByE5oGXvgGJzjtL8wRH4yzTwvsTF0hzXjqE7JBv2MXIYuerSmquq0PVwOROqA8CwVs7UYPMOtE1dPUzzmMJ7WRDgM3AgUxPw63uEII+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Oc2g9E3M; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 15D6140E0184;
	Fri,  1 Nov 2024 15:52:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QRbgms-A4_gD; Fri,  1 Nov 2024 15:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730476339; bh=ot+cpDN3KZgTcegLKYz3Z1iXBLYw+MQdN5T6/AjXwXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oc2g9E3M8kggscgtwga/u7mKVKyp3j5DXTEeBiGdybq88oRgLh47GNEAW1umFyZ/y
	 pkdPEEQHR+4RrWcmE3S/+YND4dl43ugQBWaT0TjwGVV7GXzwGV8cQSrnOvqL65BqrJ
	 IuVY850Yi73qoUJjiIPTALT+/hcwD3RCc8D7JBouOSMLBWhpuKk3EdRA/ucH+xCj1L
	 ZgMsNyzXGRMgd95pmNQ5kNJvnSZiGx3o7lO+aIyfU9dp0OqbGGX5gh5UuCTCeaNir1
	 HAt04kbIySSpPTp+QglDlfiCHjx7/1s+MOX4Lfj3t806S7zKRAb0tgF3G3bN5OfmSx
	 96T227O2ky0AAENgtZ5pfJYu/zUZvnwj3rjlmVJF+gw2EW9n0CuBtD41sqV4CTkcud
	 J/4L9nTUFFOrvRn9ww9kqsPrROnlEtoF707eWz1RXoWfwzuhSwRUqS4uDT5+G2HC8n
	 RVA8l3+cvFr2R/TZC6d6jMiz29oH/fu5Q3IEWK1BrQG3tPuUeMpdjbqfJGRPRUCrj4
	 0BjV8v2Z8ja2UOCmGW77iqmz/nGsP8XImtoowihAbNwUmpXXcg5sS9FdmX8jkKLxIM
	 yC4SiP/C+YLk/4ljVjcdrpgRoX0CgxKX6h/e9eLdydJBU6meg1IEPG/QGzvnSxxCpc
	 7HrPxIP8Lx0/0aDS1wtv5ld4=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53D4140E015F;
	Fri,  1 Nov 2024 15:51:53 +0000 (UTC)
Date: Fri, 1 Nov 2024 16:51:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Gregory Price <gourry@gourry.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
	david@redhat.com, osalvador@suse.de, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, rppt@kernel.org
Subject: Re: [PATCH v5 2/3] x86: probe memory block size advisement value
 during mm init
Message-ID: <20241101155147.GBZyT5E190IxnQMzaP@fat_crate.local>
References: <20241101134706.1185-1-gourry@gourry.net>
 <20241101134706.1185-3-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101134706.1185-3-gourry@gourry.net>

On Fri, Nov 01, 2024 at 09:47:04AM -0400, Gregory Price wrote:
> Systems with hotplug may provide an advisement value on what the
> memblock size should be.  Probe this value when the rest of the
> configuration values are considered.
> 
> The new heuristic is as follows
> 
> 1) set_memory_block_size_order value if already set (cmdline param)
> 2) minimum block size if memory is less than large block limit
> 3) if no hotplug advice: Max block size if system is bare-metal,
>    otherwise use end of memory alignment.
> 4) if hotplug advice: lesser of advice and end of memory alignment.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/x86/mm/init_64.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index ff253648706f..f1a495e998ce 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1452,16 +1452,21 @@ static unsigned long probe_memory_block_size(void)
>  	}
>  
>  	/*
> -	 * Use max block size to minimize overhead on bare metal, where
> -	 * alignment for memory hotplug isn't a concern.
> +	 * When hotplug alignment is not a concern, maximize blocksize
> +	 * to minimize overhead. Otherwise, align to the lesser of advice
> +	 * alignment and end of memory alignment.
>  	 */
> -	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> +	bz = memory_block_advised_max_size();
> +	if (!bz) {
>  		bz = MAX_BLOCK_SIZE;
> -		goto done;
> +		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))

s/boot_cpu_has/cpu_feature_enabled/

while at it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

