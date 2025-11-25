Return-Path: <linux-acpi+bounces-19260-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAADC86064
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 17:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE98D3B2235
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FD5329C41;
	Tue, 25 Nov 2025 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VpeFfnsq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E407329C64;
	Tue, 25 Nov 2025 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089108; cv=none; b=U+gLj/jjklEXyw2hB69nlYUf39YKliwhNj5h57giAzhe5PhoN4mSLHC0+uE97B2B9oCu2DhwoWBo8RueLRVUVFQhYG2pqXk1nxb2OnuW63yy+B+jqlfUY88D60fjmtAVPtY9QeKJqCXiEUEjQ3xcM2+V8wNKuLcHd/n9lEyuN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089108; c=relaxed/simple;
	bh=L7B8F2Q1Vxh92Ji5RCsOEviO3cskIYxKJ9u0G0P5QP0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zd3w65caNE9zuAhepKlxDnuEUyZCagWqQj+AgE7Gh35OIqSsrQElF+4CiCmruwq3XcuEhtobOSvFtR1UhDG+1HBD8c4UJXXZ1ZKwwILqzEnX3MAsCS39OKE59cG8Opp3WqrVIGgJwWo0NkgeWpi2p06Qu1b/8n2KenST5qAiMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VpeFfnsq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764089104;
	bh=L7B8F2Q1Vxh92Ji5RCsOEviO3cskIYxKJ9u0G0P5QP0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VpeFfnsqnbNLZb48ChsmECFmJ1ONI3vRemdpIYxlQKfzjmPDC/H8N0Nsejwm6RUry
	 Z+H8ulfHj138967YJdfQy22HCZQwTquEYeqv5bu3wD8ca/zHD13I+ohUDVNyCHjfXn
	 bctuCu3aSIaFMQIgVoswJhuDlbMeh9HWgQ+kmYn1FCsNLh2iJ05m2bAnJk9BqaW3Ad
	 GRmwt96qOkcPisYmNe/oY6W+e0vNjkveAF4K1KKTGuCvFIWg17GlqoeX5iNQPhoe/T
	 U1mI/GobupFurQ9MJVCKBeA/3/mubZMpa6K6YH7R6HqTZt5+ZzXaMuQOH25JoobYGy
	 /pNh2yCKD2jxw==
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4D2E317E0AC3;
	Tue, 25 Nov 2025 17:45:01 +0100 (CET)
Message-ID: <7701d31b-d4cc-47fb-84eb-87e61c94c126@collabora.com>
Date: Tue, 25 Nov 2025 21:44:40 +0500
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
Subject: Re: [PATCH 1/4] PM: hibernate: export
 pm_sleep_transition_in_progress()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
 <20251107184438.1328717-2-usama.anjum@collabora.com>
 <2025112423-rocking-deafness-88c0@gregkh>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <2025112423-rocking-deafness-88c0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/25 10:01 PM, Greg Kroah-Hartman wrote:
> On Fri, Nov 07, 2025 at 11:44:28PM +0500, Muhammad Usama Anjum wrote:
>> Export pm_sleep_transition_in_progress() to be used by other
>> modules.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  kernel/power/main.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/power/main.c b/kernel/power/main.c
>> index 33a47ed15994f..ff3354b5be150 100644
>> --- a/kernel/power/main.c
>> +++ b/kernel/power/main.c
>> @@ -570,6 +570,7 @@ bool pm_sleep_transition_in_progress(void)
>>  {
>>  	return pm_suspend_in_progress() || hibernation_in_progress();
>>  }
>> +EXPORT_SYMBOL_GPL(pm_sleep_transition_in_progress);
> 
> The problem is, you can not rely on the result of this call as it could
> change right after you call it, right?
> 
> So who needs to call this and why?  What new workflow requires this?
Yeah, Rafael just mentioned as well that this API isn't dependable. I need
to use better flag for detecting if driver is suspended. I'm testing if
suspended flag in ACPI button driver is enough and similar flag can be added
in input driver.

> 
> thanks,
> 
> greg k-h


-- 
---
Thanks,
Usama

