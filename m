Return-Path: <linux-acpi+bounces-18224-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95162C0A73F
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 13:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F21D3AD739
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 12:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FF72D97BA;
	Sun, 26 Oct 2025 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6jL8ot1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B622D97A1
	for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2025 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482086; cv=none; b=N9Dkuy2uLxzGhVuW74p59xKWJOPgeXzHdvMZEIzuz8eCeTCt+VFONYc17QVWBHk1fpdTCWo8hnbKSq9EDuPBBb+k7dIsy+do4k9vU9Z0i+dXZhPra4dnLgcZ6z5TPS606H+SOmGYy9Lu0OqrJGRk4+FnTs6+bpwo3rp/XyiIZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482086; c=relaxed/simple;
	bh=yWdBEvQ3ngs8EBxdz+2XpeKUEBjGRWsSJkE7qF5U5cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okn9v6hbPU3dPICkqhUka2xSm1fqLZKheypXPIMi3ndHUniLrNDbIPgIsxWodx330h3wsZ9f59rDfqFyfHgQpn9KjTErPF0P2QnimCW2lu0pZX61lxcMTVqPZZzPnlu5Lga7bFEYgtnPRALM4qqyownvnFo6jc1XNG5tSm3M1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6jL8ot1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2E1C19421
	for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2025 12:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761482085;
	bh=yWdBEvQ3ngs8EBxdz+2XpeKUEBjGRWsSJkE7qF5U5cY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c6jL8ot1OBY0PKo4IqtTB9qXRTx9+a5+1MxwE9eMYOFeGwlleoi9DsdxIP1N0l0On
	 zyg0VcszSuTXqibWw02812fcDNzbO/IwM6uCSIyQnbO89+BrX/urZ2Zjj3eDuEmQFf
	 hQmTPNbjFRy8TV1+NUD9mId5ANn8cWBirzC2UyxMSL6LhyDxJoGRHDNOBk/0++gI6v
	 cucn+utkpDXRWhDQ7/BRlioFW1fLNZr/sMtDPc2TD43P/nTzVhb6TmX801kTjRvq65
	 Zehrv8au7rLc4b7sJgMO0ScgJFjTArOZWdZoya1MdEfeHYGYtxMztFu1tn0bL8T8yR
	 b67lp3ntdQQiw==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c2846c961fso1963907a34.2
        for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2025 05:34:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUDciAf8rS/FDR8mwEih5cp+1CbH3d116DU85Y+LgMtPx+nx3R3BmlGTlSbYJez4Y5qPZHjESNFci2@vger.kernel.org
X-Gm-Message-State: AOJu0YykiPfBEa7gGAJXIxG1IL+6O5q1eGcvWfSlEAxoTHwt0XnxbxOa
	K6bzFqaHGkKshk6FSWjQDsAuqQa3dQbow2Dv8rJwc0jIFwJ33qSw0CC2X4KooBFg2RSa73IB7se
	QBfhaXcU7HtpuLjvwLfYt2TL72zIMQfw=
X-Google-Smtp-Source: AGHT+IHDrl/qGfsuH6pDSyu2LHOznPsTx+vcm2kq+BMs6YVixR4JBY2HJDdM7C9BM1NURhNAlrLD4OLKRfUHPtu8WB4=
X-Received: by 2002:a05:6808:d4b:b0:43b:6639:7307 with SMTP id
 5614622812f47-44bd41c9cd4mr5040300b6e.23.1761482084824; Sun, 26 Oct 2025
 05:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-7-lihuisong@huawei.com> <CAJZ5v0jBqPLjK2v7A-8Qd6ERhwz47jP3YCiTHJhD8vAgRHVjcQ@mail.gmail.com>
 <e1d440bd-23c0-434c-a771-5c0907c5d3ab@huawei.com>
