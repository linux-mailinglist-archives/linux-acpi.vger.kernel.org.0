Return-Path: <linux-acpi+bounces-11071-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8ACA3181A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 22:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C953A5E9A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 21:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B22676F4;
	Tue, 11 Feb 2025 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZInSFJt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49862676D2;
	Tue, 11 Feb 2025 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310316; cv=none; b=ef1zXD/UCRROTMYWXCqHeJDJC/qpL7umR8JTzuNFpBLAZ7xDzwbCYAf+DG0GmKkjCSg80eVrKBjCpV8Kn3XGsDi+enD5atYnrJqYDAXtwMnAdiyKEYFAsziCrYb3WBhKORDjhnOgIRQn9eRWhC731IzN5Gj4BhGMvR7wqwZlQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310316; c=relaxed/simple;
	bh=z7yrne3lH+j+1s6AtvmZ4Bzg6adoesjnw/4Ul78d4yE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSza2OYtv63CvdL9GpKlSkr8JpIjZD+LtskvKD6fUevIxf076t5uZXUd6SxKg58mzVrFkIiI2+0BJyhdAVUjtMpslrckLg8BhZqQbDXh7+EwQ9jnavUGtOvkI/P8Dbk9upn1GQFfDSSCWFWL5onsgiHZXKoptg3PpEpahz6xPqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZInSFJt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso15539415e9.0;
        Tue, 11 Feb 2025 13:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739310313; x=1739915113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9QVqFb0F4vJH3S/5y/Imik4nUJo70kordZ2BPM5ORk=;
        b=jZInSFJtaTuyMpE43bC0DURFwGq+En4CCvOk3ViVbDZqzYLUW9n7IAiJfCMxvAJeMn
         MSwjsWX0KlxsF25zFxxMCj4jce3Wemi5XjO5tIIBlqBsEtfkdREFyUIontiDTmYhcESR
         Jy/6FwBQqZAtnQmGu3t6LqxtCZtrtryYrjsIwQ4m03iJKfxiDgPL/RFDhO0cfXoIWcEP
         9qv3oWpHVdIKmwl51nicPWglol81kgG7FYSxFrrHG46hm2Dt8kK+PG8hBrNPdRfPBg2x
         lhWne//+6eT66H9wVPEXojaO8jcNCTZ67c0Vdy0t0M18j3PdXQ8jVDDTgOTIn2BxX/zX
         GVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739310313; x=1739915113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9QVqFb0F4vJH3S/5y/Imik4nUJo70kordZ2BPM5ORk=;
        b=YSrJ7eO1xi2OmnpwMto16uFkFLDzl9Uwu81O+guNScJOsJMcSTm03MdFi81Trwm9Oi
         hjaCChOc94N0hY1aMi3K3gowbPyuSVznVkVNvZp91az7TighqAHb/IxKwRv6u7bzKf2T
         KFcPmXuLUq9kxT279h3SQo5sbZ21DYOxx77zqtzoEgkgGDMdZT1A/8l4LGCHt6TLGz3j
         Oem9xeJRJ6dTt/UVSIjM9FAlrDOWJPMQPXXSjc4YRkUDFst/jsk3W2Zv90/UlR4D4eVq
         LlxNStEXgPCXqXdRIxVxmRqoc8yqZoZPvn/mUTl6GdZIInJ5FwNjSFJNGYHlRwMyd/J1
         zUfA==
X-Forwarded-Encrypted: i=1; AJvYcCUCvlbfaVzTN6hOqyz/mImk7WwYFnxToDmUfeAJ7bt8mqrm0nDhtyfEGrnTRBTh5JptvY9v1Sj0f+I=@vger.kernel.org, AJvYcCUORwNvlgqlc41DGZTDOB8+BboM+5nB63X7SEh164FtlJ84grO0+RQO+eh9YHifUoRx6llMN7t4NKYQa2UtHnwCWw==@vger.kernel.org, AJvYcCVOyHa+oovZbf7sktM0Z/tdCCDr8jHJ4LAha98RsRBYfGSvtC1CgFNhjN0jr1zJNVzBKoGS1qopkBxO5SE=@vger.kernel.org, AJvYcCVykrv6NTqpDmVKnZTXgLjVhO6nvkHbXLwdZCvDXrifiZeUi4gsFraKHM0Rmp2625j0qFASEPglYYZ82Bf9@vger.kernel.org, AJvYcCXsIn6ZVG8G1sJMWUIVFc8LymCVv4ns0LjpmbIZBZQuMujlY/IVIZokBSHzZD+MPiw5Vu/kkL9KVnxp@vger.kernel.org
X-Gm-Message-State: AOJu0YyOwpJFeMik+opMZTLGyABjJCO7dMNCKToW532VOmzq5NpO2KTm
	GIv62qu+HgKNAo4cKY5sLfTowse0MQd6WEyywZ9BMO0kSKU82hWR
