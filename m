Return-Path: <linux-acpi+bounces-11301-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4DFA3C7A9
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5233179D00
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1A12163B0;
	Wed, 19 Feb 2025 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PmypkfxN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389C214A83
	for <linux-acpi@vger.kernel.org>; Wed, 19 Feb 2025 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989775; cv=none; b=trMmMgIKlNAuIfo29x8/rd4W1mnAZQ6K6oiqRrmXiyccH7AWN9G7vLSe9H+FEq5DEl4khl29DLBTTrFs1uDIzkkVZnAfcZpABxsklr/U5ue9z83xn6uMiKZTBMDzqBCKXSxv4FHHV9G0PFa0zXKETzvdz3sxE5EZmDIFiF7wIDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989775; c=relaxed/simple;
	bh=hNvfVR0ZZ2UFjzAGnYJWeJC+N+Q90ykly/lra30oclk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdxK5+ml/2ACQpCCdn/3+CvWRnacHRQiTVae76lUxqepEokJM1YBWGFEIG6Ul+xPWQgQvUs1xNS2aN4E/Fuzjo2IMlf/rwp0ebllC5V1geRqT0GfWWDgOa0Tu6z/fSewkovM//SE1YJbuF/z1W4N4+8dbOz0iF4otVRZQSts4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PmypkfxN; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0a1677aebso7681985a.0
        for <linux-acpi@vger.kernel.org>; Wed, 19 Feb 2025 10:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739989772; x=1740594572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tKMJ3X6Jzp+wNnNxZ3cTu3f1diCv42/eMEvkIcSBFc4=;
        b=PmypkfxNzF+1Ps74JyQib0woINIH5uY8g24xF+LDigxh14LIjFyLE4tKpMD43Pz3GO
         MCBNVELcQ9qeJ+GlKdR7zSCCGPr5akM/moSmVRLGvpsA3lIROeti2Jl9tXfBJjTItK2c
         yYlpknRMhmSE3bcZl9cojpPBNKSOi05sL9qzJqVAxnCzwH/w6Eg81YPgtoHaXrEVyOLH
         RjsUJ3bO6J01LTuSmO2En+JrIvAWh9IuI6FvwT+9z1E/9lMuv0FO08vAjWaH5cdSmKHX
         SB4tUgyMVmlq2LuYol7f5Mo4ZcjHP+FdRq9UMqrZw9INshSXW5yUndjpcLxwQXQMMVhe
         oV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989772; x=1740594572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKMJ3X6Jzp+wNnNxZ3cTu3f1diCv42/eMEvkIcSBFc4=;
        b=ebtpBWWIOcZNXQx+zir+IdMm0seJeIyHlfkVL2RfJJorGrDFN/48ld+n0ZodQK+4c0
         5aDbHQ7qQ5pOQJo0ZhlJjciqS9bK5nqLQGNydjUWbOUeGdZE835cv+HZjtWLNjRrmXYE
         K/09ew4IQa+YzlalYT3m3wShTVBnMEgfptO87rlQsngxTKDCGhAA1Z7E3cextnXOd78u
         oIKZ6DnTefGNVFP3M+1BsBSrwZeUiWC2hIJUHdzu/88hB/TaIK/GAWJi4IVUp+pCHSH8
         GSQJE9vHCMi20WQPEOV3JKuWdNd1KLNoFKi7RIROzK2X9oRZyG+PK7p3mzHRA4rJyI/r
         Wrhw==
X-Forwarded-Encrypted: i=1; AJvYcCXQSLlzSB0ywOq50Emmh6qI/Z0mV23d4+tQxuWEYReh7iGxDsY2EUSt155hFWDYhTl0mNX/qxi6hZWr@vger.kernel.org
X-Gm-Message-State: AOJu0YyVR9ww4qFvf9ni/ivZOIJkBsVCbyKdOGgK0qV5qMvD8A9/SUu9
	rsMT4P0/WFgTXC23X4YETP1Lf3iT42IjZ9UcRm3E2Gus3vx8ou15O3DigM3A/BE=
