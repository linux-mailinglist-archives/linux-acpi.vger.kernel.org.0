Return-Path: <linux-acpi+bounces-7318-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654B5948225
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 21:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D8B1C21EFB
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 19:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF46015FA76;
	Mon,  5 Aug 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e6Ga4rQa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB1364AB
	for <linux-acpi@vger.kernel.org>; Mon,  5 Aug 2024 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885462; cv=none; b=E35uOhp1wBMfPxIQk8prIXB3Um7iICVab8tZbGrWSvqxnd5UBFveL9T+Rn68EfyVlr07Hfg6PsavXUBQthBVMjI6L6Pyu7x14isyilM3UXTrlMyFyOCfdKH3ViLBcCSO86UOeIVvCkHUPY4GYsqBZeDv39oHFDwKc5nTuSiCeE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885462; c=relaxed/simple;
	bh=DuMPoQQhTgSet1wyrZE4Tve2P6L8Uoai3Cdd7DwYklc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sG0J3QVcgFlyYhyO88x6/JaMxFotwjMjwm5VLjeH+DXo5H51uEbuE2jr8EWr2X9lBl6ZDz40KlIpWgYxWnWuey6uLzyv+y0uNspgmcmKnMIcF/LYMQrgAdM3w03lZ4A8XayrZnBwA4zStCOII9ISXVOwX0qRRxh+As/SXHh/ayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e6Ga4rQa; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so16286874a12.3
        for <linux-acpi@vger.kernel.org>; Mon, 05 Aug 2024 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722885459; x=1723490259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgSlqVJ+K4htwcqBeKJpdBmMqNKEpg/r1M8ow/yx2IA=;
        b=e6Ga4rQazRGHv2Rxx54xoE5AaQZgY17lS2ZXpz16DU+hWLxrZXJYkIt6wWFyK/7Z0q
         ExbWl2fvmtzqOC6vvAAPVZgMrst3c/M1g/yHXs9ZVGb1+AuazAckByOjx4esrgGe7C4H
         G1o4Xz4tLkxaO+P+8fcJXPQZv7AXs1oIIoN2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722885459; x=1723490259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgSlqVJ+K4htwcqBeKJpdBmMqNKEpg/r1M8ow/yx2IA=;
        b=WfzE3+OTtjdrACyKC5aiMLHSmrNWD6+SkT+dVbB9tedlc4j93QjROPN1909eUuqvIK
         hrjp0pkbany2QsXTcnmdtC0wS1wUdqYMdeAh6hVpWXvfRz8dYhJHxF7ryjm8CUAOuqvx
         PyWrDNkK7lPO1kderkCfGuN8FdXqqc0fxkR8bCLZQpOLU5jqEu4w1HHmlK+pTmzXBdei
         6lQyr+hrJSeEVKRUotzFo79AbAOdDeDuW/ZyOlBJDyg4+LrlBjhImVNunLsMiM9NETSn
         fo8LNdR7DlZ1DaDfMA76AheYw0n+KtBbDraj/w6j4m7WZS+vwFDRdaI3V6qIy4AlROf5
         UEdw==
X-Forwarded-Encrypted: i=1; AJvYcCWwyvpWLUIBcE7Mh9f1xAvkL5QCVXs4LX/2AdRDEaNKfrlWPhHW3DgZy9eH0oLG+gPGj9Twu9F7UUiRzqMAbnwCB4tVwcdW0Pyqkg==
X-Gm-Message-State: AOJu0Yz9jC4FyWB4CFgIasBqzublQlKzEpI4SZIK9JSNiQkvHQGN6U5c
	8ntz4xlVHLfwUc/suaKiu4+5TIsPnYZfXhQe5FTINWrGNErg6cNrF+pqiFllJmVGsLb+94vdUl2
	zyV6BYaruKxwSijdskn0kPvfWfC1Jyxw6FS4+
X-Google-Smtp-Source: AGHT+IFb17PIMNnbbY7zObqbVYZSDIE2BWi2Tb73439/mBG3ZRAwprsjxmoyJNei5QkAkIgYPyhfVesTtntLFYGaSUQ=
X-Received: by 2002:aa7:cad6:0:b0:57c:7471:a0dd with SMTP id
 4fb4d7f45d1cf-5b7f3bcfb2fmr9164411a12.12.1722885459333; Mon, 05 Aug 2024
 12:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
 <20240326-pci-bridge-d3-v4-3-f1dce1d1f648@linaro.org> <CAJMQK-hu+FrVtYaUiwfp=uuYLT_xBRcHb0JOfMBz5TYaktV6Ow@mail.gmail.com>
 <20240802053302.GB4206@thinkpad> <CAJMQK-gtPo4CVEXFDfRU9o+UXgZrsxZvroVsGorvLAdkzfjYmg@mail.gmail.com>
 <20240805153546.GE7274@thinkpad>
