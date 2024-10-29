Return-Path: <linux-acpi+bounces-9068-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 516F99B48F1
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 13:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9976B2350E
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 12:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0629120607D;
	Tue, 29 Oct 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTBvZRHV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D372F206078;
	Tue, 29 Oct 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203423; cv=none; b=U8dkdyPyBPxJ7VsnWMdnTMZkFV6DriSQo7fZodQtC9YQ3CezPENFByXwLC2eEreEsDnI9DnRq9QFCF8cVKZu0XEaEvOIQ5sZwP92TtYwnjMwvBS6INio4mXOQ6NM361xh4/jOHYbhnUo8+JGEJq6Ph+PwwExNw71cxSCENPnyJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203423; c=relaxed/simple;
	bh=4QJnoopncawiR3Bs++HFf+6Jy9YaevrMrh6+AldV06I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyPo/9Z0nAsPtvRsE+aEKj03A1ayyMckOAqQhA6VkoLKhZgzsSo2n3bSLfhpalc7yAz+OiY0ZsXAH0Z8gCVIwDX3f6FKm/llT8mzjhnp56GZ9uNiK2fxI3gfO7wYJ6J3poVNmk4x4gd4S3+EcO6z5QyKEp8g6DoDUhkLRHOyImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTBvZRHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB11C4CEE8;
	Tue, 29 Oct 2024 12:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730203423;
	bh=4QJnoopncawiR3Bs++HFf+6Jy9YaevrMrh6+AldV06I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mTBvZRHVIPnxd/GwItxRwE6jCEF7UzJ7hKi9JMw3umgXJ2t9oYXgfFqoiNMD6j+MU
	 076o1TlRGXZwfWXYDThptSSklw6L+H7xiaTNIGfEsXjgVqkOHRH42CdHxwAupoxQQX
	 wsoSapY1LJbLVA0UuctQRzDHqbQ9Hk224qwzquz9XndZFrrMoAAFC78XoainIS+foh
	 +TD/SzGnCROsRdQJLNRFK3ISlRpEsnNDVzaxpbb074C1T2/gCfpr08wtuLMrXnipgH
	 qsuJv9cnL0x3JsZlzgzhBrcIwu3Hc9xlmzJLdQuIfsEavsmUN75zpq0fdfGRyASLgA
	 XAQctH8lOWwcQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-29066daf9e2so1377423fac.3;
        Tue, 29 Oct 2024 05:03:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUp+w55irudMa+Bbw+3qTzc3hsgkl2javPN0ZY1OJT4hz2GNTvMeJY5jHCzmeJ4UWMCk7zTLO23mSR7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+6bHCzpLiOjh3x8qgPVe5muLDONFdddRsLn8f6ciNZv8p43sJ
	H6n2YyfgkGePURi+MipGZdf6ev1h2mqWYg0eXvhWVOpsfzuesbk00dSF5c1FFkUxfXUoQzo8P5P
	clJ6ta5PQiX6DsM32UysogqihKR8=
X-Google-Smtp-Source: AGHT+IFijydljJ+b+OkcOdBuE96XgR7L6OsNAUhKgYukL1UdIMGAiWPi+qa3j+0XWsYieCS9E0eSxZ9unEXBjJefoWI=
X-Received: by 2002:a05:6871:58c:b0:268:a79a:be0d with SMTP id
 586e51a60fabf-29051decfcfmr8753664fac.47.1730203422728; Tue, 29 Oct 2024
 05:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028125657.1271512-1-pierre.gondois@arm.com>
