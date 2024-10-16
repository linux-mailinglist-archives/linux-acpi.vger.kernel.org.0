Return-Path: <linux-acpi+bounces-8827-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 857AC9A1594
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 00:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD44B24B4F
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 22:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F041D2B37;
	Wed, 16 Oct 2024 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQIGWwVH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4818732A;
	Wed, 16 Oct 2024 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116392; cv=none; b=tqhIBNhXQKB7suJdLD6/mZcnuFvofcrSSUExAiR0/WXX3y3Nlk0DLVrZ7b5+V+hXz8jZWdprOmxdDyvovJxMzxXKb8lrEVYKMDeUE9hoFgSf3nRWDHygm23PbOHctqTMJgecDwyrU8PSbetJ1LsvlKV49ohvyV8clv4k4FJ+aAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116392; c=relaxed/simple;
	bh=cTikCrJRkFtCjhHwhx6LyLuQLGV4jmsiZjyXwDNhQWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEC70IknFzOkUw+e259Q4Wo8+IFS3nqTBuXTkN7t+7y6Wc3JJPHbx3MPAGmgjkqhKtEoRShOaHhDVpPUDRu3S0EyxVUK7v+Sb/UHBlzvN6VeexjH2xWqCdNkCMLh0JRQjq9nIVWzZ+pVopCaVqny+J0jyXPT15WUIicumx0nQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQIGWwVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF68C4CEC5;
	Wed, 16 Oct 2024 22:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729116392;
	bh=cTikCrJRkFtCjhHwhx6LyLuQLGV4jmsiZjyXwDNhQWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jQIGWwVH1IZiBBLa0iLI4camPSRsrBMjnrS9rg1RhcZgxG5UV9Kus0g3n9L0EoZNg
	 zM+/rlC6ZApKHjyrDCwNDA4/EE0Zj5Qbq/f09QUxbJRlMQYxPbLHGIPMOMVirXD/P0
	 QsrUikSUKWb2ahOocG5PyPaeD41AmNfAh036Q8ihTtUVLxL236sPnfYbMB4s7KyCe/
	 L0xYDzykBagR99dSrrkH4JawfAfmIq+z691Fqtt5nvPo67tt28RvF73n4t8xqDK1uB
	 fYdaFFdfMl1vZPKwXFOwsljj6V3ezuArnuEkzLtM251Q/DH0QrvYQMhgndzKkzF4lJ
	 lOv1zIFIqprNQ==
Message-ID: <cb7fad8c-f288-410e-b380-1204b26930ad@kernel.org>
Date: Wed, 16 Oct 2024 17:06:29 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] Adjustments for preferred core detection
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: bp@alien8.de, gautham.shenoy@amd.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
 x86@kernel.org
References: <3b2195074d7c8fa20f93f1dc6fc25afe5dbb2909.camel@intelfx.name>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <3b2195074d7c8fa20f93f1dc6fc25afe5dbb2909.camel@intelfx.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/2024 17:03, Ivan Shapovalov wrote:
> Hi,
> 
> On my desktop Zen 3 (Vermeer) system applying this series yields a new
> warning message on each boot:
> 
>> Oct 16 06:20:41 kernel: Could not retrieve highest performance (-19)
> 
> As I see it, this is one of the pr_debug()s newly promoted to warnings.
> Is there anything I can provide to help fix this?
> 

Open up a kernel Bugzilla and attach a full dmesg and all details.  You 
can CC me directly to it and I'll look into it.

Also ideally; can you please check 6.12-rc3.

> Just for completeness:
> 
> ```
> $ cat-files /sys/devices/system/cpu/cpufreq/policy0/*
> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus                             0
> /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_highest_perf                   231
> /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore                    enabled
> /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq          1746000
> /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq                       5274000
> /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking               231
> /sys/devices/system/cpu/cpufreq/policy0/boost                                     1
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq                          5274000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq                          550000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency                0
> /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences  default performance balance_performance balance_power power
> /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference             balance_performance
> /sys/devices/system/cpu/cpufreq/policy0/related_cpus                              0
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors               performance powersave
> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq                          1746000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver                            amd-pstate-epp
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor                          powersave
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq                          5274000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq                          1746000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed                          <unsupported>
> 
> $ grep -w cppc /proc/cpuinfo
> <empty>
> ```
> 
> Thanks,


