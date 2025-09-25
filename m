Return-Path: <linux-acpi+bounces-17313-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7B3BA0A2D
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 18:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B126210BB
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 16:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FC1306D37;
	Thu, 25 Sep 2025 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1n3Ck62"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C382DE710;
	Thu, 25 Sep 2025 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818183; cv=none; b=TNAT9nRgUvKqj7z9/B1D7oxYfZEckxvhMAYlF3mNh3fqUSsQpDfF5xqpJU58v5uu2UAsZerkpvGxQbQ3rSKpLMV7MTVVINKb0jXIVKUQZiafmEsMumaO1SiB4dI2mGGPqvR4Pjd6uNUy3ET1Xkr6G3roTqkfpP+Mf9jgzTzFeWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818183; c=relaxed/simple;
	bh=AV8X/rCVJ3KDbq2mpxzIlUzaF6Ly7gRtyvBAZCpEKK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfYkf9uqsllfgqh8enpR5um8AghNE2PGQnCqJZdklpX7qucPBTmGI5NGDSLfu3vn89oTkQkMB/YRm8DuQp2x4GOelLynTkiuYrebRdGEvfnb74QNWO20j5BWb83PDUdlUwbC7kxktjrc/t4KNhrcX80Zs7BvRgqLpgMNkxVLbJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1n3Ck62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A15C4CEF0;
	Thu, 25 Sep 2025 16:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758818182;
	bh=AV8X/rCVJ3KDbq2mpxzIlUzaF6Ly7gRtyvBAZCpEKK0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o1n3Ck62FMJsfoNqVSJ3TGjE4r/Wg4cBxZtcPO1FNLOMLvy1cnK38rg5tKjBfns7B
	 v7PJsiBhvzR2EmzNIyWtll/lq2cG65csHYuatRCql9gW54m5/K5d0Kz08xnP09M9if
	 yATRz4hi9Gq936AKxHK6Pl+Hg0cNhWTOIx52VV+Ecc6KNn+EGrcW6zBvRXn4nVwt6A
	 QgKb3MBI7j+N3eoch9tvtI1c2spoHzv6tSHpEgwJQZNtnNpBF138HirCj6P6jwAK+E
	 zeE/KpOtRl4Ji0qxicWnRwMBDyDd2K2lg7gSp8ZK4ykD7TTOC+XrKPB2j6hAMRYdsr
	 5wHTWP4W4qDmA==
Message-ID: <4067f542-d0d1-4055-b5ee-a468dd7eb559@kernel.org>
Date: Thu, 25 Sep 2025 11:36:20 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] cpufreq: Drop unused symbol CPUFREQ_ETERNAL
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Prashanth Prakash <pprakash@codeaurora.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
 <9533136.CDJkKcVGEf@rafael.j.wysocki>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <9533136.CDJkKcVGEf@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/25/2025 10:47 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop CPUFREQ_ETERNAL that has no users any more along with all
> references to it in the documentation.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   Documentation/admin-guide/pm/cpufreq.rst                  |    4 ----
>   Documentation/cpu-freq/cpu-drivers.rst                    |    3 +--
>   Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst |    3 +--
>   Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst |    3 +--
>   include/linux/cpufreq.h                                   |    5 -----
>   5 files changed, 3 insertions(+), 15 deletions(-)
> 
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -274,10 +274,6 @@ are the following:
>   	The time it takes to switch the CPUs belonging to this policy from one
>   	P-state to another, in nanoseconds.
>   
> -	If unknown or if known to be so high that the scaling driver does not
> -	work with the `ondemand`_ governor, -1 (:c:macro:`CPUFREQ_ETERNAL`)
> -	will be returned by reads from this attribute.
> -
>   ``related_cpus``
>   	List of all (online and offline) CPUs belonging to this policy.
>   
> --- a/Documentation/cpu-freq/cpu-drivers.rst
> +++ b/Documentation/cpu-freq/cpu-drivers.rst
> @@ -109,8 +109,7 @@ Then, the driver must fill in the follow
>   +-----------------------------------+--------------------------------------+
>   |policy->cpuinfo.transition_latency | the time it takes on this CPU to	   |
>   |				    | switch between two frequencies in	   |
> -|				    | nanoseconds (if appropriate, else	   |
> -|				    | specify CPUFREQ_ETERNAL)		   |
> +|				    | nanoseconds                          |
>   +-----------------------------------+--------------------------------------+
>   |policy->cur			    | The current operating frequency of   |
>   |				    | this CPU (if appropriate)		   |
> --- a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
> +++ b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
> @@ -112,8 +112,7 @@ CPUfreq核心层注册一个cpufreq_driv
>   |                                   |                                      |
>   +-----------------------------------+--------------------------------------+
>   |policy->cpuinfo.transition_latency | CPU在两个频率之间切换所需的时间，以  |
> -|                                   | 纳秒为单位（如不适用，设定为         |
> -|                                   | CPUFREQ_ETERNAL）                    |
> +|                                   | 纳秒为单位                    |
>   |                                   |                                      |
>   +-----------------------------------+--------------------------------------+
>   |policy->cur                        | 该CPU当前的工作频率(如适用)          |
> --- a/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
> +++ b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
> @@ -112,8 +112,7 @@ CPUfreq核心層註冊一個cpufreq_driv
>   |                                   |                                      |
>   +-----------------------------------+--------------------------------------+
>   |policy->cpuinfo.transition_latency | CPU在兩個頻率之間切換所需的時間，以  |
> -|                                   | 納秒爲單位（如不適用，設定爲         |
> -|                                   | CPUFREQ_ETERNAL）                    |
> +|                                   | 納秒爲單位                    |
>   |                                   |                                      |
>   +-----------------------------------+--------------------------------------+
>   |policy->cur                        | 該CPU當前的工作頻率(如適用)          |
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -26,13 +26,8 @@
>    *********************************************************************/
>   /*
>    * Frequency values here are CPU kHz
> - *
> - * Maximum transition latency is in nanoseconds - if it's unknown,
> - * CPUFREQ_ETERNAL shall be used.
>    */
>   
> -#define CPUFREQ_ETERNAL			(-1)
> -
>   #define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS	NSEC_PER_MSEC
>   
>   #define CPUFREQ_NAME_LEN		16
> 
> 
> 


