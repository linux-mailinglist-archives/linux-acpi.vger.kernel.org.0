Return-Path: <linux-acpi+bounces-17052-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3138BB5A247
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 22:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C867F1C01CA3
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15A52E5B26;
	Tue, 16 Sep 2025 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIjFwBUT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4042E54B9
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054137; cv=none; b=YzSY4Zokus97kZmZB16uTqDhQKeUDoNNyYESsl9vSxuGOLtHjjf6zu6H0Zdd5nmgvrYSIlYoFDeqQ0kZ3AEp+7xayKMWsnz4MXETtr2t9j4q2hwRRwY4dMcoyzfkfGpzzqaxP7mXwUwSpLH2ItPL0VxvFeJa9UE2haZvzNC/X3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054137; c=relaxed/simple;
	bh=+FJQmiQCgxY7sOvQwGKfrvsmjgtJg5wgc2QTdK97nhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYxGQjCvxzs7MeC02WL9sLtsmHQ9N4bi83p6Hxaywyr66HS0ex6SOCF+Xy2Ar53HqApg/VerjVZR8ZT8tNVI8KdUl5GaDj3VWqrJNt7brhYQ/8Ef2AGRqxUgUCOk1EeQpP3jULBp4HjGOKOfNeLLuzW7aG2NGPwsHUpfing5PZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIjFwBUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C69C4CEFE
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 20:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054137;
	bh=+FJQmiQCgxY7sOvQwGKfrvsmjgtJg5wgc2QTdK97nhQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RIjFwBUTXKC8Y3+AFHMJ0zm5cb5MUddjdmG1BG11kjSBmvFCqgItaZpYvDK4j3YHt
	 vaKcJVXfUq7oGwyAUfprSn0PUFb/DN7gX5Olz9pg2ILLf+msr124lt7AFLPW3GWomw
	 263bMRPV36Yy3s9irnNm8M1ItDXdrIMZ2jrK147X91zTCWuq0WJPjvMZpcLyC8Wv8Y
	 vIif5IKnhAwaaN4KqrQh453sl90f4NQbo8RM2whwbEXZuSocR+E8Lcd/rDyis2wfQ/
	 wQ0TvoKLH1SvLb3hg0o8SCvu5YnuVuOb+f+qCPIpNsZBtq5sEdtzyL4/gcY4V34uGS
	 Iia55Qh92cS2w==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cce8c3afaso4202705fac.1
        for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 13:22:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6fV0cyHKOWpkK7HrY7UjJdV/z7f/5/4DBcf+5Fv/40pu6b6TbFIkwFqUUiTPvFZIco0iFl25HabWI@vger.kernel.org
X-Gm-Message-State: AOJu0YzpTkNOG17kOyn9mDHaLTHLzZFbZ7HRJAuVWXCCQtAISNAXjkcq
	paWJyqtIEihhZNFCweHXxcJIZ3216OxYJE8PArwbWNmn6x9K2I+UqBPB2AvApv/lTth8pWpV3q/
	uMNvnLzPfxQG/RILFYXx7Cq99KU2dG9M=
X-Google-Smtp-Source: AGHT+IE4GuINxn6KeymGNXiv8yoxTzmxDq9RFoRe6QSRidCuJxZgzLUb2/Dx/V+3pgU6QgPZMLX1DGU4nkzEM2WLvqs=
X-Received: by 2002:a05:6808:6714:b0:437:b63f:5b06 with SMTP id
 5614622812f47-43b8da457b5mr9660818b6e.34.1758054136675; Tue, 16 Sep 2025
 13:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911112408.1668431-1-lihuisong@huawei.com> <20250911112408.1668431-2-lihuisong@huawei.com>
In-Reply-To: <20250911112408.1668431-2-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Sep 2025 22:22:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iwRzbQAFmTEkq=rMeC_hjr9DAHEGbtBfgL8AU6M5PPqg@mail.gmail.com>
X-Gm-Features: AS18NWA1kpyvkrHchUq03J9nNSLxliJNbA1jW1cK_l0W8YEIPCdvhRuzFO31tSI
Message-ID: <CAJZ5v0iwRzbQAFmTEkq=rMeC_hjr9DAHEGbtBfgL8AU6M5PPqg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ACPI: processor: Remove unused empty function
 definition for processor_idle.c
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 1:24=E2=80=AFPM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> If CONFIG_ACPI_PROCESSOR=3Dn and CONFIG_ACPI_PROCESSOR_IDLE=3Dn,
> we may encounter some warnings about function defined but not
> used. All external functions of processor_idle.c are just used
> in processor_driver.c. And if CONFIG_ACPI_PROCESSOR is selected
> and CONFIG_ACPI_PROCESSOR_IDLE also be selected automatically.
> So remove these empty function definitions.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  include/acpi/processor.h | 20 --------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index ff864c1cee3a..2976a6d0c54f 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -425,26 +425,6 @@ int acpi_processor_power_state_has_changed(struct ac=
pi_processor *pr);
>  int acpi_processor_hotplug(struct acpi_processor *pr);
>  void acpi_processor_register_idle_driver(void);
>  void acpi_processor_unregister_idle_driver(void);
> -#else
> -static inline int acpi_processor_power_init(struct acpi_processor *pr)
> -{
> -       return -ENODEV;
> -}
> -
> -static inline int acpi_processor_power_exit(struct acpi_processor *pr)
> -{
> -       return -ENODEV;
> -}
> -
> -static inline int acpi_processor_power_state_has_changed(struct acpi_pro=
cessor *pr)
> -{
> -       return -ENODEV;
> -}
> -
> -static inline int acpi_processor_hotplug(struct acpi_processor *pr)
> -{
> -       return -ENODEV;
> -}
>  #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
>
>  /* in processor_thermal.c */
> --

Applied as 6.18 material under adjusted subject and with a new
changelog, thanks!

