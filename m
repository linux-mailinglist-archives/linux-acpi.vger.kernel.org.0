Return-Path: <linux-acpi+bounces-20415-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CEED38D0F
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Jan 2026 08:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70D8A302106A
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Jan 2026 07:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74145314B76;
	Sat, 17 Jan 2026 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="BNSY6ZOH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E32DFA32
	for <linux-acpi@vger.kernel.org>; Sat, 17 Jan 2026 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768633587; cv=none; b=mZqK50tVacTvMrmq6e2DZtIiKzyu4VilgAS76qZrmfknvfE7xOztwW0YQ6MlaZUdwWrW/8jV1luPVDl+zWxd//3tFDDQXGARWY8+fJBhtRNKbQtPI54OxDfUULfzEfvVw6+vgFi1NuLXnL4XBmKwJeFgHYNxtiLubG82l7gAcQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768633587; c=relaxed/simple;
	bh=7xEDnjOE+1tFOIr1Nu08H/OKjlBqj/Z6q+hVMzK6dns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TuM1vCLZqP6LTxqk8l9ceVx98XW2WoXPDrJnM0sGF9u4VKFMhq4xsYsS1R+MffQ40YXf9dYaqZIzNycFMNvinnfee6Hy+Su2TTHEgr6EUnUBshqr+JbKay2/g0QXa1w98w9YBHMsFau4PUo8OkyvEwQyicUzpmTX67SNzDjl3f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=BNSY6ZOH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0abca9769so3212035ad.1
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jan 2026 23:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1768633585; x=1769238385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4Z8k29GQli1MwJv6po4tns8b++VlSRu8LmhGsF0n5c=;
        b=BNSY6ZOHvGoGXuBC0MjPmoqFJ75otbxSE4VGXktHo9J459W82B5fEx1R2F6onP/np5
         uSYGGnQX3TIH4U0Nk16fKQ3A72XxeYBcbeDAmd7IE/LqaHn389TAm6Fz40zwf+OOHoJh
         vfI4FgpxyKh9PoX1/6NAmuLDeZxZmddZerPsC7thZ4iG+FwlJAGxZlxW1Bm1smXKO02Y
         tE9gd1IU67doaw3gbg+e+YaOf+Bdiyvw/jRl/tx7xnuJlE2DHIL58nLgZXxs9aWHHtzU
         zSbjqnNW2iEvb0xdExmV7dzeNhPAM2L5vNhmYHF8Nig4mbmteEPs1zj9TXwbGHeRQwrW
         zXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768633585; x=1769238385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4Z8k29GQli1MwJv6po4tns8b++VlSRu8LmhGsF0n5c=;
        b=PRmYYyCtx99BqjDZwTYfMuX2by+KjKTr9gEbJmcipY1VFBl2ltjHKrCB5vsN0mn2uR
         +LvGR/HkSroEYKowBOtx/pQTI5BC8yNnzH4zgx07C6OVu75Yh87KDtunnfvsDjORD5BT
         O4BOFLRiMB3jpgREmvzKrcs7kSy+yZHeRaFC22zkH248Cq9Q+rZi0CKZKVGkLktE6WDG
         w/0ujWcabVvsjDa/CqIUARBrrmxrLXynQ7jpBmRP+dyRzE4fasoG1FqLA+SyxvStOAxw
         QK4zaduTpnZfV/5gUONnCDuM4tnCUoX38D/oDD0ghi+Hl+5JYdY4/q3QYWaxtPF3zE3B
         cAwA==
X-Forwarded-Encrypted: i=1; AJvYcCW9YvYyPq50HN3haB+CihAY0RX7cmRqGr2VX84r6eyrBYldet0qkiCaiohnzLOGLDtZ8fbD8dMJiDYR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9dn4STFgDxpzqvY8EVYuhHmOrihi738tLlQ3fDaqCJNsLHV/u
	CvQc51RIv+ee3XERrn1Onvj7rKwvMnkfTufhupG+zW6vNSNpbWPci4BxJdkrjijlrDo=
