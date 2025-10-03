Return-Path: <linux-acpi+bounces-17563-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31666BB71D5
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 16:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F13C3AF29B
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697A1F75A6;
	Fri,  3 Oct 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e7f+Yh/4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F2E2B9B9
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500302; cv=none; b=OabHGqo84WwGoaEkN7eq+OROASBSMI1BL4GysRSPcT28lXF+ZIZguNwKep+BR/UME//6/dYzR3TC8rnFoIWggdPpq20SC/7VmM7/BWr3qQebB436MmGcyDdBjjN//5s9kIdgwGRvf2m4X5ALGbr0Ry74znUg5n8lSIejgIwl0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500302; c=relaxed/simple;
	bh=PDOlaahyagViedfiSN8R/K37eGiBows/WNphK5zmxmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQSG3Ht31L8NfAvcTOudz/nCK9YtcAK47xX82Fj/9FbuKdl7WLkDKak3sxUI4BXMYL569T6oqt/LgWjp6aLAc609+s1hquoFmzp8RotlI9GBI0Tt5NuNLf0vVq0b0mV4ADFgHBnf4HOJdLi3BNjpU6YQPXeTjiZVE0U2jHeU2/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e7f+Yh/4; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7501c24a731so26751627b3.3
        for <linux-acpi@vger.kernel.org>; Fri, 03 Oct 2025 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759500300; x=1760105100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDOlaahyagViedfiSN8R/K37eGiBows/WNphK5zmxmA=;
        b=e7f+Yh/4xI08TH+ZaCFnzp0ODA8+QoY5uzzxWJ2DR03ctir5oPxfKL94XcXPLep951
         r9MFGcUUY/AYii/LrxcA24Jkmtc1xPgSzf9OPNOxpP+hAiZ8QSvLpzt/ZqzkHlUjjhOc
         9H+Nau8YvLK3pXjIyGVWG4kW9rHCb6UrmW4xotnIAW+pqoXv5ik+CmpGbHdlO1grMyap
         wDofKCXhs8vatpU0YqW/iy94DXDODFZrOMzH5jGwcFZ/iHkVeboCihgXe+LR7wfCtYzS
         f7jvr6/2rAIcV8AfEnGR2eYpvr71plCXdrdKR9a+dgA3i7M6K5g+yPdYl9h6N/uxsfN6
         HXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759500300; x=1760105100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDOlaahyagViedfiSN8R/K37eGiBows/WNphK5zmxmA=;
        b=SwUbz5rVwCPkyBK9JRnZkHv2Zt0FzXv2PhpG30AVLrsv+3SMnMWHoKtKi7F7NB/1JX
         TAUuM6Tf3hCqAQrS9vz0YJBZHSR/EyJNnBdwJvF1GwluSbqbufDGkCHOjxUSPB+2o7c7
         zmq2GDWfEXAhy3hJ56zTuhUBOD1h8SP+oCdEDJbslje7rGDsQQxqOYcKUj6onIGoOWnv
         08nQuTdfwUweO1PnhAieDe2WOqOzhrsfx099W1uF/23qvDBXFqC2yF24gs7kT1BE4hiq
         vv0onDhJkZvIUDN/1bSuGCiDdbGvx23sHdmPIYyX1GHJM3xIrvNY5J6IQ8c0bjHCSJeW
         pMyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpcLyCMxTTG8GzDEf6eqlaGg6hP9pvRd2zc7Rwtzw9JCo7i0JkNDL0XqBQWgc4ZvBBFEiltu6C5GBJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkJFiKh8fZnfNlxTTaR4cjyFTXvvYTSatGmIUIvcMf2wg1Ce8
	mM9iPzzJ2FBxBwtB98xMYCkp4VK7DpfpmAjxKuBWVnH0pQ/38hWuvA9D2rHqfg+4PKs=
X-Gm-Gg: ASbGncu5Z+0G05ONTINzteB6cWRoXiUq/NqIt7DkhzvYcJcVZ09sfgsukwXZ8Vhz3hV
	TN0U4be10O8Mdn9AavwEIIqlt0vk4leB5zyZCEPkIbdIWX+FhzLQzf6JSSXJLZaueNqPXy0xza2
	YVsjFGtF6FvGq/LKyzaEyYutPOx4n32LbfabOtpmL3zczv05U7WGmkFUsdEm5zKX/jeJ+JeDhbd
	4M1p1UvKMaU6JKzSeRdJD0/rmQetoOOalO4/W57aOgbCIZTJZCNrhxid1QZvK20i0zwD0XHo0N+
	j76mWPvzbxZGgIpJf5+by8nmJ25mLwjqiH59tGWD3DYcD9Q4DpieFy5ysSf7MHwCh+yInspXOk4
	/hUv67JD06I89NDpZrCjZTbekmtn/WN7l7taiKNqUUvXUMQny8bD5RPJXJIEr/JwzLeoWnKz9AD
	Kv0iHUT4N+XtfXQe1fm69xMV4XENA=
X-Google-Smtp-Source: AGHT+IH54YOvJZyYdYQGXmSE3qP2IlgeXBlXhYdTBxgZJrUQNZBBNqv/BfQI4aqzb9AsdFrQGB3Mxw==
X-Received: by 2002:a53:ba42:0:b0:611:ecfe:3655 with SMTP id 956f58d0204a3-63b9a0f0194mr2116314d50.30.1759500300024;
        Fri, 03 Oct 2025 07:05:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877786508c0sm437278485a.43.2025.10.03.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:04:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4gP3-0000000E5yT-3Q5L;
	Fri, 03 Oct 2025 11:04:57 -0300
Date: Fri, 3 Oct 2025 11:04:57 -0300
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
Subject: Re: [PATCH v2 02/10] PCI/LUO: Create requested liveupdate device list
Message-ID: <20251003140457.GO3195829@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org>
 <20250929174627.GI2695987@ziepe.ca>
 <CACePvbVHy_6VmkyEcAwViqGP7tixJOeZBH45LYQFJDzT_atB1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACePvbVHy_6VmkyEcAwViqGP7tixJOeZBH45LYQFJDzT_atB1Q@mail.gmail.com>

On Thu, Oct 02, 2025 at 10:33:20PM -0700, Chris Li wrote:
> The consideration is that some non vfio device like IDPF is preserved
> as well. Does the iommufd encapsulate all the PCI device hierarchy? I
> was thinking the PCI layer knows about the PCI device hierarchy,
> therefore using pci_dev->dev.lu.flags to indicate the participation of
> the PCI liveupdate. Not sure how to drive that from iommufd. Can you
> explain a bit more?

I think you need to start from here and explain what is minimally
needed and identify what gets put in the luo session and what has to
be luo global.

Jason

