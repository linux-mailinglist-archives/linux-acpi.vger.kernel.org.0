Return-Path: <linux-acpi+bounces-13763-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1314ABA82F
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 06:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC85A05176
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 04:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAEC18B47D;
	Sat, 17 May 2025 04:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="I9l7lrd9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA56175A5;
	Sat, 17 May 2025 04:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747457006; cv=none; b=EJJUr/V17pmCn0HXmJN9mSb1gzwp9XXFRqTQgVuJ1hEVLPffGGqFKTDSs/x7Dj2Xo9Vaiw3w5yfISDVh68m8PwL7A/TDA/aayXHnjHD5iBdjwex5k5jgqu1538N7F/4Up5G3UG0SkoWS/VXnVP/k9QZSwkMr1n2v+i2WycAD3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747457006; c=relaxed/simple;
	bh=Db7qwrXeHja/9TUaPkm0iJPW8zTvyXnfMTPLAx80Sto=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jb7bEMessDY9/gTT7ETQUztTpMJlGHlJIRuvG4L/gIDyB0yPYfhAqECvuaVI6AbLw3QWpzbeW1XKCCGSHoPU42iNcYXkDPDYrdgxlOG3oqs8VYud6rYSM8kZMwWj8HW6htN/FB0ky1rgV2rOuNn/8jw/KThVHiR/+VPpnQoj2wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=I9l7lrd9; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54H4ggxL509076
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 16 May 2025 21:42:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54H4ggxL509076
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747456965;
	bh=ev5wOQfgz6bQFC1LEpzjYx5uyZaaYgjmzOQTSOQC6w8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=I9l7lrd9KpAOVvMoL8timZ4/9ZwbcewJp0cSTFePoDsLLFy4C/db/ARW/U+xSnNSh
	 FHnm3VPe4fh+weL2KMTe5ssJGY7SIq3GjsBWsJU90wOV5V311/T2Hrnn3+ULXBt6bE
	 wAtmfqdH5vll+dgbLvAeOmYpMZiLutzmTsQo7z/HWvc85+NNHeFnwXM6h2LQXqride
	 eq6Ah0TXEfl5PAYGEdy3+jECn6RAJjk2XvhLhWZ3eVrEEX/dctqNJO/Bet7dEnCS8Q
	 dzougJiqoghoU2XqffUwlFCGa88HvdIZ5GPhLgGIZGVe3/pLicB2bGgg4npA1mGyEl
	 i0py6AVeH+DYQ==
Message-ID: <b8f741d6-47a1-4cc8-a5b2-45ee86fcb773@zytor.com>
Date: Fri, 16 May 2025 21:42:42 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] x86/msr: Convert a native_wrmsr() use to
 native_wrmsrq()
From: Xin Li <xin@zytor.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        rafael@kernel.org, lenb@kernel.org
References: <20250512084552.1586883-1-xin@zytor.com>
 <20250512084552.1586883-4-xin@zytor.com> <aCYH0UQzO_Ek27js@gmail.com>
 <68dba45c-a677-4f6d-b7ec-e896aef3d27b@zytor.com>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <68dba45c-a677-4f6d-b7ec-e896aef3d27b@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/15/2025 10:54 AM, Xin Li wrote:
> On 5/15/2025 8:27 AM, Ingo Molnar wrote:
>>
>> * Xin Li (Intel) <xin@zytor.com> wrote:
>>
>>> Convert a native_wrmsr() use to native_wrmsrq() to zap meaningless type
>>> conversions when a u64 MSR value is splitted into two u32.
>>>
>>
>> BTW., at this point we should probably just replace
>> sev_es_wr_ghcb_msr() calls with direct calls to:
>>
>>     native_wrmsrq(MSR_AMD64_SEV_ES_GHCB, ...);
>>
>> as sev_es_wr_ghcb_msr() is now basically an open-coded native_wrmsrq().
>>
> 
> I thought about it, however it looks to me that current code prefers not
> to spread MSR_AMD64_SEV_ES_GHCB in 17 callsites.  And anyway it's a 
> __always_inline function.
> 
> But as you have asked, I will make the change unless someone objects.

Hi Ingo,

I took a further look and found that we can't simply replace
sev_es_wr_ghcb_msr() with native_wrmsrq(MSR_AMD64_SEV_ES_GHCB, ...).

There are two sev_es_wr_ghcb_msr() definitions.  One is defined in
arch/x86/boot/compressed/sev.h and it references boot_wrmsr() defined in
arch/x86/boot/msr.h to do MSR write.

The other one is defined in arch/x86/include/asm/sev-internal.h, which
uses native_wrmsrq() from arch/x86/include/asm/msr.h to write MSR.

Because:
1) arch/x86/boot/startup/sev-shared.c is included in both
         arch/x86/boot/compressed/sev.c
    and
         arch/x86/boot/startup/sev-startup.c

2) arch/x86/boot/startup/sev-shared.c has several references to
    sev_es_wr_ghcb_msr(),

sev_es_wr_ghcb_msr() is converted to boot_wrmsr() when included in
arch/x86/boot/compressed/sev.c or native_wrmsrq() when included in
arch/x86/boot/startup/sev-startup.c.

It would change the compressed code to use native_wrmsrq() if we remove
sev_es_wr_ghcb_msr() from arch/x86/include/asm/sev-internal.h and use 
native_wrmsrq() directly in the startup code.

We probably should get rid of boot_wrmsr() and use native_wrmsrq() in
the compressed code because they are indeed the same thing.  But as we
are so close to the v6.16 merge window, I don't think it's a good idea
to make the change right now.

So maybe I should just drop this patch and we can do the job after the 
coming merge window.

But if you think it's not a bad idea to replace native_wrmsr() with
native_wrmsrq() right now, I can keep this original patch.

Thanks!
     Xin






