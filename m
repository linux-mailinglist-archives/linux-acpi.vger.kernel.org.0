Return-Path: <linux-acpi+bounces-21396-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHx2DSM7qWkd3QAAu9opvQ
	(envelope-from <linux-acpi+bounces-21396-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 09:13:23 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 940FF20D434
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 09:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D78443020D4B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 08:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EE136681F;
	Thu,  5 Mar 2026 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="edi1eKcp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D3829A1
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772698287; cv=none; b=f0V9cdRJUvP7bBaaYWc/i5ZmBF9nTCO2R6hmIbVF3P2bDvo1MUsEYiLej68ssV29JpN7u1UaMTZNpljutUODKB4mPHrx7Iowx6JMKTjiwllnra8e6gWbGeEweLCAgMnzjO1UWQRy8Mb7LgL5WUGli94oQz7z3lFY0BGSEhMvnB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772698287; c=relaxed/simple;
	bh=7lNeI4Q9Uja+/KQLyBu/MSPEZ+msyNAKfW3xJ2P/m4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubh2c69SyANwjj8l5nxh8bWhusBK54X4u2i6HynwTLMPKJOwtoLwknWo9Jnuwqp+6HzRSV/BDxXj4/U4Absr7K25L3Lak8M1YLNh0U4qa9KdEskgTapGr3PrIrjzavTjkkI7qCivM/MiCR9kIZD5ZrSeT0rHx4NQEcKeUX0qhT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=edi1eKcp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c2af7d09533so4745432a12.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 00:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1772698285; x=1773303085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBOWB+m079XaZQjYmCEPY71XRCZ9lZ345P6YQe50dwY=;
        b=edi1eKcpJNR7cnVSD/0cZ4K7bJDzXYCaU5Jjkux+fDXU2OgFN4EdmN+JTaCdhN7KMX
         pF5tsxm313RFrmihUXtK3yDIaRJ/5UfFcVqpatqPyLXf7VN3sU8MKXBsDO1U/kc0egM3
         65NagpOq3yyicf+MGcq6ZFMHPzaADn+v0eLzZ83LUlx9d5pehriTmq95TBXk3GmUislG
         mzpkMVKhx+eh+QlIww/bLFklRjprlbrEqAfW40ODl/7cESonAowbx0KEWSFz9MuMyYX7
         XF9TBCa3JAkhWLetWL1Fz/v0mQVFHu3zKKXOCZ9a4H+6Wko8mthkUiwfeVc4zKSJUSbT
         6XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772698285; x=1773303085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBOWB+m079XaZQjYmCEPY71XRCZ9lZ345P6YQe50dwY=;
        b=aGRIhdRoQahxLDh/dvmqJ8qno3WtqDhLl0OVcnikvCerc7pmPTInhY4z7pURcIBmFF
         /Cn8GaHIVJROE1ufD+yvxxaBSHdi5JPwnvygZRIXThRVoV2XSj3rc/hn6BKHDTqTAcrB
         KlEBs/ciKinz3XEyBnuxyJbtAHZnflpgC/3BaxSppqWd5+pbtwSmYkQG7cYu4LX5duQ4
         IIgEoMpRK3JWKebgEf2YD7FGfudii1wSRw5AttSQIZm652evp/jP26GZFUlJ3Ik3HC/a
         KRPib04Mf0Yw65CTNZw8dQlLF4ytSnNsqlBs32xybcuOKm4DO3jfMKT8QgFe6mkpw3/Z
         3PhA==
X-Forwarded-Encrypted: i=1; AJvYcCW4QGwjOxxqTjdKeaNhKZOtqEGssJwuL3HeLkSSEamIx6gr4w13bQPF1Gy818odiPX8r0L6qbL850fx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0Bz7+e62l5d3T9V5QBqSVfl3NEbO4G9c0tyDk22XL5PTzM6z
	H6+T3nlavVK1mgDrhhbtUJeaJWAIErVTnfQ+2fZfKEyE0g9yBDGF4Zo+wk0hO7/jr/A=
X-Gm-Gg: ATEYQzxmEFm/L6rG0CxiwQDITH1WiqDzdnJInYc+NWflT6DR8YiREst9TgA9Yhi7Kgc
	QwzcLAoMFuTpEshl6FPuqEw0okaWTvQeKCFRGy5op4bnnaiqOvdq4PXckdhlLfO2mjasUYwrE4A
	gQ2RrtqDhmfEwCTRTjTuBVUpzD5JtnC+vT3pR+sAPBUpCHJLtmzfJJx/SGfaERI5dvwsqLsDnub
	8EjjT1055Dmu6Tf3BRzWx21N+Se3pKKAyIwqjWn3J2B1XfB5OqDwu7vkzPZndODw0rukPzM72EB
	oHc0U46ek9bh45p4Uwg5SoatT3Ivxg4DKGxtBlr+eWpnzJ0ceJYbhrJ3u7jGR9XWd2QT/wW/4Pr
	tnCnmu/GRuMH1op3P7Rd55PXQ7iTAAJAHuIKjx6eF+BfRUhi88hoO/BxN6EaD5RQ/oiirBOtlLh
	v8PnjydqbJtn6b7qhlT//M1J0Q5Vezxm7tmboxCT0K3YuNyr4=
X-Received: by 2002:a17:902:d4cc:b0:2ae:4ad5:b76a with SMTP id d9443c01a7336-2ae6aa157c6mr46505265ad.21.1772698285431;
        Thu, 05 Mar 2026 00:11:25 -0800 (PST)
Received: from [10.54.26.107] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae492e6901sm121199785ad.65.2026.03.05.00.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 00:11:25 -0800 (PST)
Message-ID: <8355402a-e4f0-42b5-854a-ee42f9505612@shopee.com>
Date: Thu, 5 Mar 2026 16:11:19 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
To: "Huang, Kai" <kai.huang@intel.com>,
 "Schofield, Alison" <alison.schofield@intel.com>,
 "gourry@gourry.net" <gourry@gourry.net>
Cc: "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
 "wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 940FF20D434
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shopee.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[shopee.com:s=shopee.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[shopee.com:+];
	TAGGED_FROM(0.00)[bounces-21396-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haifeng.xu@shopee.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:dkim,shopee.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 2026/3/5 08:14, Huang, Kai wrote:
> On Wed, 2026-03-04 at 18:56 -0500, Gregory Price wrote:
>> On Wed, Mar 04, 2026 at 03:20:11PM -0800, Alison Schofield wrote:
>>> On Wed, Mar 04, 2026 at 05:33:26PM -0500, Gregory Price wrote:
>>>> On Thu, Mar 05, 2026 at 10:33:42AM +1300, Kai Huang wrote:
>>>>> Increasing the 'nr_node_ids' has side effects.  For instance, it is
>>>>> widely used by the kernel for "highest possible NUMA node" based memory
>>>>> allocations.  It also impacts userspace ABIs, e.g., some NUMA memory
>>>>> related system calls such as 'get_mempolicy' which requires 'maxnode'
>>>>> not being smaller than the 'nr_node_ids'.
>>>>>
>>>
>>>>
>>>> Is this a Linux issue or a Firmware issue?
>>>
>>> IIUC BIOS creates the CEDT based on the hardware it 'sees' as present.
>>>
>>> This patch is describing the case (weird as it seems to me) where we
>>> then boot a system with ACPI and NUMA enabled but CXL_ACPI disabled.
>>>
>>> So, I don't think we can blame BIOS.
>>>
>>>>
>>>> Is GNR exporting more CFMWS than it should?
>>> Not sure of any limits on flavors of CFMWS's a BIOS can offer.
>>> If BIOS can carve out a window, it can create a CFMWS.
>>> Not clear how that matters to the issue.
>>>
>>>>
>>>> Is your SRAT missing entries for CFMWS that are otherwise present?
>>>>
>>>> Are the CFMWS empty? (is that even valid)
>>>
>>> Why this line of questioning ;)  I see the problem as a bit simpler.
>>> We have other code that tells us if the CFMWS's are valid, etc, but
>>> the point here is, we are not going to use these CFMWS's so stop
>>> the parse as early as possible, like right here as Kai has done.
>>>
>>
>> Mostly i'm wondering if this issue should be dealt with in the acpi code
>> or if the issue is that we just don't want to figure out how to
>> lazy-create these things instead of always creating them at __init.
>>
>> it does seem rational to build out support for CEDT entries if CXL_ACPI
>> is built out, but this also means you can't otherwise load modules that
>> would have made use of this information.
> 
> Besides CXL_ACPI, is there any other module(s) that uses this information
> for these CXL memory regions?
> 
>>
>> This basically says if specifically CXL_ACPI is built out, the NUMA
>> structure is forever lost - even though it's accurately described by
>> BIOS.  
>>
> 
> The normal NUMA info described in SRAT is still there.  It only avoids
> detecting CFMWS, which doesn't provide any NUMA info actually -- that's why
> kernel assigns a 'faked' NUMA node for each of them.

Hi Kai, we met some performance issues when creating pods because of too much
possible node without cxl memory inserted in our machine (machine Intel(R) Xeon(R) 6746E).
This patch can workaround our issue.

By the way, If insert real cxl memory but disable CXL_ACPI, how the kernel
initilaizes the cxl memory and assigns the numa node? can you provide the
related kernel souce code?

Thanks!


> 
> So we are not losing anything AFAICT.


