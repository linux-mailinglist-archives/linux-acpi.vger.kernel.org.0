Return-Path: <linux-acpi+bounces-6841-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0A992D101
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 13:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E3AB26153
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 11:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B52919048D;
	Wed, 10 Jul 2024 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BY6u0s20"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8642818FC89;
	Wed, 10 Jul 2024 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612195; cv=none; b=WwIiEF+hWXdY+XwGZxYKbeh4MLkvC9S8hNWP90X6BO5B9KFTH/lZ+/dVuan1rcTs0jfOucrQAMoEMjLa2u35OlVqqi4TGp8aF6qII41Hbi8eclJ7ucBdDXJ6T1AUvaZaXMz562kEdbYpb/RBt1smxe8VOno2liFnUkFRCf44nh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612195; c=relaxed/simple;
	bh=Icr0XLd+tOg3lAw80ex57lRQGN7ul6Qtxts5UDyAvg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kukZJ1F+EVT2xQEmLsCGG9BJYd7V1DGJoj6amFxgcrSxgcFhWdJ18QUcaygzV7e4FlHXuXE6PEqIaVzzeNnTcj7yPhuxkO5+tysHMh8CL2GQU9u9SxZUATTQ2qK8gUMbNul/GeT5QiPpwDyrfnXSgJLWpHTbZtlx7e9ZUE5yTGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BY6u0s20; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1720612187;
	bh=Icr0XLd+tOg3lAw80ex57lRQGN7ul6Qtxts5UDyAvg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BY6u0s20vMPLvcKT8EiZ6u51jA8aJYTsyIkn4AkC5LcNxsPUrSEOB+KykKQ89LYBO
	 KWxkdaiat01fNaAzJXVBhz9VuKPdfRSNCxtoHTPtgdGz3zAUAGbchs9TSExoK7zmM8
	 zRlwzky5ISAMHdXmGuEkOKFs+3bMJMEJHBLdBGPY=
Date: Wed, 10 Jul 2024 13:49:47 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Lance Ortiz <lance.ortiz@hp.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/5] ACPI: sysfs: manage sysfs attributes through
 device core
Message-ID: <8c5c7067-7954-4fad-be3b-3b5a22cfbd5c@t-8ch.de>
References: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
 <CAJZ5v0iR4r6BFTd5fPEdoCVBv=c=HqyoV239Bd99tbO0gFihLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iR4r6BFTd5fPEdoCVBv=c=HqyoV239Bd99tbO0gFihLw@mail.gmail.com>

On 2024-07-10 13:43:57+0000, Rafael J. Wysocki wrote:
> On Tue, Jul 9, 2024 at 10:38 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > Simplify the lifecycle of the sysfs attributes by letting the device
> > core manage them.
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > Changes in v2:
> > - Add fix to validate buffer type validation (patch 1)
> > - Drop usage of devm-APIs as these are unusable for unbound devices
> > - Evaluate _STR on each sysfs access
> > - Link to v1: https://lore.kernel.org/r/20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net
> >
> > ---
> > Thomas Weißschuh (5):
> >       ACPI: sysfs: validate return type of _STR method
> >       ACPI: sysfs: evaluate _STR on each sysfs access
> >       ACPI: sysfs: manage attributes as attribute_group
> >       ACPI: sysfs: manage sysfs attributes through device core
> >       ACPI: sysfs: remove return value of acpi_device_setup_files()
> >
> >  drivers/acpi/device_sysfs.c | 196 +++++++++++++++++++-------------------------
> >  drivers/acpi/internal.h     |   3 +-
> >  drivers/acpi/scan.c         |   6 +-
> >  include/acpi/acpi_bus.h     |   1 -
> >  4 files changed, 89 insertions(+), 117 deletions(-)
> > ---
> 
> If this is not urgent, and I don't think it is, I'd rather defer it to
> the 6.12 cycle (that is, I'd apply it after the upcoming 6.11 merge
> window).

Sounds good to me.


Thanks,
Thomas

