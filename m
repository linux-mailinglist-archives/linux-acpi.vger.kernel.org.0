Return-Path: <linux-acpi+bounces-6522-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1035890ECD2
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 15:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B37CB24568
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 13:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE4514900C;
	Wed, 19 Jun 2024 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="d2W88XqF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2315E14659A
	for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802669; cv=none; b=UhIgFtFbQYOx8ULzP8XZ8OKILpKtjFHFusrvFVu8wGtTw/rX2aH1oZ7FmtY5y0Rjx6AKcLetVt/TIjnQq9skda5mLKsPDy2QOrAjBan6SVNM7SGFc510mnzJTrHhkxyH3idTZjC65TR9w/qUjgitqcdpcdkbfnErMj1l/dQHktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802669; c=relaxed/simple;
	bh=f8D/9s2CDW3GK+4dmcg1ylCC474S4Jkf25ughKFSwm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgwB01DHHWhvVp5XGAPrye3SezWRVBFED9VreEqgRNRr+v+fVh6IY2Ql0V6Ysyk80IELjIuugdlEhMmd8Uoxv5qlFOxGjRUlZYmEkNP5wA5K4fXjBkx6yD0PN1RH0cIeC81bxn8jAN6vcKVI1X731DnPyfq4nNVyZddAqj/x5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=d2W88XqF; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79a3f1d007fso342832985a.1
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 06:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1718802667; x=1719407467; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kf9r27RNSYH+M0vPwe+rDP3evgG93CXIjp23HZ8WnCY=;
        b=d2W88XqFhE2y/SDcMzT+0C0zYIMhNgK8ONGubqLwv1xRK2jb2ttXZhtsbb+JJahQa2
         08ovHWMFjwdhUc8h1Zt6ppBnmkJSE+32wKmDmwaUZXfH9szggYb0EQJTXZw+DFCqXaLK
         uc94N7k1ds0iPBqHw9f9npMfEp6jog0cbV4yJyJ/GrX8fCbVQrL0HEFhsXxVv8PB8a1z
         QC+Z9qYOO9ULO0mnENQ6Y3Wdprdp6+uCSuta6myZr32riqjqk94cp/EMcJM27tu/CNB0
         LQjHIrmUx1aIbOJ+FigU8qGTQBIbertr5xNXww2bgSnEWZuaYQHkFBgejbO2X0lO1GaE
         qFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718802667; x=1719407467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf9r27RNSYH+M0vPwe+rDP3evgG93CXIjp23HZ8WnCY=;
        b=jlvKHYHVyiwdMu1L5vIAu5VvVvVm6A/e2U5dbeTZpH5+eh9stIu92Y7IW65t6lfqVs
         d1rZ9SDxqZB+mOgnJHkiqvRac5MgpuEGjiVpbSZKoriejd5onAStlk8MdOTZ24Bt+ywI
         9A9+CuG26JAnnBA/sSNvtaMVZ24qnc5k2nxx3CKf1AxrVHBsJqsiwl2/22Ztn5hIJPx+
         oaRyabNVhKdeWtEq0P8egETGFoKuZooYVGnHOwWOUgSzq+48CyND+gU/nrk8sN9wvShC
         8DY85crsil/vjYF6aWSqwYLBINJbVyLJIVXwh4qknO/mBFMheZ0AdCXaeDMXP9BWviUv
         7vBg==
X-Forwarded-Encrypted: i=1; AJvYcCUFcH9bubQN5Pe58GKqBNr6QkNIkhADQVVDOkSaYd20onavUskw7f7FYcJj2r13TUzi5X6OaIKPqa63kwEsl6cv2joImPJsG4CRwg==
X-Gm-Message-State: AOJu0Yxws5O1/9jR8zdxamw7+cBe0mkM/eSMxCyG0GQBaYr3YPSmtRiX
	jpuV0pGNGtGsTE5M0gngZbCg1OpWe7KtWpQTiQlUgrWDe1YbBKZD1fNnLOH+5FM=
X-Google-Smtp-Source: AGHT+IFE11ASRWf4WYTH0x6XxeEds9PyEcIqeUwSrbCnNFW+6zWifwS2t6Yt+SRC48O2ptbYQuGPdQ==
X-Received: by 2002:a05:620a:4308:b0:795:4e35:ea9c with SMTP id af79cd13be357-79bb3e2f4b6mr277089185a.29.1718802666926;
        Wed, 19 Jun 2024 06:11:06 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaee575fsm605502085a.40.2024.06.19.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 06:11:06 -0700 (PDT)
Date: Wed, 19 Jun 2024 18:40:54 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, bhelgaas@google.com,
	james.morse@arm.com, jeremy.linton@arm.com,
	Jonathan.Cameron@huawei.com, pierre.gondois@arm.com,
	sudeep.holla@arm.com, tiantao6@huawei.com
Subject: Re: [PATCH v6 3/3] RISC-V: Select ACPI PPTT drivers
Message-ID: <ZnLY3mNxyv9QOmGn@sunil-laptop>
References: <20240617131425.7526-1-cuiyunhui@bytedance.com>
 <20240617131425.7526-3-cuiyunhui@bytedance.com>
 <CAEEQ3wnkQsfmLbyMrG_YBvWvhHJdSTg7dG5W_mxv_wxCjatgCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wnkQsfmLbyMrG_YBvWvhHJdSTg7dG5W_mxv_wxCjatgCA@mail.gmail.com>

On Wed, Jun 19, 2024 at 07:32:18PM +0800, yunhui cui wrote:
> Hi Sunil,
> 
> On Mon, Jun 17, 2024 at 9:14 PM Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> >
> > After adding ACPI support to populate_cache_leaves(), RISC-V can build
> > cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
> > configuration.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 9f38a5ecbee3..1b4c310a59fb 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -13,6 +13,7 @@ config 32BIT
> >  config RISCV
> >         def_bool y
> >         select ACPI_GENERIC_GSI if ACPI
> > +       select ACPI_PPTT if ACPI
> >         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> >         select ARCH_DMA_DEFAULT_COHERENT
> >         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
> > --
> > 2.20.1
> >
> 
> Gentle ping.
> 
Actually, my RB is still valid. Anyway, here again.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks,
Sunil

