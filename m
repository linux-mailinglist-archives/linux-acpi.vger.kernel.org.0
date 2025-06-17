Return-Path: <linux-acpi+bounces-14427-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55111ADDC99
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 21:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B50D194108A
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4D72EBBA4;
	Tue, 17 Jun 2025 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKG6LGoL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0A2EAB90
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jun 2025 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189469; cv=none; b=KjnNKQCfvTkBi7EhG6WCmYNR9UtDzk0+Vjin8f/Aj68C541O7AqyoBXbSglLFmaHQEoxBZQd8vdzqNGRMacip49yGUclYplpvdRWOj6KdVyT69uCk8Ql/dixUpQHhX16kPVHzTOyKfqpTMw1cdoxPv7sPu6amKgL9XC6QGr2nII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189469; c=relaxed/simple;
	bh=d7Qa9uTwQP9IlFVLep+Lf4kR5fWHlvWelL/qOpCe/Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9iDmalaWpD4wBaPXsqid/PSTqUuJsS/E1tV91bQ0uLCLVdDV1UamhDRbegR7ZiyigNHfbGWkUe88+i8v/iZT7zLwLSzsHHG6uOF2QadcXuLCS4Z4NlxZe/iTbPfdcN8acAGNNbfgpBNsnjC+q4c2qJzqMMVwn9Kodri/tkxNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bKG6LGoL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750189466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xz8wxuAlhJWtQEwDScEI86WHmU+E7vfWayu2m96ONxo=;
	b=bKG6LGoLNXCfL5oBx7iG+72InMHC242OBpDsXUGuZ9g+h7MeUxbV7gghfqwMrg3OtC7egU
	sllsZWqUbxw7CzPz2gUfmUO32wwMWdnMtdhpSLN5U8nJpOPjW+OguNPPn38KaO2hXV5ENj
	tnxzJMjqk19BfngCtJaNRuLDgVKi3y4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-yd6dJWOXNw6qv_HFmrpRcg-1; Tue, 17 Jun 2025 15:44:25 -0400
X-MC-Unique: yd6dJWOXNw6qv_HFmrpRcg-1
X-Mimecast-MFC-AGG-ID: yd6dJWOXNw6qv_HFmrpRcg_1750189464
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4ff581df3so5811f8f.1
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jun 2025 12:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750189464; x=1750794264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz8wxuAlhJWtQEwDScEI86WHmU+E7vfWayu2m96ONxo=;
        b=asaqvxdNV9+QshzWtBe14JfhunEOQzSrHqyiXdm5QKgT8L1tGlHXoNCyLTPLVEzYA3
         XRVMoDdP2fXw7jLNsivMQ9uI7iEhUvUT/Af4TwJW5jN3/+6Ye3eKZjvafN87cX0TWm2N
         jH3lYXppgr0H1om2o88iGfKmFM+J7SOLmnsolumm4FmWenosyj5mRUFAhDdI3fDeR6ku
         MjZfBw4M1CYJzvgxwRj1+HiqhEGTtQKKD1RpXoHfCK7qz0SuXQLSuPc9aslmsLGM2zmv
         /434rstUBKup8CfR8nOgaFz8u2SSeTl/dwfG54sjrFeLHDwiOwqWt4jmPEjkRzqUtxP1
         5p5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeL9KzrqOYVtzPBDuw7SfxH2gnpqIiQA2h11c9QtQ03G2ygKUTc3CZjYXVaOREdJDAko+LIMXZoonQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwvUXyyqjtpI++tlcY1OU2QeIvM5yuc3mXPSxwxu1Nkjsl8sdbE
	6Nvr82rBYZGQlc/3zg2TI1s0M1sgVvV2th6bGMoirWM+IzeaX7AYPhB9avu2O3GrUvkW4akjm48
	tAJxjw0qxQlER1ybjFzT+dWU/hSnpTywgEz2wmPHhDU6hBdSi1zuXSVkDBVeFINA=
X-Gm-Gg: ASbGncuiYeWrHeyF2EZAQJkjOiCvDn8UerVJnLSZ2PR4jdJKJHVzAsj7EP8sxXMwtHL
	05qBIOkmH+VV387kn5BReuzLlJHL17RNemb5nFTlcYRL/HfbV15Jks2MTsRTxURm+qXEJ/tbhZi
	qoBLtONbu8vS/7ErCRcmJpXaM0MS3YLjUC2tsDmYJKpBt2NwDucxCzxj4l7Dtpxndy4Z0mzp/a7
	Bx2eHT/91KbAabOtV9UO7ppOH5KErTnHDepq8ZuYdBHf1fqTE1h1nD0gq+aWCIF2okNS4JirdSa
	OUroXcA60lEPwYT5
X-Received: by 2002:a05:6000:1884:b0:3a4:eb7a:2ccb with SMTP id ffacd0b85a97d-3a56d821e4dmr13616056f8f.16.1750189464062;
        Tue, 17 Jun 2025 12:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT4nXs8VZp00DXkDGFfmjcwryY7G0O/06cxd3nB1XVq44C9m+cjUSonQ6A1euh9PZFFnKMsw==
X-Received: by 2002:a05:6000:1884:b0:3a4:eb7a:2ccb with SMTP id ffacd0b85a97d-3a56d821e4dmr13616025f8f.16.1750189463650;
        Tue, 17 Jun 2025 12:44:23 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b09148sm15304977f8f.58.2025.06.17.12.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:44:23 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:44:20 -0400
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
Message-ID: <20250617154331-mutt-send-email-mst@kernel.org>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
 <20250616132031.GB1354058@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616132031.GB1354058@ziepe.ca>

On Mon, Jun 16, 2025 at 10:20:31AM -0300, Jason Gunthorpe wrote:
> On Sun, Jun 15, 2025 at 02:47:15PM -0400, Demi Marie Obenour wrote:
> 
> > Is a paravirtualized IOMMU with interrupt remapping something that makes
> > sense?
> 
> IMHO linking interrupt remapping to the iommu is a poor design,
> interrupt routing belongs in the irq subsystem, not in the iommu.
> 
> The fact AMD and Intel both coupled their interrupt routing to their
> iommu hardware is just a weird design decision. ARM didn't do this,
> for instance.


why does it matter in which device it resides?
Way I see it, there is little reason to remap interrupts
without also using an iommu, so why not a single device.
what did I miss?


> So I would not try to do this at all, you should have a
> para-virtualized IRQ interface, not an extension to virtio-iommu
> adding interrupt handling. :\
> 
> AFAIK hyperv shows how to build something like this.
> 
> Jason


