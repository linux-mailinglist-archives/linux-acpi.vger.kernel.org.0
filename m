Return-Path: <linux-acpi+bounces-408-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFD17B7D33
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 12:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 61A3C1C208A3
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C3101FA
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 10:32:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66913A21
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 08:38:29 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75AAA7
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 01:38:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso148657566b.0
        for <linux-acpi@vger.kernel.org>; Wed, 04 Oct 2023 01:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696408705; x=1697013505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ppi0kBeOOweWlIZvfD7YuBHhh55A/ApHochAVYW2CEw=;
        b=DZu3xWC0dGADpy2d2SQk/KbZlvFm28HlFENrQHWyYgt2oyrDq5kK9zghnMYHzFjB20
         oFbprDeYsUy3Y5eH3qFujLJHRneosy1BdAnlPh24m7GvNdYvmJ3QEeoV+hfFBLWie1rD
         3owu0FRwoCOygjDCbGTowmYWaB1G2Q36Et+Bminem+Qq+c/3zLEht5ItwbFNV5Hp+bav
         rI4qn9u2UkQnk8KCbz7ng8ER1V6T4geNYVeZCQ2dcikKUIWq6E6WIUQ1j+33yRHosjKu
         zJ3wasUB1FoDCjpOsvE4b+9DFm0R/wI5DOHoMhzW1TKMH41zUnCkGnX4fehcpv3jhsr1
         irJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696408705; x=1697013505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppi0kBeOOweWlIZvfD7YuBHhh55A/ApHochAVYW2CEw=;
        b=kP3dBPFMTw2L+ZW7I64/dvLBgcOB9fXx+OvkXoc2a9GBcXGR8fF01OB0Iwqqe6tcO0
         11ZYmnkeZbqx7m1K/NaAZHmqjF5jZX/g1X9Kvv02HSOsmy2F3tJJw8nxv10iNxixrEwE
         uNaXEgJsSMwVSmbHg43bbcRIgFL3Oh6yXhXKBqLzVGWQsSTB3jWdK7EhwE0iOI/ublTB
         08ngfvNn33Aec9UqJr2cWZgcOqTIB2eAuVLWNY5E9xSF0HuZIiGJUC1uy3+tpS5ZMA/Z
         PTf5UUtVN0Y3lzYaigbbyx6yj7BdjiB2PABEQVJcbGqIbxLX9uoxd2d1YBRl+Ul06mJW
         Uhvg==
X-Gm-Message-State: AOJu0YyuwHE4+hkBVxNE0nXkA8cmLUl5OAosa4dVCnBHFdTOes9RzQAg
	TKTEecv5Tx9cms2sg3XW6hjbJg==
X-Google-Smtp-Source: AGHT+IEA0c4Rpr5fzXgEfRIFNS4InULkII64T3I3f9QRr7CnzN0XoS/8hb8DDlG5hrg2dBx+Uq8JWg==
X-Received: by 2002:a17:906:dac1:b0:9ae:705a:8451 with SMTP id xi1-20020a170906dac100b009ae705a8451mr4692777ejb.25.1696408704565;
        Wed, 04 Oct 2023 01:38:24 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id f21-20020a170906561500b009ad87fd4e65sm2369666ejq.108.2023.10.04.01.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:38:24 -0700 (PDT)
Date: Wed, 4 Oct 2023 10:38:22 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Conor Dooley <conor.dooley@microchip.com>, Anup Patel <apatel@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v2 -next 4/4] clocksource/timer-riscv: ACPI: Add
 timer_cannot_wakeup_cpu
Message-ID: <20231004-4fb4dad9268b0c933550a21e@orel>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-5-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927170015.295232-5-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 10:30:15PM +0530, Sunil V L wrote:
> The timer capability to wakeup the cpu irrespective of its idle state is
> provided by the flag in RHCT. Update the timer code to set this flag.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/clocksource/timer-riscv.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 9c8f3e2decc2..06f5bad3c3e0 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -225,6 +225,10 @@ TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
>  #ifdef CONFIG_ACPI
>  static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
>  {
> +	struct acpi_table_rhct *rhct = (struct acpi_table_rhct *)table;
> +
> +	riscv_timer_cannot_wake_cpu = rhct->flags & ACPI_RHCT_TIMER_CANNOT_WAKEUP_CPU;
> +
>  	return riscv_timer_init_common();
>  }
>  
> -- 
> 2.39.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

