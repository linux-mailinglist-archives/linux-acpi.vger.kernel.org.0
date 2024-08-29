Return-Path: <linux-acpi+bounces-7964-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3229649A7
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 17:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BBE1C21D39
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1964A1AD9D9;
	Thu, 29 Aug 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h4B65G2B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE72168DA
	for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944624; cv=none; b=Yqwg321+3P1eje72VXeEo2o7+aFBzT/PiNS4iLmOnBWcXoUBB/d4bvdGUxEjfWjjAtac93HykyniiSqwcK93ZlIA02YRGLYqmSj6S5jrzL5oyrYW9AAGoXs4POrkEMoftzaRC/BpXGhM7PRWJlr/7vtdhIXtnaQ6wj+omuNCTIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944624; c=relaxed/simple;
	bh=umXi7o6r5DtojGlpVGMWHvYSw9XLm0jedNBDdM0VDFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOJcFa9jzdsAKnv4AK5mjW3+J5lnUgQBo1u3zpK8ENdsOKS9hjdOGFw4PL/UlqEvOYs/BtORS30GY3Jgbi9P/BhEKMmXEPTWWt3Z++OzK9j5BVhP1z3e37hpZaExv2qTrEMSP/+PxZ4qUSkHN5qP35CalrTZP+oM/7h45lVmHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h4B65G2B; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 17:16:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724944620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9N3q5TzPU80O98ibN8yUzqkgODNoqP8ou42r0Lcqe20=;
	b=h4B65G2BuB3Zsg8/pQAKUSujyH6tDjcEONs0pe2OXp8SLcfsmUrm+7uMUO8PYvFVFHZ5UD
	+VjX54mnygNrhjuabOL3DG71RL1jobQfkb7U4FYGWgN28kYxtI+m2zkRK8h0SN9ctvHZdn
	8MVgaIeGECD/clgsQJY/UflEC6WhFWg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <superm1@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	changwoo@igalia.com, David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 8/8] cpufreq: amd-pstate: Drop some uses of
 cpudata->hw_prefcore
Message-ID: <ZtCQ6Z2LdzHyKdkz@gpd3>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-9-superm1@kernel.org>
 <Zs4G084+7MmzdYjU@BLRRASHENOY1.amd.com>
 <61b96549-2969-4b64-a40d-f91f614ec3ab@amd.com>
 <Zs6w3RktAb6fJrJ+@BLRRASHENOY1.amd.com>
 <Zs7Bwh6T3HCGlR9C@gpd3>
 <Zs866Myvbs0ByoAK@BLRRASHENOY1.amd.com>
 <ZtBvJk4MMCcF2SI8@gpd3>
 <39b25272-83e9-442c-9cc3-185c4e5cd277@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b25272-83e9-442c-9cc3-185c4e5cd277@amd.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 29, 2024 at 08:01:48AM -0500, Mario Limonciello wrote:
> On 8/29/2024 07:52, Andrea Righi wrote:
> > On Wed, Aug 28, 2024 at 08:27:44PM +0530, Gautham R. Shenoy wrote:
> > > Hello Andrea,
> > > 
> > > On Wed, Aug 28, 2024 at 08:20:50AM +0200, Andrea Righi wrote:
> > > > On Wed, Aug 28, 2024 at 10:38:45AM +0530, Gautham R. Shenoy wrote:
> > > > ...
> > > > > > I had thought this was a malfunction in the behavior that it reflected the
> > > > > > current status, not the hardware /capability/.
> > > > > > 
> > > > > > Which one makes more sense for userspace?  In my mind the most likely
> > > > > > consumer of this information would be something a sched_ext based userspace
> > > > > > scheduler.  They would need to know whether the scheduler was using
> > > > > > preferred cores; not whether the hardware supported it.
> > > > > 
> > > > > The commandline parameter currently impacts only the fair sched-class
> > > > > tasks since the preference information gets used only during
> > > > > load-balancing.
> > > > > 
> > > > > IMO, the same should continue with sched-ext, i.e. if the user has
> > > > > explicitly disabled prefcore support via commandline, the no sched-ext
> > > > > scheduler should use the preference information to make task placement
> > > > > decisions. However, I would like to see what the sched-ext folks have
> > > > > to say. Adding some of them to the Cc list.
> > > > 
> > > > IMHO it makes more sense to reflect the real state of prefcore support
> > > > from a "system" perspective, more than a "hardware" perspective, so if
> > > > it's disabled via boot command line it should show disabled.
> > > > 
> > > >  From a user-space scheduler perspective we should be fine either way, as
> > > > long as the ABI is clearly documented, since we also have access to
> > > > /proc/cmdline and we would be able to figure out if the user has
> > > > disabled it via cmdline (however, the preference is still to report the
> > > > actual system status).
> > > 
> > > Thank you for confirming this.
> > > 
> > > > 
> > > > Question: having prefcore enabled affects also the value of
> > > > scaling_max_freq? Like an `lscpu -e`, for example, would show a higher
> > > > max frequency for the specific preferred cores? (this is another useful
> > > > information from a sched_ext scheduler perspective).
> > > 
> > > Since the scaling_max_freq is computed based on the boost-numerator,
> > > at least from this patchset, the numerator would be the same across
> > > all kinds of cores, and thus the scaling_max_freq reported will be the
> > > same across all the cores.
> > 
> > I see, so IIUC from user-space the most reliable way to detect the
> > fastest cores is to check amd_pstate_highest_perf / amd_pstate_max_freq,
> > right? I'm trying to figure out a way to abstract and generalize the
> > concept of "fast cores" in sched_ext.
> 
> Right now the best way to do this is to look at the
> amd_pstate_precore_ranking file.

Ok.

> 
> In this series there has been some discussion of dropping it though in favor
> of looking at the highest perf file.  I don't believe we're concluded one
> way or another on it yet though.
> 
> > 
> > Also, is this something that has changed recently? I see this on an
> > AMD Ryzen Threadripper PRO 7975WX 32-Cores running a 6.8 kernel:
> > 
> > $ uname -r
> > 6.8.0-40-generic
> 
> You're missing the preferred core patches on this kernel.  They landed in
> 6.9, it's better to upgrade to 6.10.y or 6.11-rc.

So, if I move to 6.9+ I should see the same max frequency across all the
CPUs and I can use amd_pstate_precore_ranking to determine the subset of
fast cores.

Thanks for the clarification.

-Andrea

