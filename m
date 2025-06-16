Return-Path: <linux-acpi+bounces-14392-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E701ADB7D9
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 19:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B8D3B4A78
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 17:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663EE288CBD;
	Mon, 16 Jun 2025 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oQPUQJ4/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFAB288C8E
	for <linux-acpi@vger.kernel.org>; Mon, 16 Jun 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095189; cv=none; b=tsC0dcy4YwBNr015q3SH8tUUdV3NdO7ciQI77pEQY5G94znagPch/APXbjSYI0KbMjyZcJ71C9YmKFmegamPd4DDI4+2ukTAAFGxQ5ypMovLYnE43Bd4N4V3IHaou5VyxgJs/bJFVqSIZL7d0jlxH2PtYBG8YWVWlCilQdH1BKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095189; c=relaxed/simple;
	bh=xFsrEhbFGU3z9UoiI2uJaXv//xa6Xz4juyBcTH3R7C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4Lyum2HnASpdc+gNHkYKJbGz/YXa7K9Cg/HMPyaA5NHa8iC1EW0T7nJsOzMFDIV9j2/Vs0tYFsX8++AtkmtzlKpmXaBNin6SSj2XGVzi3OoZ6Piobm0GPeYt6CtGPz6yVxTL61vZoUgUqFgU4xPhJ1bcuLay6xG/K/R4UsdCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oQPUQJ4/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d3900f90f6so521559885a.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jun 2025 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750095186; x=1750699986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8X31SysrSCqMRM+zb4wzBK8eDdmvTJaf6Uq+iS7ehOE=;
        b=oQPUQJ4/1oySx4jwKLAAkd0IMLjz6WrFi26YbD4TOJkOl5YM0y6Nn0nVHYTJ9gZAfW
         peAaW9oCu5RrJqytt7Nte7StlkQ83wkXEpY5lQhUIZin79/sp0xIVtNjHyPRmgraA4EX
         q3iw8ovrds9hb0mDf1u9TJMrc0FZ4rrYi0EAQnv95600Q8ncqvpWm2aLv7rEjCbBa7LC
         wbuEOejizRVHrPcVJDA5qJYXUEKGq0rPIMWBHRHqgWiSrGbGkfywl5KMc6JIP0kqNaSJ
         HsM1NjwUQr+7p6GSdn1pcEPrUzMD3w/CMdT2mbKpp5oHaQbvfvwbzkZarMW1ww0WwAj/
         jfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750095186; x=1750699986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8X31SysrSCqMRM+zb4wzBK8eDdmvTJaf6Uq+iS7ehOE=;
        b=acpmlQqvfWc5ZDkcYHRgA5FxbTKJAhADTFoJvvDZ41W6QeHyqjvZuQpyZO65PeElqc
         f1korGN3eRk0qtsrS+zWKrv6dANpgYKHml8RVw1dqStYXF8xNNPMlnptE988gsYYUA02
         ObjHVgkPew9FZOSbXUNusYj+WetHatxbUla+ZOmPUgdBxEgm+MoTfsaPMdWLnhFnbGK0
         FndqlbIOEBmnrLGon4iygL0IKOjVOfP94w06CUaMxJq76SKdE8KgkkWrlrO0xGw4Ss7E
         GxNxWmd9zKpf5ZAJ8TV/olV5Pl15nyte5mUR4J0ZKyIUIO+3kUsIWWPxugWALBhBAoEX
         vBKA==
X-Forwarded-Encrypted: i=1; AJvYcCUz8fugk+6LObfKWN7pQoV4pKGj/qAcYBSI64eJwDLYFBZRvv0abXH5b+puU8/7MyyM0d8UiO0g5L1N@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnz9gDuN3C09BwpXzaCboDbUZiesdpgtGjkyKdtd3eRPy65j3Q
	ROPjKz4ej1k46SjXAZOep1u8KsXdyr2af7M9I7SoMtJ2MqEmlkdDRSSNuLOF7nf7xYg=
X-Gm-Gg: ASbGnctvvr6GWBenN1PzdBhG4e9+LC02KTmzf0J7DCBUPwcDeDCt9N7py8hvgUlTx6/
	8LOgyJJSn41MhgudpNULVNzDdFoIuiAyVPSk3FoRfNwwfw83e1JnY+ISDOgDxY682dUO9zo2P1B
	TcQMPdlUZYn1qf/TQnWfZTWDnAZ4tVPE4xTpQAPT+TH/TOol5SE2EQVDq8zJ2MurP1n5KLyZsuX
	mf8BSW/l8fiHG4xxxDc/MEkFkqr02GBrmdQGquarBqhgI0Wgf9uIBe2kqV+TvTX21UFhZIX/3p6
	oSbxaomd0ZMvNLG7CWgODpSydxsJIiO6aDeA2HxuOwU20Zzh+DGrR2rxoBDJMCvAOTk0U8XP8a1
	xW4Qt26r3DjGeW0W28sUg/ZkOG059on+FaHQauQ==
X-Google-Smtp-Source: AGHT+IF4chGBuDLOAfxdrZKfkSU9t0Ai/SG6GB1rXrSJpRvbZP1WNygH1xEW0dli48w32M0hptcl5w==
X-Received: by 2002:a05:620a:c4f:b0:7ca:dac1:a2d9 with SMTP id af79cd13be357-7d3c6cdf0c2mr1264284085a.28.1750095186387;
        Mon, 16 Jun 2025 10:33:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8dc9b58sm553436685a.13.2025.06.16.10.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:33:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRDhh-00000005m43-1aC1;
	Mon, 16 Jun 2025 14:33:05 -0300
Date: Mon, 16 Jun 2025 14:33:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
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
Message-ID: <20250616173305.GA1376249@ziepe.ca>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
 <20250616132031.GB1354058@ziepe.ca>
 <8c3b08d5-24aa-4db2-84e1-dfd1d2c52065@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3b08d5-24aa-4db2-84e1-dfd1d2c52065@gmail.com>

On Mon, Jun 16, 2025 at 12:53:40PM -0400, Demi Marie Obenour wrote:

> > AFAIK hyperv shows how to build something like this.
> Would this need KVM patches?  I'm concerned that implementing this
> in userspace would interact badly with the irqfd fast path.

I don't know. I think you get the same issues even if you did
virtio-iommu irq handling, it shouldn't be any different.

I'm not sure there even is a fast path here, remapping happens during
initial vector setup/affinity change only. That isn't fast path. So
long as the MSI is delivered to the correct CPU vector entirely in KVM
it seems OK.

And the hyperv approach of asking the hypervisor for the addr/data
pair to achieve certain parameters will work alot better with existing
Linux than trying to build a iommu emulation where the guest is
building its own private addr/data pairs :\

Jason

