Return-Path: <linux-acpi+bounces-17153-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91AB8D87A
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 11:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D56189F58D
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 09:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36F72459D1;
	Sun, 21 Sep 2025 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="yaL830jS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FACB1B423C
	for <linux-acpi@vger.kernel.org>; Sun, 21 Sep 2025 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758445813; cv=none; b=mLsGBdxI5uPDQK4HqlfZlJA6i4Be7GT6fvbJgPViPwxTPbaHHviQ0KG2Vo27bZRtUQnPvu6d2aSEJ3WCvYGOu6DpW8hP5Q+8c37qWg3YCwUcGVJmX3f6nmqJwzEORIN9GOdrK5018E7opw39JHQ2RW0H6oaaNbFwErUCgfKvNRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758445813; c=relaxed/simple;
	bh=ZLu4vr/0J+urzLha3wPwxJqs/65EMfgiHdWUUkRBON4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MJTt/TuKANa0b3WGIuZArdeQQ6frtEMAJC+0A2HKttMnA5Ek+8NmVxZyie+k18tDT2ndk5dn0tm1R05ApwWl1ZT0DLR5x+xmB3ocqkQ65DIu5oOCoIqgUZV12RIHvO6fqkSDoJeh7ce5gSHk4BxnZjppbO7QthRX3AKGusguorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=yaL830jS; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 0AF4060126
	for <linux-acpi@vger.kernel.org>; Sun, 21 Sep 2025 11:01:47 +0200 (CEST)
Received: (qmail 7682 invoked by uid 988); 21 Sep 2025 09:01:46 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Sun, 21 Sep 2025 11:01:46 +0200
Message-ID: <34b11aca-0bbc-460d-815b-82f173974a0a@david-bauer.net>
Date: Sun, 21 Sep 2025 11:01:46 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: add quirk for Lenovo X13 G4 (AMD)
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20240831003610.89970-1-mail@david-bauer.net>
 <84ec8f08-bc7b-490b-a6f3-0f41ca99dbc0@app.fastmail.com>
Content-Language: en-US
From: David Bauer <mail@david-bauer.net>
Autocrypt: addr=mail@david-bauer.net; keydata=
 xjMEZgynMBYJKwYBBAHaRw8BAQdA+32xE63/l6uaRAU+fPDToCtlZtYJhzI/dt3I6VxixXnN
 IkRhdmlkIEJhdWVyIDxtYWlsQGRhdmlkLWJhdWVyLm5ldD7CjwQTFggANxYhBLPGu7DmE/84
 Uyu0uW0x5c9UngunBQJmDKcwBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQbTHlz1Se
 C6eKAwEA8B6TGkUMw8X7Kv3JdBIoDqJG9+fZuuwlmFsRrdyDyHkBAPtLydDdancCVWNucImJ
 GSk+M80qzgemqIBjFXW0CZYPzjgEZgynMBIKKwYBBAGXVQEFAQEHQPIm0qo7519c7VUOTAUD
 4OR6mZJXFJDJBprBfnXZUlY4AwEIB8J+BBgWCAAmFiEEs8a7sOYT/zhTK7S5bTHlz1SeC6cF
 AmYMpzAFCQWjmoACGwwACgkQbTHlz1SeC6fP2AD8CduoErEo6JePUdZXwZ1e58+lAeXOLLvC
 2kj1OiLjqK4BANoZuHf/ku8ARYjUdIEgfgOzMX/OdYvn0HiaoEfMg7oB
In-Reply-To: <84ec8f08-bc7b-490b-a6f3-0f41ca99dbc0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Bar: --
X-Rspamd-Report: BAYES_HAM(-2.9096) XM_UA_NO_VERSION(0.01) MIME_GOOD(-0.1)
X-Rspamd-Score: -2.9996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:subject:date;
	bh=ZLu4vr/0J+urzLha3wPwxJqs/65EMfgiHdWUUkRBON4=;
	b=yaL830jSbINAtFBGamILJvPaDEy4UPuo8mPwgT7XaVA7XBG5D7N6wM+m2lGuJYx1M7/7bvGbgb
	+44ybOzCkioDF3/GHViOyBWqVhf+UANwEwh1c9s/SDBvULwjxr4DaoJhpw+fWACHOzs7My/1/IW8
	GKAGpbxPwYEnxOieXrE9PpoRndGW7fFI+QumEpUU02Hs4mH3p5fHv1tEQonsaIHXmVgC1QTNEIuQ
	CiPBopAdf2rifPZx+mlq83B0yRfWu4aqbN+B2z6Adn5WW3empd7DMKCVajHpFEhvmmy/0wBKeh4z
	2Kqz3cjpFjzBoNyj1k4cx7h+uaXMzXz0Js/0dfOw6KZ8BD+Kjvn0c8DX7QhnX6GcR25CqafFy4rm
	/xWt0/mt2C2LSQkb01CQvJ7DqDDe3CfUbMdLEUiTgAhyHnR5ki5zSHBrnXsnO42MEo9TCJt0TD47
	uEDIqeSkOsct90m2IqSckzWP7Z+qp4KxBP8gzkrZqm2jY75AH29eflODsO5I6iDBL3bJw1Xt0pmn
	THUQXVpSLqwB1G5tSwEtEXkagkfsw+dyjpQScLiYXF1zNxZp4l0AEC4HQR9lCPLateefw7+x/sMv
	C9RNaaFjTSolIfLgU7pzK5nT2eKAdTN0uaVfE1I3P5HTprDWxZs1gArrr/OLidtaztulAph9mA49
	I=

Hey Mark,

On 8/31/24 02:53, Mark Pearson wrote:
> I believe you've hit the issue that is being tracked in https://bugzilla.kernel.org/show_bug.cgi?id=219196
> 
> We're working with Qualcomm to get that addressed. It impacts systems with the Qualcomm Wifi chip that uses the ath11k driver. I haven't specifically reproduced it on the X13 G4 - but we've seen it on three other platforms and it sounds exactly the same.

I have seen patches [1] have been applied and gave 6.17 a spin.

First of all, the product number for my X13 G4 (21J3) was missing. I've added it myself to
the list of platforms requiring the PM quirk, however I'm still seeing wakeups on AC power
state changed while sleeping.

Does the patch retain sleep functionality on other platforms?
I'd love to help getting this fix, in the meantime i resort to acpi.ec_no_wakeup=1
which fixes these wakeups.

[1] https://github.com/torvalds/linux/commit/ce8669a27016354dfa8bf3c954255cb9f3583bae

Best
David

> 
> You can confirm by using a 6.9 kernel and it should work correctly. If it doesn't, please let me know and we can investigate further.
> This is a Linux certified platform and I'd rather get issues fixed correctly than have to quirk them in the kernel and potentially impact other functionality.
> 
> Thanks
> Mark


