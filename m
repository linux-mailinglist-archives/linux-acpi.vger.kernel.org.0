Return-Path: <linux-acpi+bounces-14431-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34388ADDF5B
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 01:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE7B17E1C8
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 23:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F058C2957AD;
	Tue, 17 Jun 2025 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Wa0KdzYe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4734429114A
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jun 2025 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201419; cv=none; b=UQnDq1DqnFaM9V/4VXdET5IayWxzRTszrXMS+LGu96md4oVCTDey9M+ZTpYG+coVqIAN3obezPo2Nu/5FENgN+4pQ1G4b82MuOW/fU1GJ6wMVMLpFt1vTsiTIT24TYOjVu5cHc1On5K7lVk3jEPa6jyvT4fyd4+1cC0s3wVL/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201419; c=relaxed/simple;
	bh=7yQyAg9QQkikdevayCOR4HwJNpcyiWJT9okKkefa+HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4JHC1b+ImMK/MoiYcp7ibhk2xxq0+GCtTskYp7GR8FWBH12tIBXNBVk88KJbtw0xwwW96/JgmprN+xjXBEtTDyP2yOvB5t6vqdcMyKDGCbyfKkRi+6BHPetp77Cf+raL5mshjFgK8PUAruq5F9MgPLAhrsgnpuBfHFHn1uCwCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Wa0KdzYe; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a5903bceffso73831361cf.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jun 2025 16:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750201416; x=1750806216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qeHg/OOZNjjpk2NyiVqmd4EaAAlIU7s30yRkT324JII=;
        b=Wa0KdzYeeAAOrbOYnin1foa9ylkbMquO1MYxtMBS2ENoxCtC3AIivyFCq4qWUEV3c7
         QAx0TO/J/BmMewyj4tEKatX2OFMKqmR+uOBDUXNoDlzG2A2vwH5INLhDZ7hgil4Q2w0Z
         JPTywtK/MlvSlCrGgwUZAVDgMXX8H/T1H+zFDm9FkY2hkUogXo55N5Mfv/oCRCkGqcG3
         Bmjk3mWdJI+JT2U6uq0blT+wTrU1XWfiAs5KujFBZEtr2RwPGp3W9zkWI47NIzO0O+6G
         O2+H/FOz+OSYzs1D5Wib7fcIf0KTRn1Fpz+LAByWy2h6nujBu/uMh6FrgPqFlNrI1TGP
         6xdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750201416; x=1750806216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeHg/OOZNjjpk2NyiVqmd4EaAAlIU7s30yRkT324JII=;
        b=K9o877YR1kG3J8suK1QmvxPwaYjL/SxI8jHcFQfWeaFGr8PJNa/IPUL1eI8pqhKSEH
         Qq4oF0OZ3FcgLG3JVba+w9xtrkWUl/VxWdJkHzxYEtqDAX/zMa7WeB7jyBPNMy6z3kIN
         kjwSwbNqIB076WKXdy+Y/bUzNwsZNwNEhWHqS0pwvIuhVbis/SYTyBBcEFY6KHYFpPY/
         nNed/KRiCWmlPjiOTepESPkXRS5FrAWRJDOfOe9sqltExpylPwMz2H7cRG2nnW4bgwli
         4wMDSK+QH9mnoy0PyH3ytb765huIYBoou3/btqUSSohqQm6vEYrgljYsdQvj9VJBAFqW
         Ii5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDcgjqwoXKoHE99N3gosaetfd4yGTYA+z1rln2zv/+PGJda5OGwCrrXi8gj5RMFvd7/IGQQauMVT0b@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/OXZOu5Q8r9vkCmmSeKGHDyeYUKeOx0d2ltDsmM1Lmp17eyrW
	b3cjY7Z8JuP/3ix4M4kOPHVR0g7nYiZFnrvD808JySppP16RBS2cYBDe+oEq/JyIcjE=
X-Gm-Gg: ASbGncs26cbW+J2HO14FR/OtpTq/juBVtZbGLPdCbEOb0v2N2JUfrAvnip3gIcOPExR
	rPd2BKsFOJnrNK64gb50XYj253InZ3+uyWHK/Khe1lI/5WXPfftswqrOJTJP7NTu5hjQQ1B1oYp
	U3l6mNQx0FIQ4KaiVBsFOW+kHbc3RyQQJdAM0caQmJBHM/yQYcd3JCpWcK1CsrSbb466pVEDRDh
	iDPy+7yMlevxgu4LNqZHidDqYtR1Ik2FxqamT3EbAmffTibZFV6I46A66Xq/deMJY3CC71QbieH
	gntkBTHniQsUlFltoENUnTFrc1BjBPRjP0lQeUWlaS8ZelxT9729Pl6mgTH2CJWAxu+5c3YW8lI
	RcfQk2zOUMGXdyWXZQBWHeaDYxDvCvNVtb1nWug==
X-Google-Smtp-Source: AGHT+IG5E4/SL5wvb+OTW2Z6g1HmGu8oKyQFTaoQSeLjiG0Pk8NLxhD4sGUeZI2iyMgdjVlOfelwLQ==
X-Received: by 2002:a05:620a:404b:b0:7d0:9519:8329 with SMTP id af79cd13be357-7d3c6c09cb8mr2841621585a.8.1750201416029;
        Tue, 17 Jun 2025 16:03:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eaca05sm705183585a.73.2025.06.17.16.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 16:03:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRfL4-00000006eJX-07UY;
	Tue, 17 Jun 2025 20:03:34 -0300
Date: Tue, 17 Jun 2025 20:03:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alyssa Ross <hi@alyssa.is>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, x86@kernel.org,
	Spectrum OS Development <devel@spectrum-os.org>
Subject: Re: Virtio-IOMMU interrupt remapping design
Message-ID: <20250617230334.GJ1376515@ziepe.ca>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
 <20250616132031.GB1354058@ziepe.ca>
 <20250617154331-mutt-send-email-mst@kernel.org>
 <20250617195720.GI1376515@ziepe.ca>
 <20250617160103-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617160103-mutt-send-email-mst@kernel.org>

On Tue, Jun 17, 2025 at 04:01:53PM -0400, Michael S. Tsirkin wrote:
> > On x86 you also need to use remapping to exceed the max CPU count that
> > can be encoded in the MSI, no iommu required to need this.
> 
> More of an x86 quirk though, isn't it?

Yes, but so is bundling IOMMU and remapping HW together <shrug>

GIC fully integrates it into the interrupt controller architecture.

Jason

