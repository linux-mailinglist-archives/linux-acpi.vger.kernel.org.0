Return-Path: <linux-acpi+bounces-9705-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AF59D421C
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 19:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682D8B23E5D
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 18:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C914515746E;
	Wed, 20 Nov 2024 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARoDrCjR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5C15624B;
	Wed, 20 Nov 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732127885; cv=none; b=oEscD/wGyZAQtHL5JDOR0EYhVnRi0Ki79GWy/omMuufiTyzdvbWVVBAP4SlfNbSK96dMeFbDIJqDXn0cU7Dt4/vETN7loY5J82VdWKsFOWDv0DT6q+9MsiueeXwSl6Xv4Tz7BBgnLv8/82d30T4gSnMqVy5QYN13WYh/7mIJhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732127885; c=relaxed/simple;
	bh=hGKVfrB+JPEHZ0SCxNgIxIJiUsJ2SLFwlPUcdvwUFgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1lsbwF1yVIdoWGfFAtzIwGYMnC8KenbMAEivCXTI1E7VpuVD2vVvGah2DtuxWyIkWAVLw3JN/kS3rTPAuIUjWOYXofpSiU9j0l3uSpao3Xev6rlvdfCmIt45lX9CIj75/P5ZnFukKy3OAbxrZJDguQXwjlGwiDmNG+Ab+CcOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARoDrCjR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732127884; x=1763663884;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hGKVfrB+JPEHZ0SCxNgIxIJiUsJ2SLFwlPUcdvwUFgk=;
  b=ARoDrCjRIAVXU3Fnn2QMBt4RfdpcngwgD8L+/QHYgTb8c7xFaXQLJBhJ
   CkX7ewtLh1bLHkeHiRPMfTDwHMyKsfTPqIYMf2TCZ05q+OtpacGqqsp38
   1mNKqKNIhKlmgtFq2r9sVw3hn9K+lcLFq2V+aJE+6EPiBG/1vtp1368OR
   mX0dqq5IA46DvGIk/DVLaFbri/SxN/YvFSvE23K1pPpqfHJEAhlfbOESR
   r1Z2+aqn9ul/TT0DOxlTyOTy1tvAfSrgI6O2Fi7m18GdZrqd/xMVCo18C
   PeoM4zaeqM0xQyXoSOvRTGRpKE2RlMppQAk1zn/SN7tjHzxmtPJxPx261
   Q==;
X-CSE-ConnectionGUID: oRMbQKRdTR2ylDnS50t6zA==
X-CSE-MsgGUID: b9mT5zFjTJuhSmu1Dw1c1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="49735943"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="49735943"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 10:38:04 -0800
X-CSE-ConnectionGUID: f3vjDGdLQGCc5avxFkZm/w==
X-CSE-MsgGUID: CLS29EcdQjCDm8oFAy2U7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="113278616"
Received: from nathanae-mobl.amr.corp.intel.com (HELO [10.125.50.190]) ([10.125.50.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 10:38:03 -0800
Message-ID: <e0dd2cb8-eea2-443d-bf23-4d225528d33f@linux.intel.com>
Date: Wed, 20 Nov 2024 10:37:58 -0800
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
Content-Language: en-US
From: Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <CAJZ5v0itnn3T4bwiAO3eAoKH4mLFYswcNWBx6JCrK1GFDEy7vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/20/2024 10:03 AM, Rafael J. Wysocki wrote:
> On Tue, Nov 19, 2024 at 4:08 PM Arjan van de Ven <arjan@linux.intel.com> wrote:
>>
>> On 11/19/2024 5:42 AM, Rafael J. Wysocki wrote:
>>> On Mon, Nov 18, 2024 at 3:35 PM Arjan van de Ven <arjan@linux.intel.com> wrote:
>>>>
>>>>> And the argument seems to be that it is better to always use more
>>>>> resources in a given path (ACPI sleep in this particular case) than to
>>>>> be somewhat inaccurate which is visible in some cases.
>>>>>
>>>>> This would mean that hrtimers should always be used everywhere, but they aren't.
>>>>
>>>> more or less rule of thumb is that regular timers are optimized for not firing case
>>>> (e.g. timeouts that get deleted when the actual event happens) while hrtimers
>>>> are optimized for the case where the timer is expected to fire.
>>>
>>> I've heard that, which makes me wonder why msleep() is still there.
>>>
>>> One thing that's rarely mentioned is that programming a timer in HW
>>> actually takes time, so if it is done too often, it hurts performance
>>> through latency (even if this is the TSC deadline timer).
>>
>> yup and this is why you want to group events together "somewhat", and which is why
>> we have slack, to allow that to happen
> 
> So what do you think would be the minimum slack to use in this case?
> 
> I thought about something on the order of 199 us, but now I'm thinking
> that 50 us would work too.  Less than this - I'm not sure.

50 usec is likely more than enough in practice.



