Return-Path: <linux-acpi+bounces-20889-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGD0B00Shmk1JgQAu9opvQ
	(envelope-from <linux-acpi+bounces-20889-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 17:09:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7491000FD
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 17:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B5613007A5F
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 16:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A288305E28;
	Fri,  6 Feb 2026 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="QRJciJ/4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA212D7D3A
	for <linux-acpi@vger.kernel.org>; Fri,  6 Feb 2026 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770394132; cv=none; b=ALBquCXRjV0n1aPNxA89YuMccguPbzAeF8SzOI4mPJqAjzCUnzNW9biAfZjr9162T/h8PsmNPaZRrqfhBal10F+PK40YnfPEVt3UqvUBoYfn0esFMw4AJ8QP7ii5iTTYQPojZE4MXDZYm1vT6+LXo3FYHOeEsfgFHThaQe7ZaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770394132; c=relaxed/simple;
	bh=Uqs+mtOZusE8Tmu6i+HWZhiMiB14vwiEy84r6G8yhxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qrch5sN5dj+VcbaqhF1vhy6b/fR0uqEZhiqI9n6tU9Lmf1MGnpjRESPgfkXiacBbUy9NtdfHZhNOrjEm7GjI0yvkOz9vJWyOBslnx5Ik1l1jOL4dEdrHHVUt/i5L7Me8/TIr5Q0B+FFMZu8G0Hsw9IABy9BSUlXOHRIUl61G8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=QRJciJ/4; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45efde72438so1497618b6e.3
        for <linux-acpi@vger.kernel.org>; Fri, 06 Feb 2026 08:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1770394131; x=1770998931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7ouzXPawCJ+kcfApoQEXHW5et7PBTD2zyd+Y6A9AqQ=;
        b=QRJciJ/4pF8BJl5AFMNl7759acLWraozEURnptPoUo/vOWdkZFLXDC4rNEPYfCgt9y
         vLVvNUFQsJdONDZpNehm5Y4Xththr9g2DOLr8qL9ugRcmuPwbprfRkeSUGy6JDOoNtAZ
         mrKXuMRRidJd41fX+DoBdt9WTrBMnNGSjcBSUxTj3OFk6gUsBtXdHbFVQEMDE2UF6VEA
         TN64rL6Q3vikBr9Xpq/LfZDpujt7ZJNAzAlU2+ucZ5M019z0M8DbjnAEzoxRC+nybN99
         jGqC11/TKpT63xE7Be3SNkB6FOzYDFYM+yUeB3uYQ2xIEyljUJ44E+heD4tzipI2ODgh
         qmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770394131; x=1770998931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7ouzXPawCJ+kcfApoQEXHW5et7PBTD2zyd+Y6A9AqQ=;
        b=TMjkaxeqq3ogkrNNlVqOuF4ujp6YFPhjlso326+zfk/Y6TOvOqcGhhCquG9ocTO72u
         UerhRhz40k5cXgn9Ffl6TdjRkMyC6gAeej/NIyH7Fl1HpSib5AEyL0abwCPF+KMHKSKM
         x8XgV+Eyqs3GLDYaSSR1UsIMka+bARmbpgcAueMAJLXv+rVMb2AB7IUM39knDHJtTDb2
         YtCFUbV0RvLPracPefpe7ZXTlBe2toccLj2NJBYVjQ4NgONmTK72gaFhTUQ8q1r11awe
         lItFdZrO/H9ynyvPd3RB8QldWbqbO5dzX7Y4zoqHCR2lvNEZb70gffawAdOgkGrISRqF
         my/A==
X-Forwarded-Encrypted: i=1; AJvYcCUuR1IsdZ4raIocEYOmX7ahl3oQioceePqIeidRs2jut0PIcbl/BF0IfxMgaChKPPcrONbQhm1RYWQ3@vger.kernel.org
X-Gm-Message-State: AOJu0YxHhjgo8SU6QkODMfv+/M7XgYsoeTf3sthPmEHOuOZLQC9Kb+Df
	jAIiOz6EF/BEgWQdBqMgxbf9K2VUVVQbcd6YkWQVOyOUe75/rjciYKkBvF2dufDGsx0=
X-Gm-Gg: AZuq6aKXagLCuTIbGWpXDBZN3nMCDQSRBpLTsfUiQnewoECTNX38GzEIDFcAsJapsUu
	lRyS+fFSPmvmfwNwvucL6EY7KEKSW8gxJZNyMWroWxvXj9sqHsle7bnWtchm5ltcokk7eej8jF/
	KVQgiZprUKv2RqolHYr38+vLifZtKER07dUX2bWknNDTAEP0zcYfk4/LuOj2XO4ZvZ4xvmU3P+L
	/RdI3AgacGoAygRW81QC5s39Y5WjSQs6/8tf9di3dy1012YQhelDQP9BDCBBYgGo+vT7kZep0P1
	YQasGE9xW6P0037oLry/CCHDbQR8HEDIxgoSqJCL0SwOmqJWrqdmSbgEmVaGjeMGeeM0uDc2ZpO
	V5PQrdZ/HE9plQ/pAQ2MT58dxW9Oecn8MxO5DlXkoJGGV6YMup8xrtRr+X+ErJlk9UCcAL68z4N
	DNESovYCBa4An6AlrviyYqALwC0lu3PR65TFFzBwMpaD3uYsVBWw+cSTMJ1gLw+vd6gJJpyqlaz
	Bcu8GpTSeo6XpA=
X-Received: by 2002:a05:6808:17a7:b0:45e:bb87:872a with SMTP id 5614622812f47-462fcb46cb5mr1739338b6e.52.1770394130798;
        Fri, 06 Feb 2026 08:08:50 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:aed7:ea82:7abb:dd28])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462feaf9410sm1511473b6e.13.2026.02.06.08.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 08:08:50 -0800 (PST)
Date: Fri, 6 Feb 2026 10:08:45 -0600
From: Corey Minyard <corey@minyard.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Igor Raits <igor@gooddata.com>,
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Daniel Secik <daniel.secik@gooddata.com>,
	Zdenek Pesek <zdenek.pesek@gooddata.com>,
	Jiri Jurica <jiri.jurica@gooddata.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [BISECTED - impi related]: acpi_power_meter: power*_average
 sysfs read hangs, mutex deadlock in hwmon_attr_show since v6.18.y
Message-ID: <aYYSDWaeiCnkwqAF@mail.minyard.net>
Reply-To: corey@minyard.net
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
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i_BmeGROzQFpUCyF5MkA7sFkP3y8jjqH0mD2r2Wqj_xA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20889-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[corey@minyard.net];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,minyard.net:replyto,minyard.net:dkim,mail.minyard.net:mid]
X-Rspamd-Queue-Id: 3F7491000FD
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 01:08:56PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 5, 2026 at 11:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >

snip..

> 
> > 2. Excessive Polling (Timer Overwrite):
> > In `smi_timeout()`, the timer is unconditionally reset to a short timeout (e.g., 10ms) at the end of the function, unless the state machine is IDLE. When the state machine returns `SI_SM_HOSED`, `smi_event_handler()` correctly sets the timer to a long backoff (1 second). However, `smi_timeout()` subsequently overwrites this with the short timeout. This causes the driver to poll the hosed BMC every 10ms instead of backing off for 1 second, resulting in unnecessary CPU overhead.
> 
> Well, that's not nice, but it doesn't seem to be related to the
> observed symptoms.

I have a fix for this, too.  Thanks for the report.

snip..

-corey

