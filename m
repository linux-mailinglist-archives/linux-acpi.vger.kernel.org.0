Return-Path: <linux-acpi+bounces-18109-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5D3BFD680
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 18:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E3A15839AD
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE66A2D3237;
	Wed, 22 Oct 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dYczUrc6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D7F279DCE;
	Wed, 22 Oct 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150478; cv=none; b=BGVTolP9b20JmMZVEDIyxyYNZJ2ysZ/8ax0i0U+zcBtkY1rK+7ODD4GGe0Az3Q/UT56adhLQrT/J6X2jW1j5BsZjxu0p5vUyRE4RRSZ3TTX+QDpU4PgTKrSSmyYzDwTMhL/LNkkVSJBz5CuyhZu/DnywDWpiM6Yqh2cWRGsHaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150478; c=relaxed/simple;
	bh=N7WMcy+tGgF0xedszwzLTPEiMBWrFIt4qQGWiXS/g98=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o2x0jo0TR1CmjefxAOOsuAeEFbwVnUlMqFW6iUqNmxyp21DexaNrWf46gRkNV20XR3f346LN3oMO+O6f6OjHpCEy/RtzfnEPM4yWhllYHaONUL6dE8eRdW3Qw0f+JvRZrbh0kajGyRwETQSkGIdEq+4m6ynDUZw44VGTwObdsco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dYczUrc6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761150475;
	bh=N7WMcy+tGgF0xedszwzLTPEiMBWrFIt4qQGWiXS/g98=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dYczUrc6/E+YlrOT4SMTk0efo1CZfEw961xQ6ObrcmuL+YLYrJo1DTe+CE6i0grnZ
	 F+5GpCQ1g2s8wATI6WkoxC8Zcje4s03PLICfFd6v4sk5GRUuoZtX0UoJjf7o0tl7sQ
	 Ndnmm26XXasPe+AEWFDUuvsJKmcAqHyu5awvmKoolOmXkeh1Wpq9EQlKAD95nHwZyg
	 OyA9QPlaFJvPZFDWKXkcXGMK63eNuPW2mKCmWvR8IyBSX/HPDSML8aZBLtIwimNOs0
	 rWutCeHG2amoPelADZ2h6vBPi18rp0pjUA5M6v374MHch9tdiBCw1UwbyDQWw2wMLH
	 Ko+56MRdnE7Mw==
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 22BE017E108C;
	Wed, 22 Oct 2025 18:27:50 +0200 (CEST)
Message-ID: <288e4d9c-a3e4-4f7e-a68c-330704e5125d@collabora.com>
Date: Wed, 22 Oct 2025 21:27:21 +0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org, kernel@collabora.com
Subject: Re: [RFC 1/4] PM: hibernate: export hibernation_in_progress()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
References: <20251018142114.897445-1-usama.anjum@collabora.com>
 <20251018142114.897445-2-usama.anjum@collabora.com>
 <68a8c1ba-275c-4908-a4c8-2e8b83367703@kernel.org>
 <CAJZ5v0hCxpWXdnoQeW79kaDFmHcfE0A4k7JuA9T+RR1OyCw29w@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAJZ5v0hCxpWXdnoQeW79kaDFmHcfE0A4k7JuA9T+RR1OyCw29w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/22/25 2:53 PM, Rafael J. Wysocki wrote:
> On Tue, Oct 21, 2025 at 11:07 PM Mario Limonciello (AMD) (kernel.org)
> <superm1@kernel.org> wrote:
>>
>>
>>
>> On 10/18/2025 9:21 AM, Muhammad Usama Anjum wrote:
>>> Export hibernation_in_progress() to be used by other modules. Add its
>>> signature when hibernation config isn't enabled as well.
>>
>> I wonder if you actually want to have pm_sleep_transition_in_progress()
>> exported instead.  "Logically" I would expect cancelling a hibernate and
>> cancelling a suspend should work similarly.
> 
> Well, it does AFAICS, except that only the "freeze" and "poweroff"
> transitions can be aborted during hibernation.  This is analogous to
> aborting a suspend transition.
I'll switch up with pm_sleep_transition_in_progress().

> 
> The missing part is a mechanism to cancel hibernation between image
> creation and the "poweroff" transition.
I'll add wakeup checking there and see if it works.


-- 
---
Thanks,
Usama

