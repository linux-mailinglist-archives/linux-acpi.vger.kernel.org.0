Return-Path: <linux-acpi+bounces-17507-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BB0BB404D
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 15:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4265619C6C59
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577A31158E;
	Thu,  2 Oct 2025 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XZY67Qp3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2050C310647
	for <linux-acpi@vger.kernel.org>; Thu,  2 Oct 2025 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411399; cv=none; b=a0QRi4Au7wfDKXo648UHl0NmK9xNtcYWz9dSrc3c5nedFxOb4NUEbixIuAofO+Su7E3vbEL+248JCc46OPl6fh0TJrm6TIUZOq1d0DATgbLTMLyr97g77LdVBbFM4LVjPc1grWrD4qSpKLYnDt8U+eZ9aqRg89KewXYwQaMWvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411399; c=relaxed/simple;
	bh=HETRcCbMmNgVH/z/E5wCLlvsrFvBjVnNgE7L6BCZIUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYntITWuIdLT79qfvyH4VOuBBZXMzlrpLV8tBo0HIXwPkcingR+sAhOhBmlRwvcs7X4CiYIDNnwv4sqBpDffzZx80Yc9ITZFXmLdDOPe20wnRWF4RyRWBlaPZegRoQEEN/TRFaJKxdBU9uH7W1/DMbhwoJ8AZcQNRLhn0p/iQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XZY67Qp3; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4e2d2d764a3so7985911cf.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2025 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759411397; x=1760016197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DRZ9nDiiIaS8xNUTdtdvnajCW2L7i3IBIHHPxUnqqqI=;
        b=XZY67Qp3qLsbSvGasfVOIi/zLA2I1JNofnsy65ZBKRMtPKf/0jlkhE6JZn7gADN5vH
         sxh1vOdG6AXW1OyMI0BGUQUGLrd85olubeFU91l/qJCW+lSu/iI1ZeBUovm2vhZEqSec
         FlvLMwjKcshmQGYQKN5vwhj0JZdLtH2mcAek+3BPPPJsFoOE9xjQneuyTKtItcJP7C+a
         8+zq8chSmNGeJqBCPTNhEVUVUl5S18ESXf5eNMtvzt+QjvkoeS3m+d2eFc4PzE0PkvI9
         EBm5nwCk4LEvnqMHDHsuCJIjIVW46SQ/RFvCDDeQJzRgJnVllf3Q3u4OvqLzpvhRBP76
         RsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759411397; x=1760016197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRZ9nDiiIaS8xNUTdtdvnajCW2L7i3IBIHHPxUnqqqI=;
        b=C3qA3BqoLsc8DNP5Ko1keBZIyXKoUrCvYn0ZBFkguxhM8rYgVpMafBAaiokB5BiXd+
         MMutNeMLEiDVWSS33zxlzz9M2wgTjRYBpr86X/bojDRqHWxBl1kamgWrzs7dwgiPZ6F2
         zjH2FKuGXeLN486TWnT59i0HL8lhQao1ON+ynlhxl8ZV5QZptT8RpNADzPhoc9btFesS
         eCf+vPZf2yYVth6sScqL6C8j+Yop6/4Cjzlc82gw8xotZfZAEyclV4mpWIBUEqwAjtOb
         EN42OnG2P9kyHvJmu/X/kuXtDNo9UeeILDfuSICK2ygi4xBhPy3zsSOpgUAqZOAmtgoQ
         JFbg==
X-Forwarded-Encrypted: i=1; AJvYcCVd9M19gaTulRHy1LRQkVjwQHNaBdmauyo1Rcl3JlNA//VfBl7HSoP+9ypHAplg8mkMlXF9vuZJjFto@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5d0qGvL0TnKBLg9zsTgoSxGJcEahGOZWhyht3vH05pIL8aHmJ
	7YQIJL4s1APQavNRh3RQOHInbpE3RhQhNTRj5H8FRV1daHqsKYT3ME9cHi5Mo5cirt0=
