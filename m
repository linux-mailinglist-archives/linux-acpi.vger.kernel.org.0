Return-Path: <linux-acpi+bounces-15607-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B4B22807
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 15:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0E77AD632
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 13:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB38242D89;
	Tue, 12 Aug 2025 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CTrNUvy7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690EB275B19
	for <linux-acpi@vger.kernel.org>; Tue, 12 Aug 2025 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004531; cv=none; b=kPItVlwJa9DPbSs6ybVLv63Sil62sCN83MMrKV6UIzk3W3CCwGbtjBNscaYn5MOD+hjh0S9ixG01YceQ5iTjtwMlDkkeygGNhXF1HoDuK2Z3Vs1UNWUOkcRv/eBl9Jt2II79rDXTQls29n5zHOCQWa3zSewrWrcP296FE87GgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004531; c=relaxed/simple;
	bh=KLnmQ4Q2BktvwUYMgm4VPtBXX+pAFSd/TT/FrW29OQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHTWNh4hUoqmKzq/Rzx3jj3RCef9rer50NbIYDSi3QNChxPHlzSEGPlTa2s/IlUI2gSdZCHc3/zPpgQ0X5C7O8lFKh9zzEEn1mw9pDnn3FIdxDf06KXrjRLnDRO4QJPfqoiGmWIIRlOvnX7TUGPNeHRR4lXg78CPX6AwT6qzZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CTrNUvy7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24099fade34so39292125ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Aug 2025 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755004530; x=1755609330; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CIZ+4Wv9ojpY1/fI9C11E1ch7d9wvWodMXJMaf6VoBs=;
        b=CTrNUvy7c/JbL4eUkp7lSZP/tbgsepeD/c0Gj0BrwsTlmtSFYTw55A/SnPwYFMmk4C
         YbkSe8GIp/p5ujWqZ94c44XazTJOYKqkEdaRVYrM0MKY815KpO0LQWfMTRjKS1htc0di
         vd3ptWQLVz/oQ+eg5tmup2PlvHrTJuWefN5iH6XvAwQp4zSN3YliEnDYJXpJy6f8vMhO
         GpHso91NWpF7uJ3+kAFVDs916du7Rrtrh/FYforTp7SzZeN0G3By/uZc5v+CC0DsT1d4
         wpxajMrx2mxfSp6zVfvztF31YeSWpFU2+FCUc/GXkuoGHw0OoExrS/ZoCCEcuyRPo69W
         G41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755004530; x=1755609330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIZ+4Wv9ojpY1/fI9C11E1ch7d9wvWodMXJMaf6VoBs=;
        b=jYO4DPneCIGrMsS2F76mmVFxrEriHV4COsve60MFiBp8l9aAtDZVihO4EndSniYTK0
         U8sFCbGX50f1X9QLJG43csl8VSwaY1Fd8PpTVu6DhXuXrPp4IuyKPHWjjXjZo46ZWM9/
         thGkZjPVgsIeVSceh03/tP/xMczDl1U0I02du2OUl44bqM2HWc1nnR5RXcCpt/UghP3P
         6Y5hmLMpsZXOiqkkOO8OoSqjn8NAV8Cq1HP9n89wwJtGAz7F8omO+5tsn513m7Yk7yd3
         Xt9t+PeDEy4jDc8JlzBJ5CnfIlqTItZECUDb5hqnrCPF22WFxOH5JsveBjmnkQY2JB5s
         aIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0G5japAPdEmydSp8RQsOVfD/1voAqJbAlR4KXxH6smfFJunuxjV0IaJK8xHWY/vw2hbwN2SlnWJXi@vger.kernel.org
X-Gm-Message-State: AOJu0YznpSAcnyQE2CIHbkdMWgxzuhYouEaxdo01bAMqbbxIRmKt9A5j
	gEYgUO065bvB5fc4s1ia0szfRdF5+oRqdlBRTxPXCncBqy0PdzUCL5mW1OPVh6kYNxk=
