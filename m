Return-Path: <linux-acpi+bounces-967-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BEA7D6ED7
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 16:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA05CB20A07
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1022AB3C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ujgIsFmS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F98467
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 12:58:37 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFC9C1
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 05:58:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27d3c886671so4956170a91.3
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698238715; x=1698843515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RXdPX/Ew6vUAH8RT3E33QyyRiIgHD1/PeR48oEvaIy0=;
        b=ujgIsFmSj0ixw/CUVChpg7tghbDRnMDBnj8ynQbY4JzSZ2NPxJYML6jWhckAY0ASPE
         GBX2jaVGsJkii10l/vWJfd1XmwRQpZqxxDFEtIEEkYTd1UtGqw1QZ6k+ivz4FRx5slZ9
         6Q0QteUAspYiRuX9Ien74naace8pNatLxtZTD2MeeoJ6R2MBjHTTNyWutoj4eA7x/BkN
         EbRU9AJPl9k4CNWxKKtauJlwGlx7Bz+UHeYlaWWzP82CqRn4+t1V4ZXKE1ghIKWGBD/4
         EjQbFTsng4kPff8s19tBLAoe/kEiq0jDcCZV5p60EQ7S2d7rGk0SmaLAY7skvOLYKubZ
         /4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238715; x=1698843515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXdPX/Ew6vUAH8RT3E33QyyRiIgHD1/PeR48oEvaIy0=;
        b=hNDO2E7AY8ALjbuVa0s2baBzxWUm/ighvzt/t1030O/JCadqgmPurTPLG/7UKN1SNz
         OyQER+sQRF2mGOOJygB0fcG+HwaJJCMTXk0UwGvewKr7GzA5/8sib1h/ZNUBNXWMrEsj
         M12fuJgRj3Y7j4eTdGtLpMVItDxCNekvzO19AdQa3hHk7QSH8/6sVjU+HtphDBkOdyFD
         anEtDCy17zE0ocRKvYU81CbyH/q6sqKhTdIT5brtK8j18Jk7SfND0QT025geTyEfU2jV
         rTPwIqO+X3fwJgd2EAfLny7YiXovTEEhiqqjKDhgMP0P3BiWcGg0w60fDzReosXY8Oor
         BlrA==
X-Gm-Message-State: AOJu0YymfwEyfMoQeS1BDBWwXjvFIDJ++YyTEzCEWMfK9Yk6dzti9ta3
	L0BbaCl8rWV/WwDSC+t/6D1BQVLsgq/Y5rOLgzmcrg==
X-Google-Smtp-Source: AGHT+IHmoJ9xE85jGvst0QuZ8mIaONL518f/RiO/u3OpvoeRZ4onqE5R7ha2FlOK0X/zBrOO+EbV/QXuM3FR8wyWxTg=
X-Received: by 2002:a17:90a:f312:b0:27d:2cc3:c805 with SMTP id
 ca18-20020a17090af31200b0027d2cc3c805mr15222491pjb.46.1698238715427; Wed, 25
 Oct 2023 05:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-6-vincent.guittot@linaro.org> <20231025125151.GF31201@noisy.programming.kicks-ass.net>
In-Reply-To: <20231025125151.GF31201@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 25 Oct 2023 14:58:24 +0200
Message-ID: <CAKfTPtAb-9VcNKNf1HJOi83STrC_eNRD1Qf0Ra2fm6qspqme7w@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] cpufreq/cppc: set the frequency used for computing
 the capacity
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, viresh.kumar@linaro.org, lenb@kernel.org, 
	robert.moore@intel.com, lukasz.luba@arm.com, ionela.voinescu@arm.com, 
	pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	conor.dooley@microchip.com, suagrfillet@gmail.com, ajones@ventanamicro.com, 
	lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Oct 2023 at 14:52, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 18, 2023 at 06:25:39PM +0200, Vincent Guittot wrote:
> > Save the frequency associated to the performance that has been used when
> > initializing the capacity of CPUs.
> > Also, cppc cpufreq driver can register an artificial energy model. In such
> > case, it needs the frequency for this compute capacity.
> > We moved and renamed cppc_perf_to_khz and cppc_perf_to_khz to use them
> > outside cppc_cpufreq in topology_init_cpu_capacity_cppc().
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/acpi/cppc_acpi.c       |  93 ++++++++++++++++++++++
> >  drivers/base/arch_topology.c   |  15 +++-
> >  drivers/cpufreq/cppc_cpufreq.c | 141 ++++++---------------------------
> >  include/acpi/cppc_acpi.h       |   2 +
> >  4 files changed, 133 insertions(+), 118 deletions(-)
>
> Perhaps split this patch into code movement and actual change for ease
> of review? As in, I'm having trouble finding the actual changes ;-)

yes, I can split it.

The actual change is located in drivers/base/arch_topology.c

>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

