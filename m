Return-Path: <linux-acpi+bounces-15270-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECB9B0D7EA
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 13:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BCF18989A0
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 11:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6403A2DECA5;
	Tue, 22 Jul 2025 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUl+WizS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F52989B4;
	Tue, 22 Jul 2025 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182665; cv=none; b=CHUxfLN9DHc6eJ+QOS/yLEwoV1HH35zNSPdlUHlOxCKTHMdzCDub18JJLk8UE0PQJoR5cnRUxeP1C+xTS5Np2eszO9lKOdLvcxcmk7vcLhWG82Wr9Vv5dfjZpGLSLZ3Xd5TIYLY67jpo6Y2rVCmZ1UoujNf8uwvh9VP/vmHJYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182665; c=relaxed/simple;
	bh=gvtrKAfjWMC9h6Jzp7M0UO2Golla0KnYyG3amvGoSqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPSfQSKSxpodNkfPDCqGpPenWBa+dLHOtrIWVMePh54IBKzIhhmAeTVNtgJjpxuNiqE8pyAG1Ba1VYOCrxq/KK22OBvm0tWs9/jZpWsLi4nZA8NeXVhKDMqH8S6CVX6CTQ1GxbYl67gtsxj/NNHNpLCxMu7TVGl8xsBkqCIRG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUl+WizS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83C4C4CEEB;
	Tue, 22 Jul 2025 11:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753182664;
	bh=gvtrKAfjWMC9h6Jzp7M0UO2Golla0KnYyG3amvGoSqA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gUl+WizSkLsK04OclAYFJpDZoXctQJJVP087CqvSIq34a5zr4R+dY5v/lzKKD4Quw
	 OSnDecK+n5+IMRMULipnROnSy/7pcljsS0+WoCRzrQFiTgpES5/V5CCrHuuISlUSf6
	 oxXw7KVdB6LzRqu6UxATK12bj5bl5tVRS/czpnzAJ73QRL9UeuJ3uo1+FaCHZutX4X
	 CY6MT1fC3eOVxL8BjEoO0H8YHNwNG1QOM2c62j8SpRXRcxUsQlN9ZkRpn9s4/zM9ag
	 KmTAdY0lPmZUNtaLavsWK/P4WvHr7v/s14cflDjS+FtIJzO98w0pmmqRf3eFPAO/Hi
	 CtLRj3UOJP2Zg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-60d666804ebso3151058eaf.1;
        Tue, 22 Jul 2025 04:11:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWjxdto5AixjROL1xW0LdbTTQFnQUElKzRuJiRqsgs7M0b6LF336lvtup++XfVFKQZe0C2oaqN8BqO9Ym8@vger.kernel.org, AJvYcCXE7TIuM8POkquqDIKRkXIQxCG7fNH7+qBXFsFGbNLzkAWDa47G1Qgjlyp9VBGnsG3HUMcDSX0Lpbbw@vger.kernel.org
X-Gm-Message-State: AOJu0YzLbn5bO6R909/tWSM3K73MFxu7PbyAH/qZwhhJK/Fm/1/an8k5
	hRHngUkoUiOkw2XkANh/qjyk1IufnJ6PaJ55s6oam9tKjpHz3D2USLUG9aQJwxDWMXeNn5Pd3Uc
	yszfH+huw9QBU7b0bElPSviGuYtcXcAw=
X-Google-Smtp-Source: AGHT+IEUaAqeddjavenbxmf8JHUpHj1czJXPInIlIk0sSkvKdQsPjT6IAAHFVaMDOmI3Hy6P2FOgT/rdvITuiu4aIUw=
X-Received: by 2002:a05:6808:188e:b0:407:39f1:ac80 with SMTP id
 5614622812f47-424a5c17052mr2396203b6e.5.1753182664011; Tue, 22 Jul 2025
 04:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619061327.1674384-1-lihuisong@huawei.com>
 <CAJZ5v0gjkZ3a-BwgJxjUJbNwu5E_j9VUUHrR3M=a+KPTA-tZcA@mail.gmail.com>
 <6a35291a-32e8-461e-a0e5-405b7b5d24ce@huawei.com> <CAJZ5v0hXHgyCKoEOMTtp0c_yu__vGGDcPnqaUML2Xg7hyJWc3g@mail.gmail.com>
 <4c1926ef-f9fa-49d5-8d5f-ed4ee2638d62@huawei.com>