X-Gm-Gg: ASbGnctXslTKWt8TZPK7RLPXsoBx5lQ47squfGxlZW1WHIHSs7t0oQiannO9FflsB7Y
	D7FDbzhN9AAAUPl8PCuS31Rh3bx1UUb1vajjh50QfOR5Oe++jenf1CjL44Agw9m8kXXgQ0pUOcq
	Qzo400abLYZxOvQy+37ZQIguVW8bid/DdQfSAnnkw7lkRqDx21hyRVjy0LsNjEXBXrUy7IIIIvl
	7e4tXFZGsUGxrL3lleOLjMHE8urLhYTgBrnOZooPrPNxtK2z5wG8uY1PDSRNeXBfAVMRpQKSG/z
	S8Zjp75cSnXmyWGuZ1PlJbPHBrQqcVhz6PAP0cEasfIMphxGjlRCzkcu1bgkw1mx
X-Google-Smtp-Source: AGHT+IG6vD9GMzJFRgKV5tkVvAkzSXjZzf3sKuYbia/+L+uYcxerEW/IEbYH+D0NjcMpo2cEEaQ1ow==
X-Received: by 2002:a05:620a:1787:b0:7be:5bc1:9460 with SMTP id af79cd13be357-7c08aa9ab2dmr2845829285a.35.1739989765100;
        Wed, 19 Feb 2025 10:29:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a609cb1bsm303023085a.111.2025.02.19.10.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:29:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkop2-000000009V2-07PN;
	Wed, 19 Feb 2025 14:29:24 -0400
Date: Wed, 19 Feb 2025 14:29:24 -0400
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
Subject: Re: [PATCH 2/2] iommu: Get DT/ACPI parsing into the proper probe path
Message-ID: <20250219182924.GN3696814@ziepe.ca>
References: <cover.1739486121.git.robin.murphy@arm.com>
 <c2f0ae276fd5a18e1653bae8bb0c51670e35b283.1739486121.git.robin.murphy@arm.com>
 <20250214201435.GF3696814@ziepe.ca>
 <4a7823b2-2634-4148-8446-ad01a09b6880@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a7823b2-2634-4148-8446-ad01a09b6880@arm.com>

On Mon, Feb 17, 2025 at 03:00:46PM +0000, Robin Murphy wrote:
> On 14/02/2025 8:14 pm, Jason Gunthorpe wrote:
> > On Thu, Feb 13, 2025 at 11:49:00PM +0000, Robin Murphy wrote:
> > 
> > > much just calling the same path twice. At client driver probe time,
> > > dev->driver is obviously set; conversely at device_add(), or a
> > > subsequent bus_iommu_probe(), any device waiting for an IOMMU really
> > 
> > Could you put the dev->driver test into iommu_device_use_default_domain()?
> > 
> > It looks like many of the cases are just guarding that call.
> > 
> > > should *not* have a driver already, so we can use that as a condition to
> > > disambiguate the two cases, and avoid recursing back into the IOMMU core
> > > at the wrong times.
> > 
> > Which sounds like this:
> > 
> > > +		mutex_unlock(&iommu_probe_device_lock);
> > > +		dev->bus->dma_configure(dev);
> > > +		mutex_lock(&iommu_probe_device_lock);
> > > +	}
> > 
> > Shouldn't call iommu_device_use_default_domain() ?
> 
> Semantically it shouldn't really be called at this stage, but it won't be
> anyway since "to_<x>_driver(NULL)->driver_managed_dma" is not false -
> trouble is it's also not true ;)

That case in PCI I understood, but the other cases seemed like they
would be OK, especially if group is NULL

> > This is the test I mean, if iommu_group is set then
> > dev->iommu->iommu_dev->ops is supposed to be valid too. It seems like
> > it should be done earlier..
> 
> Yeah, looking at it now I'm really not sure why this ended up in this order
> - I guess I was effectively adding the dma_configure() call to the front of
> the existing iommu_fwspec_ops() check, and then I moved the lockdep_assert()
> up to make more sense. But then the ops check probably should have been
> after the group check to begin with, for much the same reasoning as above.
> I'll sort that out for v2.

I guess check it at the top and then check it again after re-locking.

> > > +	 * And if we do now see any replay calls, they would indicate someone
> > > +	 * misusing the dma_configure path outside bus code.
> > > +	 */
> > > +	if (dev_iommu_fwspec_get(dev) && dev->driver)
> > > +		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
> > 
> > WARN_ON_ONCE or dump_stack() to get the stack trace out?
> 
> Indeed, hence dev_WARN() (!= dev_warn())

Oh, I've never seen that variation before!

Jason

