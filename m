Return-Path: <linux-acpi+bounces-1295-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4437A7E3535
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 07:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D70B2085C
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 06:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1661EC2CC
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOlG4fpz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5D1C2F;
	Tue,  7 Nov 2023 05:45:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4919A11A;
	Mon,  6 Nov 2023 21:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699335936; x=1730871936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ulbDZvz1gkMd0q7p/mpQrgQlpVcd7at70sX5zqHvqBA=;
  b=cOlG4fpzk8v8Pl7mZVg8wylLQ/j/812fOWoxVRdbxqg7LxLAlXmtUINp
   oiFIsEdWRn29gEdHheS/CwK4bal9oDxJex9OpOAU/99sFe1K+F4G2zJTD
   7vVZkofr3DgEWSu5MRMlAn0MnpL5sjjWpX7AIEKVrbGm2DPAyT8vhAYRm
   JJZfbRoxfERICeCWIUWhppZghwEao9dKSMXUi8ub/WJWdO7cgTvjwUVcP
   +S6KuZ1htemBG5NV/6F9ND5Tf8c1TEepC0Spw+W8FDx4qIS+cQu9tJfxP
   UC2ddEDHNlv1M1TSTTdcyC6WrA6/ybTup8v+s37AQ402ARaJ2VR1LsjBC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="386609235"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="386609235"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 21:45:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="886176112"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="886176112"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 06 Nov 2023 21:45:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 6642D3CC; Tue,  7 Nov 2023 07:45:26 +0200 (EET)
Date: Tue, 7 Nov 2023 07:45:26 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mark Gross <markgross@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" <dri-devel@lists.freedesktop.org>,
	"open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" <nouveau@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>,
	"open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] PCI: Exclude PCIe ports used for tunneling in
 pcie_bandwidth_available()
Message-ID: <20231107054526.GT17433@black.fi.intel.com>
References: <20231103190758.82911-1-mario.limonciello@amd.com>
 <20231103190758.82911-9-mario.limonciello@amd.com>
 <20231106181022.GA18564@wunner.de>
 <712ebb25-3fc0-49b5-96a1-a13c3c4c4921@amd.com>
 <20231106185652.GA3360@wunner.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231106185652.GA3360@wunner.de>

Hi,

On Mon, Nov 06, 2023 at 07:56:52PM +0100, Lukas Wunner wrote:
> On Mon, Nov 06, 2023 at 12:44:25PM -0600, Mario Limonciello wrote:
> > Tangentially related; the link speed is currently symmetric but there are
> > two sysfs files.  Mika left a comment in drivers/thunderbolt/switch.c it may
> > be asymmetric in the future. So we may need to keep that in mind on any
> > design that builds on top of them.
> 
> Aren't asymmetric Thunderbolt speeds just a DisplayPort thing?

No, they affect the whole fabric. We have the initial code for
asymmetric switching in v6.7-rc1.

> > As 'thunderbolt' can be a module or built in, we need to bring code into PCI
> > core so that it works in early boot before it loads.
> 
> tb_switch_get_generation() is small enough that it could be moved to the
> PCI core.  I doubt that we need to make thunderbolt built-in only
> or move a large amount of code to the PCI core.

If at all possible I would like to avoid this and littering PCI side
with non-PCI stuff. There could be other similar "mediums" in the future
where you can transfer packets of "native" protocols such as PCIe so
instead of making it Thunderbolt/USB4 specific it should be generic
enough to support future extensions.

In case of Thunderbolt/USB4 there is no real way to figure out how much
bandwidth each PCIe tunnel gets (it is kind of bulk traffic that gets
what is left from isochronous protocols) so I would not even try that
and instead use the real PCIe links in pcie_bandwidth_available() and
skip all the "virtual" ones.

