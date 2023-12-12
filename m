Return-Path: <linux-acpi+bounces-2318-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3652080EAFF
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 12:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C7FB20B0F
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 11:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915F95DF25;
	Tue, 12 Dec 2023 11:56:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAB9AF;
	Tue, 12 Dec 2023 03:56:04 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d9db2f1ddfso751850a34.0;
        Tue, 12 Dec 2023 03:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702382163; x=1702986963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brKq0jpbW9aCI7b335s4n8QVLb7NZhibmCFvGg8vEA4=;
        b=S9mahagTJV0MmI8aTc2lqvRT7BN427adE4iWdeIS3ZvcdxW/fOYogb1FvHox639J5E
         OEyDHwIRqQRc49gU52spFyM7FBqH79DTkW/zyadQia3xunDvmy44dA4vIPOrZiNNDver
         Is9c2swLExHESdJ4xCEfHHGB65bGOqy943DN34wJz7E7enHcaIwFJIePvsgKpTcEgjrt
         u4oAlmaaft76PanSUL9as/RQ2IetTFHGzqEeOJPQApM+7hiI7cvvOuKYcSYKdv5DhRDK
         uTvAR2BkorSAL9PnapCYiNxUoY8ajXIITL1c/tlzGDkFSQ/PDCDe+YuPjuvlaXz+5ItG
         mNLQ==
X-Gm-Message-State: AOJu0Ywna+X354nQgtpO8/YGMA5t3r0rIpdAcIY7OJtR+c+ANrVtZ5u9
	dbXPH/gZUtkv/hDQVhKKu4OkFiRnyFYY2GIkMd4=
X-Google-Smtp-Source: AGHT+IGPG+nLiZPqfM80+t4n70h/b3qWSZ9agga5aMMrFRBh9BzSnCVBMj2CwFXTYVsSwueHiPheyJ3lOPYfl+W+oC4=
X-Received: by 2002:a05:6820:220d:b0:58d:5302:5b18 with SMTP id
 cj13-20020a056820220d00b0058d53025b18mr12282868oob.1.1702382163333; Tue, 12
 Dec 2023 03:56:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211104855.558096-1-vincent.guittot@linaro.org>
 <CAJZ5v0i37gGqt=oGC4BxJ4hT5pxhAdL7dPxGf7w3D8THqwAOwQ@mail.gmail.com> <CAKfTPtDXLDpGChy7UXVsV75NHK1OPGHaGYf5G663HWnau4kAHg@mail.gmail.com>
In-Reply-To: <CAKfTPtDXLDpGChy7UXVsV75NHK1OPGHaGYf5G663HWnau4kAHg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 12:55:51 +0100
Message-ID: <CAJZ5v0ir=2qcQyCg5CPUG=A_09Tdw-rYOX_NQr7eib_yk5t=nA@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] consolidate and cleanup CPU capacity
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, sudeep.holla@arm.com, gregkh@linuxfoundation.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com, 
	lukasz.luba@arm.com, ionela.voinescu@arm.com, pierre.gondois@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, conor.dooley@microchip.com, suagrfillet@gmail.com, 
	ajones@ventanamicro.com, lftan@kernel.org, beata.michalska@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 9:32=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 11 Dec 2023 at 20:52, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Mon, Dec 11, 2023 at 11:49=E2=80=AFAM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
>
> [..]
>
> > >
> > > Vincent Guittot (7):
> > >   topology: Add a new arch_scale_freq_reference
> > >   cpufreq: Use the fixed and coherent frequency for scaling capacity
> > >   cpufreq/schedutil: Use a fixed reference frequency
> > >   energy_model: Use a fixed reference frequency
> > >   cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf=
}
> > >   cpufreq/cppc: Set the frequency used for computing the capacity
> > >   arm64/amu: Use capacity_ref_freq to set AMU ratio
> >
> > This series touches multiple places, but mostly schedutil, cpufreq and
> > the EM, so please let me know if you want me to pick it up.
>
> This serie has been rebased on top of tip/ched/core to fix a conflict
> with another change already queued in kernel/sched/cpufreq_schedutil.c

OK, so I'm assuming that it will go in through tip.

Thanks!

