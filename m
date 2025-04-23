Return-Path: <linux-acpi+bounces-13222-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FB8A996B8
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Apr 2025 19:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2D77B1F1B
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Apr 2025 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380F828A409;
	Wed, 23 Apr 2025 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKnQ54A5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4FF26561E
	for <linux-acpi@vger.kernel.org>; Wed, 23 Apr 2025 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429483; cv=none; b=f2T5B37UWRIZDmOQJ4a12tuuYz0YbKa2YqqPcCWDWXxIhdqIJeihT4oAuRkHbwEeeZRAXmPJCkSWfSHg1CN2sIrrhZ+QSoLlNgJRI2x9q+94zXcYmSyElm9dEQ6viU34Hy/LkLOMecyRQv0BfnEMI6fkCRO/tKSIjgMKr3nDZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429483; c=relaxed/simple;
	bh=kgi4ELr8mCdAm9+XhEH6VRz6G3+ojfBNAMxT3w5HoSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+DecuQ8JwGYjhcXeArkgjH7XfPfyL6L3++GsgawYKQuA3z1fcQGUDKQTEnQtfUtoFXbfRx/MoGDA5yfdwYZ0UCp0xURBpVe80kDzyhV3yoPT+FPig2nHjdP1zYfAovgH7VAbjk9/HJVy3XsV7dzUcU8Fs2NOZ7FPraWa6ALaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKnQ54A5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225df540edcso14055385ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 23 Apr 2025 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745429481; x=1746034281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkDmVE1oQubncGA13yoyJE0TwJhGavatFFU357EXcEc=;
        b=hKnQ54A54OH01v/NWH8UIDkJ38bvfjB2A/mwBI3uytCUu9Gxp2I7TdQ11SLHYWMJQG
         zTl18GT6Bm3tRyxmQawp0/e4oohop1JRXMvTvJlj/962IgPlx8VzfY0xDonBwQp+Kb1z
         +U7Q3Y87ys1QZ8+DPo7ORe7h7ccWuRHHRaijrl9IRKRiuX3Ok/l2j2caDetVylCL+t1A
         yoieaOiQLdJg5qS0u2O5kqXmsHFXZnxRIsfNcdQsw4vtG5Pao/Xz5o/lD4AvE9we7lhi
         D2wW8e7SUPwXbRzUmSpqNJ1sGNXPlb8dnIP6Z1rGQ+3YMINN/ZkXY6SROA5MF9jrMOfR
         aBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429481; x=1746034281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkDmVE1oQubncGA13yoyJE0TwJhGavatFFU357EXcEc=;
        b=PX7OtTKZRqAjYg8AZBdMlohR2lCLDH15h9F3yQ1XVPpPPFFBMRKzzWkURysv2IL5iF
         fwebFr7rbYoNPb4eN1Ey1SE1h3scTE5AZf9cW4r1OG36If6B+SmG9lBRscZzoHtWz7QS
         XeuJwq1mA+X1IWxSUsgX2aliWJesUL0Qqoce9dmL0p0bS8YrgzUKKlmDvDzqzSxMM68d
         sKx261N5ShRMuM08bBazi0SsQXSwBHdWiJoKPV74cxc5dii1L04WaUbCJjiA5cwoPtR7
         VLTpQR24gtz5NqfRNq8OwG0vTOCSB2PwFGPf2aAXXOA7mDFoVgNGTzqweuDFSCoC4BX1
         vlzg==
X-Forwarded-Encrypted: i=1; AJvYcCWFoLMuH7+/teSG1KAO72QIvo2JGf6C8VypOvQEL+2z4JiNiwJhTwyUpH3Cn0U6HLz0T3N+rdyfoVZv@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNLixCHqh291jFQ1xg1cVgOtD5BlI4l4xbw/DKsf6xrnDSRUO
	aGAsHods06vq+qNeMPhdjTnXpgQcQtzdDXJ4N3NiKR5a4E0KmFfhVLKqgQO+sw==
X-Gm-Gg: ASbGncvqr/beqkRF21IvjYcX6lxVQoSlVaMeobOIhMf/X74thwZA6lEpeKGyPj8XG2p
	5Qc0CPiZ+hYOCDMvqCWh4pRyTcctFt6tBJSiOBOQN+XKkXnTdIkqurEABWRAm1md8cbdPNL/79r
	76E5vk4Ln0exOik+9+QRVfsJQhZQCgwWGoLlDXmmrcHK3lY42BLjjAww3cgdIStUf+L8cMX+PjO
	NcpBI8DBOzgLlswppwxxhgkRpZpuH02/8QW0O/N5VXwV2GVAyJfdlGLsusH6OOtu4qHeoYcUJTG
	O8Ah3A4atK5J86nidJpgGGZ0qWTuWxXXgeu+xQsJhZtMR8t0Us1n+M1Dkp5lc4OkKIbGvt7glbZ
	1MIEl8Q==
X-Google-Smtp-Source: AGHT+IHJNQTbOTf5T97irPUNv+QmXLRPjJqv5JLklJLGHSWfRRkbgYAKpGomh75s0qhLStfcG3G05g==
X-Received: by 2002:a17:903:3bce:b0:223:3394:3a2e with SMTP id d9443c01a7336-22db2189d23mr394125ad.18.1745429480637;
        Wed, 23 Apr 2025 10:31:20 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4292sm107648765ad.150.2025.04.23.10.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:31:20 -0700 (PDT)
Date: Wed, 23 Apr 2025 10:31:16 -0700
From: William McVicker <willmcvicker@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <aAkj5P1I-e9lylIU@google.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <aAa2Zx86yUfayPSG@google.com>
 <20250422190036.GA1213339@ziepe.ca>
 <aAgQUMbsf0ADRRNc@google.com>
 <20250422234153.GD1213339@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422234153.GD1213339@ziepe.ca>

On 04/22/2025, Jason Gunthorpe wrote:
> On Tue, Apr 22, 2025 at 02:55:28PM -0700, William McVicker wrote:
> 
> > On this note, I was looking through `of_dma_configure_id()` and am also
> > wondering if we may hit other race conditions if the device is still being
> > probed and the dma properties (like the coherent dma mask) haven't been fully
> > populated? Just checking if the driver is bound, doesn't seem like enough to
> > start configuring the DMA when async probing can happen.
> 
> I think the reasoning at work here is that the plugin path for a
> struct device should synchronously setup the iommu.
> 
> There is enough locking there that the iommu code won't allow the
> device plugin to continue until the iommu is fully setup under the
> global lock.
> 
> The trick of using dev->driver is only a way to tell if this function
> is being called from the driver plugin path just before starting the
> driver, or from the iommu code just before configuring the iommu.
> 
> Given that explanation can you see issues with of_dma_configure_id() ?
> 
> Jason

I think the only concern is when a driver calls dma_set_mask_and_coherent() in
it's probe function. If we can handle that case in an asynchrounous manner,
then I think we are good.

Thanks,
Will