In-Reply-To: <e1d440bd-23c0-434c-a771-5c0907c5d3ab@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 26 Oct 2025 13:34:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h64UoWY=Zkpc4g2UH+ii8K6APDSV2qLp==yHuRQz+fsQ@mail.gmail.com>
X-Gm-Features: AWmQ_bl783FLk3NpoNYF2yfbzEexKm25cNaoRYtOQbU6yqkkeIJw8iYUi1tvZeM
Message-ID: <CAJZ5v0h64UoWY=Zkpc4g2UH+ii8K6APDSV2qLp==yHuRQz+fsQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] ACPI: processor: idle: Do not change power states
 if get power info failed
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:10=E2=80=AFAM lihuisong (C) <lihuisong@huawei.co=
m> wrote:
>
>
> =E5=9C=A8 2025/10/22 3:49, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@huawei.c=
om> wrote:
> >> Driver will update power states when processor power states have been
> >> changed. To prevent any other abnormal issues, here add the verificati=
on
> >> for the result of getting power information, don't change power states
> >> and one error log when get power information failed.
> > But the old states may not be usable any more in that case.
> Yes
> >
> > If you want to check the acpi_processor_get_power_info(), it should
> > disable ACPi idle entirely on failures.
>  From the modification of this patch, this cpuidle device will be
> disabled if the acpi_processor_get_power_info(=EF=BC=89fails to get on th=
is device.
> And the cpuidle of the device will be disabled according to the
> definition of cpuidle_not_available().
> We should not call disable_cpuidle() to disable cpuidle of all CPUs.

Since the same idle state data is used for all CPUs, I'd say cpuidle
should be disabled for all of them in that case.

Alternatively, check if it works for any of them and apply the data
from the CPU where it works to all of them.  If it doesn't work for
any of them, there's nothing to apply.

> So the modification in this patch is enough, right?
> >
> >> Fixes: f427e5f1cf75 ("ACPI / processor: Get power info before updating=
 the C-states")
> >> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> >> ---
> >>   drivers/acpi/processor_idle.c | 15 ++++++++++-----
> >>   1 file changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_id=
le.c
> >> index b0d6b51ee363..92b231f5d514 100644
> >> --- a/drivers/acpi/processor_idle.c
> >> +++ b/drivers/acpi/processor_idle.c
> >> @@ -1315,6 +1315,7 @@ int acpi_processor_power_state_has_changed(struc=
t acpi_processor *pr)
> >>          int cpu;
> >>          struct acpi_processor *_pr;
> >>          struct cpuidle_device *dev;
> >> +       int ret =3D 0;
> >>
> >>          if (disabled_by_idle_boot_param())
> >>                  return 0;
> >> @@ -1344,16 +1345,20 @@ int acpi_processor_power_state_has_changed(str=
uct acpi_processor *pr)
> >>                  }
> >>
> >>                  /* Populate Updated C-state information */
> >> -               acpi_processor_get_power_info(pr);
> >> -               acpi_processor_setup_cpuidle_states(pr);
> >> +               ret =3D acpi_processor_get_power_info(pr);
> >> +               if (ret)
> >> +                       pr_err("Get processor-%u power information fai=
led.\n",
> >> +                              pr->id);
> >> +               else
> >> +                       acpi_processor_setup_cpuidle_states(pr);
> >>
> >>                  /* Enable all cpuidle devices */
> >>                  for_each_online_cpu(cpu) {
> >>                          _pr =3D per_cpu(processors, cpu);
> >>                          if (!_pr || !_pr->flags.power_setup_done)
> >>                                  continue;
> >> -                       acpi_processor_get_power_info(_pr);
> >> -                       if (_pr->flags.power) {
> >> +                       ret =3D acpi_processor_get_power_info(_pr);
> >> +                       if (!ret && _pr->flags.power) {
> >>                                  dev =3D per_cpu(acpi_cpuidle_device, =
cpu);
> >>                                  acpi_processor_setup_cpuidle_dev(_pr,=
 dev);
> >>                                  cpuidle_enable_device(dev);
> >> @@ -1363,7 +1368,7 @@ int acpi_processor_power_state_has_changed(struc=
t acpi_processor *pr)
> >>                  cpus_read_unlock();
> >>          }
> >>
> >> -       return 0;
> >> +       return ret;
> >>   }
> >>
> >>   void acpi_processor_register_idle_driver(void)
> >> --
> >> 2.33.0
> >>

