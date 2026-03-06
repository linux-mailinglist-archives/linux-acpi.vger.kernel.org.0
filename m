Return-Path: <linux-acpi+bounces-21486-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCmgGlLGqmnVWwEAu9opvQ
	(envelope-from <linux-acpi+bounces-21486-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 13:19:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D63002206C8
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 13:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 164E8300A506
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 12:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB2C325490;
	Fri,  6 Mar 2026 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qehjsPgA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D06633CE92
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799452; cv=none; b=bS3qa9kkOwKQt67grelm2kZTJpqhrPlhF9zfJhO791UDOpijzTD8x+/uhgOOP/Y1Iqe8DIa6V70d/nrqGAzomkq9zF0OgBhAEbcjfK4PTb81dgtlshT5J/kiZW6+c9C9fKZCyIrPGtvKwiaRpGEY+3+wjBzkzmbzQu2GNiRcO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799452; c=relaxed/simple;
	bh=BEUPK5JecylyKA+amTuMaHtCLSed2fMoqZF/UabQYcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHN0x6awdoC6d2klb8n5Ds769AykpyS1WkVoNtK2BThA/hJXgCRd3e9a5GpPDzcbY26GdVhPYzjYANnbqlP9CSJ1FMFFLJD8B4NAsK4FYg7MAuYiwOdftFLa/qgI7nqqm3J/lwFBAsEsCFp1qZ9KgOemEcQGDdkBEUBg+189X9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qehjsPgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7111C2BC87
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 12:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772799451;
	bh=BEUPK5JecylyKA+amTuMaHtCLSed2fMoqZF/UabQYcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qehjsPgA1L08POR/U/sWZhDnrfcVQVmZcIpopTTJY7wQwszamzGu46LtfVk0ZeZ80
	 5XfkMIuk4rXZgujHEKiIPagoADIwvx8IHqRMmbYIkjBxLwi8+ideCEXWMzo49ZpZcX
	 qqdVza73jPm5GWQXsvoSTkTPLXNbAPTcBxeNJJGRiQYb4AiMXAjUWaerpzxkNrqSnN
	 8mDNgD7ioqr4VTSHveb4yGMbXc/zHO1W0ejEvwNbU0tigPAN/KRdJVUOPxsXKZ4DYS
	 NRBSs5kkHMlDJqxDAWpmYySOlI8HTBXz2Ijk9LIiNVDuzT29a+UyDBfWBFrCE9Nc6Q
	 ZCWHR706ZSzKg==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so1625574fac.0
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2026 04:17:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3RoWn7cmu98ba7cNg9IR6v2tMgLey9YYApW4OkHsE0CWL2Z83i+6uYvD4bACF/pRD+uXTDt0vu4tj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5CkdOoRdLAJR53D6pEvUyhD2WbgBJL92tBa2S5wfKw9bGgROW
	C0lX5cnvRizQ4tYTkIHsXEw1AFZpK+hkGUtuICR4fWu8nb26qzT0o/DywunHURbZlBpfrCq8oRg
	8eAHeTkm43OpLxM+kdK8zlRk56PkBDdk=
X-Received: by 2002:a05:6870:5251:b0:40e:fb61:26e8 with SMTP id
 586e51a60fabf-416e43a95bcmr1063753fac.36.1772799450786; Fri, 06 Mar 2026
 04:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306025144.604062-1-superm1@kernel.org> <CAJZ5v0hVm8Ceut_H74LOU7bHuzWCJERAtQ44q5VT4FY9-BwsNw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hVm8Ceut_H74LOU7bHuzWCJERAtQ44q5VT4FY9-BwsNw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Mar 2026 13:17:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ihj+DARV3P52LMOn9U+bqwVW=2fQ_QtDsjeVZkR9hFmQ@mail.gmail.com>
X-Gm-Features: AaiRm52oj8LOamFiHtNU-yNpmuYVcDmAAfSEHtTONLDOIIYAAV6xqMuW2U7Mk7g
Message-ID: <CAJZ5v0ihj+DARV3P52LMOn9U+bqwVW=2fQ_QtDsjeVZkR9hFmQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Don't allow MFD devices to probe
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, W_Armin@gmx.de, 
	Pratap Nirujogi <pnirujog@amd.com>, rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D63002206C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21486-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmx.de,intel.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 11:50=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Mar 6, 2026 at 3:51=E2=80=AFAM Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
> >
> > After ACPI video was converted into a platform device in
> > commit 02c057ddefef5 ("ACPI: video: Convert the driver to a platform on=
e")
> > other devices that are MFD children of LNXVIDEO are being probed.
> > This isn't intended.
> >
> > During probe detect MFD cells and reject them.
> >
> > Fixes: 02c057ddefef5 ("ACPI: video: Convert the driver to a platform on=
e")
> > Reported-by: Pratap Nirujogi <pnirujog@amd.com>
> > Closes: https://lore.kernel.org/regressions/007e3390-6b2b-457e-83c7-c79=
4c5952018@amd.com/
>
> The link is broken, so I can't see what is really happening, but my
> guess is that MFD devices are created under the video bus device and
> they get the same device ID (confusingly enough).
>
> > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > ---
> >  drivers/acpi/acpi_video.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> > index 3fa28f1abca38..2cb526775ac47 100644
> > --- a/drivers/acpi/acpi_video.c
> > +++ b/drivers/acpi/acpi_video.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/init.h>
> >  #include <linux/types.h>
> >  #include <linux/list.h>
> > +#include <linux/mfd/core.h>
> >  #include <linux/mutex.h>
> >  #include <linux/input.h>
> >  #include <linux/backlight.h>
> > @@ -1988,6 +1989,9 @@ static int acpi_video_bus_probe(struct platform_d=
evice *pdev)
> >         int error;
> >         acpi_status status;
> >
> > +       if (mfd_get_cell(pdev))
> > +               return -ENODEV;
>
> If the above is the case, I'd prefer this check
>
>         if (!device->pnp.type.backlight)
>
> which should also work, but is more general.

Well, this will not work if the ACPI companion is shared between
multiple devices.

However, adding an MFD check here is a "works for me" change rather.

I think what needs to be done is to extend the duplication check (see
my patch from yesterday at
https://lore.kernel.org/linux-acpi/5663583.Sb9uPGUboI@rafael.j.wysocki/)
to detect the cases when another platform device (not necessarily a
child of the same parent) sharing the same ACPI companion is probed.

> > +
> >         status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE,
> >                                 acpi_dev_parent(device)->handle, 1,
> >                                 acpi_video_bus_match, NULL,
> > --

