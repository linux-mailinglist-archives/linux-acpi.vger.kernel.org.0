Return-Path: <linux-acpi+bounces-1458-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E27EA4D8
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 21:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE4BB203AF
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 20:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70000250EE
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b66pjEtO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD2249E8
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 20:12:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E074D73
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 12:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=b66pjEtOs3F0OiGf1Ys1lGuJR8+mUhGTo3FEnUfR3Q5Mp9T26m0ZpgeYu4h7lCqC8Aq1jv
	IKhl6mX+0zd8fPFIgO/lY5O8iZGuB2htK4tVOkweP8ubXdCaWS+1GLz3NlR2hHXuGOqPtT
	HTbGJ+hRbr3Hpr7ImbxQ3LHx/gfbcIE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-g-V1seH0PlSpuRJ9rz1WNg-1; Mon, 13 Nov 2023 15:12:37 -0500
X-MC-Unique: g-V1seH0PlSpuRJ9rz1WNg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5af592fed43so56354017b3.2
        for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 12:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906356; x=1700511156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=Vavlz6PR9DSrXpQpIJUzIpHDhI8kGDPG2DSKgpDsOMhDh5kLdpWoxw9aZmTKGzgSXL
         NtMROxDvrzRFfXEJs4Haq3jjFaCO3jNfU+rOUvKgs7qCdtucW6JNs6CJrSi5TzOl9ILH
         5yj5V9NVS2fNIWsguYsRV2oWye1AE+byVZ22P6pnDEG9xYCoWvSgHvj+9gDghigKfVsY
         7lVWA5SGHU8z7VuJSnEIjgNzruLpSW8TbnPQzKPWkYO74ABvclUDDPC6hAx3zJK477kW
         gH7b4BL8f7QOkcXecbwnYcnp60yRsqfskK9Rxpym9GVU5MF2GEHTey8Xsbfzxbc0GPl+
         unuA==
X-Gm-Message-State: AOJu0Yx91bBhP04vk224TsxOCMPzu+78r6USecTnnxtLLpZhIAh3l6nz
	XIOXk0+Ah2eC8E7CMgEJxmelbP3375basE4iXhCpxxj2Cku6pynuIKmKMzMKCS3zkASwrL6XrEB
	69CSU+v+AU0J4kXgTYyWvIFc4FHGlLSNE
X-Received: by 2002:a81:a1c8:0:b0:5a7:b8e6:6441 with SMTP id y191-20020a81a1c8000000b005a7b8e66441mr5681648ywg.16.1699906356191;
        Mon, 13 Nov 2023 12:12:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8TAFaS4ERYYFs+8jp6ZPsOwc5cP1r90IboZbxfRfwy6gwcqiZWRR9jIiN36BiWY+6zJFv5g==
X-Received: by 2002:a81:a1c8:0:b0:5a7:b8e6:6441 with SMTP id y191-20020a81a1c8000000b005a7b8e66441mr5681632ywg.16.1699906355905;
        Mon, 13 Nov 2023 12:12:35 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id a10-20020a0dd80a000000b005a7ba08b2acsm1972894ywe.0.2023.11.13.12.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:12:35 -0800 (PST)
Date: Mon, 13 Nov 2023 13:12:34 -0700
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
Subject: Re: [PATCH RFC 09/17] iommu: Add iommu_fwspec_append_ids()
Message-ID: <xv2544jtubq5aefvzaiabazmz5uf32alw6blcdbvsui6wn37ep@vpykzk2vvyp5>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <9-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


