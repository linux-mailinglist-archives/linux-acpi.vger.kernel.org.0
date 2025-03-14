Return-Path: <linux-acpi+bounces-12237-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C48AA60F00
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 11:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2392A7ACB59
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 10:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2638A1F543F;
	Fri, 14 Mar 2025 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3+19/Bi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0781F4CAD;
	Fri, 14 Mar 2025 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948339; cv=none; b=WqtQ7Mz8HW1HYzb6f1axtuyS9loi7nOkONksiLYjFX287sF11HQRPtMD1RchqdkOGwBeCd33HXVi8X/Sgf2ZatDu8knQaaWzfcE8t/EG8YX3wN6qRf/31Ofgd8WZUdaozSBMSry9VZA48X8HY1c/nghS9/z3SMK5Wt8xj/ey0HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948339; c=relaxed/simple;
	bh=bIVEOosLbXV7zBjslXZjI9/mMTUHcG4P15ca5rWDDm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuAPJGY/3JQczJhCo1YhSN8ZirczNnAklNh0FfM2D1LpBfxwvxPjq/SXle8ryotrQ1sAWxiAVEX9VbGrkxTdKWlHAI092aPBDFP7gUS161d/0qCJjz5ZrNhwxK0tWvoRaPaai27+VoD3CNtu89ktxBMhbEcU+WjfMW2pfcfEkUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3+19/Bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735C0C4CEF4;
	Fri, 14 Mar 2025 10:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741948338;
	bh=bIVEOosLbXV7zBjslXZjI9/mMTUHcG4P15ca5rWDDm0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j3+19/BiN6v+pKli7W3LfZ4dOW/TqRiIxjSoUqF9o+jkG4SSng7zRIqEKXKKBsH4C
	 xkZ11M7AcGfz/2r4brm4/Xx4UhzihYkcsZDkpM8yn02ikkw3QTpvp5VKBsj26525oi
	 5K0yrlqBThCiaSvkU1bzENme1lXVpV644FHoeWZ/u0yhkz8Mqm7ShqeWu4VjQ3VZrs
	 M6jxYoyZTzIQY3Yy9ACoJLNz/1MPJo91jmWcq5GH1xosg1hhFuBUG+TFhibP2gQMCQ
	 W8wpYHTeCVg1ZMErre5+7Ri//vKGuvhIjYvFEt2kjnee7bwYxbOsWAa1scEc2gWCLp
	 fejBWC9+Re/zg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2c1c4e364c8so864348fac.1;
        Fri, 14 Mar 2025 03:32:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZjn0UIaNMmKJudSk9qSWkK9TtYp8OChmevBXg76ysmXXaCZoVCLCvs1ctju9rktUSyVt4aFx5FHXc@vger.kernel.org, AJvYcCW0fdv/uP3FOs16J2Q+d7UdVeVfU74fnmTr7ga92nagBkyCAfP0bj1PqRxbjwLPEqbzGw8LjBSQDfn02k/r@vger.kernel.org, AJvYcCW3KoxyXYr0O/DLLfuwOtVjdAybD53xpYZ350fhtYDmpJcNnLHggIfDGbANv0jPjYc/nWSBYmWVG5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCyeC7OM2QYfn1QHBkyLCJ5jrgsSRoFy72vCNGehDhZFJ7vb8p
	9mY2bi1S5+WJ/fe8DQ/b+hodbG6tOFXHYkhAWFE7puj6PS4OUzIsGqiW46iR3T0zqvCvePXzJJ8
	549LATPFzF/bGaoSoT+GgenyYQOY=
X-Google-Smtp-Source: AGHT+IHMIhcxmJiI89lHkmcp10N9Gc8dwaHNOvydy7F0N4rYcB6pfEg4Jewk4sgyfM2HYz8d8QVhijGhPoQRMSCLG6M=
X-Received: by 2002:a05:6871:8907:b0:2c3:13f7:2b3d with SMTP id
 586e51a60fabf-2c66faa0ad9mr3253949fac.13.1741948337647; Fri, 14 Mar 2025
 03:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206131428.3261578-1-zhenglifeng1@huawei.com>
 <20250206131428.3261578-4-zhenglifeng1@huawei.com> <CAJZ5v0iNzNROkPD4+b=Au8DwdF9unajKivdRQMBFfwzjFxHLcg@mail.gmail.com>
 <4fc77a58-8c77-463c-a50d-06ad19685bfb@huawei.com>