X-Gm-Gg: ASbGncvDOG8oygfq0IupfB4PEpeO/K7wckgjdhhkMXjVNB9/LAytPc60kxt6RyBFodC
	WJTn/o5rlDQmrgM05DGnh4ZgXnDsCvsCkWjaB2uhRHbrHBS98d4bmrqEk45XxxfG0ZeekS4+iif
	hxvi56KiRJDPN+1qZByRGMKI3C+pTXtwYOtzTxvRuO95zBOIrNTSrHDBoyV7MNQilxONQ+Vi+EN
	yNG8khxG/98lGyAcoD72LtZuXEpPjiaj+LG+yq1d2aVlv+pFinnlZiHSrIn2s9m7JEi5DLJOGX9
	wzF2AVgrCG+pLqatKf+8O6gyxO5iHgD8HN8KQEGOETJPTCezhgaVD3g1UO7Govln2W2efvhi7Xf
	tX9yhj+7d++yAiKSDU9Mdu+9xBtI=
X-Google-Smtp-Source: AGHT+IFryvq0NSXrxuldQjBSYbOlN7Rlx50CKMnuKseVMjAVcE6lnBOuAaWxNGVUjJ4OlINPVdOdDQ==
X-Received: by 2002:a17:903:41d1:b0:237:e696:3d56 with SMTP id d9443c01a7336-242fc316303mr60853235ad.32.1755004529704;
        Tue, 12 Aug 2025 06:15:29 -0700 (PDT)
Received: from sunil-laptop ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1efe8sm297489915ad.69.2025.08.12.06.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:15:29 -0700 (PDT)
Date: Tue, 12 Aug 2025 18:45:20 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>
Subject: Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
Message-ID: <aJs-aPH32OxpzR3G@sunil-laptop>
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>

On Tue, Aug 12, 2025 at 07:25:44PM +0800, yunhui cui wrote:
> Hi Sunil,
> 
> On Thu, May 15, 2025 at 5:44 PM Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> >
> > Add the read of CSR_CYCLE to cppc_ffh_csr_read() to fix the
> > warning message: "CPPC Cpufreq: cppc_scale_freq_wokrfn: failed
> > to read perf counters".
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  drivers/acpi/riscv/cppc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> > index 4cdff387deff6..c1acaeb18eac3 100644
> > --- a/drivers/acpi/riscv/cppc.c
> > +++ b/drivers/acpi/riscv/cppc.c
> > @@ -69,11 +69,14 @@ static void cppc_ffh_csr_read(void *read_data)
> >         struct sbi_cppc_data *data = (struct sbi_cppc_data *)read_data;
> >
> >         switch (data->reg) {
> > -       /* Support only TIME CSR for now */
> >         case CSR_TIME:
> >                 data->ret.value = csr_read(CSR_TIME);
> >                 data->ret.error = 0;
> >                 break;
> > +       case CSR_CYCLE:
> > +               data->ret.value = csr_read(CSR_CYCLE);
> > +               data->ret.error = 0;
> > +               break;
> >         default:
> >                 data->ret.error = -EINVAL;
> >                 break;
> > --
> > 2.39.2
> >
> 
> The purpose of cppc_ffh_csr_read() is to calculate the actual
> frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XXX.
> 
> CSR_XXX should be a reference clock and does not count during WFI
> (Wait For Interrupt).
> 
> Similar solutions include: x86's aperf/mperf, and ARM64's AMU with
> registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
> 
> However, we know that CSR_TIME in the current code does count during
> WFI. So, is this design unreasonable?
> 
> Should we consider proposing an extension to support such a dedicated
> counter (a reference clock that does not count during WFI)? This way,
> the value can be obtained directly in S-mode without trapping to
> M-mode, especially since reading this counter is very frequent.
> 
Hi Yunhui,

Yes, but we anticipated that vendors might define their own custom CSRs.
So, we introduced FFH encoding to accommodate such cases.

Thanks,
Sunil

