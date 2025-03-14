Return-Path: <linux-acpi+bounces-12234-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2869A60DC2
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 10:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E703717A17D
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953711F03D7;
	Fri, 14 Mar 2025 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOHOOvx/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917931D5CC4
	for <linux-acpi@vger.kernel.org>; Fri, 14 Mar 2025 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945705; cv=none; b=Lh1bJj/ZT6v8+4Att/k3Q3689pi+rAK2VcPWw55CImtPEHhc0Hgfi0iLJ6FCMvlc72dHEhWBuc1wrcllI1GZ0ZQvhiD16UEBkTO2Sd33bLulRSp+ChqLs9cEE5gqq5pb7cSFE0KA0gD1YtfdT6YwVMEXWcv/5oB8NRG2aZ9/FKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945705; c=relaxed/simple;
	bh=ntrXBr+INEaTdjjIuTH+2ThTesvG7vd12dHm2Z44+kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sm5AlDOArrh+gA12+I2bFCw8n8fil1D8ZteH3gFaFVa5mZfak5359mlTiDa/CM1JshYDbaeT9PK9AnimzEij2HosND/M88Jdax7T69H5ACCgLa8JzIrh17FnzRFVbzPTcaGz6s/TX+zPoPFvWSBbnYyOqN8q/5T20KaO3cQKO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DOHOOvx/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bee278c2aso31177921fa.0
        for <linux-acpi@vger.kernel.org>; Fri, 14 Mar 2025 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741945701; x=1742550501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FD6bznsu01iYGcm6ewJe4RuYE462CwiH5xGheRZGZw0=;
        b=DOHOOvx/mmRGl3azR92KT5IuS/fBneL/4J9rWUDNTWUEiI+oIiI1GoWcLzxcKDwjqi
         6t3luIJollkQTLEgYJ4o7ZcwY//58IWreObq3DQvFjli1V/tLpzEMEracAOIpE3uuAsF
         FkUe3mUb8HDpL68m9UMEDjTLVhqkBS9g8wdFtjvp8eG2jejfge7hu9R9eVgSH+i0pemx
         yu8ZeN8tItXieyFGNWZdnxU4MebAk5bvY6+90x9WbF2f4BZxOas3KPATFMedRZwfCx3p
         I8mfL/LTXjKdvDHwlPlzFxTejZOgc6hRtU2OCRgcluxZr87CfRLjDXP7rZDRBqirM29p
         0n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741945701; x=1742550501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FD6bznsu01iYGcm6ewJe4RuYE462CwiH5xGheRZGZw0=;
        b=KSbd4VY4c0RzdZ+lEfzfDDicAb0DJifRs6Vxr2FFRhZzkiFxXpixh7izBPDFaceALH
         GVTXbQWdQTBb8Silyc4q6t8Y4v6upEkVJfG79+VW77c3YKJ1kXddCNzTbRR12jOyUCDD
         WrJs/H0caVv5YwpI1mxwx6A/Kff+6NNkIds6mLwnniE6eVdHk8+WqOByyRz56MEn3Zeq
         7mouW68RyFItczeY0uWqBSQc2cdRacSgR+L3bYAMQtlVFBt6N8tPqukeFMolf3EYNM86
         sMgbafSuj19PvZWtTuet+5zHb0u+ARQoGJQCu++1khdZHbD6Y3bh2voqw0j0Ij256qlw
         4UQA==
X-Forwarded-Encrypted: i=1; AJvYcCWvL8NFwd1ngcVh74Bc5WfBvNJngv6lxEBHUTPxjfY+ODQImZZu1gIJqub2O5HQm81h419vLDTrxO0j@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy8IszkqzLX1PZS/odmn4VfsvgJVYr8QaDCNNqqmtJ+HhUs2ar
	WVS1DwoOTJ06rjg2vNuVJPs07S43pqIo29jTdQBN48tRQyDQXD59VyD22SblTSkRpI1DuQi8PGD
	hCon6aNDwHdHLOyNXfrNTaFyS8YwalR2M+aUzYQ==
