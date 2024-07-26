Return-Path: <linux-acpi+bounces-7084-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED4B93DB16
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Jul 2024 01:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318FD280478
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2024 23:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAC514A0A2;
	Fri, 26 Jul 2024 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="efjEE0GD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9A0FC1F
	for <linux-acpi@vger.kernel.org>; Fri, 26 Jul 2024 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722035193; cv=none; b=gAl0C2OusP1iNAmBS8Qfq2b755JtCx6YEWYoKmKvDahJjP26JPDWqucodwwS6gzTUTL5KoLRc9J+uZcyhWToT0aOVadI9Pow4AUdAOa5r0JJwFs6fHlfeWQB47aJHXKa/uL3IXalaLDaNMT/bRQmB5Pgrdo2KKpsHn8EvQ3bXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722035193; c=relaxed/simple;
	bh=ld6KeuB4sATn7KhNW/BfMGlPLHxeZpj4+EBu8ioiPck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqbWCdLbZ0dEa2a01qdbtyezEAIKUOqIfDystloIryEarhXsQ1XM3MDCME3WgF1BPwUdCDSJVKxWUIgePxAWpHlXVPKJ8fyKg1f/qM4erTe8tK+3yUvWZv0VOdKcT1r2ja5JREG6i1H6QAsdgGnlkeGIokU4B+6oxQL7/TCVszE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=efjEE0GD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so3528642a12.3
        for <linux-acpi@vger.kernel.org>; Fri, 26 Jul 2024 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722035189; x=1722639989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+ufKxTs+4yOu1uTFcIromX5f1C1mm5vL8h9xvW7RjA=;
        b=efjEE0GDcJshef/O3pan4Itzex0dz7GegnSqGqNicJe4lcOk2OaqTIt83I95NUZsIB
         uefa+LcmsZE0sMI7I5ZaYKw9s6xq/Y0tr/XHfxcWYduOC4yZzF198bs2DzsuIl1h82//
         c5IOVPfPvq991KIBSMISSDQnGc2xQrrkwggNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722035189; x=1722639989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+ufKxTs+4yOu1uTFcIromX5f1C1mm5vL8h9xvW7RjA=;
        b=RuhK2zH6lYbYUegW80TuKGPidH4biYAA5p5BhnwpR8JBFmAl57NP2qwhWpUX+weFTX
         ZhBxny/OtVTENqBE/JOBM8/DTUUxZeUXtONNn8ybQiAtozoAyABW/yaxPkThWuQla5j9
         EZb0CcdL8Dj3WrvuCsT/p6IDYSuCoWNBkULgu1wTsr9R8i/klBZdI/3zuxFVyYutJtpF
         /lZsOw+IC9pjIQ+B18ljeoGIIAjCKOHC/Pni9kmKlcqie820LhzW4bgHMpfKJOwlBQI+
         fVQ9gjA1wAT4dqTNQMVvyKVXa1xIlQBnL1yd9gcce2uIXBrmQ7RDx6pGLWFTR2QLMOgr
         d2EA==
X-Forwarded-Encrypted: i=1; AJvYcCVcxk+wLbXHxGkxEzu37lLtfxBFz54og99YJooYuFhJLsF0qecPb7mFXHwDyuWgyIVcmCEH5sZokS9/6rt/XXZeb9BJPq0w/VKTag==
X-Gm-Message-State: AOJu0Ywu5NS/EYVqHxJ+KiWk240h2CFtQ1E6gmmL5/2MdrtKcVFktD/p
	PR5pJFeJEHTFu8VAWggY48jNhRL0CdWCVJ1NNLszCZub7QwaAQzKXWMROEtEVgDPZjTz4tLO6yI
	GkXHbOKCKD2Jd8DlOnrXSwW6ULUJfpPsPhWgd
X-Google-Smtp-Source: AGHT+IGEQmOdGLNP3Mq5rTpzM4kyWZztDxXbtgm6nR21X2SELvdhrhBNz1AWPZR1GYT402EWXUxVjo+vAtNCDjCBUiw=
X-Received: by 2002:a05:6402:3487:b0:5a3:b45:3979 with SMTP id
 4fb4d7f45d1cf-5b020ba8a06mr486269a12.17.1722035189399; Fri, 26 Jul 2024
 16:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org> <20240511071532.GC6672@thinkpad>
