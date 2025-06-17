Return-Path: <linux-acpi+bounces-14428-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BE9ADDCA5
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 21:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 392EA7AC63D
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 19:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF552EE97C;
	Tue, 17 Jun 2025 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+vhJvzs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E62ECEA1
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jun 2025 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189586; cv=none; b=QDpapw0HlsfFFu74mhRgZzqWid6nAZqLbPQ+nIVgbxpmfTFwbujxcQUPu9rrI8lTZg96qIqALKKfxRwbsDa4ey+V5ly3woLHql2A0Qb8yU3sa50SoNWvtrAVo3JmQTpn5jKxy61F9PycI3KQzgaCss/jqzSjdb1o7Ew+/85jZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189586; c=relaxed/simple;
	bh=6SdbPPe9pmSE8+0ZJM1umJlBQZ1wA58S28tOdEyrjyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMPhEvFVeNVxrAdJmur0cNyJ4/k2DcHsgT8zvDcWvFtmYcKgjw4eqa1E8Q5MxzZnMu6wCH8aQSAWom+ycTRb/tibFvHs7YRIjG5YjAF5Un8JkAvOtHmDVy0m5Ryj8ikGMpeijDLyF4MV5HK4wtKhVc5Lhj/02BDwlnORlrRe5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+vhJvzs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750189583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icFJhskVkKQqZu2iPajxPrgD6zNA+fOLsrBnVy7h8EQ=;
	b=R+vhJvzsn7jePpOMaOMDbzCGPe91VkGn+iGt41nsFjlCa4gpGM7gZU0AoAfMiZgXZTHUQ6
	FK3STCoB4mkVddeitF0ZlexT4/047UC1NGyOYtf7hxCK+N6fyt7V+7gsAXCtRqJhX+JAzR
	cDpGuuZDosvzvRdAnVIMFXjMwZYPhQk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-dDFODEozONyQexYBCPIbMw-1; Tue, 17 Jun 2025 15:46:17 -0400
X-MC-Unique: dDFODEozONyQexYBCPIbMw-1
X-Mimecast-MFC-AGG-ID: dDFODEozONyQexYBCPIbMw_1750189576
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so2217171f8f.1
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jun 2025 12:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750189576; x=1750794376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icFJhskVkKQqZu2iPajxPrgD6zNA+fOLsrBnVy7h8EQ=;
        b=Icu9/F43PvAegY+/LCSaqsil67grmwGhO3myqjVynwROPqA0mbv0R3G0PJtMDNdYbm
         YaRI7Qw1gr2GPJG15sSMDOlHV0wLmP3TyWLJQXjpqVtA1XwRftfYs5PAi3+F2LBQTr9N
         g3RFSbeogihc3FWmAHdAGwyINXvIi4klPXFtH69xhHoJmgoXoFEnjfapACwrqU0RJeS5
         olywGETyrbrTNsoSPps8LGql1oMUUIWLrWBKg4r0zicUFU6oMriVRwUsaVFPyMrGfCQO
         IpYePHP+TSNhoBYsj7JRQIC/Jcm5x96u4dmkzeLLAkuhhRO+n50rD8kDCGwmmNS58xpU
         Ik7A==
X-Forwarded-Encrypted: i=1; AJvYcCW2FQfANyKLCQmYyoYjKrJ0lFYXwPgkzvVCdfs5ykHpSHc9pRHsCOBEdYGLGstLTFh/LqWONYK6iKVf@vger.kernel.org
X-Gm-Message-State: AOJu0YwhGukdiuUjj1QJg98BXYjc02k0Vzl2t0Vw46n8Xw6XUpexwf3V
	PC6xME7DMWsxGOh40SDHDi8hHb6PbE7B0UIAGQHEXe25LDH1e4eWgLMcgp/wPr12RrrBxkknqV8
	dsQCa/p2dBVOxv0v1YqkNXv+2Qwq7c20lGVGE1PaF1mRa0kVcDOa9fMs6Vs7jOzg=
X-Gm-Gg: ASbGncsLEjpFbTHAcQd/TRtDeXoiuvcI1KaMGboUVwF6KE7Obg3waG2oN7OspqF++YE
	ahieoXTx9qt8XCsjDTUphlRsPmmuQuaEnTj9MKSG/P7AY7CmY+aiMnTlKjGdJQhvDQnZgZRrn/N
	VQuw3Dl8uo/JnAQFxdOOVyS1qHumD7lCNh8umSANIRkl+qPiviMtpE5HdWQ+lwNOyHu9s+rXv0Z
	7JSDGeKaTFs+YGAMxBo9wh1JlrWQZ/h145MikGlgStcbQdJvnEm1QPzpgZlGIiYuf6E1BF2xYjn
	JsCYIk38ySg+JhJf
X-Received: by 2002:a05:6000:2007:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3a5723660b5mr12195292f8f.7.1750189576220;
        Tue, 17 Jun 2025 12:46:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO9JZf66g6UmsF+FsTytz4QymacwGU4iFb1DNv63Dd/5GxeH4PDvqwykdFRQ9tUf5lrXqgjg==
X-Received: by 2002:a05:6000:2007:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3a5723660b5mr12195258f8f.7.1750189575837;
        Tue, 17 Jun 2025 12:46:15 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a543d9sm14603319f8f.5.2025.06.17.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:46:15 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:46:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
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
Message-ID: <20250617154524-mutt-send-email-mst@kernel.org>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>

On Sun, Jun 15, 2025 at 02:47:15PM -0400, Demi Marie Obenour wrote:
> Virtio-IOMMU interrupt remapping turned out to be much harder than I
> realized.  The main problem is that interrupt remapping is set up
> very early in boot.  In fact, Linux calls the interrupt remapping probe
> function from the APIC initialization code: x86_64_probe_apic ->
> enable_IR_x2apic -> irq_remapping_prepare().  This is almost certainly
> much before PCI has been initialized.  Also, the order in which devices
> will be initialized is not something Linux guarantees at all, which is a
> problem because interrupt remapping must be initialized before drivers
> start setting up interrupts.  Otherwise, the interrupt remapping table
> won't include entries for already-existing interrupts, and things will
> either break badly, not get the benefit of interrupt remapping
> security-wise, or both.
> 
> The reason I expect this doesn't cause problems for address translation
> is that the IOMMU probably starts in bypass mode by default, meaning
> that all DMA is permitted.  If the IOMMU is only used by VFIO or
> IOMMUFD, it will not be needed until userspace starts up, which is after
> the IOMMU has been initialized.  This isn't ideal, though, as it means
> that kernel drivers operate without DMA protection.
> 
> Is a paravirtualized IOMMU with interrupt remapping something that makes
> sense?  Absolutely!  However, the IOMMU should be considered a platform
> device that must be initialized very early in boot.  Using virtio-IOMMU
> with MMIO transport as the interface might be a reasonable option, but
> the IOMMU needs to be enumerated via ACPI, device tree, or kernel
> command line argument.  This allows it to be brought up before anything
> capable of DMA is initialized.
> 
> Is this the right path to go down?  What do others think about this?
> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)



The project for this discussion is also virtio-comment,
this ML is for driver work.




