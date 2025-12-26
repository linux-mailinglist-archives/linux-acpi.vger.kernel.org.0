Return-Path: <linux-acpi+bounces-19866-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D04CDEBA2
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 14:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 324CD30012F2
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 13:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09063322B6E;
	Fri, 26 Dec 2025 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzMyuAP8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83281A0BD0
	for <linux-acpi@vger.kernel.org>; Fri, 26 Dec 2025 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766755073; cv=none; b=oL+fQhvcI3b5sgXGpbAEebb/T//726aND3B+odzC+l3aRk5VGF/je6xnye81aPcOTkC1qM0uf+DQ225+rHDUQbL+xyw/g7worupfT3CwhucfPRsPntP/J61wgXW0OsfCyCYEYyGP/n/+7Al+0PuKU3OEXazAJHAmjKrdIQTi5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766755073; c=relaxed/simple;
	bh=VpwX6zl7ZKZXAfZ9DYcQJ95RyDIkZMHQBUhiBPf4FmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJuzhtGdoDQIe2wcTIIIQQfKHybsqY8o8NX/6mhbBfsf7ma/f4A9RzSr/Q1jkW17Iu0k4wZ+wDXxwMgw7g/gqAyw3zJzjz7yfXK2wSbzfrb39qa7gKjz6/RlfSKd/d1bPz16zOxYrb05+H+KI2yzWSneh1TouDd+XP0HW/9UUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzMyuAP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBBAC4AF09
	for <linux-acpi@vger.kernel.org>; Fri, 26 Dec 2025 13:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766755073;
	bh=VpwX6zl7ZKZXAfZ9DYcQJ95RyDIkZMHQBUhiBPf4FmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MzMyuAP8a1TQIhsCHPS99BdpzYtXAg8UTdiiyczw+GKb0TIw4HV/2PW441Vjnci2i
	 iM0+CXlyzX3IgvYYCWHjPZx4OE4lHfZ9la9tYgVCrkDt9zMyaOTWvwikqqGOfEnpd1
	 ankdKKVKKjD4tc7F0XMf6VE+hsq1XXFimJyCh+taOxRVBy8GMwhnhwQvS5AwsBxSGe
	 D2Qwn3xPbgySu0gSjIn/OTsyGhRYfbmCnG5IlWsVaepfSOhbs8e23GK1FCTcDh+sTV
	 R9UMOXm3gqbQcRam6lBtQkv9gVXz1na3xcj4BXAaAy/y4x9KUkH4aD6NPgl+3TNime
	 JWj7Ws+2gEOmA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6598413b604so4578616eaf.0
        for <linux-acpi@vger.kernel.org>; Fri, 26 Dec 2025 05:17:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZVMfqqxMoykPKCmVdVjThp1bIrAlZQa9hj5nhOEEln0TLaFmBH/zc8T9EZVuquTA1HmkzaJvJKzD7@vger.kernel.org
X-Gm-Message-State: AOJu0YyqiEHakGK4pT9LGQX01jX8lhP/T98JPe2eo0/7vtVPU6+AsY2a
	8ycZmr0/NPJ4YnikwBuR8Y89IL0aKe1tYwR0DGGPzYuSqgGfoZlODPdR0Ei5+58okv04jQnjoUt
	boIwuJsw20lcwCFjpOxAvAoVB4eBNFqE=
X-Google-Smtp-Source: AGHT+IFticjAy/QlXXBk0DvND1JVCEnAKQowQSV25vYHUDaxUJY0RFEd29S1/GphBiEzXSjjuTeyVZhOgymPsu5jRTA=
X-Received: by 2002:a05:6820:1c99:b0:659:9a49:906d with SMTP id
 006d021491bc7-65d0eab6bb8mr10158316eaf.56.1766755072586; Fri, 26 Dec 2025
 05:17:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202512242052.W4GhDauV-lkp@intel.com>
In-Reply-To: <202512242052.W4GhDauV-lkp@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Dec 2025 14:17:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0igs0hdsyAKw7yT2MuPoYgyjGPe7=2Y=5-xSpt60dpOOA@mail.gmail.com>
X-Gm-Features: AQt7F2oUzYqFHD0bAUV1wFfn_3IV1J4hVLui2_C-CqBFl3xSKnrJqnAGuQjRFMM
Message-ID: <CAJZ5v0igs0hdsyAKw7yT2MuPoYgyjGPe7=2Y=5-xSpt60dpOOA@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge 69/72] drivers/acpi/bus.c:339
 acpi_osc_handshake() warn: variable dereferenced before check 'cap' (see line 332)
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 2:12=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it bleeding-edge
> head:   e08ef982088f28cd65654693f29ffe430a9d4d66
> commit: e5322888e6bf4ec17964a93638c9b14433a2f6f1 [69/72] ACPI: bus: Rewor=
k the handling of \_SB._OSC platform features
> config: x86_64-randconfig-161-20251224 (https://download.01.org/0day-ci/a=
rchive/20251224/202512242052.W4GhDauV-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202512242052.W4GhDauV-lkp@intel.com/
>
> New smatch warnings:
> drivers/acpi/bus.c:339 acpi_osc_handshake() warn: variable dereferenced b=
efore check 'cap' (see line 332)
> drivers/acpi/bus.c:339 acpi_osc_handshake() warn: sizeof(NUMBER)?
>
> Old smatch warnings:
> drivers/acpi/bus.c:297 acpi_run_osc() warn: sizeof(NUMBER)?
>
> vim +/cap +339 drivers/acpi/bus.c
>
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22  328  static int acpi_osc_han=
dshake(acpi_handle handle, const char *uuid_str,
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22  329                         =
     int rev, struct acpi_buffer *cap)
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22  330  {
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22  331        union acpi_object=
 in_params[4], *out_obj;
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22 @332        size_t bufsize =
=3D cap->length / sizeof(u32);
>                                                                          =
^^^^^^^^^^^
> The cap pointer is dereferenced here.
>
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22  333        struct acpi_objec=
t_list input;
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22  334        struct acpi_buffe=
r output;
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22  335        u32 *capbuf, *ret=
buf, test;
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22  336        guid_t guid;
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22  337        int ret, i;
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22  338
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22 @339        if (!cap || cap->=
length < 2 * sizeof(32) || guid_parse(uuid_str, &guid))
>                                                             ^^^^
> Checked too late.
>                                                                          =
             ^^^^^^^^^^
> Also this sizeof(32) should be sizeof(u32) although both are the same
> so the current code works.
>
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22  340                return -E=
INVAL;
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22  341
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22  342        /* First evaluate=
 _OSC with OSC_QUERY_ENABLE set. */
> e5322888e6bf4e Rafael J. Wysocki 2025-12-22  343        capbuf =3D cap->p=
ointer;
>
> --

Thanks for catching this!

Interestingly enough, I have a tangentially related patch fixing both
issues reported above.  I'll send it shortly.

