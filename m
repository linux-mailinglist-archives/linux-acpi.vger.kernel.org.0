Return-Path: <linux-acpi+bounces-6269-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DB8900BDE
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 20:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98ADB1F225BD
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 18:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68309225AE;
	Fri,  7 Jun 2024 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdAU88Dy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6851D6BD;
	Fri,  7 Jun 2024 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717784736; cv=none; b=HC1eGfkyJ9Lh58WE3il4ztyeXcW0pFgGVwS5Wm8gOEjY5vAQtkWXYQwK/ohKx4BvmZmViSKUJ7RcH7KQb1cviO/3LogiRd7hjOAtP3/JSOWWLMaxvNGRHLnx+4ZbPysMQtX1CMCsADhQjlh1+3pWjjoNvwT3us/lkbJFtNHF3MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717784736; c=relaxed/simple;
	bh=vezZrB3/bhMbQq7I0K1sBx/HwVAzaFUC2u3ohyDZTtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/sPnnap5cUneDx2HnxFGwZkRxM2K2CFMDjOdeyvwiUvj+YQUBw4ydbb/dKu3GwuiwlGBsX0fi7DnbvZxnmpjXXtJJ+wSJinUFMq/dd2y2fmjyWpRJ4wWDnt9CUKaeYBbjjqdhfLsVFeSpLK1+7gUUMlN5sd8tXkP6T5doXnZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdAU88Dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B466FC2BBFC;
	Fri,  7 Jun 2024 18:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717784735;
	bh=vezZrB3/bhMbQq7I0K1sBx/HwVAzaFUC2u3ohyDZTtc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kdAU88Dy3GkMUq0/icDCBymmjcP04EGhJ9qlgdUtxV63TyaRDxyxk1VYKIVcwOJ7S
	 6gg4mp7Ml/yna9VUC5oxyIQJFGviyyygRU0P1NHWOKtq6bUYFehJLWfcQ/09ejxTMC
	 yoxVtd4PsOLl0UMcUrqNX1RiitCRAChgCYhSxbzEUTOiVL04xJVaYS2o3SQqnHCtZh
	 nFqPJdDMVH5c0ke/nq3PT2wtzfSAUpePtayLjnr7NpnNoFoB0PhcKVPCIR/xgJUVDw
	 Mu1wHDs+ohp+BsJg/RTV3oH2G85domr3QwN1LKaCtxHpzRmu73dDcmK6zPs67Pczyt
	 tIUnPofHslV0A==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ba68c30395so268612eaf.1;
        Fri, 07 Jun 2024 11:25:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcwWqnu4LeRqiyV4IkxVSdTcJ522RwXBWUt1y/q73qHUCTOBKoyNyYbxPG0RD3xX8oHCzMWkyog4E0hGovpzxfe2T+zvmqTuyFLZ1vS79dPe3XNDt0T+qGS+EuRCv+iJZMiCk4
X-Gm-Message-State: AOJu0Yzm0utsGaNTuvLyVXL0/1gPicxjjvpW2r2dfDupGurXt/wRKg5v
	sF2mdpcsgDnGeyQMnWG97WamZZFJhytt+9cK8CMglHCrbgsaBVQXp5vdW9ZniYkfKGRhF9kHVvZ
	T7EmbhNhv9y4BRULim9gt+NtDlAM=
X-Google-Smtp-Source: AGHT+IEdxuS8bNc7r1sot2q0tjlocwYOIWhnYTAF4XYWjmXXocHacTNo0yYvl2SLex6Haz3Vn+S3Vw6ABTzpdjLp1VY=
X-Received: by 2002:a4a:ac08:0:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5baae73b688mr3192016eaf.1.1717784734582; Fri, 07 Jun 2024
 11:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509184502.52480-1-mario.limonciello@amd.com> <c9e4b02d-6e3a-4813-8c87-769944176ff2@redhat.com>
In-Reply-To: <c9e4b02d-6e3a-4813-8c87-769944176ff2@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 20:25:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j3crbhGw8-nnacO9V1-7wOnLh0rSUXm8mnXy3xzb_uZA@mail.gmail.com>
Message-ID: <CAJZ5v0j3crbhGw8-nnacO9V1-7wOnLh0rSUXm8mnXy3xzb_uZA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: Force StorageD3Enable on more products
To: Hans de Goede <hdegoede@redhat.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yilin.Chen@amd.com, Randy.Perez@amd.com, Michael.Chiu@amd.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 9:05=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 5/9/24 8:45 PM, Mario Limonciello wrote:
> > A Rembrandt-based HP thin client is reported to have problems where
> > the NVME disk isn't present after resume from s2idle.
> >
> > This is because the NVME disk wasn't put into D3 at suspend, and
> > that happened because the StorageD3Enable _DSD was missing in the BIOS.
> >
> > As AMD's architecture requires that the NVME is in D3 for s2idle, adjus=
t
> > the criteria for force_storage_d3 to match *all* Zen SoCs when the FADT
> > advertises low power idle support.
> >
> > This will ensure that any future products with this BIOS deficiency don=
't
> > need to be added to the allow list of overrides.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Thanks, patch looks good to me:
>
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Applied as 6.10-rc material, thanks!

