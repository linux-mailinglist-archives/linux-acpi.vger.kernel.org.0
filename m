Return-Path: <linux-acpi+bounces-11169-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CF5A351EE
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 00:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3105F18867A8
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 23:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F41202C55;
	Thu, 13 Feb 2025 23:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="J41LyyK0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE102753E3
	for <linux-acpi@vger.kernel.org>; Thu, 13 Feb 2025 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487733; cv=none; b=phm6FZB8veZckypygXs1TvZpGEUWAb7UUuq9PAIHiF3vyBeKYQ8oSaZ5h0fDd0ok0HIZRMsX3TslbeX6xqVptuKQAZbzNF+cZyVSGl6k7ozXfYRNrjBc8Jc4H6NTX1BEPakdSphS+4Hc7Hu84XRmpGryRnuonsuw7+xaC1U9iFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487733; c=relaxed/simple;
	bh=rArljYJMOfbDpgoZMM0tu7ipk28kvPE6eq6PBFLES/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WplgQxzJw1PuCH5COMu9mgJWPlNZPfRBMIyC8YbuIqJ0YxvtswmTOPXllqVD9OBBD0XRPu81s/fBGgWsGQljCP7uO/k/9c4o5qYL1PJlIDRWlUq/BrKWgJgnyNFUTAbwmRLiqh8MfWVo84ul8PwpbXW2Nf3uN0VL21gXOzS02e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=J41LyyK0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4395dddb07dso15203765e9.2
        for <linux-acpi@vger.kernel.org>; Thu, 13 Feb 2025 15:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739487730; x=1740092530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i3EJviBZVRfISojX2MI7jBzPekeh+nEUhxOfd45lGtk=;
        b=J41LyyK0jGy7KB1lSYwCiU3aEavu/CSeYCIKlxoQh9GRl4nx4qAaaBMe7RiUBZTaG6
         VXLpxAtOH8LA1dq50dFFd8qXXGkfgbEIN9wDZx8sXMrauS4QMqZcHZjwscuaOsfdfEgJ
         9h9b7yDUzZgQzptGWljIxPL+rXUWOJmqsJyPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487730; x=1740092530;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3EJviBZVRfISojX2MI7jBzPekeh+nEUhxOfd45lGtk=;
        b=xCU2fWs8mp9p1cZ/w7li7UQenvfHnsssNE9uUZd3NsOrDyqF0ZupPO9+kxlt7QaE3b
         m1AHlJhutrqTLJzAEraBpvpVU9Sb7O8pUifzC903T0M/fv91ma+QZC+ZpQTqerxWSgV2
         H05v3lHWCqZL7w07iRfzAuSvKL7n8GCPYMCzy1v449uIQw54/+bPPvsjoqP4yALBfVjo
         tzdYLTMXvYwbM1mcsIfrIDHlFojx/1wGxhuMYRejALrjcv50mlR9Vl/g6EaFxelJgNzY
         wei+33qiM2k3NtWTEt/Dmf43D9D/BoWbOdqSF5l2WOXvekfTFK+RylrFr2SIcfkDACjf
         xB2g==
X-Forwarded-Encrypted: i=1; AJvYcCUluZ6TAvDg0WBVtaEEJBZ/MgKohJNikAGIbriEYHf4tXAqlDPFDy8ddZdFXvobYTM91251dHf+nPBO@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxuwl5v3ptRe70e//JxcwaF0cd1/O1aGmrwpNpkHSJPUS9aVwR
	SHgCmLGbzO4LhKeB5HgvZZKrFsMIqIiLLaiRc6z4x2zSHkLo7bzO2dN+oWrIZzY=
