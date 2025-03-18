Return-Path: <linux-acpi+bounces-12333-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DA5A67C1A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 19:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC7919C060A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 18:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16972144B1;
	Tue, 18 Mar 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGIlcnf0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486A2144A6;
	Tue, 18 Mar 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322961; cv=none; b=Ud7ttgJe4zIEwJo74npM0GZ9ijKpZRQ6/JpsU7yq4qH3IoBIujrser5tkxrzLS9NyOWsObV3PeudZdZ6EEuuMFJvRqNYrfrJyzpe9GDnd7l0VwWzIxXMEHXJGbIiF5ItAGU6OuCqw+aLGeJsHkS3UDw2M6ndG4jtdtsEl3N8i1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322961; c=relaxed/simple;
	bh=pwoLy758tJWHhrF4rsg554mdoSJp4CwDBOkScT2rZfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coC6mJEWlkOCblyczmitxEsIwhYYnkQ1C34MXAUciwEDP5mxTNbpBb06fAnwO8h/xFepIH0m0MuLAHR23rgmKxwTetlXu5K3dOWrBFBLnzS33HiPPTbQDyaFaGMZo5Ef4UoFE+8uktIjyqHXP+bKEGkpkQV9x4RRw42GYqrtlNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGIlcnf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50958C4CEEE;
	Tue, 18 Mar 2025 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742322961;
	bh=pwoLy758tJWHhrF4rsg554mdoSJp4CwDBOkScT2rZfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGIlcnf0XAs7uNt/KYI82slLCMCem5pYXQZ/akHFyMfFVheXjPEFbFWSseIpLOB1Z
	 bFHBoXkOPL1xAWqjK6hLiron4SjTFIY4Km49fPSHxbmnZCyucg+l5URG2zWjZ8WWVn
	 nxEvIIPd1ObqKYKbofcRWZZq6G/vbheZ4sJMy7GZEhik4D/vDGnKlr5iPVbjnaaQmp
	 S6mGJOPfv2hY2Pg2m1Ck7tvIlMqL1+Tf6MJVHsijrmAikXLoUqoLl5Q241NWWOjIgi
	 lo9aaTlk1YoP9tJBldVo19eY3aDzMmnKJvpqgowOnNzOYxmJHOJA0lePpoLWn0H54L
	 5TxtMPErN05Tw==
Date: Tue, 18 Mar 2025 19:35:51 +0100
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
Message-ID: <Z9m9B7BmoItsfjiM@gmail.com>
References: <20250219184133.816753-1-sohil.mehta@intel.com>
 <df1b95d7-c953-4757-b742-3072f65539f7@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df1b95d7-c953-4757-b742-3072f65539f7@intel.com>


* Sohil Mehta <sohil.mehta@intel.com> wrote:

> On 2/19/2025 10:41 AM, Sohil Mehta wrote:
> > ---Summary---
> > Mainstream Intel processors have been using Family 6 for a couple of decades.
> > This series is an audit of all the arch/x86 Intel Family-model checks to get
> > ready for the upcoming Family 18 and 19 models. It also converts the last
> > reamaining Intel x86_model checks to VFM ones.
> > 
> > Patch 1-8 : Include Dave Hansen's Acked-by.
> > Patch 9-15: Almost ready to merge but don't have review tags yet.
> > 
> 
> Is there any additional feedback?

Looks mostly good to me.

> Most patches have review tags now or are simple enough that they might
> not need one. Patch 11 can probably use another look.

LGTM, but I've extended the Cc: list to make more people aware.

(I did the same for some of the other patches that could use extra eyes.)

> Patch 14 is the only one that has a minor change. Seeking additional
> input before spinning another revision.

I've applied the first 13 patches to tip:x86/cpu to help move this 
along. I fixed a handful of typos, but haven't noticed any functional 
problems so far, so unless there's problems in -next this might be OK
for the merge window. (Famous last words.)

Thanks,

	Ingo

