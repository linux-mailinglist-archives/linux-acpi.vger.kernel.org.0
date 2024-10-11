Return-Path: <linux-acpi+bounces-8712-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5F099A2B0
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 13:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC34282E1F
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6DF215F78;
	Fri, 11 Oct 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdqMS35B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039721502F;
	Fri, 11 Oct 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646116; cv=none; b=MIetMwyV4HP1N7j8M/Q/T94FF9XL3lVaE4zw4m1K3DyZGx4p8vWw/sJ+OpCzdqTG9fL7kk+KkvxlN9BToagcB8NTh7Ad1dFOpanQDwcf22a7bI3y5yRKPitnJxbiCVbG7uQclC/AorGqQli4wjHDvqmdlh+uQ2iLEpqJf5b38+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646116; c=relaxed/simple;
	bh=b2BF6aX7yvuhV1cDjKTs1FC2L3sf5W+ct6S8Jto4oYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukVaEpPl0/yUnZyTWdqYvjyOYrMtFTFOpjjY8naBIkJtYUj6DsM6agwY58QMYBTihS/3/sFT1I3v20OjWTkcOAox9ic4Yq5msuOVQiXaJKVCSAUf3ADEVLxGr8+X7MRD1A+IcVPQT8GgoqKos/kBVFgnZeruzCOskrMyn9KqP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdqMS35B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5FEC4CECC;
	Fri, 11 Oct 2024 11:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728646115;
	bh=b2BF6aX7yvuhV1cDjKTs1FC2L3sf5W+ct6S8Jto4oYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KdqMS35B6UT2S28pF+yBRfQNR4yHsE/zeX5qAGEOTTZdTROCOmPdwHJYn2dGpv5Fz
	 PEA215lw+JKXy+tgn52/ohxrdik7b+tp3fsufs58id5d9q48olMLDUh8fDySUn6xtv
	 bmz6zFZU6tOJLOtuqOdF1ViWf5TRMOb45VZebmwPVSUt9Upf6ylua0dKJF4SoEXJd1
	 pnGVMMolvNKXZCzI/M6W2JoMIR+CHlqxncb6d7FcrByXtGzzdDB23A9aksgRgXcgnL
	 5j66kPmSsOugPGWsoA2yxrj7Q8f1m/OXJhxsud9cWDck6UpahhF5HrSAeSSj7wjzWt
	 LQ/uYQMwBXFpA==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-716a5b9ee6fso1016948a34.2;
        Fri, 11 Oct 2024 04:28:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUITq3rPOsKr3tWueA7ZAPP3agGn5t5LrPKODzDKFb/0Twdr8QRAc0ZkjZsufY+woK2BnmYL72NNXtW@vger.kernel.org, AJvYcCX/qgHqrl8OMAox1YQaQSeG1TRx7nUwS4ncA6f+KolCyZHwr0TxIMpboEblOQN+tzTvfV4kSNEB88GR/KZl@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUyI6I8XOzE+J4VrM5mQz9rv5imu4iuFDxorV6xQU4kvUDRMC
	g998gsIPfKCdy+PofQNG18/mj5UohWezKA/bTVLrL9UnopFpjLgFeh/9KGE2+5wyODjAoXx2vmi
	MSXgP4DLKi/T/BB0/cCAsSf3hb44=
X-Google-Smtp-Source: AGHT+IGtFi7+XflJhdoe2a845QyQCYPlrIQbcAmzlN087fwENXDcaP9JxbSbHXIU/DeakWbMWjuPPBRMY8zguyxW7Xc=
X-Received: by 2002:a05:6871:5226:b0:261:2072:7b5d with SMTP id
 586e51a60fabf-2886df8928dmr1333630fac.29.1728646114921; Fri, 11 Oct 2024
 04:28:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011061948.3211423-1-arnd@kernel.org> <20241011061948.3211423-2-arnd@kernel.org>
 <Zwj1p3uMEA24a0sU@smile.fi.intel.com> <de65a5c8-1bbd-47b3-9dc5-de4ad93c41b8@app.fastmail.com>
 <ZwkIFREb1Ia90hSR@smile.fi.intel.com>
In-Reply-To: <ZwkIFREb1Ia90hSR@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Oct 2024 13:28:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hG0o3jxH_HnS76s=VUC28M4fY5yuWxQttGSkCX_SvCSA@mail.gmail.com>
Message-ID: <CAJZ5v0hG0o3jxH_HnS76s=VUC28M4fY5yuWxQttGSkCX_SvCSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] acpi: allow building without CONFIG_HAS_IOPORT
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Jarred White <jarredwhite@linux.microsoft.com>, 
	Perry Yuan <perry.yuan@amd.com>, Easwar Hariharan <eahariha@linux.microsoft.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 1:12=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 11, 2024 at 09:59:46AM +0000, Arnd Bergmann wrote:
> > On Fri, Oct 11, 2024, at 09:53, Andy Shevchenko wrote:
> > > On Fri, Oct 11, 2024 at 06:18:18AM +0000, Arnd Bergmann wrote:
>
> ...
>
> > >> +  if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
> > >> +          *value =3D BIT_MASK(width);
> > >> +          return AE_NOT_IMPLEMENTED;
> > >
> > > Perhaps it has already been discussed, but why do we need to file val=
ue with
> > > semi-garbage when we know it's invalid anyway?
> >
> > It's not strictly necessary, just precaution for possible callers
> > that use the resulting data without checking the error code.
>
> Do you have any examples of that in the kernel?

Yes, there are at least 2 cases.  May not be relevant, though.

> > The all-ones data is what an x86 PC would see when an I/O
> > port is read that is not connected to any device.
>
> Yes, but it's not what your code does.

Care to elaborate?

