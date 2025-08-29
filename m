Return-Path: <linux-acpi+bounces-16194-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0099CB3C170
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 19:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC44567CBF
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B75218AC1;
	Fri, 29 Aug 2025 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTksd1s9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6963A1DB
	for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486946; cv=none; b=ASVD3LnoKnHw3CTke5JUUr5/C14P6WHminnFFVCEHgDvAlSHG3TwckQ0Ho+NUFcIrDkaAAx5T5u5RRVizeg3fY4+sEPxEcQjTqttJD0tNDjAzyd06HzLwluwK2Ph0E+30gxPYVIpjRE6DCI88CZwithhVY54MVsm+zVSv6iQsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486946; c=relaxed/simple;
	bh=jckHIqF6i2pBFamtML/gMy0ZqD2SuPtuowG9SJKDWMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lky1kX3JdzGetbA+bML7/OqoyDHmMOeixh0dbFsiIszF6mn34LcrsahtmOqwuXu6v7QHm7b1uHX5luV7n88dBgwbjn9f3zfTZciLRiKoOyyhdvHDsj6RV7YSKsGnRju7x07XZf4KXsC2Ds0+Xw/nRLASdgN2BmQhV244JrznYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTksd1s9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11209C4CEF8
	for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 17:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756486946;
	bh=jckHIqF6i2pBFamtML/gMy0ZqD2SuPtuowG9SJKDWMY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CTksd1s9xY3D0u83iS89bdocTJ09tnw1g9g+hpKj1CK5cqCdJmF0hc8bl4T4EVp3m
	 gPRjB6HfzJrWbXuQZp29GIsx6RBX46JuQEibY4RG4q4hahVkmjfxgXOSsIXTynqo9s
	 1FDoItIRV+Zv1ZIQ4tHD/KMlUlDTi2KDWWvu9tQXO2M5007NyEiuMedK3N5TnY2MHI
	 kfQd53mA5PeKNL2y7xgWhRbSJsjyE9HkM41EXEz3xiSw6b1KdBFNhZdMbahKPhmUFM
	 zhoCoGbIfnadZLsmE2nHHGoYrsCp1HYuOClPVIAXZiGqQk+eXWFwQaHHjQLrJ7C2lx
	 +aWRWBoQy2Slg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61e266ab733so440009eaf.1
        for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 10:02:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwkIAW6xJKNxCdMOOOWOO6N93WlPXbihpu5QDD9VzsMOgRnM6PWipvofzUm6RzJiSo2rGPIg5l8+mU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/A4hXpUeajIgjrTDR6FDTW78bzAr6YG6KeJi5k1QTDV1Jtgy
	vTJrURvC+a1PpCx0FFJqISwi1VM1k2jT4PSTUDYggvkxg3vNpre06y972PBF0fPBeABxV4GvJ2z
	2901mUZPl2LjuhiC5zXEcYEWKee1eYyc=
X-Google-Smtp-Source: AGHT+IG9Vf5FW7DEcOzXTmI+SdGyTY6utY2avMM/kXK5FjQwmV/DQokNRVb6fgLdg7jgG0yhffJknqZl2eY+AsF0ZxM=
X-Received: by 2002:a05:6820:1691:b0:61e:2989:5eff with SMTP id
 006d021491bc7-61e2989619dmr909695eaf.2.1756486945260; Fri, 29 Aug 2025
 10:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829112614.1872244-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20250829112614.1872244-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Aug 2025 19:02:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hxj84qq-riRobM-_z=BQRTWGsQ8EDLeqJrvZdkazEeDg@mail.gmail.com>
X-Gm-Features: Ac12FXwn0F9lO3JbVscHYnV3zA_PmL_0_rwqUnRgO0nMCylkYe1f_lsw7uT4ta0
Message-ID: <CAJZ5v0hxj84qq-riRobM-_z=BQRTWGsQ8EDLeqJrvZdkazEeDg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: acpidump: fix return values in ap_is_valid_checksum()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, robert.moore@intel.com, saket.dumbre@intel.com, 
	lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 1:27=E2=80=AFPM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> The function ap_is_valid_checksum() has a boolean name suggesting it
> should return TRUE/FALSE, but incorrectly returns AE_OK on success and
> has no explicit return on failure, leading to undefined behavior.
>
> Fix by returning proper values:
> - FALSE when checksum validation fails
> - TRUE when checksum validation succeeds
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Please submit ACPICA changes to the upstream ACPICA project on GitHub.

They are not going to be applied directly to the Linux kernel code
unless they are based on existing upstream ACPICA commits.

> ---
>  tools/power/acpi/tools/acpidump/apdump.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/=
tools/acpidump/apdump.c
> index bf30143efbdc..7a6223aa703c 100644
> --- a/tools/power/acpi/tools/acpidump/apdump.c
> +++ b/tools/power/acpi/tools/acpidump/apdump.c
> @@ -86,9 +86,10 @@ u8 ap_is_valid_checksum(struct acpi_table_header *tabl=
e)
>         if (ACPI_FAILURE(status)) {
>                 fprintf(stderr, "%4.4s: Warning: wrong checksum in table\=
n",
>                         table->signature);
> +               return (FALSE);
>         }
>
> -       return (AE_OK);
> +       return (TRUE);
>  }
>
>  /***********************************************************************=
*******
> --
> 2.34.1
>

