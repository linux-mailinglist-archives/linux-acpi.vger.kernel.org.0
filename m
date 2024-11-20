Return-Path: <linux-acpi+bounces-9708-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60909D4284
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 20:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CAE28482D
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 19:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67FF1BDA8A;
	Wed, 20 Nov 2024 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGXD9diK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891016DEB5;
	Wed, 20 Nov 2024 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130327; cv=none; b=V1/cwDTYHLnO/Fo476EQheg7hOBm1Zo4ESH5RYYrZgAbz3Sh4/QD8Wjsk2W3ttmWp5X7veNgWM8L478IPV0NNJJupgOFsuuJR9IozjYkgLPuH2RkeI7pQxcaKgX78GDVUW0ueUYgxWdV4h6eY99N2bZ+wW3jfS2/Lr6IIV/E3SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130327; c=relaxed/simple;
	bh=Vm11cXeEBMkk6f1oEaCwXIxmjRjWx9DHPNiUZb5lN9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZEet0CEImsl4zfEZSI6zzJC57azJhw0/qEs+p3f0+hDcG4W1vznWVX4piIJ+wlnjkfxUfvv3dr69+IVvMXrjfwOO1vjqGJ5rxkIUhfgVSw983hzBD+wzoeP7tV+Ru3eFWjAQ7klcJJflZlXVy+rSsusMxyEVthAC4xw+s0uUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGXD9diK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732130326; x=1763666326;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vm11cXeEBMkk6f1oEaCwXIxmjRjWx9DHPNiUZb5lN9U=;
  b=gGXD9diK/qScwlClXwE+Bxqdfo7hFyo964bBOLnTCu5FqajbEWX2Wgxw
   U5k2BxV1UjwUhqFGPEhS+fQ0go2Fgl4aZ1I+QsO68UKHhq6aZe5rnG5oz
   pLtwSXL/aWCBVmlEaRGm/EAABpGzTs/xrUroVYxrl2pvknMXpH24JmIEV
   TAq8OGxXIAWRrMLIfxJXQ+76W5BjxJp3s7ff4hqUqUHqmM7EKCNFzdm2U
   cKT39ZB9Urp2EDmMRwX4pJfnlyjh0DBKGhoxW61UNX/O0U2vYeUpNsuGQ
   1/vFYcDyc+WFGVFV9wwX5DG3VvKm/G8ZKZgR72R5zTQB9b/10kThKGiGH
   Q==;
X-CSE-ConnectionGUID: 0xn5ZfVKTbmFoOlNarvxnw==
X-CSE-MsgGUID: feOJ6/bURJC4rb4vlNM+Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="32141174"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="32141174"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:18:46 -0800
X-CSE-ConnectionGUID: t6aaiXxgQmSAl3BUBIoIPw==
X-CSE-MsgGUID: a9SdXz1aS6SoolUqq4WH9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="94967277"
Received: from nathanae-mobl.amr.corp.intel.com (HELO [10.125.50.190]) ([10.125.50.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:18:46 -0800
Message-ID: <593c4be2-c21e-49fa-8bf7-a614c01c8e66@linux.intel.com>
Date: Wed, 20 Nov 2024 11:18:41 -0800
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
 <0147ea1a-3595-47ae-a9d5-5625b267b7a8@linux.intel.com>
 <CAJZ5v0itnn3T4bwiAO3eAoKH4mLFYswcNWBx6JCrK1GFDEy7vg@mail.gmail.com>
 <e0dd2cb8-eea2-443d-bf23-4d225528d33f@linux.intel.com>
 <CAJZ5v0h5=3LMVCa8kSoomNyF9r_7HLmpkH+YhYEO_N7H6-hAGQ@mail.gmail.com>
Content-Language: en-US
From: Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <CAJZ5v0h5=3LMVCa8kSoomNyF9r_7HLmpkH+YhYEO_N7H6-hAGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/2024 10:49 AM, Rafael J. Wysocki wrote:
>>> I thought about something on the order of 199 us, but now I'm thinking
>>> that 50 us would work too.  Less than this - I'm not sure.
>>
>> 50 usec is likely more than enough in practice.
> 
> And would you use the same slack value regardless of the sleep
> duration, or make it somehow depend on the sleep duration?

I don't see why you'd make it dependent on the sleep duration
sure in theory the longer the sleep -- you could pick a fixed percentage

but you're trying to amortize a theoretical timer register write, and a
cpu wakeup. the timer write is fixed cost and not THAT expensive after
some amount of this . the C state wake up --- sure that is more variable
but that is super important for high occurance things (thousands to millions
of times per hour).
If your ACPI sleeps are high occurance on a system I suspect you have way
bigger problems than an occasional extra wakeup

