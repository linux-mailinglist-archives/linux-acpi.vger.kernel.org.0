Return-Path: <linux-acpi+bounces-2305-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896E880E62E
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 09:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D271C1C212EE
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69071863F;
	Tue, 12 Dec 2023 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ohaMR0vs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29E7F4
	for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 00:32:19 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67ab5e015aaso35886046d6.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 00:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702369939; x=1702974739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4kqMN+HbgK8h0LRfiST0/gaIQ4yUhlUvwCL2KbU+eI=;
        b=ohaMR0vso/xbPTodlA9davmFnr6Wk8qwVFrDd3oymXW1n0MjDY+dLUIx6j3mTwKq15
         6quMuRTWo8Rkgnv63ObkHSRfVuFpOCnF2VVmk+Hfg647kW1rYBf52yUNbw12fTb7fAiI
         C1LY2Wc0r+B60Parv06z9G9IyptP9l7q+29+wCJjMKsUKQ6Scy/F21uOXzuVcvT86SdT
         fKnc44KtKdXJ7BIs5m4E939lphbz/bC8Gj1nl5JXoP+gh+hyttBasQtAZ8DY0Lx4xdCA
         PcsuI1xRX4fs+zqt+FKo9CU8DqC365fTbDgHOUUPr9LI8Xn1jNq1LPAmYnv/KYfu8GVn
         GEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702369939; x=1702974739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4kqMN+HbgK8h0LRfiST0/gaIQ4yUhlUvwCL2KbU+eI=;
        b=sdti50Khe2/2G9gkLsV0WeMg0vMV9+1Z/vh53jVaifnWNab5rox8xvaLzQOiSlhy43
         bUeTgehNydbJfLbyqUA/ydLrA0DPzWRJZ8i/LogFFQtHvNrMRgeSeAihjhl4pQKwHTs8
         3Om9UGhc+xgAIh+ok7WZO/0EZPkQVnQEJrEVvBLTEd3fPcPhws0RgXEaJTHneTMHKF0+
         fb96mF9bOma/OZ3+sXLor7zXMzYDrjmlIM+XxwWBHW3/1OIr3q3E30dxn1hq9gMWCpn+
         vozl6+mVrfGJJmPddBdhJ8U/Pn4sL+LDNgrP3Xc0hP8pGCEGp2XMvaPFZVussU/igfjD
         PXNA==
X-Gm-Message-State: AOJu0YzWuf59BV5U/DxjLz9i+wp5WF9Vl3BnFrn0UmGuFQDd/NKOca0o
	MMOdUp0IUOfI9xp2julvBbCrZFW3GLtL32nfAeQSDA==
X-Google-Smtp-Source: AGHT+IG0V6b2w6UWHUlW9pxYWTaS0uDQUzxhZQ4B06wFrRKsghNDJX6XvOe1qtLzaxB+JBeOLMSozUSB2UxByYZ/7u8=
X-Received: by 2002:a0c:be89:0:b0:67a:a721:7850 with SMTP id
 n9-20020a0cbe89000000b0067aa7217850mr5392942qvi.117.1702369938818; Tue, 12
 Dec 2023 00:32:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211104855.558096-1-vincent.guittot@linaro.org> <CAJZ5v0i37gGqt=oGC4BxJ4hT5pxhAdL7dPxGf7w3D8THqwAOwQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i37gGqt=oGC4BxJ4hT5pxhAdL7dPxGf7w3D8THqwAOwQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 12 Dec 2023 09:32:06 +0100
Message-ID: <CAKfTPtDXLDpGChy7UXVsV75NHK1OPGHaGYf5G663HWnau4kAHg@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] consolidate and cleanup CPU capacity
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, viresh.kumar@linaro.org, lenb@kernel.org, 
	robert.moore@intel.com, lukasz.luba@arm.com, ionela.voinescu@arm.com, 
	pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	conor.dooley@microchip.com, suagrfillet@gmail.com, ajones@ventanamicro.com, 
	lftan@kernel.org, beata.michalska@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Dec 2023 at 20:52, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Dec 11, 2023 at 11:49=E2=80=AFAM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:

[..]

> >
> > Vincent Guittot (7):
> >   topology: Add a new arch_scale_freq_reference
> >   cpufreq: Use the fixed and coherent frequency for scaling capacity
> >   cpufreq/schedutil: Use a fixed reference frequency
> >   energy_model: Use a fixed reference frequency
> >   cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}
> >   cpufreq/cppc: Set the frequency used for computing the capacity
> >   arm64/amu: Use capacity_ref_freq to set AMU ratio
>
> This series touches multiple places, but mostly schedutil, cpufreq and
> the EM, so please let me know if you want me to pick it up.

This serie has been rebased on top of tip/ched/core to fix a conflict
with another change already queued in kernel/sched/cpufreq_schedutil.c

