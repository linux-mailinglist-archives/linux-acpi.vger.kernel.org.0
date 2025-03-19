Return-Path: <linux-acpi+bounces-12357-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0110A699B9
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Mar 2025 20:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9938A5B0B
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Mar 2025 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2DD2135D8;
	Wed, 19 Mar 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj1CDZbZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69551DE3A9;
	Wed, 19 Mar 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413603; cv=none; b=KLYy5htWzVLZJ6BOPENIYBmVYbTIwp2hX/K58znxcda9QDVcDfXmxiGFab5hlj5wkQkIMetJXp/zt+Gx6VEKbp0OncDRCLrSfrujPsq/KR9aszMHhCidgNgWDeoEtM8KRlpD7a1ZTlbD1grOWwPvAvP3wGno8I+BxaN+e2WYmGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413603; c=relaxed/simple;
	bh=IVqEgb8BU0DyEdDZvihoAosRm1nskRL3J+Fcr1ksIXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMkMVOEjCfvfxyiMREiWbqrhZV18W8u7W8aLGAdiHJfPNx1uNWI0RjbHvNMg7/iSsv29WK6uuilHkSsC74hASqcPzJwrLPa/1cBc3rBrfmWZycuaOsA0B/VXxLrJ+tvJsePkKaBckzJ3qA1JefJZxYKYfZGElyC+ilj6H9wtAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj1CDZbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819C9C4CEE4;
	Wed, 19 Mar 2025 19:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742413603;
	bh=IVqEgb8BU0DyEdDZvihoAosRm1nskRL3J+Fcr1ksIXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gj1CDZbZrJlURb9cAIa8SHs7GVNPqS147jFeleHHjizSfNH+ZNCbxUzGlJKhKlxAi
	 fmmMxLZJwCP0mqiVB7xznE3RtbAtvoe6MrlCV82nGnL3vyM5bqcBv7IkFWCKtGmgvv
	 FFM0tyXxFL29vofDGhSjAoqQR1Rpui7DTQ87j6D885qvXPm4KrmRyvxRN+SoWGSMl5
	 ZY2HNxTUekKglHNDf5Ksx0HFSlrN0LquyJrblVTmWFbhE3dIi8AQ/tjJpKtt6qZI9S
	 4k+K4tZ+UuRdnO6wDF35kWtrJGecGO7371wvAmgrwqYVaUbJe+sH017C2D8DmckRoj
	 +inaVp36tU2Jw==
Date: Wed, 19 Mar 2025 20:46:33 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v3 00/15] Prepare for new Intel Family numbers
Message-ID: <Z9sfGeRhbsJkQnKP@gmail.com>
References: <20250219184133.816753-1-sohil.mehta@intel.com>
 <df1b95d7-c953-4757-b742-3072f65539f7@intel.com>
 <Z9m9B7BmoItsfjiM@gmail.com>
 <6758e958-a4d7-48b8-83ff-4bcb98f87340@intel.com>
 <Z9nT8-7dPahdKgSQ@gmail.com>
 <b3a6493e-2dc7-4342-ad5f-9c4e91b0d35f@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3a6493e-2dc7-4342-ad5f-9c4e91b0d35f@intel.com>


* Sohil Mehta <sohil.mehta@intel.com> wrote:

> On 3/18/2025 1:13 PM, Ingo Molnar wrote:
> > 
> > * Sohil Mehta <sohil.mehta@intel.com> wrote:
> > 
> >>> I've applied the first 13 patches to tip:x86/cpu to help move this 
> >>> along. I fixed a handful of typos, but haven't noticed any 
> >>> functional problems so far, so unless there's problems in -next 
> >>> this might be OK for the merge window. (Famous last words.)
> >>>
> >>
> >> Many thanks.. Fingers crossed!
> > 
> > You are welcome, and please send the remaining patches in a day or so, 
> > on top of tip:x86/cpu.
> > 
> 
> Sent the v4 series with the couple of leftover patches. When sent, the
> patches were based on tip:x86/cpu, but that seems to have been merged
> into x86/core.

Correct, we had to back out a broken patch, and a rebase of a number of 
patches, including yours, was the cleanest option. It should be the 
same tree content-wise.

> I have verified that patches apply cleanly on updated tip:x86/core as 
> well.

Thank you!

	Ingo

