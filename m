Return-Path: <linux-acpi+bounces-1054-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6020A7D955E
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 12:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6D2B20EE5
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2772E18055
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnrjxLDc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98B415AE5
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 09:32:31 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56443E5;
	Fri, 27 Oct 2023 02:32:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso3082968a12.3;
        Fri, 27 Oct 2023 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698399149; x=1699003949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TGQezb/2UwSSANsvO0wTZNbBZ1J9wDNV1NfnwhXP5Y=;
        b=LnrjxLDcxJUIt9Yq9IFd8Be4bKDxWY1xHSmYzyB03O/fNZ+2oef85H077PBcnCpEVy
         qY9TJ/zIt9IrNcMDScdjMaBkcq3Vt9iwdjFjxmPKLrjQcO7SASLg6jF38QI+2+YGaYZ/
         LsvrmQCss/64PmEC4YkKSPs9Pp/M2hFo/kSCDDKLWLqRu0UzNDodf0khzPr/JZMJfwcK
         Rhs4YZ7fVHm03D8tQxNrkFnY32GNocZdqFt+sd/BDfGeBfey4oaN0k4afdPP9d3+zJjQ
         UUo7WOVYVRCNBccayWSATSL7/dUU3hZpvP9frL4JBcxdvHVnwEkEY9waFWfqQV90VZ8u
         HqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698399149; x=1699003949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TGQezb/2UwSSANsvO0wTZNbBZ1J9wDNV1NfnwhXP5Y=;
        b=RXbA0+VbjvZUItglNRH8nDWTs+K4xdtwjyXZD3cD/BFeAS3dB84WX/U24RPWZDSJd8
         nAcRjNrnIftlBHIuZr8Wu2BjfUQAY4td/VCMpRhLfi4YULYYirKedQiNWWOAUcxH/0Yd
         kWShPh+X/16Ryse4CIuCvu/4QEV4kbdEuzKFP1zGUv9BpH1TaUhJ/Nj6bcKe9EMDpAm7
         EvtenXM7evARZrvwnlg6iCwPrhA/84VBY4MYOIqJ/2pRI/1xaGv13sFHHzhmCOOOFFSx
         16e3In+emmhnJVpepn2PAKuQ9BOodM4XqWoC/RtnkHd/D4cjQcABAx8DnB2esRMoPFLr
         5jVg==
X-Gm-Message-State: AOJu0YxOiPG9bPHwbrJ6vMYfV8E/YuxHYJbb+uKcNUkHKdT7Dx6Did38
	QYjIrQpeQCjMzIX35ecVV7o=
X-Google-Smtp-Source: AGHT+IFYRkZzQF178l+CBBj5nIhjyDKrHzuo7UGw35x0uc/25E+HLUFEyY65L95Wmew2k9xBvyg6eg==
X-Received: by 2002:a17:907:60cd:b0:9be:45b3:3116 with SMTP id hv13-20020a17090760cd00b009be45b33116mr1857989ejc.71.1698399148573;
        Fri, 27 Oct 2023 02:32:28 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id o26-20020a17090637da00b0099293cdbc98sm915781ejc.145.2023.10.27.02.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 02:32:27 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 27 Oct 2023 11:32:24 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
	lukasz.luba@arm.com, ionela.voinescu@arm.com,
	pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, conor.dooley@microchip.com,
	suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v4 0/7] consolidate and cleanup CPU capacity
Message-ID: <ZTuDqCFL6uM3tqDd@gmail.com>
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027080400.56703-1-vincent.guittot@linaro.org>


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> Vincent Guittot (7):
>   topology: add a new arch_scale_freq_reference
>   cpufreq: use the fixed and coherent frequency for scaling capacity
>   cpufreq/schedutil: use a fixed reference frequency
>   energy_model: use a fixed reference frequency
>   cpufreq/cppc: move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}
>   cpufreq/cppc: set the frequency used for computing the capacity
>   arm64/amu: use capacity_ref_freq to set AMU ratio

Just a general comment wrt. titles: please capitalize the verb, as we'd do 
in a proper sentence. Saves maintainers one more thing to fix when applying 
patches.

Thanks,

	Ingo

