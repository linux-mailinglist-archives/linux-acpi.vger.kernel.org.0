Return-Path: <linux-acpi+bounces-18356-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F6C1E820
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 07:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D97444E62E9
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 06:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2982F60DA;
	Thu, 30 Oct 2025 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="0gwxhhNO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB726A0DB
	for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 06:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804436; cv=none; b=TWngA+PIMFneRBl4vENKhWlLGEX7/7aGbcdwZqf/yY7EHnjl0nmsATDLVoLquhnZiReOT7HZiYQZNeCy3CpqE9GsjqX7cJVqL8Amb72r1nUUrcFrO08d3hEhzI8qufH1z5QLXnaSfsyJ/5iJnCuVobmFIM5MnJPGU7bH5G04C04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804436; c=relaxed/simple;
	bh=/6eS1rSrp3y277Vz4B3Abj/WQzCqBSEwZwUivQ53yoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHsQOO0dyalBpWw5W5YaHJ13a1SSp73AEqwa/y8+tus0C4TQuXAEIxgc74B8HmgXmltZSFoe7Kq/HskLxVI477GG0EmMW1rOPuVLzFGbnuPyqGsBw7uBiKy80xWPdySUcNh8JuVmWXjxbsLZZOW/HcwpOD05DQl2Y8yH+VhbsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=0gwxhhNO; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-92b92e4b078so30477139f.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 23:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1761804434; x=1762409234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2oOVPuOCfFeYpVN2DHmuplgz6ll1JdAv6+U3SGE1nM=;
        b=0gwxhhNORdYniZZzPck6P6fKpoDTfcj3OLogXg33XBkk33c8zK5zJhtMl1n+6otqDt
         yTu3G0fbMleUYBhjYnMlUzO8UocbTcYKPS2nzoBLCYNDAyQmvhA/ae26MsXwn3gPzcVm
         i8VABokHVHtIYunV9QVnLnzozs/ByraB6OjOU+9rv9swrn+HFjsXAjD5qei1icnoh85N
         5lZaM/a8sN8UQcs3hfE3ZKCMtSd0fY7WxG2lrgCyS+vbwKcBrVL6AQ4wb88fmA5KLVcK
         xBBzuzZDNsxC7T+21KNMzpi95JwiXdyGvT22jajZ1B6dTAPVH8eht6awMlBSBRc9xa0C
         ileg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761804434; x=1762409234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2oOVPuOCfFeYpVN2DHmuplgz6ll1JdAv6+U3SGE1nM=;
        b=KRv7vSmlc7CESXXvLNtzVf2l5RZxCjxo7/ZW/HusvsG9S9uHNnNYaDc7kl29QxnIYD
         yg3xh9C+sH70haW2lMNurV0p7/4qqiNJhDh38ldYuRflrC09vM7eka/lZUzetNQ5axij
         vd2aE3AwcWjJ5vh/Eut0zUPTI2FUGGOHXwjtlkJmIqnNI/6a6D+YG1BtXwBGJj+isB5w
         dcF62S9d21csTd96SiemIEje67r4a2rXCfRrhdk/3WYjxGAdmUzKkxiHA+BmGXoAAkIp
         eI+XwteSX96XqpFyQuhXy8CNgY/dwiGrcyoSA13kBZtUTgXH+6gpIl1h7uFM+lrW4HDy
         FMdg==
X-Forwarded-Encrypted: i=1; AJvYcCVFy2e4e4OgOQZGpxeNM+oeIUqPXUy0EvmV+yNCrRG2NKKXgco3rZkWm+AjnJKBT5Jo8v3JEsAt+TpZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwCZ9Gyl+jkwihVZHlIWqBnUWaWqStMqBz+oXW1bJ6pAcdTwoWv
	8FPT+57WdyGLfLcJ5BcSTq2kZIB/R6bfegRqwB1MHlzjPVjm4IxR57dfuMe1Oev9NItTVXqN3wz
	di2BkxtDxI80ZGm4j44ExqBXH5SbRKE829NWMs7l9HQ==
