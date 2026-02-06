Return-Path: <linux-acpi+bounces-20890-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONxjIwgYhmk1JgQAu9opvQ
	(envelope-from <linux-acpi+bounces-20890-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 17:34:16 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDB710054D
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 17:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0ACE1300B5A3
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EF1329363;
	Fri,  6 Feb 2026 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFIOoIcc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFE430F950
	for <linux-acpi@vger.kernel.org>; Fri,  6 Feb 2026 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395516; cv=none; b=nicPVj3LkHMbRN1EbU3DcHsHJ9fFlavt6gtBm+G50QXe0M2744bRNpDfLjl6REABUvZLxGLLRZX+6KIAo1nhi8qnJyn8IFBkqV2t3pxBpL8Ams34+r/CdRdfZuX4/P2xX8Lh71EsvgWb9YRzxmIdNRtCOxsZnl44rjTQ778Skp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395516; c=relaxed/simple;
	bh=2zB7HekGKrFnGNzWWAGcA2J5iO+2U396GYLL/gI9dLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMOIXmbn96fiM4vTUHFjKMfdP15phQ8KWvJodNU1sfjHPEBgi6LtUBE6nW3DGITvrY4669PkaFR6D0KSvRLOot4EZB53xtMP9+YgXWHxLeen4TNGnSP+QUQM1+1iNhhp/78e+ys4WJ3Czb+lygo3mlOMmPahRUXykFF6GmSpuVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFIOoIcc; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12336c0a8b6so140367c88.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 Feb 2026 08:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770395515; x=1771000315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=B5VaLgdl0sc/lc6dY2l3XCuB72osV9uT0bSdbO107cc=;
        b=IFIOoIccK6wwwso5oScbI4vUiZ2NSyIuo8S/oF5aw1xrRfZ1jWx0RD0GS/l3QZI69S
         4lENTsPoCwKhZb77MVaOPGAlvO1rG5JHNLy3okyNC5YaA8eTCKg3nEHX+Ba8P8pnqOYA
         vakcOINJ55IZQnpmiDmySaEK59sA/Tk/s6B/SKeX4ystsQpi46AkQu1vgm2l3lYQq+BA
         2X91ZxFwHPvQYJCmAqrloWG2v/Uj5xAAXFnkh9e8UFEcilXLN0GO4l+g0roXAbZpNUzb
         8MaJ3jWLg4OYoaP6ZoP55ekPwk46xkeQbkfSQmIbKJKuNE+/mbS2ykBwLho2JSNsCfPk
         mopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770395515; x=1771000315;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5VaLgdl0sc/lc6dY2l3XCuB72osV9uT0bSdbO107cc=;
        b=Z/Gq/qOyxWScUJAaGTeH9JUIX/HhkwRoo6wZ774cik/cLQSRv54Mgr/0qfeES9wLJr
         sREgb8OY0bt7A8UMydrQt/0rWeafi5Xx7BljB3dPRcNgBHtXy+mr1kZalE5KTQiUNGx6
         iOiTyIhMGYScAk+UgZQ0Rz1gf8oi4kSMYoOGJHTF1AyOfXqK6+EUnZ/Ape11JHUbYhSR
         s9LOzONT5UxNRx34Qw2T4Fsu31kaQDZ/wtxMAcCsp/WzA4BdD1PNIUl0WsnGP5f121yh
         XyT+mLnQ2+C2cQQ3PHScRdwEuJgX330e/VNq/iIZiPJhRWlRrpQ+oWfFOyZOHdvjgUW9
         jjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZIdefhSvJUhigbJMNaDl1/Cx/BxXXPSsng+1VZI6Ja5S0pmnCfyhFC9nbN0oOcB9lyYaVOBpTn1n8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6cZ9O3vCosv0kkEG9Qbh2EG/kayEZ9VqKZQRJSSbIA6PmAdb5
	t0Wo8Qyj2Ye/4KUBrdvu3VVoB1Nazlq6mvhMLlXuDf4qmfoTZ8jMHxfq
X-Gm-Gg: AZuq6aLna1uEmM/xy27/8YEbZsyljoH0GYwd74f4W5bIpALhQpqJAZyzzJM38q1SAOy
	KWZ53ebuq0IzejJ8GGEMZ4jTTF7qff2OYlMfQXtbbrbstUXPTmw0nJQn8qS8kohI2eBpNSv9xML
	dfkigH2u1M4YQ2X2oYSGmwM+3QJanZy5NtlcLhzILvHjiNMgHoRys2xzFIAOhZD/oeNaxmXlf17
	vkYNyzTiC/j3ODiCWFozus9npUP8YOCW9/Y2ob13KGQAG66JU0ZMpfcPfm7dpw8u/vgRmwGvh1f
	l5VX/EqRJObTPV+vREalDMjAtinDKUu5n2bh3v88Ws3DCQs2m8SV7GS1r19Vn4L4BxEq5SmFZ6S
	BOMH3stC9g83beh5uzR3KBe190LK7u2OKE35YNfrRt0YgI9ebciKQ1zJt/gpWjnrCgdUgLe8ZZl
	hKrq1ucO86y6m4oPhqtt5RB8DsY0GKtazIvi5huY2a27ikDsGTZ0VOSKA2pnel
X-Received: by 2002:a05:7022:6092:b0:11b:9386:a3ce with SMTP id a92af1059eb24-127041a239fmr1388232c88.47.1770395514664;
        Fri, 06 Feb 2026 08:31:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041d9c91sm2560985c88.2.2026.02.06.08.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 08:31:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c9ecdbd1-cc50-4e3a-9540-6a4917dc07d6@roeck-us.net>
Date: Fri, 6 Feb 2026 08:31:52 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BISECTED - impi related]: acpi_power_meter: power*_average sysfs
 read hangs, mutex deadlock in hwmon_attr_show since v6.18.y
