Return-Path: <linux-acpi+bounces-17203-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E574B9259D
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 19:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD4557AB644
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BBB31195A;
	Mon, 22 Sep 2025 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lrj9Z2fx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374C1E32B7
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561013; cv=none; b=ZhrgzoVlRHn49oRg+vMnvuKCZ8w9Jl0/oO8C53fEXQPaioKifKnQp8QTSS7qGdjSxii1CjOlIy6DsqpNhjO+OnEuf2rRpvlAdRAaL6IX79IFxIbRgXGAE5z1uR/i8agWPCqXzwMBCZgFOACTM1IeOaTJ99uIImPv7Wt6O4PubNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561013; c=relaxed/simple;
	bh=LjfO8KQZ0pOYPVi6VN1I03sM/JgE4fiqagXrNbVWxZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FweCIPxr0tfeDjgsSe+1gfokQUwvq3LR57MJjzQl1tJ5LwSy/1YBxBicm95h7E5Ybb53eGU01lLLodNccQh9WVOjSOu4WyL1MQQzrhHB2vXyfGTZ6tRxvM6BDjD5R/TIFKFf7x/dfB9FzJK+gKSD4S/Dw0LeS+OK3l1RStQwqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lrj9Z2fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE68C19421
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758561013;
	bh=LjfO8KQZ0pOYPVi6VN1I03sM/JgE4fiqagXrNbVWxZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lrj9Z2fxus0EQD+OB8bJazR3ZDEcJSQZ18UQsQULqJ5Iq/2vZufMw5d4giGj7gNNa
	 pN5PYjh+13AUKIwXi2iTfzlanD897Sw+SFtyZrYMLvg2VzDJVDpElUWHtXpr49HdFC
	 MiRqsd8tPCaR8ldWVTFwqNPyLSwkvlErbo+t4SYAa+1WrlHlrbKd8hVbkR3rVRKQtM
	 N4QS7Pd+JeKbhZYawQnaK+jGr2G18cAqnI/tRMUWeR2LncyOvSm7TkirwKqPFVo2ug
	 zhFJr01QXTlmzN4mzXR5sHcjM+OnjjzaxKbYHituJStPbR+ud6HZp8MqMXf1k+1LTn
	 +3TEuGJxT22Eg==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74526ca79beso4038768a34.0
        for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 10:10:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+KtSKZskhwNG6XRfnx8dnd9tLKH8utNWT33vEMkISuCO5aUynHAvF6mY7rri39mIYZ5qvCniL0wtw@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPc3hSgUymHbxFqW1K/BchW4SyE0XVzzlXYwfJ8cx29j0lbIs
	GzAa7X1iR5BTEQ9lkvLVVy254zCSly/EzYSnIBArMwBdk3gr1DkmyCv3ThPQsxBfHsgt4qGSnV8
	81tNRP/i0p0+s6QodBI3XOk1qhKT0pCg=
X-Google-Smtp-Source: AGHT+IEQgrPHe32vZeMLsnLLopfoaTVSCbgyw3/FvnA92tK1XG9E0pwJSaFqOTcNR67lm0Y9z3GITnD3dGbnCFY+o04=
X-Received: by 2002:a05:6830:611a:b0:756:a322:2f8 with SMTP id
 46e09a7af769-76f6e58e005mr8523341a34.5.1758561012535; Mon, 22 Sep 2025
 10:10:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922082833.2038905-1-maz@kernel.org> <20250922082833.2038905-3-maz@kernel.org>
In-Reply-To: <20250922082833.2038905-3-maz@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Sep 2025 19:10:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jPdvdTUWqW1OEkLUSrucifEQxmKjEn2H5Xp4g_4q_+Gw@mail.gmail.com>
X-Gm-Features: AS18NWB5qQhnXhcfR4zq93qjbiiurDZoCQiEBrfaJ7614-vzCAHGIWYi6x8OUsg
Message-ID: <CAJZ5v0jPdvdTUWqW1OEkLUSrucifEQxmKjEn2H5Xp4g_4q_+Gw@mail.gmail.com>
Subject: Re: [PATCH v3 02/26] ACPI: irq: Add IRQ affinity reporting interface
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 10:28=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> Plug the irq_populate_fwspec_info() helper into the ACPI layer
> to offer an IRQ affinity reporting function. This is currently
> only supported for the CONFIG_ACPI_GENERIC_GSI configurations,
> but could later be extended to legacy architectures if necessary.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/acpi/irq.c   | 19 +++++++++++++++++++
>  include/linux/acpi.h |  7 +++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index 76a856c32c4d0..d1595156c86a4 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -300,6 +300,25 @@ int acpi_irq_get(acpi_handle handle, unsigned int in=
dex, struct resource *res)
>  }
>  EXPORT_SYMBOL_GPL(acpi_irq_get);
>
> +const struct cpumask *acpi_irq_get_affinity(acpi_handle handle,
> +                                           unsigned int index)
> +{
> +       struct irq_fwspec_info info;
> +       struct irq_fwspec fwspec;
> +       unsigned long flags;
> +
> +       if (acpi_irq_parse_one(handle, index, &fwspec, &flags))
> +               return NULL;
> +
> +       if (irq_populate_fwspec_info(&fwspec, &info))
> +               return NULL;
> +
> +       if (!(info.flags & IRQ_FWSPEC_INFO_AFFINITY_VALID))
> +               return NULL;
> +
> +       return info.affinity;
> +}
> +
>  /**
>   * acpi_set_irq_model - Setup the GSI irqdomain information
>   * @model: the value assigned to acpi_irq_model
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 1c5bb1e887cd1..c506ae4bacc86 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1509,12 +1509,19 @@ static inline int acpi_parse_spcr(bool enable_ear=
lycon, bool enable_console)
>
>  #if IS_ENABLED(CONFIG_ACPI_GENERIC_GSI)
>  int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource=
 *res);
> +const struct cpumask *acpi_irq_get_affinity(acpi_handle handle,
> +                                           unsigned int index);
>  #else
>  static inline
>  int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource=
 *res)
>  {
>         return -EINVAL;
>  }
> +static inline const struct cpumask *acpi_irq_get_affinity(acpi_handle ha=
ndle,
> +                                                         unsigned int in=
dex)
> +{
> +       return NULL;
> +}
>  #endif
>
>  #ifdef CONFIG_ACPI_LPIT
> --
> 2.47.3
>

