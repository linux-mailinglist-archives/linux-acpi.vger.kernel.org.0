Return-Path: <linux-acpi+bounces-10246-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20AF9FA014
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 11:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98EA4188B2C0
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285251F0E2B;
	Sat, 21 Dec 2024 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6uqDtjN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686EC646;
	Sat, 21 Dec 2024 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734777334; cv=none; b=Rqbj00k7D6E8/NL8pgzgjVcIpWhCKpGuDo8seiB5JJx55JCiHA0f9vfAZLQ8RuDZmYyMGCyBfOI84M4A7nG0lpXOlL3W4TwvVTghxKYxoVGob5tdb9jHoj8D+u3BLQi6Cz38VfILxGHeH+W+WtYf/ScnXcWn7+GlNruH3SdJfm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734777334; c=relaxed/simple;
	bh=eB6lS9ha1kYv9GEm8TgMPYt6fXjYLVzRJ3TXpfXP/rw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2xoGVFpvXdxCV9g+ezqOK8NrWOxVXTHYZIhWJ1FRho0FgcrHG6zadOsGUem7PlCrG5fcrUkPQ0xNPdlqO5CZo41mhJu/YDDfp4wFbTw7Qn2Qas2qf6YSKkAiVUY/NS//HOkTRTTHGKF5j8Y1rbywZ/XF3B/+vvb+rLzbi+4bVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6uqDtjN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so30188765e9.0;
        Sat, 21 Dec 2024 02:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734777330; x=1735382130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV4MfTOnPXGCM6//LL3weM7ThasmfUOU7e3taojJq6o=;
        b=A6uqDtjNGu19eeNwCPRUBZN+mXmNC/rKe2tofhNIDUYn8Zq8dP1FEGkgIkj63XsC2o
         2gN74ZsoZjwfyVKxSNgkB7Bo1wMvI5FpaeOJ1Wzgf7uRFNSyVE0kE7fxI4ZvHWPLlxZO
         VFWfzCmoSuH7muyMWS9KUCVAXteEpQl0BEasbQsXQgByKvHRogB3T3ZO+FPqnGdyp5X8
         lkZhtdVf12UgZbZFGzxuBnpELuMokYGNrI7LExZHzCPmkJ6FZs2tRRO8pYnePsj6Im7Q
         ZQuvUtF/0/r0ruVHG3hFjo4JrcU4tplSsswb83cBFMzkw9tm4a60SgnzFn20A+INKIOS
         pvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734777330; x=1735382130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV4MfTOnPXGCM6//LL3weM7ThasmfUOU7e3taojJq6o=;
        b=UcbRa4pmYXQIZQhTQZumw6GHY+7599BPDflcnyiq+4ZDumU5o3pccOdOGdSocP0xWF
         0ILFazvyFCZ0PH+iXrx7aSDlNfoaFKVylg2evNcYnqgSbXIFH+i8GoXmfQITC8V+ESNi
         50tdE8TyzhD1wMxdFg5SW7OWWsH42z46YwKU3IgSvo6Ec9uYdY2aXP32HWoND61wH1fv
         Q2ALAUD009tvaYGaFc/YsVJLWqrKBZYhN4KxFnXttfE6tjlEqjMB4N8ZeW39+7ct93qQ
         T/oXfYfv06w8ZYl3qZBE7w+mngGbOLFltrJ0x5XE9ikdm0fni5M3tC+Ccj+LmhHFmqZ0
         /PRw==
