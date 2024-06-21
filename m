Return-Path: <linux-acpi+bounces-6562-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD776911F3E
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 10:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F951F27B94
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B6716D4FA;
	Fri, 21 Jun 2024 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZLIF2xhG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1718E20
	for <linux-acpi@vger.kernel.org>; Fri, 21 Jun 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959744; cv=none; b=aO566twFOTnAzTCrOcA0xmvcWAmymC2ZWmXY+dMVVNqIK9/zk5ir6W8ObHnSAMcIdF+YOxUrNKdC/P1LSiR+tz1/Bvw5IPqwE8kf88Z4znNyTjcH9wWr+JmDVMyuqMoM1d5WlUiyPHgiSY5jIbOZUb0eZoNUSSUBpYF5OdEGNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959744; c=relaxed/simple;
	bh=rSxw4pa4t8IcwJVhLPl6MDGWM7dwZWWN62i7pdCWBQY=;
	h=From:Date:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYeaCw6CmWOclvOPWH7zI7njapL1fBMvUwFmTO+BML516qpH1QzpGn4vCF7OC4wcUZ+gXbIuEzvENFe7csg7yT3TDZEjq/hlZ9WmHU/ycc57Ghavvy9IZBv4beulPcyF/RlrchzwYVAYSXF2NHt5N8PJ/p4R+6z0QqTANhpmRJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZLIF2xhG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421757d217aso20332255e9.3
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jun 2024 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718959740; x=1719564540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iJELWqmHsWyPqLt5/DkXc5x6DSIixUK4AK2BKtFmaI=;
        b=ZLIF2xhGYM6JoU0eGCmfkE+2wVC3hVj5SfJ8y+Sz5MEK/3s/P95aTCT4hUSTGfVv+p
         AFQH7M/9XtRl3UmMTamznTlWyocWulJ4YLyL3fQuZwIKzGVdIPYqRDp1bPzaIgkEF1Sn
         ZXxYSPuwrb4KN+ig9wc75nvzuyE30FidUXtfsCZ5CVlHQpLZrQ3PpDG+feyhMw/PteDv
         RowPTePWLmH2JPm2gw6pHnpCw21W0jpnaJ2mtHt+Mb+kp4nrK4ExFwNurug0StzAMrIM
         IXPwNftlZB68eHzoWP7aSSJbN9Q1LjtbYjjs5uMJaAbwKJJGZlaDDKDgDQtRnwTHmsyO
         NtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718959740; x=1719564540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iJELWqmHsWyPqLt5/DkXc5x6DSIixUK4AK2BKtFmaI=;
        b=c/wKNVK8VKTiF2hHMQwQrgNYPpBds5tt1qXvwvZWIQiAMWzfLbx+8gEDT8wTS/QrX/
         BZtJ8eYff/IbwVKOLDQTUCy9piiQEo3728VJ4c8WC65gVBy0Bi8uo7vSi2E94sbKXCgk
         iozGpHxOZPB8PPcJprFyIpR9LYvmDuzZbkLNJN1q+YJQWjA+8ULrr8R+aN8VEpbz5duK
         4py7EqmgYd0qIsUQMDpYp2sEEERO9qXg5Er2qQl7fp99H6II6IFS3tJfQ8FHf9ju5NUV
         lJXLQvOo+wKImeV/TbDB5RDemmzmC63TVOQs7qkuRrCZOkaXHgIEXrAB22gKGkMDh+Uz
         vL4g==
X-Gm-Message-State: AOJu0YwpSC2wM/VDlEtC7TODCRvWoZycXd7anIAav5njOkk9i8EImMnk
	/STyb89RaPgo+pdCqtJQA3YPZmmbS6C2Ix9gvW8ekEJjhLMaK33N2CkR7zPG0vq7HPQuDWQ/1fe
	R
X-Google-Smtp-Source: AGHT+IHD0UiB/erhdyglKOgxMUboY8Pnov/khJEt6iFT9uzQrm3z/CAJybsWZyouvGL8/1RhtngtSA==
X-Received: by 2002:adf:e909:0:b0:360:9d1a:a8d with SMTP id ffacd0b85a97d-363170ed4a0mr7437278f8f.13.1718959740270;
        Fri, 21 Jun 2024 01:49:00 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638f85916sm1085258f8f.61.2024.06.21.01.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 01:49:00 -0700 (PDT)
From: Petr Tesarik <petr.tesarik@suse.com>
X-Google-Original-From: Petr Tesarik <ptesarik@suse.com>
Date: Fri, 21 Jun 2024 10:48:48 +0200
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: CPPC: add sysfs entry for guaranteed performance
Message-ID: <20240621104848.3f14d60e@mordecai.tesarici.cz>
In-Reply-To: <20240606115541.2069-1-ptesarik@suse.com>
References: <20240606115541.2069-1-ptesarik@suse.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  6 Jun 2024 13:55:41 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> Expose the CPPC guaranteed performance as reported by the platform through
> GuaranteedPerformanceRegister.
>=20
> The current value is already read in cppc_get_perf_caps() and stored in
> struct cppc_perf_caps (to be used by the intel_pstate driver), so only the
> attribute itself needs to be defined.

Are there any objections to exposing this CPPC register through sysfs?
I mean, if everybody is OK with it, the patch could be acked and queued
for 6.11, right?

Petr T

> Signed-off-by: Petr Tesa=C5=99=C3=ADk <ptesarik@suse.com>
> ---
>  drivers/acpi/cppc_acpi.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1d857978f5f4..9976bb57356e 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -160,6 +160,7 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, hi=
ghest_perf);
>  show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_perf);
>  show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_perf);
>  show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_nonlinear_perf=
);
> +show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf);
>  show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq);
>  show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
> =20
> @@ -196,6 +197,7 @@ static struct attribute *cppc_attrs[] =3D {
>  	&highest_perf.attr,
>  	&lowest_perf.attr,
>  	&lowest_nonlinear_perf.attr,
> +	&guaranteed_perf.attr,
>  	&nominal_perf.attr,
>  	&nominal_freq.attr,
>  	&lowest_freq.attr,


