Return-Path: <linux-acpi+bounces-8560-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD47F990A73
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 19:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 409CAB21427
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 17:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1221DAC81;
	Fri,  4 Oct 2024 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqi76Il4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF11CACEF;
	Fri,  4 Oct 2024 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064491; cv=none; b=vE37iE+RyiRiP/mcGWiCLXsWtAXyvWx28MXLbUCfppvxqPDoiC8T2TjbzP00VoUi/SX1QlvIm4YaSzha46heDtz4NgOlaBWHO8pz5XxDanWNMK4RMD0KXFmKhpHHpHHTcNUaVwLZRjB0ZdJEP1NEYrSDafc+iE2dspeYAoaMIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064491; c=relaxed/simple;
	bh=vIoN4GpuCg59a4ErFTCIsZ4mtSc4k/xM/7/QF23owDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHwlOU/4HCWn4TpMG/VOsPTVIAMjw/AGEYAtk/kmEhXhfg6x/SYnpgOK4JXOAamMc2QOeV85LDROxG7wznV6QxevXQFwsXaCNoOvnHsYLlwX5zRCj1KNW0GKEifKrfuvKuf+9jSKNag3DRYZ0jXHRY5S/jjIzDIU1AAUk4UUdxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqi76Il4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB0DC4CED0;
	Fri,  4 Oct 2024 17:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728064491;
	bh=vIoN4GpuCg59a4ErFTCIsZ4mtSc4k/xM/7/QF23owDI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cqi76Il4uC5ZPz19N2cJc0migHOoPqFW6D/vmSvlKnGLGNqMwT8US9jaZHWdEjTg1
	 UkFKPeyKiMz0q86Kdheon9VX0TebhH4ATyAFzUjvMLD6Fp2wtR12gN99HmDSUWAXGW
	 ATNU9LX94cErNndZ0PCZ/3euBiLAzOTwFZW8Qc3+FWTON/p7ydS01yEBn1M3xe98yR
	 pdwIt+zTTyshpyfkJLlyuo5xhM3VOrH1bg8UbMAhx0mB9mehwbMbit53V2h3Tz60wf
	 4R5rsQ6a25M9FPRQ/kYq3cfgDbGfwBhU0xRxNtQ+tN9P4L7Rb2mXLmJdHXFoQ31OG/
	 DX5h3m+pHQr0g==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5e5568f1b6eso1210456eaf.1;
        Fri, 04 Oct 2024 10:54:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCQAi7MvXeCp51UE4dBSSXHaQyIiHwJbpb1MGy0oXarB16dl9WoNsh5TmaEsA6krTOYpXa7vdKqFnDzP6K@vger.kernel.org, AJvYcCUmIMvV6nURTfsQQyVeUqeZKC3ebe12uNqDX63wJFRcU99lou8FsvsIFIkuIA/XS6TvAgOyApOHnrfm3Of8@vger.kernel.org, AJvYcCViicSO/8i4rJFUS/DJTGt0ph/rYpWk7ZfMp6QrPZbHqZ2mAhZPUq7TT5S5ZQ2095T8CfF98az1Fg/X@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+WldRt0+OvQ6wcMVTCD89MzblRZ5KD1uQayyTQnCirUJKZna+
	WUSxeMQlqJjRGTJgBH1p2q2W7lOLlyFC/MgaZlbwSHG4mfUbbBqUBUY5b+BknRLJe2NLseJSX22
	KG5lg07EV/oBqV1hQ5Q1joSrXRTA=
X-Google-Smtp-Source: AGHT+IHHU5oF+bEJbOmmVNOobDQq8hExkxmIB2OVr3TpoNANPW2L8tWMdr0JMDOM05w0lfgNI2DdzksEHdeqzKI/MAc=
X-Received: by 2002:a05:6820:2283:b0:5ba:ec8b:44b5 with SMTP id
 006d021491bc7-5e7cc05e00amr2315276eaf.3.1728064490629; Fri, 04 Oct 2024
 10:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912173901.3969597-1-rrangel@chromium.org>
 <20240912113616.3.I1b7a5033a2191cb0cdbadc2d51666a97f16cc663@changeid>
 <CAJZ5v0hmf55OA1f4egzE7F0ET+7af_+pcxmnOSxO5Snd6L5CrQ@mail.gmail.com> <CAHQZ30CRYoH_-rY7hMgasbkyqEBpgVfH6PZRzuaU=2g4S_oGtA@mail.gmail.com>
