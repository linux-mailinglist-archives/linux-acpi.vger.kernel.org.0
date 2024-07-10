Return-Path: <linux-acpi+bounces-6842-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 380F892D286
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 15:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B3F1F25B09
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A002192495;
	Wed, 10 Jul 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFfyB67p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263919249F;
	Wed, 10 Jul 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617201; cv=none; b=JA6d9wW5zkaR6KvHAbuTOlDzqPIWDNSQO26YDkPNv3AU5unJeQK5t003/AmWeck7nr+buQKoso/EknmrRibUnTvGtQLpW5xQ5j6O8TJaUiZ1z0cFuA+w+hsrsmnOXulTTqKFADWL6tEBd2D49vvLGy1sumHZdgog7jub+gg1ENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617201; c=relaxed/simple;
	bh=huUNhhTJhWFtjsInUEv7wh3a987qL/8BId3TQ7pKYso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOdnrDbo5bfITkpwkByO8/hn3c5Wk5pttTlOC6OPEt8UaWle3xkfryyVVm0Ga6+lEfEddSN6DoVeJTyK/cH5S4HWgM5ALfgMNMaeL7qaUDu+aMbXVt9OQMtAB2Kv5GTmVrch3LRjwHaovZz3sE3TmeMFc/pHfKoFHhtMuJvt3qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFfyB67p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06155C4AF07;
	Wed, 10 Jul 2024 13:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720617201;
	bh=huUNhhTJhWFtjsInUEv7wh3a987qL/8BId3TQ7pKYso=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QFfyB67pfrArc/YSAZmhXQa585RK3v8YkxzG7BSr2h1//0jKCv0ASOCvYpNkOCazg
	 gYHXFuovFgDM8Isq8gBwKnGZzHOfsctCNO8ipr8W/e84BNhYTCgoMFdqdkME45ZDsv
	 f86A7wM01Wckpb0gAJFIyWJiHkv2cWOgUIUQ7uAMnCIWhaH5td4GJWDrNkwAGxomGC
	 qhciIfHSypgh+9ciECLWnV0TgpaHk8YjhBT+5/M6RPYHpO+a+dj5RtzodCP+2a36Uq
	 m915b7qGhzXIBoggnYAIh8Eq5aqK7SbBQfUsu376GqQA3Sy9ag/bbnNb7h/NJ6cHV7
	 17GBMed6HVCCg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c7aff2005bso22716eaf.2;
        Wed, 10 Jul 2024 06:13:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvU38mTARVsfxixBvliZ9D/mQv/K4XP2J+Q5YVbgsEeaLighp61yoOxRzmhm2F2M7VLNm+oB07yek5/vyfoiueuJwwBEoFAxNrOw==
X-Gm-Message-State: AOJu0YxIHbmOdvHQKeXAnkCwPcqyy1P9wfuxUMSvozen29z0Mgq6Gmp6
	wCV2u0pM1s9+wzTMHjeWjxvqlFrGaJnUTLXJEvy+zfr4pJTzTQTok49ETkbmLALXMceWHm4fWTv
	C3xjo85E01yasRdLbuSY5B+5RtlE=
X-Google-Smtp-Source: AGHT+IHsJZjuZ8j57DYvMIy9ZN5zAAF9UpBAeroiul+VAjZIQYW74gb6rUlf8Jz7HB9fp726J4USbwLXE+GLRaP7hM0=
X-Received: by 2002:a4a:a6cc:0:b0:5c6:6aae:b5f5 with SMTP id
 006d021491bc7-5c68df9c85emr5607255eaf.0.1720617200161; Wed, 10 Jul 2024
 06:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <205bd84a-fe8e-4963-968e-0763285f35ba@message-id.googlemail.com> <67d74985-7be5-4e29-aab2-97a08208ca3f@intel.com>
In-Reply-To: <67d74985-7be5-4e29-aab2-97a08208ca3f@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jul 2024 15:13:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i0jJBDqYjp+9_Bmhhf67SrWNXaRY1ZfDx6GEKfCLcGVQ@mail.gmail.com>
Message-ID: <CAJZ5v0i0jJBDqYjp+9_Bmhhf67SrWNXaRY1ZfDx6GEKfCLcGVQ@mail.gmail.com>
Subject: Re: Regression in 6.8 from "ACPI: OSL: Use a threaded interrupt
 handler for SCI"
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: multipart/mixed; boundary="00000000000002bab2061ce46990"

