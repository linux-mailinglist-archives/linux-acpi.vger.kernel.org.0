Return-Path: <linux-acpi+bounces-20892-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APp1K6FChmmbLQQAu9opvQ
	(envelope-from <linux-acpi+bounces-20892-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 20:36:01 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B6A102CFF
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 20:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D630D3004D80
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A214C309DCC;
	Fri,  6 Feb 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2QjKPPj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFE1240611
	for <linux-acpi@vger.kernel.org>; Fri,  6 Feb 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406555; cv=none; b=ILqKL+fbS8PWnkBBkwhA4e9xDazUz5ppHb0ZO7CLD279kjStWNilkDvmx7nf+sdP6iExwjnv28pMDe8BGQEL8ypgre5rF7DYuKZ/q0u4pQDF4lknQXDG+Id6q9lyiKbCoa2erkCpmgJt0dpJwqd+7Wyg/jrkxWFaJzcRIL+FF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406555; c=relaxed/simple;
	bh=oRf0JIwZUDaaXV4KZFNbvumYEkV3ZmLhwkG2OaRKQsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OF2kaM1Z8W2WV6zhT9XD8tEEdeDuD7RNigz1fzPfg0FX2L2ekb6R6BpmD4mW+WKp14b8j1ntV6nfwzkAR18jfQ86KiO9DcUlBsc/BofilY2Nc4XRw6y4K5NA7pmmNIB/7lQ/ZCC3mKruusCIhOFB3iSpUfehLO2KsFxAQRYUIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2QjKPPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216F4C19425
	for <linux-acpi@vger.kernel.org>; Fri,  6 Feb 2026 19:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770406555;
	bh=oRf0JIwZUDaaXV4KZFNbvumYEkV3ZmLhwkG2OaRKQsg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W2QjKPPjcNOgFggiX18XF6n02xbwW1441e3KgJztVwoePC6my1vtHl4ngnzsde+Bv
	 Rrr3GBu9OZ5pByKC0jcSUEyhdpcmeVtV8JZ9BxR+Khu3s9O0/X4xCde2J93hdIpfVd
	 RpVgL9yNH8vKWYAeUvmvzxXwaGA61pZqZ9Jq7hKiQSI3l+YHykbjCM9UzOwFPFqc5J
	 6VZN1NPaMVyXR5j0a6oRyg1DVByLfcUrMrk9LRAZSgDAHgSE6eITNmnarBRRqg8Xaq
	 rmygnYieKbCPvbjEGvOPr/a0k5M7cf9BC2Rn11bWVkRBXg/5dtJ2nPiucz5rucq7Sy
	 OjthoqiiLzNRw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-663170b9472so1473844eaf.3
        for <linux-acpi@vger.kernel.org>; Fri, 06 Feb 2026 11:35:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX07gMeY8Q+txZhpwLf0jZcP3k+jOlpot75RBMmhhu2QHopfk8SKHh2CBdjX4pXoovRFnL/vP0AFHsi@vger.kernel.org
X-Gm-Message-State: AOJu0YxBiOVbnKuN1ynAOkylu1/R4p20BYAlBXX+6Qs8Bs01BfhYhyZC
	YCYsc1u92BMVoSBzRebTJjdE1KG8ES/dJdpbSMlxoEHwF8w6Xt1xG9W7c1ZMQHN24GrLqpl20LN
	m6BWi/LBknN2SIfEtiKDBHC29a4Q3RXU=
X-Received: by 2002:a4a:b684:0:b0:66e:4279:3e13 with SMTP id
 006d021491bc7-66e427a01d3mr413777eaf.48.1770406554153; Fri, 06 Feb 2026
 11:35:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ65Vro5nQqJq_cvsY93hgDbfTdibWnNr5b0Bixzc-ESfg@mail.gmail.com>
 <CAK8fFZ6Vi4xayvdKh-_eLi-nDNMLuEoMsvwEnb33QqnwS7o4BA@mail.gmail.com>
 <1c8f748a-5c5d-4234-ae86-7bb12045a373@roeck-us.net> <CA+9S74i+BC3=E0opOPMff0cuC1OPYSecii0C8fVZ+NM7bptNcQ@mail.gmail.com>
 <fee01c19-2711-487e-91e9-d57f9be04b98@roeck-us.net> <CA+9S74jR9jRRE-DNMxNg=6Uv2uDAUar2n-RkVDJqzkDfNu3eog@mail.gmail.com>
 <39100538-a1f3-48dc-82d6-5e3314a43b4d@roeck-us.net> <CAJZ5v0jo4CV__AoUfqxuhVgkw6hA=hM_fBU+W=pTzqDLmNmytw@mail.gmail.com>
 <1642aec8-e8c1-4ad4-a5b7-556feeedfd93@roeck-us.net> <CAJZ5v0i_BmeGROzQFpUCyF5MkA7sFkP3y8jjqH0mD2r2Wqj_xA@mail.gmail.com>
 <aYYSDWaeiCnkwqAF@mail.minyard.net> <c9ecdbd1-cc50-4e3a-9540-6a4917dc07d6@roeck-us.net>
In-Reply-To: <c9ecdbd1-cc50-4e3a-9540-6a4917dc07d6@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Feb 2026 20:35:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ht59yZ6jetQfM6TTm-AGVanJk2dO5mDUvYgnY+_bOghg@mail.gmail.com>
X-Gm-Features: AZwV_QgUF5YPX8vK3Fbkcxgm9UpsQW5nwD6lJM9zBKWeOxC4vTdEhktARX9k8po
Message-ID: <CAJZ5v0ht59yZ6jetQfM6TTm-AGVanJk2dO5mDUvYgnY+_bOghg@mail.gmail.com>
Subject: Re: [BISECTED - impi related]: acpi_power_meter: power*_average sysfs
 read hangs, mutex deadlock in hwmon_attr_show since v6.18.y
To: Guenter Roeck <linux@roeck-us.net>
Cc: corey@minyard.net, "Rafael J. Wysocki" <rafael@kernel.org>, Igor Raits <igor@gooddata.com>, 
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>, Jiri Jurica <jiri.jurica@gooddata.com>, 
	Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	URIBL_MULTI_FAIL(0.00)[roeck-us.net:server fail,mail.gmail.com:server fail,sin.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20892-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2B6A102CFF
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 5:31=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 2/6/26 08:08, Corey Minyard wrote:
> > On Fri, Feb 06, 2026 at 01:08:56PM +0100, Rafael J. Wysocki wrote:
> >> On Thu, Feb 5, 2026 at 11:34=E2=80=AFPM Guenter Roeck <linux@roeck-us.=
net> wrote:
> >>>
> >
> > snip..
> >
> >>
> >>> 2. Excessive Polling (Timer Overwrite):
> >>> In `smi_timeout()`, the timer is unconditionally reset to a short tim=
eout (e.g., 10ms) at the end of the function, unless the state machine is I=
DLE. When the state machine returns `SI_SM_HOSED`, `smi_event_handler()` co=
rrectly sets the timer to a long backoff (1 second). However, `smi_timeout(=
)` subsequently overwrites this with the short timeout. This causes the dri=
ver to poll the hosed BMC every 10ms instead of backing off for 1 second, r=
esulting in unnecessary CPU overhead.
> >>
> >> Well, that's not nice, but it doesn't seem to be related to the
> >> observed symptoms.
> >
> > I have a fix for this, too.  Thanks for the report.
> >
>
> Thanks is due to Gemini 3, really (I would not have seen that problem),
> and to the AI model used by Igor.

Well, Jaroslav reported the misbehavior, tested patches and then
bisected it down to the problematic commit.

Without that we wouldn't have known what to feed to the AI even.

