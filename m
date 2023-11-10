Return-Path: <linux-acpi+bounces-1403-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFA97E7B6F
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 11:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0278A1C209B5
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 10:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B7918E09
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZV2WbWJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623310A0F
	for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 09:18:07 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA072B7F7
	for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 01:18:06 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5bdf5a025c1so1396045a12.0
        for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 01:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699607886; x=1700212686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQTkE1ZnpGXcZrl7W6lR4eKSn0Z1KI5/u9IM9eBWdzI=;
        b=aZV2WbWJN/MupF53Gl5WDyBX4VnHbTtk3PCCM/99/x6RApuoK7xeoksvPU6VwvyrqM
         X2ou80ymLE/EJkub+m0GtsKNUqILZoZMV/4M7bz1GsvKE5NcUlgxQN1aRoOrbjVXofnh
         +aBzgYGURDHKOOIAZtnc692snRHBgC+00WwWGT4obxw4OcIhAccCpkd++O9PYfsEeu4H
         1uHqU0FucU15gp8uH04VGF5KygK9SRKG7ijc2LwulLwdxduWBOWjXtzEi8LuRkcMah9y
         GKkMqGUpxn9CUnCzb/4v/SXskuUe5K/irfmxvx0AuY5dOCZKGMQOzjNwXPLbjrXeh0Cb
         8iWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699607886; x=1700212686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQTkE1ZnpGXcZrl7W6lR4eKSn0Z1KI5/u9IM9eBWdzI=;
        b=S1UUGKKTtavNMLjvNuFYN1ea+8UZ4EaG9/q2KeuwZe65Jl0BUcn7kkWpUsdlQwnBpG
         GsHZjgD3WEZUNN3tBNB4CKNlvK75x7XFBe07JMN/eaFgTOboyrwHxe1s1oX2oEzHgsg7
         /I2tQCqj5MJjtfixY2V6JHLY4aunvRyPFlurR3+cZtK94nW1lHF9GNJF1PlUfen3+MG3
         ar5b6ET18Qsv9GvKKWuSz0klvVz9oYIbQCkxyfFJojyp6Hu0s8v2QLfmOJ1Y7W5Ei0oQ
         71OlKB05zhCrrm/irx8LMbdSDC/0UXygioPp4/huQugVUF+G/FMb/PfNwTWiBthx2Q3e
         Q2xA==
X-Gm-Message-State: AOJu0YzCQcLN1e+TRxfVUjD0ymFVscMjPDBoWymb3goyBZUgh36iQ3RJ
	mE6ip2F9Mv76oVu/OBBeCUnO4A==
X-Google-Smtp-Source: AGHT+IGife7skzKrRrmxXSpDW1iTw6SRyJPT40pz+mavprG4ApUvNEQqFPvzfzolUakrl+Owq+kyyg==
X-Received: by 2002:a17:90b:3887:b0:280:e0:9071 with SMTP id mu7-20020a17090b388700b0028000e09071mr4653129pjb.28.1699607885946;
        Fri, 10 Nov 2023 01:18:05 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id g13-20020a17090ae58d00b0027d12b1e29dsm1149227pjz.25.2023.11.10.01.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 01:18:05 -0800 (PST)
Date: Fri, 10 Nov 2023 14:48:03 +0530
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
Subject: Re: [PATCH v6 6/7] cpufreq/cppc: Set the frequency used for
 computing the capacity
Message-ID: <20231110091803.2xqtodhyxtuxdbba@vireshk-i7>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
 <20231109101438.1139696-7-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109101438.1139696-7-vincent.guittot@linaro.org>

On 09-11-23, 11:14, Vincent Guittot wrote:
> Save the frequency associated to the performance that has been used when
> initializing the capacity of CPUs.
> Also, cppc cpufreq driver can register an artificial energy model. In such
> case, it needs the frequency for this compute capacity.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/arch_topology.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

