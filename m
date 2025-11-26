Return-Path: <linux-acpi+bounces-19282-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 688D3C8A119
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 14:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C07D43498B7
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEDD30C612;
	Wed, 26 Nov 2025 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZkpGHxEN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92354280024;
	Wed, 26 Nov 2025 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764164506; cv=none; b=ottKm8RQGuZU+FaEtllWNvhLnUKpSnOy575CTlDNqRaWU3GA3VwmUn8ps1B4ox57bYiVPgNsm00a37f6g2KqKmxcYpShdW4rOo9RTqIXWeGyZKuzN4iVi8qmd13NRu4KxrYR/DIA0mBmqLrCV7DBd3aw/SYxnyO5q0AJ+NT3d0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764164506; c=relaxed/simple;
	bh=TCjsAggYrqSpEnSkYp0Cl1DlGai0+9iHnU3UKi1PI50=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L/gkzdZFe6IZxuJDjdDgNtIy3zmDXIGPT+zl08iIR//B9WXy8m98KZyoR53ZDv3qygdtpXwe4x30KET9m4d6rzkpleIg/pgS29WEyTfbSUjQ0qQ26Aezc7iOQ3fFp0PfPRjFU4IeRaTg4E2wDrs+H8kBGJ7cQtBmk7eacLzuk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZkpGHxEN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764164502;
	bh=TCjsAggYrqSpEnSkYp0Cl1DlGai0+9iHnU3UKi1PI50=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ZkpGHxEN1DgEXInu5l7rmYqVQpTJeBWgOfg/6fUC9pBgpzbefPYXBplfAlT8hfZZl
	 MoB6v82YLfEHxlLVFmIQWeDdxFSbBEExGq+DhYvPIhF76tV72nmuqo7QVHwseCW86/
	 sWfYgj+lg6ql9QCVDa/hXIK+GGTUR1HLEr5wXf+c7YBrlF9FThgzJA1dfiQYVmnhCu
	 /AG5sz1R0CejZ82+p85WaXtJkGk/aeTV87tORu4Bcx8fHQnXb+U833XC+W/ERM4uFs
	 wsiQjywxX90N2r+e5zEyjBtaZrKzhRT7naOdEljy6GkW0YhnjE0ZKPUt9SEd1s5dgM
	 SwfDxbJpvw6tQ==
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5041D17E00B0;
	Wed, 26 Nov 2025 14:41:39 +0100 (CET)
Message-ID: <40627ddc-720b-42c5-948b-8d832d16e2ce@collabora.com>
Date: Wed, 26 Nov 2025 18:41:09 +0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org, kernel@collabora.com,
 superm1@kernel.org
Subject: Re: [PATCH 2/4] ACPI: button: Cancel hibernation if button is pressed
 during hibernation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
 <20251107184438.1328717-3-usama.anjum@collabora.com>
 <2025112433-emphasize-helpful-b748@gregkh>
 <e1e97842-0ad3-4270-b0d1-3cc7150988cd@collabora.com>
 <2025112506-acting-tipoff-3a49@gregkh>
 <cef1d96b-b642-4e69-8c1b-2e0bf7528edf@collabora.com>
 <2025112612-backup-driving-e6e6@gregkh>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <2025112612-backup-driving-e6e6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 12:38 PM, Greg Kroah-Hartman wrote:
> On Tue, Nov 25, 2025 at 09:41:22PM +0500, Muhammad Usama Anjum wrote:
>>>> While I've thought about increasing the speed, I've no concrete ideas yet.
>>>> The main problem is that its sequential in nature.
>>>
>>> Then fix that?
>> That's in the plan. But who knows when we get time to attempt that. 
> 
> Take the time to fix this properly first, don't paper over the issue by
> changing user/system interactions that will not be needed in the future
> when the real problem is resolved.
You're absolutely right, and I share the same philosophy.

However, I think the hibernation cancellation feature has standalone value
regardless of how much we optimize hibernation time. Even if we achieve
significant improvements (5-30% or more), there will still be scenarios where
users want to abort an in-progress hibernation.

I'm focusing on making this series more concise for next revision.

> 
>> First I need a board/machine with serial console access to view all logs in real
>> time. :)
> 
> usb debug cables might be your solution.
> 
> good luck!
> 
> greg k-h


-- 
---
Thanks,
Usama

