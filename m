Return-Path: <linux-acpi+bounces-17433-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE85BAA3D7
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 19:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BBD192368E
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB4221FC8;
	Mon, 29 Sep 2025 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n4gAIY7B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34E15855E
	for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168628; cv=none; b=rirqvDDByNifgHUYVfR2d7doVVQhMm9o6KLZSqXism6t8tjpI1G/A3QTO7BYGoymsPb4AbUTKOIasdp1NawjzPo2eLPl7oj3RPlt7r8GmBpY9hBi1GxhiOl0bUF7WTuPHhvuB4MCP4A2/GQM0X8X0QXEDc4ZI5+mzkCPnZ3CSHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168628; c=relaxed/simple;
	bh=Ej3spbu5J2zc+b/KtZHQNvatQD77mVd1Ebq6G/Cw2xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erTOc4OndYofT/ViddzIbsn8xntHNOQqVVk4G6QUx34Ar+0wqHJ5T/Bg+pNbMzwbIDQoJlMyH2lzuwTTIVDz6MKjQsjxSBk2jq+7v6mkkNNf54hI5DbjDTYj7NI7zEm1uzagSi0TZsRHxgmzJxvgtGVtoMMJKO+oWF6I5z7vFXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n4gAIY7B; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso1917294b3a.0
        for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759168626; x=1759773426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSEfWA1uLs7j42NbWHoxDuAcJfkgLIbQX7B0j4gXr2A=;
        b=n4gAIY7B8jsesZlN+FKLD1ej3sA5WauGkdqVcsunFs1umteoPa98rMUQIpe7uEC4of
         w/0NfQpJ+JMDf9zb2YEJZtkvhMAqgCaEHtNFoF15QtSuvViNxJFPquhVE/DEPYbz0tKu
         lGEl2VNCrbrSIxKG54fCHDzlX08fJdfYT78zusa2cSX6IB/EGzD2A+KdfZQZ+yRzBW8X
         9N5xStq6aNuuwZZU4PZ0jJz5OXOS59fHPk7UPG8u/trlSinu1TYkU+0ow5q9C3ETmsII
         aE0KMk0ceP+s2a+kKot1rP5MA6bI8Tvh2+CfrNGKclaNJZh96UANYrEqToSLsPzLiQ1h
         Q0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759168626; x=1759773426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSEfWA1uLs7j42NbWHoxDuAcJfkgLIbQX7B0j4gXr2A=;
        b=uzNF8J2pnFAKbCkuQoCK26m5sIuV4DL7/up7C+eYaSYEDHWixpIVlNnSJzb838XWG6
         kAC8lfWbm/ZWGWKLpId5c70VgsutVN0k0vuYSq06l/XOlKPPnI/XvsLYeSbOCp3Z4noU
         B/4Eb1ngzFjWDjOKEcHjvtCkuYrBl2qX42HnwvCLU9KP/P86CXiZ8mFlmNSXFD7HzF6H
         Mx96+HdLKKMQ6WyPcnNnlXPaQYrgm95/9UHpll01e8O2B/5XRY8CVXOfgqYjHI/mRgd+
         xTIeoVz5iOc10SF32Ch4ljfd+2b+Q3z1TBz2nPYTGrPK2jgJ8+tGZYSJb5iDlawlS/Er
         yG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIoFGQd4cL4DrYUBQ0lebk4zoKEyWPLad4EQw3nqkqbfftSPkFOE3A0Rfd0qHKOpdUZuaGMO216Tv1@vger.kernel.org
X-Gm-Message-State: AOJu0YzWvH4u9XVqMxRwHn9+VJkYxhgYkgGvNR4ajHIvdzUgogVNqnxP
	nx7c44fWArIScPHxbeQFnUDylPKRNXWHrZxe62GCuRZsxCJ8xdU8gh4XtrEza0UakEA=
X-Gm-Gg: ASbGncu5Vj6UumUe2DwYqVkF+a2m9GUAYio+GWC5WPI0UvzOsYNOyPI2Jz2iTH+qJzI
	iDaQaRQaUz0Y/MsgBs34s4DV3McDOjER0DxzxXWN6VG/EQjOFoQRV8rcyxp3Iq1JqD7jhdgE5Uz
	vecnI5iaOE1MFissmdFodf9fGg3874aOWDI9AXXM1jwN0gV19Hf3sSXW+DfHVuZGSKNPY1/9/LK
	HkRTiUSEJ5UqtKeiBIHjl3tIOOlDYrKmeT3CUpqtFFTY7BI5RPyI91MUa1EgmRFZogMEZNesbNj
	apBFZZHS+0hZ6Ic83RGotCnxDx/eUrF7+lFLVxT9Vk9G39ZijDqiBtgT0R+9/qLDsJIiWFvJ
X-Google-Smtp-Source: AGHT+IEC8oBuuW4/Xw28rIvKPHz1CFCYAk3QHNI8WxtedXpOGhzC8bhDdJWSvjwEZ8vuUpUfIyJQTQ==
X-Received: by 2002:a05:6a20:9712:b0:2fa:e8f4:618b with SMTP id adf61e73a8af0-2fae922592amr10511358637.26.1759168626501;
        Mon, 29 Sep 2025 10:57:06 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c52eee5fsm12037328a12.0.2025.09.29.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 10:57:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3I7U-0000000CNpB-3RFT;
	Mon, 29 Sep 2025 14:57:04 -0300
Date: Mon, 29 Sep 2025 14:57:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
Message-ID: <20250929175704.GK2695987@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>

On Tue, Sep 16, 2025 at 12:45:14AM -0700, Chris Li wrote:
> Save the PCI driver name into "struct pci_dev_ser" during the PCI
> prepare callback.
> 
> After kexec, use driver_set_override() to ensure the device is
> bound only to the saved driver.

This doesn't seem like a great idea, driver name should not be made
ABI.

I would drop this patch and punt to the initrd. We need a more
flexible way to manage driver auto binding for CC under initrd control
anyhow, the same should be reused for hypervisors to shift driver
binding policy to userspace.

Jason

