Return-Path: <linux-acpi+bounces-12437-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC02A71A45
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 16:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8B63BDD25
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 15:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFF21F1908;
	Wed, 26 Mar 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC7IxoH9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A306814A4C6;
	Wed, 26 Mar 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002719; cv=none; b=ZarIMqNo+3IVc9Qpw7/dYxpVQF9goBb7mIT5AFQWY8obyZKqIPAsylmWcq2+DrAyNlUXlghKoA7tKDimo1DAgBvB7QaPRVjnaTtPOXP/rb7lQ5HJUHzaOrn3NOoE9poUNoLqsvS1VtifI0DZj4Ifk7t9pGWDaNbHv3Yc1auGCIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002719; c=relaxed/simple;
	bh=fAuSUL7yObr2JsUjb/aNOLhrRIjNLcrPE9UvoJPnNnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaX3b7kBYsWitGo0eSy3edVisTGh/Oa+b1Cc/jFgyCuWatk1uZ1DTYRDNWMh+READg3LRlr+683jTJf3WH0oH0Qn+WSIhEMRKQcSqcsuZ0J16B1/sky646lAU/77QSEJ3/vLEJ7kJ+XTsbiE3+nGA4qNOUUXe5tiNHbEhUBOYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC7IxoH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0E2C4CEEE;
	Wed, 26 Mar 2025 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743002719;
	bh=fAuSUL7yObr2JsUjb/aNOLhrRIjNLcrPE9UvoJPnNnI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LC7IxoH9s5uM7aSYG/LyfJ4Z5BDoAFUQW2ObD3P6edGM/15AQNyWnoi4/6FtTuxB1
	 zt++n3xiCp/p6sbpXBN3wei5zXQPLPMAuMo4m9N6YoAh3mteB8fDXBctQgF8pkgdDq
	 /5+2F7aOfH5hbs7LcHtsFIs6pP/X2RAPnn6A7uDZ+y9wwfDJKq5R+Jp+W5Isg97Sqy
	 nBK3wDXYQQ9RPYt/TfemxoDMn68CuhImCWWOKfOTz/4YWMU3RZl44/VLmnlVkCBYtL
	 GssFM4Rwc3wiTypr67jT2ge+vbTe278RM8KVcVNpy8SzifYh6CQEZSV7G7MV2XaG5Q
	 KUhgVlW6eohbg==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72c14138668so1138808a34.2;
        Wed, 26 Mar 2025 08:25:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGw/qjFOQs5W4Sju+kHJu2D3mUdj2AGgJwdUb7Sa0w7J1em28EIhYx/XPWrQ0aCeHEc03AZDi+wOPQ@vger.kernel.org, AJvYcCXfsHcmgzsrAGMLj5NXirDYTNx0TB15RxLM+sFu+e+/X4BM09gTGlGiX1wT8jQfOURts1Vi15yK4kBnWquQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJQmaJlC2QNq05M0B10vDoVh9WKMR9CBxRKluRe7483bOfhQ7
	tpoIFGwkqbwqDtycICCEoBsYR4mPWm6Y/ILn4V0FpjaPUm6zlOH7ADao4xhtE0QwJO8fXWko3GW
	nwUYqM9TKoeLgZO5OF5iZuBHi9n4=
X-Google-Smtp-Source: AGHT+IHr5tsGpOngZIcIxU/BshH+uj+SEmFWZRPxZ1xT9KDNCl5JkjcXIT/guU1z2fkpt2dop7yD15PAh+5hCWL/xAA=
X-Received: by 2002:a05:6870:20d:b0:2c6:72d3:fc93 with SMTP id
 586e51a60fabf-2c7802ef8b5mr11720539fac.12.1743002718471; Wed, 26 Mar 2025
 08:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320092943.92790-1-qiaozhe@iscas.ac.cn>
In-Reply-To: <20250320092943.92790-1-qiaozhe@iscas.ac.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Mar 2025 16:25:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gUDxrAn4W+Rf3ifjrg8Z9ZzTTOZjPFSSN5488mPqzXeA@mail.gmail.com>
X-Gm-Features: AQ5f1JrFEpUN-GlO-VC4xnjHPMjRt4YSppHgFV2CAH6qLqsSxNLTbDaOdzQZnd4
Message-ID: <CAJZ5v0gUDxrAn4W+Rf3ifjrg8Z9ZzTTOZjPFSSN5488mPqzXeA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Adjust the position of code lines.
To: Zhe Qiao <qiaozhe@iscas.ac.cn>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:33=E2=80=AFAM Zhe Qiao <qiaozhe@iscas.ac.cn> wro=
te:
>
> In the acpica/utcache.c file, adjust the position of the
> "ACPI_MEM_TRACKING(cache->total_allocated++);" code line
> to ensure that the increment operation on total_allocated
> is included within the ACPI_DBG_TRACK_ALLOCATIONS configuration.
>
> Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>

In order to modify ACPICA code in the Linux kernel, please first
submit the change in question to the upstream ACPICA project on GitHub
as a pull request.  Once that pull request has been merged, you can
send a corresponding Linux patch with a Link: tag pointing to it, but
in principle it is not necessary to do so because ACPICA changes are
automatically integrated into the Linux code base on a more-or-less
regular basis.

Thanks!

> ---
>  drivers/acpi/acpica/utcache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.=
c
> index 85a85f7cf750..046e6ba127d4 100644
> --- a/drivers/acpi/acpica/utcache.c
> +++ b/drivers/acpi/acpica/utcache.c
> @@ -251,9 +251,9 @@ void *acpi_os_acquire_object(struct acpi_memory_list =
*cache)
>         } else {
>                 /* The cache is empty, create a new object */
>
> +#ifdef ACPI_DBG_TRACK_ALLOCATIONS
>                 ACPI_MEM_TRACKING(cache->total_allocated++);
>
> -#ifdef ACPI_DBG_TRACK_ALLOCATIONS
>                 if ((cache->total_allocated - cache->total_freed) >
>                     cache->max_occupied) {
>                         cache->max_occupied =3D
> --
> 2.34.1
>
>

