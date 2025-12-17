Return-Path: <linux-acpi+bounces-19640-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ACBCC966F
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 20:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 606C7302D28F
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 19:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88CA230D0F;
	Wed, 17 Dec 2025 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="OLmNAUZe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F461668
	for <linux-acpi@vger.kernel.org>; Wed, 17 Dec 2025 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765999207; cv=none; b=m0gqUx6C+g1UiHw2HiahuGfuu+QCu94IcqJQ1r4Ujpx9eB+DPeAjkrqfi2jXgBfbvbzhoZhJNGMpvAvd3ZStGIXhZROF3zlgYnQ9tWUdqormJXlAYmBEUerklF96O3nbWB41JWojtyDY2vZAqfbs9spetO7txFAtxUGKag8Wcbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765999207; c=relaxed/simple;
	bh=1+wQu3DU4CveI1Mh+k8iA2Z1S2uievEyjDzxJ+b0qXk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lD7lSaW5qt1plaerWHQGSgLuocbMOPkBzu1rDJWz/MErdrQ48FbC7thsCo2mTa4ZwIfuw5mc1DiNYPdVowewp0Y/f91frH2zxk/XcrZD82pwxXo36kErdI3kfOn0pgbaobydOMqKvfNnsRYV8qnOhng95Nmuzghjh7vSDY/B49Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=OLmNAUZe; arc=none smtp.client-ip=109.224.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1765999202; x=1766258402;
	bh=SxDHQdz0UsAAfomsYBxGUPDOxZEVHiqHRxjT3siJq0Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OLmNAUZeqWq7HeJDwGUR9ZexOwdIfVY0lTN3vV8I7B5fsJ1Y74OnrPVVULnJHJTPc
	 bm1PViGhKNofLwWUu9psDlsj+J69cNFQy+6JLWz5ZTUt2qrRtcceGOwMXL8w8ilstY
	 nhQFJSZc7lDyq5D20eQYYgkti9k1NcO8qMKkpOdphN+ZmbUMqar9hVnLBt6qgcE69s
	 73vkTNXYx9ZfYwe2hLPE2faJRbjcSXDUn2bz6HaZAiPj+n4AjUXPswgDoRE8DkmVt8
	 K6hGP0cR0/pXrcEexJNvDtx+sqOp4LUOX5yt5/fiT+Eto5U+XARqPy3rzohbOCn696
	 TkmQbb35ISf4A==
Date: Wed, 17 Dec 2025 19:19:56 +0000
To: Mario Limonciello <superm1@kernel.org>
From: Francesco Lauritano <francesco.lauritano1@protonmail.com>
Cc: Hans de Goede <hansg@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "westeri@kernel.org" <westeri@kernel.org>
Subject: Re: [BUG] 36-second boot delay due to by acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
Message-ID: <ReQS8sQSGy3UTuG6tyPvoOb8_037sC6A2yXsSFNuXY1PlTFtCcDHnjf8vufEsk8avBSIL46U0qE-ZjTJD1xsbVYZ6_d2-wlTOZ2NJ2coTsc=@protonmail.com>
In-Reply-To: <e8ed4d4e-37e1-4577-bf80-62fcefbef7dc@kernel.org>
References: <2kSCn4XaoXsXJ3EUR0syTdmip8Z1cBuUr0Br4sFVnwnsA8q4GlhiHOmsJkeBxvxYoLnetp4r44wIPXw42yTAFl-BtMROnIwR-NkckKgA5EY=@protonmail.com> <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com> <4402ed86-77f5-4a47-a9e1-8d57a709bb15@kernel.org> <woxnPhTYiKi2aLzBK8GnO8DpvdgYjQc-P42uhJOzyrcYC3Gdstht27hML8yNHgOklhm2MgGA7wt9gGZ17BHoWlG0vqJuVVJDgCSev8udfds=@protonmail.com> <NIIS8XD_nSRvp36X39GxcDRAWsaScQIFx6o9JsFCbyBZk5PqznRdxg9EDDb_9tzWd5TcjzxrRtFx5_uLCVa5wJAYykW2k0Ue_XPMPtWCQiY=@protonmail.com> <e8ed4d4e-37e1-4577-bf80-62fcefbef7dc@kernel.org>
Feedback-ID: 66654272:user:proton
X-Pm-Message-ID: e296eaddc6befbe5480d0ef28284d40fa59a5ac2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 17th, 2025 at 7:01 PM, Mario Limonciello <superm1@ke=
rnel.org> wrote:

> On 12/17/25 10:57 AM, Francesco Lauritano wrote:
>=20
> > On Wednesday, December 17th, 2025 at 4:12 PM, Francesco Lauritano franc=
esco.lauritano1@protonmail.com wrote:
> >=20
> > > The _AEI defines 5 GPIO interrupts. Narrowed it down to two:
> > >=20
> > > gpiolib_acpi.ignore_interrupt=3DAMDI0030:00@21,AMDI0030:00@24
> > >=20
> > > This fixes the delay. Pins 0x15 and 0x18 both call: \_SB.PCI0.SBRG.HN=
C0()
> >=20
> > Traced it further. HNC0(pin, 0) takes the Else branch and calls:
> > ATKM(0xC0)
> > ADTM(Zero)
> >=20
> > ADTM calls NOD2(), which is the actual culprit:
> >=20
> > While ((Arg0 !=3D RDNT))
> > {
> > If ((Local0 >=3D 0x0F)) { Break }
> > Notify (^^GPP0.PEGP, Arg0)
> > Local0++
> > Sleep (Local0 * 0x64)
> > }
> >=20
> > It notifies the dGPU and polls RDNT, sleeping 100, 200, ... 1500ms per =
iteration.
> > Max 15 loops =3D ~12s per pin. GPU doesn't respond at boot so it maxes =
out.
> >=20
> > Two pins, ~12s each, ~24-36s total.
> >=20
> > Francesco
>=20
>=20
> Any idea why isn't the dGPU responding? I would have expected
> https://git.kernel.org/torvalds/c/4d4c10f763d78 sets up policy that it's
> in D0.
>=20
> Is the dGPU turned off in BIOS or through some reverse engineered
> tool/API or something?

dmesg without the workaround:
[    1.005184] pci 0000:01:00.0: PME# supported from D0 D3hot
[    1.288811] pci 0000:01:00.0: vgaarb: VGA device added
[   38.250139] nvidia: loading out-of-tree module taints kernel.
[   38.369358] nvidia 0000:01:00.0: enabling device (0000 -> 0003)
[   39.744421] NVRM: GPS ACPI DSM called before _acpiDsmSupportedFuncCacheI=
nit

GPU is in D0 from 1.0s. nvidia loads at 38.2s after the GPIO hang completes=
.

No weird tools/APIs besides userspace utils (asusctl/supergfxctl).=20

No changes to BIOS factory defaults other than disabling Fast Boot.
dGPU is active, Display Mode is Dynamic (hybrid).

Traced RDNT - it's set by GPS function 19 in the ACPI tables:
Case (0x13)
{
    Debug =3D "GPS fun 19"
    \_SB.PCI0.SBRG.RDNT =3D (Local1 + 0xD1)
}

As far as I can understand GPIO initcall blocks at late_initcall_sync, prev=
enting nvidia=20
from loading in time to respond. Based on the timing, GPU is awake but noth=
ing can=20
register a handler while kernel is stuck at NOD2 polling loop.

Thanks,
Francesco


