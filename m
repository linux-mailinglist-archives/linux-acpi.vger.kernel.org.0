Return-Path: <linux-acpi+bounces-14253-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B89EAD2644
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 20:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4B616F4CA
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 18:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85E521D3EE;
	Mon,  9 Jun 2025 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pg3C94eU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6621CFEC;
	Mon,  9 Jun 2025 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495518; cv=none; b=OTLfLGv2JKqDBEcTqtdec4FNeCRdb9BWNEXlDOXBXTcYSUZi1STW9xe1ITm8fGq0k8y34ap19wnXd6nj2f+d+D9hX5nXMFA2MDUMhVyF1zk6xPgkYibFgIJiBD9dveZTqc1AlhSVGwK1/2K9Vg+VtiDBaLv5VnHfZfGuZ/5l9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495518; c=relaxed/simple;
	bh=jjPWTfrAHKJowj5Z+4zZD4280cfX8ICtIyTBCFXvyXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7lP4Sfj6DxIrfjY8EEsLAdod5uJZIHCDlCmD2RctwnHwkiz8FRlh1MmP0IG2oTf9W5O6l0IvHnupaw3wa7HR/QyfBhyXUOWkmsz5PbAEqWc+e84oZLBrx9m3V4lFzvouh5qtx6nsZwui5PZCYOd4izSI8K6wsek9oYUPyh6MyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pg3C94eU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06926C4CEEB;
	Mon,  9 Jun 2025 18:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749495518;
	bh=jjPWTfrAHKJowj5Z+4zZD4280cfX8ICtIyTBCFXvyXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pg3C94eUpCb2nkxFPVcQnF8o5van3SJL0Bs2RSjymovqZwi0GmCzmn4m68CHPBYNL
	 DxBUubPRtEwqI+RLvqoMs3GNGjY1NwA5dSwUzl+ZSFwQJhl87F76XegePDGKsDpzEj
	 7v2frVfOcMcRaf6gXFwICqb/x6N8omJsyuQro1F7bkjtjayx3FQHJt7XrfUhboaJnk
	 YTpt4ImQc7rs8WWAPYZpuwYLmENPACxZ/Tt05F1Rin5LoUYx0YdWUKdS+R2whrqxAD
	 7OsB2isfcuDT96fNNXlTtabNGMJBrpLtWW7gvPPApL4xlq+sG2acM3vV4U+vtEhtY8
	 0vyXWORB90R9w==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72c173211feso1420640a34.1;
        Mon, 09 Jun 2025 11:58:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkHhoOYiJw4d4etx9hxDQuAUA7r1g3ew3byLZ5Xf/sgYKsa5lB+GEH11dO36WefNkDEdSnGCDJ/X5g@vger.kernel.org, AJvYcCXWG8xJB0N0HBLb4JH9PaN33j1qNetQrvfTuMlQUvr6c39YQfeDELSeVwCUNI0Kqg9tT7+0mPZMrYWQQT1M@vger.kernel.org, AJvYcCXw19YE+bOFwWKh5PPhEs3ZHPj1CoTg3wb+9gf/mmWn74Upkl8sm39Pk19GVzW+BrhAGDsrZZgnuPIl@vger.kernel.org
X-Gm-Message-State: AOJu0YwGXHiAEIJ5y+mayRWOYKYTKP+ZG1xdugReGpqOplhG+K0GCoOs
	n+dZC/aksVKvqL5zjpimK88k0lUf6saoU1L4/3xMHG9kDC70Z3n1dgL00N9G9zGUfCVXTZmTFWG
	FxLX5fPVeQDzlWr7KNzn2UXZkvBTTZUE=
X-Google-Smtp-Source: AGHT+IE/Kf/rglv+zULIsd/Hx9i9RCS+ZxIkARQeY4xSLesj5blmdcfud4/343OwkYCSbD3QuWbq3rTHSxaVmc5WZ3M=
X-Received: by 2002:a05:6870:1786:b0:2c2:2f08:5e5b with SMTP id
 586e51a60fabf-2ea00877847mr8655527fac.13.1749495517352; Mon, 09 Jun 2025
 11:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607033228.1475625-1-dan.j.williams@intel.com> <2af31ff8-eee0-4868-8f97-2a390910f9ed@intel.com>
In-Reply-To: <2af31ff8-eee0-4868-8f97-2a390910f9ed@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Jun 2025 20:58:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j5+iB97rTqtOoFB0zpHzNOOHGOQVz51ZU--=4AcUPf-Q@mail.gmail.com>
X-Gm-Features: AX0GCFtM4Z_9kTNBgzU_uqk4-HS_OYG_CSCBhIivKu7nnPX-kKHvYc24bYkuhmo
Message-ID: <CAJZ5v0j5+iB97rTqtOoFB0zpHzNOOHGOQVz51ZU--=4AcUPf-Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] CXL: ACPI: faux: Fix cxl_core.ko module load regression
To: Dave Jiang <dave.jiang@intel.com>, gregkh@linuxfoundation.org
Cc: Dan Williams <dan.j.williams@intel.com>, rafael.j.wysocki@intel.com, 
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ben Cheatham <Benjamin.Cheatham@amd.com>, 
	Danilo Krummrich <dakr@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 5:04=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> wr=
ote:
>
>
>
> On 6/6/25 8:32 PM, Dan Williams wrote:
> > git bisect flags:
> >
> > 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interfac=
e")
> >
> > ...as the reason basic CXL unit tests are failing on latest mainline. I=
n
> > addition to the fix to einj-core.c, this also needs some updates to
> > faux_device to make it behave more like platform_driver_probe(). Detail=
s
> > in the individual patches.
> >
> > Dan Williams (3):
> >   driver core: faux: Suppress bind attributes
> >   driver core: faux: Quiet probe failures
> >   ACPI: APEI: EINJ: Do not fail einj_init() on faux_device_create()
> >     failure
>
> LGTM
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>
> >
> >  drivers/acpi/apei/einj-core.c | 9 +++------
> >  drivers/base/faux.c           | 3 ++-
> >  2 files changed, 5 insertions(+), 7 deletions(-)

Greg, I think it's better if I route this through the ACPI tree as the
issue being fixed was introduced through it.

Any concerns regarding this?

