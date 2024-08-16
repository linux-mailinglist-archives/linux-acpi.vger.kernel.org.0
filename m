Return-Path: <linux-acpi+bounces-7636-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3538895527D
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 23:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6013F1C20FF2
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 21:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E191BE250;
	Fri, 16 Aug 2024 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jevklidu.cz header.i=petr@jevklidu.cz header.b="DZUv6dqx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3102D02E;
	Fri, 16 Aug 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844205; cv=pass; b=n3W/b7FPipDg/XoUrpjOvXRZ5P0Z2x4kcZWnP3tdzez+c/2QqMJU6QJ5IOzR8+wFwqjHObDoQpAEA2VuMtoj3PP8Xo52L8DqL+VkdkVhLuUAi2eyHjKxEVnahwNurxyJCjHCavVRJlMC5XLRqjPGq1KGppj/jqK0Gq3aiY/Z+n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844205; c=relaxed/simple;
	bh=c17FZbLWCHlwpY1peGpdkedS72div4Jo5jTC/JJCJQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tms9TRefcGJLHiz15yh8/HlU8Cyai5QmQeAWWhIu6foubbtzyD73bPYTeGLeDz+dUcB0KKeYdEruNp6pMCO5Ffuq649plNqg8+5EYbHJUFz7UvV0gVVNL1HQ1+uRRjtaAe0sPfzA5Xjrkgv/Mm3EWdyRxSvz4jvPxJxRYd2ab3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jevklidu.cz; spf=pass smtp.mailfrom=jevklidu.cz; dkim=pass (1024-bit key) header.d=jevklidu.cz header.i=petr@jevklidu.cz header.b=DZUv6dqx; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jevklidu.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jevklidu.cz
ARC-Seal: i=1; a=rsa-sha256; t=1723844190; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bQk8V4jUloaXUJr4avZp2TOnuOcY6nOoujAoF1vTkj7qlQebEQbtB/30yF17TDVabMEO+Swk9WRyaiRjtApNmffEaLYaVBqqkhLT2vuohIzFior1jYZSj8jR3RVGtRhAe29IFOsBRCHod4RktGwSvMeZafHtiy3j7YqOY/B+jTc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723844190; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=d+nsXWkB2Aw92a5tKCDR/lymJS8ziMLdHe14zTquOHE=; 
	b=HIIcACDp/SIs8kVX6QaRf9SIAGk5v4QcgHwrnmmtTPjemAHImAYcyHoBpOlYejWImiIpBGUsC6rF9Fpex/ZFP7Ba04BESQckhDw+3BacC/qay3/Jk6Y5oq35V9apg/KRXLqSajrAZQqY8gmYsQvyUs3umv7wesuuIzc5KHjuiFU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=jevklidu.cz;
	spf=pass  smtp.mailfrom=petr@jevklidu.cz;
	dmarc=pass header.from=<petr@jevklidu.cz>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723844190;
	s=zoho; d=jevklidu.cz; i=petr@jevklidu.cz;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=d+nsXWkB2Aw92a5tKCDR/lymJS8ziMLdHe14zTquOHE=;
	b=DZUv6dqx3JwJLj1hW/OtijSJvEg6L+mZTMiZUzYnZrnRLx2nKKG3uawvPbIx45du
	QVP6DClEweEo9tyPybHD5NGF1YJStGwIJop+M+F1wWxt4KeLoeJf5kZOlzKrfv0aJTQ
	TY9+n/MkGg83+/PlZoqEd4rdOm5WLDMR4sedWgu8=
Received: by mx.zohomail.com with SMTPS id 1723844188239272.99156550785096;
	Fri, 16 Aug 2024 14:36:28 -0700 (PDT)
Message-ID: <512c2b92-bad8-4dd6-9db9-a6260dc1cdb5@jevklidu.cz>
Date: Fri, 16 Aug 2024 23:36:20 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ACPI IRQ storm with 6.10
To: "Rafael J. Wysocki" <rafael@kernel.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org>
 <bd149809-f670-4b5d-a18a-f1f63624265f@kernel.org>
 <CAJZ5v0jrgC+cvjDfw+vQ1jyVz1oj28uTf9k+-Kk2EAPJj3VmdQ@mail.gmail.com>
Content-Language: cs-CZ
From: Petr Valenta <petr@jevklidu.cz>
In-Reply-To: <CAJZ5v0jrgC+cvjDfw+vQ1jyVz1oj28uTf9k+-Kk2EAPJj3VmdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External



Dne 16. 08. 24 v 20:29 Rafael J. Wysocki napsal(a):
> On Wed, Aug 14, 2024 at 8:48 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>>
>> On 14. 08. 24, 7:22, Jiri Slaby wrote:
>>> Hi,
>>>
>>> one openSUSE's user reported that with 6.10, he sees one CPU under an
>>> IRQ storm from ACPI (sci_interrupt):
>>>      9:   20220768          ...  IR-IO-APIC    9-fasteoi   acpi
>>>
>>> At:
>>> https://bugzilla.suse.com/show_bug.cgi?id=1229085
>>>
>>> 6.9 was OK.
>>>
>>> With acpi.debug_level=0x08000000 acpi.debug_layer=0xffffffff, there is a
>>> repeated load of:
>>>> evgpe-0673 ev_detect_gpe         : Read registers for GPE 6D:
>>>> Status=20, Enable=00, RunEnable=4A, WakeEnable=00
>>
>> 0x6d seems to count excessively (10 snapshots every 1 second):
>>> /sys/firmware/acpi/interrupts/gpe6D:   82066  EN STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:   86536  EN STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:   90990     STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:   95468  EN STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:  100282  EN STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:  105187     STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:  110014     STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:  114852     STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:  119682     STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:  124194     STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:  128641  EN STS enabled      unmasked
>>
>> acpidump:
>> https://bugzilla.suse.com/attachment.cgi?id=876677
>>
>> DSDT:
>> https://bugzilla.suse.com/attachment.cgi?id=876678
>>
>>> Any ideas?
> 
> GPE 6D is listed in _PRW for some devices, so maybe one of them
> continues to trigger wakeup events?
> 
> You can ask the reporter to mask that GPE via "echo mask >
> /sys/firmware/acpi/interrupts/gpe6D" and see if the storm goes away
> then.
> 

It works, thank you. High CPU usage by irq/9-acpi is immediately gone.

> The only ACPI core issue introduced between 6.9 and 6.10 I'm aware of
> is the one addressed by this series
> 
> https://lore.kernel.org/linux-acpi/22385894.EfDdHjke4D@rjwysocki.net/
> 
> but this is about the EC and the problem here doesn't appear to be
> EC-related.  It may be worth trying anyway, though.
> 