--00000000000002bab2061ce46990
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:51=E2=80=AFPM Wysocki, Rafael J
<rafael.j.wysocki@intel.com> wrote:
>
> Hi,
>
> On 7/8/2024 10:07 AM, Stefan Seyfried wrote:
> > Hi all,
> >
> > any kernels after 6.7 break my trusty old Toughbook CF-51 by rendering
> > many PCI devices unusable.
> >
> > I did first notice that i915 did no longer work and filed
> > https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11437, there I
> > was pointed to commit
> >
> > commit 7a36b901a6eb0e9945341db71ed3c45c7721cfa9
> > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Date:   Mon Nov 27 20:57:43 2023 +0100
> >
> >     ACPI: OSL: Use a threaded interrupt handler for SCI
> >
> > which I verified with a week-long bisecting from 6.7 to 6.8 (just for
> > fun :-)
> >
> Thanks for reporting this, although it would be nice to put linux-acpi
> on the CC.
>
>
> > Just reverting this commit top of 6.10-rc5 (sorry, this machine is not
> > very powerful so I did not try the latest git master) makes everything
> > work fine again.
> >
> > I get these messages in dmesg when running the broken kernels:
> >
> > [  T308] genirq: Flags mismatch irq 9. 00000080 (yenta) vs. 00002080
> > (acpi)
> > [  T305] genirq: Flags mismatch irq 9. 00000080 (uhci_hcd:usb1) vs.
> > 00002080 (acpi)
> > [  T305] genirq: Flags mismatch irq 9. 00000080 (uhci_hcd:usb1) vs.
> > 00002080 (acpi)
> > [   T46] genirq: Flags mismatch irq 9. 00000080 (ehci_hcd:usb1) vs.
> > 00002080 (acpi)
> > [  T312] genirq: Flags mismatch irq 9. 00000080 (firewire_ohci) vs.
> > 00002080 (acpi)
> > [  T305] genirq: Flags mismatch irq 9. 00000080 (uhci_hcd:usb1) vs.
> > 00002080 (acpi)
> > [  T308] genirq: Flags mismatch irq 9. 00000080 (yenta) vs. 00002080
> > (acpi)
> > [  T592] genirq: Flags mismatch irq 9. 00000080 (snd_intel8x0) vs.
> > 00002080 (acpi)
> > [  T581] genirq: Flags mismatch irq 9. 00000080 (i915) vs. 00002080
> > (acpi)
> > [  T874] genirq: Flags mismatch irq 9. 00000080 (enp2s1) vs. 00002080
> > (acpi)
> >
> > These are not present with that commit reverted.
> >
> So all of the drivers above attempt to share the IRQ with the SCI and
> they don't use IRQF_ONESHOT and because they all are threaded, there is
> a flags conflict.
>
> They all need to be made pass IRQF_COND_ONESHOT when requesting
> interrupts and it will all work again.
>
> I'll send you a patch for this (hopefully later today), but I guess it
> will take a while until it gets absorbed.
>
> Thanks!

So can you please check if the attached patch helps?

--00000000000002bab2061ce46990
Content-Type: text/x-patch; charset="US-ASCII"; name="irq-flags-mismatch-fixes.patch"
Content-Disposition: attachment; filename="irq-flags-mismatch-fixes.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lyfv0amz0>
X-Attachment-Id: f_lyfv0amz0

LS0tCiBpbmNsdWRlL2xpbnV4L2ludGVycnVwdC5oIHwgICAgMyArKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCkluZGV4OiBsaW51eC1wbS9pbmNsdWRl
L2xpbnV4L2ludGVycnVwdC5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvaW5jbHVkZS9s
aW51eC9pbnRlcnJ1cHQuaAorKysgbGludXgtcG0vaW5jbHVkZS9saW51eC9pbnRlcnJ1cHQuaApA
QCAtMTY4LDcgKzE2OCw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IF9fbXVzdF9jaGVjawogcmVxdWVz
dF9pcnEodW5zaWduZWQgaW50IGlycSwgaXJxX2hhbmRsZXJfdCBoYW5kbGVyLCB1bnNpZ25lZCBs
b25nIGZsYWdzLAogCSAgICBjb25zdCBjaGFyICpuYW1lLCB2b2lkICpkZXYpCiB7Ci0JcmV0dXJu
IHJlcXVlc3RfdGhyZWFkZWRfaXJxKGlycSwgaGFuZGxlciwgTlVMTCwgZmxhZ3MsIG5hbWUsIGRl
dik7CisJcmV0dXJuIHJlcXVlc3RfdGhyZWFkZWRfaXJxKGlycSwgaGFuZGxlciwgTlVMTCwKKwkJ
CQkgICAgZmxhZ3MgfCBJUlFGX0NPTkRfT05FU0hPVCwgbmFtZSwgZGV2KTsKIH0KIAogZXh0ZXJu
IGludCBfX211c3RfY2hlY2sK
--00000000000002bab2061ce46990--

