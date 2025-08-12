Return-Path: <linux-acpi+bounces-15612-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A8FB229FF
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 16:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C4758712E
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 14:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ABA2C2ACE;
	Tue, 12 Aug 2025 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HNAayn21"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B252D59F7
	for <linux-acpi@vger.kernel.org>; Tue, 12 Aug 2025 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007602; cv=none; b=LT+mqzcPC6pAWJPWF7i5XqTx5nw1qrDbTuz/4I4WWwbRlZyeOg3b7oCUpCvxyh9ujxKSwNLXqMQuNAH51UOlFVzJxuldXohVIzgUow0mDQB/LgRHM1IWCFsDe/hL0EtEJZNGiAFfLZdGFRjPQ+4F3N8hvtVEdbEgEhvK8fwOB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007602; c=relaxed/simple;
	bh=Om9ZXEBeL13c43bVNNkHAG09ch4yzcWNjm0tkf3t5OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNrN0Yw9iE+kmDYYe7cRC6kkH+6eiqn3l7ywAL9XWWCadwz0HjjOXUrQJzrzGtyaotPn7oGyDMeKP/pJnQ4Jk5spiGKCbBmdi5OyWZHo3Qit/FxOST4x8p/KL7UfduOey5ZYPNLe15HEi61TxF1maSLREq2TDFazym/hrRSOqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HNAayn21; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76be8e4b59aso4733926b3a.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 Aug 2025 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755007600; x=1755612400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zx9oekVSmxCmaENR1V+wY9m/ybp/4Sj6Dwt7Jr21Xsg=;
        b=HNAayn21D/xHDOBTo+hqzX6DtZ7C0qe/5K8yUx4IOxnPXSjEOs3/oW6y3s1eyKBqQp
         3mWVOXXbEDW0Qy3g4A27SZ2Nc57yJlWmbz3pCYczldY23AjEBXcMe0F3F32e/7P+Djn4
         sBO9TArzOf8DDES74DsrkeNczVg9hNOC/RsYiq7PKUy9DlEYsNo+2VT6umUHuJarLYHX
         V1ARwP/YOseJ4lTg2TmEs9WZXMn4iWztlrUBQcgl2CJpoGkIy+hINJPzr5AY4+nafhUE
         8aVpGAV5GMY2SvkfJtaZl5IeTU322jNzdMwxlHu2YNnfmRjQirw6MLQO0NFSAlKXqkp2
         kkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755007600; x=1755612400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zx9oekVSmxCmaENR1V+wY9m/ybp/4Sj6Dwt7Jr21Xsg=;
        b=lzOrFqXcT5BQ2ai+UNXfuC6/5OJDQY9DQYG+HN1vl7zZkf1kbIOYp969f31/ARwWcB
         lXkFa8cB/uYQ6LsuTJnXQQ6yQGXL+EgfSljYDZ+BHVXRZU3JMpiPMpJvfDBZlFrKD3pg
         926TJbtbl0n82+TRnfnORcKZQHl0dsRumc92E2Z0d8aEoi0E2IGSJ9N8WlcmecE6Z372
         rgyLaH7AgjmL28PXrjB7xoQjSdCicYi9Fh3psQZXCHL49M54V7TPWO6CahKWihvLlvK7
         bTsaT7cDPk6VTNhpAxxxm2vZTNULPCtRMdPxfIQBf0Zh3zoVTDP06XnKfxK87JkYWE2N
         me5g==
X-Forwarded-Encrypted: i=1; AJvYcCU8ilcxRjT8uvO8yGBTD/xRhhrVsBq/XKhERaNOT4Zm8oTMSZGq5ZaEmumCJRToyAKShPIo120btij7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfc5+OUmUtBuMjPv/xUMd9K69V6NRxpd65dPm19DzFxhkrc3nx
	J+/M5ckN5F5RyCb8xc4hGSYRJMNSBQodjd1vKziLDXa7M0inPQLeynj6zULCxyC9qj4=
X-Gm-Gg: ASbGncuc1XcsX+ZVaJAhSE5ZaxYC2T9YOJ99v2LjfzC3WXlYRsSZMqVGBQVoOiREVEo
	IvULRG4o3ZOafDH1sDSL6E9xd01OBF+5NrPYr35WsEZuZYvYudOcWtiiR+eWC8r85xhWOTiJdoL
	J7AlSCFm8abOCIlAtMRgvd7/mGrSivmjS2MbNxdmndFx+LWbhSpXqX6YHaS3Jjvyy19RBlMUPMn
	9x1jICpJVoyinVBIIAkldrHXFbYByY9K6WWYPLh/gx8+gyuWeegm/SJ/ujrDcb5HR4T1ZQ85EnU
	fMqCk7IP+rskoeXsxH7H7m95jun+dbkl+Nh3DkGjyy7LZp0cBpg7Ohyr6ddwA1IEn3pbddzZo+D
	RP7lKIrPYDqu3EEhWjk99DIW3DqI=
