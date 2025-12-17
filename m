Return-Path: <linux-acpi+bounces-19631-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA9CC8207
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 15:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0EA130AC726
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D89238F230;
	Wed, 17 Dec 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LixhGvrN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD4382D3D
	for <linux-acpi@vger.kernel.org>; Wed, 17 Dec 2025 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980132; cv=none; b=OJzSTwm9C6v7+Txs+ov1ABhk+uyXJeDxaGdOT8MmBnbMdVPbZSztp8+OFsd+adpA6MFIPCfLFwmZfHGd1lewZ4N+FB+nTtIRzRSN9Z9oRKY9dvJXw80hCrzF9H/XoaPLCbrvRNJH2PZnq1ef/OybboCtQAlqPzFw01Qsva+yZhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980132; c=relaxed/simple;
	bh=u25j76qwGnRUqcQwkw9CffxRdmeo2S9TfbZWsUxPi54=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qe3bL0oLXdQDvDOvqN04oR+Kpi69eVqOrceEKwiv58ZSwtWQyLh5GQ/mICTNXtoBbNYY+9s5/JpsLuCmF272zgkbTmp3Qjqx+hpA/ix1nVZ0krG6fJCrhkL7EL4NVLcDKhusyN024Ij9chrscrZUNOM20i2VJLsF86/tJs8IbxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=LixhGvrN; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1765980115; x=1766239315;
	bh=u25j76qwGnRUqcQwkw9CffxRdmeo2S9TfbZWsUxPi54=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LixhGvrNQ4cBW7ZKRVLqubWtljJk8MSpwhNtGgQIgp5T/xus2XHdq9o3VlyFwhheM
	 mEUqhv6gRwOv6cGKZl5SHLhGqHmSnh02QXd/Mtn0hsh3xCFiLBo9izxPkxZbRN+Mxl
	 um09jzeU7PgzHjMompVUGFXdZfM0GhwFRJcMKp2QCRa4fuCtuFeRLY7ZZYp16DDD/+
	 Jt2THDcgYK5FHDN0Wa4Ep1NZo0vicObBGY585htRtSTXd+HX2shYYZNRUitL0MkuKY
	 JPMXIzoxpI/Xa7jkv9wi8d9vwaicYAYcJxlHjQ5IeZwljqGrPDu9BvVGgHBiOa4mTH
	 e3RKTu8pYk94A==
Date: Wed, 17 Dec 2025 14:01:51 +0000
To: Mika Westerberg <mika.westerberg@linux.intel.com>
From: Francesco Lauritano <francesco.lauritano1@protonmail.com>
Cc: Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Disable edge events on boot on ASUS ROG Strix G16 G614PP
Message-ID: <X9fJuqzxIBzuhcbjDFYBPSScoKnUpKLe13znKYaJkJpgmjcbfF6_RN2_24ksQq0Hwyvy9pVrnL7_vHEarnQyUBC0zBLmhlvp75nNhgmq7OI=@protonmail.com>
In-Reply-To: <20251217130822.GS2275908@black.igk.intel.com>
References: <2kSCn4XaoXsXJ3EUR0syTdmip8Z1cBuUr0Br4sFVnwnsA8q4GlhiHOmsJkeBxvxYoLnetp4r44wIPXw42yTAFl-BtMROnIwR-NkckKgA5EY=@protonmail.com> <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com> <20251217120146.51321-1-francesco.lauritano1@protonmail.com> <20251217130822.GS2275908@black.igk.intel.com>
Feedback-ID: 66654272:user:proton
X-Pm-Message-ID: 8daf313e9631af51c88f53e393a3181169e4a355
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Mika,

Thanks for looking into this. Happy to dig deeper.

Here are the requested dumps (boot with initcall_debug, no workaround):

dmesg: https://gist.github.com/kylan11/63ec3ec319cd6bcaa043fa0b1366965a

acpidump: https://gist.githubusercontent.com/kylan11/7956bbf75714265107f088=
6f6ed2a381/raw/1614845eb1dc6ab7e2effb6fe56b585a746abe4f/gistfile1.txt

Some quick notes:
- The AMD GPIO controller probes successfully (LINE 2077)

- The hang occurs in the deferred IRQ handler (line 2960)

- There are some ACPI errors around 0.285373 to 0.289806, though they compl=
ete quickly

- After the 36-second hang, everything else initializes normally.=20
touchpad, audio, wifi, nvidia GPU all work fine.

The ACPI tables show there's a _AEI method under \_SB_GPIO. Not sure if tho=
se
unresolved GPP2/GPP7 references are related to what's blocking the deferred
IRQ handler, or if it's something else entirely.

Let me know if you need anything else or want me to test something specific=
.

Thanks,
Francesco


On Wednesday, December 17th, 2025 at 2:08 PM, Mika Westerberg <mika.westerb=
erg@linux.intel.com> wrote:

> Hi,
>=20
> On Wed, Dec 17, 2025 at 12:01:52PM +0000, francesco.lauritano1@protonmail=
.com wrote:
>=20
> > From: Francesco Lauritano francesco.lauritano1@protonmail.com
> >=20
> > On the ASUS ROG Strix G16 G614PP (2025), the kernel can stall for ~36
> > seconds during late init in acpi_gpio_handle_deferred_request_irqs().
> >=20
> > Booting with gpiolib_acpi.run_edge_events_on_boot=3D0 avoids the stall =
and
> > restores normal boot times.
>=20
>=20
> Okay but it might just accidentally "work" and hides the real issue. Doin=
g
> things like this blindly might end up breaking something that relies on
> that _AEI.
>=20
> Can you post full dmesg and acpipdump somewhere so we can try to figure o=
ut
> what is going on?
>=20
> > Add a DMI quirk to disable edge events on boot by default on this model=
.
> >=20
> > Link: https://lore.kernel.org/platform-driver-x86/6iFCwGH2vssb7NRUTWGpk=
ubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pn=
u5hzPguTa0s=3D@protonmail.com/
> >=20
> > Tested-by: Francesco Lauritano francesco.lauritano1@protonmail.com
> > Signed-off-by: Francesco Lauritano francesco.lauritano1@protonmail.com
> > ---
> > drivers/gpio/gpiolib-acpi-quirks.c | 16 ++++++++++++++++
> > 1 file changed, 16 insertions(+)
> >=20
> > diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-=
acpi-quirks.c
> > index a0116f004..763dd3cbd 100644
> > --- a/drivers/gpio/gpiolib-acpi-quirks.c
> > +++ b/drivers/gpio/gpiolib-acpi-quirks.c
> > @@ -370,6 +370,22 @@ static const struct dmi_system_id gpiolib_acpi_qui=
rks[] __initconst =3D {
> > .ignore_wake =3D "ASCP1A00:00@8",
> > },
> > },
> > + {
> > + /*
> > + * The ASUS ROG Strix G16 (2025) has a buggy ACPI GPIO configuration
> > + * causing acpi_gpio_handle_deferred_request_irqs() to stall for
> > + * ~36 seconds during boot.
> > + *
> > + * Found in BIOS G614PP.307.
> > + /
> > + .matches =3D {
> > + DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> > + DMI_MATCH(DMI_PRODUCT_NAME, "ROG Strix G16 G614PP_G614PP"),
> > + },
> > + .driver_data =3D &(struct acpi_gpiolib_dmi_quirk) {
> > + .no_edge_events_on_boot =3D true,
> > + },
> > + },
> > {
> > /
> > * Spurious wakeups, likely from touchpad controller
> > --
> > 2.52.0

