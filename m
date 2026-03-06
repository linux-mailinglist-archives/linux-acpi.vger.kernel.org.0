Return-Path: <linux-acpi+bounces-21491-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBvbH7fOqmkNXQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21491-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 13:55:19 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F222121D
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 13:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 293D830EF1F1
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 12:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F0C366577;
	Fri,  6 Mar 2026 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKxoa2X0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B3299AAB
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801194; cv=none; b=G7X4s0aT/BAMAD8GKKxCSzNrcmedbPkLeQV6UhGn+jXNWIgy18utYg3zjo7qx+6NS1vtTiFhg8hX8JkrFoVZoqIJjCJdp2EqnapzOztDy2HrJFRblMEcWwqyLjvCDjcSxDH93diLnd0x1Ra1dIEXeZYkvNEbT/hYJuTT+ldUMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801194; c=relaxed/simple;
	bh=ZflBJd5CD+Nmd3JpPRFtaGeIgw933UJLBwDpDZQLrCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ParWoLKZc7vPjUKkKh9x1ZQGdsBTM387/nNP9BlIA2t1ng6tZyhznTaygM9kyyj7h8Nt0L1oAVk4NLbjGgGlcb2wiVpegAZxtkBu1SR8ppgWJF+C0qUoJy7ce06ttqgyb3HhCSu8HEy38mM3P3kmQ6AVDSK3hIja7EMoFY3XvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKxoa2X0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18616C4AF09
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772801194;
	bh=ZflBJd5CD+Nmd3JpPRFtaGeIgw933UJLBwDpDZQLrCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kKxoa2X009RtP2jxHFGncUKqN94kjhjbVFN8ssQULCGYMpOtwl61i40HQKIVUcwuu
	 091CHgeSkhO4hlMVnVb0eB3nqTqrXgPLvThCVOS+GT6N28cYWEaB9E/5Nsi2waQ+4U
	 +4Vzgp6xuST//vgrQemAOMjnEODAPRNb4VRys6t61fGMJjILbKNa2ALXSEuuvJaXhY
	 7mNQe1Gf6ulJ1Td1QmNGRnFzSxEZjP5qAbdpyW8lFpZkKNrVTWlmvvnuWkEAOb+5Iz
	 Lc94AszZkiAY4wDB+gwcMXCjV1WcbNCGbuVtGh4Ci5sj/xm1fx+9A+aHz/7DsFP5bE
	 p8eCpYtqGMLjw==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so9095446a34.2
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2026 04:46:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpBGb4L5WX/wYzmOsSRUvT3SBbImP5l9EvAUeN2ndlSWyVnxeGRVvKk3h1yGINLa8WcKSedZSTpk/J@vger.kernel.org
X-Gm-Message-State: AOJu0YxgxSlNalBVy6Swvja0CmR//ucHbH1iwHZYGoChFQZJS+D2iMBj
	4GfJFUF44lly07tb6/fJXXRX2WW/oT2qWzWPYyQf4UPMapAflBoT7aOwN0CF5RyiG9o5enaeSRv
	49XnUrSx6osoavkRnNRgMUPKG41s69QY=
X-Received: by 2002:a05:6830:81d7:b0:7cf:e60a:f67d with SMTP id
 46e09a7af769-7d726f1eb6dmr1347885a34.7.1772801193095; Fri, 06 Mar 2026
 04:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306025144.604062-1-superm1@kernel.org> <CAJZ5v0hVm8Ceut_H74LOU7bHuzWCJERAtQ44q5VT4FY9-BwsNw@mail.gmail.com>
 <CAJZ5v0ihj+DARV3P52LMOn9U+bqwVW=2fQ_QtDsjeVZkR9hFmQ@mail.gmail.com> <23a0f5f8-11a6-4f41-9e32-19cb08110bc6@kernel.org>
