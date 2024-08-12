Return-Path: <linux-acpi+bounces-7523-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A233694E468
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5D61C2084E
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 01:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660B3568A;
	Mon, 12 Aug 2024 01:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="amf0xEzi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6D953A9
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424867; cv=none; b=kjVgKb/ySjc0gvHht8VWrmTLLKfQ4n9LNtPjn0NtQHpq1Jbe7tVyLdhl7/64YvZGU4dzfKUtgFUwO24b0XTcJ/EsDHNdKIaCr6p3ULD/4BQdS03V95WQesPdWN1w6rboeNG5lPLZlKwWFku+APhiQxLr11r64c0oeGr3PIRyW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424867; c=relaxed/simple;
	bh=2sNswRQwFYvamsccTf71Mx+B1uS30lOIX5Wufuwq/zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGtd+OFKEK2TvK6fER+mYFwmgun26VGNtBPaFqB1J7r9ugGDFbhXZN6DcsptJK3CqFo2KAMTNWOzsBDfw7b1zpcYwxTRo7Y71mkHawbBNYtKg4DCuHHpXTyw+Ho3m2FKQqACZ2Gm7v3rhIJF45F2Q/eAqczJ2A1HGmBc+2Qyxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=amf0xEzi; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb4c4de4cbso2419483a91.1
        for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424865; x=1724029665; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Crz27ST5X2jO2vrF90biTTCavSItjpCBUjBKFknbYQ=;
        b=amf0xEziBJb2sNeO4jSyRGdVgkHNX2zOA/UeCRm8jmDrwxK4nu6vzZFoxdubCf0kjd
         XsB05qOpMv5oy5Xz0s+cBzPXm78EUzWsSOhJHMwjHvCstOOFMZ2QmUqLjCpRARy+upxe
         G3rlzPIpD9ICX3QfiRu2MT8qpj5B51ALbx/4RqnWAEoIUEn27Zt4SqPb21NTM2l1HgIc
         1HByGIFEbfYAJVvmANq9vIO52qY/7lLya5eW48ALOXccddzS1foR5v+iW1VHDrbILz+Q
         YZatoh1t+dJx6gTOLulpo/fPKJ4n6hKHkUHXFit7baWebS3N79bVC/jpHXNda2/iAErv
         ydqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424865; x=1724029665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Crz27ST5X2jO2vrF90biTTCavSItjpCBUjBKFknbYQ=;
        b=hl8v52X6xwM+nt2Ci0CGyJi/MdlUGY5YBpUkaZirH6acZBrjshK9oSEGEDBJ072hd6
         xDa2IUg2fbQn/rbUiJ1EtHtzYZbt5T72VxuySRpW5PiRP+NOw6mwDO3ntjktsZKoYoFD
         DnuCqQdMkZYUzWlwF0YbpxoefjG+lrSUFPLk/k2Lh/0Lrufrn38RTOPjFibdXFXRkeyL
         UX07Pz57jX+MpwXJJTemBJBfa2GAaDkmtI6MOfpWaS/XiC6o/1s5cTK9usrsmsD/uW+l
         JIYeZK2E9B+4LbXoeIFWufRVPTGQO5kQMnYw3x59L3rIYEqo2lnzt47rCJg5qcg6VY90
         WbqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy9x8ggRFQCGpCTkPwwBQfaK50K06xb64HqIPQP4jHeCVI/ikEShJ/9yZYGG0PyHZtqtZcXq5+ZW7E@vger.kernel.org
X-Gm-Message-State: AOJu0YxFnvQUYEwta4jI1osK/6St1vXiq3/LYWSgErvGSIC2wX98JMUP
	V3wRNp0+g6lWnHtfJr9vJEq2A/Uhv/lYQ5SNp02z3Y8dp2+S3VAx33e1EITWYaQ=
X-Google-Smtp-Source: AGHT+IFy5zs1UKvROLW81s0IANcAfrd4dDGTMIm7sbcPUJ21ofUGfdTh3DNcEjKHaI13Ofh/d6iuAg==
X-Received: by 2002:a17:90b:4a42:b0:2c8:a8f:c97 with SMTP id 98e67ed59e1d1-2d1e8078a15mr6034174a91.37.1723424864290;
        Sun, 11 Aug 2024 18:07:44 -0700 (PDT)
