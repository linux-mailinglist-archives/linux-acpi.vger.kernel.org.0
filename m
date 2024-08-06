Return-Path: <linux-acpi+bounces-7369-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5436949867
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 21:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C3F1F21B03
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 19:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1768154C05;
	Tue,  6 Aug 2024 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QyAM3BLt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D51547D2
	for <linux-acpi@vger.kernel.org>; Tue,  6 Aug 2024 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972919; cv=none; b=QHKoehxJngnUrVxlpBFwJAfobCg1hbnxFMQSgMS4w8lDGHe3Gau0EyDNxI8A67np/fJaMEkE1Zis8PS+cpcTN+u87jWBKK6BWS9mikw6HU4FNQbb0Nao14jXmz/aHkKTQL0y1N9CBLPx1rnk1atl8/71ZKc9cu2AVrgHTmH/kiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972919; c=relaxed/simple;
	bh=Mi3krm6qKlcXMFdQvEFj4HhJT1E3mVvwjBP6EDvEadY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMiTM5DE6e9K19hwpoJJHyOZoTGQrx1jrtDSZZmM6FVqN4FaucAqfIVxIts7FThST2q8YXv7IMChh1Ysb/bdKtt09P63occ/a/xH4CdFMi10NjRCPeS2asYg/fkXu5H+tHnM9TAiWIlydHX1BWB1kayAEmIqSIVfnFvHouwYlSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QyAM3BLt; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f025ab3a7so1437480e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 06 Aug 2024 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722972916; x=1723577716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65V64CMleR7tjOpduSpYXGNLWYO2WeeBKGktESkyjrI=;
        b=QyAM3BLtRzzt1fLzC2n9awYKai8a+0CJQgSfwOnb4a5mGeTaOs9C587JnS9ypeM2No
         RgT3wMYEuam+7B6nc+GLf6ZHiW9qr4h/Fvd/ghh5QeMkJnIW4nvLGgBouvdAqZian1a4
         DquJ16YULhaEH0Tlleufv6UnGJNizJtzEWv90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722972916; x=1723577716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65V64CMleR7tjOpduSpYXGNLWYO2WeeBKGktESkyjrI=;
        b=TqnWUr1WBFIO8RDGm2/IWdo3ImylWl8PasF/wSLaFuNXmpTQpgeeX12bAysdOnTNJq
         ATBYaGImHca8OUW9tvWvjBLiFkziQKoFQ4B8UOFfrss2l+eAYvOpAGXloI+IvsfPq8D0
         QKnQj/bwrbI1alaO0pw9o7BMiqKziLJzSDoLF7/CM3CBcSzFpfgTe/piZR3KJlgqB9Of
         Rnru1mDBHE4SteCzIPIMDiLKO27q4sdkDOy0g/g4JpE4Xc6Li6SiQbcd4U1ZJSQEUZEe
         LEz1wWd47tnRtZ2jbg+T+bL270tF6SsBGxFYXL/U4cR4qjSbeuqBhVzVRd+0dfxSnXXq
         2tdw==
X-Forwarded-Encrypted: i=1; AJvYcCXNd3+o4fHcdll33gSSVDZhYbvcsNlsvcHMLfnhCep5zzhPe8dZl00P1l7AzOAabSVw9H1Y1VrlHKlTdgVO2Cl6sYlE/A3vaKK3uQ==
X-Gm-Message-State: AOJu0Yxk0pr5uUrXXB6mwDcZcvZBOyV42bHIIVtqazdf+lg3yTejOmFI
	93oERSqaXWY4vFQXGN+xDjV0skDYbbvH413p2SEjH92/2dWRvuQBMqiPitX3NUVoXo6LVu2nWGl
	jHhaI2/qwkMIw1NweniSasRm1JS4kPe/RMpawW0vlsjGNZzk=
