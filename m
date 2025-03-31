Return-Path: <linux-acpi+bounces-12560-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9879FA766C7
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 15:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F049A3A9EA2
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 13:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5372116EB;
	Mon, 31 Mar 2025 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/KMf7Ad"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A9617A2FA;
	Mon, 31 Mar 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743427422; cv=none; b=WnpkjktzF5B6//7fTer4BYeWIGsZBPrQyFoy6nBo2PsDpR2xcJRDTtNEDo64PIExTFJTN8mqK1fi+1Qt7GQUOCGJVUWDBZLchDbXRnNz39QI6sMzXfMYgAvYDxrxBvyPsyUQ3BfiZLtVpf97GmFR9pMvcxemYMQiTQ4t7UV9aqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743427422; c=relaxed/simple;
	bh=BNvLxh5zFpguHH6d2CpK/g7iaez1WKqjMuDikvk/WsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HznKiv9JTDUMle4EGOCQzUhY/0eEt/u9kMDRlJ2yZph4c/kMA4xqnHMDarFoXRYIjo30LWgdhtylGJxFSWGxcY1sJdV3vVbVicP+z1E8XQj/CI3gq481N7lPX/28TKdGDkibGi5gw0IoVCNBVKCqt4wP11s9DaQAAF3Jun7e094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/KMf7Ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8212DC4CEE3;
	Mon, 31 Mar 2025 13:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743427420;
	bh=BNvLxh5zFpguHH6d2CpK/g7iaez1WKqjMuDikvk/WsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t/KMf7AdlJOt6yO09WNRUYCsZ3Pg/d9as77b3kAXaKnYEqjsLo8zJ3dcYd/tW5K58
	 adbprGvchIGbgCsCH1UH3FuL32t2/DGULEWY/fbhbYWhFWu22hebNSo0ZDEWrnhqa1
	 /JnZ30HmAnK+1829u+jf/s+RBNs0+ZFtyAkg5iBLPovVsiUZvv6Y7YVWJkczF4XeeO
	 r9yY2JimDoJRBXB+aOHMlNkedEvj77RZmrgIGWBV/2LBHZ8D5bz0DsTR2cjQob1v/Q
	 a2t1sgLfv1ihcVaLEnO9Jh2N56BbXovPourDE1rjEski+PSMjBs4sMIjAmlKCUW5Qt
	 glp+T9G4+mQ/w==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c77a5747e0so2640727fac.2;
        Mon, 31 Mar 2025 06:23:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYdfwNB7IW9vwbqJYk002vOCfbBgg+yFHbb0g6Tg3iLFoJ34/vZhIa5gbHn94Xp6IKY/ovqvWhUm2e@vger.kernel.org, AJvYcCWwhdBbSAQTRRC7y5AfFPjbwFyTXPlNk+A71sDTyMB3AwZ4ljBzOS45ec2Hwpk7ogalBZEsrRb+nUknbOrU@vger.kernel.org
X-Gm-Message-State: AOJu0YxD9s8WbvhQ4uOtozzjbH75/qFbKQGBpoG0PGtSNlcafLa11UCz
	UOxf00V/zol9dy/c9+yHrweBcQbH0hdXL73dgEqHnbHouuwVenybwNRY193GYH/OWUF03HqdyTh
	fpCSg/M6kLOyhsHpoC5+NAZTcGPA=
X-Google-Smtp-Source: AGHT+IFpjRAG9jxkdHVT1kiTjIYNaocNQRJBpnWXCk7BJLlLGdHW5Rg4gN7sPQ9eXfl0WvbDapdST+EC1XbE9rhVC70=
X-Received: by 2002:a05:6870:610d:b0:2c2:519e:d9a9 with SMTP id
 586e51a60fabf-2cbcf765ef8mr5111966fac.24.1743427419888; Mon, 31 Mar 2025
 06:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61c3df83ab73aba0bc7a941a443cd7faf4cf7fb0.1743195250.git.soyer@irl.hu>
 <CAJZ5v0jBONZ7UFL0HCOV=7xmnUphL_UTV=_1PnYmR6n0oN4pcg@mail.gmail.com> <d3dfe61a-1d4d-4aa6-870c-61249799e6da@redhat.com>
In-Reply-To: <d3dfe61a-1d4d-4aa6-870c-61249799e6da@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 31 Mar 2025 15:23:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hy7ge+vPgNXzo89=qu7pP-tPgbjUPRHUMdwUnSTpVXQQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jq2qoSpp3qytZmIhGEF74CJIGeXYn3IZnod2sw1TIK9OOzCAOUj43B2Xj4
Message-ID: <CAJZ5v0hy7ge+vPgNXzo89=qu7pP-tPgbjUPRHUMdwUnSTpVXQQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
To: Hans de Goede <hdegoede@redhat.com>, Gergo Koteles <soyer@irl.hu>
Cc: Len Brown <lenb@kernel.org>, Alex Hung <alex.hung@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
	Alex Deucher <alexander.deucher@amd.com>, linux-acpi@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 3:04=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 31-Mar-25 1:46 PM, Rafael J. Wysocki wrote:
> > On Fri, Mar 28, 2025 at 10:09=E2=80=AFPM Gergo Koteles <soyer@irl.hu> w=
rote:
> >>
> >> The _DDC method should return a buffer, or an integer in case of an er=
ror.
> >> But some Lenovo laptops incorrectly return EDID as buffer in ACPI pack=
age.
> >>
> >> Calling _DDC generates this ACPI Warning:
> >> ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - \
> >> found Package, expected Integer/Buffer (20240827/nspredef-254)
> >>
> >> Use the first element of the package to get the EDID buffer.
> >>
> >> The DSDT:
> >>
> >> Name (AUOP, Package (0x01)
> >> {
> >>         Buffer (0x80)
> >>         {
> >>         ...
> >>         }
> >> })
> >>
> >> ...
> >>
> >> Method (_DDC, 1, NotSerialized)  // _DDC: Display Data Current
> >> {
> >>         If ((PAID =3D=3D AUID))
> >>         {
> >>                 Return (AUOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.AUOP */
> >>         }
> >>         ElseIf ((PAID =3D=3D IVID))
> >>         {
> >>                 Return (IVOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.IVOP */
> >>         }
> >>         ElseIf ((PAID =3D=3D BOID))
> >>         {
> >>                 Return (BOEP) /* \_SB_.PCI0.GP17.VGA_.LCD_.BOEP */
> >>         }
> >>         ElseIf ((PAID =3D=3D SAID))
> >>         {
> >>                 Return (SUNG) /* \_SB_.PCI0.GP17.VGA_.LCD_.SUNG */
> >>         }
> >>
> >>         Return (Zero)
> >> }
> >>
> >> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extens=
ions/output-device-specific-methods.html#ddc-return-the-edid-for-this-devic=
e
> >> Cc: stable@vger.kernel.org
> >> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if ava=
ilable for eDP")
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
> >> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> >> ---
> >> Changes in v2:
> >>  - Added comment
> >>  - Improved commit message
> >>  - Link to v1: https://lore.kernel.org/all/4cef341fdf7a0e877c50b502fc9=
5ee8be28aa811.1743129387.git.soyer@irl.hu/
> >
> > Hans, any concerns here?
>
> No the patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

OK, applied as 6.15-rc material, thanks!

