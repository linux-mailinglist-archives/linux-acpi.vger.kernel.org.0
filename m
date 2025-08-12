Return-Path: <linux-acpi+bounces-15602-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49631B225DA
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 13:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 428DC7B5923
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DE22E338D;
	Tue, 12 Aug 2025 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C9RFMPjQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614362EA47E
	for <linux-acpi@vger.kernel.org>; Tue, 12 Aug 2025 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997958; cv=none; b=jx+bFGw6xMnhFEglfRk+LBMRBCrPlXPBPVkI8YK9N+S7z51ue89nSdgoUPojmkatDZtNzCy/eZ7lWBmpG9lVxzSmMar0vbV7kWEZyjgWFoIHtP5+hKW889RoRbKjOGclMHiYZUY5No7hYcdvC+r4sXK0qsAUoGwKYcmI381SoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997958; c=relaxed/simple;
	bh=ZKKuolHihaGCQVn/G8GeT0Fv3Uj+qdXeNK7uItuc6nE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bMlAxT2TrDynYe6JU3Yb923nKGVHIxEMzh1V6f8BP3n2EQQrciCxwkXbSQpSfLN0TP8PvzG1REqTJpxorK7NQun4gMgLtbvgxyxRg/ORmZVWKqfbAO3b0mCniSplW9cy12W/n/iWdRHYSlfmHWsAMPwvcxWknnidNwrY51Duems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C9RFMPjQ; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4358a73e8a3so2920050b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Aug 2025 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754997955; x=1755602755; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qjfyf5ayYUQV/s7vBTZ8Nh9S9lY0mAPp0Jy1qKR37a4=;
        b=C9RFMPjQZB+x+5CCIGJW15+GJGwgSO2pCUB22WGAQ5qn1sResuds0qqZ/Ea+ouOgpG
         mhe26CxHS0jal328pzqUbVOsbaTg5Mp3k7+VVv7BvZBgO9uRDMpOROGEOOTzQKHR1PxF
         sFI009h3e1+A41OjVNaT3pAlPCsSi7VB6F9ILYgtbxaNsW72YQWihHbh4MHV2rJIPTaq
         ZdAtk52aEbYuRupIEEN1XpGVtnEYpGbD5gY0t/tCbut6hg80hXkWoFyVzfMQ3eU67l0C
         kRxN6QY2OIA5Ic5tGE0v7GgAkH9PFwFAmRAca8JDFZL/AoI3oI1teC/PgmjkxzUeLat5
         LoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754997955; x=1755602755;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qjfyf5ayYUQV/s7vBTZ8Nh9S9lY0mAPp0Jy1qKR37a4=;
        b=coXC1CGN/MkGbpqKnX/dYaH8obNf5ImiEXeyTy0BZHW/WIrFARkzUw9koawuB62Qfd
         ED8aOonP9gvVM1JXqcbdcn+OVzIxleKgA4ppJGwnvgZ5o7tZFiv2cLJlBCB2x5Dw2387
         mTTTGVdGII+kp/rn0Z9BbB5R+6r8FQBu2JNt3CQAnLESDB/YBwlqobTIStJpKmk+TW7B
         W2CcnrXZn/c1x6XMcXNp+9b0ZpFX1WyTEhikdRMhK98udVs1PYewmJ6cusZmU6e9T4A0
         5sDBcXU0sMzs7Ci5WdN7Gv/QVak1XiSEoRVMVwyqNEgJp3sUbB9e7nI3VkkGt/Nuf/72
         lgbg==
X-Forwarded-Encrypted: i=1; AJvYcCUr0DPmbj4I9FY2bGvnkwvUTqEmUAKHAGY/1no3MtRCrTRbOoZpxYtwuQhx2rrCX6jy/pXCBG801UMa@vger.kernel.org
X-Gm-Message-State: AOJu0YyEk250hZ9wdyvb2Eiq6LtzZ3g1PTN61J3X8DMYwggbEnPu5UZt
	VsyzCp75e7WGC4wsNqaq2+ucGWiTC6jp/mf741/5QQe9gLlJ7hbkdfWzIvfgPzXVtJICzSO1LvZ
	abaSrDyta/AEMnW47xbrqsfU095DriWEjhngEuMVAbw==
X-Gm-Gg: ASbGncsWqHHr1XfXoMJr41TCTuxj8vyDzAzA3njgid30nvdUP63LdO0RT8m/oXYYA0z
	/RDY+/oSyjHD6eNkvP+ZCf4P/bg9dETUFmpvv6yahjao+TkR9RTO+s7wiiNeanr7x/ZXvkPehnr
	gjk6hbJp01eIGVaZ+MVHaOwUrj+AnAb3015cGYTYJsiOEudVvSeaH46uEUXrV1dpEWqLvnn45wa
	TsBAdfJSqet8Kb0IzBWsY9d
X-Google-Smtp-Source: AGHT+IFcPYgbej7VXqBZ9l2ZGteq16uRDcRJtLkqmXUHtMhTcloMmWBdGKMKq/p/vubapwMbfjDcv+/odkkwRTeoq8c=
X-Received: by 2002:a05:6808:4f61:b0:41b:75ca:b104 with SMTP id
 5614622812f47-435c925f657mr1622625b6e.39.1754997955426; Tue, 12 Aug 2025
 04:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
In-Reply-To: <20250515094301.40016-1-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 12 Aug 2025 19:25:44 +0800
X-Gm-Features: Ac12FXzJhCUBUv-F1HNVERzz4bnGfTnGrmHS9y4FCCPn4eJYOe2JOvnJfPiVMIk
Message-ID: <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
To: sunilvl@ventanamicro.com, rafael@kernel.org, lenb@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,

On Thu, May 15, 2025 at 5:44=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> Add the read of CSR_CYCLE to cppc_ffh_csr_read() to fix the
> warning message: "CPPC Cpufreq: cppc_scale_freq_wokrfn: failed
> to read perf counters".
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  drivers/acpi/riscv/cppc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> index 4cdff387deff6..c1acaeb18eac3 100644
> --- a/drivers/acpi/riscv/cppc.c
> +++ b/drivers/acpi/riscv/cppc.c
> @@ -69,11 +69,14 @@ static void cppc_ffh_csr_read(void *read_data)
>         struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)read_data;
>
>         switch (data->reg) {
> -       /* Support only TIME CSR for now */
>         case CSR_TIME:
>                 data->ret.value =3D csr_read(CSR_TIME);
>                 data->ret.error =3D 0;
>                 break;
> +       case CSR_CYCLE:
> +               data->ret.value =3D csr_read(CSR_CYCLE);
> +               data->ret.error =3D 0;
> +               break;
>         default:
>                 data->ret.error =3D -EINVAL;
>                 break;
> --
> 2.39.2
>

The purpose of cppc_ffh_csr_read() is to calculate the actual
frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XXX.

CSR_XXX should be a reference clock and does not count during WFI
(Wait For Interrupt).

Similar solutions include: x86's aperf/mperf, and ARM64's AMU with
registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.

However, we know that CSR_TIME in the current code does count during
WFI. So, is this design unreasonable?

Should we consider proposing an extension to support such a dedicated
counter (a reference clock that does not count during WFI)? This way,
the value can be obtained directly in S-mode without trapping to
M-mode, especially since reading this counter is very frequent.

Thanks,
Yunhui

