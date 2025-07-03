Return-Path: <linux-acpi+bounces-14972-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A82AF71C8
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 13:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C04E175868
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 11:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9432E2F09;
	Thu,  3 Jul 2025 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p75tGWnz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336B2E267D;
	Thu,  3 Jul 2025 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751540976; cv=none; b=steB4zkb2SEzweEUN/aJPmgwPNEmAK5gp3d/fAUAKk7zJAwlB8mbx2XuKa2gnCHJjHoO+ln8IJzTq8mou9kqyLQJg9BK/j9Gvoqlu7omkoTfZ4SMhws37By6ARITDTyK/bn6VxlVP5zgEHTQjYtQ1meTLPDuk5YsNnrlqfvBXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751540976; c=relaxed/simple;
	bh=KrtZbiltchxKLUWpVAOiu6ePqO1CBaerKbLeeIdSV8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOsdpKwNQyNh9oaO2VbQOMFcN7I0+jkyMMkPssfrGt3Mibis9GbTVpl0/m724vUm1F55DCdKxBJnsq+GNRsdZvgslU8BX/rJbZ4oe/Ys8J5ltkHKhjqyB8dKGXIZeDq60E2wSTn9zozQQFMAFAkOzB5IiYLSLu2XMaOoHUGIu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p75tGWnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BDCC4CEF1;
	Thu,  3 Jul 2025 11:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751540974;
	bh=KrtZbiltchxKLUWpVAOiu6ePqO1CBaerKbLeeIdSV8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p75tGWnzXA4eKT8wapqG3goCNTc/+dA7Bx80IJ+c2DboJm8PzEqXLoT9jjVwj6kf4
	 IFQOowBgO8mcQFvznJGGIp3CrCbi78uZEeteHI2lfbBLcU+fiOFd1qnLiSR7+BFcW4
	 e9OixZMY3Iu2g/3aTV46B9lXwV559H2P/W2Aluz4Ev7M4kUBYcjwp0VT+aPFb77Apr
	 mRWc2e7JdPAmv7TJ7RuZkxwdTsSn3+md2Epoy65lRufd8UDXIfxnTsUfFxXQyUjZ4R
	 O78PNpQbmhyNawnbPcHz/HW44f6JiZCtt4lufkzF0CwYR4/9zeI+ttbkVGmlqZWULI
	 YB7+jumKMDNww==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6138aedd718so27377eaf.0;
        Thu, 03 Jul 2025 04:09:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFjJveI19ei0DY5gdapos68VSAlLXem5nlU1UeaQGJRDkG1qQdS1HMEyz7GFyIp7oc5+fSjSvI5fYNCSXi@vger.kernel.org, AJvYcCVML+GSe4xGNMDBiEXGL9rit8H+UuV/M/LukOdnhvglhtlAuQQna0FdtkIGbXkGHIxRde/0O+sECDSo@vger.kernel.org
X-Gm-Message-State: AOJu0YzYapLLSt7PJaYDqVPJCC0iQ4cZxP5RgeIGAEFuTFtYj4hIIarI
	IMNS2usUUOVF8ABPSNss2+O15Dtgi028sec3ih4ZDVUuvex/ono8iqiZbgKl5pbasbvr7U+CQ/0
	dxIXugyJuNGPvXdw9zvaSbactmsDyg9I=
X-Google-Smtp-Source: AGHT+IEtVyen2G7jyBhQ9vNHG7/BXIgvXddhrVK01n15rZ/RqJfaXFqkTHgdWsdSiEg2VMlUCyt93OpLUlqVBhtwZwE=
X-Received: by 2002:a05:6820:3081:b0:611:3e54:8d0a with SMTP id
 006d021491bc7-613835900fbmr1057409eaf.1.1751540973662; Thu, 03 Jul 2025
 04:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619061327.1674384-1-lihuisong@huawei.com>
 <CAJZ5v0gjkZ3a-BwgJxjUJbNwu5E_j9VUUHrR3M=a+KPTA-tZcA@mail.gmail.com> <6a35291a-32e8-461e-a0e5-405b7b5d24ce@huawei.com>
