Return-Path: <linux-acpi+bounces-8951-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AD69AEAB8
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2024 17:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFD5B20B81
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2024 15:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BAF1E32CF;
	Thu, 24 Oct 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCqpNI/x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C714A4CC;
	Thu, 24 Oct 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784322; cv=none; b=n0oQcNlYj7KNzG8HoiQkOZ7TQB92MS0t8PZ7MW9THz834Q+e+wblWlR8Vb5NFB3croc/Hew7J8xjOCFDzQ9no7W76JA/p9rqryb6LQjvfHewImvL6UdYH/S4x/kqcqUcdfo0/kOY7v3Haifd7GL6+lcPkUnyH+izjAbR0a8MS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784322; c=relaxed/simple;
	bh=h9SjXAxMUaB6ZIwhlTLaUbF5816pwq4H4u3Yn/U4ins=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWO8fdbs+lDsWN01hR5UfA9hYeuMKOdG6CVEbKSBtQEUfb79KiTqneJY+P619wX0pL7W3q24egMiqORi4ECjH8eC0donDY7waaA0Ddz3IEAVhKiNlBvfeAqxOgf6nnzjUq8JZa+KwDHiP4NYBAJDscR2txNqBrDHV5Z5q6TMbVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCqpNI/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F78C4CEE3;
	Thu, 24 Oct 2024 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729784322;
	bh=h9SjXAxMUaB6ZIwhlTLaUbF5816pwq4H4u3Yn/U4ins=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CCqpNI/xHcFyDXKjPfvJKGrmstmJkWDnb2QRBCX6OQ5N52KE3icTAQR8d68MXTl42
	 KAIBs63J5acVQztnX4w4cEUjt8tcrXmFU+noPyDfF7/3kOUx+dXUBlqXOfVp2iJ50t
	 OghE4JqmUbWKfUaMHWbg40YwtFnv4Me4VaqKpZCFsO7TdP5vBAp/dc5IZr6DQuorMY
	 zFPnmOCsSKdlpeVvZKLF12P+sBDMTOQ85beS1vp0P2Elq47SXMQ6bwmU5WnI9suPyN
	 EWs8FLSinfSq9xrxvHU7g1kliZDUhz/rYyUn5udQudJz2HwdQ7Rz19Zvg/WqwtmG7J
	 /xknwkT70jzcA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2890f273296so522371fac.2;
        Thu, 24 Oct 2024 08:38:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0G5/sM3oXWvk3lZY41vXVtqscz6WWLmTPXuQm/ekHC9kZrebJAIo0xgcFCdZhjKOMEnbsjG53iJ19@vger.kernel.org, AJvYcCV8oECMVQjHtXVR/9Y4vXie0XYFvm3KMtTjuLviDBeqP7cPIoigj53WkJbAgQgcNvaUWizs/fPnUIApjv69@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRoZkMg/O1qFUuDQtb9adyTCjvdXuW9lFyee7rY9MKTvisZE4
	UgPVlCy4/3MyoVb6PS/mn81EBv1wjDCQ+7DmWln2lmNKYs+ZbxZlc4mVzueADDWQkSKjhaO3wP+
	8XSD79VTORO7lkGNzFWB45PPmohE=
X-Google-Smtp-Source: AGHT+IHTXsoKulanH4wFqL0jOXHtVBcAt2WTSzpPUZPGTLaD8Si5iLxik5Zb7rOSNizpIBepKThQa288nnLjlJFlwCM=
X-Received: by 2002:a05:6870:6489:b0:288:8aaa:ed0e with SMTP id
 586e51a60fabf-28ced134cd7mr2428935fac.8.1729784321504; Thu, 24 Oct 2024
 08:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024022952.2627694-1-liwei728@huawei.com>
In-Reply-To: <20241024022952.2627694-1-liwei728@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Oct 2024 17:38:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jcsYnKW=WwXs7tvd-dy9vp_pCT2KDWOEsTELUJonmYYQ@mail.gmail.com>
Message-ID: <CAJZ5v0jcsYnKW=WwXs7tvd-dy9vp_pCT2KDWOEsTELUJonmYYQ@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq/cppc: fix perf_to_khz/khz_to_perf conversion exception
To: liwei <liwei728@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org, 
	Pierre.Gondois@arm.com, vincent.guittot@linaro.org, mingo@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bobo.shaobowang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 4:16=E2=80=AFAM liwei <liwei728@huawei.com> wrote:
>
> When the nominal_freq recorded by the kernel is equal to the lowest_freq,
> and the frequency adjustment operation is triggered externally, there is
> a logic error in cppc_perf_to_khz()/cppc_khz_to_perf(), resulting in perf
> and khz conversion errors.
>
> Fix this by adding the branch processing logic when nominal_freq is equal
> to lowest_freq.
>
> Fixes: ec1c7ad47664 ("cpufreq: CPPC: Fix performance/frequency conversion=
")
> Signed-off-by: liwei <liwei728@huawei.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> v2:
>     - Fix similar issue in cppc_khz_to_perf()
> ---
> v3:
>     - Add acked-by tag
> ---
>  drivers/acpi/cppc_acpi.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index b73b3aa92f3f..c3fc2c05d868 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1916,9 +1916,15 @@ unsigned int cppc_perf_to_khz(struct cppc_perf_cap=
s *caps, unsigned int perf)
>         u64 mul, div;
>
>         if (caps->lowest_freq && caps->nominal_freq) {
> -               mul =3D caps->nominal_freq - caps->lowest_freq;
> +               /* Avoid special case when nominal_freq is equal to lowes=
t_freq */
> +               if (caps->lowest_freq =3D=3D caps->nominal_freq) {
> +                       mul =3D caps->nominal_freq;
> +                       div =3D caps->nominal_perf;
> +               } else {
> +                       mul =3D caps->nominal_freq - caps->lowest_freq;
> +                       div =3D caps->nominal_perf - caps->lowest_perf;
> +               }
>                 mul *=3D KHZ_PER_MHZ;
> -               div =3D caps->nominal_perf - caps->lowest_perf;
>                 offset =3D caps->nominal_freq * KHZ_PER_MHZ -
>                          div64_u64(caps->nominal_perf * mul, div);
>         } else {
> @@ -1939,11 +1945,17 @@ unsigned int cppc_khz_to_perf(struct cppc_perf_ca=
ps *caps, unsigned int freq)
>  {
>         s64 retval, offset =3D 0;
>         static u64 max_khz;
> -       u64  mul, div;
> +       u64 mul, div;
>
>         if (caps->lowest_freq && caps->nominal_freq) {
> -               mul =3D caps->nominal_perf - caps->lowest_perf;
> -               div =3D caps->nominal_freq - caps->lowest_freq;
> +               /* Avoid special case when nominal_freq is equal to lowes=
t_freq */
> +               if (caps->lowest_freq =3D=3D caps->nominal_freq) {
> +                       mul =3D caps->nominal_perf;
> +                       div =3D caps->nominal_freq;
> +               } else {
> +                       mul =3D caps->nominal_perf - caps->lowest_perf;
> +                       div =3D caps->nominal_freq - caps->lowest_freq;
> +               }
>                 /*
>                  * We don't need to convert to kHz for computing offset a=
nd can
>                  * directly use nominal_freq and lowest_freq as the div64=
_u64
> --

Applied as 6.12-rc material, thanks!

