Return-Path: <linux-acpi+bounces-14874-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C13BAAEED07
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 05:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A316F1894E41
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 03:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F1C1E0E08;
	Tue,  1 Jul 2025 03:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dfkGlmQF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2E1862A
	for <linux-acpi@vger.kernel.org>; Tue,  1 Jul 2025 03:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751340850; cv=none; b=ryJWvGZCOGEt/aP2AIFxbt4PXpNRjZACzY49sEuWwYUBLG5IyvVnytrtg7F9wFf/WX4RkyNsQW1eR6JKVwo2PAJnezMFITdmoqFLuoycOb3MaQstuOPt6Yr+O8ZON1Z7A1+VJP/OJ0SMgzaH5AHwHEb9fG/SPByiGyzjgHhsRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751340850; c=relaxed/simple;
	bh=0ILwCOvCew56oAyKwRacIstQKCp9aDHxuoc+AExHhy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiBnsPIKFkP44nTulgojGMrUZvbZfiiYLIxxG7AD+04pv/LMfVph6pgBRfi7VqohOBPyA8jSrRs4uQooxuy2Ktgc4pf+pIgv/VnVMetH+80gTD23EK4OQGqMrsy8vQiQC/7T830hoHmfWK6swXxBn7rDOxU2GadjWvU8EuzzBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dfkGlmQF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-236377f00a1so50958035ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jun 2025 20:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751340847; x=1751945647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=31XS2nxYehKiliXMsYuVNFSQuv9hNJl6nMqw6J9ZvFA=;
        b=dfkGlmQFk9zxeZBgviR7okPJ7Y7WQFSjF5AHbALGaWZ53viHKFVut50RZ21RH4bIEF
         7Tn9aPwJNHKeVePdJjH4GhqVgKremHVCAczGwH+TxF5rpY39fgJUCFWJmsyE9qYAIa2i
         EF9LPj+/wTxjXvA5IDYVp/Hu+eLbxem6xXRf8GTTJ0KZgUrk+OjiL7SnrJJTxA6k7qgv
         EMe1kifBkWOWQgD0Vd215/Wbaj7rDpqzJq+1HoJgfPr2neLnN0g0vGGA0tYEKzST3K9a
         qColmt8CLQW1YNj9zKyadFFPUs12QjjJnKwpOANcQ4lsu04vGdeXhXDxDbJi1WQHdeS6
         c6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751340847; x=1751945647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31XS2nxYehKiliXMsYuVNFSQuv9hNJl6nMqw6J9ZvFA=;
        b=Yq8fCOoXzUSvCeZRSECk33m439aK9y/DqjFFyewwm53mbvZYqWz+SsDvQdDbgVH7FO
         F6zZP2sSHsauv6L0ywhaoqd3mJnWV4qZM3VZjLkIDEOL742nQRw1VEo6OSLyVYo9wYgM
         SvxbBwS+AcoluVXW/0jD8rzrb2FuoT+9IubXlkAUL8sVSikVSoInJoCQRN1ttHH1MIGk
         i9lzbY7des/3bt1eQeEQGMK8dVOQKzMNifR+KqxUE4NLYEHQqcLN1dsq2Nxb/T3yoceE
         GqhHDN1n/i/EQI6wQ6i4aiwUB9WvbFykXmv66XeKb9l9gaVWw+lZTUgSEcgJG/9uPVmK
         tLDA==
X-Forwarded-Encrypted: i=1; AJvYcCXv+95ECE/KrKzJEApj5g9DHZGFG7ilP4DfIqh/6P/DbkBLiOJYebg1Wge7dW2suMKwuSt+g9sKJCoD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6J/lisF4BgedwVmYZ8pFsHOButV1oDLDayFgbTKc8sLdZqoko
	l9KkcZ8nrw0D8E7p4iiGY1VTObF6Hs5me9xdF//i0cY1ZOoZMIusjAbl2Ax+uamZJqWDBJw6wVZ
	3gMN4vl8=
X-Gm-Gg: ASbGnctR9xO98a+4UNxH8o7oBosCA7stHeoyrS3cK7Y0zWtyXFRJhImhAda11S8xK2d
	3LGfwjVpGsbahLeLZSiwvetQ36N6wEDGzt6XpXjdNQgmD8Bcn13tnmWUDUQxNLwdRkhUqqzsLMm
	dcrlT+/Ai/A65ZRItsVFSBE3fEcknhPi5wk3qXc2/5muFjwrESiYOA1dyGz4qr9PPoub4KXi2Ey
	1SyzqsFQfGF6ul1c97ycWr7zXmr2QkiJLSg8u/gpRbqznX2Hn30qFwikxZMHiQcjhf8pBDxLSO3
	L7l31t7Zz9lg04AXuTSwdbvO3az1Z1pp0rAc9HZxdc7nMPNK9jr6hqfH3WjES831HSvboQ==
X-Google-Smtp-Source: AGHT+IHBFOUU87e7HImdYW3OwpB6jU6VOhsQ+1GbwVU50fpWtSuIe6bavi41hI7Zk0rpNJpgH2mTrQ==
X-Received: by 2002:a17:903:1a70:b0:236:6f5f:caaf with SMTP id d9443c01a7336-23ac40f4e43mr241646815ad.15.1751340847108;
        Mon, 30 Jun 2025 20:34:07 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c90d5sm95757375ad.247.2025.06.30.20.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 20:34:06 -0700 (PDT)
Date: Tue, 1 Jul 2025 09:03:55 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 2/3] ACPI: scan: Add support for RISC-V in
 acpi_iommu_configure_id()
Message-ID: <aGNXIzi8vYL4AOj4@sunil-laptop>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
 <20250630034803.1611262-3-sunilvl@ventanamicro.com>
 <20250630-c479c6607cf8c1430f11336f@orel>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-c479c6607cf8c1430f11336f@orel>

On Mon, Jun 30, 2025 at 10:02:53AM +0200, Andrew Jones wrote:
> On Mon, Jun 30, 2025 at 09:18:02AM +0530, Sunil V L wrote:
> > acpi_iommu_configure_id() currently supports only IORT (ARM) and VIOT.
> > Add support for RISC-V as well.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/scan.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index fb1fe9f3b1a3..70f57d58fd61 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/acpi.h>
> >  #include <linux/acpi_iort.h>
> > +#include <linux/acpi_rimt.h>
> >  #include <linux/acpi_viot.h>
> >  #include <linux/iommu.h>
> >  #include <linux/signal.h>
> > @@ -1628,8 +1629,12 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
> >  	}
> >  
> >  	err = iort_iommu_configure_id(dev, id_in);
> > -	if (err && err != -EPROBE_DEFER)
> > -		err = viot_iommu_configure(dev);
> > +	if (err && err != -EPROBE_DEFER) {
> > +		err = rimt_iommu_configure_id(dev, id_in);
> > +		if (err && err != -EPROBE_DEFER)
> > +			err = viot_iommu_configure(dev);
> > +	}
> 
> This can just be
> 
>   err = iort_iommu_configure_id(dev, id_in);
>   if (err...
>      err = rimt_iommu_configure_id(dev, id_in);
>   if (err...
>      err = viot_iommu_configure(dev);
> 
> Thanks,
> drew
> 
Sure. Let me update in the next version.

Thanks!
Sunil