X-Gm-Gg: AY/fxX49wqUOREuhjmnIRn1toEZyTwyGuR1L3WrAALHJWE3Pnak6uQWdCoJNAYfBUbh
	7pCvPFSmNv/bZogP0FxFRLH1H3yHBAVBXyzMTp+gEp0BdzLEeSybjKVe5fcf1h9PVCPScLZiaF7
	pgxT/d5mbQn/RPYyEt/jR2LygGtLOEw4afQO0vU9PeK6wo2V91sBaLitCujVsHSxdXmWzZIrsRi
	oB2II345mCRUZYYBd3tBac29w3JABRxyrfjjWEAwbAOU6WlJ9hen+nmHmj/w5IZ+Rp9Nf2tIHuH
	Tdkn5pIbuc9t/ZwTmzMrKvcK1kfHam0dC1kFYuCIQFRO8qVuzkCP1J4ZLxejlrIpO3JrgLoKgUo
	Q0a2Vm9PSdldc30XCB0qd9daRZyIfZNttAzC4sxBD32B0RnZqReKdl0Nv3DtyLqV/GJJprF4MyZ
	i3pnob9awEOx7G
X-Received: by 2002:a17:902:c409:b0:29f:f14:18a0 with SMTP id d9443c01a7336-2a7175cd02dmr42177405ad.4.1768633585353;
        Fri, 16 Jan 2026 23:06:25 -0800 (PST)
Received: from [10.0.0.178] ([132.147.84.99])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf355ca7sm3748156a12.27.2026.01.16.23.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 23:06:25 -0800 (PST)
Message-ID: <b2584ec9-8593-46d6-aff7-5a1f6081c9ae@shenghaoyang.info>
Date: Sat, 17 Jan 2026 15:06:11 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] x86/acpi: Add acpi=spcr to use SPCR-provided default
 console
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20251228092222.130954-1-me@shenghaoyang.info>
 <20260114154656.GDaWe6cFCruAGbJbhe@fat_crate.local>
 <b5d54942-f280-40ab-b445-00b6dc610a8e@shenghaoyang.info>
 <20260115120058.GCaWjW-sT7eBr94SEr@fat_crate.local>
Content-Language: en-US
From: Shenghao Yang <me@shenghaoyang.info>
In-Reply-To: <20260115120058.GCaWjW-sT7eBr94SEr@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 15/1/26 20:00, Borislav Petkov wrote:
> On Thu, Jan 15, 2026 at 01:09:40AM +0800, Shenghao Yang wrote:
>> We've been inserting the dumped config into the kernel command 
>> line and rebooting on first boot (e.g. console=uart,io,0x3f8,115200),
>> but would love to avoid this loop.
> 
> Yah, put that in your v2 pls. That's much more understandable.
> 
>> It's easier this way for larger fleets - we don't want to manage
>> hardware specific serial console settings on the kernel command line
>> if the firmware is already capable of telling us the correct ones.
> 
> Should also be in the commit message.
> 
>> If earlycon is specified on the command line the console from SPCR
>> is used, but only as a boot console. It's not present in
>> /proc/consoles.
>>
>> It is possible to retain it with keep_bootcon, but that uses the
>> less efficient (in the 8250 case) 8250_early driver.
> 
> Also for the commit message.
> 
>> In 0231d00082f6 ("ACPI: SPCR: Make SPCR available to x86") the SPCR
>> console is only added as an option for earlycon but not as an ordinary
>> console so users don't see console output changes.  
>>
>> The patch adds an opt in so we can get the SPCR console added as
>> an ordinary console.
> 
> Yap, your explanations make much more sense, thanks.
> 
> Please structure your v2 something like this boilerplate guidance below:
> 
> 1. Prepare the context for the explanation briefly.
> 
> 2. Explain the problem at hand.
> 
> 3. "It happens because of <...>"
> 
> 4. "Fix it by doing X"
> 
> 5. "(Potentially do Y)."
> 
> And some of those above are optional depending on the issue being
> explained.
> 
> For more detailed info, see
> Documentation/process/submitting-patches.rst,
> Section "2) Describe your changes".
> 
> Also, to the tone, from Documentation/process/submitting-patches.rst:
> 
>  "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>   instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>   to do frotz", as if you are giving orders to the codebase to change
>   its behaviour."
> 
> Also, do not talk about what your patch does - that should (hopefully) be
> visible from the diff itself. Rather, talk about *why* you're doing what
> you're doing.
> 

Thanks! I'll reword and send v2.

Shenghao


