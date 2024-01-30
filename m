Return-Path: <linux-acpi+bounces-3089-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 531EB841F1F
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jan 2024 10:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09F03B2FDC2
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jan 2024 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652935BAFC;
	Tue, 30 Jan 2024 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="rc9Mc+Vb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE056B94
	for <linux-acpi@vger.kernel.org>; Tue, 30 Jan 2024 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605661; cv=none; b=pDLujU0TqueBQ6+wwo3XE9Fefzxeb2WUS1Hg5sQIK1rmqM9C6nggpJsplNn3Dn9orxue3ySXwuKShSwW8SoMi6p/CYkNLK80PZVY6nCuFiKg2kjt7H4Mkvd1oIA8d5L8fM/2kUDcDJq2++vty8kF1GCLuyUnuRgsvAjrLWmHQ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605661; c=relaxed/simple;
	bh=44XkCsZCctr6fIPl85tILYlsF3Pmyb1/in21HOr3WR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEi7QrHH7M9STj+DWlUzneJcrckCcGbhbG1MQ3oG579Sty2CytcfhcdNJI+MRMcwEDwwW40Kuth9mqPPmKlkKC19j+jaeGlQ0Z7PXLgiQZhfw99X6iUOtrnQbBnwqhk/GTtyTacFudbm1TLZawQr69lPZMBgBGX1gtsSevA5R9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=rc9Mc+Vb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ae51f8111so1806257f8f.2
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jan 2024 01:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1706605658; x=1707210458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtHLxH7cs3c5SJogzL1Yq2dCgbgujdB2fUN48I8yxUw=;
        b=rc9Mc+Vb/Az0DcPkzb5uTooYwF5tQFJ49mGYm074w8x33a00dkrSTZKPG60WKZbpfu
         3cp3ON48ja/mAkwLU9u+xSpZ14ElXpRv6+oU2EAAuPRdGaTrKgPfY0UXyi+2+zr6f17T
         sN4Gkvi+f0JfMhAub6X1n6DzqA58YAkdN4Meg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605658; x=1707210458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtHLxH7cs3c5SJogzL1Yq2dCgbgujdB2fUN48I8yxUw=;
        b=sm3pQsCm8oiY0UWAJvo3mbJfkTnWIi2+4tUvAuwUE+12gWuhk4kWqC2L+bfFLO73D9
         57far680J7w++A3N9pEfVmrGhvCKpYkmsxweHSkRQvtfnyyFbA89GejFS2TTLJXjw4uw
         OtwzLmnPtaSQ8EaiGvUVvCSTI6Fp7GCS8rW8andu8jhZHYQ44Mol5nHtysRUUTuPEVTs
         5ukaIawdLSnCq3kj7nnnN5jtlv7STjCKOLuXbpjxSNyPDP/JuGIw5jsiwBZF9pYE7yLA
         PK2s14xyndmDqSiJHKXywz9t9y6w9gHJMKl8PrylxlIq3To93ve4kH1rq51jbTLekHPH
         meEw==
X-Gm-Message-State: AOJu0YzBZp6ZBsqDXsThAkt7R5uMglf3M0Z6y40lMBwezUr3YyItKd0N
	nwxHlhkSEKDvksn3Ct2DzSGAq0gC0assNGu5znpXdnluCnZ7WXqWTScdEaluZj8=
X-Google-Smtp-Source: AGHT+IFLxhDmdcX3IN6b2Fn+UG9CGRbGL/awFLcQCQToWkfjaxuNkbTHPqxTVGG3vpy19ocVt6A2Jw==
X-Received: by 2002:a5d:6da3:0:b0:33a:eda8:336a with SMTP id u3-20020a5d6da3000000b0033aeda8336amr4089276wrs.26.1706605657835;
        Tue, 30 Jan 2024 01:07:37 -0800 (PST)
Received: from localhost ([213.195.118.74])
        by smtp.gmail.com with ESMTPSA id ck14-20020a5d5e8e000000b0033afcf26e11sm586620wrb.29.2024.01.30.01.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:07:37 -0800 (PST)
Date: Tue, 30 Jan 2024 10:07:36 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Chen, Jiqian" <Jiqian.Chen@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>,
	"Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>
Subject: Re: [RFC KERNEL PATCH v4 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Message-ID: <Zbi8WJPEUSMgjuVY@macbook>
References: <BL1PR12MB5849B51FADC8226764078A98E77A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20240129220113.GA475965@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129220113.GA475965@bhelgaas>

On Mon, Jan 29, 2024 at 04:01:13PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 25, 2024 at 07:17:24AM +0000, Chen, Jiqian wrote:
> > On 2024/1/24 00:02, Bjorn Helgaas wrote:
> > > On Tue, Jan 23, 2024 at 10:13:52AM +0000, Chen, Jiqian wrote:
> > >> On 2024/1/23 07:37, Bjorn Helgaas wrote:
> > >>> On Fri, Jan 05, 2024 at 02:22:17PM +0800, Jiqian Chen wrote:
> > >>>> There is a need for some scenarios to use gsi sysfs.
> > >>>> For example, when xen passthrough a device to dumU, it will
> > >>>> use gsi to map pirq, but currently userspace can't get gsi
> > >>>> number.
> > >>>> So, add gsi sysfs for that and for other potential scenarios.
> > >> ...
> > > 
> > >>> I don't know enough about Xen to know why it needs the GSI in
> > >>> userspace.  Is this passthrough brand new functionality that can't be
> > >>> done today because we don't expose the GSI yet?
> 
> I assume this must be new functionality, i.e., this kind of
> passthrough does not work today, right?
> 
> > >> has ACPI support and is responsible for detecting and controlling
> > >> the hardware, also it performs privileged operations such as the
> > >> creation of normal (unprivileged) domains DomUs. When we give to a
> > >> DomU direct access to a device, we need also to route the physical
> > >> interrupts to the DomU. In order to do so Xen needs to setup and map
> > >> the interrupts appropriately.
> > > 
> > > What kernel interfaces are used for this setup and mapping?
> >
> > For passthrough devices, the setup and mapping of routing physical
> > interrupts to DomU are done on Xen hypervisor side, hypervisor only
> > need userspace to provide the GSI info, see Xen code:
> > xc_physdev_map_pirq require GSI and then will call hypercall to pass
> > GSI into hypervisor and then hypervisor will do the mapping and
> > routing, kernel doesn't do the setup and mapping.
> 
> So we have to expose the GSI to userspace not because userspace itself
> uses it, but so userspace can turn around and pass it back into the
> kernel?

No, the point is to pass it back to Xen, which doesn't know the
mapping between GSIs and PCI devices because it can't execute the ACPI
AML resource methods that provide such information.

The (Linux) kernel is just a proxy that forwards the hypercalls from
user-space tools into Xen.

> It seems like it would be better for userspace to pass an identifier
> of the PCI device itself back into the hypervisor.  Then the interface
> could be generic and potentially work even on non-ACPI systems where
> the GSI concept doesn't apply.

We would still need a way to pass the GSI to PCI device relation to
the hypervisor, and then cache such data in the hypervisor.

I don't think we have any preference of where such information should
be exposed, but given GSIs are an ACPI concept not specific to Xen
they should be exposed by a non-Xen specific interface.

Thanks, Roger.