X-Forwarded-Encrypted: i=1; AJvYcCV1kIp9Fx0NbMyYhqRBE0d/hX88lcG6C5e0uOfzbtqPOMigNCf/4tYgjyB+v27oTA8gwNNMglvD70krxa+jJuo4Jg==@vger.kernel.org, AJvYcCVw0QEoJVbiJ55u/s7phG5UNSubHJN4D2VlD2ASq01eTlP9wapa8fcqQgTc1UHkpzbKbzPK+XPpddFo@vger.kernel.org, AJvYcCWSOTUv8FdlqnctxHe+FC8bzAjn64liBR1+ja8HTWV9WFq68wR2kWySn+s7NXUjZVkW9z6G+G4fjXZyXRw=@vger.kernel.org, AJvYcCWWF/WB962KSD8tApfschbjI84kJVup/jHQAfso6Wp9+cJzQbYGXZbZo+/OpPaLmrg2YfodVxs2L/wuFwxr@vger.kernel.org, AJvYcCWytv8p3s/ma2a6y860IKMHQytTZsMJMyhq8Iafo5PZXFWRtPNCrQtHCTYGC2sOFzy1ctIHOOVAdXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9iXY89CNG9AdQi+KUmRAnmywDEp8M9PtF2lg3ZoC2Ya9NryMm
	1bPDrvJWeQ1Q0dfGiHNc3gnb2Jsj4x5rX6S6hRf4jy0s1IavAho7W78Axeco
X-Gm-Gg: ASbGncsYaB7GaajyF8BZoQXGrur3jRedjfIb1JHESi97U6fxnxeTpaLaS5z259eMOLk
	3Jdno/PBM6wtgRNU35CLG/dpZPWY4KvSjMBPDuyuo/H+L8S7IWov/8jCotM5GnsOgeaYo9B8KsR
	dpJM+0uq5zWFRipPUMitC01T1m1vLkxpqx/vrLRhRRVhaNfqa5ZbRCLkGIHxzf9FhivvEBB01WR
	1fsiSsuZx1OYrt0oYMyxJH/D9f6aCztozTu78ybyIdUuy1Y5xGziKES1McMwYu7y8DUl3KgfiOI
	MCVb+F/LY75+Cr1ORg5SuMg=
X-Google-Smtp-Source: AGHT+IGgVKTc2GXw31nd/5D+nzQxbCxuAoRXwAk8jEc+q1KPL4Ec54RHeXe32ocbmwCEGiCG3kankQ==
X-Received: by 2002:a05:6000:2af:b0:385:e1a8:e28e with SMTP id ffacd0b85a97d-38a221e1e76mr5578757f8f.10.1734777330425;
        Sat, 21 Dec 2024 02:35:30 -0800 (PST)
Received: from dsl-u17-10 (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e261sm6251002f8f.76.2024.12.21.02.35.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Dec 2024 02:35:29 -0800 (PST)
Date: Sat, 21 Dec 2024 10:35:28 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck
 <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Thomas
 Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H . Peter
 Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Zhang Rui
 <rui.zhang@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [RFC PATCH 08/15] x86/cpu/intel: Replace early family 6 checks
 with VFM ones
Message-ID: <20241221103528.2ca530a5@dsl-u17-10>
In-Reply-To: <20241220213711.1892696-9-sohil.mehta@intel.com>
References: <20241220213711.1892696-1-sohil.mehta@intel.com>
	<20241220213711.1892696-9-sohil.mehta@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 21:37:03 +0000
Sohil Mehta <sohil.mehta@intel.com> wrote:

> Introduce names for some old pentium models and replace with VFM based
> checks.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
>  arch/x86/include/asm/intel-family.h |  3 +++
>  arch/x86/kernel/cpu/intel.c         | 13 ++++++-------
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 6d7b04ffc5fd..41278093bcd4 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -46,6 +46,9 @@
>  #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
>  
>  #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
> +#define INTEL_PENTIUM_II_KLAMATH	IFM(6, 0x03)
> +#define INTEL_PENTIUM_III_TUALATIN	IFM(6, 0x0B)
> +#define INTEL_PENTIUM_M_DOTHAN		IFM(6, 0x0D)
>  
>  #define INTEL_CORE_YONAH		IFM(6, 0x0E)

I think I'd add all the extra defines in one patch.

Isn't the order 'funny' as well.
I think it ends up being neither numeric or date order.
Increasing family order is probably best, but the headings for each
'family' probably need to be a bit more descriptive (esp 15 - all P4
netburst).

	David

