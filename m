Return-Path: <linux-acpi+bounces-9569-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44869C7DBA
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 22:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF0E1F23280
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 21:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3941818BC0A;
	Wed, 13 Nov 2024 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tyGmpIxR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538D18B483
	for <linux-acpi@vger.kernel.org>; Wed, 13 Nov 2024 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731533934; cv=none; b=YcB+Hcp67zpEVxXBVyPcBYvYebLPjCnDpPvGv3xZxLjtUnE8AqUyG81z1epKCzYhRnIf7AVpVLOWJOyU6sBnpP5zKFjWJRRHupwMeQaoAYD32cLnVn0Ue3KaZ8IDl2b20bUvlpYUbuMbTHA4S1SdcWenxr77k4vMribiNbHeqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731533934; c=relaxed/simple;
	bh=h3pNFM0oblrUYOB6pkkCwK/sr+vTUFr1C8PiWtlv8rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEibl1XTVTO0mzLLmyI6ldWl6MQ8zMtSqLe/vj9reSjCswcX13gSGsCFo5EF2UT9YeOtUPiVw68dBc1DVwMI8urcbTQ106fToIqDLMeUOO8FXVf1YJjsmkM4ZkQfgEYd6K+d7bDoKFDM1rRRxops4iB5PFJdwUmssJNYRkg//+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tyGmpIxR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-210e5369b7dso78257725ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 13 Nov 2024 13:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731533932; x=1732138732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/SIxTh7J31xbTMjPP69b/bUoDVK1zzpUJ9rscgsMJY=;
        b=tyGmpIxR2G8GWmo1ECXKwrB/S61FrGFI6J+mU082jp1bade0uh/BpZDpthLvYrd+hz
         5p67nLz2PAyngYFFVQHsBVjXDyZ+0KoHoqqCK2D37x8bZ07TzMK6gPL4QLj2R4L0KgC3
         sVOFagi8bvmbao9rvorJIJjCCB1Qz9J2e3JAiHirPwcJxFjSQlMJoEG6qZTiXFKIKLPJ
         K/le1vkzw/1/nCcEzqlMc9hLCuKOscOi9yaLSF7bpBAPQvSP4KLu4o/q7W8cS//OASPT
         i/yydlo/4UMMjKTjNEPkiMJmnVIH/gR4N3dstqf8YP5t+oOwdz4joxnbO631e2pQBDX/
         xy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731533932; x=1732138732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/SIxTh7J31xbTMjPP69b/bUoDVK1zzpUJ9rscgsMJY=;
        b=lMbE9ULKDuG/efjbjrZtb+4GpR1gvQV1w6gJ4dSTKAzeQuKOLtznJp5OvWlDfDT18p
         gwke+LNItgOxbSfCSaYTK3Esw4nk/WLwMMO11FGmPlpaJDzDfxvPUZ+/DXm7SBv1q8r/
         yX2bb7khgbc1Ts61M/e1nJl/Zph4R5DjPtpHAzHnYPumDRnNGzS70RNSjoN3THqjsXdr
         KAD8M9JhiJE8HuswuXX1PqOEoQymhB+2ouabtHLL6SM2rvDwPRL3KyYongZGydwzsJ/K
         OypTMKjjMY+UsRRkFfY5eGojwmtiGTKuIkQyD0eSw91EhVDH+B6cr8cnOD63vQv7I0HI
         0brA==
X-Forwarded-Encrypted: i=1; AJvYcCV+CgImi12GuMMIprWqwY9M+ZcZQ7UkJD8FTxUW8bacTX2aPDvzn6s6MrUq76c7RiV0VLKGlYtujll/@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCxLn0p/wabSxh5nlPA+34YaNHTLr8WNE0FbwKTSYDTJEUzw0
	D25X/bHmDvmUu+QRkFfsRQqN1KII9l6i3P1yYEhD0Sgcb1SX0cLmgUlvWZ817NBe5SXE93p+2N6
	5S3kgDgHV23BUyLGQmQ5hwh7SW/SGZ6Ayuav5
X-Google-Smtp-Source: AGHT+IFSTZo8eDq5AVjULTxkBdn1QAACx9SVOAxHbG2ogMZWy2xpiXhaZKNwmM2oe/A96ZXy7LtkzQ+cUTRsIShcqKg=
X-Received: by 2002:a17:903:2447:b0:20c:895d:b41c with SMTP id
 d9443c01a7336-21183d55336mr284292875ad.41.1731533931844; Wed, 13 Nov 2024
 13:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220426172105.3663170-2-rajatja@google.com> <20241113202214.1421739-1-jperaza@google.com>
In-Reply-To: <20241113202214.1421739-1-jperaza@google.com>
From: Rajat Jain <rajatja@google.com>
Date: Wed, 13 Nov 2024 13:38:13 -0800
Message-ID: <CACK8Z6FHBj2eUp9Wrqg_ehY76hUZF7iEa+y7tFP0eT_7rdVT1Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
To: Joshua Peraza <jperaza@google.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com, 
	dwmw2@infradead.org, gregkh@linuxfoundation.org, helgaas@kernel.org, 
	iommu@lists.linux-foundation.org, jean-philippe@linaro.org, joro@8bytes.org, 
	jsbarnes@google.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	mika.westerberg@linux.intel.com, oohall@gmail.com, pavel@denx.de, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rajatxjain@gmail.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 12:22=E2=80=AFPM Joshua Peraza <jperaza@google.com>=
 wrote:
>
> This patchset rebases two previously posted patches supporting
> recognition of Microsoft's DmaProperty.
>
> Rajat Jain (2):
>   PCI/ACPI: Support Microsoft's "DmaProperty"
>   PCI: Rename pci_dev->untrusted to pci_dev->untrusted_dma

Thanks for resending. This probably dropped off my radar since I moved
on to other things. But I can confirm a lot of Chromebooks today in
the market already use this property (and this patchset) for
identifying untrusted DMA capable devices.

Thanks & Best Regards,

Rajat

>
>  drivers/acpi/property.c     |  3 +++
>  drivers/iommu/amd/iommu.c   |  2 +-
>  drivers/iommu/dma-iommu.c   | 12 ++++++------
>  drivers/iommu/intel/iommu.c |  2 +-
>  drivers/iommu/iommu.c       |  2 +-
>  drivers/pci/ats.c           |  2 +-
>  drivers/pci/pci-acpi.c      | 22 ++++++++++++++++++++++
>  drivers/pci/pci.c           |  2 +-
>  drivers/pci/probe.c         |  8 ++++----
>  drivers/pci/quirks.c        |  2 +-
>  include/linux/pci.h         |  5 +++--
>  11 files changed, 44 insertions(+), 18 deletions(-)
>
>
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> --
> 2.47.0.277.g8800431eea-goog
>

