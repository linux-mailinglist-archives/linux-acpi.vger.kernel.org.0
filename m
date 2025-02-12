Return-Path: <linux-acpi+bounces-11077-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2583EA31ADD
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 01:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECAA1889A0F
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 00:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E717996;
	Wed, 12 Feb 2025 00:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ATu/kmAq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED575A50
	for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321698; cv=none; b=XYimNZZF+1cEXS31a5+Jg3ppn7pBSMW4uZ1xDKUTfnFfRO3fPlKYqECttujZbIcm7B2Tuc9k08CBGQ7IGBbMQoORO+EjNR0As7hApyaXloesX4DfooXNRhNvqMkzuEx+s/XCPBOz3mCAx66OLUq+ix2s1iN+2MEi0U/brwS9+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321698; c=relaxed/simple;
	bh=UIzklivqR5Z23WPkWjVe2n77YozrOST8ZDHjd23oRgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDB26JT3eDiu677vh5rd/NM5aEvPaFz8vdJHi/NMGx2Zm7Zk+iIfzW4fiLgwaBiGPHhAaT1GnWPqjEaW4arvYBcaikPYCWZc6z8YTHDUKj7MCNZaUFg2RiV+pg1wTjIsDkg1r3k5ssJbr9FQdpGUAozE0p8++a1J9g520hj7r1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=ATu/kmAq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so21029565e9.0
        for <linux-acpi@vger.kernel.org>; Tue, 11 Feb 2025 16:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739321695; x=1739926495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3eEjYLiIzAQvKfFhJfuIXXpvDRbqlCf0jI1QKURWY7Q=;
        b=ATu/kmAq6UsVYQ31QRq+jvEFumCs+gQo6q462XofCYlHjpHBjgCIhjksLVgH+ACCfF
         v4E+kgMLzwlXXjM+2/2GJ2cFP2qyzgZIBI+5Gou67i0douboKH2VTCRLkhj3Y2LiQS0U
         lhOI9+StSp00lDDoFid24c9COnjrE8fdeVpU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739321695; x=1739926495;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eEjYLiIzAQvKfFhJfuIXXpvDRbqlCf0jI1QKURWY7Q=;
        b=hkafAUVKiYDrVngiQ4iMUbD+5fNkKWfaxcC0ymYo+en6txW6VdFJYvtDYbWie8h920
         ccOZNaZpl3BoHQlABoyelmKsVtJ1uvNLntcZ5PGETp1nGSeRdnxp4h16TZTM5iksk5Je
         QDA/9D6wMXNbdHlaYAqnaFWm88Tnux0GCl8dLsJq/jd/CdZNpQRZmhUS1vudhDyahWIe
         GqHiOOIkTG6tRHNHs4ms7saYsrKDnnrDpFDpytPag9ogYjtFvmr58XK34z8AB8bx8IPM
         2mz1btXZLEv8cLmPOx8zu8aYzGi65qPNbT97e3VPh5jEZZo4UW3GMegLN43bMTblYD9N
         AQZw==
X-Forwarded-Encrypted: i=1; AJvYcCXbx5ti75dHZXNpVl0HTqACH7dydY1c7j12w/aeonCSLGdmKr9tjDV+Zp8zjbvhNWzpnO5IxgTtiDzS@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqTjQ1fPN7CFWnZpqTp2Ezh2GD9BhieD/DrO0+q4kxtXVmTjL
	j2uvUSV2keRk3xav9sjikGVAJopqYn2GdJS7lUuLMBb1Shitgk4FYOEZQ79s71s=
X-Gm-Gg: ASbGncs7uFf/vaSohPAYl3t59Pmhm9tD1DtHu5FpvQj1Z/yVI8n1rDf8e+KXobFFZgL
	aMNMRj0Sl2B6lXy3rzyDvI0fFMNe7xntN0E3ByBN/di3Ru11sR/p1t3MUZZEXgp3akamjEsjEzG
	dez7gfxvzH/nVb1esh1tRAt5+OhSwj6+S1TAvPE3dO7P3j8QnWX1IjBP1fUSdmS9svAdtENs3SR
	5qI3v61OQX05o39B97izrnnzo+hAYG2fq9XDbvt0q1f4nqFZo28PP02jy8ILrhLEoH1p5o2MKTx
	YTjzYMywMxGmHI0GAN0AHROvQC+lBKRJZxnWgECd7oZWnYS3/CTkcnQ=
X-Google-Smtp-Source: AGHT+IFBoL5K522A7AuoflUF+1XhMG9n3ItwKCGI8JCLC5Il05/77VAGdvXbN30wro/dkD3TCaY0yg==
X-Received: by 2002:a05:600c:4e8d:b0:439:4a1f:cf85 with SMTP id 5b1f17b1804b1-439580e532amr12252835e9.0.1739321695252;
        Tue, 11 Feb 2025 16:54:55 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06ae8asm3736345e9.21.2025.02.11.16.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 16:54:54 -0800 (PST)
Message-ID: <2299c94f-aa46-47b5-bd25-9436a8fbd619@citrix.com>
Date: Wed, 12 Feb 2025 00:54:52 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] x86/cpu/intel: Fix page copy performance for
 extended Families
To: Dave Hansen <dave.hansen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>,
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
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <b9c21518-54fc-4907-8fc3-d492a3f33bdf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2025 8:53 pm, Dave Hansen wrote:
> On 2/11/25 11:43, Sohil Mehta wrote:
>> +	/*
>> +	 * Modern CPUs are generally expected to have a sane fast string
>> +	 * implementation. However, the BIOS may disable it on certain CPUs
>> +	 * via the architectural FAST_STRING bit.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_X86_64) && (c->x86 == 6 || c->x86 > 15))
>> +		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
> I'm not sure the BIOS comment is helpful here.
>
> Also, at this point, let's just make the check >=6 (or the >=PPRO
> equivalent).
>
> It will only matter if *all* of these are true:
> 1. Someone has a 64-bit capable P4 that powers on
> 2. They're running a 64-bit mainline kernel
> 3. String copy is *actually* slower than the alternative
> 4. They are performance sensitive enough to notice
>
> We don't even know the answer to #3 for sure. Let's just say what we're
> doing in a comment:
>
> 	/* Assume that any 64-bit CPU has a good implementation */

If you're going to override the BIOS setting, then you need to
explicitly set MSR_MISC_ENABLE.FAST_STRINGS.

Otherwise you're claiming to Linux that REP is good even when hardware
is prohibited from using optimisations.

~Andrew


