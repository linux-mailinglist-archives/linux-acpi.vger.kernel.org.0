Return-Path: <linux-acpi+bounces-14429-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCF2ADDCB6
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 21:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D0D17EBE2
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 19:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902732EAB6F;
	Tue, 17 Jun 2025 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ett0jDLE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6BB2E2676
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jun 2025 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190244; cv=none; b=taur3QL5D3qgXdKEZrLAIse+XObdpmQPUN0hX7qfsphsA8Lr6p4OCmmHim+H4//8A7hdzgxIJiVULHncTSOoI2nHm+WYIyiQv+pRbzq2bp5QQaf/I/sXKEtDsjxsZWkCdpSUOyB5f1MsR4Tl1+2VH65bHrwTRphqbLxHCTG86L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190244; c=relaxed/simple;
	bh=g1hqr9LAd5tlBlXHUe2Abbj5LysvcxE3l71FgP8GPCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcsKYsaAUB9U1+rgJIuLARTUQWyv0FuRoYlSMDM5WBM3ex3Fak5tR8cIykft2lxjV/sO0oyjUHHZHRER1tUyGn2Mm4I4OJjjnVKCzgRVfbX1xIXGzwMdZ9qyfx8n/QA+pm6tb2zUL7o6oaO5TDtLqUzCYuW4Znmr220VdnoTg6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ett0jDLE; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a42cb03673so73024841cf.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jun 2025 12:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750190242; x=1750795042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSljJoj4v6CeDXJDozVd8y37KP8tPNu+Cmnc8/7K2EU=;
        b=ett0jDLEoebh+JyaQv+RJbvAuXymydoDvslAFmcZ6Z4dfurrqwxY3JeC1uQ3i1SOPt
         ph8UXl6D771R+SfQfflI+6p3EoDL8zJq1hfV/tn/e7AD0FzGVuyWE4f72YJt+YKMDQQj
         hsXyhtTxcd99QA2PUBp4kv+CHzGKeNhCdIHRpPqFydEQbsnW/BpP4yHrMLKTODHfGoYW
         8+Bc+Rf4948wdV/0bi221GMSuJKpKMLGTUB4rzPeJMJaHs5aXJXBmihiPn1q9o8MeSXh
         z21/ZZdKkfS2mpDdBS53ts3GuAn+zCodwtfNBvXnwpGeyg7BqwWckZyWeJr+H/nJreHp
         8Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750190242; x=1750795042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSljJoj4v6CeDXJDozVd8y37KP8tPNu+Cmnc8/7K2EU=;
        b=F7E4us7EvWIR/brJYJrbbrS0wT1/z8XJ32LphtSjYGnkGnhC3RfJmg066cxnQjAeWU
         LQUOaoWRd7JiMshTrvenOU43jolsdgnIKKQS+rLTYlRC775/B6DWsCqEd8dvbh4ovm6Z
         hliAcdKG+QqYghX7v6aR2E9YmHjzq1q8ULYKMlP7GbWXrwq3t5FWQV62HXVu1hz84yga
         JCZ+42mxWEeYO1vu/TXTum9IT/8LWJR910zuoR40Z9hOphlSUd1OKagf+rqExsMVhdtz
         SoVGMDqW3GPzSSb+54Cg5HvNSKE1Q9hqbq5NNiFRcPPSxGWP+YJ9vkQ8JqReqxOtEFqL
         gfLA==
X-Forwarded-Encrypted: i=1; AJvYcCUgJac0GIDGnr3/JaZ6bPgiS5MExG0QoQgEjGndGEWoXokwJkmCa123wRW7G2YdI9iIx18uiSDInxvE@vger.kernel.org
X-Gm-Message-State: AOJu0YwRbt95CX5TpL+vY7ZK4Lzdo/+i/uRF8yumWn7wbqM95np0GkOS
	mvH94Ke2Fe2CU2NlCma1YwkICnFSbzAZxgMEJlhJv45U3e5sAjLx91IAxiqvfxWuOdM=
X-Gm-Gg: ASbGncuF4wRmP2nEYn9j47Lt6Ci60sEPgCcd56rdWbb9QRIA5tc9K62SDeXbt9qJEtQ
	czb2du0/uK0RI6ARnC+p0gb1aTu2IsSMHUwiAw9ND0+kpCYthMSSTNCZc1qzVAcP2HsoKnnUo4z
	MYy/3m1tkrXOCnZKhHkA8ztz8WpdaUQ5NWj8Gum2JC9KLODGOrU+oJR0dDjpz/p8Wid6ta8E/nh
	buDl+rOtpSfOAWwTciW2fyVUl/bxZX0X8TbDr60q6Y86TTnKETPEdGXYeXPDE96dY831gGfedPC
	Zlyfeqp3H9cQK95ZWDWBMDlER0tGNHVALx2HF1hwFNpKdrCy50vo4E5C5pBFdSUbbp6EzkTWGiL
	/eOGELWr5zwv6Tmihkiu1I1/grGErXzgKHwRjHg==
X-Google-Smtp-Source: AGHT+IHoE/CIYPSeBo9AkwYX6P5QyNezX929DkvT7AQbxP5vAuyPsD+eSrDU1SNqwDaclH2cAsl91Q==
X-Received: by 2002:ac8:5746:0:b0:494:f1e7:65ef with SMTP id d75a77b69052e-4a73c627abcmr231747311cf.44.1750190241701;
        Tue, 17 Jun 2025 12:57:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a4b0e93sm65849681cf.42.2025.06.17.12.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:57:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRcQq-00000006ckX-2tam;
	Tue, 17 Jun 2025 16:57:20 -0300
Date: Tue, 17 Jun 2025 16:57:20 -0300
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
Message-ID: <20250617195720.GI1376515@ziepe.ca>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
 <20250616132031.GB1354058@ziepe.ca>
 <20250617154331-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154331-mutt-send-email-mst@kernel.org>

On Tue, Jun 17, 2025 at 03:44:20PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 16, 2025 at 10:20:31AM -0300, Jason Gunthorpe wrote:
> > On Sun, Jun 15, 2025 at 02:47:15PM -0400, Demi Marie Obenour wrote:
> > 
> > > Is a paravirtualized IOMMU with interrupt remapping something that makes
> > > sense?
> > 
> > IMHO linking interrupt remapping to the iommu is a poor design,
> > interrupt routing belongs in the irq subsystem, not in the iommu.
> > 
> > The fact AMD and Intel both coupled their interrupt routing to their
> > iommu hardware is just a weird design decision. ARM didn't do this,
> > for instance.
> 
> why does it matter in which device it resides?

It would cleanup the boot process if the IRQ components were available
at the same time as the IRQ drivers instead of much later when the
iommu gets plugged in.

> Way I see it, there is little reason to remap interrupts without
> also using an iommu, so why not a single device.  what did I miss?

Remapping interrupts can be understood to be virtualizing the MSI
addr/data pair space so that the CPU controls where the interrupt goes
though its internal tables not the device through the addr/data.

On x86 you also need to use remapping to exceed the max CPU count that
can be encoded in the MSI, no iommu required to need this.

There is also some stuff related to IMS that could get improved here.

You don't need an iommu to enjoy those benefits.

Jason

