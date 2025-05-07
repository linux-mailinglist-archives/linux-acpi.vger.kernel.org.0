Return-Path: <linux-acpi+bounces-13612-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E27AAECAB
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 22:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3237AF5D0
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 20:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD013207A22;
	Wed,  7 May 2025 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/p2ej6A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B661DD877;
	Wed,  7 May 2025 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648390; cv=none; b=G9DcjzvN+gMafqzQ7s4hGn30G3vqs7Qwyob8zXmLEevjwGNkHV81yJgZjN5n6al2HvHJAo+azFHCPl4RUr6p7CJens45zAV8fytG1koY3PXFRUFELdAFcDMWbrt043NpNo9KrOkTjUf+kokg4OoRqbp1RKcy3mT6lu2CEMyQCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648390; c=relaxed/simple;
	bh=5a9DCd5aeaRGsOQ99DfkXpo2NibiBiAJqVSk1lPL7Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeFC9CpGvTITRTCPrI5/HO34+F2zwAwwPld3uOkPvd1d0JotLUpgQLxvfcESLTWKJOv2EN7A+Gz/5NEHQEI6f1oF+4tdLG133MArP39pLnE4vnGc9WFKIfef/CwQ6rVKj3vy6dtYb39oKrfUWohVAnR/47oqMIh4tX86/h+r7l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/p2ej6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A389C4CEEE;
	Wed,  7 May 2025 20:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746648390;
	bh=5a9DCd5aeaRGsOQ99DfkXpo2NibiBiAJqVSk1lPL7Ms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E/p2ej6AqC6dPjbwREPzUAnHBknt3QtLWsB+5qhZafYNzSEcVhAN+68d5Rc72qKZg
	 fgZswwXAfgp8AoU+C/nn5QmmUhFzB97bl74wWDtOCp92YaBI/0bnohXa20/DAA8uzt
	 HHMLIsdclgTesgE9kUXcRvSI1FHGLUTB1epLrJcuQRQ73ggMUgSzVWq11xDiVeXbR0
	 YkzjfdUvZfHowmpghA4Wj0Dv0N2nyDANASyGU1/y9mRT1Mi6NAYPOhfop0y8MCOhkd
	 KwvUfXIRafnOJwmkqK7T3ILaeBN5gQ5OJ8VtRHa5w8Dwzc/p7b4vwT1O0f2WdeySkx
	 9bpapE11bxCZw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2d54b936ad9so152059fac.1;
        Wed, 07 May 2025 13:06:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV573tkSbJ1N5s0MKShgLTDPx7MovTyjoP7oDCKCmjMIqU0E35ShBFcBmmzUOj1TTy2JPJLIBFKRyUt@vger.kernel.org, AJvYcCWZUvYsWKxfPEcjvHwFR4694Z7bc/IdQEGu7x4Vn64ONE3BE07yheVMHbsg+XfWoiVpGHMjJNIX3HKIJWXA@vger.kernel.org
X-Gm-Message-State: AOJu0YyEMj/90VMfsncWQ01DxbF2jvTs83BeextVbhfKRDxy+irnYmNl
	tN0UQZDSy0+Ed0vkmq1qdT7kvojCso1j+E39NlAIfUXokwkHo0JD7VrdtS4ZWQJcg3Ze8poneKc
	Ad4HbXL5EJzNsEI+xiQS67oJqNQ8=
X-Google-Smtp-Source: AGHT+IGnydU3H8sqGsX8B4o+4mQs44hFfkMJPXHjk2ZWhlSgCaespw5/yCH5Kj1oZ4JnryyItjnwijXNg1gzS/icwOk=
X-Received: by 2002:a05:6871:eb01:b0:2d6:2a1b:320f with SMTP id
 586e51a60fabf-2db5be3253emr2712159fac.11.1746648389369; Wed, 07 May 2025
 13:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331072311.3987967-1-andriy.shevchenko@linux.intel.com> <20250502151537.GA2724505@myrica>
In-Reply-To: <20250502151537.GA2724505@myrica>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 22:06:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iOVmoUS+N5KkEBAzRjXP2OJz4G3Ypr2+1m5bHKFkKsPQ@mail.gmail.com>
X-Gm-Features: ATxdqUGR08Rwoah6vHsSgWmAF82DpX4gvPylL0AHWH27WeSyQZeQYEPZ2nG1RoM
Message-ID: <CAJZ5v0iOVmoUS+N5KkEBAzRjXP2OJz4G3Ypr2+1m5bHKFkKsPQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: VIOT: Remove (explicitly) unused header
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-acpi@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 5:15=E2=80=AFPM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Mon, Mar 31, 2025 at 10:23:11AM +0300, Andy Shevchenko wrote:
> > The fwnode.h is not supposed to be used by the drivers as it
> > has the definitions for the core parts for different device
> > property provider implementations. Drop it.
> >
> > Note, that fwnode API for drivers is provided in property.h
> > which is included here.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> > ---
> >  drivers/acpi/viot.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> > index 2aa69a2fba73..c13a20365c2c 100644
> > --- a/drivers/acpi/viot.c
> > +++ b/drivers/acpi/viot.c
> > @@ -19,11 +19,11 @@
> >  #define pr_fmt(fmt) "ACPI: VIOT: " fmt
> >
> >  #include <linux/acpi_viot.h>
> > -#include <linux/fwnode.h>
> >  #include <linux/iommu.h>
> >  #include <linux/list.h>
> >  #include <linux/pci.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >
> >  struct viot_iommu {
> >       /* Node offset within the table */
> > --

Applied as 6.16 material, thanks!