X-Gm-Gg: ASbGncuzasa/PbeCVC7EFPsO0p5KNhDJZzvotGhXQc8XGcql4td7DdMm4LiHSLba77s
	HYFJa9NvFfRlz7dNh/KXJf5vabJIiM9uh47I2I+fKXxffK6kp4ST4+mTpnt7w58LYV62W3UtEPm
	pGkZowZHgEDnUYqmtbcW3fM7nDaHp499KsYMQ3tLfkSusmRwo9MrhGWVw/XlG+bLuDelciszIP+
	ATsJ0KexlFDwBo65wZ4kdMHM+SyBSwXBg8XaZj4w5C9IXvMZvhz0kbq35TeNapmwhB+9Kmu+REt
	yLit5H1N0OBrwTt3v5OrQ3cPKB5vR3w+KLvsUOHOoj314IWkMhI48w==
X-Google-Smtp-Source: AGHT+IEjFMRaO0UZ6wft/wxo/+IRAbLWtbO1fwLdZMCQbltj99k8Ofj68ppzmanMrEJJGKF4/cn8cw==
X-Received: by 2002:a05:600c:1d1b:b0:434:a468:4a57 with SMTP id 5b1f17b1804b1-439581bfdc2mr6022405e9.26.1739310312538;
        Tue, 11 Feb 2025 13:45:12 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395076a2a2sm14643765e9.3.2025.02.11.13.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 13:45:11 -0800 (PST)
Date: Tue, 11 Feb 2025 21:45:09 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org, Dave Hansen
 <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Andy
 Lutomirski <luto@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>, Andrew
 Cooper <andrew.cooper3@citrix.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 04/17] x86/cpu/intel: Fix the movsl alignment
 preference for extended Families
Message-ID: <20250211214509.281dc3be@pumpkin>
In-Reply-To: <5b954a96-1034-467d-a5dc-3d3f7bc112a1@intel.com>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
	<20250211194407.2577252-5-sohil.mehta@intel.com>
	<5b954a96-1034-467d-a5dc-3d3f7bc112a1@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 12:26:48 -0800
Dave Hansen <dave.hansen@intel.com> wrote:

> We should really rename intel_workarounds() to make it more clear that
> it's 32-bit only. But I digress...
> 
> On 2/11/25 11:43, Sohil Mehta wrote:
> > The alignment preference for 32-bit movsl based bulk memory move has
> > been 8-byte for a long time. However this preference is only set for
> > Family 6 and 15 processors.
> > 
> > Extend the preference to upcoming Family numbers 18 and 19 to maintain
> > legacy behavior. Also, use a VFM based check instead of switching based
> > on Family numbers. Refresh the comment to reflect the new check.  
> "Legacy behavior" is not important here. If anyone is running 32-bit
> kernel binaries on their brand new CPUs they (as far as I know) have a
> few screws loose. They don't care about performance or security and we
> shouldn't care _for_ them.
> 
> If the code yielded the "wrong" movsl_mask.mask for 18/19, it wouldn't
> matter one bit.
> 
> The thing that _does_ matter is someone auditing to figure out whether
> the code comprehends families>15 or whether it would break in horrible
> ways. The new check is shorter and it's more obvious that it will work
> forever.

For any Intel non-atom processors since the Ivy bridge the only alignment
that makes real difference is aligning the destination to a 32 byte boundary.
That does make it twice as fast (32 bytes/clock rather than 16).
The source alignment never matters.
(I've got access to one of the later 64-bit 8 core atoms - but can't
remember how it behaves.)

For short (IRC 1..32) byte transfers the cost is constant.
The cost depends on the cpu, Ivy bridge is something like 40 clocks.
Lower for later cpu.
(Unlike the P4 where the overhead is some 163 clocks.)
It also makes no difference whether you do 'rep movsb' or 'rep movsq'.

For any of those cpu I'm not sure it is ever worth using anything
other than 'rep movsb' unless the length is known to be very short,
likely a multiply of 4/8 and preferably constant.
Doing a function call and a one or two mispredictable branches will
soon eat into the overhead. Not to mention displacing code from the I-cache.
Unless you are micro-optimising a very hot path it really isn't worth
doing anything else.

OTOH even some recent AMD cpu are reported not to have FRSM and will
execute 'rep movsb' slowly.

I did 'discover' that code at the weekend, just the memory load to
get the mask is going to slow things down.
Running a benchmark test it'll be in cache and the branch predictor
will remember what you are doing.
Come in 'cold cache' and (IIRC) Intel cpu have a 50% chance of predicting
a branch taken (no static predict - eg backward taken).

Even for normal memory accesses I've not seen any significant slowdown
for misaligned memory accesses.
Ones that cross a cache line might end up being 2 uops, but the cpu
can do two reads/clock (with a following wind) and it is hard to write
a code loop that gets close to sustaining that.

I'll have tested the IP checksum (adc loop) code with misaligned buffers.
I don't even remember a significant slowdown for the version that does
three memory reads every two clocks (which seems to be the limit).

I actually suspect that any copies that matter are aligned so the cost
of the check far outways the benefit across all the calls.

One optimisation that seems to be absent is that if you are doing a
register copy loop, then any trailing bytes can be copied by doing
a misaligned copy of the last word (and I mean word, not 16 bits)
of the buffer - copying a few bytes twice.

	David



