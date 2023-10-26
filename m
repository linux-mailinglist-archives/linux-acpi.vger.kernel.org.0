Return-Path: <linux-acpi+bounces-1023-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0923B7D84D2
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 16:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B812A281FC1
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3DA2EAF5
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2dEkPdF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C562EAFD
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 14:31:07 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0C71B2
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 07:31:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9a1762b43so7768705ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698330665; x=1698935465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cyPzF6zImIluItqkN237S1HDHY3vs2wBArSwbVc/hzA=;
        b=z2dEkPdFfUlgbOE45z4yUdd/p2adlb/iOdWRpd+vaiDpn+D9rjuT/ONKaIae3IY7R9
         S2HOZOWACm/u59cenOkLecHRR/9yS17fPTf7U+w1oYzac/JAC9jHqnMdYhhgHYL6Ou14
         7e6b0WjSKjW4EZwtEJeS8VEZsnO3RrCb+R9Gb1NYYJc7iq7W9GGPweL+LuRWdSaa8KGV
         izPA0C88gnjevyA8WQYcEUJK4WZY/ovecw7ctYkyEhlhtky0AFoRlVupMhYPtlRdUcmw
         g3HTbL4WKZoTxIZAP3FLSIRFadR71HmAcOj+bf26TjKEoz9oOvMTCokxb4pf8dw3fGfN
         jU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330665; x=1698935465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyPzF6zImIluItqkN237S1HDHY3vs2wBArSwbVc/hzA=;
        b=v5Ba8IYDZSxdSBfFtYHja4h4VaXPjtwMLO3ZRA2ZgmKuCZk4SyMgyABGhwCot49pA2
         jLM4pUD82f7+9FFhSA8KgRa8EV0Xa9czl0S8EOEMC+1gVd7ILGnMs+JVITc+jvt/Rr5N
         pDqeTdIzqeP6GzOLXEKuQ8CWIjyuhCl4xHffcsipGm/fj6MUtxVQ0XMNmGoKtuTXnqZr
         cOJA/PhrBBJEEXUbzECs0WBFNd6Kbl3AOUE4k28qq8rXFuIfSO/YSOlVDPU1hrdXShLL
         klYWbmd0a7biatyeq12CbEoOEG8gJFO6lUOofwIjGZQBMNJsU3PMACl7hJzvaTTtR0w4
         9FRA==
X-Gm-Message-State: AOJu0YyM77YXOW0Q6MQjS2ngSXQKEQhBSswysrc9D1neqaLMMWLC3nmi
	IM/2f4e06wO8o/57r4d8NYR1lHJZ9d+XasewRbn1sw==
X-Google-Smtp-Source: AGHT+IEPrFg7ph9PvUTjEjTWPycx9rIXgHGj8Pm/PdzOH55g1dDMU1zMVGUh7AImWIiMYHZ2g2wRbWAImZmI9AfkT3Q=
X-Received: by 2002:a17:90a:1c8:b0:27d:6dd:fb7d with SMTP id
 8-20020a17090a01c800b0027d06ddfb7dmr19390459pjd.17.1698330665193; Thu, 26 Oct
 2023 07:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-7-vincent.guittot@linaro.org> <ZTbebQrK3K+JwWxR@arm.com>
 <CAKfTPtA0KBE8TFifOEXddF9d_wqDjb4QUvgK8c0DTtyLrX0atA@mail.gmail.com> <c000f7a3-caeb-4d75-8c88-40ed02950ec1@arm.com>
In-Reply-To: <c000f7a3-caeb-4d75-8c88-40ed02950ec1@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 26 Oct 2023 16:30:53 +0200
Message-ID: <CAKfTPtC7vtCKXG4y+7TwtjRJKkzjhPQ1Wb61OXihTDPaetGeWg@mail.gmail.com>
Subject: Re: [RFC v3 6/6] arm64/amu: use capacity_ref_freq to set AMU ratio
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, sudeep.holla@arm.com, gregkh@linuxfoundation.org, 
	rafael@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com, 
	lukasz.luba@arm.com, pierre.gondois@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	conor.dooley@microchip.com, suagrfillet@gmail.com, ajones@ventanamicro.com, 
	lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Oct 2023 at 13:19, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 24/10/2023 11:58, Vincent Guittot wrote:
> > On Mon, 23 Oct 2023 at 22:58, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >>
> >> Hi,
> >>
> >> On Wednesday 18 Oct 2023 at 18:25:40 (+0200), Vincent Guittot wrote:
> >>> Use the new capacity_ref_freq to set the ratio that is used by AMU for
> >>> computing the arch_scale_freq_capacity().
> >>> This helps to keep everything aligned using the same reference for
> >>> computing CPUs capacity.
> >>>
> >>> The default value of the ratio ensures that arch_scale_freq_capacity()
> >>> returns max capacity until it is set to its correct value with the
> >>> cpu capacity and capacity_ref_freq.
>
> Nitpick: Could you mention that arch_max_freq_scale is the default value
> for this ratio? Took me a while to recreate the (not so simple) story
> for this change, i.e. make the connection between ratio and
> arch_max_freq_scale.

something like :
"
The default value of the ratio (saved in per_cpu(arch_max_freq_scale)
ensures that arch_scale_freq_capacity() returns max capacity until it
is set to its correct value with the cpu capacity and
capacity_ref_freq.
"

Or I can rename the variable per_cpu(arch_max_freq_ratio)

>
> init_cpu_capacity_callback()
>
>   freq_inv_set_max_ratio()
>
>     u64 ratio
>     ...
>     per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio
>             ^^^^^^^^^^^^^^^^^^^
>
>
> static struct scale_freq_data amu_sfd = {
>         .set_freq_scale = amu_scale_freq_tick,
> }
>
> #define arch_scale_freq_tick topology_scale_freq_tick
>
> topology_scale_freq_tick()
>
>   sfd->set_freq_scale()
>
>
> amu_scale_freq_tick()
>
>   ...
>   scale *= this_cpu_read(arch_max_freq_scale)
>                          ^^^^^^^^^^^^^^^^^^^
>   ...
>   this_cpu_write(arch_freq_scale, (unsigned long)scale);
>
>
> #define arch_scale_freq_capacity topology_get_freq_scale
>
> topology_get_freq_scale(cpu)
>
>   return per_cpu(arch_freq_scale, cpu)
>
> [...]
>

