Return-Path: <linux-acpi+bounces-20858-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKwaLuLMg2kFugMAu9opvQ
	(envelope-from <linux-acpi+bounces-20858-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 23:49:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2545BED10A
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 23:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E2ED3004C79
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Feb 2026 22:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AD3311958;
	Wed,  4 Feb 2026 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyexBrK0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D0A1A9F91
	for <linux-acpi@vger.kernel.org>; Wed,  4 Feb 2026 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245341; cv=none; b=e9/NL0kTChx/4bLl8CqicKJS2LpRJzJ1yr6mKmzXfAc12lW7QRItmIO8pGtpHcCTNpFYDJ7UbytS7tt6BXoUaYR/jFKALD4uB2qNplN+l28EWs82lhNSvPErY+iPPAsd7h46WHuN+RpMs2JPHTxwPzke52PcFiYvLgc4eQoT5LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245341; c=relaxed/simple;
	bh=tpk7E9/nFhxsnpWDZMJzvRP025Ac6ntJAXsa09zWW5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYiogI+5QLoouPwVfjRX3/XpeufVytpYv64WNzlePyT7ErQ2PsbV5MajfLuIc5u+Klft7ffW+mpCEx91gXZhoGj+uqUqfCxlriWW3V6Bk4myB6aE9YLgxeWi7oRrt0i2HqIMalkSN8G/s81hY7g1c1swugCS2UdKAYBC45WAMJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyexBrK0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8230c839409so282533b3a.3
        for <linux-acpi@vger.kernel.org>; Wed, 04 Feb 2026 14:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770245341; x=1770850141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dtHMvIPuRkX/7mzVfaFvUESxdrXYp5n2H0Br2oAyacw=;
        b=TyexBrK0uHThfIMR5KfOXet3DvEHzvGbVrz1Oq+w2LXAQxrfIvxr6V03BP1rsyvC01
         H47amZmeno/LTY7ZyOkv4H6dJbZpMi9dcTmwCgnMNc/GiizdEiVxHz/dndHTseUhhmj+
         fmkBaBgfuZmB3XrDWVvCDkOoRNNE4UnXXMXMAcy9/NMaPc+vjQGf6IK4YaFVrlBZEyDE
         TOjhktr7H38VF3im5kofvlx0klkgYkVLGPpm7mz6cCYPWIdg18LkReGtC1YGU2+9i/L7
         Ia1m4EzsiKU/Fpp2d/wjiQsToKnP+l02h0UzbU0F7kk0XaqCWx/WCAkq8/CCrf+nCH0C
         9GPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770245341; x=1770850141;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtHMvIPuRkX/7mzVfaFvUESxdrXYp5n2H0Br2oAyacw=;
        b=IAVLJ41itwEjuEo3lV38Mqnw70XtKIzXGEQ2xmlEQfJf0bs64ZhLLLzcpVL6fwFHGu
         9f2NPKKTTUL4NPmfslRoZK04UA2rFRlfKgjiy7didtg3/owTS6G1tozbfnlPD40nPZZF
         wK/jlQY6nBE/LOTpzbVImcra+L69tlTCUZVv/vaHgByhp/zBJtylk6QZJT68y1siLgp5
         ZuoW1zHhgoqd7C89GYSiohgXir45tAmUrAhztOvRoHMimYAW1tOuTbmmhf5lVgQd5xHT
         V3mz7RWc6bQXGdgV1IkMlr+Vx7eqFl6ZGcwqpNt/bXdmi2Q3yNuMg6mmpPokY2hDhV+Q
         3uPw==
X-Forwarded-Encrypted: i=1; AJvYcCXyo9x/Wn0QlYdjZSgRcEhm7BP3pWQboiy3R18T5F/usp+5C0nFfCo5UdDeWuC8BhSJ5XNub15VAl1p@vger.kernel.org
X-Gm-Message-State: AOJu0YxwT8sRzqxSSV5QBfjQNxaqWG3loRsJg3+obU4QdN40lyD6ktEO
	5+omQAj8/VS2qEAbdMx8gSkD2xmzkLOVN5p8OUa6Uqmt1x+pdtdrqvNN
X-Gm-Gg: AZuq6aJ2dqRpMOMR9wRdDP40fLz1Pzx3T8obJiOfwCZF1PFwCdWkiMUAeKjVTpB2LQw
	2bg9UogG5dwZlm1kcz8tXyvK/soxTAgV7Jjf74fQPZUv1E8oKH3nUmQ8HLFd4twbhBOZT/+y12F
	5hgxuA3fCMeJiLuXTtsI2DXr1YMF1wqGXqBOtIvVsgxD1BwJG2pJS+ygXAcSQD3VnpHTsSrUfuy
	xLh2w1lVXVppNnh+6iPi7SfhQKliVmE9vZZawxdOC65nKj/C6WkkY10ruuEWAjPTk91jXfpyD4R
	7O0E+PJk6mQgiEcKAzN3/cLY2VNn8LA+kt7EOuqJNbxWtQb+Nq8/Z2GqQ31gVlgpmS2uS4ABKxq
	WxBJHCbF1hf9e9DzByqzLHirsTOxU164a3zxkBpCIQAml0gjdSt1lu76o8BGTqxvvf43nGghSva
	chQEjNvlKA7N8Y2/R/V2YEmfO6OZs9svNVkOMLzIHRxS01RdKM2HBDVL423Ld7
X-Received: by 2002:a05:6a20:d497:b0:393:5fcd:cec5 with SMTP id adf61e73a8af0-393724ab47dmr4195847637.58.1770245340975;
        Wed, 04 Feb 2026 14:49:00 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c85729e2dsm2823395a12.34.2026.02.04.14.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 14:48:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fee01c19-2711-487e-91e9-d57f9be04b98@roeck-us.net>
Date: Wed, 4 Feb 2026 14:48:58 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BISECTED]: acpi_power_meter: power*_average sysfs read hangs,
 mutex deadlock in hwmon_attr_show since v6.18.y
