Return-Path: <linux-acpi+bounces-1402-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2187E7B6D
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 11:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08731B20A04
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7572A14A8A
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="esARizgs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2E610950
	for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 09:17:35 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5175B2B7F9
	for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 01:17:32 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b709048f32so1692387b3a.0
        for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 01:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699607852; x=1700212652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qMFA/4LVo9MaNuOmPJbDYsQ8leCjxXQe4RXEqsi7Vk=;
        b=esARizgsre9kqI3zGeoLlST7/KVBkc09g1O66V8dft3tiL0cdPjQXa3/eEpBNtrjMl
         9g57WteRLr177S2wGvOmavsFhopumQGUNMyhnFQZhmDZc6SjyaFqYByMWoe3Wp9q/OHJ
         alsEFXvJrXZbXz8Z7MBEXyeOF6p70Q/9tBPnJkvD1pNreWgKtj4dTD0Q6GLyAQG8evmK
         vvPpOM+6qr9361SziZG1CcmUi+sap15huml2Mu56zIoQSxUlxL9/wV/h4fPbJRSQnLS+
         aYwoZf0Jb9EgehdeM/LphyuRJU1h9xY0dNlCLRRD24EfeC54slXfiedr4/it0W6uu5dd
         z/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699607852; x=1700212652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qMFA/4LVo9MaNuOmPJbDYsQ8leCjxXQe4RXEqsi7Vk=;
        b=hk2uCJL11hDY3FmsNJgLWn6VXIWkGK/okAgepTziYDkkK0AApUfSmX9KvfCVSNBjvA
         9IZiCd3kErQsT4B3zkh6HNbT8nR9P0pNZmsxVsogGCGFaq//JSzbQz1t3dvLW8zf8pQ0
         d5WkMfduO11IcwUU8sX+5N58YbGx0r2JzhpgQUJ5/9ufWmN7g6f6Qc/50zTo32Hz21Om
         vfyK5IiAzPqx/Bqs65cZKH7KT2h5z1Q2j63cREIHUDPzO1G72PSv9fLjaueUfE56UIbp
         nTHDkqAFlR/OcGABuZIOqcgGQH0tEtNwLD9X+g/gOJeeXMzBoOZpF6HF36P/gi2c2LrG
         E76w==
X-Gm-Message-State: AOJu0Yzu65LMRNDuBeXzMdnwzsX7/H3LzJNYWye2djDqXatF6tAxV2LC
	serSj5a6Yy7qbW41WYy3RTmSzQ==
X-Google-Smtp-Source: AGHT+IEf6ivgAkw6yVi3FBgNRxGS3TsVvGiByXO2mRhR+nd07TngiWoOOOYFgaeien5HK7d1Y0M7oA==
X-Received: by 2002:a05:6a20:f3af:b0:153:353e:5e39 with SMTP id qr47-20020a056a20f3af00b00153353e5e39mr5947121pzb.51.1699607851729;
        Fri, 10 Nov 2023 01:17:31 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709026b4800b001c771740da4sm4889837plt.195.2023.11.10.01.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 01:17:31 -0800 (PST)
Date: Fri, 10 Nov 2023 14:47:29 +0530
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
Subject: Re: [PATCH v6 5/7] cpufreq/cppc: Move and rename
 cppc_cpufreq_{perf_to_khz|khz_to_perf}
Message-ID: <20231110091729.jssgofhlcye4juev@vireshk-i7>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
 <20231109101438.1139696-6-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109101438.1139696-6-vincent.guittot@linaro.org>

On 09-11-23, 11:14, Vincent Guittot wrote:
> Move and rename cppc_cpufreq_perf_to_khz and cppc_cpufreq_khz_to_perf to
> use them outside cppc_cpufreq in topology_init_cpu_capacity_cppc().
> 
> Modify the interface to use struct cppc_perf_caps *caps instead of
> struct cppc_cpudata *cpu_data as we only use the fields of cppc_perf_caps.
> 
> cppc_cpufreq was converting the lowest and nominal freq from MHz to kHz
> before using them. We move this conversion inside cppc_perf_to_khz and
> cppc_khz_to_perf to make them generic and usable outside cppc_cpufreq.
> 
> No functional change
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> ---
>  drivers/acpi/cppc_acpi.c       | 104 ++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 139 ++++-----------------------------
>  include/acpi/cppc_acpi.h       |   2 +
>  3 files changed, 123 insertions(+), 122 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

