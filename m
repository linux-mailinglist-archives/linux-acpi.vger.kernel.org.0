Return-Path: <linux-acpi+bounces-7958-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A30996458D
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 14:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6617286712
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 12:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F5B1B3735;
	Thu, 29 Aug 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KbL5VC/u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1019047F
	for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2024 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935983; cv=none; b=JYB8wFobJUEoSC5fr5qhb3XJMDV4bbT0ZaVdwvo8MyMflfy3jdBSqTmzLea/MZYNXJoXJLjD6ur1w/R9VOIV6IyE9rsuYFjcKD1/f9kOXr92eB01gOtt5U2PGcquMj+MIQ8MbmNMcVJE/VY50A1g0vYGrbr8vAAqvgjVDHPD0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935983; c=relaxed/simple;
	bh=2QxECIkMRBg1EHw+Lnb7plNG6unPYTyHh3rJdDSG+GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlMRIt/8SLTTZw13Em6F50l9EPadObCHfd04Jwjy/JOHcGRa4v2MspTszQjQOiThbcO4cSZL+kAGS6VTJPB4w8zoRWMBTx+rz9mkQjTlWVtQwpL/4PiUUCXC4I+WJkneTWpDcV14tx8egXE3jlaotDS02c28xUwIB1kSrrLfaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KbL5VC/u; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 14:52:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724935979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RuangRg+vh3E7dlcXFpSDKUB0oQAYvgNeBuSyw6jcC8=;
	b=KbL5VC/ubgUL7rfAgj+wK9QB3y540bW4/RAh/DzZcSiZQi+81nG6jfiuhRLm1cRZ+TIgzn
	FypUXa3hMUiyV56itV7aaZ9McMEEZotBSckDhdGQBBU0Ar/RSnOi2RLvX2dPG3YffLoqU/
	KR8Dz9w4091deBakaT6Msw7tgH6O8/8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
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
Message-ID: <ZtBvJk4MMCcF2SI8@gpd3>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-9-superm1@kernel.org>
 <Zs4G084+7MmzdYjU@BLRRASHENOY1.amd.com>
 <61b96549-2969-4b64-a40d-f91f614ec3ab@amd.com>
 <Zs6w3RktAb6fJrJ+@BLRRASHENOY1.amd.com>
 <Zs7Bwh6T3HCGlR9C@gpd3>
 <Zs866Myvbs0ByoAK@BLRRASHENOY1.amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs866Myvbs0ByoAK@BLRRASHENOY1.amd.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 28, 2024 at 08:27:44PM +0530, Gautham R. Shenoy wrote:
> Hello Andrea,
> 
> On Wed, Aug 28, 2024 at 08:20:50AM +0200, Andrea Righi wrote:
> > On Wed, Aug 28, 2024 at 10:38:45AM +0530, Gautham R. Shenoy wrote:
> > ...
> > > > I had thought this was a malfunction in the behavior that it reflected the
> > > > current status, not the hardware /capability/.
> > > > 
> > > > Which one makes more sense for userspace?  In my mind the most likely
> > > > consumer of this information would be something a sched_ext based userspace
> > > > scheduler.  They would need to know whether the scheduler was using
> > > > preferred cores; not whether the hardware supported it.
> > > 
> > > The commandline parameter currently impacts only the fair sched-class
> > > tasks since the preference information gets used only during
> > > load-balancing.
> > > 
> > > IMO, the same should continue with sched-ext, i.e. if the user has
> > > explicitly disabled prefcore support via commandline, the no sched-ext
> > > scheduler should use the preference information to make task placement
> > > decisions. However, I would like to see what the sched-ext folks have
> > > to say. Adding some of them to the Cc list.
> > 
> > IMHO it makes more sense to reflect the real state of prefcore support
> > from a "system" perspective, more than a "hardware" perspective, so if
> > it's disabled via boot command line it should show disabled.
> > 
> > From a user-space scheduler perspective we should be fine either way, as
> > long as the ABI is clearly documented, since we also have access to
> > /proc/cmdline and we would be able to figure out if the user has
> > disabled it via cmdline (however, the preference is still to report the
> > actual system status).
> 
> Thank you for confirming this.
> 
> > 
> > Question: having prefcore enabled affects also the value of
> > scaling_max_freq? Like an `lscpu -e`, for example, would show a higher
> > max frequency for the specific preferred cores? (this is another useful
> > information from a sched_ext scheduler perspective).
> 
> Since the scaling_max_freq is computed based on the boost-numerator,
> at least from this patchset, the numerator would be the same across
> all kinds of cores, and thus the scaling_max_freq reported will be the
> same across all the cores.