To: Igor Raits <igor@gooddata.com>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Daniel Secik <daniel.secik@gooddata.com>,
 Zdenek Pesek <zdenek.pesek@gooddata.com>,
 Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAK8fFZ4izdX_HDtGN60CZ3Ta61nqkUg7ncViM=mGgxKki_5FoQ@mail.gmail.com>
 <a7334568-13ce-4600-8650-607273e67976@roeck-us.net>
 <CAK8fFZ6gKs7s2rJ=f7bt24f+_cY-jGU33TvX3UP=U58uK-1KaQ@mail.gmail.com>
 <fff54ec8-496e-4c26-b652-358dc4de0de0@roeck-us.net>
 <CAK8fFZ4wEUdMAHkfdC_z8ohYB_rEXZ=dHArc75jDibgQ_-ozKw@mail.gmail.com>
 <4f151d4c-fdc6-4281-87b0-b7120eeb1b46@roeck-us.net>
 <CAK8fFZ401-nez_CgDTTnQiPT=oBRRJuYooXyEKFuCdHpGCPXtA@mail.gmail.com>
 <27d60756-d33e-4926-9a02-f52505339de6@roeck-us.net>
 <CAK8fFZ43wrQ8A_bO_g+rKN9O31sxULtqA0hUieZSzEH5KqeW1Q@mail.gmail.com>
 <CAJZ5v0hEu_io2BAzp9weUDHwHngorjZ37GRUK=ngSXNjtp38qw@mail.gmail.com>
 <CAK8fFZ65Vro5nQqJq_cvsY93hgDbfTdibWnNr5b0Bixzc-ESfg@mail.gmail.com>
 <CAK8fFZ6Vi4xayvdKh-_eLi-nDNMLuEoMsvwEnb33QqnwS7o4BA@mail.gmail.com>
 <1c8f748a-5c5d-4234-ae86-7bb12045a373@roeck-us.net>
 <CA+9S74i+BC3=E0opOPMff0cuC1OPYSecii0C8fVZ+NM7bptNcQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CA+9S74i+BC3=E0opOPMff0cuC1OPYSecii0C8fVZ+NM7bptNcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20858-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2545BED10A
X-Rspamd-Action: no action

On 2/4/26 11:54, Igor Raits wrote:
> I have written a patch with the help of AI and it fixes the problem. Attached.
> 

"No MIME, no links, no compression, no attachments.  Just plain text"

... which means I can not provide inline feedback, which is the whole
point of the above.

Your patch crosses subsystems, so it will need to be split in two
(assuming the ACPI side is even needed). Also, references to iDRAC
in common code seem inappropriate.

Thanks,
Guenter

> I don't know how correct it is, but it works :)
> 
> On Wed, Feb 4, 2026 at 2:01 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 2/3/26 15:21, Jaroslav Pulchart wrote:
>>
>>> ...
>>> $ git bisect bad
>>> bc3a9d217755f65c137f145600f23bf1d6c31ea9 is the first bad commit
>>> commit bc3a9d217755f65c137f145600f23bf1d6c31ea9 (HEAD)
>>> Author: Corey Minyard <corey@minyard.net>
>>> Date:   Wed Aug 20 14:56:50 2025 -0500
>>>
>>>       ipmi:si: Gracefully handle if the BMC is non-functional
>>>
>>>       If the BMC is not functional, the driver goes into an error state and
>>>       starts a 1 second timer.  When the timer times out, it will attempt a
>>>       simple message.  If the BMC interacts correctly, the driver will start
>>>       accepting messages again.  If not, it remains in error state.
>>>
>>>       If the driver goes into error state, all messages current and pending
>>>       will return with an error.
>>>
>>>       This should more gracefully handle when the BMC becomes non-operational,
>>>       as opposed to trying each messages individually and failing them.
>>>
>>>       Signed-off-by: Corey Minyard <corey@minyard.net>
>>>
>>>    drivers/char/ipmi/ipmi_si_intf.c | 29 +++++++++++++++++++++++------
>>>    1 file changed, 23 insertions(+), 6 deletions(-)
>>
>> Now that is interesting. Does reverting that patch on top of 6.18.8
>> (or any other 6.18 release) solve the problem ?
>>
>> Thanks,
>> Guenter
>>
> 
> 


