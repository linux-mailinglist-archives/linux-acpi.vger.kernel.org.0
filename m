Return-Path: <linux-acpi+bounces-11866-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77534A50A03
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 19:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A1C3ABB22
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 18:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01194253326;
	Wed,  5 Mar 2025 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ntXUTPGQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F022528F6
	for <linux-acpi@vger.kernel.org>; Wed,  5 Mar 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199343; cv=none; b=GvpDg5WJv9zoMQO+lEsv215n1Yssn0t31b6rmZLUc2PBsOwrsQol0hkGf9f/jcFnFFRHvV2NgeLN/OUnGUtr1rKyQZnE7wy2dEp5dRCevMLvN8L106lgMA8FYEiDXpIAx96zMsVNNaiNPTvNVh4qazc/SLoCrs+xb66lYWMuC9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199343; c=relaxed/simple;
	bh=m+xkMwoySrd0uSVjVDdxdBcJZDoeadqoxer/R/dsQu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/8NywYHzPvF9zcYiNF2rm4aC7mCc6+f/w/piNlc8RGjQi6t0d6NYTsLIGIZOHC0paBHgZFYck1LK6STXn0mC4i2lXyXRP4kQJIwpQ0QO1f8wHGkI5pKAMFNriPXI61WrvL2u45CUov6NcG2sEMBwLcJ3BucXHBunHN+AVhYu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ntXUTPGQ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be8f281714so828071685a.1
        for <linux-acpi@vger.kernel.org>; Wed, 05 Mar 2025 10:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741199340; x=1741804140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qytsi8AsRvyusqMe3jOhTvgsVPTM08UZ5Jj8wi8LUdo=;
        b=ntXUTPGQ2OhCeIeDBZigmR2lhyh7Dwx091quvr3fUKRKbY1a5Vq1kr7PX3zyQLHRfr
         DJRIRxj5MP8M0rOZ4cbG/9+kD6nzREFD66/T37MceNneQ+iTqDkHv4rs6H3XRtU3WQ1/
         ZfL0BkSN3DK3JkdfTwjjW2SE9DoGicAW6tBdDJODmUf2JwMr44z+rt0m4bM3D3U+t4tF
         3Gx5tDZimGE8rUazvfqFzzY7Ftu5ALorY1zO1eD4gipqmgvTQGeNyekJgCw5A4k3HXyE
         zLsswuVuz6l6t3ukQIkdnjjaGCiAP+JfCD0E+l1T8HwgNA1khJvL49/Fx4mLalOR13nm
         MfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741199340; x=1741804140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qytsi8AsRvyusqMe3jOhTvgsVPTM08UZ5Jj8wi8LUdo=;
        b=Xpn+3/1MBL1RUKE4MFx4NdGmbkCJcFrpoe8JuCVkgzm6qVuVBao7M9p39IV2mywZBm
         vbxUXDYF4StqukrcOpYtY/Wj1HHBG0zzhXWuHfbwQouEbY81e9IAXTtES1idK8KBFzxH
         RsySCvBKN/xPQMb5Xu58qMbhiJ2FGJoU581YLNLwxMNw6gq9cjh12AlMsXrD1RLBgL3U
         6ManEBO6ZsveE8Cgk5u3lxk/kBYb/477ibMWzA43AqI/M8ZYjfjDFwE3Iol2k+kMUXSz
         EhgmosMu/1H5Pw1H9Jk/dbTAhvDmJLYZ+jzG9xQeeUKV3k2J+TAfc0IdqijUuypxqyj+
         I11g==
X-Forwarded-Encrypted: i=1; AJvYcCXpqvXBna2Cjuba5664XNPrwm7B8GWAhf++G/FAoZ2c2FhnxQnnen0lsGTcV4gT+ZYkRAqcuUZzH1la@vger.kernel.org
X-Gm-Message-State: AOJu0YynSgy+PFTmldCVGZ2vIebFy3OHhM47JtV8PBwt9zcmq7o44ta0
	rcHKsLtkKMHZP7p4vakH1vEHxKgT35Oqai9yPqM/ONogeXM73jiO3/2JeY9in0I=
X-Gm-Gg: ASbGncvGLTeKCWvKERi3CJrWO8tVLSmOzbkTRQCOTx4fHQ+ipI/jN54CSJbdiRsduwt
	jEQTS9K3RF3IRwbOdH6NhiMyFfrnucL2eBVjKOadUx4u2AMJlW9eN+Epg1vhkEXIT9vGqChi2//
	vIsr9L7qdqGWmmkKzTdGKnjKoOPInVg159328UyPopNF+NNOPuRn83GaPSFOHLxsxC9FBe8J7t+
	DNhqXdjSjtAXxUc05NNWYXSgdQGbon3/e4SulQimGuvAjPVuIXZiNu5K21IhytfrnvVPkUQLqdH
	TtDeiaLKU12hTbb4WMY=
X-Google-Smtp-Source: AGHT+IFWMmT9cW2Ut5DYuDUpvyIFOmmiZcEpt4WPetA8yQdQkDPqbKkYQiVXDZwiZSFr/BdwTkrEVw==
X-Received: by 2002:a05:620a:8806:b0:7c3:bcb2:f440 with SMTP id af79cd13be357-7c3d8e703f8mr618694385a.33.1741199340112;
        Wed, 05 Mar 2025 10:29:00 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474e90b8853sm44121231cf.65.2025.03.05.10.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:28:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tptUI-00000001UBj-3ss3;
	Wed, 05 Mar 2025 14:28:58 -0400
Date: Wed, 5 Mar 2025 14:28:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Message-ID: <20250305182858.GK5011@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>

On Fri, Feb 28, 2025 at 03:46:33PM +0000, Robin Murphy wrote:
> +	if (!dev->driver && dev->bus->dma_configure) {
> +		mutex_unlock(&iommu_probe_device_lock);
> +		dev->bus->dma_configure(dev);
> +		mutex_lock(&iommu_probe_device_lock);
> +	}

I think it would be very nice to get rid of the lock/unlock.. It makes
me nervous that we continue on assuming dev->iommu was freshly
allocated..

 setup the dev->iommu partially, then drop the lock.

There is only one other caller in:

static int really_probe(struct device *dev, const struct device_driver *drv)
{
	if (dev->bus->dma_configure) {
		ret = dev->bus->dma_configure(dev);
		if (ret)
			goto pinctrl_bind_failed;
	}

Is it feasible to make it so the caller has to hold the
iommu_probe_device_lock prior to calling the op?

That would require moving the locking inside of_dma_configure to less
inside, and using a new iommu_probe_device() wrapper.

However, if you plan to turn this inside out soonish then it would not
be worth the bother.

Anyhow:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