X-Gm-Gg: ASbGnct0nsn1KiV8GdJAWYZlo2PcpD28wPCBF+I4LonD+rEOW22HqYFb4NKS+kUOZpa
	N/s7zACZyaV/AqMXdBFmiG0g/Owth9E0JCf355Biekj1qX2T5FNgRLgi38gfCZp6XtsffMrx/Aw
	mZObft75TwuodAAKqBvbrL6IwC93E3iaE093Q8BZ5J4aoquj/UuvMrOT60jhjhr0JwefIGCc0T4
	QqMGRWl6mYYmNaIp4lI9gNcUP2nlBKZjOEyWuXs7QlJusBRxeSs5FbwOoERSjsZOEyfbI0j6ffL
	K168/l9zfVZ8y7j9M61ZMan2DASCJ39Rz/XUujjJxS10UvN4WHO23AI=
X-Google-Smtp-Source: AGHT+IE0uyHeHLCMBxq4Z4hX5//KBRVvvcvQgFQ/zStEwjaIUElrnH2cHxabdmecWAuAifE/TSbAoQ==
X-Received: by 2002:a05:600c:5950:b0:439:5b4d:2b2e with SMTP id 5b1f17b1804b1-4395b4d2cfcmr82726945e9.19.1739487729679;
        Thu, 13 Feb 2025 15:02:09 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a055910sm60424855e9.9.2025.02.13.15.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 15:02:09 -0800 (PST)
Message-ID: <445ccf10-5ac8-42aa-ba09-5f4ba689ec19@citrix.com>
Date: Thu, 13 Feb 2025 23:02:07 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] x86/cpu/intel: Fix page copy performance for
 extended Families
To: Sohil Mehta <sohil.mehta@intel.com>, Dave Hansen <dave.hansen@intel.com>,
 x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>,
 David Laight <david.laight.linux@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
 <20250211194407.2577252-6-sohil.mehta@intel.com>
 <b9c21518-54fc-4907-8fc3-d492a3f33bdf@intel.com>
 <2299c94f-aa46-47b5-bd25-9436a8fbd619@citrix.com>
 <90eb900b-0b75-4c0d-be65-a4357729e5cd@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 xsFNBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABzSlBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPsLBegQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86M7BTQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAcLB
 XwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
In-Reply-To: <90eb900b-0b75-4c0d-be65-a4357729e5cd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/02/2025 9:19 pm, Sohil Mehta wrote:
> Check 1 (Based on Family Model numbers):
>> /*
>>  * Unconditionally set REP_GOOD on early Family 6 processors
>>  */
>> if (IS_ENABLED(CONFIG_X86_64) &&
>>     (c->x86_vfm >= INTEL_PENTIUM_PRO && c->x86_vfm < INTEL_PENTIUM_M_DOTHAN))
>> 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
> This check is mostly redundant since it is targeted for 64 bit and very
> few if any of those CPUs support 64 bit processing. I suggest that we
> get rid of this check completely. The risk here is fairly limited as well.

PENTIUM_PRO is model 0x1.  M_DOTHAN isn't introduced until patch 10, but
is model 0xd.

And model 0xf (Memron) is the first 64bit capable fam6 CPU, so this is
dead code given the CONFIG_X86_64 which the compiler can't actually
optimise out.

>
> Check 2 (Based on MISC_ENABLE.FAST_STRING):
>> /*
>>  * If fast string is not enabled in IA32_MISC_ENABLE for any reason,
>>  * clear the fast string and enhanced fast string CPU capabilities.

I'd suggest that a better way of phrasing this is:

/* BIOSes typically have a knob for Fast Strings.  Honour the user's
wishes. */

>>  */
>> if (c->x86_vfm >= INTEL_PENTIUM_M_DOTHAN) {
>> 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
>> 	if (misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING) {
>> 		/* X86_FEATURE_ERMS will be automatically set based on CPUID */
>> 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
>> 	} else {
>> 		pr_info("Disabled fast string operations\n");
>> 		setup_clear_cpu_cap(X86_FEATURE_REP_GOOD);
>> 		setup_clear_cpu_cap(X86_FEATURE_ERMS);
>> 	}
>> }

MSR_MISC_ENABLE exists on all 64bit CPUs, and some 32bit ones too. 
Therefore, this section alone seems to suffice in order to set up
REP_GOOD properly.

~Andrew

