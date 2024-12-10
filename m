Return-Path: <linux-acpi+bounces-10031-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091B29EB8DD
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 18:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087E9282CE5
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 17:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971471BEF70;
	Tue, 10 Dec 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYDXsOS+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5386329;
	Tue, 10 Dec 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853569; cv=none; b=W4wAjjnyumPEfac/GYjjcZoXL7PqduBqtr/C/d2wYHXyhr9wARbmVKjpzcHmAXi/I3Vk9kBDCzj6rfE19vGapXXfFTDwLgDAGimMYIAfAPBGL9IRAzQU/osKHiDQdEXDF1/RlQZlr+s6PiDZhNR8X97zj10c9IA7nSdsyTfQxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853569; c=relaxed/simple;
	bh=gUkzlMiFdKBnhr92IRCHX0ktYexfnkyYZwL6mPhBhoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSxEcnYaT5rNBAIwUzgWaP5CBkSeQ374vo1uNKHHBZYb0PDszVbr5i7oOvxY9++N/HsRgZqHwJ27PwBDpU9G0f4Kx3gVWadFDKWfHLjqxbjKxbqB1lQhQ7VoQhMW1hv/34SR3wa/XdlFv4y95kz8xpn0tEGkCFNWJztO/xTdg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYDXsOS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB437C4CED6;
	Tue, 10 Dec 2024 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733853568;
	bh=gUkzlMiFdKBnhr92IRCHX0ktYexfnkyYZwL6mPhBhoE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nYDXsOS++7Yr1cB/sscavqICDcVktb/OKaC7gMFEhIUOGq3771r1HrJIJCsVaE3Yo
	 GgZGdQkeZixS3CMev38bRnic37iqag8CJKuSEhOA0CfnXY1RcOsmJPlAfCSoz4gk+l
	 eJbndocJMiUO6P3stSfC/pPXuu9r4LgVlRJkCfOWC2CND+48UFG0WkOI2eVniuAgK5
	 CWEjT57RlVWRTcLm3Z5aXD01T87Y7GJ/snuUf7/IYnwo+HoqTiLvaxp2K5Njlt4XLz
	 T8Aykjk5WoF6OZYsT6+hOH38nteVZU1CcbAlFhMaTJrAlP7tHwH8NHnU4IleqvlxXA
	 o3W5F/m6IZDDw==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eb4684f3cbso1391592b6e.3;
        Tue, 10 Dec 2024 09:59:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVn25pEKxiMetsMd6K0KJDThYT8O2uCottS+vtyS985gs2um+rGaJmar/oAdF555mccFSuuvi5V72jZF91c@vger.kernel.org, AJvYcCXoDAGlsq7LKH9uWSwEEmj1UON4mdA1vlFZoLMV1SUIEaUn9rcdft9rpS+uGSz6uJY9vLWKgqbyl8HV@vger.kernel.org
X-Gm-Message-State: AOJu0YyLgf9MEB3teMM8q5xSTSDEhb0L2KchNbSREeFmyAcVse8+DK0s
	+QqyR52XviB72SHunAl/2XjyXsUhnVKohrtvBrcfxdLihD0dBNRflZPzrdtVB8nriHSWhHCM2JR
	w1sUtSludeGUUuOs/aYfQpA+jUdM=
X-Google-Smtp-Source: AGHT+IFm14pb4rSYOuEEFJW8NM2IQuTQWF2FsycXRpWQrvEvlko50wAYJMJ+h+eftM/3To32c0wUDA6Rbpl6+86evTc=
X-Received: by 2002:a05:6808:1813:b0:3e6:5f3:f0d8 with SMTP id
 5614622812f47-3eb66e1b502mr3403613b6e.24.1733853568225; Tue, 10 Dec 2024
 09:59:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115035014.1339256-1-tanxiaofei@huawei.com>
In-Reply-To: <20241115035014.1339256-1-tanxiaofei@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 18:59:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h4-cSFs+ED3ymJKHKkEAproXCtB2t3cP1wcyd6eq=Sgg@mail.gmail.com>
Message-ID: <CAJZ5v0h4-cSFs+ED3ymJKHKkEAproXCtB2t3cP1wcyd6eq=Sgg@mail.gmail.com>
Subject: Re: [PATCH] acpi: Fix hed module initialization order when it is built-in
To: Xiaofei Tan <tanxiaofei@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com, 
	M.Chehab@huawei.com, roberto.sassu@huawei.com, shiju.jose@huawei.com, 
	prime.zeng@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 4:56=E2=80=AFAM Xiaofei Tan <tanxiaofei@huawei.com>=
 wrote:
>
> When the module hed is built-in, the init order is determined by
> Makefile order.

Are you sure?

> That order violates expectations. Because the module
> hed init is behind evged. RAS records can't be handled in the
> special time window that evged has initialized while hed not.
> If the number of such RAS records is more than the APEI HEST error
> source number, the HEST resources could be occupied all, and then
> could affect subsequent RAS error reporting.

Well, the problem is real, but does the change really prevent it from
happening or does it just increase the likelihood of success?

In the latter case, and generally speaking too, it would be better to
add explicit synchronization between evged and hed.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  drivers/acpi/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 61ca4afe83dc..54f60b7922ad 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -15,6 +15,13 @@ endif
>
>  obj-$(CONFIG_ACPI)             +=3D tables.o
>
> +#
> +# The hed.o needs to be in front of evged.o to avoid the problem that
> +# RAS errors cannot be handled in the special time window of startup
> +# phase that evged has initialized while hed not.
> +#
> +obj-$(CONFIG_ACPI_HED)         +=3D hed.o
> +
>  #
>  # ACPI Core Subsystem (Interpreter)
>  #
> @@ -95,7 +102,6 @@ obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) +=3D ioapic.o
>  obj-$(CONFIG_ACPI_BATTERY)     +=3D battery.o
>  obj-$(CONFIG_ACPI_SBS)         +=3D sbshc.o
>  obj-$(CONFIG_ACPI_SBS)         +=3D sbs.o
> -obj-$(CONFIG_ACPI_HED)         +=3D hed.o
>  obj-$(CONFIG_ACPI_EC_DEBUGFS)  +=3D ec_sys.o
>  obj-$(CONFIG_ACPI_BGRT)                +=3D bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)    +=3D cppc_acpi.o
> --
> 2.33.0
>