In-Reply-To: <23a0f5f8-11a6-4f41-9e32-19cb08110bc6@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Mar 2026 13:46:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gmOzT8+b9rkTqxw1qehKj7Yc_sKu0YgRn+7aEUOhLLEA@mail.gmail.com>
X-Gm-Features: AaiRm523XTYQIggvkEwDik-ygFHoLPMAdKJPqo47-7WwbIinxMw0XTlsYTWtYJI
Message-ID: <CAJZ5v0gmOzT8+b9rkTqxw1qehKj7Yc_sKu0YgRn+7aEUOhLLEA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Don't allow MFD devices to probe
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mario.limonciello@amd.com, W_Armin@gmx.de, 
	Pratap Nirujogi <pnirujog@amd.com>, rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 073F222121D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,amd.com,gmx.de,intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21491-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 1:43=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
>
>
> On 3/6/26 6:17 AM, Rafael J. Wysocki wrote:
> > On Fri, Mar 6, 2026 at 11:50=E2=80=AFAM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> >>
> >> On Fri, Mar 6, 2026 at 3:51=E2=80=AFAM Mario Limonciello (AMD)
> >> <superm1@kernel.org> wrote:
> >>>
> >>> After ACPI video was converted into a platform device in
> >>> commit 02c057ddefef5 ("ACPI: video: Convert the driver to a platform =
one")
> >>> other devices that are MFD children of LNXVIDEO are being probed.
> >>> This isn't intended.
> >>>
> >>> During probe detect MFD cells and reject them.
> >>>
> >>> Fixes: 02c057ddefef5 ("ACPI: video: Convert the driver to a platform =
one")
> >>> Reported-by: Pratap Nirujogi <pnirujog@amd.com>
> >>> Closes: https://lore.kernel.org/regressions/007e3390-6b2b-457e-83c7-c=
794c5952018@amd.com/
> >>
> >> The link is broken, so I can't see what is really happening, but my
> >> guess is that MFD devices are created under the video bus device and
> >> they get the same device ID (confusingly enough).
>
> Hmm, I just double checked the link and it worked for me.

It works now for me too.  I'm not sure what happened the first time.

> But you are on the To: list of that thread also.

Yup, I've found it.

> >>
> >>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> >>> ---
> >>>   drivers/acpi/acpi_video.c | 4 ++++
> >>>   1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> >>> index 3fa28f1abca38..2cb526775ac47 100644
> >>> --- a/drivers/acpi/acpi_video.c
> >>> +++ b/drivers/acpi/acpi_video.c
> >>> @@ -14,6 +14,7 @@
> >>>   #include <linux/init.h>
> >>>   #include <linux/types.h>
> >>>   #include <linux/list.h>
> >>> +#include <linux/mfd/core.h>
> >>>   #include <linux/mutex.h>
> >>>   #include <linux/input.h>
> >>>   #include <linux/backlight.h>
> >>> @@ -1988,6 +1989,9 @@ static int acpi_video_bus_probe(struct platform=
_device *pdev)
> >>>          int error;
> >>>          acpi_status status;
> >>>
> >>> +       if (mfd_get_cell(pdev))
> >>> +               return -ENODEV;
> >>
> >> If the above is the case, I'd prefer this check
> >>
> >>          if (!device->pnp.type.backlight)
> >>
> >> which should also work, but is more general.
> >
> > Well, this will not work if the ACPI companion is shared between
> > multiple devices.
> >
> > However, adding an MFD check here is a "works for me" change rather.
> >
> > I think what needs to be done is to extend the duplication check (see
> > my patch from yesterday at
> > https://lore.kernel.org/linux-acpi/5663583.Sb9uPGUboI@rafael.j.wysocki/=
)
> > to detect the cases when another platform device (not necessarily a
> > child of the same parent) sharing the same ACPI companion is probed.
> >
>
> Generally makes sense to me.  But in this particular case it shouldn't
> be a FW_BUG.
>
> Do you want to roll this in your series?  Or would you prefer one of us
> to send a follow up patch?

I've sent one already, our replies passed each other:

https://lore.kernel.org/linux-acpi/5975968.DvuYhMxLoT@rafael.j.wysocki/