To: corey@minyard.net, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Igor Raits <igor@gooddata.com>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Daniel Secik <daniel.secik@gooddata.com>,
 Zdenek Pesek <zdenek.pesek@gooddata.com>,
 Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
References: <CAK8fFZ65Vro5nQqJq_cvsY93hgDbfTdibWnNr5b0Bixzc-ESfg@mail.gmail.com>
 <CAK8fFZ6Vi4xayvdKh-_eLi-nDNMLuEoMsvwEnb33QqnwS7o4BA@mail.gmail.com>
 <1c8f748a-5c5d-4234-ae86-7bb12045a373@roeck-us.net>
 <CA+9S74i+BC3=E0opOPMff0cuC1OPYSecii0C8fVZ+NM7bptNcQ@mail.gmail.com>
 <fee01c19-2711-487e-91e9-d57f9be04b98@roeck-us.net>
 <CA+9S74jR9jRRE-DNMxNg=6Uv2uDAUar2n-RkVDJqzkDfNu3eog@mail.gmail.com>
 <39100538-a1f3-48dc-82d6-5e3314a43b4d@roeck-us.net>
 <CAJZ5v0jo4CV__AoUfqxuhVgkw6hA=hM_fBU+W=pTzqDLmNmytw@mail.gmail.com>
 <1642aec8-e8c1-4ad4-a5b7-556feeedfd93@roeck-us.net>
 <CAJZ5v0i_BmeGROzQFpUCyF5MkA7sFkP3y8jjqH0mD2r2Wqj_xA@mail.gmail.com>
 <aYYSDWaeiCnkwqAF@mail.minyard.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aYYSDWaeiCnkwqAF@mail.minyard.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20890-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,roeck-us.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BDB710054D
X-Rspamd-Action: no action

On 2/6/26 08:08, Corey Minyard wrote:
> On Fri, Feb 06, 2026 at 01:08:56PM +0100, Rafael J. Wysocki wrote:
>> On Thu, Feb 5, 2026 at 11:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
> 
> snip..
> 
>>
>>> 2. Excessive Polling (Timer Overwrite):
>>> In `smi_timeout()`, the timer is unconditionally reset to a short timeout (e.g., 10ms) at the end of the function, unless the state machine is IDLE. When the state machine returns `SI_SM_HOSED`, `smi_event_handler()` correctly sets the timer to a long backoff (1 second). However, `smi_timeout()` subsequently overwrites this with the short timeout. This causes the driver to poll the hosed BMC every 10ms instead of backing off for 1 second, resulting in unnecessary CPU overhead.
>>
>> Well, that's not nice, but it doesn't seem to be related to the
>> observed symptoms.
> 
> I have a fix for this, too.  Thanks for the report.
> 

Thanks is due to Gemini 3, really (I would not have seen that problem),
and to the AI model used by Igor.

Guenter


