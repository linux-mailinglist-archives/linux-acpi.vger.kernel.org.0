Return-Path: <linux-acpi+bounces-13831-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80431ABE1B2
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 19:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF3C8A2719
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 17:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3DA26C39F;
	Tue, 20 May 2025 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="OjAnlo1M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sonic308-2.consmr.mail.bf2.yahoo.com (sonic308-2.consmr.mail.bf2.yahoo.com [74.6.130.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A44263F44
	for <linux-acpi@vger.kernel.org>; Tue, 20 May 2025 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747761471; cv=none; b=fj09Pe4HsHPE2O9F5pHBidKUl6GZy3hreYjnFzEjoT5+G7F40XtqRVGvqZ7sjTCx24lQelCmBvL4HDrlPZ+jaJLAe3bBjpJPZPnhexfxj6ixUm8TAfCdH4IdNKtAi7H/232pXgWPz/RfKR3+lRRJTXKHSJyHMbqDvz8E7uyMvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747761471; c=relaxed/simple;
	bh=1WP0pXze1Ta3gmNPfudg9tJumMW+jB/0BJbf57nwFaE=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=mmFl/6ahCIQZvKOH16+XLNbRVv+XrWqiqoQFqN+e6F3hJla2xVwksnyBkQZwa5bNV04LpBrRTysiHesXBtpwcjap+EsQOp/3zfBX4S4JLlqf9aaDuHsuMK6zSpKS12W9QJsx6YRt4g7edlKr2mh/06uEdf9jCqJTg8rf6jocY98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=OjAnlo1M; arc=none smtp.client-ip=74.6.130.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1747761469; bh=1WP0pXze1Ta3gmNPfudg9tJumMW+jB/0BJbf57nwFaE=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=OjAnlo1MwdQc8ySzVtm+tffLuanMFT0BabJwIHNZszYlXETqOBJQ0ln1IhUU52BeAayAarCPmYn2MD2kRSVPCdFPiUxN74NlQhXn6fsFUuvuw7vUsH+ecCX4YfFVB+bDzb2xefT7mtFGQZRROx+7mt4aRNzyTIsCZFmKYs5QAguKVzyVDulsnKzAYcWeXUvGre5lgljq6a5skNYNwlUYsN9pZ89XoQKvO9SR5FgnuIspu5qbR4zio7Vab7qfU1HHxkqR3hqPu0cOGmotlRXNqIkXftS+lVRVhstvK6mRWQ1JLYdknBNYkC6H2lBtUkIgH2PAb24TH7+T0POefaV5+w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747761469; bh=B7XOpVeViAhgzuS9xdPJ/+pa0TmsAh8pxJkFfc8U5NY=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=DjqgGiB/Z8zPj21EYZ8QpmVzLq29oX5e3iaq0VwpA/GNvVSL6s9xIo0Y8KOrdCo2H2WgGUP2o+CLM1hh55OVqlquo7u7fRGcT+eh1Ej0aEjt8YCqqtnAR0Yf5YO9V4HApViG23mfDFyeaNcwnL7pHPfhl0/i6389jE6qeT92HAIA+rtsx+aXhcIWmQTHbPHuqGFgChG1gUzGqVHo/gqxwA3TmSk9YWd2UBShLGLVCY8AtvDwO6MEypLujFV8mLihMT32lefVaBKnnebCwMB2qPPqzgBJ+TbSESDotHrhrFR+bdl2j4WC1Tvrb5f+d8RpiBWJYDiqask6Fuy4HQiyTA==