In-Reply-To: <20240805153546.GE7274@thinkpad>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Mon, 5 Aug 2024 12:17:13 -0700
Message-ID: <CAJMQK-iZ6s0UmsT91TCRe6E9RMZ-3BndDFtXqCUxdWGcyxPSTA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] PCI: Decouple D3Hot and D3Cold handling for bridges
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, lukas@wunner.de, mika.westerberg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 8:35=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Fri, Aug 02, 2024 at 12:53:42PM -0700, Hsin-Yi Wang wrote:
>
> [...]
>
> > > > [   42.202016] mt7921e 0000:01:00.0: PM: calling
> > > > pci_pm_suspend_noirq+0x0/0x300 @ 77, parent: 0000:00:00.0
> > > > [   42.231681] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D=
3hot
> > >
> > > Here I can see that the port entered D3hot
> > >
> > This one is the wifi device connected to the port.
> >
>
> Ah, okay. You could've just shared the logs for the bridge/rootport.
>
> > > > [   42.238048] mt7921e 0000:01:00.0: PM:
> > > > pci_pm_suspend_noirq+0x0/0x300 returned 0 after 26583 usecs
> > > > [   42.247083] pcieport 0000:00:00.0: PM: calling
> > > > pci_pm_suspend_noirq+0x0/0x300 @ 3196, parent: pci0000:00
> > > > [   42.296325] pcieport 0000:00:00.0: PCI PM: Suspend power state: =
D0
> > >
> > This is the port suspended with D0. If we hack power_manageable to
> > only consider D3hot, the state here for pcieport will become D3hot
> > (compared in below).
> >
> > If it's D0 (and s2idle), in resume it won't restore config:
> > https://elixir.bootlin.com/linux/v6.10/source/drivers/pci/pci-driver.c#=
L959,
> > and in resume it would be an issue.
> >
> > Comparison:
> > 1. pcieport can go to D3:
> > (suspend)
> > [   61.645809] mt7921e 0000:01:00.0: PM: calling
> > pci_pm_suspend_noirq+0x0/0x2f8 @ 1139, parent: 0000:00:00.0
> > [   61.675562] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
> > [   61.681931] mt7921e 0000:01:00.0: PM:
> > pci_pm_suspend_noirq+0x0/0x2f8 returned 0 after 26502 usecs
> > [   61.690959] pcieport 0000:00:00.0: PM: calling
> > pci_pm_suspend_noirq+0x0/0x2f8 @ 3248, parent: pci0000:00
> > [   61.755359] pcieport 0000:00:00.0: PCI PM: Suspend power state: D3ho=
t
> > [   61.761832] pcieport 0000:00:00.0: PM:
> > pci_pm_suspend_noirq+0x0/0x2f8 returned 0 after 61345 usecs
> >
>
> Why the device state is not saved? Did you skip those logs?
>
Right, I only showed the power state of pcieport and the device here
to show the difference of 1 and 2.

> > (resume)
> > [   65.243981] pcieport 0000:00:00.0: PM: calling
> > pci_pm_resume_noirq+0x0/0x190 @ 3258, parent: pci0000:00
> > [   65.253122] mtk-pcie-phy 16930000.phy: CKM_38=3D0x13040500,
> > GLB_20=3D0x0, GLB_30=3D0x0, GLB_38=3D0x30453fc, GLB_F4=3D0x1453b000
> > [   65.262725] pcieport 0000:00:00.0: PM:
> > pci_pm_resume_noirq+0x0/0x190 returned 0 after 175 usecs
> > [   65.273159] mtk-pcie-phy 16930000.phy: No calibration info
> > [   65.281903] mt7921e 0000:01:00.0: PM: calling
> > pci_pm_resume_noirq+0x0/0x190 @ 3259, parent: 0000:00:00.0
> > [   65.297108] mt7921e 0000:01:00.0: PM: pci_pm_resume_noirq+0x0/0x190
> > returned 0 after 329 usecs
> >
> >
> > 2. pcieport stays at D0 due to power_manageable returns false:
> > (suspend)
> > [   52.435375] mt7921e 0000:01:00.0: PM: calling
> > pci_pm_suspend_noirq+0x0/0x300 @ 2040, parent: 0000:00:00.0
> > [   52.465235] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
> > [   52.471610] mt7921e 0000:01:00.0: PM:
> > pci_pm_suspend_noirq+0x0/0x300 returned 0 after 26602 usecs
> > [   52.480674] pcieport 0000:00:00.0: PM: calling
> > pci_pm_suspend_noirq+0x0/0x300 @ 143, parent: pci0000:00
> > [   52.529876] pcieport 0000:00:00.0: PCI PM: Suspend power state: D0
> >                 <-- port is still D0
> > [   52.536056] pcieport 0000:00:00.0: PCI PM: Skipped
> >
> > (resume)
> > [   56.026298] pcieport 0000:00:00.0: PM: calling
> > pci_pm_resume_noirq+0x0/0x190 @ 3243, parent: pci0000:00
> > [   56.035379] mtk-pcie-phy 16930000.phy: CKM_38=3D0x13040500,
> > GLB_20=3D0x0, GLB_30=3D0x0, GLB_38=3D0x30453fc, GLB_F4=3D0x1453b000
> > [   56.044776] pcieport 0000:00:00.0: PM:
> > pci_pm_resume_noirq+0x0/0x190 returned 0 after 13 usecs
> > [   56.055409] mtk-pcie-phy 16930000.phy: No calibration info
> > [   56.064098] mt7921e 0000:01:00.0: PM: calling
> > pci_pm_resume_noirq+0x0/0x190 @ 3244, parent: 0000:00:00.0
> > [   56.078962] mt7921e 0000:01:00.0: Unable to change power state from
> > D3hot to D0, device inaccessible                    <-- resume failed.
>
> This means the port entered D3Cold? This is not expected during s2idle. D=
uring
> s2idle, devices should be put into low power state and their power should=
 be
> preserved.
>
> Who is pulling the plug here?

In our system's use case, after the kernel enters s2idle then ATF (arm
trusted firmware) will turn off the power (similar to suspend to ram).

The issue can previously be handled by setting pcie_port_pm=3Dforce, or
using v3 of the series that sets a flag in DT.

>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

