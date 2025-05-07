Return-Path: <linux-acpi+bounces-13581-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 647C5AAE0A2
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 15:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961F71899802
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9B3287508;
	Wed,  7 May 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOZWrIuP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15426A0AA;
	Wed,  7 May 2025 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624300; cv=none; b=VDjwvoiJ5NPk+qwm1RZsIMzTU0BAMp43DSb09tiFxLZ60s4OkcdpdixKuHvLzcQY65t71joVuJrD2UV0Qae4VMrYYt1JLLYGASvEfuXjhEBWpwUnE3Fk5FF4Lss1DIZ5gpqv9RzNbH2sLb2JoL+GQkyaK4jjOZvuSHeMnxKHNMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624300; c=relaxed/simple;
	bh=oKBYwKfrfI6NoCrzA+Pw879j08FdOnSRP+qbgWIEpLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKPdYfBr8lw3TzAfGArUs35E4ed7UDqEDq3aL621Vqp4Ww0BHcxdQ5EznvK0sncKbya77GeRvT+EcLRawVetEz6iVboSvMzuiNbU8R73tU2IPfX37BstSDiimTUVNMw4tJfo2dRragkWeNACeMAO5d3tAqEL2bF+B8u3VhKtdY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOZWrIuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568C4C4CEE7;
	Wed,  7 May 2025 13:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746624298;
	bh=oKBYwKfrfI6NoCrzA+Pw879j08FdOnSRP+qbgWIEpLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nOZWrIuPfeIlwySgztRVIUOkaIPlzTPoKkCG+nSPH7c/ELW/NJPZ5FpzMF2oIa6NB
	 o/h7lAp7lkeWjUF49nr9Wi6g+GM6XE129Asep/Fwr37rRI88X8UYRP+YhOAH2ViGW3
	 yPzoHyHdT59k/bTsAwY61uKaEH0Vp53qbR85BWmyCFtNq6uV5ADrOxy3xRXHxZyxXa
	 TjS2Nhs5aVsiIku2WWl/sjlEtIgCYIg3n2h6pWYSJT1nlosm3HUujhtSh+aYVfBrDC
	 HOjVzwBPHtAjivprktyB0XmOcDIiWuCXfIYu/91yeaBBim03sM8DhRSt5SxTV060qD
	 MpPW/vZ+PT90A==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2cc36b39545so463617fac.1;
        Wed, 07 May 2025 06:24:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX49WnVg82pdpA2ujd2fTiZ0EM1FLslpQubiR4QQpraAUDsFIE8Ll5gtsS56g5359dhtNdsQRGVkRyTHz8=@vger.kernel.org, AJvYcCXgAtD3pQNQXfAwF2YC5kAEP1qBjAlq9+us+cKv0nwTVyQvWO5F/pa45tWvmwRfPDsQ/qnj+3Lg9EKZ09M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9zUWleaGyKUx3HiN+vlcThE/3JOhTesqPvvseZ/N0U8DrBpD9
	szVKGkMzCyU26SjAS1bcMtUjBaouiw6F4zAy6mr2P23KQs5fSA8zVxhDxOnyw3rTeNbcMDtPz8W
	zpmxaKCYOiQfkNSH4VvJCnZGOU2E=
X-Google-Smtp-Source: AGHT+IEm3fCKgwOI+5DFmExHa4qQouYRMk1rdrz3LfztrzJ9UvIw1oK34LhH0M38zuIDugSuSenLYL2mAokoL8P7ORQ=
X-Received: by 2002:a05:6870:a786:b0:2c1:4827:c0e1 with SMTP id
 586e51a60fabf-2db5d0c4e51mr1676378fac.17.1746624297722; Wed, 07 May 2025
 06:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501124621.1251450-1-jonathanh@nvidia.com> <20250501-gay-bull-of-flowers-6edebf@sudeepholla>
In-Reply-To: <20250501-gay-bull-of-flowers-6edebf@sudeepholla>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 15:24:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hcN9B7TukPcE+xAzDEgt66BbnN+SUmuFaWU0ddKjdM4w@mail.gmail.com>
X-Gm-Features: ATxdqUExsOoWqnuEkJ7CTPUXzCE9bmtB5YeLPc1P6JXyvTEOjlPdMxuDlWNBHGA
Message-ID: <CAJZ5v0hcN9B7TukPcE+xAzDEgt66BbnN+SUmuFaWU0ddKjdM4w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: Fix probe error message
To: Sudeep Holla <sudeep.holla@arm.com>, Jon Hunter <jonathanh@nvidia.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 2:53=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Thu, May 01, 2025 at 01:46:21PM +0100, Jon Hunter wrote:
> > Commit 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device
> > interface") updated the APEI error injection driver to use the faux
> > device interface and now for devices that don't support ACPI, the
> > following error message is seen on boot:
> >
> >  ERR KERN faux acpi-einj: probe did not succeed, tearing down the devic=
e
> >
> > The APEI error injection driver returns -ENODEV in the probe function
> > if ACPI is not supported and so after transitioning the driver to the
> > faux device interface, the error returned from the probe now causes the
> > above error message to be displayed.
> >
> > Fix this by moving the code that detects if ACPI is supported to the
> > einj_init() function to fix the false error message displayed for
> > devices that don't support ACPI.
> >
>
> Good catch, it was silently passing error before.
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Applied, thanks!

That said, when fixing a bug that is only present in linux-next and
not yet in the mainline, I'd appreciate a note about this, especially
if it carries a Fixes: tag, because I do rebase patches occasionally
and the commit ids may get stale.

