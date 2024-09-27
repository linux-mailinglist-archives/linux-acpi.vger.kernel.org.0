Return-Path: <linux-acpi+bounces-8455-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 816B49881D7
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 11:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3E11F222D2
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9508D187FEE;
	Fri, 27 Sep 2024 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="DwvNkBzQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4A018D62A;
	Fri, 27 Sep 2024 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430644; cv=none; b=T3fRiMe1jaZd/fd/Jp5/UQU6LBftyQjogwcMEut/isg05g9a6a7eavtO9DUz3e5Hws4qVgNSnxFJLJHQe1+JF53ohYfb9mPMBxn927DuVpWCK25NPp+z54v26i5aGGjnpH0Xdh0UQISCoSu0Q3K82c31y0EIRy/qtqnobao4iRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430644; c=relaxed/simple;
	bh=N+iHZrpJ2KkaxzNy9JDcylLX5uxcG4z2UdR+OzmMOt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSTBb/DpMRrt8wzJe1xjfoiPgj5nh0/wjI041FI4bgS8ALIDhHEGb4HkWVF4SJAbljYI8iqaZ2qXlQTFpZPQKXR3hazGzQ0ncpurZSJvOTVoKo1A0NWtWx0fMQXdWS3EhC8PJsvWlwMaxSQBqfaDXMG+YFa3eRWzWkRZBXxB6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=skogtun.org; spf=pass smtp.mailfrom=skogtun.org; dkim=pass (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b=DwvNkBzQ; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=skogtun.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skogtun.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
	; s=ds202312; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=x5ctretvgsVDiT6kUglBCR2+u5P1/Itys22V3gbPC/o=; b=D
	wvNkBzQ7WWKMCsgWXROctXuAmLvAlydpe+6YcSEFuzL0QL9W+ixqpxRjio/WdZZFQnbdeeDieVJ8B
	U5Iggd3JdN/rez2gxqxbI9htLzmG2Tl1EEqQhZiwJvOcrtAoaNflpZb5uS1jm8rsTEnYM42fWvV8m
	++2on7/sk3iVeyxTPi+ljZX5p6mX/0E0gVtJS7IgO7W16DgQc7xgpS1uV06vkGUJgtuK1KLdDs/5R
	4H4GyVDvhAqG8JxQWDCgjNXfD+FAjNP3jCKn1LFdduQPrWFc1LsZnWUhYP5ErlafhIX829MpumbWf
	eFUpbDTDd+tPXiWgJrU1H9VBnY9HrQ78Q==;
Received: from [2a01:799:d62:ac00:6417:a5fb:b81f:f312] (port=54372)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <linux@skogtun.org>)
	id 1su7cR-00HG5x-8I;
	Fri, 27 Sep 2024 11:50:35 +0200
Message-ID: <ee575504-6f7c-494f-ba53-7a82a116c363@skogtun.org>
Date: Fri, 27 Sep 2024 11:50:33 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bricked Thinkpad x220 with 6.12-rc0
Content-Language: en-US
To: Pavel Machek <pavel@ucw.cz>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux@leemhuis.info,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ZvW9e8qBiAT5e0Ke@amd.ucw.cz>
 <CAHk-=whj9dbJD0mT6VUW7i16Les5waxWBb1o_XsDKrtQ9iBO1g@mail.gmail.com>
 <ZvXJjU7gpAchSqiy@amd.ucw.cz>
From: Harald Arnesen <linux@skogtun.org>
In-Reply-To: <ZvXJjU7gpAchSqiy@amd.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Pavel Machek [2024-09-26 22:52:29]:

> Hi!
> 
>>> When I press power button, it starts producing some noise (hdd
>>> spinning up), but power light goes pulsating, not on, and I stare at
>>> black screen.
>> No beep?
> No beep. And no beep when I tried booting with RAM removed.

Just some random thoughts, probably not very helpful:

I assume you have tried pushing F1, F12 or the ThinkVantage Button 
during boot?

Remove and re-insert all ram.

Especially if it has an i7 processor, could it be overheating? Try 
removing the heat sink and apply new thermal grease (and clean the fan, 
of course).

I have one of these machines myself, never had any problem with it.
-- 
Hilsen Harald


