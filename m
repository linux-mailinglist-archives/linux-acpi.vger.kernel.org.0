Return-Path: <linux-acpi+bounces-20672-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOJlLjjseGkCuAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20672-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:47:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E15F397EEE
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 019FF30693B5
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B1B310774;
	Tue, 27 Jan 2026 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V482qUjk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13929315D53
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530530; cv=none; b=b239rLTg23yjGpNuNd9NujdzFkYmYTxav421dc4AESnYd/mJHHYCsp88qn+cLy8IlQJRuBOSrOhWwydSNDzUgmq6N3a64Cs8tDI+lX/ciQ6CFYFrO54dWRmnQ2TtXER9LhLrkpVkpIRY4qgZoJSkkSFzOYoUpBCITlkmF2fdo/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530530; c=relaxed/simple;
	bh=fJLO8mgR7MxzQJPxJHeEwCXhX/hLZZN104VEgWIUYMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhrxwSJb/ppLATtVzvyiKi4cUycIDIdnmC20or9kFmBe2ujwuWGVyKlRhDyTY8uZjZhjkSFulO+xbBVxMlFJolg1pEOKjkPqtlSvA+hEv2niE/6CEOqA31KrVdR1VYwNAoqm6G0aREUsfNR0DQj9olcZqPMP1351kt6OpT8VFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V482qUjk; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5f548b7ab61so2765694137.3
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769530528; x=1770135328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=glwth67pMNa1uo+tDZsuuxF/rVPpQOEYq0+JJJ0P8F0=;
        b=V482qUjkKdjY/fZMlZrl3p6OaOmu4/kSziExYnT+gWn6OWB+RzqdZBjInwU6IS+tnX
         HLoIHgdYqqo27qom23E74LjaO0axjt/3afxei1KZgRTNdILeXy0YrJ2ecLKvvEgEhGKu
         2egmQ7MqRh2LzpE3TLeeLOyDlyF6ofVDyybAKXAhRshuBILTlUxuxv+zPPgRFeI1hNSb
         pMbO1fdFJFKbr6CXOL7pGwMlS8UPDpPtziUSZrGMIdyRqsA9f14/rSCSlQNtcgV7FZ6R
         1QFdTUavlOGR06O1YCaBNKUR6O9k3BtqfFNt5uN8ZJ6IKLxZZOZqM2BaQWgp1L5Boew0
         tTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769530528; x=1770135328;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glwth67pMNa1uo+tDZsuuxF/rVPpQOEYq0+JJJ0P8F0=;
        b=J59JkLqdGNPrunKYHKe9JH1LHqavtMIV0tg7IP8wKi1i3G3nWJcORnkOR2whYnGtEI
         p2XLhzXYbk+lcLkpg/4NolgPlcm/yoSvHQqfOPBr9SAQ8DKxiOjAPPH1Bu6fRuUffiNe
         FCs6f7i9RHpa+ceLZjTfIUdkXeX/FQlx8bSx2i6mHbRgiOX6p0W4Ob+UtM36ztt0+nhc
         ZYoHFrFBsGJrzB8RQMHvTyEhpgC9tHTShWzjOw2tNHywH06rnoE5JJ33YuoufkQ95Gm1
         ikKb0/Bsl1hgf3M5hr9J8Gz3RFM+eidL6glyYsrR56dEl6TTTXgYXUJD/YEleb/krV6I
         G3RA==
X-Forwarded-Encrypted: i=1; AJvYcCXCoXyld0ryTlezO6/i8YN3nVcI2e9rAQWIw0rl7fTyD3brTZ+R5LLS+bpQ4UDSrVoRLCBEm5vFCVyp@vger.kernel.org
X-Gm-Message-State: AOJu0YzlARgOrEi8o4Mek5f7b/98KypOuVcTjCHFywDM3Cz/xwCMkjrV
	tr0nY9O//bQPJ0UXcB83cpx3dei3pIjM+ZKhsSzq+thZllE8rbfosmCLuvLZlk1x
