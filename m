Return-Path: <linux-acpi+bounces-21315-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHK4GPQsp2mbfgAAu9opvQ
	(envelope-from <linux-acpi+bounces-21315-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 19:48:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E571F5738
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 19:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F246301A3A7
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 18:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322FB3D6CB5;
	Tue,  3 Mar 2026 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1WRxE09"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6A37F010
	for <linux-acpi@vger.kernel.org>; Tue,  3 Mar 2026 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563689; cv=none; b=gBjFJ22sthipM8+2lHJuk+Er7739GMY1/X5Z0uLQmeRuEPAn5QC/g72YpdM0hE7u5/kALFuLmjBXMdSC33mJ0m6NHgLhOKq6LsSrO5y653aszX8XBy1bzrt0PCyoItfwD4iqnGeWOHHYj40xnZW3TS7nH0DbPw7Ch3RxpMVxFhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563689; c=relaxed/simple;
	bh=BD9wjnSUBgXm9OjM2B2u056ojO9WtpXKBhoeHNzuL64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqHQ4KZH6NCAcP7hi0FbrQZP17Y7rTJz7ugCn3PDAvUHa0Hl9+TIjY921mqwVbB46SWoDFborYvPWFPgb7VILDDUuVs1ThCvmPv/biDK3Lv5vU6il0de0rCUn/KfvI7zv+Pa+wME9SkRfpKuoT3/6MAki9UUlSXafgddjZFtB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1WRxE09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7088C116C6
	for <linux-acpi@vger.kernel.org>; Tue,  3 Mar 2026 18:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772563688;
	bh=BD9wjnSUBgXm9OjM2B2u056ojO9WtpXKBhoeHNzuL64=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L1WRxE09wk4oGkYMOWTJkhLABb1AN7src2vsWT/twufyGdwxJ8hWxdGzfXz6fbLgw
	 i4GFfJ46o//PJpJEBpQybJj0qPDcNuL35Zr8ltIRCNNqPGDPqJ/mk9JdkZDyWMd2GG
	 moo/Lr0flVhzcGOn9qeQFOxxbDD156fHCCx+WLWYVAyhiih8BhbdI2K2EfHGECd2C5
	 bhLh2DvCB21T3yzYTru9ruQxtbisoo5j/sLL9JYqQJ9Fs9GHGm0o79rmzsVnF+hWD4
	 Ef51Q2v4v+pVgu5SH0O4lGyJc0FQ0Rs/O3JUmxBhkQntc2T0zqcx3Hr+KKXP/xzIsb
	 f0gniSYOJ4ZPA==
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12732e6a123so2702571c88.1
        for <linux-acpi@vger.kernel.org>; Tue, 03 Mar 2026 10:48:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCevxhDI/sHjOBDgdYDBVf2G2iUMBiD5wwcKmALfGy5yHFaLdD6/ym2cSDO45einoHwBWu7mhArLFl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6jmp8Ag9gm4dFUQut4ZAcjOp8V2+eiNxWo6beNbV+eqzCXdlo
	xK0KA8VfT+sI9RB4dYUIvv8lQC7FETBZ21mLtKzQVUZvCQQyTvv04nwKj16/fKxD8R2uWYjhTwl
	ezxm1VNspx2rX4jeYjah93wpLi524K/4=
X-Received: by 2002:a05:7022:7a5:b0:11b:ca88:c503 with SMTP id
 a92af1059eb24-1278fc9a69amr7822173c88.3.1772563688010; Tue, 03 Mar 2026
 10:48:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5983325.DvuYhMxLoT@rafael.j.wysocki> <13969123.uLZWGnKmhe@rafael.j.wysocki>
 <20260303060752.GA2749263@ax162> <5087839.31r3eYUQgx@rafael.j.wysocki> <20260303175237.GB1114907@ax162>
In-Reply-To: <20260303175237.GB1114907@ax162>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Mar 2026 19:47:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jgLU_87cESzySAQhP31L83u-sd2xAHFiJmeqrw0NdOhg@mail.gmail.com>
X-Gm-Features: AaiRm53r5VVhjUhKVNIqBkURSr4o5RN2T4l7mgppMp-HoBCPPQpIGfBSE1fdzNQ
Message-ID: <CAJZ5v0jgLU_87cESzySAQhP31L83u-sd2xAHFiJmeqrw0NdOhg@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] ACPI: x86/rtc-cmos: Use platform device for driver binding
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>, linux-rtc@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 70E571F5738
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21315-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 6:52=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Tue, Mar 03, 2026 at 01:51:37PM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, March 3, 2026 7:07:52 AM CET Nathan Chancellor wrote:
> > > After this change in -next as commit 2a78e4210444 ("ACPI: x86/rtc-cmo=
s:
> > > Use platform device for driver binding"), I am seeing
> > >
> > >   rtc_cmos PNP0B00:00: error -ENXIO: IRQ index 0 not found
> > >
> > > on a few of my test machines. Is this expected?
> >
> > Not really, thanks for reporting!
> >
> > Please send me a dmesg boot log from one of the affected systems.
>
> Attached.
>
> > The patch below should make the message go away.
>
> Can confirm, thanks! If it is helpful:
>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Thank you!

Can you please also send me a dmesg boot log from the same system with
this patch applied?

> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH v1] rtc: cmos: Use platform_get_irq_optional() in cmos_=
platform_probe()
> >
> > The rtc-cmos driver can live without an IRQ and returning an error
> > code from platform_get_irq() is not a problem for it in general, so
> > make it call platform_get_irq_optional() in cmos_platform_probe()
> > instead of platform_get_irq() to avoid a confusing error message
> > printed by the latter if an IRQ cannot be found for IRQ index 0,
> > which is possible on x86 platforms.
> >
> > Additionally, on x86, if the IRQ is not defined and the system has
> > a legacy PIC, hardcode it to RTC_IRQ, which should be safe then.
> >
> > Fixes: 2a78e4210444 ("ACPI: x86/rtc-cmos: Use platform device for drive=
r binding")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/rtc/rtc-cmos.c |   13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/rtc/rtc-cmos.c
> > +++ b/drivers/rtc/rtc-cmos.c
> > @@ -1423,9 +1423,18 @@ static int __init cmos_platform_probe(st
> >               resource =3D platform_get_resource(pdev, IORESOURCE_IO, 0=
);
> >       else
> >               resource =3D platform_get_resource(pdev, IORESOURCE_MEM, =
0);
> > -     irq =3D platform_get_irq(pdev, 0);
> > -     if (irq < 0)
> > +     irq =3D platform_get_irq_optional(pdev, 0);
> > +     if (irq < 0) {
> >               irq =3D -1;
> > +#ifdef CONFIG_X86
> > +             /*
> > +              * On some x86 systems, the IRQ is not defined, but it sh=
ould
> > +              * always be safe to hardcode it on systems with a legacy=
 PIC.
> > +              */
> > +             if (nr_legacy_irqs())
> > +                     irq =3D RTC_IRQ;
> > +#endif
> > +     }
> >
> >       return cmos_do_probe(&pdev->dev, resource, irq);
> >  }
> >
> >
> >

