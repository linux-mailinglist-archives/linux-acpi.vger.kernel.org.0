Return-Path: <linux-acpi+bounces-11865-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79F8A5094D
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 19:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B97188958E
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 18:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA20D252919;
	Wed,  5 Mar 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y+QJv0BN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B48250C1A
	for <linux-acpi@vger.kernel.org>; Wed,  5 Mar 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198479; cv=none; b=jca0/OSQlE8sKwV8J8Y9RweSbfJ6DIaE3ens3sqB8fQ+RP7pShEb5lE+gCiKL12EX3B66w6isAAXpJw6wkr8eQGCmg+yjvKEJu4bTPMeCXoh8P+DTGz5zwfL6/sfro4jPXzXjRxzDiLWA4HyexkiUi0oFkedFX09czKYU2Gd6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198479; c=relaxed/simple;
	bh=lDGktsrrvusw3EwyIKgqSW+1nB/A4uH5GaWgGqTDi+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPnxtFqFhVIXUq07gExGBZyDLhaLNB1vPkkMWbTJ/Ll4HOWefdBeLzZ3e+YQ99aa3AiqN19YE+48IQjXzYXIX/00KN/FXCCWu/KdbWX4ekS32/3lUA3B1z4F37/tNuSOP/pYCqiyrR5/5HP1XSqg7lc3pRBoOt8Ux6Oi0rn0WWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Y+QJv0BN; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c3cf3afc2bso213348385a.0
        for <linux-acpi@vger.kernel.org>; Wed, 05 Mar 2025 10:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741198476; x=1741803276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BM3nl1PDUv3g4PwFQ23XNaGdtMsSR0uMk4FDd4zSWU0=;
        b=Y+QJv0BNv1h50k0q6lHIhHKtGAX+jzCkhA1/+Fi0IVupW6xrJv3OUj+z42+l3i7QIu
         oaDWLn3lWMRe8hwvUtTfNmmO9msLSIN8fG4TVsbL9DhGNHfX+9MLs6+BxHXsMvOwBQ32
         88FUxHbsgqGoHXBYtg8CzakkX0IPm1PiUty6cEBOHpdshKu5FDgCcdByE5gAvvv6YJHv
         1K7LjoyXYa5Hu2uugJuoSoefYNQCZYTtkFLeHueHKm+yk64X4R43xkqy98SKUTaFCWcH
         BUGqUV1XafFjeDkinPilRsDPn5w/4zJkfMrfqv2nH5S57cg2WnTU/25CvNdEcEukPtY/
         KfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741198476; x=1741803276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM3nl1PDUv3g4PwFQ23XNaGdtMsSR0uMk4FDd4zSWU0=;
        b=khEUmkYxYrXFouEfCcD02iViSFjtQN8j8+zUdu0B5gcGkh560/63mZFwktwz+3jjyy
         dLmRCUD1cOw4um5vvgcvPiJGUp2HtNI3BsILR3OYXNq4OFua1bkb+b0OCPgW4jg108ru
         VMdjhD1E8LQQpwwLtgQnHNH5Ly8bIV+xWvACiWTeAf9VsQgL6ZP6DNuzOKXbkIBjWY0T
         c5Y7AqM+kK4cG/8ofXWlieP99YEKO8t20o8Mb6ViebJsXlk8QNo4eh6VKnZ47EVidN2F
         udIB85qlAduvt6pf05o/GOGSt2O1tHloPQvuehr6tuDNxkSgzoXZ2b3ACTqU/njFM+YR
         0Xhw==
X-Forwarded-Encrypted: i=1; AJvYcCUzXvLbIl53q11KLUCEV1NIO1vBU/C9MZRkhVtZsJ+0okpyexZsA+veBnF7GHMKNhcdZyo+aXvzL7wB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0A7R6SnE+U1slJ2zSUMIDoGyyiXduYgywUtNOJk3s+pMWrrTQ
	0POkRdH5JT1wd2BEHXoq6eIwTPGOQHEVoIKb1foexyezUNg/8gzSYw1gaZAvQ0E=
X-Gm-Gg: ASbGncsdJpk2NAwbyL/GU7r5RERKKrjK2C3GuYmY9fgOzIuQDt2DB87UmCaVJG+YGHu
	AdN4fZdsgJNQRGONQmMMk4XuyEr+Cvz3gb+6rA6fW5vheTdx9HWl71IrZZFa5HMPjBBqQRVWpnY
	FnL2xg4vCXC8jp4JQl7RlWscPKYGZHyAWJi2/ZftYVCp3c26xh88HlTTvFSTpXBM9cpWH7zu8rW
	KRqeJA19wnokyFCyQZhAxMY10XNC3yormT434RVJVaymeY08q1GDlipRBPk8Lw7cSHO2QizVPo8
	//NEh6lI6Gxh6zL3gK0=
X-Google-Smtp-Source: AGHT+IGBXOlCQEjAXivcZONN7HD211rRxB+Amwcgf4SScDXv9d/J0SEM3NN6sEdvhUlnOiPXZLnHzQ==
X-Received: by 2002:a05:620a:2b44:b0:7c3:c077:fbf2 with SMTP id af79cd13be357-7c3d8ee8505mr677678685a.45.1741198476550;
        Wed, 05 Mar 2025 10:14:36 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976da283sm81577696d6.111.2025.03.05.10.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:14:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tptGN-00000001U2f-0a3P;
	Wed, 05 Mar 2025 14:14:35 -0400
Date: Wed, 5 Mar 2025 14:14:35 -0400
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
Subject: Re: [PATCH v2 3/4] iommu: Keep dev->iommu state consistent
Message-ID: <20250305181435.GJ5011@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <d219663a3f23001f23d520a883ac622d70b4e642.1740753261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d219663a3f23001f23d520a883ac622d70b4e642.1740753261.git.robin.murphy@arm.com>

On Fri, Feb 28, 2025 at 03:46:32PM +0000, Robin Murphy wrote:
> @@ -127,6 +128,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>  		mutex_unlock(&iommu_probe_device_lock);
>  		return 0;
>  	}
> +	dev_iommu_present = dev->iommu;

I feel like this deserves a comment..

Maybe it is:

/*
 * If of_iommu_configure is called outside the iommu probe path
 * dev->iommu should be NULL and it needs to remain as NULL
 * If it is called within the probe path then the dev->iommu
 * was setup by iommu_init_device() and must not be changed.
 */

And I think the commit message should explain what consistent
means.. AFAICT you are going for !dev->iommu means no probe has
succeed / dev->iommu means a probe is ongoing in this call chain or
it has succeeded?

Otherwise:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