X-YMail-OSG: Fj577owVM1l4YpXKsKwlPs87FFgf1CeCiLXzD6Aa_XDTvU3XRcpK_MMjZr0_SKI
 OaUecybgeSbIx96pWELkoJasJ811vgdoVaOh1UWm6M0lFB06fK6pYEpyO7QDvBoSRCTPl6JbTSIm
 82uDsNEPr4oWd3rfl10_g5_79DxmI5ppCUIZPIz2CzJdGxxXHKmbIKL5gJfSKR4zBQyEp82xdkv7
 C8RjWbbsfDQVO6Br4NmvPgfp4ELZ.DbHQhGLNHGcRh41P_Fru59qr9aJSEXPrru_n1gzXzcEWP85
 rwkmPSRWtb_bTIOXLS2zBTLf0oFwgSx1ntDFI8bx8scR_xMbBYN8._2tGF7gGGPTl7zPWw7kJ5C_
 J62WG9gcflZ9SjiDefu8yPCcese0ojxLnp7kVeftkHd0bp4slJu5Nb_IKTy07IcEtgi3rSWdr.yB
 q1JvVC2paSI.YB2_dPnPxv5.cM09K5BC.h2Y.blCpWKdZ5UcIFdj.cdonJEKaII.nJd68CjjF5C4
 yExZFnaak_8_ESb.uEumwmY.jecsrnNndojvinIiyKfbtX.IwsNmuZ2eZ2wvPkcUCNeXqTNdVzee
 fueJj3Ke74v.mIlVsWSfzd00Jh5fICIvFj6KopQXNLYXZfraExAYl813yrY6btSMt43l5HadtG2q
 C8ZH_pCyncMUGdEZqukgPPnR5XHC1xjqI.PKHDgp65mPVL9opMtAH2uQDYIFlv4zW2pkoX.W3Ats
 VLB__jNTvTrUXsELY6G24zbeEm7nN6fXSJIrxKbUkeWAXY_gPL9OGXLr56tjTZD2EBhyYochTtWA
 fTG5XVO5Jw4Mb8sUojicWojxfqMN7t07zuS0wRsb4VXrsbhi6d7uVs3WstjpqNiZoWvPkefp2JeK
 PIIxHv10us9uafugUfeipJYjFpHRg47jRFKqOzgM7Li7PrOvkFeRY4Si9oiaW6OdsWR6OS5FsSdH
 y.BaboIXsK5QaCOD9e06mVHXHSxFqAWOaoy6E1wWO3AncfJz6dZOL2TJxo.oZ8GJ7oePwApiHA3v
 m.TQ0FTflBngduD.FrGQperNcd4KqPRWzm8P6wCfAVw8C8CtAGbR24OWfR7VsdrwsJr6ykOC.ovb
 avVUFpFwnz8AWPALALXxObhB0mEHsQxmEeOQQdb5OVGypZRQOFOIXK8tD2Z2wflJH2z.0TuQeptm
 U_IB4GmNXepV0KlOzcwybtxHIJNN4kKUlJSNuIXss4HC7FfzT_bNsgGX6FRwZ6n0qWq5_oXdgiap
 fziyyxCpr46eoq7jIAyjjr.lPp6xcwtprwhUrbJYG8Aa_VhQ1wg7qM2H9MPSB1884l9n6w7RXjW6
 sHacWZmCwbTiWNT6Jt68Fn8cNTDcJ8eOyjU2m8lU2YPmGWhqOyK9FYxCl_zQl4_Hg474fzyjXHfT
 .A281mTJCexgrFiKC6imUKrzOuCynKyzLiNKguSh1BRQoNmjxpq9mWdMuE9856k8fSuyilxr_Z1Z
 8p9ZVaoY7K93_z0gsTJT9Ry3xGPuJPcCNhs3.FUftNiXswRNVA2RAIv2nnezREAqhb19AR3_SkMW
 GROHAz1yAFkR0IVnChWCROWUjjH0mdsQ3tmWAB8.X95Ps_M3W2ZYcrOBxxcvJu1.dhsJ.GRRY1N1
 ChMgKY_qdeUbARuhjnzHUqVuLh517qClWitrUXl0cRh26Y1bJeP1ZLhsXaSrERuFQEhzMFvvOJY5
 X7ZMo6KBxtO1L7Eeu9kyo.EANZ1egOOFXnztsR0XE0pUypY3i8.0g8qo.2vvH0zmvihD8f3lCzlZ
 I02oUbnWq4GTJaMy2lfZQjbKXb2yRl0oUt2sY6fTvlCG6aWIoaOH20uLoFBs7hJCzvL5wtdvei1j
 RRks1x_blUw61c6M4CAk1g0jg.nF8P0rZo7pL6Ev4BVwxoRIBWJO8o08BTWeravps8cJHcGTqrhA
 z0Evyn2ot5xGcGKjkKj7Y0C8X.jh3cVkqBMVvaUylZBZ_47p3qN5GljZBDLk7A.UzST2zaDpQrZO
 e62DKT60Zil8q2nAxJo2W.Orn6_exvfS.fzpzquYF3jID0Q6Nq7m_2IMdx8k1RP.fIqPc8mgXdw7
 fx.iZlGpRdN9h.VCkbYII2KDNKNWO.UXmoD8kkotDIBJyjrbQcAVZxcmm0PUA5MwEVcCKnrYPtow
 LDJ51Kh3v5csbJPL3byeFDhUkY5dlYvQ2uITWMQWRJpU.XOmhA75a0Pv16qdnrkZvrz6dkLTyO4c
 kNboDPA--
X-Sonic-MF: <michalk@myyahoo.com>
X-Sonic-ID: 23727ceb-3aab-4a75-a5a6-c019a044a95a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Tue, 20 May 2025 17:17:49 +0000
Date: Tue, 20 May 2025 16:47:25 +0000 (UTC)
From: Michal Krupa <michalk@myyahoo.com>
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Message-ID: <270336573.1421224.1747759645243@mail.yahoo.com>
Subject: =?UTF-8?Q?[BUG]_MiTAC_PH12LI_BIOS_exposes_broken_MADT_?=
 =?UTF-8?Q?with_HT_enabled_=E2=80=94_fixed_via_apic.aml_override?=
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <270336573.1421224.1747759645243.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.23840 YMailNovation

Hi ACPI maintainers,

I'm reporting a reproducible ACPI MADT/APIC firmware bug on the MiTAC PH12L=
I=C2=A0motherboard (Intel i7-4770TE), where the BIOS fails to enumerate all=
 LAPIC entries when Hyper-Threading is enabled.

Summary:

- BIOS exposes only 4 LAPIC entries in MADT
- SSDTs declare all 8 logical CPUs (0-7)
- Linux kernel fails to initialize HT siblings or behaves erratically

I have validated and resolved the issue by:

- Rebuilding a corrected MADT with 8 LAPIC entries
- Overriding via initramfs (`apic.aml`) using `acpi_apic_instance=3D1 acpi_=
override`
- Verifying proper CPU/IRQ behavior across reboots

[[UPDATE]]

MiTac issued a BIOS firmware update in 2019, but I had to contact to OEM to=
=C2=A0get it. This fix may work for other Haswell era processors, since the=
 firmware is of course system specific, so I will leave it up. If someone c=
an confirm whether this works on another Haswell system, that would be grea=
t.

The override project is documented here:

https://github.com/michalkrupa/rhel-kernel-bugfix

Would this warrant a known-DMI quirk, or a documentation mention for kernel=
/firmware compatibility?

Best,

Michal Krupa

