Return-Path: <linux-acpi+bounces-15730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C17B27EB5
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 12:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BDA11BC7F02
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981932FCC07;
	Fri, 15 Aug 2025 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IQ+QY05c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B22E06D7
	for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755255090; cv=none; b=r87ZZbsEwYZyjHr9wf6f2mVHOCfLihl2OpmXNwbiMdZ+IkA1IKLyMrkCyXT2yc8gLktYHW+ERRPPwZLLxwczbnDwOnWREeIJibGI1Fi4Z4mn3g5jor3V6xGDXfqaHxA6CODo1/MnzhxtzAs+Pk2dYyaYpszLb6T9i5GbR4ck0e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755255090; c=relaxed/simple;
	bh=5856zXIPk9IgqnEkrq9a7ikopP8h2OIrgLDCAzSSICg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSaW7p9oCipU+dlYrTqdWcdjLAfZ7Ysf0vwMLQkix8N88su/4aSWsHs7DiljqlWOHOOg/SuV98dkdgugSJh6jp0S6w4oKQRp8qo5ezg/4iffEFC3tHQSXXaL2Ryeg/OfrA1Nfoh6IWA4ex0SOW0ni10EjiVQ7HavJ25DMEubK0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IQ+QY05c; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e1ff326bbso2317257b3a.1
        for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 03:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755255088; x=1755859888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dix/CPpSMGWXSWO0Y4aNEfoYpWHiRGQqO96WVTnVXQ0=;
        b=IQ+QY05cviOzbYXd1UPOuwVpj9LmvcuwLWQ4wyIWQWr4bdyg6jaEjE1gtQ8oaBRfW5
         6noxC8tGbdI2HQ9IMCF18bQmbWCGCs+VdX8FdI/Rgltl6C6rlqyWEiSp1Al9j0Jswdtu
         +0uH7iF1WeH6ar4odHB8p3GWpmILtSVYekjW2VLYkDaJx24dGKipi+pmQGPTOoBrkC+q
         7WlwOffYGHHkyZX2orK+Ay+ZYWhqQX0uUDFUnx1GwCP9AQjh4Sh4+TM/g94b2wq7u7gf
         BiewxbUZw2sQb6a9sDUgs6uAnGsPEt4sHJLynxQPnt20nqCNZ2dARUPJVCW1X6Crlsyv
         UMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755255088; x=1755859888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dix/CPpSMGWXSWO0Y4aNEfoYpWHiRGQqO96WVTnVXQ0=;
        b=Q+QyH1yr5roLMK44/5YVdZ7N58wkMD2O5Oi3TKHWAMRFpiV+fMoPO8rD33ddvk1S3j
         I8O6OcaDuBPK2XCM+MZ2RA+THOJ/be4KWbuUnoNPe4A81vI3qTsnBZD3Pby2cYFRu1Ps
         SAp/znrvm5TrffjkJ4IUGqtWo4Z1ULBgqDzQ69XrSn6g/exAIpSQzb99WVyQsx10ENnS
         UJkHmv1aw8kyINSPvU+qNn1vJpW1BcdiK2J7PR0zoxlal+cYgnhySjKh7iVkl5BcGGAi
         KSFVWZjIoF/84RlG76681X43RtZB8Vx68oy8GncCf4vrbfgOqVWUUmkrBPxJ2RDKpwWR
         zRfw==
X-Forwarded-Encrypted: i=1; AJvYcCVgz66mW9ZNR6vwbeRmKAdSn9NprGtQbSlwgMJpX1ebq6TU61InYN4Ogi7DHTnEL0U4/qf75p4Po76k@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmu6gadG3DSEFRNYzgwzwqi2aXuZJzThIYxN+fm7fhWw14LSyq
	Dx7q5QsSwOgUDrYoffCZ26tQuNBJnaxoc9g0ZI8jogvMQmqmT+yVxkAj86HLb2t6xUw=
X-Gm-Gg: ASbGncvV4HhI9VhDrnn1AzlkJVDmG2je0CnKKQmSZoGZJNE2e2uV6Yravois0R9kV8J
	DXthD1dkghtb4c0zu1oqe7zpx2ZU5K9C0gKUFixBl+EtARMPec1lHLz7QVnkOdWXmm0TXWe+RQi
	4rkdpSZ4r++dhaYfggj6duy5Cdk6ntw3Jj7NE1uVM30Hk462WlkOHYetQgECdeQ4qxptJoksq0e
	BzoYQKVEnrLqUvRU1Y684pQUUg5gpmctdqHeZsbHAJLQGTJaGOZ91BGcgYcR83PghX9BBMlywdc
	Q0tYyQj2hFRNzC8fkRjvCvFubZxQCgQTkB5qEuXqUNP3keEaGMh+6HZq0KnJ4POelMM6oESTpFB
	ZNed8XrskuwbZYuCjpe8orBLt1RY=
X-Google-Smtp-Source: AGHT+IEmNprlP3EyYzXw2mJxg75wrJzN+aQ6IJA3e06q3ZiRiLLueRHZsG1qP8n+zVyH+f5AwDAHpw==
X-Received: by 2002:a17:903:1252:b0:240:1ed3:fc28 with SMTP id d9443c01a7336-2446bd2d05fmr30011465ad.12.1755255088359;
        Fri, 15 Aug 2025 03:51:28 -0700 (PDT)
Received: from sunil-laptop ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9ee0esm11563455ad.8.2025.08.15.03.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:51:27 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:21:16 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: XianLiang Huang <huangxianliang@lanxincomputing.com>
Cc: ajones@ventanamicro.com, alex@ghiti.fr, anup@brainfault.org,
	apatel@ventanamicro.com, atishp@rivosinc.com, iommu@lists.linux.dev,
	joro@8bytes.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com, rafael@kernel.org,
	robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org
Subject: Re: [PATCH v5 1/3] ACPI: RISC-V: Add support for RIMT
Message-ID: <aJ8RJCFM8p_GrFXk@sunil-laptop>
References: <20250716104059.3539482-2-sunilvl@ventanamicro.com>
 <20250815075541.29941-1-huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815075541.29941-1-huangxianliang@lanxincomputing.com>

On Fri, Aug 15, 2025 at 03:55:41PM +0800, XianLiang Huang wrote:
> Hi Sunil,
> 
> On Wed, 16 Jul 2025 16:10:57 +0530, Sunil V L wrote:
> > +	parent = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table, map->dest_offset);
> > +
> > +	if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE ||
> > +	    node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
> > +		*id_out = map->dest_offset;
> > +		return parent;
> > +	}
> 
> Why do we assign dest_offset to id_out? The dest_offset is the iommu offset, not
> a valid deviceid required for platform device in rimt_plat_iommu_map?
> 
Good catch!. Thanks!. It should be dest_id_base. Let me fix it in next
revision.

Thanks!
Sunil

