Return-Path: <linux-acpi+bounces-1280-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8673F7E2C16
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 19:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3C2B209F8
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAD22D035
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRFXV4je"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA6928E27;
	Mon,  6 Nov 2023 16:48:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043D6D49;
	Mon,  6 Nov 2023 08:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699289282; x=1730825282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=A4xozrlM98o/6is3EgoMPreQJpmablfWX3/r4GaT1kw=;
  b=kRFXV4jexd3FZj8ePD1khtpMhGZ9LPkIEnOJz975AOcHLi4Al35E5w0o
   TcjHaZVaWQHbySKI0rLnxh9mMiATM44vZimXu2RHspU7ayFOd3FetVvQi
   bjPkqTFb2uz1zrhXmBd0TJLU8C7sYvdnDucYgUNWLLSfKWllAsr3Ti1rE
   w9w1wO1gO0VogUk2q6bS++gAltfTifay4Z2MMDXEtDqPrwjbeA9qM7xlr
   Z2P0IDQyktLRaZ+iP4Y86eJVowCDiIsp2BJOVQbWu+bSZWtwdfxilA5RT
   ig5AkdJnnlF4ClxQ4TipN/EmSJkjgjg8xh39djoPOlTApoo0uqsjpkBb7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="453623285"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="453623285"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 08:48:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="879501854"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="879501854"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2023 08:47:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 2F0E31A5; Mon,  6 Nov 2023 18:47:51 +0200 (EET)
Date: Mon, 6 Nov 2023 18:47:51 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hans de Goede <hdegoede@redhat.com>, Lukas Wunner <lukas@wunner.de>,
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
Subject: Re: [PATCH v2 1/9] drm/nouveau: Switch from
 pci_is_thunderbolt_attached() to dev_is_removable()
Message-ID: <20231106164751.GS17433@black.fi.intel.com>
References: <20231103190758.82911-1-mario.limonciello@amd.com>
 <20231103190758.82911-2-mario.limonciello@amd.com>
 <55563d57-60c3-1789-1e7c-5e618fbd6253@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55563d57-60c3-1789-1e7c-5e618fbd6253@linux.intel.com>

On Mon, Nov 06, 2023 at 02:25:24PM +0200, Ilpo Järvinen wrote:
> On Fri, 3 Nov 2023, Mario Limonciello wrote:
> 
> > pci_is_thunderbolt_attached() only works for Intel TBT devices. Switch to
> > using dev_is_removable() to be able to detect USB4 devices as well.
> 
> Please extend this with more details. I had to lookup the TBT change to 
> be able to make any guess why you're doing this (and it's still a guess 
> at best).

Also please write it as Thunderbolt not TBT so that it is clear what we
are talking about. Ditto to all patches.

