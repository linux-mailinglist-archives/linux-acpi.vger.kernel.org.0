Return-Path: <linux-acpi+bounces-14430-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E59FADDCD8
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 22:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA251889C79
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B772EF64E;
	Tue, 17 Jun 2025 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLdN9mVe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80B2E54BF
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jun 2025 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190523; cv=none; b=NANSB/VMkz52JfTaowJej+9l7r7Adstc9fvF7wW63Gw8iobmn7hVHz99JHovJIEWeP5h5Fnt5Hk9r8s00/dDa1aMgqOY0l9F4nt90k34YiL3CAb/1IArNR2N7sR5oj0evZ8umOSdC7pZqeek5J8X14nU66WTR/Z1p2NAHm4XkLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190523; c=relaxed/simple;
	bh=XMvjS9h95kOV8JujLb2GDDrONYa4hpVobP4wUiW7o7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNVXbHIWmiwJSZeyneb7Ohlete3LqH6JDSr2wLi6wysA8BykGwT1O+NgKMCLBEyhqhxlen/0KgSSgV427ytwL/2G6tHUTnhx2F8s//vMhf9KiM+tDy2pruL0zDmCHIdDCOOCC4TuWMzShC1n150v9Nky4O/wgQUFywPdqxEXaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLdN9mVe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750190521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+NoG2Xo5HkG5dYXEBVx8rtfO3qQh/xgk518Z7oyOlQ=;
	b=TLdN9mVeEAtiHVvO18UP6VGN/tmIdCsl+W9WhmHGxZJs1WIRk6yO0gGpce/VGWhCV4JHBC
	kz/BW5C0S+fBjxvSXQso1d/rPgqzKHNGL4mkASqMp0jwfItzBGAagy3RMWeCZfvhUZx9a9
	uFmJFttm13g24c4uxr7HltFKyX61j34=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-wMVJpiB5PpGOBabU4LpZsw-1; Tue, 17 Jun 2025 16:01:58 -0400
X-MC-Unique: wMVJpiB5PpGOBabU4LpZsw-1
X-Mimecast-MFC-AGG-ID: wMVJpiB5PpGOBabU4LpZsw_1750190518
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451deff247cso87475e9.1
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jun 2025 13:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750190517; x=1750795317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+NoG2Xo5HkG5dYXEBVx8rtfO3qQh/xgk518Z7oyOlQ=;
        b=aQJ3HT+CN6Hze9/74RwlG/qzkq3Yy+YUhof0ha2/UnGk5SJJKHXVyGknXnNL1Znrqk
         gcyD29tezA2A1lUEhwQZzcJVVKZT0xpcy3tvZ4TP/dhQsco9kOxWQhc4NNdQaF52vK7o
         +7cAi5Zg2gGtNi6BhGelEgb72h7lNKy5vyLssJSJ4MjQ4PqwjFPlUX2corgjhi1bHs+Z
         cG5gfVQVZHt5n4CWa7eOv5rc1j8HrSW37FsgM+bTaVvICaRGnrd7qH+1g7mE+7YNZvvX
         molnSe/y1DWwOjE7zkBQlY4o/J+S2yNRjBUc5hwmrq7X2PtL6C9PLm/scYxHLCObv4/z
         09hA==
X-Forwarded-Encrypted: i=1; AJvYcCUzNsLrArw3KRJCIqhpPhvH3lK0cT4RcNdpbERw2NQoZk7NcvQVH/Btt5qPongTp5MEpV+2WayUl8Jy@vger.kernel.org
X-Gm-Message-State: AOJu0YyHBuLMtgpVnJpAwhNE1/DV+W7tMRNQ5FV9TgoJ0THgvfk9QXRI
	gKZw5YtQT7nkJ/i4nktQfcgwRsJ+9qtGeAFXvh7K7N/jF4kAW3xBIjEGC9bZ8LQM2GxvSDe2YKu
	oGeCPXZdusvQQe8VkizdSBQkr5IGTO/L/b+YF40y07Hwxe8yfqLF+RSx4yL72thM=
X-Gm-Gg: ASbGncvglU1m6Va8Ljg/VoOVib78xitSG/feEZwz97r3VhxMfqEvyfKn/TgDo8o35YM
	SN1vnVqpk4dsNTPzKHzLmLBr2bXEddFyaghv0MPOE1l1CXN2TazLv2N3pgvKrW4yLOsricFJcrG
	nh5/W4r3NiAtzm3/WrNKBJYO/bsNaueG6lFfLyzQM256XxxW9rEKT2jFoCA864/u15o1eh64Fyv
	NZHpq+Y6V3khJRspnEe9u09LOFcklPdq+3gHzp4u7nvPNYlyZGdooTso1BhEutdQBWw0dbhIbh3
	8RmzW949A1zqolU/
X-Received: by 2002:a05:600c:574b:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-4533b2723fbmr106294505e9.10.1750190517522;
        Tue, 17 Jun 2025 13:01:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNEtk99gWXSpZ+RahNNIJ+KZNHzBGaVUSD+dSFjshNFQhawiqf1xX90P7+NZhpbwqFDbMbUg==
X-Received: by 2002:a05:600c:574b:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-4533b2723fbmr106294125e9.10.1750190517096;
        Tue, 17 Jun 2025 13:01:57 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b4cc7bsm14653724f8f.86.2025.06.17.13.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 13:01:56 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:01:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
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
Message-ID: <20250617160103-mutt-send-email-mst@kernel.org>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
 <20250616132031.GB1354058@ziepe.ca>
 <20250617154331-mutt-send-email-mst@kernel.org>
 <20250617195720.GI1376515@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617195720.GI1376515@ziepe.ca>

On Tue, Jun 17, 2025 at 04:57:20PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 17, 2025 at 03:44:20PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 16, 2025 at 10:20:31AM -0300, Jason Gunthorpe wrote:
> > > On Sun, Jun 15, 2025 at 02:47:15PM -0400, Demi Marie Obenour wrote:
> > > 
> > > > Is a paravirtualized IOMMU with interrupt remapping something that makes
> > > > sense?
> > > 
> > > IMHO linking interrupt remapping to the iommu is a poor design,
> > > interrupt routing belongs in the irq subsystem, not in the iommu.
> > > 
> > > The fact AMD and Intel both coupled their interrupt routing to their
> > > iommu hardware is just a weird design decision. ARM didn't do this,
> > > for instance.
> > 
> > why does it matter in which device it resides?
> 
> It would cleanup the boot process if the IRQ components were available
> at the same time as the IRQ drivers instead of much later when the
> iommu gets plugged in.
> 
> > Way I see it, there is little reason to remap interrupts without
> > also using an iommu, so why not a single device.  what did I miss?
> 
> Remapping interrupts can be understood to be virtualizing the MSI
> addr/data pair space so that the CPU controls where the interrupt goes
> though its internal tables not the device through the addr/data.
> 
> On x86 you also need to use remapping to exceed the max CPU count that
> can be encoded in the MSI, no iommu required to need this.

More of an x86 quirk though, isn't it?

> There is also some stuff related to IMS that could get improved here.
> 
> You don't need an iommu to enjoy those benefits.
> 
> Jason


