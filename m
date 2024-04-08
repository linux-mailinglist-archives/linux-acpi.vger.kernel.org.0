Return-Path: <linux-acpi+bounces-4752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D520289C6E7
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 16:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75ABE1F231DB
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE428662A;
	Mon,  8 Apr 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NedOmmMy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962DA8061F
	for <linux-acpi@vger.kernel.org>; Mon,  8 Apr 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586145; cv=none; b=epQIeK0tgmhcXetiNdgZ1d1otMwt6h58Lcdl7Z8/+bLSdL5j6p2biohOdxsdhScaq49GFLFp9uCEKRocB+fqqy5wqC3Vg2oGJaj59phxruDrSAWIvoL4r/OYrh+xeyuJqj4w0ADIKcQGwrPWSPOVykHGG10FJYWfsOHE43OfiL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586145; c=relaxed/simple;
	bh=V5SUuy03re6znkRGtk9U1rmn26usMcAFyTE1U4SRBxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvR7Qa0ogBaXPKum6isZJx1U60gjKVcHtWbPgrMxAJVKAjd4qe3vTGEhsOq77ljtYg+XViINYX243uZ5MJTTh6AYJA8i/zS4GtfdO/JYtS9Jkf9eZ8DoWFPIjFTi3RMS4yPuhdVZUZBezT4cQwSUMvlrfjSFiuSU8ImZRwjeDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NedOmmMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EC9C43390
	for <linux-acpi@vger.kernel.org>; Mon,  8 Apr 2024 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712586145;
	bh=V5SUuy03re6znkRGtk9U1rmn26usMcAFyTE1U4SRBxE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NedOmmMyJt4byNbXThyO5+MeunYxaCE1Mf11d5aY3XkZOUYZ8HCUJ19MIDjlga2Ws
	 8TiNbrHmzns3K0Eal3lB3dwod05qXlb9oKU+ZcaEcLAPVZdiodhgNbupWgJL3xIvOz
	 N6poGLfiO1OtuJqcbfVo/1dXQRl93pihmAE8nvGNHun7xgw8SSCF4Y4CkPefa+j8Zq
	 pKgRVKNAleu1GUhJunowKiTFPXAujsRkSD7fiLqWntIjRWqjwuElyqbZ9FXH0LItwG
	 Y86MKkGAFfoJYOOZXs8U7sfLVyWic2m32QGqACz1MODF5f+jb+gGqObLR09H6paivz
	 35lWF1VT+2Q2Q==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c5f468a2faso311403b6e.1
        for <linux-acpi@vger.kernel.org>; Mon, 08 Apr 2024 07:22:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWC/mTPNQWu45V+QzxFIoxU1YLBslXuQAT20wgwdWzWAdE66lk/twy+xY2o9jfJqtcpyg63zbGCRM8kXUQjtc3gPRnmmamQMocrcQ==
X-Gm-Message-State: AOJu0Yzwx6XvvgwDLI1dSAfD1qX4YrBWDuZNfhx8zzEr5l2+mWM3RVX0
	NVHAfowHcBjy3xAUSppGw8mquK4RnrHcWvvx46FfquQVAJOEnOYnDHWVYTguok+soso9PDPW3R3
	3LxzyQU19cweV72A9ziZ9A4ltK1s=
X-Google-Smtp-Source: AGHT+IH40QvM1h+NSd47sofz21TU9GSb3jsdj9E+IsYwfU0HpQLuov2cmh5WOhiG+nxBAfvQ6emvpH/dSayAeEaVCgA=
X-Received: by 2002:a05:6808:1c5:b0:3c5:f187:2089 with SMTP id
 x5-20020a05680801c500b003c5f1872089mr3406192oic.2.1712586144501; Mon, 08 Apr
 2024 07:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329100203.540368-2-u.kleine-koenig@pengutronix.de> <66070eb518072_4a98a294d5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <66070eb518072_4a98a294d5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 16:22:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hvNrLN19Wo-NPGNi8=asRAUhXPtu4LnJ=f6aKQ63wzyQ@mail.gmail.com>
Message-ID: <CAJZ5v0hvNrLN19Wo-NPGNi8=asRAUhXPtu4LnJ=f6aKQ63wzyQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: mark remove callback as __exit
To: Dan Williams <dan.j.williams@intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Avadhut Naik <Avadhut.Naik@amd.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>, 
	linux-acpi@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 7:55=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Uwe Kleine-K=C3=B6nig wrote:
> > The einj_driver driver is registered using platform_driver_probe(). In
> > this case it cannot get unbound via sysfs and it's ok to put the remove
> > callback into an exit section. To prevent the modpost warning about
> > einj_driver referencing .exit.text, mark the driver struct with
> > __refdata and explain the situation in a comment.
> >
> > This is an improvement over commit a24118a8a687 ("ACPI: APEI: EINJ: mar=
k
> > remove callback as non-__exit") which recently addressed the same issue=
,
> > but picked a less optimal variant.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> Thanks for the explanation Uwe, this makes sense.
>
> Rafael, do you want to pick this one up as well?
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Applied as 6.10 material, thanks!

