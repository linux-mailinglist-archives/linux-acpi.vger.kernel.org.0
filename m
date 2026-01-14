Return-Path: <linux-acpi+bounces-20339-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1029D20708
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 18:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2AC4301AE2B
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 17:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE132ECD39;
	Wed, 14 Jan 2026 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="EvnJ18aU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE712EC571
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410598; cv=none; b=NVqeTUv5Bfj6TvpU7pCB7t/FHjyvUDdu1qo1u5Kx3kqxpSEYhk/QfjXRiRPArS4md0leiE3oDaUafjiTRIW2ZFBcOqUfjbHLCiYj5xpxMrU403v3V5CPqtSjQZO9FfMrWqJzFYReSlq0f6RIda42i+cXurIPDOimUJnRVWzZVuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410598; c=relaxed/simple;
	bh=PM6sHi1aQfy0NtK9ko2ZFgH/OijvhK/kCkUnfQiolAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTELHR5pymFL49Acq20sP7eT0kIj8bzV+cdMSlU/8zM08Wq4yuG+n84mujP85V+fB/KyVhah2dHwteeH/2liHWU4iyfSZ5sBZVySW5RTd4t5pcJz6uJWWFW/awyiFk7eGrhizzDLAo3b/ShmEBMzBNNtmzM+8FoChJAlP3z6tK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=EvnJ18aU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a355c8b808so74265ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 09:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1768410593; x=1769015393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7mzYYJYLlSKoW+IZetZsbxI9tBQZKOvmgPmXcCAqdY=;
        b=EvnJ18aUOj8QfcPfJ3/s1L7bK3/408J1P7VDM9KmmWQYvJTjvJnPm4YqTliIQtGvSq
         wton5eObUlJ1S8iboCnS2l0R5pEF9coWuxbtOzQL6WAvANp20SmSESejFVLb25J2LrNO
         0vdOAog4zgn4DEdwfmgU5/wTyAMSc7viT06AgV80csm66iSejYaIgmNFTobz1kxwUdmK
         5DAaDQD9HOvee+2HxMapiuus2tJlVF57NZUta3Gdv2Eds0qDGLXrm16y5uP1CHiCcyU2
         ortQd9+t1bEDQbezoIjwYDFoh3VSZUUuwgaVUm54SmEIhOdDGtR3/82Qcyd7kwP+spcg
         zADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768410593; x=1769015393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7mzYYJYLlSKoW+IZetZsbxI9tBQZKOvmgPmXcCAqdY=;
        b=a7iaQSuYDfr4lENaupRjSpQcq8s6HIyeMJFpdS3Vt5cEqLxVXYckwXqCBVpPVm30AD
         7dO3K1GRhuXJl10qkGv1dBk6EH72eGNWPTdEm5vn/LXJ9J8MZNFbJWhZmwCtRXWEPWc+
         3u/2oqqVRfJ+Hpueu1KyRsQD84JBSa9bixS3fNjohYWSC4WB7klInim9oK8hjV9I3nUo
         Eu/32HfzTxDT6S6fKQAZQk/VlgnX6IYPHyVK2ge28M78UZYnUFHNmCpgqgCJXIPhu6xI
         05zNO42WH5weSkR7WeoV1iR+X0aSJCmDtHNbdHzgThR2ZcRYK1h+3Ihcua859LIH9HvP
         r8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCURziFQw5GgOVlVHLVSxQ/Xgb0TPWMjFJs4+BNy1x2m4o9Mc3B7zay+SWMSN2zRofI0FgVLua9DDajX@vger.kernel.org
X-Gm-Message-State: AOJu0YxXDQ16QQp0WNtrVtsBz0H9UqQL0MpGACgKycUGZzyTPqMWR48k
	CJKtQlslgCeQ03RF+vBq/ancBJlb7ePRpwXszj8c5NleodmaLdo/vFSPhdUqXepnFIs=
