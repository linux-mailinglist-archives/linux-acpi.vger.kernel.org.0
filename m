Return-Path: <linux-acpi+bounces-8691-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295CE999479
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 23:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA631F24530
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 21:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCE31E0098;
	Thu, 10 Oct 2024 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IGD8/3X/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B61C9EBB
	for <linux-acpi@vger.kernel.org>; Thu, 10 Oct 2024 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595907; cv=none; b=lxUJAMBjC/S4W1JswG2GM07zaRAkk/AlXHPNcKuuqEhNfLqS5iYYlJLti08t0t9tRp+IsUXhB//mV6oS/embdpvzU7kGLaYal8RDqw9jAPKqG0A+C+9UzLQv5SBZy/leB5pG4My8EQ57MsznNOrWVZsr/t1jC5YbaNrP+P6kI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595907; c=relaxed/simple;
	bh=Yzqo2EvRl/hAMy9921B1F/vlHog+5QKQvX4eo6xSj5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZvurH0D6fOjJs51iQnf/Olv9vAWehBHgXk0L+QLrrx/7m/GqHM8BE4lKNqAX3+s2eblM9vaHC8NCH747nUBgSvn/QP7n71Qtksu5ES8+oGrHB+ECi9j6UjmV+LLEcsPUjVAD1WR3uezai461jQIcjttShadYt4dUfQNJ4pmyTIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IGD8/3X/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32e920cf6so27003567b3.2
        for <linux-acpi@vger.kernel.org>; Thu, 10 Oct 2024 14:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728595904; x=1729200704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EJHAgR8eOYnfYjnDH+Ke7REFFOpEvhduZdZs2oNUNrQ=;
        b=IGD8/3X/ciWjjAl1QsnWRuxJc0PxewqEr4rcm/D3kShmy2R8Fbj6jFXYvgsWpzt5KC
         xb1XV/BhDo/Ucj3PCHY3ApcBzbbiK1kKmsaW6gvq+D96EbdcO+sILsnNodrIqOEx2il7
         hVbjD2QaO3TZ2GU/up4MviwEXlyXokRb7NqmVvwRghzGo0tTH8uROofnqhMjL4+ms584
         0KpumhkQuIt8coBDgpG4oAfgLMO8kqJOXPNhrqIlVz86a7BH2WquD0wYhcsN2+wX0ywy
         otAnzNs9PfkJbdi5zNUk3B9seNuKuxYQc13XOM8E9Juvgg8SfoiHe5hCu1s4oxjAI4tB
         kfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728595904; x=1729200704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJHAgR8eOYnfYjnDH+Ke7REFFOpEvhduZdZs2oNUNrQ=;
        b=jaT603PymnUiZJCrXXG6EN9hQg/jC8mVVnj2jWn2SaArm5LTBUdj6QpuLa6eZRFwrS
         DMO1F45Q14KRZMZcVTTx/NqJqJIuYbK52/uBTJMd9CBUQIudM4I2VpS2vN5n9L3TZbiL
         Sq22u93lw9SzQOSDD6pJlaVUl98riso93TFbcDAShVulBJ8O8BsSUocHJrCsnlaIvRsp
         SsVs4o6ETifUh1SV8iIA6bGGpoL5z9IQztYHtnCgcwY6B05fb014CV4mZ5KEZqF/Xe5N
         wExugLP72lpMgh7BbwzBpZC6cHL/UXXfxrvYaodPUfME9i1wadgYLlIY/KPXH6zHpLeJ
         ZcPw==
X-Forwarded-Encrypted: i=1; AJvYcCXWAK33Ii39qVIzMYzSF9WjAUALUdiUxVptPVMWhCZmr25NmWvHNMNdyLng1Rb8xnwbB9X9fOzTBBT0@vger.kernel.org
X-Gm-Message-State: AOJu0YyhnyLBmdl8c2yZpMpSWRW299B7R1n96sFbg5oCKF4wSyZvEhqr
	rWouQfZhkUngejQKEIKu1tr0AgCX7RbszjYDfmpg7szoeZuSdSMkLLWNeaGoQI/WajSJPj6QPKj
	N3yw4m6Xg3A==
X-Google-Smtp-Source: AGHT+IFlkqx3xD0Q33jhVUIr5iUteh4Yw48/PxVPDblQ90mLsIhhb+hEXTRk5UZ9znbyyum31yvdj2omH/gr5Q==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:f3:525d:ac13:60e1])
 (user=jmattson job=sendgmr) by 2002:a05:690c:48c1:b0:6e3:14c3:379f with SMTP
 id 00721157ae682-6e3471eaeb7mr201857b3.0.1728595904524; Thu, 10 Oct 2024
 14:31:44 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:31:36 -0700