In-Reply-To: <20240511071532.GC6672@thinkpad>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Fri, 26 Jul 2024 16:06:03 -0700
Message-ID: <CAJMQK-gBACa0s7qo=sOkK2UJB+9WbNHBkfg4NTxp3dVfjvugSg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] PCI: Allow D3Hot for PCI bridges in Devicetree
 based platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukas@wunner.de, 
	mika.westerberg@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 4:02=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Mar 26, 2024 at 04:18:16PM +0530, Manivannan Sadhasivam wrote:
> > Hi,
> >
> > This series allows D3Hot for PCI bridges in Devicetree based platforms.
> > Even though most of the bridges in Devicetree platforms support D3Hot, =
PCI
> > core will allow D3Hot only when one of the following conditions are met=
:
> >
> > 1. Platform is ACPI based
> > 2. Thunderbolt controller is used
> > 3. pcie_port_pm=3Dforce passed in cmdline
> >
> > While options 1 and 2 do not apply to most of the DT based platforms,
> > option 3 will make the life harder for distro maintainers.
> >
> > Initially, I tried to fix this issue by using a Devicetree property [1]=
, but
> > that was rejected by Bjorn and it was concluded that D3Hot should be al=
lowed by
> > default for all the Devicetree based platforms.
> >
> > During the review of v3 series, Bjorn noted several shortcomings of the
> > pci_bridge_d3_possible() API [2] and I tried to address them in this se=
ries as
> > well.
> >
> > But please note that the patches 2 and 3 needs closer review from ACPI =
and x86
> > folks since I've splitted the D3Hot and D3Cold handling based on my lit=
tle
> > understanding of the code.
> >
> > Testing
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > This series is tested on SM8450 based development board on top of [3].
> >
>
> Bjorn, a gently ping on this series.
>

Hi, I was also working on a similar patch to add bridge_d3 to arm
platforms until I found this series, which is what we need. Also
kindly ping on this series.

Thanks!

> - Mani
>
> > - Mani
> >
> > [1] https://lore.kernel.org/linux-pci/20240214-pcie-qcom-bridge-v3-1-3a=
713bbc1fd7@linaro.org/
> > [2] https://lore.kernel.org/linux-pci/20240305175107.GA539676@bhelgaas/
> > [3] https://lore.kernel.org/linux-arm-msm/20240321-pcie-qcom-bridge-dts=
-v2-0-1eb790c53e43@linaro.org/
> >
> > Changes in v4:
> > - Added pci_bridge_d3_possible() rework based on comments from Bjorn
> > - Got rid of the DT property and allowed D3Hot by default on all DT pla=
tforms
> >
> > Changes in v3:
> > - Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
> > - Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-1-=
9dd6dbb1b817@linaro.org
> >
> > Changes in v2:
> > - Switched to DT based approach as suggested by Lukas.
> > - Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-0-=
46d7789836c0@linaro.org
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> > Manivannan Sadhasivam (4):
> >       PCI/portdrv: Make use of pci_dev::bridge_d3 for checking the D3 p=
ossibility
> >       PCI: Rename pci_bridge_d3_possible() to pci_bridge_d3_allowed()
> >       PCI: Decouple D3Hot and D3Cold handling for bridges
> >       PCI: Allow PCI bridges to go to D3Hot on all Devicetree based pla=
tforms
> >
> >  drivers/pci/bus.c          |  2 +-
> >  drivers/pci/pci-acpi.c     |  9 ++---
> >  drivers/pci/pci-sysfs.c    |  2 +-
> >  drivers/pci/pci.c          | 90 ++++++++++++++++++++++++++++++++------=
--------
> >  drivers/pci/pci.h          | 12 ++++---
> >  drivers/pci/pcie/portdrv.c | 16 ++++-----
> >  drivers/pci/remove.c       |  2 +-
> >  include/linux/pci.h        |  3 +-
> >  8 files changed, 89 insertions(+), 47 deletions(-)
> > ---
> > base-commit: 705c1da8fa4816fb0159b5602fef1df5946a3ee2
> > change-id: 20240320-pci-bridge-d3-092e2beac438
> >
> > Best regards,
> > --
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