X-Gm-Gg: ASbGncsiaz/n7xjYq7T4QseiB+tyaw/1FgTv5l8mrh1ey2RH1ZHs8PZgSDgjp6nImTf
	FskjIBv2sM7G1/WVmPdgpIcNKwheQ/yOHu4BGMjQyy+u7QPkI6beagrJmmp5U84RAJDt3ymU0zv
	9+6Ab9DRi5t1mmE/IsBjUi5Bh6ZjGqhrFenkzt6j1sbRyyXdWqixQqCagzVDzamZSEsdSbUicYe
	RZsujuoj5QaAv6CMMHOOONQmF5ITCLa802/PB3HNRLP5VrH8i8V1CenfuEW1B8NqHgxxiJLx9EU
	JnS9qdekzAJCIUI7yD9fi7yPNqOd1ZPeE0f3fII/vf+U0nN6d4YbK+vAVBMA0Z9gdBkz0y/RGRb
	s6awd/eA5PgesJZbNgxet
X-Google-Smtp-Source: AGHT+IH2rObuT1XqtiQfOTMeENIHe7Dgk6JaeeB2+vpuv7lVOnL0btICGqEnALLQMUXWxv2WByPvfg==
X-Received: by 2002:a05:6214:19ee:b0:7a9:32e8:56f4 with SMTP id 6a1803df08f44-873a5d1e6a6mr93793016d6.44.1759411396820;
        Thu, 02 Oct 2025 06:23:16 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bb4465cesm18648026d6.17.2025.10.02.06.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 06:23:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4JH9-0000000Di2M-1I6m;
	Thu, 02 Oct 2025 10:23:15 -0300
Date: Thu, 2 Oct 2025 10:23:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
Message-ID: <20251002132315.GC3195829@ziepe.ca>
References: <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
 <2025093030-shrewdly-defiant-1f3e@gregkh>
 <CA+CK2bDH=7H58kbwDM1zQ37uN_k61H_Fu8np1TjuG_uEVfT1oA@mail.gmail.com>
 <2025093052-resupply-unmixable-e9bb@gregkh>
 <CA+CK2bCBFZDsaEywbfCzDJrH3oXyMmSffV-x7bOs8qC7NT7nAg@mail.gmail.com>
 <2025100147-scrubbed-untold-fc55@gregkh>
 <CA+CK2bA0acjg-CEKufERu_ov4up3E4XTkJ6kbEDCny0iASrFVQ@mail.gmail.com>
 <2025100225-abridge-shifty-3d50@gregkh>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025100225-abridge-shifty-3d50@gregkh>

On Thu, Oct 02, 2025 at 08:09:11AM +0200, Greg Kroah-Hartman wrote:
> > However, it is my hope that we will
> > eventually stabilize this process and only allow breakages between,
> > for example, versions 6.n and 6.n+2, and eventually from one stable
> > release to stable+2. This would create a well-defined window for
> > safely removing deprecated data formats and the code that handles them
> > from the kernel.
> 
> How are you going to define this?  We can not break old users when they
> upgrade, and so you are going to have to support this "upgrade path" for
> forever.

I think the realistic proposal for LUO/kexec version compatability is
more like eBPF. Expressly saying it is not ABI, not stable, but here
are a bunch of tools and it is still useful.

> Just keeping a device "alive" while rebooting into the same exact kernel
> image seems odd to me given that this is almost never what people
> actually do.

This feature has a lot of development to go. Right now the baseline
for upstream is no ABI promise. You can live update between any two
kernel versions that don't change the LUO kexec ABI. In practice that
will be a lot of version pairs.

The downstreams are going to take this raw capability and choose
specific downstream version pairs, patch in support for certain ABI
versions that they need, and test.

When things mature and the project is more complete then the kernel
community may have a discussion about what upstream version pairs
should be supported by the community.

I don't think this would be as broad as every combination of linux
versions ever, but ideas like sequential pairs of stable
releases, sequential pairs of main release and so on are worth
exploring.

Jason

