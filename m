Return-Path: <linux-acpi+bounces-10447-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4112A0782D
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 14:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFB43A9803
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD971218AC3;
	Thu,  9 Jan 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WLHIrDkX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8421859D;
	Thu,  9 Jan 2025 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430491; cv=none; b=UneBO7Q5cMQ/gpfiDyQzNkrakTOJ5sm+7DQU0Dl7KDgb5TLA8Thamlv05FlxLvq/flbzoXM1JMPCwc68KCgr6Rh0CYqFa3lZ/lHaOb9vvtt6ZTK1kxZj6qWgVyDlHJb0xN9hGoVqIJQxjw5hMynEPVIJibIA2SeabBOvSp6yKZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430491; c=relaxed/simple;
	bh=+ONi6QhbyXumKTcpx/BwKZwWaJ109HRIzVb5L1of6+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQBYeUfX7G1brpk8Eo7Fvu7n8/6JY1Kdtdp+dWRxaH+zxkQr5hp6sXNx7dJTdIpMgaiWhtldjEIIeMm9Bk0ZRz7KlnL06Joq/aY+lxv06CnNnkByb3DhAD0kXrddHmBWm5hBWU8GTUFccLonpXz3YbelAZdJwJOEOeR5NDJIS8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WLHIrDkX; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736430479; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Mq+DduKybPpPalKjvqW6lg6riTbk0wY8BtEW8iTwMPs=;
	b=WLHIrDkXomJoGCcPsJtAUsej93jdyvOWQdkejPb29zuMhegFUqtD6ygKQXjzehbtllgKiW/pGtY7MQG/6IbR0JN4OSz4U3LXT8ONkX+QHXcUurBLwIgDEy9sHn4lFXhXtEUycMd+28FMajaFjBa1XG/ZqOEHCWH0mZE8/TD1pgk=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WNHnawK_1736430477 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Jan 2025 21:47:58 +0800
Date: Thu, 9 Jan 2025 21:47:57 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>, rafael@kernel.org,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] acpi/ghes: Make ghes_panic_timeout adjustable as a
 parameter
Message-ID: <Z3_TjYzeQVIZirpK@U-2FWC9VHC-2323.local>
References: <87wmfhjusk.fsf@DESKTOP-5N7EMDA>
 <20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>
 <Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>
 <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
 <Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local>
 <20241230132403.GEZ3Ke8zm7HxSv84pA@fat_crate.local>
 <Z3OS4LCCxfVN32uH@U-2FWC9VHC-2323.local>
 <20241231092358.GAZ3O4LroNtlnztneC@fat_crate.local>
 <Z3PEXxFTGXW2j2F3@U-2FWC9VHC-2323.local>
 <20241231111314.GDZ3PRyq_tiU002p5d@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241231111314.GDZ3PRyq_tiU002p5d@fat_crate.local>

On Tue, Dec 31, 2024 at 12:13:14PM +0100, Borislav Petkov wrote:
[...] 
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Tue, 31 Dec 2024 12:03:55 +0100
> Subject: [PATCH] APEI: GHES: Have GHES honor the panic= setting
> 
> The GHES driver overrides the panic= setting by rebooting the system
> after a fatal hw error has been reported. The intent being that such an
> error would be hopefully written out faster on non-volatile storage for
> later inspection.
> 
> However, this is not optimal when a hard-to-debug issue requires long
> time to reproduce and when that happens, the box will get rebooted after
> 30 seconds and thus destroy the whole hw context of when the error
> happened.
> 
> So rip out the default GHES panic timeout and honor the global one.
> 
> In the panic disabled (panic=0) case, the error will still be logged to
> dmesg for later inspection and if panic after a hw error is really
> required, then that can be controlled the usual way - use panic= on the
> cmdline or set it in the kernel .config's CONFIG_PANIC_TIMEOUT.

Also, is it worth including this patch into stable tree?

Thanks,
Feng
> 
> Reported-by: Feng Tang <feng.tang@linux.alibaba.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  drivers/acpi/apei/ghes.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