X-Gm-Gg: ASbGnctEPVK0g6U4TaV1dPPlPJa7WQSkNO9wK3jsYA6FClYp49CKQn+iJSxsjM8Pacb
	MHXCGiaKRd8zelRJfoZnSWqc9jDU/Oc3ii8yWUmAWNzobalKgT4VGzv8JpIIF3F3misdJhRFXwF
	8sd+eAcgbUBvGE2lBKavSLUXUKbg/vTTfVVyXCKFBBfUUCRvBFsX3lzT+kq+16qvy1CJYr4+lCG
	O6ChwEbpX1gjBpof6nkpxjSjcAltS/XM35suKxRk96wA3YA1x/FHYLj2mV8ZawBJO/S4CNBPaJh
	yi6VPMAU5BHpbfFqzYX+HjUkP9i4
X-Google-Smtp-Source: AGHT+IF2w8g1ojnDyGQLFzRzdE61uNp4FTHmi/dw+D9zx9iGIJ1bDIJjlMRj6txF7f56YSZyhxHtxSGceOGnH7lmkQU=
X-Received: by 2002:a05:6e02:4714:b0:432:fbe2:3605 with SMTP id
 e9e14a558f8ab-432fbe23809mr44060065ab.11.1761804433543; Wed, 29 Oct 2025
 23:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014132106.181155-1-apatel@ventanamicro.com>
 <20251014132106.181155-2-apatel@ventanamicro.com> <012aaa39-a37b-e682-0e34-9b7d7cd87f75@kernel.org>
In-Reply-To: <012aaa39-a37b-e682-0e34-9b7d7cd87f75@kernel.org>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 30 Oct 2025 11:37:00 +0530
X-Gm-Features: AWmQ_bmMf5OoHFiUJY6zI6JVVcFsxCAmo8ACbrb1vAID1QwfAgdvKVsJ-cC2OvY
Message-ID: <CAAhSdy0iwq_ZPzFY5_x_wsbM_H+npSDVv1F=wP=O-_25VChh6Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
To: Paul Walmsley <pjw@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Nutty Liu <nutty.liu@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:35=E2=80=AFAM Paul Walmsley <pjw@kernel.org> wro=
te:
>
> Hi Anup,
>
> On Tue, 14 Oct 2025, Anup Patel wrote:
>
> > In RISC-V, there is no CSR read/write instruction which takes CSR
> > number via register so add common csr_read_num() and csr_write_num()
> > functions which allow accessing certain CSRs by passing CSR number
> > as parameter. These common functions will be first used by the
> > ACPI CPPC driver and RISC-V PMU driver.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Reviewed-by: Atish Patra <atishp@rivosinc.com>
> > Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
>
> This patch also (silently) removes the CSR number filtering, e.g.
>
> > diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> > index 42c1a9052470..fe491937ed25 100644
> > --- a/drivers/acpi/riscv/cppc.c
> > +++ b/drivers/acpi/riscv/cppc.c
> > @@ -65,24 +65,19 @@ static void sbi_cppc_write(void *write_data)
> >  static void cppc_ffh_csr_read(void *read_data)
> >  {
> >       struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)read_data;
> > +     int err;
> >
> > -     switch (data->reg) {
> > -     /* Support only TIME CSR for now */
> > -     case CSR_TIME:
> > -             data->ret.value =3D csr_read(CSR_TIME);
> > -             data->ret.error =3D 0;
> > -             break;
> > -     default:
> > -             data->ret.error =3D -EINVAL;
> > -             break;
> > -     }
>
> ... the above code, and:

The switch case is incomplete for cppc_ffh_csr_read().
Also, csr_read_num() already does appropriate filtering
so the switch case over here is now redundant.

>
> >  /*
> >   * Read the CSR of a corresponding counter.
> >   */
> >  unsigned long riscv_pmu_ctr_read_csr(unsigned long csr)
> >  {
> > -     if (csr < CSR_CYCLE || csr > CSR_HPMCOUNTER31H ||
> > -        (csr > CSR_HPMCOUNTER31 && csr < CSR_CYCLEH)) {
> > -             pr_err("Invalid performance counter csr %lx\n", csr);
> > -             return -EINVAL;
>
> ... the above code.
>
> I'm thinking that we probably want to keep the CSR number filtering code
> in; at least, I can't think of a good reason to remove it.  Care to add i=
t
> back in?

We can potentially have custom CSRs as hardware counters
hence the CSR filtering over here is already incomplete. Plus,
csr_read_num() already does the CSR filtering and returns
failure for inappropriate CSR number.

Regards,
Anup

