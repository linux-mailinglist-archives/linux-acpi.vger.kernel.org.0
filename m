Return-Path: <linux-acpi+bounces-20680-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APa3LokLeWnyugEAu9opvQ
	(envelope-from <linux-acpi+bounces-20680-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 20:01:29 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8CA998A0
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 20:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B2CB30093BA
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 18:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AE332AAC1;
	Tue, 27 Jan 2026 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO/fVk9K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9FF329370
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539864; cv=none; b=NLJjOmEtkcaL3DAV6Q4wsVP2mg1LJGgTQOFG7HPMURLpA9N+osErB7FzCQDRFHCVeB0kxlfm9C011pDzV+38lS4E7SPkjGyqrbS+rwzfxM4we8FluJt0/p/ak99ir0479yMPadvPMU73X1BXV51oR5IKXvBBbSHYWWh0y978BIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539864; c=relaxed/simple;
	bh=5fCSYs3cjWXNj6kD6uXFDIhla+bxW6w8hXBfqk6eHrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHSgpnu6sTZN9gXobXCSsG4xB5xmiN+Uee+QpJb6rK9djO0bhBtgYjydP9EuiDEe4GTKfKeqqscJVw/tWetA360S3wJPZ4ZjkKdSNY2/oP9VVBCzXhmmblBiYtzc4erjzbW3TS37u5wTQtUHX8qIvnD4xHvoazCneoukJYxhgXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO/fVk9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CCFC2BCAF
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 18:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769539864;
	bh=5fCSYs3cjWXNj6kD6uXFDIhla+bxW6w8hXBfqk6eHrs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rO/fVk9KGOIQL3qj9zN8GwXwvNOtSBr1xxy+CIrUR83dXroBccPza54wycaffC/3V
	 QNSuK8/wRgmyJChwXoett1m0vsu9yc5a9tAW68Nu+OCg7iEjauaP784XOjOGU22qlt
	 ATxskFX4anozd4Ez/lqhpViS8/NSris7/FnHzkRtJkHAxbHDpC0r/Jw+z3MZaCsQfM
	 RvfoSQFd8uH9MqUc2p1yE3ezViWVUJPa/Ng3ff8fzrbLGgEj5I6eOhZ5wG4Ze8aXwV
	 7t+KB124YLWkwsX3YseO6GOYHFcTvjmycuS4TTlswJ9614jLHq14AcBIw1/wA/rT1+
	 CFpvqeIwYonvw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-408778a8ec4so3753296fac.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 10:51:04 -0800 (PST)
X-Gm-Message-State: AOJu0YxTnxGfOIWXSZWVTMx9ybVwSBj6KZsrtBU+ZXwbS3XzE/F69E+n
	sVgDvUs2Xouk3JdcC7SV6cgQvqq/Fh5tt+8QZyx6sj+tAGsqvRI2CL3UD6Dl/raeR0SsUnGAF78
	vM7sfppwNDC/t853g2Ar1+eZmtgfeC2s=
X-Received: by 2002:a05:6820:218:b0:65f:1012:68aa with SMTP id
 006d021491bc7-662f203a2c0mr1500222eaf.1.1769539863186; Tue, 27 Jan 2026
 10:51:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2396510.ElGaqSPkdT@rafael.j.wysocki> <DFHK7ZS7H7LJ.1POCUDPSLC3CP@kernel.org>
 <CAJZ5v0gDXSdAy9wJYUc_yyHD-Y_tPk0eVzWTyMLe7uHm30_Ncw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gDXSdAy9wJYUc_yyHD-Y_tPk0eVzWTyMLe7uHm30_Ncw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 19:50:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h+xwRJg9=-FYnHy5O=o=YzX_u6Qpt3WQ-3XCbnJyh=vA@mail.gmail.com>
X-Gm-Features: AZwV_QgEp63WWSibz14NNzgyCI6vuljeFyyemM8eKWk7bs1261BvkPJEzNDPnKU
Message-ID: <CAJZ5v0h+xwRJg9=-FYnHy5O=o=YzX_u6Qpt3WQ-3XCbnJyh=vA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hansg@kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Armin Wolf <w_armin@gmx.de>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux.intel.com,linuxfoundation.org,intel.com,gmx.de,amd.com,infradead.org];
	TAGGED_FROM(0.00)[bounces-20680-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DA8CA998A0
X-Rspamd-Action: no action

On Wed, Jan 7, 2026 at 1:14=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Tue, Jan 6, 2026 at 3:01=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
> >
> > On Tue Jan 6, 2026 at 1:27 PM CET, Rafael J. Wysocki wrote:
> > > +This means that it really should never be necessary to bind a driver=
 directly to
> > > +an ACPI device node because there is a "proper" device object repres=
enting the
> > > +corresponding piece of hardware that can be bound to by a "proper" d=
river using
> > > +the given ACPI device node as the device's ACPI companion.  Thus, in=
 principle,
> > > +there is no reason to use ACPI drivers and if they all were replaced=
 with other
> > > +driver types (for example, platform drivers), some code could be dro=
pped and
> > > +some complexity would go away.
> >
> > I think it would be good to explicitly encourage people to convert exis=
ting
> > drivers (maybe even list some of those) and rephrase the last sentence =
to list
> > what exact infrastructure, complexity, etc. can go away once that happe=
ned.
>
> I can rephrase the last sentence, but the purpose of this document is
> to explain the motivation for the change rather than to make a call to
> action.
>
> > I think this would make it more likely to receive some contributions to=
wards
> > this goal.
>
> I have prototype driver conversion patches for almost 50% of the cases
> right now and I'm expecting to have them for all of the cases by the
> end of the current development cycle, so I'm not sure how much there
> is to gain.
>
> I want people to not be surprised when they see those patches though.

Actually, all of this work is almost ready to be submitted, but in the
meantime I put the patches on an experimental branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=
=3Dexperimental/acpi-driver-conversion

It includes some material already queued up for 6.20/7.0 and a fix
that has been posted.

The changelogs are a bit rudimentary and need some more work, but the
code changes should be complete (famous last words).

