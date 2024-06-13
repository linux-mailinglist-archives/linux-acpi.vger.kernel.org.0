Return-Path: <linux-acpi+bounces-6380-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 550E2907C10
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 21:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3911F2431B
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 19:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA80014B06A;
	Thu, 13 Jun 2024 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz7YBVwB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC65514A092;
	Thu, 13 Jun 2024 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305884; cv=none; b=AQMa2eBBwUsZnvfDeKtliiynqfr6KQzECDor5XsQDIS0+aW8IoXqmgSTA2s5wNOSN/yrvsnH1wqu/Pt8UL1yiGA2EAlq6Lmeh/ptXZL41DwzIOpbKhps9naP9Nkt8IWvdFqEnDRDIZmzW6wZAP/vC3RDWyYMghLJ82oTVDhDTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305884; c=relaxed/simple;
	bh=aSYiRz3VNxWG8/XIWBGJN3+y8R6sjrC4sTBSoiBgCak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=di8hKlEgVRfvFOa9PgPuMUQWxHcJKODgApa/4xPb5un8jQmCUcWHRkWaqvfvFSnkOB6gvsuYs7gyxemk5LYNCb4N8Hb9YM76IVYZZ5W1o8yJX1Bt/msBnAAxpkr8Gp+symSWtFvsqwexiRIyghB51u+NB9L8sBYyZsdrzdebTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oz7YBVwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492CDC3277B;
	Thu, 13 Jun 2024 19:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718305884;
	bh=aSYiRz3VNxWG8/XIWBGJN3+y8R6sjrC4sTBSoiBgCak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Oz7YBVwB41CeaIslASHo/smftghebL9mpkOUsBO+VAPKbOOirFOrOsRblBIHocN65
	 Tno4mzlfoOaiK0Ez1afHh5dcS4gBcSQdh+c2ca1RF6/9EB2y2vwE0sPCYfU+pVoH45
	 2CXFsCiayvG3cmXVwrgQBFbsoSfbs2HtUlenTdxPVOi8ks4UJDTQfXcHVqsBe0Bt7K
	 fGWhdwCRxv5cFtHH1Zg9/V92Emp2dcjHebzZRpw4KssIZ4cZovtv2bab6sqoNsEz9R
	 X7XQHTtjhsuxvQcSH80KukTtvm3xp7ECUVDvc5WYqFKaNbYGcFhZVwrvijoJv3i0Yz
	 dJwNEG62Y7d1g==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b3356fd4f3so100907eaf.1;
        Thu, 13 Jun 2024 12:11:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLTIjIMSsynkirIqlQg/2bY2U3yIpu5AO7SWciFuqyGja9oOlRcVVZF26UBkcw9RLC8u2Dxg8Eav/TbhKh@vger.kernel.org, AJvYcCVkmw3GF6Tfty5If7I/6qz1k2VxHFqLfw1IxU2v3Jhjwx4TyMOYPhjV9QV/a5ZJ3MaQKLbHyUqhVmqHrSpkNa4=@vger.kernel.org, AJvYcCVzTPpZUDerEMNkXfbF5Wm8LeJsRair3Li43fv8+6GH3C4TZk9uQgzDCqofyzZNiq0up8vlw1uIqZ/ztw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqxDDL2ogZYN8Ynn53PJkjnxBCGkQJtJO9aLAkH30ukuOJ5E1c
	e6cZqkY4nPS5IIFKNx6SLxcL9m3ivtPM65+dCufeOCqnLtqG7uFCkJ57EhcEErxk50K1YTEayhA
	0rGnlzSu1rKlDKUzH6O31JKE2zGA=
X-Google-Smtp-Source: AGHT+IH5P846mxAsiqb0j5TMIN/XoIEj3UuLwuoWyyVGmZPrOQSmmDznRb8UNs4AoDtv8IXQDvuJA+KmjZC5p6mFWfs=
X-Received: by 2002:a4a:c482:0:b0:5bd:ad72:15d3 with SMTP id
 006d021491bc7-5bdadc0905fmr637211eaf.1.1718305883349; Thu, 13 Jun 2024
 12:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603-md-drivers-acpi-nfit-v1-1-11a5614a8dbe@quicinc.com> <5224f029-c156-4477-9823-54efd434af98@intel.com>
In-Reply-To: <5224f029-c156-4477-9823-54efd434af98@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 21:11:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iw41pe-PbR81eQmNTQ2HDKU6PEHt1TBdsuSq55f_ceXA@mail.gmail.com>
Message-ID: <CAJZ5v0iw41pe-PbR81eQmNTQ2HDKU6PEHt1TBdsuSq55f_ceXA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NFIT: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 6:10=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> wr=
ote:
>
>
>
> On 6/3/24 6:30 AM, Jeff Johnson wrote:
> > make allmodconfig && make W=3D1 C=3D1 reports:
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/acpi/nfit/nfi=
t.o
> >
> > Add the missing invocation of the MODULE_DESCRIPTION() macro.
> >
> > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  drivers/acpi/nfit/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index d4595d1985b1..e8520fb8af4f 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -3531,5 +3531,6 @@ static __exit void nfit_exit(void)
> >
> >  module_init(nfit_init);
> >  module_exit(nfit_exit);
> > +MODULE_DESCRIPTION("ACPI NVDIMM Firmware Interface Table (NFIT) module=
");
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_AUTHOR("Intel Corporation");
> >
> > ---

Applied as 6.11 material, thanks!