X-Gm-Gg: ASbGnct5nOqLo2UwGUFXoKs82eqMSZXj+tCEoJZgTYOmlZe1J/s4jYAElnraw05tD7/
	42ar6zyERr3yRdpl8ZVAFtH4FqJeT5R2v8C3//Khei0fA50PAgtE8AphuM7cJkVCql7M3yRzY/S
	GOl144guy0aHHeZAGzeDIhFkfPtC2no6M=
X-Google-Smtp-Source: AGHT+IF+BXUJPCiL1c7sbvSs4gfqol1v20qox8jtJslAuMcy8M2YGJF8kQcGGVoAZtCirbS3VlFVKlXtncaYF36CYig=
X-Received: by 2002:a05:6512:ba8:b0:549:7145:5d2d with SMTP id
 2adb3069b0e04-549c3f97f37mr544029e87.16.1741945700612; Fri, 14 Mar 2025
 02:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SJ1PR11MB61295DE21A1184AEE0786E25B9D22@SJ1PR11MB6129.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB61295DE21A1184AEE0786E25B9D22@SJ1PR11MB6129.namprd11.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 14 Mar 2025 17:48:09 +0800
X-Gm-Features: AQ5f1Jp8h2KQrj8cXSVVa65hkY1o46EVlIPZXIQrn2pTPHmKX_laXhYL3waLDDA
Message-ID: <CABQgh9HBqbJYnUqJzG+nOY=B8nQ-8Scy8i0ctszBm8rzpocNFw@mail.gmail.com>
Subject: Re: Regression on linux-next (next-20250312)
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani" <jani.saarinen@intel.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi, Borah

On Fri, 14 Mar 2025 at 17:18, Borah, Chaitanya Kumar
<chaitanya.kumar.borah@intel.com> wrote:
>
> Hello Robin,
>
> Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
>
> This mail is regarding a regression we are seeing in our CI runs[1] on linux-next repository.
>
> Since the version next-20250312 [2], we are seeing the following regression
>
> `````````````````````````````````````````````````````````````````````````````````
> <4>[    6.246790] reg-dummy reg-dummy: late IOMMU probe at driver bind, something fishy here!
> <4>[    6.246812] WARNING: CPU: 0 PID: 1 at drivers/iommu/iommu.c:449 __iommu_probe_device+0x140/0x570
> <4>[    6.246822] Modules linked in:
> <4>[    6.246830] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6-next-20250312-next-20250312-g9fbcd7b32bf7+ #1
> <4>[    6.246838] Hardware name: Intel Corporation Arrow Lake Client Platform/MTL-S UDIMM 2DPC EVCRB, BIOS MTLSFWI1.R00.4400.D85.2410100007 10/10/2024
> <4>[    6.246847] RIP: 0010:__iommu_probe_device+0x140/0x570
> `````````````````````````````````````````````````````````````````````````````````
> Details log can be found in [3].
>
> After bisecting the tree, the following patch [4] seems to be the first "bad" commit
>
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> commit bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c
> Author: Robin Murphy mailto:robin.murphy@arm.com
> Date:   Fri Feb 28 15:46:33 2025 +0000
>
>     iommu: Get DT/ACPI parsing into the proper probe path
>
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
>
> We also verified that if we revert the patch the issue is not seen.
>
> Could you please check why the patch causes this regression and provide a fix if necessary?

I just send one fix caused by this patch
Just FYI

[PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER

"bcb81ac6ae3c iommu: Get DT/ACPI parsing into the proper probe path"
changes arm_smmu_probe_device sequence.

From
pci_bus_add_device(virtfn)
-> pci_fixup_device(pci_fixup_final, dev)
-> arm_smmu_probe_device

To
pci_device_add(virtfn, virtfn->bus)
-> pci_fixup_device(pci_fixup_header, dev)
-> arm_smmu_probe_device

So declare the fixup as pci_fixup_header to take effect
before arm_smmu_probe_device.

If your system has fixup, it may need a change '
from
DECLARE_PCI_FIXUP_FINAL
to
DECLARE_PCI_FIXUP_HEADER

Thanks


>
> Thank you.
>
> Regards
>
> Chaitanya
>
> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250312
> [3] https://intel-gfx-ci.01.org/tree/linux-next/next-20250312/bat-arls-6/boot0.txt
> [4] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250312&id=bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c
>
>