In-Reply-To: <CAHQZ30CRYoH_-rY7hMgasbkyqEBpgVfH6PZRzuaU=2g4S_oGtA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Oct 2024 19:54:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hQicgscfoOhkh8DN5MmYBK8-5gJvzM=ixs6k75XqE2og@mail.gmail.com>
Message-ID: <CAJZ5v0hQicgscfoOhkh8DN5MmYBK8-5gJvzM=ixs6k75XqE2og@mail.gmail.com>
Subject: Re: [PATCH 3/3] ACPI: SPCR: Add support for rev 3
To: Raul Rangel <rrangel@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-serial@vger.kernel.org, pmladek@suse.com, 
	rafael.j.wysocki@intel.com, ribalda@chromium.org, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 7:45=E2=80=AFPM Raul Rangel <rrangel@chromium.org> w=
rote:
>
> On Wed, Oct 2, 2024 at 12:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Thu, Sep 12, 2024 at 7:39=E2=80=AFPM Raul E Rangel <rrangel@chromium=
.org> wrote:
> > >
> > > Revision 3 supports specifying the UART input clock. This allows for
> > > proper computation of the UART divisor when the baud rate is specifie=
d.
> > >
> > > The earlycon code can accept the following format (See `parse_options=
`
> > > in `earlycon.c`.):
> > > * <name>,io|mmio|mmio32|mmio32be,<addr>,<baud>,<uartclk>,<options>
> > >
> > > This change makes it so the uartclk is passed along if it's defined i=
n
> > > the SPCR table.
> > >
> > > Booting with `earlycon` and a SPCR v3 table that has the uartclk and
> > > baud defined:
> > > [    0.028251] ACPI: SPCR: console: uart,mmio32,0xfedc9000,115200,480=
00000
> > > [    0.028267] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options =
'115200,48000000')
> > > [    0.028272] printk: legacy bootconsole [uart0] enabled
> > >
> > > Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serp=
orts/serial-port-console-redirection-table
> > >
> > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > >
> > > ---
> > >
> > >  drivers/acpi/spcr.c   | 5 ++++-
> > >  include/acpi/actbl3.h | 6 +++---
> > >  2 files changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> > > index cd36a97b0ea2c7..67ae42afcc59ef 100644
> > > --- a/drivers/acpi/spcr.c
> > > +++ b/drivers/acpi/spcr.c
> > > @@ -209,9 +209,12 @@ int __init acpi_parse_spcr(bool enable_earlycon,=
 bool enable_console)
> > >         if (!baud_rate) {
> > >                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, io=
type,
> > >                          table->serial_port.address);
> > > -       } else {
> > > +       } else if (table->header.revision <=3D 2 || !table->uartclk) =
{
> > >                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart,=
 iotype,
> > >                          table->serial_port.address, baud_rate);
> > > +       } else {
> > > +               snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d,%d", ua=
rt, iotype,
> > > +                        table->serial_port.address, baud_rate, table=
->uartclk);
> > >         }
> > >
> > >         pr_info("console: %s\n", opts);
> > > diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> > > index 8f775e3a08fdfb..afe45a2379866a 100644
> > > --- a/include/acpi/actbl3.h
> > > +++ b/include/acpi/actbl3.h
> >
> > The part of the patch below is outdated - SPCR v4 is supported already.
> >
> > Please rebase on the current mainline kernel source.
>
> Oh awesome. Should I send out all three patches again? Or just this
> one? I think patches 1 and 2 can be merged.

I have only received patch [3/3] and this one needs to be resent as
far as I'm concerned.

