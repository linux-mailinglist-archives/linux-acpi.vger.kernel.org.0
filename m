Return-Path: <linux-acpi+bounces-17558-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AB3BB695A
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 14:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61ABD421666
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 12:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269222ECD22;
	Fri,  3 Oct 2025 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="i2AX0r50"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804492EC572
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759493044; cv=none; b=iQm7MgpnI+yzHMqvqZgXFLfOQXCoQkplcFMkO9lsU0qYlsQkXPZ9eavJ22wXo1yIFzwn7WGha+OaQFawh+FMrNuyXwE860pmw2+EZaDz29gz4yTNfa2BI+DvuPyScz1W6ioM/rAIc4yor9fln2JL9G6b4GldtQHcGjUP2yrLuQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759493044; c=relaxed/simple;
	bh=yCCP5s9lTzTlxvPaMrvl2U2nWczarzv5lVR64JUY0XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ5Rj3yb2HcJW+uWQXBS97HvGGqwLdIxZDNna5ENyUFD1R2CeJiUqErXgYHBJoQosSDkP0ZR0JkgasqJrKRxAeuSY9rR3mEOsW8FVh3BM+8H/M6bKdUb+Kb4C8QGV/FgdEU1Wi1dNmSbbEj/wMADUzHHUDbyhycXLUe92q0UYbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=i2AX0r50; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-85c66a8a462so306050685a.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Oct 2025 05:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759493041; x=1760097841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vyK6EDMdZhWcTtV/wan5DW3m1OGhyAdsB4+u9LiW5EY=;
        b=i2AX0r50q/9oVJ8tX94qI3pxl3kAvtWezIgySUen8HnwtgwH2n8nNzHoF70arI3bjK
         QOFS7UAE4JjG3DId8KUUv+VY0n1bcVufOr1TD/bIsykp59nDi3avWz6fVJyTMM8YCr1v
         PbVSrlu5VCZNp4sNea3ngiykrROoc2HUhNVNWTS8AiHG+HcPsoUuswI0JBOL2IhaZnxd
         5ZAmCaBQecYpJyHS7LSFD6IZMdX/aiyebqFacWlV8FsyswOP2ICCrPxZgsfBJFIA2mKE
         QY5Yy8jKo0NZUjzsFfmJs3yNIrMDticvDxS6Q2xz6s+EDYwQ2esBw+cohQCip7xUg82a
         fb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759493041; x=1760097841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vyK6EDMdZhWcTtV/wan5DW3m1OGhyAdsB4+u9LiW5EY=;
        b=gStE/s0o+B3DE2zCu2O35TKiEYWLfyXx5tiB5tIkMs+gzuyMk93jh51tQYfzRnbW9o
         gWbmS358D3savLo+L+bT7cfrK9XEoBQi/UvBJm4Mm10lQPQTQ5NxCqKqHgDMrh9VMBbk
         OSohUkxHAaOupszIdUSm0n/PF84nGQcm841N8pu9n6Vf26G4bF4hUaTcmf1Ad9n7rD4n
         pEhEGAWRReGUfgzqD6f58re+xkx7xRYYy5LXyTTyiFghszQGb+83HL3OQ2KIbl33i0+H
         ptdp0iipTuD5BDPUyPHtuBxs7aGJar25tmyDYPxAKZZoDMZSxp62B39nJcuovin3/WAZ
         ICWw==
X-Forwarded-Encrypted: i=1; AJvYcCU/lbZEfrSvJV7dAs6UALql4WEXl14SO/7kN8pvv0jf3QFzv/j5hYX5zq7fZ7eeYAORRtstp8l3XFcy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4K20pWcQFwwVx6vN8LR5flDXsnZj9y3ZVt5NdFYH5ooiF0KB3
	xQqVldmEXX32CmyFtH5X8/8k8vJyxZJrwazKS7xfzzFm6YULi0psJ9Nf9m3LsGyrzK4=
X-Gm-Gg: ASbGnct+1S0I+XcTqtbnhiWTulJxoi9SEfedBoYE7DqNoJE9MOAmbKwejcWD5w2MDCy
	/RVztvR39EKVNA30rvclvSgXRgcb5qu76h/Y8SU6otRy6A4i/TA12Ad2oVqgE5OMFDBdEfplfxq
	kPDSNZdzPIzUySVX5aGkXu2wxvxKFiMNSYjPP2eOG7YRU29ftdvS+105stFsbPpoQtaY34n9sdh
	E6kPjQYZV4ERd55tcMU5G1yZWuR8C2bpGa5thipadE8r/ImmMHqElayVA/PkwBq9MUuHlLQO3cv
	AGaBgJn/d32tACKCt2vox0g5J0JepnRkAuFYT2sOtSinQdri2XTa9ZTdFicuuQ1fvpz7xM2Tdxb
	6E0VOCKWyiPevt1Qk8rYC1/B79vcLldXUVApQSUVK/B0sICHW16InEfjG7lD5O0cwTk+AOn/8XJ
	R8EKdMWc8lJetmj/6q
X-Google-Smtp-Source: AGHT+IG9u6J/XxiDHAEh0uQ+ECKUfFxeEFaK0PE7MiU6DsChuKmxi8Y6PiMSOlaUnZoft+5pp0GGAA==
X-Received: by 2002:a05:620a:4101:b0:870:6891:9c1c with SMTP id af79cd13be357-87a37ea1664mr359649085a.35.1759493041309;
        Fri, 03 Oct 2025 05:04:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cadcecdsm39906701cf.23.2025.10.03.05.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:03:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4eVy-0000000E4mn-3rSP;
	Fri, 03 Oct 2025 09:03:58 -0300
Date: Fri, 3 Oct 2025 09:03:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Matlack <dmatlack@google.com>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
Message-ID: <20251003120358.GL3195829@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>
 <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca>
 <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
 <20251002232153.GK3195829@ziepe.ca>
 <CALzav=cYBmn_t1w2jHicSbnX57whJYD9Cu84KJekL0n2gZxfmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=cYBmn_t1w2jHicSbnX57whJYD9Cu84KJekL0n2gZxfmw@mail.gmail.com>

On Thu, Oct 02, 2025 at 04:42:17PM -0700, David Matlack wrote:
> On Thu, Oct 2, 2025 at 4:21 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Thu, Oct 02, 2025 at 02:31:08PM -0700, David Matlack wrote:
> > > And we don't care about PF drivers until we get to
> > > supporting SR-IOV. So the driver callbacks all seem unnecessary at
> > > this point.
> >
> > I guess we will see, but I'm hoping we can get quite far using
> > vfio-pci as the SRIOV PF driver and don't need to try to get a big PF
> > in-kernel driver entangled in this.
> 
> So far we have had to support vfio-pci, pci-pf-stub, and idpf as PF
> drivers, and nvme looks like it's coming soon :(

How much effort did you put into moving them to vfio though? Hack Hack
in the kernel is easy, but upstreaming may be very hard :\

Shutting down enough of the PF kernel driver to safely kexec is almost
the same as unbinding it completely.

Jason

