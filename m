Return-Path: <linux-acpi+bounces-18502-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06039C3203E
	for <lists+linux-acpi@lfdr.de>; Tue, 04 Nov 2025 17:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5291899296
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Nov 2025 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE9D330B24;
	Tue,  4 Nov 2025 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juq32+HN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B635732ED36
	for <linux-acpi@vger.kernel.org>; Tue,  4 Nov 2025 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273262; cv=none; b=BI5gT8AEz2xm/FATDe+Y/ANZ4u4/kQkrDp1YFFfkW7IGWeRg2xCyjXtY7zhWglyaSUaL+hdWikdHQ2n/pwH2Kl8B0cXMJ0FOgIUtCA/YvY4npAjxtEgffhV6OmVu7itkoRzj+KF2nB7ZF205VJ+IshQF7zRvLPeLxjVGQmxsEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273262; c=relaxed/simple;
	bh=X4NddkL82DArePBpPhdP2MGyDhQslwtEOSqofIwGZaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZR+Q648jcpvRGWqkcSli+EOv0FqhQwtuFF1Ri96K8iQR9j1nRxEgrXU/jtn7Trlr5Hl3sJk3EF5tm3HpO9oTh7HbtDUhY4SRZM4U+5guncfwriMm+mwQUWJoQf62CQ9ZMbic/dxRkSUBwv3so46uPDyUmQRR11sV62oVZvfU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juq32+HN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467BAC4AF09
	for <linux-acpi@vger.kernel.org>; Tue,  4 Nov 2025 16:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762273262;
	bh=X4NddkL82DArePBpPhdP2MGyDhQslwtEOSqofIwGZaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=juq32+HNcV60d+RCTyqTOEVbTUB1ipRfFvHMkkH18DPyrDPd0B5xnAO3vxn9bwxFt
	 N64IY/hk1L7m/Qudpa8oH3IBwaS55WbnJT+cEPWqLcTaedE3J976AsCHI9vVaTy04o
	 Z5bjKtyqwOjQGf9ll/pKLB7qLvmu+iE9RDQFinaf6u8XhX8wjLtaoKDBktdbpNBe7S
	 dq5EIx0OjXXRh6WzMGYHleOmU5Gct4vznfDkZ7XnUdn+xJB0jEKVmgu9dKGznCuL48
	 +DgwS2mgIoukbk5Ewm9K3zaVXhk2jUl9u83uTqxsXg/nLAySJ3H1TjxdYPDPvW81mf
	 yB7XFtLiFzRVA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3e1175ef97bso307958fac.2
        for <linux-acpi@vger.kernel.org>; Tue, 04 Nov 2025 08:21:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwzPf2Adcd4lgw2CdIs8Npb0Ugr2W9bg4Vx/HkNuAY7BcMDO8SfPauZ+toWemqasRaqe4nNR+vniX5@vger.kernel.org
X-Gm-Message-State: AOJu0YxaFSwNCR7pWvGXqlNOYWE7ci7zKm9ulL6Fs7A8x8M2tmTTT2Zn
	ruI7L1hClVn5fNrYayL0D4o3Ng441wtLvqQanLKpqJuygdWO1/p9sxB9BRQePaVsqeTVeH4YpSl
	ugwmZhLDNiYqo1X0uSywSK2r4EQdIO/o=
X-Google-Smtp-Source: AGHT+IGmIy5pyUKql+7Fatc8EfFtB4IWgHKnsgu0CU340UMoRiCZM9VH3T18qwnsG5vs5ibZHikWvUhyoWqvVQOYjcM=
X-Received: by 2002:a05:6871:80c7:b0:3d4:b76:5080 with SMTP id
 586e51a60fabf-3dacd6442c6mr8010358fac.28.1762273261566; Tue, 04 Nov 2025
 08:21:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103084244.2654432-1-lihuisong@huawei.com>
 <20251103084244.2654432-6-lihuisong@huawei.com> <CAJZ5v0ifcuqF7=+NowYOfPbKfGq5XCe4+mg_9Sv8gRHyMZ0gNQ@mail.gmail.com>
 <e4ccdd1d-2ade-4fac-8296-3b6eebce1bfa@huawei.com>
