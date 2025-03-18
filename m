Return-Path: <linux-acpi+bounces-12338-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06393A67DDF
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 21:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E330119C14CC
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 20:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109D42139C9;
	Tue, 18 Mar 2025 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP/jvTlj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579F21149C;
	Tue, 18 Mar 2025 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328829; cv=none; b=JxAZEv8P5dSYF8WgQXDbB2gEEWFMVBbIP/mbrY2N7vuxaOnvC8NKuVuqNV2e6KZbn4SZlBVQT7xHkiI4p7bIvHkwaItnQimpoE+4qdgbC2cLb+aQvMVxhEKy/eZPZfbphxZt3ZXFS3sINBlVZNP79L1fg/mGUd63FyuePcJu3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328829; c=relaxed/simple;
	bh=WA+MrRBhQ2uopgtWZQB5sYYIW4Ahn0VawcQ00Sty8I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asBNZZjS4nPbf15uH8sUvKNqSsKnVp6Eb0tWvmSprv+YdK69e57UNWmkven2I7qmh7Up5aYWLzkRPEPasK0q1BSCcmsunIfBCsMjb6PA8uL5zjXaZmXDb+x4CgVzci0FNGGa8AMYf+Q5A56Ggr2bL5ujknJeGfN/G5jj7SxBbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP/jvTlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD98FC4CEEE;
	Tue, 18 Mar 2025 20:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742328828;
	bh=WA+MrRBhQ2uopgtWZQB5sYYIW4Ahn0VawcQ00Sty8I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kP/jvTljT7Z+rAV1WPj90DHOSTIXuWQ+SHBJepMzIIJTplpxFI8lJfewXNcSvKlqP
	 f4WjXFtXoKWshkNrD6t7JWJCBM6fMd6Xm3GX6NbJ+QvaBNwBmAm/Z28LD8g73pM5UU
	 8yQBDNAmQhuFVwki9DtAiVxRF9PDEBE5p2vmz8quLehJyCt22ebvWOiEXIhTfl6n5Q
	 JvQLnCpl4WVmDXLj6V2alD/7atN0RlahQbURzS6mbZ8sEriOtQdlzwPstJmZg3qvTk
	 lpJf1L6B2NciUBkC6IFJL+pez4GFo515C1usflmLbr6AVsZ3xtmay7YsCbyqD1Ncel
	 29fvcnZ+LYhxw==
Date: Tue, 18 Mar 2025 21:13:39 +0100
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
Message-ID: <Z9nT8-7dPahdKgSQ@gmail.com>
References: <20250219184133.816753-1-sohil.mehta@intel.com>
 <df1b95d7-c953-4757-b742-3072f65539f7@intel.com>
 <Z9m9B7BmoItsfjiM@gmail.com>
 <6758e958-a4d7-48b8-83ff-4bcb98f87340@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6758e958-a4d7-48b8-83ff-4bcb98f87340@intel.com>


* Sohil Mehta <sohil.mehta@intel.com> wrote:

> > I've applied the first 13 patches to tip:x86/cpu to help move this 
> > along. I fixed a handful of typos, but haven't noticed any 
> > functional problems so far, so unless there's problems in -next 
> > this might be OK for the merge window. (Famous last words.)
> > 
> 
> Many thanks.. Fingers crossed!

You are welcome, and please send the remaining patches in a day or so, 
on top of tip:x86/cpu.

Thanks,

	Ingo

