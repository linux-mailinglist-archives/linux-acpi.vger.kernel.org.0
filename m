Return-Path: <linux-acpi+bounces-17454-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD53BAE111
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Sep 2025 18:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BDBA4E259E
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Sep 2025 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9924923ABAF;
	Tue, 30 Sep 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QXDWdEhq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0623CF12
	for <linux-acpi@vger.kernel.org>; Tue, 30 Sep 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250256; cv=none; b=DWj9NksLIb4XumGaUHaLw3DrDqhHwGq3eyf2GX5pXdYOZBSfDcYPoNAZCnw+UR0J+We1mc0JnXl/E5fDV00JpBk1wvykgCdx+cUPokyQV4RzQoHV7EBhltjEZ2hVotZ7Qs91xGZee6G6q1mK7F+sYMT7LezqOFtnoU3KnoI6GWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250256; c=relaxed/simple;
	bh=wZlnhLVWjCo/EoZ8rwJ+2WNDjewuk+/wknr5aB3MEkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADDQV9I6eFzZZsY9Jji6aFU6B0mpnujC9tAxHVEVFmeTbiiwS5MO27/jsNd1A5y5MNpcTzZHRd0vK1UR2YsinbKnhADM1VGFBvxRBoIMmA94h6CnJcjqvpiKSGv/ikUY/OGYXVjGB+AiHUOKSqJfKen8RmouydRybNNHIIrLUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QXDWdEhq; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7ea50f94045so642146d6.1
        for <linux-acpi@vger.kernel.org>; Tue, 30 Sep 2025 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759250254; x=1759855054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZlnhLVWjCo/EoZ8rwJ+2WNDjewuk+/wknr5aB3MEkU=;
        b=QXDWdEhq6DrEERhYXLsV8N2u8lhNdFUKfN8/cQK5terzImXnW+c1KYzeNEIrcu6r9a
         TGXDMnJGDgaqn/+1ZZJR6eJtflG+y+ULwaeQMlVMtRknJLEpbJg1lUcm5ynEWvDjJKye
         O4apiuqGYsjUrhwhNeq01OHMy0TC1Xw4xluczD39vGkXSA3BiiVQMtYd6RKtI7Y0geji
         mXkar18DiCFacXLx42+pZU/mZvibP01gvp0tmUfNezH6mSJ5r9fDjHePGhIvcylzJy42
         beBP2C8wWvZZBgxhGV2ytQMyIvnvWJIlry90DAgF9jz3Ab0fGAb4Dvxu2myyCbWCf259
         2I9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759250254; x=1759855054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZlnhLVWjCo/EoZ8rwJ+2WNDjewuk+/wknr5aB3MEkU=;
        b=osbwvKryUV9puSqA+lfZtWy3XqYBe5ZXm2zU4quj686NEB6qWNKGSYK5Txisz7+NCh
         2YzTJ+TwNUz3fkcaUO1vG5huBThrQWf1nsWNijAnlUN+6uRVmZ9Mr6kSIH9zIjqSiBfs
         7USgMM97n+0+EwsDhnLT8BGex2mtOeAZc25kod4hQHQERvaEWvMbso14OOUE1nC9zUBo
         /Wj/1pqqXDSKtAkA0Nhv2r1dhkvSKOvMtsG8C7bVNmFH+ccoSyTi/8hvqUX5la0U0m2B
         2npfEpz3QGz/JF4muHXXzfpIptcPbEkVmsGEy1v6jzc2n5IhJmjQ5DR5Ph9mkvzdfL++
         MHSA==
X-Forwarded-Encrypted: i=1; AJvYcCUAUeoPtPt7O57qOJ6cVw0mVhQS+wV7FP9TrNSjrwGBcFATONuljnfpWn9tsErLNshBhESMPxB0IXgG@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLSSYGiMaisAS+qHB9DoiOoRYTb2su7uoAT8wyeMAimBwVojB
	0k5zfBN9O+uftfMmPlkW7qvIfIIdZdLPt1DiJK3pCGRVI65tmamIoUg5Yxakc1rTKCI=
X-Gm-Gg: ASbGncsw0OIi2ubbA24xliIg8ReNEKZHJjMk8NlDwIeoQvAlwSawM83IlOtDq1/Mwbr
	EwIOnRI4At94c4Wx7JjMKulQTjF02vnmm/icBxwZE1dmRDpfzD2QEeewzozD1hvZLy8ff96+RmP
	JVju1hSN9Mgmu6AGMcOznWqf6oaFjacT04Eoqz43KEzB65RcCjqXqOT3eABqFQ5cR8pfrisTRfU
	UxbmfBIHV9Ch1RQBqJFNbRZUuThGBpl6CYKsZMmFmfu4nnDsJmNpMt0upy87bIELUMtJBEzl6HA
	GQB75iNnmwCSVHGMffHnF65Z4XSW6yM2lNqiNo1jezWqb48p0prWSr9gItB4+YENkp30mDHMw6m
	D+dVDqCsYtJa/uNel5+rKmkpIc5UgVtE=
X-Google-Smtp-Source: AGHT+IFTUouLZO/CN3csdEu5i5OdgDUNjmGvNmvgmP5gfS05E7lB9xEJ9dOZVQrm6wg7EiUAZUUmJg==
X-Received: by 2002:a05:6214:c83:b0:7a7:b219:635f with SMTP id 6a1803df08f44-8737bbfd4ddmr7502266d6.16.1759250253744;
        Tue, 30 Sep 2025 09:37:33 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-801351c328esm99532066d6.9.2025.09.30.09.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:37:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3dM4-0000000CbmJ-21fb;
	Tue, 30 Sep 2025 13:37:32 -0300
Date: Tue, 30 Sep 2025 13:37:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20250930163732.GP2695987@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>
 <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>

On Tue, Sep 30, 2025 at 09:02:44AM -0400, Pasha Tatashin wrote:
> The kernel's PCI core would perform an extra check before falling back
> to the standard PCI ID matching.

This still seems very complex just to solve the VFIO case.

As I said, I would punt all of this to the initrd and let the initrd
explicitly bind drivers.

The only behavior we need from the kernel is to not autobind some
drivers so userspace can control it, and in a LUO type environment
userspace should well know what drivers go where - or can get it from
a preceeding kernel from a memfd.

This is broadly the same thing we need for Confidential Compute anyhow.

Jason