In-Reply-To: <6a35291a-32e8-461e-a0e5-405b7b5d24ce@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 13:09:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hXHgyCKoEOMTtp0c_yu__vGGDcPnqaUML2Xg7hyJWc3g@mail.gmail.com>
X-Gm-Features: Ac12FXwqd0ylAIhQYSBLc9NqzXjbpCrSKhCrNKNwXE5Hj02C57qxgKBzZGGGrkw
Message-ID: <CAJZ5v0hXHgyCKoEOMTtp0c_yu__vGGDcPnqaUML2Xg7hyJWc3g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: idle: Fix resource rollback in acpi_processor_power_init
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, liuyonglong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:23=E2=80=AFAM lihuisong (C) <lihuisong@huawei.com>=
 wrote:
>
> Hi,
>
> Thanks for your review.
>
>
> =E5=9C=A8 2025/7/3 1:42, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Thu, Jun 19, 2025 at 8:13=E2=80=AFAM Huisong Li <lihuisong@huawei.co=
m> wrote:
> >> There are two resource rollback issues in acpi_processor_power_init:
> >> 1> Do not unregister acpi_idle_driver when do kzalloc failed.
> >> 2> Do not free cpuidle device memory when register cpuidle device fail=
ed.
> >>
> >> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> >> ---
> >>   drivers/acpi/processor_idle.c | 24 +++++++++++++++++-------
> >>   1 file changed, 17 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_id=
le.c
> >> index 2c2dc559e0f8..3548ab9dac9e 100644
> >> --- a/drivers/acpi/processor_idle.c
> >> +++ b/drivers/acpi/processor_idle.c
> >> @@ -1392,8 +1392,10 @@ int acpi_processor_power_init(struct acpi_proce=
ssor *pr)
> >>                  }
> >>
> >>                  dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> >> -               if (!dev)
> >> -                       return -ENOMEM;
> >> +               if (!dev) {
> >> +                       retval =3D -ENOMEM;
> >> +                       goto unregister_driver;
> > No, unregistering the driver here is pointless.
> I don't quite understand why here is pointless. Can you explain it?

When this function is run for another CPU, it will attempt to register
the driver again if it is unregistered here.

Quite frankly, the driver should be registered before running this
function because it is a CPU hotplug callback and registering a
cpuidle driver from within it is quite questionable.

Alternatively, it can be registered when all of the CPUs have been brought =
up.

> >
> >> +               }
> >>                  per_cpu(acpi_cpuidle_device, pr->id) =3D dev;
> >>
> >>                  acpi_processor_setup_cpuidle_dev(pr, dev);
> >> @@ -1402,14 +1404,22 @@ int acpi_processor_power_init(struct acpi_proc=
essor *pr)
> >>                   * must already be registered before registering devi=
ce
> >>                   */
> >>                  retval =3D cpuidle_register_device(dev);
> >> -               if (retval) {
> >> -                       if (acpi_processor_registered =3D=3D 0)
> >> -                               cpuidle_unregister_driver(&acpi_idle_d=
river);
> > Pretty much the same as here.
> >
> > It would be good to clean up dev here though.
> It is ok if above is pointless.
> >
> >> -                       return retval;
> >> -               }
> >> +               if (retval)
> >> +                       goto free_cpuidle_device;
> >> +
> >>                  acpi_processor_registered++;
> >>          }
> >>          return 0;
> >> +
> >> +free_cpuidle_device:
> >> +       per_cpu(acpi_cpuidle_device, pr->id) =3D NULL;
> >> +       kfree(dev);
> >> +
> >> +unregister_driver:
> >> +       if (acpi_processor_registered =3D=3D 0)
> >> +               cpuidle_unregister_driver(&acpi_idle_driver);
> >> +
> >> +       return retval;
> >>   }
> >>
> >>   int acpi_processor_power_exit(struct acpi_processor *pr)
> >> --
> >> 2.33.0
> >>

