Return-Path: <linux-acpi+bounces-1760-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766737F4FC9
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 19:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E931C204BF
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 18:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAE85CD0D
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DSr5HBce"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9501A8
	for <linux-acpi@vger.kernel.org>; Wed, 22 Nov 2023 09:49:32 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 529E540E0257;
	Wed, 22 Nov 2023 17:49:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ye2hmHk8fjTu; Wed, 22 Nov 2023 17:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1700675367; bh=j4OvileRdiB72WaS5f8RnKgaglxFLtA5UwsHsPaO2l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSr5HBceaoG5XUaaSWwdU98GTCEVLdchOz25TUBSUj9bx2wGrn1f5NIWytZXobI0E
	 YH+EZDeSwhqS+iBSOsQvDI5dQv0/EDj2w/H2jeJbH2rlBSVvb5vJXqBA/sMs3B17lc
	 tggyHqU00KhICgYAXqbOPPMPS036yeKrweVF+b40MlH5d59Pqe3IDD9vGNWZLE6DS3
	 xIGKMQ7YiSjz5OltprseCB42sC/A8CceoUNH1Nz857e17TJ7iPyZ839c13K92nbBtA
	 Hip3eHepvvr5WrpHMWeYGRW23/nOiSyScQ2vVQQ7oO25Br33n668vliREObuX8ZOj5
	 pI6wElyx9kx31fA8fjkh90SHQhV+/9ueQuEisu+DI9kpPeGtprqjlp4bZoJHdDtXn/
	 l+sJH9yMQLnwi2vaZpFTvtDw+Nc5VxGEvQUZqzLfMycvC/blyZpyO5/RHU5P0eyzo1
	 WPcYQ+nI+mjJFKwYqkg1TNELfMvo/8b599+N0Y54UxosMHa4GLnu26+SVKXLpzAmpi
	 iauHoEjsofPRR6HGtIucYfbu1teErRC2whr220Dg9DJ7QDFkjxYArtI08eC1hFnro8
	 ZPcnKh4Spaoml1dzuvbG8cT+gyzO/jFdl9OfPC10d8c1aglBmOxjxGpz2es9jc2DJa
	 8k7CO8aqAZvkMm70V/qenD9E=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FD1340E024E;
	Wed, 22 Nov 2023 17:49:19 +0000 (UTC)
Date: Wed, 22 Nov 2023 18:49:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	James Morse <james.morse@arm.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] ACPI: APEI: GHES: Convert to platform remove callback
 returning void
Message-ID: <20231122174913.GFZV4/GUKci24sp1oj@fat_crate.local>
References: <20231120173053.49597-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0iW_B72o8EMbZaH_x2SOHOvqnieP8EsK2A6d93GRDYtBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iW_B72o8EMbZaH_x2SOHOvqnieP8EsK2A6d93GRDYtBA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 04:25:30PM +0100, Rafael J. Wysocki wrote:
> On Mon, Nov 20, 2023 at 6:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > The .remove() callback for a platform driver returns an int which mak=
es
> > many driver authors wrongly assume it's possible to do error handling=
 by
> > returning an error code. However the value returned is ignored (apart
> > from emitting a warning) and this typically results in resource leaks=
.
> >
> > To improve here there is a quest to make the remove callback return
> > void. In the first step of this quest all drivers are converted to
> > .remove_new(), which already returns void. Eventually after all drive=
rs
> > are converted, .remove_new() will be renamed to .remove().
> >
> > Instead of returning an error code, emit a better error message than =
the
> > core. Apart from the improved error message this patch has no effects
> > for the driver.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >
> > I tried to improve this driver before, see
> >
> >         https://lore.kernel.org/linux-acpi/CAJZ5v0ifb-wvyp0JRq_4c1L6v=
Ti_qEeXJ6P=3DPmmq_56xRL74_A@mail.gmail.com
> >         https://lore.kernel.org/linux-arm-kernel/20221219221439.16817=
70-1-u.kleine-koenig@pengutronix.de
> >         https://lore.kernel.org/linux-arm-kernel/20221220154447.12341=
-1-u.kleine-koenig@pengutronix.de
> >
> > but this didn't result in any patch being applied.
> >
> > I think it's inarguable that there is a problem that wants to be fixe=
d.
> > My tries to fix this problem fixxled out, so here comes a minimal cha=
nge
> > that just points out the problem and otherwise makes ghes_remove()
> > return void without further side effects to allow me to continue my
> > quest to make platform_driver remove callbacks return no error.
>=20
> Tony, Boris, any objections against this patch?

SDEI is James. Moving him to To:

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