In-Reply-To: <e4ccdd1d-2ade-4fac-8296-3b6eebce1bfa@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Nov 2025 17:20:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jLACQCJN_=k4u-e5MdEnHqJPXABU-Fq5irMjjE3fF4-w@mail.gmail.com>
X-Gm-Features: AWmQ_bnF8wO-BeWuFQT9vcIKze9jPHRzll00ni-zXXtKvQ48ug5GZOtPQXqkq_Y
Message-ID: <CAJZ5v0jLACQCJN_=k4u-e5MdEnHqJPXABU-Fq5irMjjE3fF4-w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] ACPI: processor: idle: Remove useless codes about
 the verification of cstate count
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 11:03=E2=80=AFAM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> =E5=9C=A8 2025/11/4 2:10, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Mon, Nov 3, 2025 at 9:42=E2=80=AFAM Huisong Li <lihuisong@huawei.com=
> wrote:
> >> The acpi_processor_setup_cstates and acpi_processor_setup_cpuidle_cx w=
ill
> >> be called after successfully obtaining the power information. These se=
tup
> >> functions have their own main role, but also verify the validity of cs=
tate
> >> count.
> >>
> >> Actually, the acpi_processor_get_power_info_cst will return failure if=
 the
> >> cstate count is zero and acpi_processor_get_power_info will return fai=
lure.
> >>
> >> So the verification of cstate count in these functions are useless.
> >>
> >> No intentional functional impact.
> >>
> >> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> >> ---
> >>   drivers/acpi/processor_idle.c | 22 +++++++---------------
> >>   1 file changed, 7 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_id=
le.c
> >> index 4627b00257e6..1f332f02d273 100644
> >> --- a/drivers/acpi/processor_idle.c
> >> +++ b/drivers/acpi/processor_idle.c
> >> @@ -732,8 +732,8 @@ static int __cpuidle acpi_idle_enter_s2idle(struct=
 cpuidle_device *dev,
> >>          return 0;
> >>   }
> >>
> >> -static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
> >> -                                          struct cpuidle_device *dev)
> >> +static void acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr=
,
> >> +                                           struct cpuidle_device *dev=
)
> >>   {
> >>          int i, count =3D ACPI_IDLE_STATE_START;
> >>          struct acpi_processor_cx *cx;
> >> @@ -753,14 +753,9 @@ static int acpi_processor_setup_cpuidle_cx(struct=
 acpi_processor *pr,
> >>                  if (count =3D=3D CPUIDLE_STATE_MAX)
> >>                          break;
> >>          }
> >> -
> >> -       if (!count)
> >> -               return -EINVAL;
> >> -
> >> -       return 0;
> >>   }
> >>
> >> -static int acpi_processor_setup_cstates(struct acpi_processor *pr)
> >> +static void acpi_processor_setup_cstates(struct acpi_processor *pr)
> >>   {
> >>          int i, count;
> >>          struct acpi_processor_cx *cx;
> >> @@ -822,11 +817,6 @@ static int acpi_processor_setup_cstates(struct ac=
pi_processor *pr)
> >>          }
> >>
> >>          drv->state_count =3D count;
> >> -
> >> -       if (!count)
> >> -               return -EINVAL;
> >> -
> >> -       return 0;
> >>   }
> >>
> >>   static inline void acpi_processor_cstate_first_run_checks(void)
> >> @@ -1248,7 +1238,8 @@ static int acpi_processor_setup_cpuidle_states(s=
truct acpi_processor *pr)
> >>          if (pr->flags.has_lpi)
> >>                  return acpi_processor_setup_lpi_states(pr);
> >>
> >> -       return acpi_processor_setup_cstates(pr);
> >> +       acpi_processor_setup_cstates(pr);
> >> +       return 0;
> >>   }
> >>
> >>   /**
> >> @@ -1268,7 +1259,8 @@ static int acpi_processor_setup_cpuidle_dev(stru=
ct acpi_processor *pr,
> >>          if (pr->flags.has_lpi)
> >>                  return 0;
> >>
> >> -       return acpi_processor_setup_cpuidle_cx(pr, dev);
> >> +       acpi_processor_setup_cpuidle_cx(pr, dev);
> >> +       return 0;
> >>   }
> >>
> >>   static int acpi_processor_get_power_info(struct acpi_processor *pr)
> >> --
> > Does this patch depend on the previous patches in the series?  If it
> > doesn't, why don't you send it independently?
> Good suggestion. Thanks, got it.
> This patch doesn't depend on them.
> But patch 6/7 and 7/7 depend on this patch and patch 3/7.
> If they still need some times to discuss, I can send this patch first.

Yes, please send it separately as I said.  The rest of the series can
be rebased on it.

