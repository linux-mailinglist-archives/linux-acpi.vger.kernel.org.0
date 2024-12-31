Return-Path: <linux-acpi+bounces-10334-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3EC9FED52
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Dec 2024 07:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7C41882D24
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Dec 2024 06:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C039A186E27;
	Tue, 31 Dec 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RfWE5B/p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A115573F;
	Tue, 31 Dec 2024 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735627496; cv=none; b=VlTKaxcpXTbU9LJWQ2OH7F1cp9udQ5wmuMO10vjRr+oJsuVfQgdudBWeaZKt5XLziIJaTfYGQOEsuzVqD4TxwgjDmau+Ntu+MKjE0jVPvkvc3Xye7mgDY0FOYLHvWFQoRaDjH6R75sw2Q/h1zzZTuMdPvE/a4IooiEv7zwjtSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735627496; c=relaxed/simple;
	bh=jQtjRw3H695UGgLf+HEUEAm3VjQE0wTFTk1Pn5M0sv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKIAe9KY9aFCZKYmLccDv86kbJPQUCxfcQkSWa8BBU3L5UwaeUtM9kN/arK+GiJxMVQhIdT1CMumWy44VEsXhY2vE5uQSNj4zEXQ3uzjTbrxZQ4GMPdXLxyghqc9lKbj4J41l9DW/i71N3m8kb4PG123aUGb+Ud3J2eugN2Z0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RfWE5B/p; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735627490; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=stFhbRNN4lVPS+Tz3jMwkWmrXR9TdWculPU425IqZBA=;
	b=RfWE5B/pQej2R7bUhQW14SzVzDckodmK6qzVRHfuzzrI8RbTKv8gf+B44Tum86kCwROkgEdxFe8TtTAzCB8VzbHMh/U17lIlDm3ZveaMJqQ2XhM2TDUFco8qjP6ySQcxHME6PBLHuB4fxyOPlKB3H2N1JLgf+gw7kP9uQomzSTQ=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WMd1icX_1735627489 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 31 Dec 2024 14:44:49 +0800
Date: Tue, 31 Dec 2024 14:44:48 +0800
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
Message-ID: <Z3OS4LCCxfVN32uH@U-2FWC9VHC-2323.local>
References: <20241227095422.44147-1-feng.tang@linux.alibaba.com>
 <1EA3C309-6508-489B-9F13-7659E8388A17@alien8.de>
 <87bjwtlnqb.fsf@DESKTOP-5N7EMDA>
 <20241230101658.GAZ3JzGhRjn7UtoJPt@fat_crate.local>
 <87wmfhjusk.fsf@DESKTOP-5N7EMDA>
 <20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>
 <Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>
 <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
 <Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local>
 <20241230132403.GEZ3Ke8zm7HxSv84pA@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241230132403.GEZ3Ke8zm7HxSv84pA@fat_crate.local>

On Mon, Dec 30, 2024 at 02:24:03PM +0100, Borislav Petkov wrote:
> On Mon, Dec 30, 2024 at 09:04:11PM +0800, Feng Tang wrote:
> > As per kernel config, most ARCH has 'panic_timeout' as 0 by default, so
> > need to set the kcmdline. For the case in my commit log, where user had
> > clear requirement for not-reboot and wait, the manually set 'panic=0'
> > should take priority here?
> 
> I think so.
> 
> I'm not convinced that lets-log-the-hw-error-faster should override the panic
> timeout setting but I'm open to real-life example scenarios...
> 

I see. Upon the discussion so far, how about the change below?

---
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 07789f0b59bc..113471b76d8d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -173,8 +173,6 @@ static struct gen_pool *ghes_estatus_pool;
 static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
-static int ghes_panic_timeout __read_mostly = 30;
-
 static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
 {
 	phys_addr_t paddr;
@@ -987,9 +985,10 @@ static void __ghes_panic(struct ghes *ghes,
 
 	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
 
-	/* reboot to log the error! */
-	if (!panic_timeout)
-		panic_timeout = ghes_panic_timeout;
+	/* If user hasn't specifically set panic timeout, reboot to log the error! */
+	if (!panic_timeout && !strstr(saved_command_line, "panic="))
+		panic_timeout = 30;
+
 	panic("Fatal hardware error!");
 }

Or we want to stick the orignal patch, which doesn't change the
original flow?

Thanks,
Feng

