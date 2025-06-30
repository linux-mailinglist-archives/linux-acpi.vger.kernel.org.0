Return-Path: <linux-acpi+bounces-14852-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EE1AED7BA
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 10:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 022AC7A216F
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 08:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD3B22156F;
	Mon, 30 Jun 2025 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OP/02MND"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0B720F069
	for <linux-acpi@vger.kernel.org>; Mon, 30 Jun 2025 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751273332; cv=none; b=HrGp0R3zcrdhsy8GNZwI7x4OYp+2DoW3ZKHu73y9l90x9KZJQgml4U2eGSGDI6dW/LF1AXEHh8kOv7J5pDMpuFOOgmWfen5hdIhB75HHwtDx64TCNWfHGKnHeZDe5O665PR9fiblm48NX16FAcL34yTHYJuXAHwxIAhoobVC2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751273332; c=relaxed/simple;
	bh=9LX9av9yvxOClo7gCs52aPEZGCecg5/87QicfzfhCEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4qK5kSUUBxLglRPPRQG6vuKWqZC6nR5G2UxV04P/2RC72p+BdlKAElRhhfC4MeDvOiSNM9Lvex9ugPkCxsprQHOFOepaewgv5rpd66GqHcWj6XyYuy+AS/KYwsWCTpgxaB6cck9KDRz4tR/ty3y22f+P8lfhw58JxN2BqJgoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OP/02MND; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a5257748e1so1043098f8f.2
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jun 2025 01:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751273329; x=1751878129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0MFmQYTIhwQaPU7YK/VjsEzsIiL6rLtVHCSHLdz344=;
        b=OP/02MND348iZGO/JSYbUVZDr7EKMIVoSp4PuVBXyDMeEjCkMzOBm1NzsJUvjzRRgg
         7/QcuTJ2UGfZuTmwxzkvMA/PreLR5kBCyOpPD4gum4Tv+IH4ddUMQ7C4jhNf/6FRhfBV
         KZN0VEkdsirC51kh74EvzVMONLyAXCjf/g6LlmHcafBG+LgsGGNUgnGUUoTW6JFr35l0
         VNiDvsvdumNC2OJCpYd892Mx1XFu3BKiBtK3vGjh4Z7juc5UA/bSMz0Y+fn8FpHLQgCB
         MvOlQ2xwSAC5EVZLYW8wbPOSUKxRk7qdYLBhlYB2WGXh0tFMdGP+vmPm/oT8DjXlc+DM
         Mrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751273329; x=1751878129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0MFmQYTIhwQaPU7YK/VjsEzsIiL6rLtVHCSHLdz344=;
        b=IMeqdxhjw1QbQ9d4xLz+hX+qrBRypLz+AkuDg3Ju1TWOtGKnrxHhJOZ7gvrQPHl7Z4
         BjRLLbFT0qW5LO4p0ODCi0qwP+03YzOqQ/74ECo0hFPQNONje4fO/aBpDFehx+e5dk90
         mYxCTw9kUflcKY7ZpNB/J/a4QhHHDWBE7BcrCjTZfRRJfN657vwftxTP6Ibn14dUuFBR
         aMBP6VteUvyH6vwAdzzwI5rUj26ekGxs6jP9BP/3WVI3uBBUx1JjO2TN24V6cfSgJnQ9
         h7cb47Oa4sMENM0A1KyKey3TyBI+cfe3OESYHo21dsr6GsCT+yoiLscPPZbnHqsp0ujN
         qGEA==
X-Forwarded-Encrypted: i=1; AJvYcCXmlXPmyEUj5E2Mw4WSOEvcr7mG2boJsacLbYulHMLXCX8p3AvKIbo/JgSPQlRXLV6FZ/BXBsbdqrbh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx51lfoBYHegf0R5Y09Y2REM2VgH2jCpuXII/AiukqPv60I/H4I
	L9h7z8ZjVqy+t7cTwk8SoTHZ/pSL5H6htnAWVa1s1FMX4bDnYelTCww43ylXFTwTio0=
X-Gm-Gg: ASbGncsYewXqMLU4kh2YlCpVBg7rulIvznmkIjI01ekMQW0GqRyDep8KBvyoaaOQh3s
	bzq450IUZKz9lkZjBPK2isn9p+SEJN2WD9g0ZpsvEbmU0HEPWwDt4TH6zxuoM4FzVLpTWZb3VAo
	DiivHfqkbY3696pXrXWv3hrrgoCM8BEhdGGquikGBkTJPlGIw/+6OeSnI2o0Gvz2Zm0c4M0Fj3i
	u7pmPoYkjWWMpttr3IwhkiUm6PHe6w2ps1YK2Jo+9MnRB0OtUoI6U2AQYV7925tASR/nq+lfxfF
	hh4qWkZ2FdFpXL4Dky/JXCvauJOYTZ4Da7JrR5lTACrUUoxMAg==
X-Google-Smtp-Source: AGHT+IFkP2IxHQSzwTBSX2V8J3HFEeGEU2UchiOHVWbWGfVFsEoSfKrpjADgwPpJXxhXznoj1gfTMA==
X-Received: by 2002:a05:6000:4b0d:b0:3a4:f435:5801 with SMTP id ffacd0b85a97d-3a8fdb2a190mr10032131f8f.17.1751273329044;
        Mon, 30 Jun 2025 01:48:49 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::5485])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7386sm9698288f8f.20.2025.06.30.01.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:48:48 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:48:47 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Anup Patel <apatel@ventanamicro.com>, 
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v3 3/3] iommu/riscv: Add ACPI support
Message-ID: <20250630-43f937dcdcd84599d28169cd@orel>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
 <20250630034803.1611262-4-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630034803.1611262-4-sunilvl@ventanamicro.com>

On Mon, Jun 30, 2025 at 09:18:03AM +0530, Sunil V L wrote:
> RISC-V IO Mapping Table (RIMT) provides the information about the IOMMU
> to the OS in ACPI. Add support for ACPI in RISC-V IOMMU drivers by using
> RIMT data.
> 
> The changes at high level are,
> 
> a) Register the IOMMU with RIMT data structures.
> b) Enable probing of platform IOMMU in ACPI way using the ACPIID defined
>    for the RISC-V IOMMU in the BRS spec [1]. Configure the MSI domain if
>    the platform IOMMU uses MSIs.
> 
> [1] - https://github.com/riscv-non-isa/riscv-brs/blob/main/acpi-id.adoc
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/iommu/riscv/iommu-platform.c | 17 ++++++++++++++++-
>  drivers/iommu/riscv/iommu.c          | 10 ++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