In-Reply-To: <20241028125657.1271512-1-pierre.gondois@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 29 Oct 2024 13:03:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jzDxAe6FmVOigd-EnAOkgOhbtdPp-ZrVGQqjpxAnabRQ@mail.gmail.com>
Message-ID: <CAJZ5v0jzDxAe6FmVOigd-EnAOkgOhbtdPp-ZrVGQqjpxAnabRQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: CPPC: Make rmw_lock a raw_spin_lock
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 1:57=E2=80=AFPM Pierre Gondois <pierre.gondois@arm.=
com> wrote:
>
> The following BUG was triggered. sugov_update_shared() locks a
> raw_spinlock while cpc_write() locks a spinlock. To have a correct
> wait-type order, update rmw_lock to a raw_spinlock.
>
> Also save irq state.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> [ BUG: Invalid wait context ]
> 6.12.0-rc2-XXX #406 Not tainted
> -----------------------------
> kworker/1:1/62 is trying to lock:
> ffffff8801593030 (&cpc_ptr->rmw_lock){+.+.}-{3:3}, at: cpc_write+0xcc/0x3=
70
> other info that might help us debug this:
> context-{5:5}
> 2 locks held by kworker/1:1/62:
>   #0: ffffff897ef5ec98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_ne=
sted+0x2c/0x50
>   #1: ffffff880154e238 (&sg_policy->update_lock){....}-{2:2}, at: sugov_u=
pdate_shared+0x3c/0x280
> stack backtrace:
> CPU: 1 UID: 0 PID: 62 Comm: kworker/1:1 Not tainted 6.12.0-rc2-g9654bd3e8=
806 #406
> Workqueue:  0x0 (events)
> Call trace:
>   dump_backtrace+0xa4/0x130
>   show_stack+0x20/0x38
>   dump_stack_lvl+0x90/0xd0
>   dump_stack+0x18/0x28
>   __lock_acquire+0x480/0x1ad8
>   lock_acquire+0x114/0x310
>   _raw_spin_lock+0x50/0x70
>   cpc_write+0xcc/0x370
>   cppc_set_perf+0xa0/0x3a8
>   cppc_cpufreq_fast_switch+0x40/0xc0
>   cpufreq_driver_fast_switch+0x4c/0x218
>   sugov_update_shared+0x234/0x280
>   update_load_avg+0x6ec/0x7b8
>   dequeue_entities+0x108/0x830
>   dequeue_task_fair+0x58/0x408
>   __schedule+0x4f0/0x1070
>   schedule+0x54/0x130
>   worker_thread+0xc0/0x2e8
>   kthread+0x130/0x148
>   ret_from_fork+0x10/0x20
>
> Fixes: 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage")
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>
> Notes:
>     v2:
>     - Do the actual changes.
>
>  drivers/acpi/cppc_acpi.c | 9 +++++----
>  include/acpi/cppc_acpi.h | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index c3fc2c05d868..1a40f0514eaa 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -867,7 +867,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *=
pr)
>
>         /* Store CPU Logical ID */
>         cpc_ptr->cpu_id =3D pr->id;
> -       spin_lock_init(&cpc_ptr->rmw_lock);
> +       raw_spin_lock_init(&cpc_ptr->rmw_lock);
>
>         /* Parse PSD data for this CPU */
>         ret =3D acpi_get_psd(cpc_ptr, handle);
> @@ -1087,6 +1087,7 @@ static int cpc_write(int cpu, struct cpc_register_r=
esource *reg_res, u64 val)
>         int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
>         struct cpc_reg *reg =3D &reg_res->cpc_entry.reg;
>         struct cpc_desc *cpc_desc;
> +       unsigned long flags;
>
>         size =3D GET_BIT_WIDTH(reg);
>
> @@ -1126,7 +1127,7 @@ static int cpc_write(int cpu, struct cpc_register_r=
esource *reg_res, u64 val)
>                         return -ENODEV;
>                 }
>
> -               spin_lock(&cpc_desc->rmw_lock);
> +               raw_spin_lock_irqsave(&cpc_desc->rmw_lock, flags);
>                 switch (size) {
>                 case 8:
>                         prev_val =3D readb_relaxed(vaddr);
> @@ -1141,7 +1142,7 @@ static int cpc_write(int cpu, struct cpc_register_r=
esource *reg_res, u64 val)
>                         prev_val =3D readq_relaxed(vaddr);
>                         break;
>                 default:
> -                       spin_unlock(&cpc_desc->rmw_lock);
> +                       raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, f=
lags);
>                         return -EFAULT;
>                 }
>                 val =3D MASK_VAL_WRITE(reg, prev_val, val);
> @@ -1174,7 +1175,7 @@ static int cpc_write(int cpu, struct cpc_register_r=
esource *reg_res, u64 val)
>         }
>
>         if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
> -               spin_unlock(&cpc_desc->rmw_lock);
> +               raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
>
>         return ret_val;
>  }
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 76e44e102780..62d368bcd9ec 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -65,7 +65,7 @@ struct cpc_desc {
>         int write_cmd_status;
>         int write_cmd_id;
>         /* Lock used for RMW operations in cpc_write() */
> -       spinlock_t rmw_lock;
> +       raw_spinlock_t rmw_lock;
>         struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
>         struct acpi_psd_package domain_info;
>         struct kobject kobj;
> --

Applied (with edited changelog) as 6.12-rc material, thanks!