In-Reply-To: <20230702162802.344176-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230702162802.344176-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010213136.668672-1-jmattson@google.com>
Subject: Re: [RFC PATCH] x86/acpi: Ignore invalid x2APIC entries
From: Jim Mattson <jmattson@google.com>
To: rui.zhang@intel.com
Cc: bp@alien8.de, feng.tang@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, 
	rafael.j.wysocki@intel.com, tglx@linutronix.de, x86@kernel.org, 
	jay.chen@amd.com, jon.grimm@amd.com, vladteodor@google.com, 
	ajorgens@google.com, myrade@google.com, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

> Currently, kernel enumerates the possible CPUs by parsing both ACPI MADT
> Local APIC entries and x2APIC entries. So CPUs with "valid" APIC IDs,
> even if they have duplicated APIC IDs in Local APIC and x2APIC, are
> always enumerated.
> 
> Below is what ACPI MADT Local APIC and x2APIC describes on an
> Ivebridge-EP system,
> 
> [02Ch 0044   1]                Subtable Type : 00 [Processor Local APIC]
> [02Fh 0047   1]                Local Apic ID : 00
> ...
> [164h 0356   1]                Subtable Type : 00 [Processor Local APIC]
> [167h 0359   1]                Local Apic ID : 39
> [16Ch 0364   1]                Subtable Type : 00 [Processor Local APIC]
> [16Fh 0367   1]                Local Apic ID : FF
> ...
> [3ECh 1004   1]                Subtable Type : 09 [Processor Local x2APIC]
> [3F0h 1008   4]                Processor x2Apic ID : 00000000
> ...
> [B5Ch 2908   1]                Subtable Type : 09 [Processor Local x2APIC]
> [B60h 2912   4]                Processor x2Apic ID : 00000077
> 
> As a result, kernel shows "smpboot: Allowing 168 CPUs, 120 hotplug CPUs".
> And this wastes significant amount of memory for the per-cpu data.
> Plus this also breaks https://lore.kernel.org/all/87edm36qqb.ffs@tglx/,
> because __max_logical_packages is over-estimated by the APIC IDs in
> the x2APIC entries.
> 
> According to https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#processor-local-x2apic-structure,
> "[Compatibility note] On some legacy OSes, Logical processors with APIC
> ID values less than 255 (whether in XAPIC or X2APIC mode) must use the
> Processor Local APIC structure to convey their APIC information to OSPM,
> and those processors must be declared in the DSDT using the Processor()
> keyword. Logical processors with APIC ID values 255 and greater must use
> the Processor Local x2APIC structure and be declared using the Device()
> keyword.".
> 
> Enumerate CPUs from x2APIC enties with APIC ID values 255 or greater,
> when valid CPU from Local APIC is already detected.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
> I didn't find any clear statement in the ACPI spec about if a mixture of
> Local APIC and x2APIC entries is allowed or not. So it would be great if
> this can be clarified.

Has this been clarified?

The reason that I ask is that Google Cloud has a 360 vCPU Zen4 VM
occupying two virtual sockets, and the corresponding MADT table has a
mixture of Local APIC and X2APIC entries.

All of the LPUs in virtual socket 0 have extended APIC IDs below 255,
and they have Local APIC entries. All of the LPUs in virtual socket 1
have extended APIC IDs above 255, and they have X2APIC entries.

Prior to this change, Linux assigned CPU numbers to all even-numbered
LPUs on virtual socket 0, followed by all even-numbered LPUs on
virtual socket 1, followed by all odd-numbered LPUs on virtual socket
0, followed by all odd-numbered LPUs on virtual socket 1.

node  #0, CPUs:          #1   #2  ...   #87  #88  #89
node  #1, CPUs:    #90  #91  #92  ...  #177 #178 #179
node  #0, CPUs:   #180 #181 #182  ...  #267 #268 #269
node  #1, CPUs:   #270 #271 #272  ...  #357 #358 #359

After this change, however, Linux assigns CPU numbers to all LPUs on
virtual socket 0 before assigning any CPU numbers to LPUs on virtual
socket 1.

node  #0, CPUs:          #1   #2  ...   #87  #88  #89
node  #1, CPUs:   #180 #181 #182  ...  #267 #268 #269
node  #0, CPUs:    #90  #91  #92  ...  #177 #178 #179
node  #1, CPUs:   #270 #271 #272  ...  #357 #358 #359

I suspect that this is because all Local APIC MADT entries are now
processed before all X2APIC MADT entries, whereas they may have been
interleaved before.

TBH, I'm not sure that there is actually anything wrong with the new
numbering scheme. The topology is reported correctly (e.g. in
/sys/devices/system/cpu/cpu0/topology/thread_siblings_list). Yet, the
new enumeration does seem to contradict user expectations.

Thanks,

--jim

