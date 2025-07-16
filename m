Return-Path: <linux-acpi+bounces-15203-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD50B07D44
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 20:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB3A1AA469D
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CE229B20A;
	Wed, 16 Jul 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWzeJQC+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED07E288CA1;
	Wed, 16 Jul 2025 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752692358; cv=none; b=DO4eVD/eaplM9wfr6YLktBcetKbfbNIV4M1qAY34bQL/32hd6JiRbg0i0JF7GzwZ5qBnxyyW6wxa6Ou9hNo23uFIBX/7kczXQTaG0jlb7ug3oLKtr/cJtQva4NZP4ZVkkZnTxSYU5wgjQhxlIDeLQXfzTKm9tZDosnKTSecppDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752692358; c=relaxed/simple;
	bh=/omEhvjVTapPD90QGO2cVGPkfSWUs2Njdx/dD9e79V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcqQ82LwVvomUESzoUVV8ITrK6t9NFPPVSTtzL6YmZ5NQ5vQFGeJIuQOKfHyUy5pQDuu2dET4F77jzV6YVzvePaGfDla8COOle59DmuQtNDusekmzIah5sxntdWAkrtYFy+x+zgmS6QPrD2hzNslLnJMt1vjILvZPtNaixVcjzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWzeJQC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721FEC4CEF6;
	Wed, 16 Jul 2025 18:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752692357;
	bh=/omEhvjVTapPD90QGO2cVGPkfSWUs2Njdx/dD9e79V8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lWzeJQC+mr+oca7xZC3nO0JaKoztvyGFGTDpi5pXfwfCj00YtvhclPclptQ0HDjcr
	 5hpsawMvEp3Kns1TH1gPrk1Y67UFx4zkELTGsgkWexTrghArMDuEJ8WxXWzOFAl2Fi
	 BdxOU9Y4XiKA+9pmJuMbyI7DNe7pby+a07Oh1O8ynLfp37v1GgQQoRQPoV8YtfCFyc
	 0xdjf0RaAMgTl1FaEYwMxGSJT3iXODLfPaE8vaoxxCu9q0be+4DRT05dWyQbeCv8JJ
	 ml20dwYj7XlY9lMXjoV0l5+DLDEc992rZMrNAby1ODr9Zdou0bljZPFIBL0mkNFXtl
	 X3WCa4/lSDu+w==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-60d666804ebso642901eaf.1;
        Wed, 16 Jul 2025 11:59:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUez4EVJGkJRZIVpGC+dxhVTuQMDnUoQSFglVnzZRsI9aT0MJLqiJZNOMXJFgKvqlfd3lnkEJ16vC5xxlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhHlctlCgHdojRD5rJiuczVF6spLw65krDfHG3VMrTSA9EvS74
	nImA8+jm1Wn5SXn3k1IHsroPi1NJlzRWVu4ykj5gdOV81GvcLaIyGjS2VbOQJfO0PS6MyU03dc6
	5goNzRqHj1O8yH5P+MNwPg94JUZnhz5E=
X-Google-Smtp-Source: AGHT+IHNiSZSOiDpfj4Ghoq7jk4CaTDYvI0dRNkivlLTQMRgzcWUP4tRe5rmsbs0JHmGP2fEZEWsDySvyL9QsZSdklM=
X-Received: by 2002:a4a:ee17:0:b0:613:bd07:54cc with SMTP id
 006d021491bc7-615acb4ab78mr472990eaf.0.1752692356749; Wed, 16 Jul 2025
 11:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12722151.O9o76ZdvQC@rjwysocki.net> <998ca55d-13b5-4f10-819e-47d674ba3504@linux.alibaba.com>
In-Reply-To: <998ca55d-13b5-4f10-819e-47d674ba3504@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Jul 2025 20:59:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iBQ6MDgTKx9F0vG5EsDCMswkAknZaAHtohAqA8qG=GrA@mail.gmail.com>
X-Gm-Features: Ac12FXxG0MwX8IAG9qg6MQ8xDH_WFTmdb7QvIY4R3_Nmk4QK4-4oEXkTK5QofNw
Message-ID: <CAJZ5v0iBQ6MDgTKx9F0vG5EsDCMswkAknZaAHtohAqA8qG=GrA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: APEI: MAINTAINERS: Update reviewers for APEI
To: Shuai Xue <xueshuai@linux.alibaba.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 3:37=E2=80=AFAM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
>
>
> =E5=9C=A8 2025/7/15 21:20, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Update the ACPI APEI entry in MAINTAINERS by dropping the reviewers
> > who have not been responsive for over a year and adding a list of
> > new reviewers.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > The new people in the new APEI reviewers list, please send your ACKs fo=
r this
> > change, thanks!
> >
> > ---
> >   MAINTAINERS |    5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -306,10 +306,11 @@
> >
> >   ACPI APEI
> >   M:  "Rafael J. Wysocki" <rafael@kernel.org>
> > -R:   Len Brown <lenb@kernel.org>
> > -R:   James Morse <james.morse@arm.com>
> >   R:  Tony Luck <tony.luck@intel.com>
> >   R:  Borislav Petkov <bp@alien8.de>
> > +R:   Hanjun Guo <guohanjun@huawei.com>
> > +R:   Mauro Carvalho Chehab <mchehab@kernel.org>
> > +R:   Shuai Xue <xueshuai@linux.alibaba.com>
> >   L:  linux-acpi@vger.kernel.org
> >   F:  drivers/acpi/apei/
> >
>
> Acked-by: Shuai Xue <xueshuai@linux.alibaba.com>

Applied, thank you all!

