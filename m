Return-Path: <linux-acpi+bounces-2849-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4858C82D3CD
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 06:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1211C20FFA
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 05:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190E02566;
	Mon, 15 Jan 2024 05:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Yk1qcEGn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B9D20F4
	for <linux-acpi@vger.kernel.org>; Mon, 15 Jan 2024 05:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3e05abcaeso53928715ad.1
        for <linux-acpi@vger.kernel.org>; Sun, 14 Jan 2024 21:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705295241; x=1705900041; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w2DMZrv/vftTV3/CK2PgvRDBQKFQBwMoQcf1arJiP6I=;
        b=Yk1qcEGnyZNKu9O4dhWY2MKN3MAzKjIjvGNuCQaAei+vLSBruoJabj2pemft+gUHlw
         MHU09xyZludveG1X39bq4a4yxvIFQwKejd/NoDfnKnAfuTy0SqlCDKaZyw1VJ1y3lxi3
         C1Q+GelO4GSnfi2SPxMDksOekuNZ5sCcEBD/OE3j/P+Wob6NcV8M8DSMRGLyI1Fg15+S
         JZeDFs97jW46r0544q9j1eyHb25XhxmaYZNr3aF7ms9UgRQK/P+wf+xM16l/Y6kv7ZId
         7lcmyEn3bcYOWEv6vhp4WZQLZ80pplVhTNs6A0QNWeXN8xSSpRYsXYD+z/DF0CnqwjjB
         Hu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705295241; x=1705900041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2DMZrv/vftTV3/CK2PgvRDBQKFQBwMoQcf1arJiP6I=;
        b=REnxL9z9obplqVpipfbDizTazOSTnwqqntVvT8ObvVu3pG4mu79OaPMbTirfB2ADyZ
         ymbxbXS+WCp72mlXpZi/0ZKf1Pmx0aaABFWFkXLUUu+JSr+C57KPdKBfyw6SXuLrm3eu
         /22isWfDibiKAIoj/52fsql/j1oL4pesnZF4Bvht0d6D12WY9WlF+i1QCxf48F8BEP8D
         pydiod0yZv65HS/SjdFRa+Z92F1viJCE6Egn0XJmjhF3TCudrGvUTwfKMwBY2dSXDJ/2
         LADZYcnI6aFCBKFMkoCsRRc52SS14YIq5oQ+dGqnTJ9BFcGVx+JM0GGe0EGlg4akpeT0
         K7Ig==
X-Gm-Message-State: AOJu0YzX9UbwsZUnesRVZyx2w990GXv7xi6IdK2P/Nzl1ozcnxFmU0c1
	Rp+ZB3BaTd4o7FYxxeeIsCDya5QhmJ5zJQ==
X-Google-Smtp-Source: AGHT+IEvzxpRVFQLh9OO7fdUTY/2UwLLDyRzSULhO6pjToVkFQ3zpRcC/wUy3kWXKGuh6/R/Edr8Xw==
X-Received: by 2002:a17:903:1209:b0:1d5:8a8d:83be with SMTP id l9-20020a170903120900b001d58a8d83bemr2457583plh.16.1705295241182;
        Sun, 14 Jan 2024 21:07:21 -0800 (PST)
Received: from sunil-laptop ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id lw8-20020a1709032ac800b001d06b63bb98sm6806351plb.71.2024.01.14.21.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 21:07:20 -0800 (PST)
Date: Mon, 15 Jan 2024 10:37:13 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Anup Patel <anup@brainfault.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH -next 2/2] cpuidle: RISC-V: Add ACPI LPI support
Message-ID: <ZaS9gQS4fURoiffV@sunil-laptop>
References: <20240111093058.121838-1-sunilvl@ventanamicro.com>
 <20240111093058.121838-3-sunilvl@ventanamicro.com>
 <CAAhSdy22JrFOS8V-FC=ZCQiybhcJCszxy_TsnGAzuzYA06Mw7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy22JrFOS8V-FC=ZCQiybhcJCszxy_TsnGAzuzYA06Mw7Q@mail.gmail.com>

On Fri, Jan 12, 2024 at 10:35:07AM +0530, Anup Patel wrote:
> On Thu, Jan 11, 2024 at 3:01 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > Add required callbacks to support Low Power Idle (LPI) on ACPI based
> > RISC-V platforms.
> >
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  drivers/cpuidle/cpuidle-riscv-sbi.c | 78 +++++++++++++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >
> > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > index e8094fc92491..cea67a54ab39 100644
> > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > @@ -632,3 +632,81 @@ static int __init sbi_cpuidle_init(void)
> >         return 0;
> >  }
> >  device_initcall(sbi_cpuidle_init);
> > +
> > +#ifdef CONFIG_ACPI_PROCESSOR_IDLE
> > +
> > +#include <linux/acpi.h>
> > +#include <acpi/processor.h>
> > +
> > +#define RISCV_FFH_LPI_TYPE_MASK                0x1000000000000000ULL
> > +#define RISCV_FFH_LPI_RSVD_MASK                0x0FFFFFFF00000000ULL
> > +
> > +static int acpi_cpu_init_idle(unsigned int cpu)
> > +{
> > +       int i;
> > +       struct acpi_lpi_state *lpi;
> > +       struct acpi_processor *pr = per_cpu(processors, cpu);
> > +
> > +       if (unlikely(!pr || !pr->flags.has_lpi))
> > +               return -EINVAL;
> > +
> > +       /*
> > +        * The SBI HSM suspend function is only available when:
> > +        * 1) SBI version is 0.3 or higher
> > +        * 2) SBI HSM extension is available
> > +        */
> > +       if (sbi_spec_version < sbi_mk_version(0, 3) ||
> > +           !sbi_probe_extension(SBI_EXT_HSM)) {
> > +               pr_warn("HSM suspend not available\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (pr->power.count <= 1)
> > +               return -ENODEV;
> > +
> > +       for (i = 1; i < pr->power.count; i++) {
> > +               u32 state;
> > +
> > +               lpi = &pr->power.lpi_states[i];
> > +
> > +               /* Validate Entry Method as per FFH spec.
> > +                * bits[63:60] should be 0x1
> > +                * bits[59:32] should be 0x0
> > +                * bits[31:0] represent a SBI power_state
> > +                */
> > +               if (!(lpi->address & RISCV_FFH_LPI_TYPE_MASK) ||
> > +                   (lpi->address & RISCV_FFH_LPI_RSVD_MASK)) {
> > +                       pr_warn("Invalid LPI entry method %#llx\n", lpi->address);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               state = lpi->address;
> > +               if (!sbi_suspend_state_is_valid(state)) {
> > +                       pr_warn("Invalid SBI power state %#x\n", state);
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +int acpi_processor_ffh_lpi_probe(unsigned int cpu)
> > +{
> > +       return acpi_cpu_init_idle(cpu);
> > +}
> > +
> > +int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
> > +{
> > +       u32 state = lpi->address;
> > +
> > +       if (state & SBI_HSM_SUSP_NON_RET_BIT)
> > +               return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend,
> > +                                                  lpi->index,
> > +                                                  state);
> > +       else
> > +               return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(sbi_suspend,
> > +                                                            lpi->index,
> > +                                                            state);
> > +}
> > +
> > +#endif
> 
> Lets keep the cpuidle-riscv-sbi.c driver focused on DT only. Instead,
> I would suggest moving the required function from cpuidle-riscv-sbi.c
> to arch/riscv and have a separate driver under driver/acpi/riscv for
> LPI states.
> 
Okay, sure. Let me send v2 with your suggestion.

Thanks,
Sunil

