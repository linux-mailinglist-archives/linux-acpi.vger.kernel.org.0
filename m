Return-Path: <linux-acpi+bounces-12812-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4CBA7EC5D
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 21:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4867F3BEAB9
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 19:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D72E21A458;
	Mon,  7 Apr 2025 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKn5WvM1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF2219A71;
	Mon,  7 Apr 2025 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051472; cv=none; b=N8llArKv+aN7/OLeOzT+tJYVfnlh6H19cbTofmwuIo6WA3+S2LuiWt/8G4SSv3wcDGUghG50YePcx8X+t1I7azJ4QGtoGGW1u7ORFHcKaH2IBUFFyl8gbqaJyojCyq4Ik4NpMT4RHTw8mUIon4niF54Vnl+WgnLHMNV9ZTRM9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051472; c=relaxed/simple;
	bh=jrjhlUOHynHcx5AA4mfIaHb/PgLP0VTcSvdCpFklOW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dk1n3S8MztV+ZqlbgvQ2yJnFfGMXnrvGp17wupL7yMkN0VEkEsVB+RBQingz2CNo9mMseDXtj23Mi/11G0DRN96HbgO2FOIplnWfTNvlsgomubjBHoFjGZF95E5LOEbq4lcYhElEJr5M8CrYQAMY9IFZ+pGQB2C4U2iOcsnkk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKn5WvM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E3EC4AF09;
	Mon,  7 Apr 2025 18:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051472;
	bh=jrjhlUOHynHcx5AA4mfIaHb/PgLP0VTcSvdCpFklOW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QKn5WvM1GA2AG/Svczk91A+QLVZHuPEjHGZL2Ki++3DDWdp6SiIMXejUhyXUIeVMu
	 ZSuyvhf4bwZPZO1P2W8PofkaaIGgapcN2NXabAliaVyKaWhCvSHv667qKPVcwCyTzx
	 RCEwzvjhJ3Peat3KzL2RTXiRRZ+Do/RTvSn9s3+YsuHsDou2OHBnbKL2wRm6FWP6Mm
	 KaVDYMY/OuEfWcM4h4ober+VpcL3MRL4s3H06SSgExxYZmJ+vd2WFTw/V7TRg2pvVT
	 7uFMfnX8D5jpAjF/R35c2HSOAirgDDCVj3PlqFV4I6M4B+iV+qGw9tPrReDzCRkyjM
	 MZyJBfV/KJHZg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c77f0136e9so1572002fac.3;
        Mon, 07 Apr 2025 11:44:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXEQHv+wyiDxXREyjO15iQi1JmLXBgIDfN5h0QyEr0Y4vCJb1MAG2MtutvWGzoiQIc/9ent5ztscUR@vger.kernel.org, AJvYcCVkyQ/W/JV8PMPZ7U3ZzyBOlt1zK1+MlSpsE0beB7X/LnSSuC5AQ7pg1tS6ekPhhADoWM/SJSS3JTo5GuHo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7eT68pGYfn5CrESxDXJ/qrIFG5sfFbB+z4Ko3FPrq4egCxFpK
	+cf2ZSNOWwZwUrbubyiaIWRTCRKqQf1yErlNblRyHg1rTyWJArNSaY2W5P9VDohkDTVAKMsHc4q
	Jajljs+KkOi9trPjw7SaBzpOt8nQ=
X-Google-Smtp-Source: AGHT+IGDKEf4L7LLFk6lEMOK9b//paytgxDhy9rdlk4xNS3DtC1Jd1+QhbDCRgSMgnpkHk3WYbiF8WA4V/9SCb1Idas=
X-Received: by 2002:a05:6870:a79b:b0:2c2:b9cc:afb8 with SMTP id
 586e51a60fabf-2cd32e4b747mr5718988fac.7.1744051471468; Mon, 07 Apr 2025
 11:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331163227.280501-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gcbnWA4Whyn-x7uaqEbPow9Sqa3_GO4Z_cBcpYLcF3RQ@mail.gmail.com> <Z_QbFgSFMv58-QmM@smile.fi.intel.com>
In-Reply-To: <Z_QbFgSFMv58-QmM@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Apr 2025 20:44:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hFNqUTVn4wVqigzhHTnmPU63+Z8iFwv++=gx8P7A-cow@mail.gmail.com>
X-Gm-Features: ATxdqUEaxWSnaUVQQPj9SUIA5lG4Bpvuf2UCM_7ORvRYQjAbNkPgmEJXzzlo4q0
Message-ID: <CAJZ5v0hFNqUTVn4wVqigzhHTnmPU63+Z8iFwv++=gx8P7A-cow@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Add a note to the fwnode.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 8:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Apr 07, 2025 at 08:17:17PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Mar 31, 2025 at 6:32=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Add a note to the fwnode.h that the header should not be used
> > > directly in the leaf drivers, they all should use the higher
> > > level APIs and the respective headers.
> >
> > This sounds like a solution to a problem, but the problem statement is =
missing.
>
> > What's your motivation?
>
> Found a few drivers that are mistakenly include fwnode.h while they meant=
 to
> have either of.h or more likely property.h.

I see.

I would then say

"This header file provides low-level data types and definitions for
firmware and device property providers.  The respective API header
files supplied by them should contain all of the requisite data types
and definitions for end users, so including it directly should not be
necessary."

And I would mention that the purpose is to give guidance to driver
writers to avoid repeating a common mistake.

>
> ...
>
> > > + * Note, this header is not meant to be used by the leaf drivers.
> > > + * It provides the low level data types and definitions for the firm=
ware
> > > + * and device property providers. The respective API headers should
> > > + * guarantee all the required data types and definitions without inc=
luding
> > > + * this header directly.
>
> --