I see, so IIUC from user-space the most reliable way to detect the
fastest cores is to check amd_pstate_highest_perf / amd_pstate_max_freq,
right? I'm trying to figure out a way to abstract and generalize the
concept of "fast cores" in sched_ext.

Also, is this something that has changed recently? I see this on an
AMD Ryzen Threadripper PRO 7975WX 32-Cores running a 6.8 kernel:

$ uname -r
6.8.0-40-generic

$ grep . /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_max_freq
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu6/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu8/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu9/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu10/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu11/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu12/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu13/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu14/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu15/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu16/cpufreq/cpuinfo_max_freq:6161000
/sys/devices/system/cpu/cpu17/cpufreq/cpuinfo_max_freq:6321000
/sys/devices/system/cpu/cpu18/cpufreq/cpuinfo_max_freq:6001000
/sys/devices/system/cpu/cpu19/cpufreq/cpuinfo_max_freq:6646000
/sys/devices/system/cpu/cpu20/cpufreq/cpuinfo_max_freq:5837000
/sys/devices/system/cpu/cpu21/cpufreq/cpuinfo_max_freq:6482000
/sys/devices/system/cpu/cpu22/cpufreq/cpuinfo_max_freq:5517000
/sys/devices/system/cpu/cpu23/cpufreq/cpuinfo_max_freq:5677000
/sys/devices/system/cpu/cpu24/cpufreq/cpuinfo_max_freq:6966000
/sys/devices/system/cpu/cpu25/cpufreq/cpuinfo_max_freq:7775000
/sys/devices/system/cpu/cpu26/cpufreq/cpuinfo_max_freq:6806000
/sys/devices/system/cpu/cpu27/cpufreq/cpuinfo_max_freq:7775000
/sys/devices/system/cpu/cpu28/cpufreq/cpuinfo_max_freq:7130000
/sys/devices/system/cpu/cpu29/cpufreq/cpuinfo_max_freq:7451000
/sys/devices/system/cpu/cpu30/cpufreq/cpuinfo_max_freq:7290000
/sys/devices/system/cpu/cpu31/cpufreq/cpuinfo_max_freq:7611000
/sys/devices/system/cpu/cpu32/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu33/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu34/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu35/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu36/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu37/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu38/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu39/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu40/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu41/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu42/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu43/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu44/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu45/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu46/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu47/cpufreq/cpuinfo_max_freq:5352000
/sys/devices/system/cpu/cpu48/cpufreq/cpuinfo_max_freq:6161000
/sys/devices/system/cpu/cpu49/cpufreq/cpuinfo_max_freq:6321000
/sys/devices/system/cpu/cpu50/cpufreq/cpuinfo_max_freq:6001000
/sys/devices/system/cpu/cpu51/cpufreq/cpuinfo_max_freq:6646000
/sys/devices/system/cpu/cpu52/cpufreq/cpuinfo_max_freq:5837000
/sys/devices/system/cpu/cpu53/cpufreq/cpuinfo_max_freq:6482000
/sys/devices/system/cpu/cpu54/cpufreq/cpuinfo_max_freq:5517000
/sys/devices/system/cpu/cpu55/cpufreq/cpuinfo_max_freq:5677000
/sys/devices/system/cpu/cpu56/cpufreq/cpuinfo_max_freq:6966000
/sys/devices/system/cpu/cpu57/cpufreq/cpuinfo_max_freq:7775000
/sys/devices/system/cpu/cpu58/cpufreq/cpuinfo_max_freq:6806000
/sys/devices/system/cpu/cpu59/cpufreq/cpuinfo_max_freq:7775000
/sys/devices/system/cpu/cpu60/cpufreq/cpuinfo_max_freq:7130000
/sys/devices/system/cpu/cpu61/cpufreq/cpuinfo_max_freq:7451000
/sys/devices/system/cpu/cpu62/cpufreq/cpuinfo_max_freq:7290000
/sys/devices/system/cpu/cpu63/cpufreq/cpuinfo_max_freq:7611000

Thanks,
-Andrea

