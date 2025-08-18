Return-Path: <linux-acpi+bounces-15807-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D740FB2ADD1
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97586221A9
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 16:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBADA3375DF;
	Mon, 18 Aug 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoxCO4uF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3138334737;
	Mon, 18 Aug 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533336; cv=none; b=qwX5yVOtB9wJuVvpZ5TXTvXAzH3TXFO6ZQT14l7Eup6dXqGiW+FESB3BtfdUttrxIJjrVqkzqUtC6KCoewY9fLHw/RGhGitLIvJFt+zzO4WXtGidDbqygBHbC1gq+nxTLa8BrQ88fqH7aocKQlAnkjDtaipZeiJZtZoRhA+leqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533336; c=relaxed/simple;
	bh=praVVRYQknEmW2PnOYAUW4g/6bcrHTZgh8UjIqOn6e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOXukLcRky0lJlcWCw4dYtef+CLXgf8iZGiv8IhKD/AUiTWGboFvDu9fu9PuMahTLj3SsIWjmza0g3YZIHDBbQoFRKjh1lIkCUdJe2U+TtsYqZhDe7F6zwYdAcTE2dEGJEvqrsk55AhWMnQON/FgLPnkaUJyvKfHqIEmn+9Gr2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoxCO4uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F23C19421;
	Mon, 18 Aug 2025 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755533336;
	bh=praVVRYQknEmW2PnOYAUW4g/6bcrHTZgh8UjIqOn6e4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JoxCO4uFGu7BGkAzNrwPeiok1VrtnD0fOKf66zu3gaNU8PiIlLYI1yWqXvCzPC4IT
	 w/dJ8CJXWBqiU4AsLouwY6U0QasKGD2sNVPrR5WeQkIGyDNx5WZdBcWpQJ6ZbJHUYh
	 2SdP610Lw2LyAigmoxvlOuEor4JFC+kygH96uDrjpfxuY1oIbas+l6Pi8fqAC3FwSm
	 4/ODHGp3YsTF6AxM7iB6bWCSzpMA/4VSfwENCnfuE5bIvoGKm7/F14l1n+RG6ItpYs
	 EFoImdonprr9kZTqtB04dJUDwIKR6TnWVmT3/YvKyprqjNPKIcPNu6qzyz93nYW3Pe
	 mcYzWLhlL1g9Q==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30cce86052cso2613336fac.1;
        Mon, 18 Aug 2025 09:08:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6EW+fVaeQ+GZ6AT7XDC5vvyECVI/a7N+Zv+hSMIroYKr9E3PH0lB6zEyYiyHZqjmjyzZSUtgBkgCJsVIf@vger.kernel.org, AJvYcCUmg2qAtg4YgGttN4TeHMjXS56xTieVYlgLsXXUIZoWIW3VEVvtGUGivTsEIuLbtLTcKSQSjs5YkILh@vger.kernel.org
X-Gm-Message-State: AOJu0YxmUE78ozcUpZzIEXIu0wW0aqbFgPI5Y4f9s8CMdalYT3WgEfK+
	JkQ2d1nUs6cEQOJXSBaxxVnwvz5zNVUm17m1pLW41oPKO3zNcSIjT5lzUgnHQeDtBh7sr5qCmuZ
	/5KGO51c2AsSLeGXCPKPs9aWG1BlBILo=
X-Google-Smtp-Source: AGHT+IFkq5KncVYHEk/LN9k0et6idyAoVR2GJ7EVldfLfvV7MKWlr0LQMntLQzrYg4NzYalRknRoMllv2VqRTyG+JhQ=
X-Received: by 2002:a05:6870:3d9a:b0:2d5:b7b7:2d6e with SMTP id
 586e51a60fabf-310aafe4464mr7621787fac.38.1755533335571; Mon, 18 Aug 2025
 09:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814161706.4489-1-tony.luck@intel.com> <230e2659-7838-2165-4490-3b3f89cb7838@huawei.com>
In-Reply-To: <230e2659-7838-2165-4490-3b3f89cb7838@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Aug 2025 18:08:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g8+XsUsYa0vNeCMcjx1wmMf99PfbYfofSqtaOqDajaow@mail.gmail.com>
X-Gm-Features: Ac12FXxUylNn3wz4tNeEKNr6XV_DMtzkj2Zt0mREl5vK_65erZjinrFq4jvlxXU
Message-ID: <CAJZ5v0g8+XsUsYa0vNeCMcjx1wmMf99PfbYfofSqtaOqDajaow@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: Check if user asked for EINJV2 injection
To: Hanjun Guo <guohanjun@huawei.com>, Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Len Brown <lenb@kernel.org>, Zaid Alali <zaidal@os.amperecomputing.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, "Lai, Yi1" <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 5:58=E2=80=AFPM Hanjun Guo <guohanjun@huawei.com> w=
rote:
>
> On 2025/8/15 0:17, Tony Luck wrote:
> > On an EINJV2 capable system, users may still use the old injection
> > interface but einj_get_parameter_address() takes the EINJV2 path to map
> > the parameter structure. This results in the address the user supplied
> > being stored to the wrong location and the BIOS injecting based on an
> > uninitialized field (0x0 in the reported case).
> >
> > Check the version of the request when mapping the EINJ parameter
> > structure in BIOS reserved memory.
> >
> > Fixes: 691a0f0a557b ("ACPI: APEI: EINJ: Discover EINJv2 parameters")
> > Reported-by: Lai, Yi1 <yi1.lai@intel.com>
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >   drivers/acpi/apei/einj-core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-cor=
e.c
> > index bf8dc92a373a..99f1b841fba9 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> > @@ -315,7 +315,7 @@ static void __iomem *einj_get_parameter_address(voi=
d)
> >                       memcpy_fromio(&v5param, p, v5param_size);
> >                       acpi5 =3D 1;
> >                       check_vendor_extension(pa_v5, &v5param);
> > -                     if (available_error_type & ACPI65_EINJV2_SUPP) {
> > +                     if (is_v2 && available_error_type & ACPI65_EINJV2=
_SUPP) {
> >                               len =3D v5param.einjv2_struct.length;
> >                               offset =3D offsetof(struct einjv2_extensi=
on_struct, component_arr);
> >                               max_nr_components =3D (len - offset) /
>
> Reviewed-by: Hanjun Guo <gouhanjun@huawei.com>

Applied as 6.17-rc material, thanks!