In-Reply-To: <4fc77a58-8c77-463c-a50d-06ad19685bfb@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Mar 2025 11:32:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gmGx-9QsTTdbKi6EMQm2tePfhBdYMry_88gbybLUY6WA@mail.gmail.com>
X-Gm-Features: AQ5f1JoupU6GpOA9Iyps8s1JuMZY-IPPw-xEHtHAfwnoaE6pdAQsbzMgFba8YeA
Message-ID: <CAJZ5v0gmGx-9QsTTdbKi6EMQm2tePfhBdYMry_88gbybLUY6WA@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, robert.moore@intel.com, 
	viresh.kumar@linaro.org, mario.limonciello@amd.com, gautham.shenoy@amd.com, 
	ray.huang@amd.com, pierre.gondois@arm.com, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxarm@huawei.com, yumpusamongus@gmail.com, 
	srinivas.pandruvada@linux.intel.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com, 
	fanghao11@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:25=E2=80=AFAM zhenglifeng (A)
<zhenglifeng1@huawei.com> wrote:
>
> On 2025/3/13 3:54, Rafael J. Wysocki wrote:
>
> > On Thu, Feb 6, 2025 at 2:14=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawe=
i.com> wrote:
> >>
> >> Rename cppc_get_perf() to cppc_get_reg_val() as a generic function to =
read
> >> cppc registers. And extract the operations if register is in pcc out a=
s
> >> cppc_get_reg_val_in_pcc(). Without functional change.
> >
> > This should be split into two patches IMV.
>
> Yes. That makes sense. Thanks.
>
> >
> >> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> >> ---
> >>  drivers/acpi/cppc_acpi.c | 66 +++++++++++++++++++++------------------=
-
> >>  1 file changed, 35 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> >> index db22f8f107db..3c9c4ce2a0b0 100644
> >> --- a/drivers/acpi/cppc_acpi.c
> >> +++ b/drivers/acpi/cppc_acpi.c
> >> @@ -1189,48 +1189,52 @@ static int cpc_write(int cpu, struct cpc_regis=
ter_resource *reg_res, u64 val)
> >>         return ret_val;
> >>  }
> >>
> >> -static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *per=
f)
> >> +static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resou=
rce *reg, u64 *val)
> >>  {
> >> -       struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpunum);
> >> -       struct cpc_register_resource *reg;
> >> +       int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
> >> +       struct cppc_pcc_data *pcc_ss_data =3D NULL;
> >> +       int ret;
> >>
> >> -       if (!cpc_desc) {
> >> -               pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> >> +       if (pcc_ss_id < 0) {
> >> +               pr_debug("Invalid pcc_ss_id\n");
> >>                 return -ENODEV;
> >>         }
> >>
> >> -       reg =3D &cpc_desc->cpc_regs[reg_idx];
> >> +       pcc_ss_data =3D pcc_data[pcc_ss_id];
> >>
> >> -       if (IS_OPTIONAL_CPC_REG(reg_idx) && !CPC_SUPPORTED(reg)) {
> >> -               pr_debug("CPC register (reg_idx=3D%d) is not supported=
\n", reg_idx);
> >> -               return -EOPNOTSUPP;
> >> -       }
> >
> > I'm not a big fan of the IS_OPTIONAL_CPC_REG() macro.  I'm not
> > convinced at all that it adds any value above (and in the next patch
> > for that matter) and the message printing the register index is just
> > plain unuseful to anyone who doesn't know how to decode it.
>
> With this index, it is easier to locate problems. This is what a "pr_debu=
g"
> for, isn't it?

For those who know how to decode it, yes.  For others, not really.

> >
> > If CPC_SUPPORTED(reg) is not true, the register cannot be used AFAICS
> > regardless of what IS_OPTIONAL_CPC_REG() has to say about it.
>
> The name "CPC_SUPPORTED" may be a little confused. Actually, in ACPI 6.5,
> only optional _CPC package fields that are not supported by the platform
> should be encoded as 0 intergers or NULL registers. A mandatory field as =
a
> 0 interger is valid. So If I wanted to make this function as a generic on=
e
> to read cppc registers, it would have been more reasonable to do this
> IS_OPTIONAL_CPC_REG() check before CPC_SUPPORTED().

I see, so you need to explain this in the changelog.

And IMV the code logic should be:

(1) If this is a NULL register, don't use it.
(2) If it is integer 0, check if it is optional.
    (a) If it is optional, don't use it.
    (b) Otherwise, use 0 as the value.

Of course, there is a problem for platforms that may want to pass 0 as
an optional field value, but this is a spec issue.

