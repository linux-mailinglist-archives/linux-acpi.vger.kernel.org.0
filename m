Return-Path: <linux-acpi+bounces-8558-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2097D990A57
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 19:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965551F215FD
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 17:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F3C1D9A7F;
	Fri,  4 Oct 2024 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XUVrqwQ7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC9B8249F
	for <linux-acpi@vger.kernel.org>; Fri,  4 Oct 2024 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063958; cv=none; b=uZjqbQ+DLfTk4XatwndoOkS1huiH3lvRpesdkML/7IhzBxcdppZDVoYwXvF35VgA/Ls0W+0n547TR1ZiOYGJKhGLrRzTtoosPTMLEWSmcgtHFRrYyBefy9+UHCusMeEhvqI8rKeqG1Y4cjLqJuknx7CF3BREMuSLLy+wV5ZfGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063958; c=relaxed/simple;
	bh=TI6mcXb4V5s95OY28ThDa+Nttx+DA0b7i9XYbIv6P9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aqirug9KAOXXZHXezhdW7jVSee5Wyvd6aqSIaKU1I3BfRCA1dWwq8xyPd8jpdAnnBBY8aKM7S8r7YgrbIMzEcchABQ4sq4sBbWkJcgwDpKhtCHbdjgEUGWolPPoo/ST15STghAcR0+Khl+NRjkodXmz2ulA403yN2DdG23EYYC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XUVrqwQ7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71de9e1f374so597805b3a.1
        for <linux-acpi@vger.kernel.org>; Fri, 04 Oct 2024 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728063956; x=1728668756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hTEi2pGCxMRGUpF5+1bzMouLoBbQyVgP6nKgujfGZc=;
        b=XUVrqwQ71xfWtyrURKkM2S/CkVr1OI6s/zA24zO1EN9F6sppGPlvRBvq20B51s55Zx
         0GmFz+NcMX5ThEAEfsMPAfyA4owZHuzJEHJWd+YQfm6LJLBC9mICCgmDmYPeKAcEpNTV
         rRJtsZbUIDD6JADlFdrfVKYOGMwvqMlth+MSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728063956; x=1728668756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hTEi2pGCxMRGUpF5+1bzMouLoBbQyVgP6nKgujfGZc=;
        b=PY8QTh8E/kI8nF/L6ddaFC2bFntj/y7+q71FU9ZmaakbyF3MiISs+9joKZfmxI1aOJ
         prQkpoCAjeQB5eEOPyFDroaK4vNRcbbCoEiNu/atjQqV2h4G066/4OF69Nayr4bO9vEe
         z21zuUL8XpLSvjvRq4pnrTsFBTd/KBU5ppKn15t7RjrDvRrfaT1Opv0yNeIG33pS55AZ
         +PvKkbXGetAoOpwWSJcdVKragnCyGLAkvlCOEHLacAH/JgpL8DQwczWDwTKiVfGjtfe7
         DKdm6xiksl8jN5ekguix57yPY/X1Xyx+6+XTEVfofvamKxBjRnUfTpaIRHL7Hey/PE9B
         6rsA==
X-Forwarded-Encrypted: i=1; AJvYcCUflcTXGspiQs25JODBKsXhGsqzbzinRBAKvSd7XQg1tZjvwq82Iw49XhYGUlNr+Io46Awiad9x5Px1@vger.kernel.org
X-Gm-Message-State: AOJu0YzM+hRGu6HccCJoZNyaAS8UmC9zQjBMw/t0iYaeMC9UTFL4HvY3
	2HcHRhZ5UyrFKdNvUFmXgu4xkj9yGwdw7s2/KI59UnpH8iLUXiRdWu5ln3jxXRe3aY3roRK24eM
	=
X-Google-Smtp-Source: AGHT+IEa1ylGS7rCTYej/G3bGZUpdbX2UC3z6TQ0lgaSyCxf6QS2KrqCB7c6sg/2jVU+y+No2gu1IQ==
X-Received: by 2002:a05:6a20:c88a:b0:1cf:4ad8:83b9 with SMTP id adf61e73a8af0-1d6dfae299fmr5901850637.43.1728063956096;
        Fri, 04 Oct 2024 10:45:56 -0700 (PDT)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d09bsm118987b3a.199.2024.10.04.10.45.53
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 10:45:54 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7e6b738acd5so821490a12.0
        for <linux-acpi@vger.kernel.org>; Fri, 04 Oct 2024 10:45:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMFSD87g2OSeLALe1fiKpK4jQb3x5UclgrELZi1YlIySdpWUGjDjByeJ4nEKExsl78ReukqZ8sVUEZ@vger.kernel.org