X-Gm-Gg: AY/fxX6nTd9i2Osqiwxuk/jlHBUg2j29y5e8wAgHyZ8tylHCZCd2bGIVnvojkbteCcG
	pZICybBYZpZGUXPH0ceZygfSgmoO+3Q0/Y6Xe+1XGtY875RaGyRISSKX/KaLt2oXy+V29uovPw8
	TU5rjcgLcgB40szUwJ3uirrUcSd9aHku3lzKDCWK6jKsvydx2a1nf353PNGpjF2AzPhvFmqsQE/
	HHEyEebiCt6em65RhmW1aymLAAZt58rbxnDUdd1Z47x6PLbEfRlL3KNnrQEubCprQ/yyXJRhM4e
	h7JmE/6g5kCUo/KlGrOINLwEjjJ/C/TXnUhESUQzl7OrtXlXtHnA2qMPPaZpT2ViUmPzdDcodfv
	ymGyMUpgxvTtk4AJggIXdas5WcJWFUCtzQ1w9Gq953hX69RQYX/vxDF6DZKnQyYhusKo3eNOojO
	rUprzLHDLUpd3T
X-Received: by 2002:a17:90a:fc4c:b0:34f:4416:33b5 with SMTP id 98e67ed59e1d1-3510918d67bmr2365054a91.8.1768410593040;
        Wed, 14 Jan 2026 09:09:53 -0800 (PST)
Received: from [10.0.0.178] ([132.147.84.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3510691b655sm1211536a91.2.2026.01.14.09.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 09:09:52 -0800 (PST)
Message-ID: <b5d54942-f280-40ab-b445-00b6dc610a8e@shenghaoyang.info>
Date: Thu, 15 Jan 2026 01:09:40 +0800
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
Content-Language: en-US
From: Shenghao Yang <me@shenghaoyang.info>
In-Reply-To: <20260114154656.GDaWe6cFCruAGbJbhe@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14/1/26 23:46, Borislav Petkov wrote:
> On Sun, Dec 28, 2025 at 05:22:22PM +0800, Shenghao Yang wrote:
>> Commit 0231d00082f6 ("ACPI: SPCR: Make SPCR available to x86")
>> made SPCR available as an earlycon option on x86 but did not add
>> it as a preferred console to avoid breaking existing setups -
> 
> No one has noticed AFAICT since 2018 (this commit's date).
> 
> Also:
> 
>         /* Do not enable ACPI SPCR console by default */
>         acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
> 
> Looks nicely conservative to me.
> 

Thanks for taking a look.

>> users have to round trip the dumped console options
>> ("SPCR: console: uart,io,0x3f8,115200") back via their
>> bootloader.
> 
> I don't know what that means.

The kernel decodes the SPCR table and dumps the settings to use
the firmware preferred console in the kernel log:

[    0.005091] ACPI: SPCR 0x000000007FFB5000 000059 (v04 ALASKA A M I    01072009 INTL 20250404)
[    0.073387] ACPI: SPCR: console: uart,io,0x3f8,115200

We've been inserting the dumped config into the kernel command 
line and rebooting on first boot (e.g. console=uart,io,0x3f8,115200),
but would love to avoid this loop.

> 
>> Let users opt in so serial console configuration can be made
>> automatic.
> 
> Why?

It's easier this way for larger fleets - we don't want to manage
hardware specific serial console settings on the kernel command line
if the firmware is already capable of telling us the correct ones.

> 
> Text says:
> 
> 	[X86] When used with no options the early console is
> 	determined by the ACPI SPCR table.
> 
> But the code doesn't enable the SPCR console by default.

If earlycon is specified on the command line the console from SPCR
is used, but only as a boot console. It's not present in
/proc/consoles.

It is possible to retain it with keep_bootcon, but that uses the
less efficient (in the 8250 case) 8250_early driver.

> 
> I have no clue what this patch is trying to do.
> 

In 0231d00082f6 ("ACPI: SPCR: Make SPCR available to x86") the SPCR
console is only added as an option for earlycon but not as an ordinary
console so users don't see console output changes.  

The patch adds an opt in so we can get the SPCR console added as
an ordinary console.

Thanks,

Shenghao

