Return-Path: <linux-acpi+bounces-1463-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FA97EA4E3
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 21:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9F1280CCB
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 20:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06190250F3
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsoPlO93"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720AF24A0D
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 20:25:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFECD7A
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 12:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699907126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=EsoPlO93xa9IbDgvEh3uBrUaKHGA2TgVsMGRGD6Yx6oHWeRvWdx1aV+WWOGBv88/IX6hVd
	jV3XdIqepXP+Swe2na1/oMMYrFc0INXer/5N3Uc8mVMUhhyywzfPBMZg18P/bO1wHQLLHT
	5mWePEi+opY3VO3GMuFts4mAiSIzw3U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-UtMLapgtPOKeSfKFA8QKsw-1; Mon, 13 Nov 2023 15:25:25 -0500
X-MC-Unique: UtMLapgtPOKeSfKFA8QKsw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66fe14725aeso61926586d6.2
        for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 12:25:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699907125; x=1700511925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=axknEyecxjeksqCzecmUAI25Hv3emUNEV7v5Zyj49mkyeVIg82Ohq8xZaT+SxT7YjN
         OT0T+RySO5t0F1AgkLHVeHJ/XpaFklPTd5uzbXLjMzOpPR5LkrIwezvMCu+fAeSG0qxg
         tIx2qE6VxiuX6eebMcge+jG7d/HNqwIl1rmRi3IVW/GOIXj69g2N+ECDQ7ieIHD2y9NO
         9BG5ddEDxY10IVsdc9U86fWpKb9eAfREhB7SGetDiQOQLZn+dic3qN06UZmbmZ1OZcRe
         Jt5VxEgOUzJZOPgL/ltLJ0JDk593f8j89qDbZX2MO/XlEteP2Pz0G+/Vd4EeQJCpJ/Ii
         jlvw==
X-Gm-Message-State: AOJu0YyABoZad5/u4WzQ0B9WJpZ2jge38/NEW0acAiqARtzqrWRvEalB
	Yf58Uo5CT95MrMDki3cTVLf98hm0Yh8Ilo6UxPkWmKBTwiuSi3xR/rNXgoqtE2qiIc9EJO7k35f
	zwZXFPIiDLMhTNQ6eVNrnCg==
X-Received: by 2002:a05:6214:2a9:b0:672:3f54:b94f with SMTP id m9-20020a05621402a900b006723f54b94fmr343480qvv.7.1699907125257;
        Mon, 13 Nov 2023 12:25:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDuwvOtoyPZ5iPmtgsnzi3ZmT4SfzU8sjdIavaCXICAagXeDLzw8KJuwOG1DaOAnqE0bqGXg==
X-Received: by 2002:a05:6214:2a9:b0:672:3f54:b94f with SMTP id m9-20020a05621402a900b006723f54b94fmr343444qvv.7.1699907125050;
        Mon, 13 Nov 2023 12:25:25 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id qz6-20020a05620a8c0600b00774292e636dsm2120525qkn.63.2023.11.13.12.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:25:24 -0800 (PST)
Date: Mon, 13 Nov 2023 13:25:23 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linuxfoundation.org, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-tegra@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Krishna Reddy <vdumpa@nvidia.com>, 
	Vineet Gupta <vgupta@kernel.org>, virtualization@lists.linux-foundation.org, 
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 16/17] iommu: Mark dev_iommu_get() with lockdep
Message-ID: <avqfvjfck64kedxvjtsw5rc7x2dkubbpm5ytz6roog6pb7of2z@g6up6nxawsmo>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <16-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