In-Reply-To: <4c1926ef-f9fa-49d5-8d5f-ed4ee2638d62@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Jul 2025 13:10:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j8k3FXx0TCF8nF+KTGcZL8CG7yZ6_Z11jpqOM9x_0w6g@mail.gmail.com>
X-Gm-Features: Ac12FXy-gqefBxgu4Y37L6F2_GNinpb07bXrbpS2H07UyTOtiCiXWxL-lypkZGA
Message-ID: <CAJZ5v0j8k3FXx0TCF8nF+KTGcZL8CG7yZ6_Z11jpqOM9x_0w6g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: idle: Fix resource rollback in acpi_processor_power_init
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, liuyonglong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 3:34=E2=80=AFAM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> =E5=9C=A8 2025/7/3 19:09, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Thu, Jul 3, 2025 at 8:23=E2=80=AFAM lihuisong (C) <lihuisong@huawei.=
com> wrote:
> >> Hi,
> >>
> >> Thanks for your review.
> >>
> >>
> >> =E5=9C=A8 2025/7/3 1:42, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >>> On Thu, Jun 19, 2025 at 8:13=E2=80=AFAM Huisong Li <lihuisong@huawei.=
com> wrote:
> >>>> There are two resource rollback issues in acpi_processor_power_init:
> >>>> 1> Do not unregister acpi_idle_driver when do kzalloc failed.
> >>>> 2> Do not free cpuidle device memory when register cpuidle device fa=
iled.
> >>>>
> >>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> >>>> ---
> >>>>    drivers/acpi/processor_idle.c | 24 +++++++++++++++++-------
> >>>>    1 file changed, 17 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_=
idle.c
> >>>> index 2c2dc559e0f8..3548ab9dac9e 100644
> >>>> --- a/drivers/acpi/processor_idle.c
> >>>> +++ b/drivers/acpi/processor_idle.c
> >>>> @@ -1392,8 +1392,10 @@ int acpi_processor_power_init(struct acpi_pro=
cessor *pr)
> >>>>                   }
> >>>>
> >>>>                   dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> >>>> -               if (!dev)
> >>>> -                       return -ENOMEM;
> >>>> +               if (!dev) {
> >>>> +                       retval =3D -ENOMEM;
> >>>> +                       goto unregister_driver;
> >>> No, unregistering the driver here is pointless.
> >> I don't quite understand why here is pointless. Can you explain it?
> > When this function is run for another CPU, it will attempt to register
> > the driver again if it is unregistered here.
> Yeah, got it.
> So registering cpuidle also has a potential race issue here.
> >
> > Quite frankly, the driver should be registered before running this
> > function because it is a CPU hotplug callback and registering a
> > cpuidle driver from within it is quite questionable.
> >
> > Alternatively, it can be registered when all of the CPUs have been brou=
ght up.
> Agree with you.
> The reason why is that the initialization of acpi_idle_driver depands on
> the power management information of CPU.
> But the power management information of CPU is obtained in this callback.
> I have an idea.
> Because acpi_idle_driver is applied to all possiable CPUs. And use the
> power information of the first onlined CPU to initialize and register
> acpi_idle_driver, currently.
> So I think we can use this logic and dependency to extract a function to
> initialize and register acpi_idle_driver. And put this function to
> acpi_processor_driver_init().
> I tested it is ok.
> What do you think about this?

This is one of the options I mentioned above, isn't it?

