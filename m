Return-Path: <linux-acpi+bounces-6518-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8AC90E97D
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 13:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2384C2854E0
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 11:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A9E13B583;
	Wed, 19 Jun 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LWkC4J/i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C666763FD
	for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796751; cv=none; b=aCi35FRYTslE0FDqfD3OFhI6YOV1jzil4ypkFbP8+oGx/tjBpPwa/ztMo4Iy0fKGvmJJpg5QXOyQjV9hWZ0UuKTokEESXOYpq+cFMWq16/cq2zCxgoSSVtB5ch92Q0A4OqPAN+Mz+XsBEplk16xUk2KwrEUVS7O2epq2W7I1NB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796751; c=relaxed/simple;
	bh=ep+bcQ9KIBL3Ur4LJps7I1N9rQ6T3o1g4+RjR962b+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SxQM5GBmIs7KtfVbpckxFPMDWrCPtRNBbrDToNtbZcf0Jv4USmc6/P6V5rU+XEJlGh/WmjrHUmm7Ll4xaUazWWKQUOzin0qf6R7NYa0PoipsVu/gStIoFaKXjmlRd+JQ6P/EdCCjHKlJ4CVucEO2mnOH5ta+HnMuotxEQCBFxeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LWkC4J/i; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25caf76158cso4970fac.0
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 04:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718796749; x=1719401549; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pWZByJHXQuXqyJwb/jU6Cx4D/ezIf4+3nq/sxOvdo4=;
        b=LWkC4J/iXumglmKU/NFNi1MwfKSKj4b7vm3Ji/h+MbXZsEnRg1GV2cP8erBxpTQN3H
         ztsdrHCyTHvMdnYd0g0N13U2zjDAHXbqQ6GV17qGKIkbjOxxawZh81pGFRG6liQh0HDN
         XhagqEOwcjQojBgAcAyS6P8T9NzXapi9NWQWy48FHYt6yUZj4hXVVQ+R+bI4Hgz1VZ/q
         r08G9wPAiA5Hg/oYHfGy1sE3mB2ieESzl8+KsPMvaM3Qm0KDiqeNw+/IIh3UHAhGJp1l
         xKEw1WgQ4faaRFwOKbQ7vLIu1jpGmV+MvaRycpWy1FKA83Hx2J4FOYqgX6bD2wSKU4s0
         QQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718796749; x=1719401549;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pWZByJHXQuXqyJwb/jU6Cx4D/ezIf4+3nq/sxOvdo4=;
        b=j/7AdusqF4kO01v/0MVDthIuMxq9IxIU72H5A3hJiWyY+jZtwTlYUGhhbLPXlyzQTF
         3Kfy6lAIValV1fvQgYRQZnCuG93sftWeFtQW2bIcwBnyq9CnHmZMA7F1bXdsbJPdW9wu
         vGQ1Nx8gHaFphnCkY4xEKcatXPrWN1QKIaCQzrwwCoVqo6q2hd4qgevpCZ2imqXjL3xH
         TZ/WKERvTfCPpZo4e6alnfYGxGQ/yJPlcxNyjkdU23mubW4NQlS1f3orfS5jKdZGevP/
         tI6tyYDoqE4CzYSdp4MVDwnlF7E3jTdwHKbFHphmzvn/xFyBgIonPoMlXAOrYo9XMC4f
         FchA==
X-Forwarded-Encrypted: i=1; AJvYcCVDXmF41pFqAusrteTqn1ScMB7VCsQCRYEDUhI8jnFojqP5PpGnq1JsR5MSJuw55pZytmYNsWW3vLkd2wNqFSwhSsO/qajLGoI0GA==
X-Gm-Message-State: AOJu0Yw1Wa2wiAgrEI88hg3uBHm/pl39z3uKdJdwIiQhLtiWZXqDEgDa
	gZPc23H708IWPM4qH+KWeKEntMuYKCM0S7cdLG+NUpx25nueG/rNmFCVJKsc9C5OjMxOClYEdJ8
	YIrRdph7zi7KJegzYscNDOVBCoiJ/2q6LWwYyMw==
X-Google-Smtp-Source: AGHT+IFDTJPJUvt5MDx8yXoy50LjAmUvtMJn2QjJIM1rsP4eAxrwxGqnbfFwaWVFBzqTW1RnUYiLxwgToBAi2U6CAmM=
X-Received: by 2002:a05:6870:c0ce:b0:254:783d:aeb4 with SMTP id
 586e51a60fabf-25c94ade8d7mr2582738fac.35.1718796749303; Wed, 19 Jun 2024
 04:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617131425.7526-1-cuiyunhui@bytedance.com> <20240617131425.7526-3-cuiyunhui@bytedance.com>
In-Reply-To: <20240617131425.7526-3-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 19 Jun 2024 19:32:18 +0800
Message-ID: <CAEEQ3wnkQsfmLbyMrG_YBvWvhHJdSTg7dG5W_mxv_wxCjatgCA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] RISC-V: Select ACPI PPTT drivers
To: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	sunilvl@ventanamicro.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, bhelgaas@google.com, james.morse@arm.com, 
	jeremy.linton@arm.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, 
	sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,

On Mon, Jun 17, 2024 at 9:14=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> After adding ACPI support to populate_cache_leaves(), RISC-V can build
> cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
> configuration.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 9f38a5ecbee3..1b4c310a59fb 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -13,6 +13,7 @@ config 32BIT
>  config RISCV
>         def_bool y
>         select ACPI_GENERIC_GSI if ACPI
> +       select ACPI_PPTT if ACPI
>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>         select ARCH_DMA_DEFAULT_COHERENT
>         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATIO=
N
> --
> 2.20.1
>

Gentle ping.

Thanks,
Yunhui