X-Google-Smtp-Source: AGHT+IGcHsbPj8XO4cfW2pkk7LoFwg04kGCDkYJV8zmTFaJVh057ytF2HwAZGrdzENuzynVjDOcyWw==
X-Received: by 2002:a05:6a00:2d28:b0:76c:c48f:d7ab with SMTP id d2e1a72fcca58-76e0d1263e1mr5042146b3a.13.1755007599557;
        Tue, 12 Aug 2025 07:06:39 -0700 (PDT)
Received: from sunil-laptop ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8fa33sm29884689b3a.43.2025.08.12.07.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:06:38 -0700 (PDT)
Date: Tue, 12 Aug 2025 19:36:30 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>
Subject: Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for
 CPPC FFH
Message-ID: <aJtKZhvNX0p3obFw@sunil-laptop>
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>
 <aJs-aPH32OxpzR3G@sunil-laptop>
 <CAEEQ3wnHFPBPC0U59rDBJaZYxJ24uJzJ7NDQO0gfmVqoiQwNOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wnHFPBPC0U59rDBJaZYxJ24uJzJ7NDQO0gfmVqoiQwNOw@mail.gmail.com>

On Tue, Aug 12, 2025 at 09:32:10PM +0800, yunhui cui wrote:
> Hi Sunil,
> 
> 
> On Tue, Aug 12, 2025 at 9:15 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > On Tue, Aug 12, 2025 at 07:25:44PM +0800, yunhui cui wrote:
> > > Hi Sunil,
> > >
> > > On Thu, May 15, 2025 at 5:44 PM Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > > >
> > > > Add the read of CSR_CYCLE to cppc_ffh_csr_read() to fix the
> > > > warning message: "CPPC Cpufreq: cppc_scale_freq_wokrfn: failed
> > > > to read perf counters".
> > > >
> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > ---
> > > >  drivers/acpi/riscv/cppc.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> > > > index 4cdff387deff6..c1acaeb18eac3 100644
> > > > --- a/drivers/acpi/riscv/cppc.c
> > > > +++ b/drivers/acpi/riscv/cppc.c
> > > > @@ -69,11 +69,14 @@ static void cppc_ffh_csr_read(void *read_data)
> > > >         struct sbi_cppc_data *data = (struct sbi_cppc_data *)read_data;
> > > >
> > > >         switch (data->reg) {
> > > > -       /* Support only TIME CSR for now */
> > > >         case CSR_TIME:
> > > >                 data->ret.value = csr_read(CSR_TIME);
> > > >                 data->ret.error = 0;
> > > >                 break;
> > > > +       case CSR_CYCLE:
> > > > +               data->ret.value = csr_read(CSR_CYCLE);
> > > > +               data->ret.error = 0;
> > > > +               break;
> > > >         default:
> > > >                 data->ret.error = -EINVAL;
> > > >                 break;
> > > > --
> > > > 2.39.2
> > > >
> > >
> > > The purpose of cppc_ffh_csr_read() is to calculate the actual
> > > frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XXX.
> > >
> > > CSR_XXX should be a reference clock and does not count during WFI
> > > (Wait For Interrupt).
> > >
> > > Similar solutions include: x86's aperf/mperf, and ARM64's AMU with
> > > registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
> > >
> > > However, we know that CSR_TIME in the current code does count during
> > > WFI. So, is this design unreasonable?
> > >
> > > Should we consider proposing an extension to support such a dedicated
> > > counter (a reference clock that does not count during WFI)? This way,
> > > the value can be obtained directly in S-mode without trapping to
> > > M-mode, especially since reading this counter is very frequent.
> > >
> > Hi Yunhui,
> >
> > Yes, but we anticipated that vendors might define their own custom CSRs.
> > So, we introduced FFH encoding to accommodate such cases.
> >
> > Thanks,
> > Sunil
> 
> As mentioned earlier, it is best to directly read CSR_XXX (a reference
> clock that does not count during WFI) and CSR_CYCLE in S-mode, rather
> than trapping to SBI.
> 
No. I meant direct CSR access itself not SBI. Please take a look at
Table 6 of RISC-V FFH spec.

> drivers/acpi/riscv/cppc.c is a generic driver that is not specific to
> any vendor. Currently, the upstream code already uses CSR_TIME, and
> the logic of CSR_TIME is incorrect.
>
CSR_TIME is just an example. It is upto the vendor how _CPC objects are
encoded using FFH. The linux code doesn't mean one should use CSR_TIME
always.
 
> It would be best to promote a specification to support CSR_XXX, just
> like what has been done for x86 and arm64. What do you think?
> 
Wouldn't above work? For a standard extension, you may have to provide
more data with actual HW.

Thanks,
Sunil