Received: from sunil-laptop ([2405:204:5602:8c56:518:77d3:10fd:70a0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fcfed6c1sm3637969a91.36.2024.08.11.18.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:07:43 -0700 (PDT)
Date: Mon, 12 Aug 2024 06:37:33 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v8 00/17] RISC-V: ACPI: Add external interrupt controller
 support
Message-ID: <ZrlgVUXC_dCW9ISM@sunil-laptop>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>

On Mon, Aug 12, 2024 at 06:29:12AM +0530, Sunil V L wrote:
> This series adds support for the below ECR approved by ASWG.
> 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
> 
> The series primarily enables irqchip drivers for RISC-V ACPI based
> platforms.
> 
> The series can be broadly categorized like below. 
> 
> 1) PCI ACPI related functions are migrated from arm64 to common file so
> that we don't need to duplicate them for RISC-V.
> 
> 2) Added support for re-ordering the probe of interrupt controllers when
> IRQCHIP_ACPI_DECLARE is used.
> 
> 3) To ensure probe order between interrupt controllers and devices,
> implicit dependency is created similar to when _DEP is present.
> 
> 4) ACPI support added in RISC-V interrupt controller drivers.
> 
> Changes since v7:
> 	1) Updated commit messages as per feedback from Bjorn on patches 2, 3 and 8.
> 	2) Addressed Anup Patel's comments.
> 	3) Added Tested-by tag from Björn Töpe which I missed to add in previous version.
> 	4) Rebased to 6.11-rc3 and updated the RB tags from Anup.
> 
> Changes since v6:
> 	1) Update to commit message/code comments as per feedback from Bjorn.
> 	2) Rebased to 6.11-rc1.
> 
> Changes since v5:
> 	1) Addressed feedback from Thomas.
> 	2) Created separate patch for refactoring DT code in IMSIC
> 	3) Separated a fix in riscv-intc irqchip driver and sent
> 	   separately. This series depends on that patch [1].
> 	4) Dropped serial driver patch since it depends on Andy's
> 	   refactoring series [2]. RISC-V patches will be sent
> 	   separately later once Andy series get accepted.
> 	5) Rebased to v6.10-rc1 which has AIA DT patches.
> 	6) Updated tags.
> 
> Changes since RFC v4:
> 	1) Removed RFC tag as the RFCv4 design looked reasonable.
> 	2) Dropped PCI patch needed to avoid warning when there is no MSI
> 	   controller. This will be sent later separately after the
> 	   current series.
> 	3) Dropped PNP handling of _DEP since there is new ACPI ID for
> 	   generic 16550 UART. Added the serial driver patch instead.
> 	4) Rebased to latest linux-next.
> 	5) Reordered/squashed patches in the series
> 
> Changes since RFC v3:
> 	1) Moved to _DEP method instead of fw_devlink.
> 	2) PLIC/APLIC driver probe using namespace devices.
> 	3) Handling PNP devices as part of clearing dependency.
> 	4) Rebased to latest linux-next to get AIA DT drivers.
> 
> Changes since RFC v2:
> 	1) Introduced fw_devlink for ACPI nodes for IRQ dependency.
> 	2) Dropped patches in drivers which are not required due to
> 	   fw_devlink support.
> 	3) Dropped pci_set_msi() patch and added a patch in
> 	   pci_create_root_bus().
> 	4) Updated pnp_irq() patch so that none of the actual PNP
> 	   drivers need to change.
> 
> Changes since RFC v1:
> 	1) Abandoned swnode approach as per Marc's feedback.
> 	2) To cope up with AIA series changes which changed irqchip driver
> 	   probe from core_initcall() to platform_driver, added patches
> 	   to support deferred probing.
> 	3) Rebased on top of Anup's AIA v11 and added tags.
> 
Hi Rafael,

Hope you are back this week!.

This series has spent quite a bit of time now on the list. As you are
aware, few clarifications like _PIC codes are also done now. There is
no major change after you had agreed for the design. So, can this be
considered for the next release please?

Thanks!
Sunil

