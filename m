Return-Path: <linux-acpi+bounces-21161-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDULCy47n2m5ZQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21161-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 19:10:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2C819C0F4
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 19:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60B40305A97B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625C22EBB8C;
	Wed, 25 Feb 2026 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ef3mosPO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9DB2EAD15
	for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043042; cv=none; b=m7ISljJtfqJVqW+skrxrULajD7/0SmHVf4GpJQfBDES533nt5wTvPkGT7WpZAiBPGEPk44We+qUAKopr3VndThl7DEP+2ASD24GJJ2M3ZL0bhAirVOIezxih2ETMiyyNun7ZSZAgRiCC7HUhAGLTeOoZRn61sHHDd/MlUXToRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043042; c=relaxed/simple;
	bh=YNTwvo/Pda57gkHbqBvSuOxAQKDUGF2V0zFCz7zr0/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJ6ZcvLKXoaBgXETNeyFFJnn2QjExw617qYz+7U4pKnDLpi5lfLXk/9s8ZkvbGKylE0gb+/qxEBqM5YY+PzUdShchpydrlzbMHTS1xAl9GqfjffKf4ThvyF98dkZmxtlMz/kLztcxGb9HeAEy9KaliH8VE9hcx/5dbm++hzztec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ef3mosPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0368C116D0
	for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 18:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772043042;
	bh=YNTwvo/Pda57gkHbqBvSuOxAQKDUGF2V0zFCz7zr0/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ef3mosPOQu8mfIISLKfEJ27f8kWxtRuUsdK8YD8yumzxgcX5SK18OWBAa9+rkv3c+
	 1CpjwF7wwW2uW0Sw4Qr088SbJ1l/hoXbnG3bv1WbjOONNlgQN+nj5eyAh1E/R7sq3P
	 EZJRFZ5HNeOIuA+el3fKeqxhqzRl4WJZvWWto+Wmal2zDXPcC/eZeZjlb3GB8zsm8i
	 fhYrE93qmKIbx/mnlAxLo+xmq5ugPEBYdt5L4VuWXqVJ0t/4jU1EjQ9Velry1UgPLr
	 W063QVvE2AIydrW9zxslygbFEXbmeTo9+qkGAXfZqaHaJSgDPXa6NkGI7lP92unjl/
	 yByxDTmln8B0A==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-66f3e7d9eccso42854eaf.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 10:10:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+4eWr1RoIxcS47EGyyKzuDRGaLm3MrokNmVFXbk8KytyvgXjdWFihP7FkWpvmpkqaL43v5+nPweua@vger.kernel.org
X-Gm-Message-State: AOJu0YzzzA2diawjTLuQsup2zL+ryBpnNoQPD1UKXpfRWYx6Mvi/bgf+
	75c2jUByKIMGDk/jyxF9ryuA1JFRVrRWNbe6UevdwXhch7cmEhYST2zZWnKaxBaNRPMuGM3guur
	2pxrOBORoeL2QTeQBmVxyt5+voxkcUBc=
X-Received: by 2002:a05:6820:4888:b0:675:a193:b9ab with SMTP id
 006d021491bc7-679c40a0216mr6506809eaf.0.1772043041055; Wed, 25 Feb 2026
 10:10:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5983325.DvuYhMxLoT@rafael.j.wysocki> <8660687.T7Z3S40VBb@rafael.j.wysocki>
 <6b751b23-ded2-4343-bf29-103f4a7ab6ba@intel.com>
In-Reply-To: <6b751b23-ded2-4343-bf29-103f4a7ab6ba@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Feb 2026 19:10:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iydudmE_HQVKCrMVtnUK0YKOd_XiqJwnR8Y9W3OL6CLw@mail.gmail.com>
X-Gm-Features: AaiRm51rEBLt3EUFbi7RLHoBLLxSr6ongn-NfwzYafPxsNBFpjS3KQ9hZSgGHZk
Message-ID: <CAJZ5v0iydudmE_HQVKCrMVtnUK0YKOd_XiqJwnR8Y9W3OL6CLw@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] x86: rtc: Drop PNP device check
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>, linux-rtc@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21161-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: AA2C819C0F4
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 7:01=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/23/26 07:31, Rafael J. Wysocki wrote:
> > Previous changes effectively prevented PNP devices from being created
> > for the CMOS RTC on x86 with ACPI.
> >
> > Although in principle a CMOS RTC PNP device may exist on an x86 system
> > without ACPI (that is, an x86 system where there is no ACPI at all, not
> > one booted with ACPI disabled), such systems were there in the field ~3=
0
> > years ago and most likely they would not be able to run a contemporary
> > Linux kernel.
> >
> > For the above reasons, drop the PNP device check from add_rtc_cmos().
>
> If someone had one of these devices, what would they see after applying
> this? Would they just not be able to detect the RTC any longer?

No, add_rtc_cmos() would just create a fallback platform device for
the CMOS RTC AFAICS and the driver would pick up that one.

> In any case, this does seem obscure enough to not worry about any more:
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # x86

Thanks!

