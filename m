Return-Path: <linux-acpi+bounces-1401-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD847E7B6C
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 11:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076F81C204F6
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F4D14280
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kD6KlBtS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE510950
	for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 09:17:06 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05A52B7F2
	for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 01:17:05 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc3542e328so15158965ad.1
        for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 01:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699607825; x=1700212625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNAKGQcfwtX1sEelGFUcCMMKPbFCHvv7FrRIow0M5oA=;
        b=kD6KlBtSOJVn76Un+S+8+g470XuA8EJZrddiREBhESrNY0fbt/Y1vffed70qYBc588
         h7ZLU8TTYLzI1PR/Kldxv93K7V7U3tBYCWroM/DbGWbLN3v1EkNt9Wm/Bd6IG7Cq1wHz
         nZn6pg1ha6XLBUOpohzb49L0Bh1dcuBH8mCzdahf00F9mffrOT0n9RLBtWNrRxlGfbZ8
         RISoGBcRIR/3S+2uOzYRbKcwx/1Li34xeCNi2r95xhyz7LjZgK/D5yhDSct7XcQbtqKv
         RoT9XDxdKbkitmXVrUwbuF4uWkRLRu5mbflxDvc5fjlRN1tnlfxWaChRXZ9u+KU5xowm
         HSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699607825; x=1700212625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNAKGQcfwtX1sEelGFUcCMMKPbFCHvv7FrRIow0M5oA=;
        b=V0/XB//8D9SkNdO0JXNgHbUYBPELY746W9F868cYKFiD0C9+OaTvzP0sa1ZSdMHucw
         dX01naWsCaA/ge7sUx4+oSVyiuPgFsZya2tAh59yekd3dPACpKM++OQCwmz70nhzNv8b
         7ueAg0rMQ9nWuYaJEXFISQqN1B/Arke8jbROfrNjZ/xHl4Re2rQ2DW80mQdUNxYLBIe8
         EJZVLjnefW31LlMaahBYeWTlme6IyNuupWjxS/tIdpEuR/FuhcgsjgsJtOmmRFsWbiCl
         3yXPTJMWcRLXEt2AWxLzs1vrFZU2Afccq3VsgsBT+iQKIXZHoejkQFzlC/eDK1EsG2M+
         fY4w==
X-Gm-Message-State: AOJu0YwE/SCqaA/Fo/3yxqhtOXD8hxT8qrz95xsZ65BnuHB+lwyErclf
	OKpZkguAprz5C7fMr9XiA6ioLw==
X-Google-Smtp-Source: AGHT+IEex3kLeiwKyEz2es872zjMNmrevn40/2l4PbaRjQ1owa57zfxwzE3YTcFU8WWcXat6tXWPLw==
X-Received: by 2002:a17:90b:4b82:b0:280:74fc:ac2c with SMTP id lr2-20020a17090b4b8200b0028074fcac2cmr4523903pjb.13.1699607825201;
        Fri, 10 Nov 2023 01:17:05 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a7f9100b0027ce254fed8sm5666457pjl.0.2023.11.10.01.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 01:17:04 -0800 (PST)
Date: Fri, 10 Nov 2023 14:47:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
	ionela.voinescu@arm.com, pierre.gondois@arm.com,
	beata.michalska@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	conor.dooley@microchip.com, suagrfillet@gmail.com,
	ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v6 3/7] cpufreq/schedutil: Use a fixed reference frequency
Message-ID: <20231110091702.z3phucnffoe44kxy@vireshk-i7>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
 <20231109101438.1139696-4-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109101438.1139696-4-vincent.guittot@linaro.org>

On 09-11-23, 11:14, Vincent Guittot wrote:
> cpuinfo.max_freq can change at runtime because of boost as an example. This
> implies that the value could be different than the one that has been
> used when computing the capacity of a CPU.
> 
> The new arch_scale_freq_ref() returns a fixed and coherent reference
> frequency that can be used when computing a frequency based on utilization.
> 
> Use this arch_scale_freq_ref() when available and fallback to
> policy otherwise.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

