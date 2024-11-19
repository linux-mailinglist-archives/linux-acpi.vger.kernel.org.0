Return-Path: <linux-acpi+bounces-9661-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3029D2973
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 16:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD95B28105
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 15:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B8E1D1305;
	Tue, 19 Nov 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8vjuEEG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97251CDFC9;
	Tue, 19 Nov 2024 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028934; cv=none; b=PVYqxQomsv4RLHnTLwcB4ux+Oqt+qJv75RPjAHDVsLOQPpoX+auKh3js01ny4i0qx8kFURyrOHVztvHbencV6q5Y1KngIpwG3eXSJjBcvQjspXAsEyflyIn2pjcW80enmUtMutaCksV7WEy8tDgqIUHyiUCCib4L1fgoFdneW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028934; c=relaxed/simple;
	bh=6B9Y5YBIqcbrEZKrGl78kfe61LRlH2akECpY+g52GqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGgLKaT0iI8+/9Fcsbu8tdRWG5UWvlFzn4xDPujTahT2Usi/2RtUfcDPyTWTSwpiY6SzUp7u7mwODJf+rx3psHnz5uheU1ci1UWS55iOwsorzaZUG/BKAu8fTrJv2AHfNI762tKAA28OMOJ3/7327v2xJe17vmz6Nsk8urxi/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8vjuEEG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732028933; x=1763564933;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6B9Y5YBIqcbrEZKrGl78kfe61LRlH2akECpY+g52GqM=;
  b=d8vjuEEGgxdEH5Y7yWRInpK8Je518IrSdzletGJUER+2U/ZLnyvw4q5X
   6HvDqdlSt4sgQaCIlJS3nsGAvzxYroAlFU8SK5lkfGD26RzQEYw5JNpOk
   s/olF1FtERCmUvzUjQXWnnM8du5s6ez7+n0BotoxLEST12JH8ZvqgoVLm
   GcA4Fqydw9DMGYhDoOFWYSsqL6l729Kvj4OXPMpbJht+QSBSJqNWl/YEJ
   WfUY2AExrnvWhx87W4QKUzJbkt0Z3QOB+Ct8xp1T02qNbW27RllXs+d4f
   08POsOCKxHXmiDCgmqmKackEv0DWR6p/wGYnQ2VRwf7BfvZD7qYK5Jk9z
   Q==;
X-CSE-ConnectionGUID: OJwDUytQQWaQsuvQSOxP1w==
X-CSE-MsgGUID: eVh9dsYRSHSCfOPy8IcpzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="34896535"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="34896535"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:08:52 -0800
X-CSE-ConnectionGUID: SUf8VSU7RZ6VmpjD2h62ug==
X-CSE-MsgGUID: YmzwbAuUQPK+7eN8aJSKpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="112881344"
Received: from dmusso-mobl1.amr.corp.intel.com (HELO [10.125.178.57]) ([10.125.178.57])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:08:51 -0800
Message-ID: <0147ea1a-3595-47ae-a9d5-5625b267b7a8@linux.intel.com>
Date: Tue, 19 Nov 2024 07:08:46 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in
 acpi_os_sleep().
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, anna-maria@linutronix.de,
 tglx@linutronix.de, peterz@infradead.org, frederic@kernel.org,
 corbet@lwn.net, akpm@linux-foundation.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Len Brown <len.brown@intel.com>, Todd Brandt <todd.e.brandt@intel.com>
References: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
 <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
 <90818e23-0bdb-40ad-b2f9-5117c7d8045e@linux.intel.com>
 <CAJZ5v0gxNEQx5Q+KXs-AMn=bt7GD=jU-TseMHUc5mHp0tKSBtA@mail.gmail.com>
Content-Language: en-US
From: Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <CAJZ5v0gxNEQx5Q+KXs-AMn=bt7GD=jU-TseMHUc5mHp0tKSBtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/19/2024 5:42 AM, Rafael J. Wysocki wrote:
> On Mon, Nov 18, 2024 at 3:35 PM Arjan van de Ven <arjan@linux.intel.com> wrote:
>>
>>> And the argument seems to be that it is better to always use more
>>> resources in a given path (ACPI sleep in this particular case) than to
>>> be somewhat inaccurate which is visible in some cases.
>>>
>>> This would mean that hrtimers should always be used everywhere, but they aren't.
>>
>> more or less rule of thumb is that regular timers are optimized for not firing case
>> (e.g. timeouts that get deleted when the actual event happens) while hrtimers
>> are optimized for the case where the timer is expected to fire.
> 
> I've heard that, which makes me wonder why msleep() is still there.
> 
> One thing that's rarely mentioned is that programming a timer in HW
> actually takes time, so if it is done too often, it hurts performance
> through latency (even if this is the TSC deadline timer).

yup and this is why you want to group events together "somewhat", and which is why
we have slack, to allow that to happen

> 
>> (I'm with you on the slack argument, some amount of slack, even if it is only a usec or two,
>> is very helpful)
> 
> Thanks!


