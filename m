Return-Path: <linux-acpi+bounces-17431-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B450BAA395
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 19:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA097A69FE
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4321E5711;
	Mon, 29 Sep 2025 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RvKAuoui"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73B01B394F
	for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167992; cv=none; b=U4isn8VKodMsO3DyLbWrspwROJzgIIxPidvil5CzXf4tgbhwSd07A9LFuwTG3Gl8ozQ/MVV2uO47vZcx1FhRl2voPmfIb7cL8vgSe89DFyf9PqD1igcOPwXgvHqEzRpJ1PDHmVjIgp35SYPGwgj/LxVkI23OA/iuehXI06nNyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167992; c=relaxed/simple;
	bh=H3LBXvT182wT0ex9LDutokYOCnXgq0ndAm+2Ud0WjYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj0LeeY/9AcNc/kZEssd8UFJFoqOUSv6azb+IEQfg/LP02TCsgEsd72fRn3Lh25U7b9UwNb86apQID/wJLXDmq+AitRbZG4Qi509Q8oVWWOhoHca9vKYsSY0fyKlRSvH5Cj8LfH6b1T8pthwHCxnNliIaEYZuO9NIZ55oE07leI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RvKAuoui; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4da72b541f8so61466931cf.1
        for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759167989; x=1759772789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekGW8DgI6WebvQt3SE7n7wwqZhBDCV4b8cIcqpBzX1Y=;
        b=RvKAuouiVKvoTWmTAMSZtSVx9QKL7nNS3k9xg+Nt/I7ZRwsXKgnChnDj0JcnrriSlr
         4WQlkNHQbm6ENBK9ovjtLK9BBgHj46JDfkVThVbTd/+lSb1t0AMQgowhpjncrV3tIFKc
         VJ8v8e6k+gHAcuzDPRlEl03It8IwWeH9YQxnIKxOPY/Zl3FISCC1nV/rl2ZbY8CoBgJG
         T0zuqpUH0LQhztGU2qISPn4mK7S9RDvzhSj7SVX/ILOgrtD+6kbfElI5VQxsD3D2m2Vb
         SUJkW5VX/5MrqzssD/xdDIHvdqTMa4VdqTezM5kQ3qb/XfI8jpSBciUyfJa9kkYakDyz
         ha1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759167989; x=1759772789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekGW8DgI6WebvQt3SE7n7wwqZhBDCV4b8cIcqpBzX1Y=;
        b=QcafwE7sT9ht9ZAuNqRJnw+4Kr0EDEgdYw1Nv4wRTWb/ESnc8CcoNmsPKWdHWeBBa4
         JM3RuZv8kc5DzsmLG6J9Rt/R3TPvbJ+Wy12cihNBzD5SrJw1Sixe3C9NdN+Yz7rhsCw0
         UeQgFhKqOFCSd3rUcBC4wjk4Mpo8g1UVpzEgIkXzfUjrGeU3Gyl0L/QI0HnOshBgiznv
         M8Z6ycGhMtep/EcaLgMGa0r+13xJ+SHwSUOrUFMUS/VTpA4Bnd7BzuEuwDYyaKPXZVib
         6tXuWzFAxjC3+TxXw4HOOI5q6AWXo3rHtQrbTQQV+couwELkWErZAWW2qEhjjqLBbney
         meEA==
X-Forwarded-Encrypted: i=1; AJvYcCX8N5l5FW2rQiAMGF+dJZv3Ta4Pw3VdqxpQur9tNMSQ2q6hir5+IozOx8Xiz+3Eg4N7HSPp0iRCbyqo@vger.kernel.org
X-Gm-Message-State: AOJu0YzOafw6D1yp+OJZVp7YxylMvtcBXfSB0Jj1bCoPEI4W921289g8
	xWdcFBwHUCyKZgISedmgJiFzNhZ4bpKStkp2d2GkqjV2e3JI04CJStSm/Mkk3MJHSOI=
X-Gm-Gg: ASbGncszkANPQqb9y5x8SnstkCdsSv6xxJy1DrDLyldP0jV3T8vxLaIRVsmPhnPOTiB
	kL27OgU4tVcNj0GemeraIADbYXwPsFKhRs3TPX7At5jGgbuuuTxh1Dy6fGMBrs7OwuEonWqVGOU
	0UgM8Adzmks5D6fr/bdOs6IwZO+1/9z7CVZmTazEVqsqgmwpTsHpiLDg7C8Xk0SLsIity6DgGY0
	1vAWrRtIxZyxN//fr1Sl8j371FKSnx47BEJsP8voHyQvZDL8edRch8pD/L4aqpHBN+CZI4IffO3
	Wwv4sfOxTajzg1IiI9MuodD8XWHvV/7L/bBnEXpmuKR+qDSsz9McX5OQkzgn1HVDpxcbURCBl4E
	qLWth0Ko=
X-Google-Smtp-Source: AGHT+IGV5bd0OxOxeha94oMHGR7r6z2JQMG5YvjTqqBPp/nfSpSoj6eA3rdVJdGjuygNySyB8mMM0w==
X-Received: by 2002:a05:622a:15c8:b0:4de:f1eb:e296 with SMTP id d75a77b69052e-4def1ebe887mr122193321cf.77.1759167989475;
        Mon, 29 Sep 2025 10:46:29 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c306b641asm844443385a.37.2025.09.29.10.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 10:46:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3HxD-0000000CNky-1poo;
	Mon, 29 Sep 2025 14:46:27 -0300
Date: Mon, 29 Sep 2025 14:46:27 -0300
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
Message-ID: <20250929174627.GI2695987@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-luo-pci-v2-2-c494053c3c08@kernel.org>

On Tue, Sep 16, 2025 at 12:45:10AM -0700, Chris Li wrote:
>  static int pci_liveupdate_prepare(void *arg, u64 *data)
>  {
> +	LIST_HEAD(requested_devices);
> +
>  	pr_info("prepare data[%llx]\n", *data);
> +
> +	pci_lock_rescan_remove();
> +	down_write(&pci_bus_sem);
> +
> +	build_liveupdate_devices(&requested_devices);
> +	cleanup_liveupdate_devices(&requested_devices);
> +
> +	up_write(&pci_bus_sem);
> +	pci_unlock_rescan_remove();
>  	return 0;
>  }

This doesn't seem conceptually right, PCI should not be preserving
everything. Only devices and their related hierarchy that are opted
into live update by iommufd should be preserved.

Jason

