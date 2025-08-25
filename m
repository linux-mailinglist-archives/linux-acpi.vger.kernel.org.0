Return-Path: <linux-acpi+bounces-16049-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EB7B34A48
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 20:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C1B18919F7
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3693125A2B5;
	Mon, 25 Aug 2025 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+UVO2XC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1263A1DE2AD
	for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146187; cv=none; b=f8ko+gjj93ratQIWuoAXmkGn3i9r+QuznU+/fNpecirLaQbF5l2ZfIaKjQvj6+sOHOUaCjeTSj2Z7PHLGKI3sTGIeF3/vx2NlnmuIkrB8LoSxvmWn5ut3gmClo2DkEURkNIRDXV8k8ayg5QrVLH++aCGVKhrYMDmBSUhwPuQsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146187; c=relaxed/simple;
	bh=iSMcoZ4atfJaIXhnMbeC3f7/SSxgkpEllz9vNNn5qqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJjnpeFT+Agy2oqFkoc8f8TeMVS/Kcz47yNRcy2P0SbulxE+Sj4Y+Jfcy0wmQ6nM58anog2UUgvGusnbknRQKQVcSVrmiW4xB/Vj9/+symA2kt/FkEMjJHIKGOGT2MxjKMDxIe+Nkf/S9tbxXKm/M1Qkc1gIhgSR9+5zk+sGoaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+UVO2XC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9991DC4CEED
	for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756146186;
	bh=iSMcoZ4atfJaIXhnMbeC3f7/SSxgkpEllz9vNNn5qqU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N+UVO2XCke5B5QTgNTm+m+NhjE2HuZkz3565kVuccxrhkyBqq1VOYjVyFBlToeTKF
	 JkgSHOCetXHHFDVS8aIhR/26VBo2qFNgXACFflrkk4Li8FLLOumpmR1Rgs/TpnkGr4
	 7563BO9GjPWcAwAngpmgt4eh6wfg2cwzVuim8ARrirJFbJ+Se5cpl3vkv8vJ2D9i64
	 i/WyWqjb0db0ixxtAKfKixQYREln9eyJMq8JfFhOUIAquJN0VUBiyjtixI8x9ZgNV7
	 a1FvBmp8LN/4cy6Y8cR/xjUZcfcfAfFj2Nf9VUdU6St/DzaWVSW6QQXPqUi+1XGYRb
	 iDsyBXJDx2dXA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cce8c3afaso2961381fac.1
        for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 11:23:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3lPFwOaFbDVNceXE3+rtGPEUNcLDBznRH8eI8nuiXM+an3z3IEBNIie5AMDT8I3t7wHhh1MbfNqYj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5SDkk7fSH4Ehyn3HxF45iUT0Q2+5jXpZdBUwGbbPalCcvk82v
	XTv/ocT5PfQNE+OuVOAH5sdt7DOr/EMM4obnfQbuD+delIrBhDBpXUQHgc/XjOp0i4emX0gmJ9u
	iVlzogYTpS6sTtKYE4+S4tqShypy4kXw=
X-Google-Smtp-Source: AGHT+IFxquLl/IZ4CrbPg4j3bqlODWwBV7B4xVBtQVW0JPBoJlhuGxpfJbI7dUm6LPQBYbyA+90DPeAqJcwH1A6m1LQ=
X-Received: by 2002:a05:6871:d80a:b0:315:29a5:fc3b with SMTP id
 586e51a60fabf-31529a63857mr1847539fac.15.1756146185988; Mon, 25 Aug 2025
 11:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822061946.472594-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20250822061946.472594-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 20:22:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j8vP-6eNEqmc=SwxrnfUkQQv+eGG-OzchwXYVDQQP=JA@mail.gmail.com>
X-Gm-Features: Ac12FXy__xIZa8zy5FkTM4rscvWQfSnK-3-IF1-4-NrfXcCIpZeQAlSj20HR_F4
Message-ID: <CAJZ5v0j8vP-6eNEqmc=SwxrnfUkQQv+eGG-OzchwXYVDQQP=JA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / device_sysfs: Use ACPI_FREE for ACPI object deallocation
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 8:21=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Replace kfree() with ACPI_FREE() for deallocating ACPI objects in the
> description_show() function.
>
> The str_obj variable contains an ACPI object that was allocated through
> ACPI subsystem functions. Such objects should be freed using ACPI_FREE()
> rather than the generic kfree() to ensure proper cleanup and maintain
> consistency with ACPI memory management conventions.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/acpi/device_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 3961fc47152c..cd199fbe4dc9 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -464,7 +464,7 @@ static ssize_t description_show(struct device *dev,
>
>         buf[result++] =3D '\n';
>
> -       kfree(str_obj);
> +       ACPI_FREE(str_obj);
>
>         return result;
>  }
> --

Applied as 6.18 material under a modified subject and with a new changelog.

Thanks!