X-Google-Smtp-Source: AGHT+IHSs9543k/zOW9WqMKpwH9LrWuH6uHqfIQ8NSfc6Ur/yfVVd9I9UN8S9btPzYqNYkV8bgO4aucquSvU5cwCLc8=
X-Received: by 2002:ac2:58d5:0:b0:530:db85:e02a with SMTP id
 2adb3069b0e04-530db85e1camr307895e87.22.1722972915814; Tue, 06 Aug 2024
 12:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
 <20240326-pci-bridge-d3-v4-3-f1dce1d1f648@linaro.org> <CAJMQK-hu+FrVtYaUiwfp=uuYLT_xBRcHb0JOfMBz5TYaktV6Ow@mail.gmail.com>
 <20240802053302.GB4206@thinkpad> <CAJMQK-gtPo4CVEXFDfRU9o+UXgZrsxZvroVsGorvLAdkzfjYmg@mail.gmail.com>
 <20240805153546.GE7274@thinkpad> <CAJMQK-iZ6s0UmsT91TCRe6E9RMZ-3BndDFtXqCUxdWGcyxPSTA@mail.gmail.com>
 <20240806150250.GD2968@thinkpad>
In-Reply-To: <20240806150250.GD2968@thinkpad>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Tue, 6 Aug 2024 12:34:49 -0700
Message-ID: <CAJMQK-jMPJUfyKyEwmYxKX3+NykkP9EzP3-knMp=NyY-vczVRA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] PCI: Decouple D3Hot and D3Cold handling for bridges
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, lukas@wunner.de, mika.westerberg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 8:03=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Aug 05, 2024 at 12:17:13PM -0700, Hsin-Yi Wang wrote:
> > On Mon, Aug 5, 2024 at 8:35=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Fri, Aug 02, 2024 at 12:53:42PM -0700, Hsin-Yi Wang wrote:
> > >
> > > [...]
> > >
> > > > > > [   42.202016] mt7921e 0000:01:00.0: PM: calling
> > > > > > pci_pm_suspend_noirq+0x0/0x300 @ 77, parent: 0000:00:00.0
> > > > > > [   42.231681] mt7921e 0000:01:00.0: PCI PM: Suspend power stat=
e: D3hot
> > > > >
> > > > > Here I can see that the port entered D3hot
> > > > >
> > > > This one is the wifi device connected to the port.
> > > >
> > >
> > > Ah, okay. You could've just shared the logs for the bridge/rootport.
> > >
> > > > > > [   42.238048] mt7921e 0000:01:00.0: PM:
> > > > > > pci_pm_suspend_noirq+0x0/0x300 returned 0 after 26583 usecs
> > > > > > [   42.247083] pcieport 0000:00:00.0: PM: calling
> > > > > > pci_pm_suspend_noirq+0x0/0x300 @ 3196, parent: pci0000:00
> > > > > > [   42.296325] pcieport 0000:00:00.0: PCI PM: Suspend power sta=
te: D0
> > > > >
> > > > This is the port suspended with D0. If we hack power_manageable to
> > > > only consider D3hot, the state here for pcieport will become D3hot
> > > > (compared in below).
> > > >
> > > > If it's D0 (and s2idle), in resume it won't restore config:
> > > > https://elixir.bootlin.com/linux/v6.10/source/drivers/pci/pci-drive=
r.c#L959,
> > > > and in resume it would be an issue.
> > > >
> > > > Comparison:
> > > > 1. pcieport can go to D3:
> > > > (suspend)
> > > > [   61.645809] mt7921e 0000:01:00.0: PM: calling
> > > > pci_pm_suspend_noirq+0x0/0x2f8 @ 1139, parent: 0000:00:00.0
> > > > [   61.675562] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D=
3hot
> > > > [   61.681931] mt7921e 0000:01:00.0: PM:
> > > > pci_pm_suspend_noirq+0x0/0x2f8 returned 0 after 26502 usecs
> > > > [   61.690959] pcieport 0000:00:00.0: PM: calling
> > > > pci_pm_suspend_noirq+0x0/0x2f8 @ 3248, parent: pci0000:00
> > > > [   61.755359] pcieport 0000:00:00.0: PCI PM: Suspend power state: =
D3hot
> > > > [   61.761832] pcieport 0000:00:00.0: PM:
> > > > pci_pm_suspend_noirq+0x0/0x2f8 returned 0 after 61345 usecs
> > > >
> > >
> > > Why the device state is not saved? Did you skip those logs?
> > >
> > Right, I only showed the power state of pcieport and the device here
> > to show the difference of 1 and 2.
> >
> > > > (resume)
> > > > [   65.243981] pcieport 0000:00:00.0: PM: calling
> > > > pci_pm_resume_noirq+0x0/0x190 @ 3258, parent: pci0000:00
> > > > [   65.253122] mtk-pcie-phy 16930000.phy: CKM_38=3D0x13040500,
> > > > GLB_20=3D0x0, GLB_30=3D0x0, GLB_38=3D0x30453fc, GLB_F4=3D0x1453b000
> > > > [   65.262725] pcieport 0000:00:00.0: PM:
> > > > pci_pm_resume_noirq+0x0/0x190 returned 0 after 175 usecs
> > > > [   65.273159] mtk-pcie-phy 16930000.phy: No calibration info
> > > > [   65.281903] mt7921e 0000:01:00.0: PM: calling
> > > > pci_pm_resume_noirq+0x0/0x190 @ 3259, parent: 0000:00:00.0
> > > > [   65.297108] mt7921e 0000:01:00.0: PM: pci_pm_resume_noirq+0x0/0x=
190
> > > > returned 0 after 329 usecs
> > > >
> > > >
> > > > 2. pcieport stays at D0 due to power_manageable returns false:
> > > > (suspend)
> > > > [   52.435375] mt7921e 0000:01:00.0: PM: calling
> > > > pci_pm_suspend_noirq+0x0/0x300 @ 2040, parent: 0000:00:00.0
> > > > [   52.465235] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D=
3hot
> > > > [   52.471610] mt7921e 0000:01:00.0: PM:
> > > > pci_pm_suspend_noirq+0x0/0x300 returned 0 after 26602 usecs
> > > > [   52.480674] pcieport 0000:00:00.0: PM: calling
> > > > pci_pm_suspend_noirq+0x0/0x300 @ 143, parent: pci0000:00
> > > > [   52.529876] pcieport 0000:00:00.0: PCI PM: Suspend power state: =
D0
> > > >                 <-- port is still D0
> > > > [   52.536056] pcieport 0000:00:00.0: PCI PM: Skipped
> > > >
> > > > (resume)
> > > > [   56.026298] pcieport 0000:00:00.0: PM: calling
> > > > pci_pm_resume_noirq+0x0/0x190 @ 3243, parent: pci0000:00
> > > > [   56.035379] mtk-pcie-phy 16930000.phy: CKM_38=3D0x13040500,
> > > > GLB_20=3D0x0, GLB_30=3D0x0, GLB_38=3D0x30453fc, GLB_F4=3D0x1453b000
> > > > [   56.044776] pcieport 0000:00:00.0: PM:
> > > > pci_pm_resume_noirq+0x0/0x190 returned 0 after 13 usecs
> > > > [   56.055409] mtk-pcie-phy 16930000.phy: No calibration info
> > > > [   56.064098] mt7921e 0000:01:00.0: PM: calling
> > > > pci_pm_resume_noirq+0x0/0x190 @ 3244, parent: 0000:00:00.0
> > > > [   56.078962] mt7921e 0000:01:00.0: Unable to change power state f=
rom
> > > > D3hot to D0, device inaccessible                    <-- resume fail=
ed.
> > >
> > > This means the port entered D3Cold? This is not expected during s2idl=
e. During
> > > s2idle, devices should be put into low power state and their power sh=
ould be
> > > preserved.
> > >
> > > Who is pulling the plug here?
> >
> > In our system's use case, after the kernel enters s2idle then ATF (arm
> > trusted firmware) will turn off the power (similar to suspend to ram).
> >
>
> This is not acceptable IMO. S2IDLE !=3D S2RAM. Even if you fix the portdr=
v, rest
> of the PCIe client drivers may fail (hint: have you checked the NVMe driv=
er)?
>

NVMe and its port stays at D0. We won't power off them.

> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

