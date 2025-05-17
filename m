Return-Path: <linux-acpi+bounces-13765-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0F9ABA8AB
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 09:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340B79E6695
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 07:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA581B4121;
	Sat, 17 May 2025 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JfigqQZ5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9452B9B4;
	Sat, 17 May 2025 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747466842; cv=none; b=sbfKcwVcNCjVp5Kqd8RIFvv5JU8pGKVKF+EdWYcbFON1nm6tWvBZQ0SHQG+nGyTOyTQP91V6tvJfFmws9tFMBsfvMsZ1WIPL2pqSklbi4wHbVVrlFuf7HmP0m4P19cFQylnkR8j454YUCkkqhF74t/Q/k/Y+f1xMqMMZn30xYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747466842; c=relaxed/simple;
	bh=20NmFlWcellGqNfz3xrsNWTznkSLmvSOR6YstuK9F+c=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=pitTqJFGLFm0sZ0zlBpdf4F8rhkaaS1SJX6XQtjsrnDS+TXVfQRKINbOSE68K6bxgymMKBXQzsxm0SD7UKRj1p6J4BRtw/9si/H4OeFBg7XA8ntfJp/zDpxM85WZeQhnL7E+phdn/urhnM8/1QZ3LAkwEuaMuVcAwBhunlcjkdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=JfigqQZ5; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from smtpclient.apple ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54H7QhLm591490
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 17 May 2025 00:26:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54H7QhLm591490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747466805;
	bh=CZtkP3WrpMIGbhySH/khDRYEg3tCdemTLMORia2zrho=;
	h=From:Subject:Date:References:Cc:In-Reply-To:To:From;
	b=JfigqQZ5Lh/TeQEqqyQKd8QM/ozskiXWWzhEwAaEP/NSDAXzGTuveYCYLruvOh24f
	 Rx6isU+2S9BV3OGP1yK3L2fuZj8zKu0SI6I+SJrNAW4ow77BAKijsLpIBQfeaq7Tgo
	 JebNnI7RC7C0XefauAe3O64YSAbfJmCq8Zvw+ZekHJDAsaFoFJhNnKX89u+GKXJ5xy
	 HTDU4z0X5rSsRI/k1lX6GojOxbeWx3oFn/1nwGYgKkIh5EPikQePMIsnv0vT75sMwn
	 RbykR0FK5XFvenmDV6tfJnOVKc5dzk3SrKNq3P4mImuX8O75ABonq4k35ChRoQGXTJ
	 x5kuQ40RpC+rA==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Xin Li <xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 3/3] x86/msr: Convert a native_wrmsr() use to native_wrmsrq()
Date: Sat, 17 May 2025 00:26:32 -0700
Message-Id: <EAEB5A61-F19B-481C-B6F0-49B3D509B70A@zytor.com>
References: <aCg27zLhBM5d0dAI@gmail.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        rafael@kernel.org, lenb@kernel.org
In-Reply-To: <aCg27zLhBM5d0dAI@gmail.com>
To: Molnar Ingo <mingo@kernel.org>
X-Mailer: iPhone Mail (22F76)


>>> On 5/15/2025 10:54 AM, Xin Li wrote:
>>> On 5/15/2025 8:27 AM, Ingo Molnar wrote:
>>>> 
>>>> * Xin Li (Intel) <xin@zytor.com> wrote:
>>>> 
>>>>> Convert a native_wrmsr() use to native_wrmsrq() to zap meaningless type
>>>>> conversions when a u64 MSR value is splitted into two u32.
>>>>> 
>>>> 
>>>> BTW., at this point we should probably just replace
>>>> sev_es_wr_ghcb_msr() calls with direct calls to:
>>>> 
>>>>     native_wrmsrq(MSR_AMD64_SEV_ES_GHCB, ...);
>>>> 
>>>> as sev_es_wr_ghcb_msr() is now basically an open-coded native_wrmsrq().
>>>> 
>>> 
>>> I thought about it, however it looks to me that current code prefers not
>>> to spread MSR_AMD64_SEV_ES_GHCB in 17 callsites.  And anyway it's a
>>> __always_inline function.
>>> 
>>> But as you have asked, I will make the change unless someone objects.
>> 
>> Hi Ingo,
>> 
>> I took a further look and found that we can't simply replace
>> sev_es_wr_ghcb_msr() with native_wrmsrq(MSR_AMD64_SEV_ES_GHCB, ...).
>> 
>> There are two sev_es_wr_ghcb_msr() definitions.  One is defined in
>> arch/x86/boot/compressed/sev.h and it references boot_wrmsr() defined in
>> arch/x86/boot/msr.h to do MSR write.
> 
> Ah, indeed, it's also a startup code wrapper, which wrmsrq() doesn't
> have at the moment. Fair enough.

So you want me to drop this patch then?

Thanks!
    Xin

