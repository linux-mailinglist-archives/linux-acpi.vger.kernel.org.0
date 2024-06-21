Return-Path: <linux-acpi+bounces-6582-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E7F912EEB
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 22:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C145D1F22B3C
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 20:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444BF17BB37;
	Fri, 21 Jun 2024 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asThEooi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0A817BB2C
	for <linux-acpi@vger.kernel.org>; Fri, 21 Jun 2024 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003119; cv=none; b=CxB/Isq0n6j0bSLACrLkR6oBnjJ0nVE/eYy6Zs+pxhmHUBWrxL+tOQ2hothcLXC/u4w0O4qIqUuuSEU8vXXtQ1UcQ2V0nStC4p91YsM7tD9gjziP5J8wiBEP03Ew6Z7B2CE5gVw4hn219FFAV1nYPYujWXE430p8bs8W8r3etFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003119; c=relaxed/simple;
	bh=Oh3fHeV4znlvxEw6zOAQuavyv3NjqYzTMJ90QD3QnrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ1xiHdDFPKghWlYZpsw5Ydqw1XLg9u9+v/Orp+czf2M9S7chvpkAHl7Dny9EN1dF3nqpJEMzppKeHVLNdWv+hBw1+b3AlYa0yUMdfTRW9G3nLPyE6aYn600Nrs+om2zN2CpKKqFa61YfmdCR1JitLNDxrt2m0tMhDhO4wz7MFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asThEooi; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44056f72257so537891cf.0
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jun 2024 13:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719003115; x=1719607915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lArdc/1wZ6cGMV0ZmDn9MYnxqrFzIsvvBqrD/IAOOXM=;
        b=asThEooimGIB6lT3goXLdKHmwSc/SexKaLdfRQ89jrkN2j7W2kdBbo6Cq8EqTJeXv3
         JJrv1GebWy6p+I6zmr4lWjudBJYQ/uKXP1veHlItPqcqzJXAzCzKKBdD3s+cyD5pVHa7
         1cO5wO0kusRMpB5yrV8GcNbZBmvuDp0eUi3L+K2brgvLvougSmhfnY0rMMVEEP1iXzhV
         LrJ7NdScLT0Ebak/MqjSF4tD6+xM6Voaa+0qt6sVPLCueBN5acqcxn5OaSx71MAVNY+C
         FfMGhv9rDe/wSq3+YCmB+gq/k1SZimdwns9C30ZCzf72qqT8eH+5B6auKTaQXcxAdo30
         TaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003115; x=1719607915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lArdc/1wZ6cGMV0ZmDn9MYnxqrFzIsvvBqrD/IAOOXM=;
        b=nfZJJ9VDWn4m/85cIFJjCUbSKwt51bZmy42G0zb2uj7WumSrba6wp8GwBOu+OQc43y
         i6L+LnDQSPlAyMxT+/DMNl7eQqEZFbfV56dWsVVlr8F6b+0l0FijKwXUQYHapvtCACFV
         B2zyT5I4Ia+b2zvb6XGYQmB3bCvss67aV7YMQnFnLQcZIl279ZoalhFLF7/iulRmeJxM
         GCLc3yO/SAk+XgSt4vSVbTnxt2h9xj+TiQZyHyvCvLsDCU/4FWvhtl7/RcW22LylArQg
         wJbtLaUE+K9xOzZ18hUmClPq0SzKDr9n97f7W4d+nnh6e46i3QaVBGsKGrqxWy0ivpCs
         cdjw==
X-Forwarded-Encrypted: i=1; AJvYcCVl4XhdUGYdHg8wzNeMrKaPu9Cg8pRG3J549uM1cak5oCnHMtwliaDQvu5XIBkXZyDHUrWDM1VXYsdRB8IaZzVcFwQO/RUK0Pza/g==
X-Gm-Message-State: AOJu0YxsqOdYpbLQ6YXHTWCd6mm5ryU2e1WSDKWwDpyvUaQokN4RtBxz
	UUOEDpIUQ4y7BWIlmxHeHyaEZZfqAMR7afsthAXlALdFF2BGLk6ug/KtTTnhmFIWrPg0D2lnwk+
	/+QVin3K1o+4u5mMa4dnOFNHFH1/QdtUsarUJ
X-Google-Smtp-Source: AGHT+IH5yoYBlppb4JsqH83QVq/VXvffOxaxcg76w1huEHrI0GcDKG80KYq2O785kln/S9G/4ZJBzT5QZpUnTZkr5kA=
X-Received: by 2002:a05:622a:1a01:b0:444:92a6:188a with SMTP id
 d75a77b69052e-444ce2be63dmr496101cf.9.1719003115301; Fri, 21 Jun 2024
 13:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718994350.git.robin.murphy@arm.com>
In-Reply-To: <cover.1718994350.git.robin.murphy@arm.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 21 Jun 2024 22:51:16 +0200
Message-ID: <CAGETcx-nBb43181Rd4HC6HQF-6=XOufA05e8Zda+LBBfhwvagw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] iommu: Remove iommu_fwspec ops
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 8:46=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> v1: https://lore.kernel.org/linux-iommu/cover.1713523251.git.robin.murphy=
@arm.com
>
> Hi all,
>
> Here's v2 of this little cleanup, with acks and the additional cosmetic
> tweak suggested by Andy. There were some slightly non-trivial changes in
> the rebase so I've left off Jean-Philippe's tested-by from v1, but I've
> given it a quick spin on arm64 ACPI and DT and all seems well still.

Hi Robin,

I see in this series you talk about figuring out if a device has a
driver that could match. There has been a "can_match" flag in every
device that's set if a driver that match it is present, but hasn't
probed the device yet (for whatever reason). Just pointing that out in
case that makes things a lot easier for you. As of now, we don't
handle clearing it when the driver is unregistered, but if that really
needs to be handled, that shouldn't be too difficult.

-Saravana

>
> Thanks,
> Robin.
>
>
> Robin Murphy (4):
>   iommu: Resolve fwspec ops automatically
>   ACPI: Retire acpi_iommu_fwspec_ops()
>   OF: Simplify of_iommu_configure()
>   iommu: Remove iommu_fwspec ops
>
>  drivers/acpi/arm64/iort.c             | 19 +++-------
>  drivers/acpi/scan.c                   | 36 +++++--------------
>  drivers/acpi/viot.c                   | 11 ++----
>  drivers/iommu/arm/arm-smmu/arm-smmu.c |  3 +-
>  drivers/iommu/iommu-priv.h            |  7 ++++
>  drivers/iommu/iommu.c                 | 20 +++++------
>  drivers/iommu/mtk_iommu_v1.c          |  2 +-
>  drivers/iommu/of_iommu.c              | 50 ++++++++++-----------------
>  drivers/iommu/tegra-smmu.c            |  2 +-
>  drivers/of/device.c                   | 30 ++++++----------
>  include/acpi/acpi_bus.h               |  3 +-
>  include/linux/iommu.h                 | 15 ++------
>  12 files changed, 65 insertions(+), 133 deletions(-)
>
> --
> 2.39.2.101.g768bb238c484.dirty
>

