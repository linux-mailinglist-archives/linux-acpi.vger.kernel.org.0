Return-Path: <linux-acpi+bounces-1554-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E474A7EDE89
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 11:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417CA280DCB
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 10:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC322D049
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4VjVSEp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D674A1A7;
	Thu, 16 Nov 2023 01:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700125270; x=1731661270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/STXsbosH6Rz9sQMt/crvGrrS9Z0X1RfO/fEtM3K5Z0=;
  b=c4VjVSEp+FXbfcPUlMD4dOLzaf2czQG5e5BcvJAIqJ09QVP4TPJwHGVF
   yx4C5RwvB2aeZJ+HbLJCkocyorQciAxNuwadWNZmJrCVrA7lth2cUaNWb
   Ru4V/mu33t4t1ioMQIXCIRbdyqsw+BQR0+UK4hVB0Ao6H529p3LFEVQ7B
   HJNcC4R47c3v7QKrEokzjLPtDbiERAV3VaYVyg6diHWEoPNvnmsQmlI2C
   tcgoOygFG3uY+y1gteOUJrAvA1+6KErTEBXrtBOVB2CMTUdgQDaIVggIg
   ugKd96b3KrGF1+phb24hscy2SFDRwsE1ttgD2fCvWtUUq7DS9K3j4mDmE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="457542981"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="457542981"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 01:00:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768851613"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="768851613"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Nov 2023 01:00:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 9BFF0209; Thu, 16 Nov 2023 11:00:42 +0200 (EET)
Date: Thu, 16 Nov 2023 11:00:42 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" <dri-devel@lists.freedesktop.org>,
	"open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" <nouveau@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] PCI: ACPI: Detect PCIe root ports that are used
 for tunneling
Message-ID: <20231116090042.GF17433@black.fi.intel.com>
References: <20231114200755.14911-1-mario.limonciello@amd.com>
 <20231114200755.14911-6-mario.limonciello@amd.com>
 <20231115104019.GY17433@black.fi.intel.com>
 <70b35a0e-5ccd-4e19-a8ac-4cf095007a69@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70b35a0e-5ccd-4e19-a8ac-4cf095007a69@amd.com>

Hi Mario,

On Wed, Nov 15, 2023 at 11:08:43AM -0600, Mario Limonciello wrote:
> On 11/15/2023 04:40, Mika Westerberg wrote:
> > Hi Mario,
> > 
> > On Tue, Nov 14, 2023 at 02:07:53PM -0600, Mario Limonciello wrote:
> > > USB4 routers support a feature called "PCIe tunneling". This
> > > allows PCIe traffic to be transmitted over USB4 fabric.
> > > 
> > > PCIe root ports that are used in this fashion can be discovered
> > > by device specific data that specifies the USB4 router they are
> > > connected to. For the PCI core, the specific connection information
> > > doesn't matter, but it's interesting to know that this root port is
> > > used for tunneling traffic. This will allow other decisions to be
> > > made based upon it.
> > > 
> > > Detect the `usb4-host-interface` _DSD and if it's found save it
> > > into a new `is_virtual_link` bit in `struct pci_device`.
> > 
> > While this is fine for the "first" tunneled link, this does not take
> > into account possible other "virtual" links that lead to the endpoint in
> > question. Typically for eGPU it only makes sense to plug it directly to
> > the host but say there is a USB4 hub (with PCIe tunneling capabilities)
> > in the middle. Now the link from the hub to the eGPU that is also
> > "virtual" is not marked as such and the bandwidth calculations may not
> > get what is expected.
> 
> Right; you mentioned the DVSEC available for hubs in this case.  As I don't
> have one of these to validate it works properly I was thinking that should
> be a follow up.
> 
> If you think it should be part of the same series I'll add it, but I'd ask
> if you can please check I did it right on one that reports the DVSEC?

I don't think it should be part of this series. I just checked and DVSEC
is only required for hosts so kind of hardware equivalent for the _DSD
property you are using here. For hubs there is no such luxury
unfortunately.

I think I do have hardware here with the DVSEC in place so if you
decide to add it, I should be able to try it.

