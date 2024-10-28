Return-Path: <linux-acpi+bounces-9044-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477CD9B3079
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 13:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF4F1F22563
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 12:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56281DA2E5;
	Mon, 28 Oct 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPcuanI4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDFB18FDBE;
	Mon, 28 Oct 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119092; cv=none; b=r+ai6c9aLgqvuL4VN/oLdoeZaGAMClq2LWycbt5CBQkr+eR0KfwHJHwJznVneeW9Jbt5PQHT3Db/z3/I8+ljvLsEjxR/K/1BUzhpkpEdX00BFrJ75/UF/QhuUTy1oeJGpV8s9MsL+BrDVphb+/aNZJ06Mv/iTwBfx5mRLUmeI8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119092; c=relaxed/simple;
	bh=V1JXJL1vWwx7XP9YK/J1MZBdP+aQk/vvq7BuTE22XGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7cFrjfZ3YDJXPu2PK8ut83wpz/X8UdnWfnUJPWTGjmt1+ovi8/Z5qJsWMiajuDLLkWKofinXoDYSpWbIJYisbP5st1FvZjC/S4cPAGpaecVqJLcOXqYhZ3rt+N/C7rbEVI+IHqPznrMuklJ8g4KRSQAMH6qemt45dE7Qw6FZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPcuanI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CB8C4CEE7;
	Mon, 28 Oct 2024 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730119092;
	bh=V1JXJL1vWwx7XP9YK/J1MZBdP+aQk/vvq7BuTE22XGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pPcuanI4L/9WHLvcEeESZlfco46yDS+cvw01ROOOs6ZBpPWbDhX7bdzaNH4kIZHWi
	 u/Tc+1Lq56F6vDPKvI84Ub7g2Iq6FU9LUmZNwydfWyyMk5XROv1P+ngdZ22truySCI
	 8M2kw96x8tdQfqGPyfDHCGAXb3nRv0K2D5TkZpzCwjDKWGte0QR9r1itWqW0EMxIRv
	 RGiWOeG6SHr9fE/b3LYUgUxwt6fn8bNlPM6mnM71QNBL8B5HdB7mArKp5RI4MubYpN
	 ku6exlDFjc3Fwpvdr+sE5TjHoHWOpBb2AWHyzv+Qv5ikzNwNXTOp30UINpKOmVsXRj
	 HLtI5d+Z52QWA==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7181eb9ad46so2597254a34.1;
        Mon, 28 Oct 2024 05:38:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPfLnk1zuN0lllKT+MjPA4MyAYD/fo+UdfBZ0+jWvfrYhx+ei+geCHonAPnuFBioVEIgtvYg4QEsEy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4r4Mg+mQz6NNuZtc/WzuIZaikUTv1Z5oPfvW8Z30tcRxO11xN
	btv1D0PVTu5BTi9wKoInaPF+QXsJfosjx3LWWMF1msYuV/WvC5TgnayxcxzYSmESDQLYH30aMQe
	rHLXBaxaDee7MWNq5O4L309b2OB8=
X-Google-Smtp-Source: AGHT+IHcPpA8PwSHFKyy4jVsSoWz0exQdbIJ/BCQr8AmaXDfJKdcACxok+MuRtE7oJfCfUQ19KdoW2248k6Yc5vVjzs=
X-Received: by 2002:a05:6870:3310:b0:25e:23b4:cf3e with SMTP id
 586e51a60fabf-29051e30582mr6787713fac.44.1730119091651; Mon, 28 Oct 2024
 05:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028105200.1205509-1-pierre.gondois@arm.com>
In-Reply-To: <20241028105200.1205509-1-pierre.gondois@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Oct 2024 13:37:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g=Q0aYEZUdy+F-bmptOvLVRxAs5gzGpbgrbCoFxMpcZQ@mail.gmail.com>
Message-ID: <CAJZ5v0g=Q0aYEZUdy+F-bmptOvLVRxAs5gzGpbgrbCoFxMpcZQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Make rmw_lock a raw_spin_lock
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jeremy Linton <jeremy.linton@arm.com>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Steffen Persvold <spersvold@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>, 
	Yury Norov <yury.norov@gmail.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 11:52=E2=80=AFAM Pierre Gondois <pierre.gondois@arm=
.com> wrote:
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
>  drivers/acpi/cppc_acpi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1a40f0514eaa..e7e4bf932e28 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1127,7 +1127,7 @@ static int cpc_write(int cpu, struct cpc_register_r=
esource *reg_res, u64 val)
>                         return -ENODEV;
>                 }
>
> -               raw_spin_lock_irqsave(&cpc_desc->rmw_lock, flags);
> +               raw_spin_lock(&cpc_desc->rmw_lock);

This won't apply because the current code is

spin_lock(&cpc_desc->rmw_lock);

and analogously below.  I think that it needs to be
raw_spin_lock_irqsave(), though.

Besides, a raw spin lock needs to be declared as such.

>                 switch (size) {
>                 case 8:
>                         prev_val =3D readb_relaxed(vaddr);
> @@ -1142,7 +1142,7 @@ static int cpc_write(int cpu, struct cpc_register_r=
esource *reg_res, u64 val)
>                         prev_val =3D readq_relaxed(vaddr);
>                         break;
>                 default:
> -                       raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, f=
lags);
> +                       raw_spin_unlock(&cpc_desc->rmw_lock);
>                         return -EFAULT;
>                 }
>                 val =3D MASK_VAL_WRITE(reg, prev_val, val);
> @@ -1175,7 +1175,7 @@ static int cpc_write(int cpu, struct cpc_register_r=
esource *reg_res, u64 val)
>         }
>
>         if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
> -               raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
> +               raw_spin_unlock(&cpc_desc->rmw_lock);
>
>         return ret_val;
>  }
> --
> 2.25.1
>