X-Received: by 2002:a05:6a20:9f8f:b0:1d2:e1b5:2b51 with SMTP id
 adf61e73a8af0-1d6dfa1e516mr5534269637.8.1728063952820; Fri, 04 Oct 2024
 10:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912173901.3969597-1-rrangel@chromium.org>
 <20240912113616.3.I1b7a5033a2191cb0cdbadc2d51666a97f16cc663@changeid> <CAJZ5v0hmf55OA1f4egzE7F0ET+7af_+pcxmnOSxO5Snd6L5CrQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hmf55OA1f4egzE7F0ET+7af_+pcxmnOSxO5Snd6L5CrQ@mail.gmail.com>
From: Raul Rangel <rrangel@chromium.org>
Date: Fri, 4 Oct 2024 11:45:39 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CRYoH_-rY7hMgasbkyqEBpgVfH6PZRzuaU=2g4S_oGtA@mail.gmail.com>
Message-ID: <CAHQZ30CRYoH_-rY7hMgasbkyqEBpgVfH6PZRzuaU=2g4S_oGtA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ACPI: SPCR: Add support for rev 3
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-serial@vger.kernel.org, pmladek@suse.com, rafael.j.wysocki@intel.com, 
	ribalda@chromium.org, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Sep 12, 2024 at 7:39=E2=80=AFPM Raul E Rangel <rrangel@chromium.o=
rg> wrote:
> >
> > Revision 3 supports specifying the UART input clock. This allows for
> > proper computation of the UART divisor when the baud rate is specified.
> >
> > The earlycon code can accept the following format (See `parse_options`
> > in `earlycon.c`.):
> > * <name>,io|mmio|mmio32|mmio32be,<addr>,<baud>,<uartclk>,<options>
> >
> > This change makes it so the uartclk is passed along if it's defined in
> > the SPCR table.
> >
> > Booting with `earlycon` and a SPCR v3 table that has the uartclk and
> > baud defined:
> > [    0.028251] ACPI: SPCR: console: uart,mmio32,0xfedc9000,115200,48000=
000
> > [    0.028267] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '1=
15200,48000000')
> > [    0.028272] printk: legacy bootconsole [uart0] enabled
> >
> > Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serpor=
ts/serial-port-console-redirection-table
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> >
> > ---
> >
> >  drivers/acpi/spcr.c   | 5 ++++-
> >  include/acpi/actbl3.h | 6 +++---
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> > index cd36a97b0ea2c7..67ae42afcc59ef 100644
> > --- a/drivers/acpi/spcr.c
> > +++ b/drivers/acpi/spcr.c
> > @@ -209,9 +209,12 @@ int __init acpi_parse_spcr(bool enable_earlycon, b=
ool enable_console)
> >         if (!baud_rate) {
> >                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, ioty=
pe,
> >                          table->serial_port.address);
> > -       } else {
> > +       } else if (table->header.revision <=3D 2 || !table->uartclk) {
> >                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, i=
otype,
> >                          table->serial_port.address, baud_rate);
> > +       } else {
> > +               snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d,%d", uart=
, iotype,
> > +                        table->serial_port.address, baud_rate, table->=
uartclk);
> >         }
> >
> >         pr_info("console: %s\n", opts);
> > diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> > index 8f775e3a08fdfb..afe45a2379866a 100644
> > --- a/include/acpi/actbl3.h
> > +++ b/include/acpi/actbl3.h
>
> The part of the patch below is outdated - SPCR v4 is supported already.
>
> Please rebase on the current mainline kernel source.

Oh awesome. Should I send out all three patches again? Or just this
one? I think patches 1 and 2 can be merged.

>
> > @@ -92,10 +92,10 @@ struct acpi_table_slit {
> >  /*********************************************************************=
**********
> >   *
> >   * SPCR - Serial Port Console Redirection table
> > - *        Version 2
> > + *        Version 3
> >   *
> >   * Conforms to "Serial Port Console Redirection Table",
> > - * Version 1.03, August 10, 2015
> > + * Version 1.08, October 7, 2021
> >   *
> >   *********************************************************************=
*********/
> >
> > @@ -120,7 +120,7 @@ struct acpi_table_spcr {
> >         u8 pci_function;
> >         u32 pci_flags;
> >         u8 pci_segment;
> > -       u32 reserved2;
> > +       u32 uartclk;
> >  };
> >
> >  /* Masks for pci_flags field above */
> > --
> > 2.46.0.662.g92d0881bb0-goog
> >

