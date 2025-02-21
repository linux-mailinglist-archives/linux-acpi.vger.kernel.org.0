Return-Path: <linux-acpi+bounces-11375-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E21A3FCCE
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 18:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BD316B760
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 17:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A738E2475E9;
	Fri, 21 Feb 2025 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp3Zb5En"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826612475C8
	for <linux-acpi@vger.kernel.org>; Fri, 21 Feb 2025 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157468; cv=none; b=AZD94HrQXOappQnRH6Ng6tfrckB41xJuMOHBcS0iIRQW8F+DF6+awRkNGbsE8FMucoMFi9JWcYJMXaJkleKkOGXmoKWxmtPx2bmPmyMj1KYCcfYt9rYkPWMc223gJDEVsdyU0jrM3F5AnAj8Pm7T8VGoisL9TRXqzovD2jJY8XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157468; c=relaxed/simple;
	bh=qYpcNyI5chCnRxP1Cg+OvZoMLnMnbLzm+nkqekbvTfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdUmHV4LIWX23pw6Shnr/FKnEr2taGUM/svagIeqy+VS9U0Dr2XxdZiDqyne1N7d/gxdAAuf18akOlAdfHvMYBZWHxS5kBpJmaKa2JYyDAANC/eaBS44MMcmauTfwJi8jQBrPIWzeJagM17+WSj0NOZzBbWOG4Dq4xCy1n0pEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp3Zb5En; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E0EC4CEE8
	for <linux-acpi@vger.kernel.org>; Fri, 21 Feb 2025 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740157468;
	bh=qYpcNyI5chCnRxP1Cg+OvZoMLnMnbLzm+nkqekbvTfA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gp3Zb5EnRE3b3uyWlyneZhIlsBJHpOv7F7Bwjmlp8QVp/9CfzB02IY3negd6r0lfv
	 ZQ7tsMWZgUwC6FoICTUsnW6nwDnGY3sKpjoOFxCmvRzSDKdvBrZy6+2pXD+9VQDJHJ
	 uARKa6j2CMFVjuDnX2AKLUQTKUv3XiPN00IamQTMYPPBexdR19STgzpV+dSJb9uiAs
	 ZKel9Ib4+oTQPDoKMN6uL2WcWS0Ga2Ga6Qf9NfIksdoe7pHEcbcAI499/fxshq8abb
	 aquU5ZOAysVboxCYYTjdPqjdRfc7IqppbB8ti+QIDQcQNLVfhbBPFGXxfvYv8fWZrm
	 2duiO4AyYTFmw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fcde65241cso1513017eaf.3
        for <linux-acpi@vger.kernel.org>; Fri, 21 Feb 2025 09:04:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVarUM6n7XyeBptllYc37t0A7FHgQsMAdhMxpH20C1S414FYrol+3iBF81fTh8glJWfm5tzmvshMC/4@vger.kernel.org
X-Gm-Message-State: AOJu0YxwbXzAMPh6m7kbftc0vkUHAmrYETRk9f3y49gS5xbkCPSwCvCt
	a9yd6nGMZldgxyWsceonNEucZ9UALEY4szVZCc+xuRTRe/REQ/XGKsFSh72SqvLXNO8k4bqxMfp
	qxKHqEu3KmjjVTs2/Vy3DK2QwJxw=
X-Google-Smtp-Source: AGHT+IFc67AwjXcDJNh1y9fF+z1GIWiaR/CcQQbqw7CtDsBFkrkBDN2CZ9NtU261rhB5JPwEyMdSnTx+xZNnBO1UH0I=
X-Received: by 2002:a05:6820:16a2:b0:5fc:ed3a:701b with SMTP id
 006d021491bc7-5fd1964564dmr2297899eaf.5.1740157467238; Fri, 21 Feb 2025
 09:04:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219145338.3306745-1-superm1@kernel.org> <20250219145338.3306745-2-superm1@kernel.org>
 <CAJZ5v0gWAfP=2fr-db=zSUu2iHUdbEdNHACFbqof5zFcaCX3eQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gWAfP=2fr-db=zSUu2iHUdbEdNHACFbqof5zFcaCX3eQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Feb 2025 18:04:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gU_dmfWxhNmjX43Ox2VwUDZQa3bLw8NbVZKt-krNevcw@mail.gmail.com>
X-Gm-Features: AWEUYZlUD2TrotxgSH9xcSSCHC6b9sAVAWr6h625USiT7YfRp3JG967cQCY8aqY
Message-ID: <CAJZ5v0gU_dmfWxhNmjX43Ox2VwUDZQa3bLw8NbVZKt-krNevcw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: Add missing prototype for non
 CONFIG_SUSPEND/CONFIG_X86 case
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, kernel test robot <lkp@intel.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 9:05=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Feb 19, 2025 at 3:54=E2=80=AFPM Mario Limonciello <superm1@kernel=
.org> wrote:
> >
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > acpi_register_lps0_dev() and acpi_unregister_lps0_dev() may be used
> > in drivers that don't require CONFIG_SUSPEND or compile on !X86.
> >
> > Add prototypes for those cases.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202502191627.fRgoBwcZ-lkp=
@intel.com/
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  include/linux/acpi.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 4e495b29c640f..8e16ca5046e45 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -1130,6 +1130,13 @@ static inline int acpi_get_lps0_constraint(struc=
t device *dev)
> >  {
> >         return ACPI_STATE_UNKNOWN;
> >  }
> > +static inline int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *a=
rg)
> > +{
> > +       return -ENODEV;
> > +}
> > +static inline void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops=
 *arg)
> > +{
> > +}
> >  #endif /* CONFIG_SUSPEND && CONFIG_X86 */
> >  void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
> >  #else
> > --
>
> Applied as 6.15 material, thanks!

And dropped due to build issues:

https://lore.kernel.org/linux-acpi/202502211223.IKdRg7rk-lkp@intel.com/

