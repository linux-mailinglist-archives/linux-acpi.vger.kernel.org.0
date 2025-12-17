Return-Path: <linux-acpi+bounces-19637-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA943CC8FA3
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 18:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E38130572FA
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72723376A2;
	Wed, 17 Dec 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="faEeMp0b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D7830E0CC
	for <linux-acpi@vger.kernel.org>; Wed, 17 Dec 2025 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990685; cv=none; b=hcAGEgx8KFiQ4i/jNRWVdYisDfTw55O9pA+BinVJxhKBQxq9j6VZ9qjgtii+ssDQ3VAW6BkJgOrUVvBllYHksbRgyrXZ/ufL6NNdwYos4ilcmuk0vI8zfouVd97z/WdCXM5e8qzPlf0wOrW1QdjPV8QHRBwfmvsHuXA0co6VX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990685; c=relaxed/simple;
	bh=Mdgf1xrwj6ePxOwSPFAm39chF49gYnS5GIZrmTBc9W4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkbP5TAspWb3svXl/fGFakv1d3+0oSlVAsCE/tY+qmd96WY8F78ArhqrZzulV040tXaeuFuApWrChOk92ebKJDzIzeJ05Z46ZRYMkVa6G0PHswTrAPayqa4bjHdqFKj50mDS8XoNEcceWiqf0Eoi81GXwuFgMBWbQl8BAIECWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=faEeMp0b; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1765990681; x=1766249881;
	bh=ZEXvYe1lDmnxsyCFWRdLKARj04UHQ5mSH6Oq9QoAojE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=faEeMp0byJqJp86pMjdUMibam6EJdKNn96h/0nGyvepX3JdHrlD2Lwq2mePDhgdzp
	 id1bC2Sm8qA1Aedm7eBHcA/PKltx99yPbM/5EaJOgPqlHvrDeE4jjlXJpbhIrLFrEA
	 DfBgjT9Mu3dJKdHSZtkxoxNKAdEDMvmhG12XHBr+KvzUAK6p+DUQbBb3/qo2PVwtTt
	 +kBTxqFbkx332xrqRSBMGEPyDymimoROdaWlBThflayXZas7qn5m1hdVGDC2p8bs2Z
	 fJ1L0YVFQw8KgmRHTjwInCRwHxbiiLSGSw7r+Lhg/6WgoTZD3rqhiSBufAvvrW2wzS
	 6HYoWRXQleLEQ==
Date: Wed, 17 Dec 2025 16:57:58 +0000
To: Mario Limonciello <superm1@kernel.org>
From: Francesco Lauritano <francesco.lauritano1@protonmail.com>
Cc: Hans de Goede <hansg@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "westeri@kernel.org" <westeri@kernel.org>
Subject: Re: [BUG] 36-second boot delay due to by acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
Message-ID: <NIIS8XD_nSRvp36X39GxcDRAWsaScQIFx6o9JsFCbyBZk5PqznRdxg9EDDb_9tzWd5TcjzxrRtFx5_uLCVa5wJAYykW2k0Ue_XPMPtWCQiY=@protonmail.com>
In-Reply-To: <woxnPhTYiKi2aLzBK8GnO8DpvdgYjQc-P42uhJOzyrcYC3Gdstht27hML8yNHgOklhm2MgGA7wt9gGZ17BHoWlG0vqJuVVJDgCSev8udfds=@protonmail.com>
References: <2kSCn4XaoXsXJ3EUR0syTdmip8Z1cBuUr0Br4sFVnwnsA8q4GlhiHOmsJkeBxvxYoLnetp4r44wIPXw42yTAFl-BtMROnIwR-NkckKgA5EY=@protonmail.com> <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com> <4402ed86-77f5-4a47-a9e1-8d57a709bb15@kernel.org> <woxnPhTYiKi2aLzBK8GnO8DpvdgYjQc-P42uhJOzyrcYC3Gdstht27hML8yNHgOklhm2MgGA7wt9gGZ17BHoWlG0vqJuVVJDgCSev8udfds=@protonmail.com>
Feedback-ID: 66654272:user:proton
X-Pm-Message-ID: 5886d2650bfc8d25da78d3cc0473592092b1c1f8
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 17th, 2025 at 4:12 PM, Francesco Lauritano <francesc=
o.lauritano1@protonmail.com> wrote:

> The _AEI defines 5 GPIO interrupts. Narrowed it down to two:
>=20
> gpiolib_acpi.ignore_interrupt=3DAMDI0030:00@21,AMDI0030:00@24
>=20
> This fixes the delay. Pins 0x15 and 0x18 both call: \_SB.PCI0.SBRG.HNC0()

Traced it further. HNC0(pin, 0) takes the Else branch and calls:
ATKM(0xC0)
ADTM(Zero)

ADTM calls NOD2(), which is the actual culprit:

While ((Arg0 !=3D RDNT))
{
    If ((Local0 >=3D 0x0F)) { Break }
    Notify (^^GPP0.PEGP, Arg0)
    Local0++
    Sleep (Local0 * 0x64)
}

It notifies the dGPU and polls RDNT, sleeping 100, 200, ... 1500ms per iter=
ation.=20
Max 15 loops =3D ~12s per pin. GPU doesn't respond at boot so it maxes out.

Two pins, ~12s each, ~24-36s total.

Francesco

