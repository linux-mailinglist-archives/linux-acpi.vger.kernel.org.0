Return-Path: <linux-acpi+bounces-21430-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBlSMdimqWnwBgEAu9opvQ
	(envelope-from <linux-acpi+bounces-21430-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:52:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44514214E2C
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8D313021D2B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 15:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6568A3CA4AE;
	Thu,  5 Mar 2026 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoJgVU6C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E7F3BE162
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725971; cv=none; b=FTM5bovhw2OdFRgliwFhClya1gsv4RnI+UmEe3iKLR3VSGPhSkCCCnTUlNe8NysBn5aFgDMH0GVGprWj8lLRH+Qxf4O4QudiPsHKe0y3iHO2k4rPP15WoxVuBMo98cZJuYh227GncYo920GOKHjaQbZFjQCVg4bFVX2mjsGhyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725971; c=relaxed/simple;
	bh=RcOj/M7Bi2O0mPxHl+rl9Aneerb42P1SL12sHOnu6fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wn6heddA/vYwKxkmuMALf3Ic+VIkQ8SoSgfDe8J3K4npSXvJ7wvlcWpLaQFjK+b5vvjbaDynoROA/GuEQ4TCpA889n6VZSmhZMaHpe6QongGX2mlPIEvhGgAa64p5XodcZkckXWuix+WYl06gas3NYlL4JaoTno0f63YZZFc2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoJgVU6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E015EC2BCB0
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 15:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772725970;
	bh=RcOj/M7Bi2O0mPxHl+rl9Aneerb42P1SL12sHOnu6fk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SoJgVU6CjfTRCtVnkbD3qMQdN/okZRxqk1iTHsvP5idR+vj7WYCr+9Q9jWoxx+qVP
	 otTyLAy+43cm1RbNhJQk5xafDnCnZ5ivx7BgEpuR17aES9WUeKeMEzSO6ggmqyGPFs
	 o8m8oqZ52cpp9mKHDZ/H/tBfpqa5Mg404kdMhnW7bNUNhHHhG1jOkZ5mD0URsBYNZS
	 w5K9Rz0iF2pXwCCyFfcjHvMNKQVs8juMlfsrv1qLd1YtC9kEpagHxMSmoBtj+GhaiM
	 VdXl0lXcEyR/mtUhj58bV4Trf1jpUrR1hNfHXAdA5bnnuaTVjTEFgXQw5VXDUAJvDM
	 l2KIQCf1akM5Q==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-415b23dd6e5so1225180fac.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 07:52:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXk81LoOjLGAWKA5fAE7dhJDdhdxADmRRSQzzWoA338wT/yhZMdvlA+uATTgxDxCXnFRTJtD1KyKssj@vger.kernel.org
X-Gm-Message-State: AOJu0YxccO1KR5BQH4NNtdYrHA+3ScGNJCyaO9MhamJ8kDoJdW9cwzHp
	RJTOUHtrW9vO1aZOs37kxj21LWqSqgiJ3lobBVbbdbPrxsigxLg7znbHleY2XuogI2g1jLyZRAW
	32eIR7olYdUqAi1DvtkkDwXZ5fKzkL3c=
X-Received: by 2002:a05:6870:8a27:b0:404:383f:56bb with SMTP id
 586e51a60fabf-416abad36fbmr3120377fac.35.1772725969914; Thu, 05 Mar 2026
 07:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2274474.Mh6RI2rZIc@rafael.j.wysocki> <2553054.jE0xQCEvom@rafael.j.wysocki>
 <aamgGkgfFh-cQNfF@tzungbi-laptop> <CAJZ5v0jYk+RQu5RKUUh4caUE9vPQDgK1ss8B+=-HfPLZP6RsyQ@mail.gmail.com>
 <aammMeX3M83JZr6U@tzungbi-laptop>
In-Reply-To: <aammMeX3M83JZr6U@tzungbi-laptop>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Mar 2026 16:52:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jyp-sDTeM2sSYxocH23U6sXkUsQ9ROCu0aWABv8UoxMQ@mail.gmail.com>
X-Gm-Features: AaiRm53pwBPvGJtM15fitb6rGcKT-IpUm1vGA7GqBjAHaxiTP10Q4LJsWkc5J5E
Message-ID: <CAJZ5v0jyp-sDTeM2sSYxocH23U6sXkUsQ9ROCu0aWABv8UoxMQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] platform/chrome: chromeos_tbmc: Convert to a
 platform driver
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, chrome-platform@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
	Ravi Chandra Sadineni <ravisadineni@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 44514214E2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21430-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 4:50=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> w=
rote:
>
> On Thu, Mar 05, 2026 at 04:34:26PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Mar 5, 2026 at 4:29=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.or=
g> wrote:
> > >
> > > On Wed, Mar 04, 2026 at 07:44:26PM +0100, Rafael J. Wysocki wrote:
> > > >  static void chromeos_tbmc_notify(acpi_handle handle, u32 event, vo=
id *data)
> > > >  {
> > > > -     struct acpi_device *adev =3D data;
> > > > +     struct device *dev =3D data;
> > > > +     struct acpi_device *adev =3D ACPI_COMPANION(dev);
> > > >
> > > >       acpi_pm_wakeup_event(&adev->dev);
> > >                              ^^^^^^^^^^
> > > If I understand it correctly, I think this should also be changed to =
`dev`?
> >
> > Yes, it should.
> >
> > Essentially, this needs to be the same device for which
> > device_init_wakeup() has been called.
> >
> > Sorry for missing this.
> >
> > Do I need to resend the series with this fixes or would it be
> > sufficient to send a v2 of this particular patch?
>
> Please resend the series as v2, addressing the fix and the minor fix in
> patch [2/6].

I will, thanks!