X-Gm-Gg: AZuq6aLlpVYgCHlf/HOrpgt0QOU4b6Kh4qg9tQEdcU9TyFgq+/V0wI3DUokJhtGh+Wh
	9sbJEbAg3oSEA3ADdqeqTOx2O/AaU/EclpjJuOhLi9ttce1SwI0zD2l8o6pEMLZY7F34+XOq3MS
	SJfczvyvdT8pBmC0AOT7ilwdPwoiow91tLL7QB/UoNW3uNv+/K1zJ0RAojO28DC/SR5Ls0jZwMP
	XKhj1CiVwkchQIajSUAldtbyZl9XoW/YMtQp1wGYq/bftHc/7rFdG+FkMZmsCL28W+zJKkBUjkM
	TUMQjpbq156Z0mXq1GdOKW9b/b3PUuBc/aAPzTZ9RWrTMe4Kr4V70OfAUTSbzqFr0EzG6irWu/I
	I/pvRtP1zif/Q5LLGx12kRE5Z6xV+B5QMXLID9srQ5ZWt+gBigGUzvLN5ts/RvUmKChBKLNcoqq
	lLjaSP1Kh8sBsqwr7L6QkTBOfK0iTe+4GUDHxQBGeltPFuytEChkBmFoni6tTG
X-Received: by 2002:a17:902:ccc2:b0:295:59ef:809e with SMTP id d9443c01a7336-2a870d9a24amr18044895ad.24.1769523850026;
        Tue, 27 Jan 2026 06:24:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802f9762esm120834775ad.55.2026.01.27.06.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 06:24:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fff54ec8-496e-4c26-b652-358dc4de0de0@roeck-us.net>
Date: Tue, 27 Jan 2026 06:24:08 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: acpi_power_meter: power*_average sysfs read hangs, mutex deadlock
 in hwmon_attr_show since v6.18.y
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Igor Raits <igor@gooddata.com>,
 Daniel Secik <daniel.secik@gooddata.com>,
 Zdenek Pesek <zdenek.pesek@gooddata.com>,
 Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com>
 <e03c8b69-e667-45b8-b82c-2cd4f1c96bdf@roeck-us.net>
 <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
 <d7f34e0f-e258-4fef-93eb-1ef0a3123d95@roeck-us.net>
 <CAK8fFZ4izdX_HDtGN60CZ3Ta61nqkUg7ncViM=mGgxKki_5FoQ@mail.gmail.com>
 <a7334568-13ce-4600-8650-607273e67976@roeck-us.net>
 <CAK8fFZ6gKs7s2rJ=f7bt24f+_cY-jGU33TvX3UP=U58uK-1KaQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAK8fFZ6gKs7s2rJ=f7bt24f+_cY-jGU33TvX3UP=U58uK-1KaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20672-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,roeck-us.net:mid]
X-Rspamd-Queue-Id: E15F397EEE
X-Rspamd-Action: no action

On 1/27/26 03:58, Jaroslav Pulchart wrote:
...
>>> Hello,
>>>
>>> Thank you for the analysis and insights.
>>>
>>> To add some context from our side: we observe this issue shortly after
>>> a server reinstall or fw updates followed by a reboot, typically when
>>> hwmon sensors are accessed for the first time (e.g. by monitoring during
>>> early system initialization). We have not seen it trigger during normal
>>> operation, such as a simple reboot or on long-running systems.
>>>
>>> Given this behavior, it is possible that the issue is related to
>>> hwmon_device_unregister() being triggered early during system
>>> initialization, but I do not have concrete evidence at this point.
>>>
>>> As a workaround, we will exclude the ACPI power meter from hwmon monitoring
>>> (Grafana Alloy) until the mentioned refactoring or a fix becomes available.
>>>
>>
>> Would it be possible for you to test the patch series I just sent out ?
> 
> I suppose these 5 patches from
> https://lore.kernel.org/lkml/20260123182208.2229670-1-linux@roeck-us.net/
>   ?

Correct.

> I will try them and let you know.
> 
Thanks !

Guenter


