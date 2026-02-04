Return-Path: <linux-acpi+bounces-20847-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEA1BZgBg2lGggMAu9opvQ
	(envelope-from <linux-acpi+bounces-20847-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 09:21:44 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A781E30F6
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 09:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71AB9301E3E4
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Feb 2026 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D00392821;
	Wed,  4 Feb 2026 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="oA0eyKsQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5711353ED1
	for <linux-acpi@vger.kernel.org>; Wed,  4 Feb 2026 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770193255; cv=pass; b=GYqQJE1HJDlFWWBTR/vX7pndDRKwyqHR6uIFujhOixgZRmB0hy4ngQ0B9Zmd8VKAk9yvJHtLxD/iniJ6daMJu89Wm1+TrDwlFcE1/VQEYcOsZgC/IMtY8zhrW4gB7ii/qbiEtHlnhqVw3HyrFMASw70OSPRIWMlqDl4ZNKpX+vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770193255; c=relaxed/simple;
	bh=yQwGJnp8nFSA8oli4GbB6SkUvqn3H61QJ80HMfFj484=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8viox9SH14gswlV7eJJZ9XJ8q9IZmgkZIdcF9V6zSaMRz17CPglYHeOtp1EY5txcDe4lHboV7vYGQRlc9CsCp5Zm8hrQUbBpX7CDbi5HbgXpByzxiVeuiLoxitaLN8NlrEdurmKOtPD/XnNN8kjT/SoOgFAOlEt3QALfgzNfSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=oA0eyKsQ; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-124b117776fso4062357c88.0
        for <linux-acpi@vger.kernel.org>; Wed, 04 Feb 2026 00:20:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770193255; cv=none;
        d=google.com; s=arc-20240605;
        b=QdMt+DVGJo6pDXd0xPpHMCZwCOZOkrDPZ/tK22/yOzLrXRDtqtigvQAzqPapUVuucL
         3r328cHbBvW8t9POZql2YOthUeDlA3/IghA7bceufmAb9aZJCwXIA0eJ9u2Dd5jmFJK1
         ISbqpnQ+XXixY1ZuogUJyZkNnvPaYos1vK60ug04F+fzEDKORAzjFCsBPVUuT8fZHnZ4
         UOdM3kZRZJzSVAQTsH2eocMhFvU/nrz61IPruJTLFQ7N5xDyPjapWm3y08C3nu0jF+K5
         8WA6LErZIrJkVpPGuM+mq3k05J0sRcSoVGUGbMJM4HR7eD53d2xP0NYzgPmHNIcy2fxr
         f2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UpVUHH/DUdD2rsKBwnHapoi48eE9XHeYgIxbMBSYxjM=;
        fh=ENp/WNSDP4DEFJKE4MyJPjK+oVxM+h1+ytYFfiHQFl0=;
        b=SW97HE6WiMZdL2VUTvYpaMTxfvRTc5f6Z2e31QphWteB6+EabGH8QZrguIMZaejx3o
         Cwx3knXmQbQl1uXCi22Cm7eHV1Tt3cQez2a6XaeDkhT+u26cDUDnXamN4aEd4I0K7tgZ
         DVNKOEg66heAbaylGG9ULldHqXVpNNZ6W0KKrtLeKxnY7Ju2xftpHTXAJEqiOH4x56bl
         RL6uuYO9vK+lIMoPlPhxo2/a158w6zFo+mFiuZtf5pQoMbYaOLGstxufvVCb1iQhBB/R
         VEDK/wGNjfg/0PEr/I4fdU/DhiA1GxGlMNg39L+CVo7M5fhsMA2njbV1jyzjJCMbrrJX
         DfHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1770193255; x=1770798055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UpVUHH/DUdD2rsKBwnHapoi48eE9XHeYgIxbMBSYxjM=;
        b=oA0eyKsQPI5VELQvxjxyxcjUsJHmTVFuQAkAhAaQwizSKigs5zbXG1Kfwq8giOJ53B
         oEVax2iuOywY9Hu93j0wpGKDygN/WaM48yErii9QI2zDf21M8yO/xQXpJt/9USc4rShp
         hsvPgJPFaeX3qrEvvWqW7SNAxkx7VIrpZZJ54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770193255; x=1770798055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpVUHH/DUdD2rsKBwnHapoi48eE9XHeYgIxbMBSYxjM=;
        b=bq4sFGNAA3B2lIIyAKf/4If0scS1HLZB963nXCdNWKSJlia4LaiVJfkp51DxzqKpMi
         WkSgK+RfBgVdTTGWHhTIEdNCWxMcyRghY2E+sLQHPemZaDGbX8R4cA+X8xe6ZSlzXrsM
         TIj28HI/8RtLjFUBlce1YP5rNmRyxjbyVUPDAczk8GQ6CMSMbGspC5o+7iPFzkijjYn1
         b6JqS42go2CYyKNbo8Zmg5qQhrST/oq1kvTc8dI6ieGpsicVsCHltw/dNIROyvxyWqyR
         cwzWkQpe8vdKIK4zZynNOOT3/OcquQOElScuNhhuJXUdYilhCBn9x4V/JmRwq5NsJTGR
         aWhw==
X-Forwarded-Encrypted: i=1; AJvYcCWEO71/idknAanMnEYa3os3f/U3Xd1pxmR2goUKAm8s6GWrcFd9JpDHUXnY+xqDVFOGDChaww52Wpjq@vger.kernel.org
X-Gm-Message-State: AOJu0YxYZo/afeZ31Pncm4f2eUUHZhYiLpbNVuViykIkewT9NJqv4LdQ
	z7Ex9k+3chVxHyW20+bzSUfPswq33WIpv6imVAGGGSrm6IFbxxtUuTpxKghUWKJs+Q0EUTddzPA
	gBA8sa9we1KOawPWuu0dxeCg2Wyuo+DW76AUsg3jm
X-Gm-Gg: AZuq6aLkbbOMdjmeuh33pHKE/KFVrN7UGhO96zi4JxN1/cMpbtcoG0dvQkx9OH65Ccb
	uoMoiBtGExFbDo3Byx+oJrBppst6R9QcvGr6gVS/9cXCg6unPa4p1s1E98aakclLTcbB4qDTE2h
	o+A2ReUxvv8RFkrLHQhYzC81m/t4PctHoB5hfrOmjlBBAJ8vWeZ0lTjkwhYs12FrgFa5ayB3wqB
	XxgXcZhUDDkF/8rAVcjmPT+OPSk+L6B+Z2RKv39spxg1dGBD4NohL9YR1oV3B3BvbsSFl+VI2AG
	ibu5KPY=
X-Received: by 2002:a05:7022:2506:b0:119:e56b:98a4 with SMTP id
 a92af1059eb24-126f478f949mr1114334c88.11.1770193254712; Wed, 04 Feb 2026
 00:20:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
 <d7f34e0f-e258-4fef-93eb-1ef0a3123d95@roeck-us.net> <CAK8fFZ4izdX_HDtGN60CZ3Ta61nqkUg7ncViM=mGgxKki_5FoQ@mail.gmail.com>
 <a7334568-13ce-4600-8650-607273e67976@roeck-us.net> <CAK8fFZ6gKs7s2rJ=f7bt24f+_cY-jGU33TvX3UP=U58uK-1KaQ@mail.gmail.com>
 <fff54ec8-496e-4c26-b652-358dc4de0de0@roeck-us.net> <CAK8fFZ4wEUdMAHkfdC_z8ohYB_rEXZ=dHArc75jDibgQ_-ozKw@mail.gmail.com>
 <4f151d4c-fdc6-4281-87b0-b7120eeb1b46@roeck-us.net> <CAK8fFZ401-nez_CgDTTnQiPT=oBRRJuYooXyEKFuCdHpGCPXtA@mail.gmail.com>
 <27d60756-d33e-4926-9a02-f52505339de6@roeck-us.net> <CAK8fFZ43wrQ8A_bO_g+rKN9O31sxULtqA0hUieZSzEH5KqeW1Q@mail.gmail.com>
 <CAJZ5v0hEu_io2BAzp9weUDHwHngorjZ37GRUK=ngSXNjtp38qw@mail.gmail.com>
 <CAK8fFZ65Vro5nQqJq_cvsY93hgDbfTdibWnNr5b0Bixzc-ESfg@mail.gmail.com>
 <CAK8fFZ6Vi4xayvdKh-_eLi-nDNMLuEoMsvwEnb33QqnwS7o4BA@mail.gmail.com> <1c8f748a-5c5d-4234-ae86-7bb12045a373@roeck-us.net>
In-Reply-To: <1c8f748a-5c5d-4234-ae86-7bb12045a373@roeck-us.net>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Wed, 4 Feb 2026 09:20:28 +0100
X-Gm-Features: AZwV_QgEcGPFEtMQ44PFqqfa4Vwe2eBylAQU3_AL8hBX4XKGTsX1VUgdzIPJsbQ
Message-ID: <CAK8fFZ4YhuE5ygveCet3aGyOsL1e+kD1U4kQDVAe0dZECjYu9A@mail.gmail.com>
Subject: Re: [BISECTED]: acpi_power_meter: power*_average sysfs read hangs,
 mutex deadlock in hwmon_attr_show since v6.18.y
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, Igor Raits <igor@gooddata.com>, 
	Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>, 
	Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gooddata.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gooddata.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20847-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gooddata.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaroslav.pulchart@gooddata.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A781E30F6
X-Rspamd-Action: no action

>
> On 2/3/26 15:21, Jaroslav Pulchart wrote:
>
> > ...
> > $ git bisect bad
> > bc3a9d217755f65c137f145600f23bf1d6c31ea9 is the first bad commit
> > commit bc3a9d217755f65c137f145600f23bf1d6c31ea9 (HEAD)
> > Author: Corey Minyard <corey@minyard.net>
> > Date:   Wed Aug 20 14:56:50 2025 -0500
> >
> >      ipmi:si: Gracefully handle if the BMC is non-functional
> >
> >      If the BMC is not functional, the driver goes into an error state and
> >      starts a 1 second timer.  When the timer times out, it will attempt a
> >      simple message.  If the BMC interacts correctly, the driver will start
> >      accepting messages again.  If not, it remains in error state.
> >
> >      If the driver goes into error state, all messages current and pending
> >      will return with an error.
> >
> >      This should more gracefully handle when the BMC becomes non-operational,
> >      as opposed to trying each messages individually and failing them.
> >
> >      Signed-off-by: Corey Minyard <corey@minyard.net>
> >
> >   drivers/char/ipmi/ipmi_si_intf.c | 29 +++++++++++++++++++++++------
> >   1 file changed, 23 insertions(+), 6 deletions(-)
>
> Now that is interesting. Does reverting that patch on top of 6.18.8
> (or any other 6.18 release) solve the problem ?
>
> Thanks,
> Guenter
>

Yes, reverting commit bc3a9d217755f65c137f145600f23bf1d6c31ea9 on top
of 6.18.8 prevents the issue, and the problem no longer triggers with
the same reproducer.

