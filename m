Return-Path: <linux-acpi+bounces-10244-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1909F9F8F
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 10:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF6718913C0
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C2A1F0E28;
	Sat, 21 Dec 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="byaljubt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84281EC4C5;
	Sat, 21 Dec 2024 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734772315; cv=none; b=uBXEl9x0yea/MobTKbNU1MjHgiWif5MF8yiwty30dF8WeH4MIDG/7TyHu47nS0iy3cldEQDPfBuGG1j8to3WKEbtWtOrix2TNjW09HgYkIyBvInz6Wfr9AZ/LKmL4nCJTp8zBMHLKM+3x6EaeShSBEWluVCbCf1719C30eCp+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734772315; c=relaxed/simple;
	bh=En7ijAPoJHn5JUBnJu37901ne4hKj2S5Qwc8XbxaPrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PM7zfZKU01DI6gJzStZ+hDlWFFJKoiI65E600uCeF9XOAMWNJYs1X11runAyFylaCHTth20T1V6oILJI3dsQbv2XwgsXoEP2+clUgTGR07cTu/gYiU9lnWk7o/2i2PqyhwAhHXzaUpYeTpfaUq3hPQS5oLFeSSoJPBf17WIw2zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=byaljubt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7949740E015F;
	Sat, 21 Dec 2024 09:11:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id j9QJuJMhsvRi; Sat, 21 Dec 2024 09:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734772298; bh=qGNQ2BA6S2S+aM5v5bqTEJnygVFVuoTIinMCLQtEBwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byaljubtrLS5ejAU3uz2kLzofDFixHGYukj0vRX6SgmQsdKQ2kCtfjimqzqG02duD
	 y43ZI3lDoLW7cGvNMIToGNSWvEeh/p7UJAoQRd3L5RTYbUSZW8kkocwN5GE6Y6R1yz
	 vwI8OeTEEroakcGN8rBwHm5x2V3rfvD1M0JbEo751PvTAaT5rhdXfytTEbOCzuR1m2
	 NT/GtMrX0NgRCWOJ7tUnABArk86SnP4eUQWPY++i4ksqnyyXbTFL4P1w2XeNTuRX6p
	 8XIfIbljIuaWjOrE8gjuhSw5kRFEZU8yKrVxf823d2PaDyo3ISa2vZdE9N/ScBAQwx
	 yJ1tiGZRC3I21U/Jv4Hd979mZZ8AAsryOQ3tw8ZlpxB+4eWGU1OhnQqlIpBCiavvpi
	 oDPZZzc0NXSdSxwICSHFKuF14I9C+J9fVbe7MS67KjwpooP2ljgxIXmPETdY0DZoLX
	 bso6YsvLMG1O+MOy4KeqZQXuUux9H/OqwzgqSlaM5aBPm7IpqV9qYAIOP7esJWb6jV
	 PbiAJZmXIG23yMAIpyvBylaG0zwuduj7vavzqaBxuNfDwVF8oJrjsIDLgh7e5H30E7
	 YBRDIF6bK2hcxW/I0aHbOHsO/b0QeXvgQZEFuaXSJsEECvC+nx43KRhBzTTgHvSFO7
	 Jrso1g99qMbOlbLfpwUo7YuU=
Received: from nazgul.tnic (dynamic-176-005-148-127.176.5.pool.telefonica.de [176.5.148.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A3E240E0269;
	Sat, 21 Dec 2024 09:11:07 +0000 (UTC)
Date: Sat, 21 Dec 2024 10:11:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [RFC PATCH 06/15] x86/microcode: Update the Intel processor flag
 scan check
Message-ID: <20241221091104.GBZ2aGKIXUMlpmrbQW@fat_crate.local>
References: <20241220213711.1892696-1-sohil.mehta@intel.com>
 <20241220213711.1892696-7-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241220213711.1892696-7-sohil.mehta@intel.com>

On Fri, Dec 20, 2024 at 09:37:01PM +0000, Sohil Mehta wrote:
> The check whether to read IA32_PLATFORM_ID MSR is misleading. It doesn't
> seem to consider family while comparing the model number. This works
> because init_intel_microcode() bails out if the processor family is less
> than 6. It is better to update the current check to specifically include
> family 6.
> 
> Ideally, a VFM check would make it more readable. But, there isn't a
> macro to derive VFM from sig.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
>  arch/x86/kernel/cpu/microcode/intel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index f3d534807d91..734819a12d5f 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -74,7 +74,8 @@ void intel_collect_cpu_info(struct cpu_signature *sig)
>  	sig->pf = 0;
>  	sig->rev = intel_get_microcode_revision();
>  
> -	if (x86_model(sig->sig) >= 5 || x86_family(sig->sig) > 6) {
> +	/* TODO: Simplify this using a VFM check? */

No TODOs. Take your time and do it right from the get-go please.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

