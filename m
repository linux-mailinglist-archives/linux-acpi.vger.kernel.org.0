Return-Path: <linux-acpi+bounces-1286-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6247E2C1C
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 19:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B28C6B2101E
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 18:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E38E2906
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9986D156E1;
	Mon,  6 Nov 2023 18:18:27 +0000 (UTC)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516ED94;
	Mon,  6 Nov 2023 10:18:26 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 82750104310B1;
	Mon,  6 Nov 2023 19:18:18 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 590FA119432; Mon,  6 Nov 2023 19:18:18 +0100 (CET)
Date: Mon, 6 Nov 2023 19:18:18 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mark Gross <markgross@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
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
Subject: Re: [PATCH v2 6/9] PCI: Rename is_thunderbolt to is_tunneled
Message-ID: <20231106181818.GB18564@wunner.de>
References: <20231103190758.82911-1-mario.limonciello@amd.com>
 <20231103190758.82911-7-mario.limonciello@amd.com>
 <20231105173946.GA31955@wunner.de>
 <9b1a5e36-337b-4750-9dad-b54e28cde03a@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b1a5e36-337b-4750-9dad-b54e28cde03a@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Nov 06, 2023 at 10:59:13AM -0600, Mario Limonciello wrote:
> On 11/5/2023 11:39, Lukas Wunner wrote:
> > On Fri, Nov 03, 2023 at 02:07:55PM -0500, Mario Limonciello wrote:
> > > The `is_thunderbolt` bit has been used to indicate that a PCIe device
> > > contained the Intel VSEC which is used by various parts of the kernel
> > > to change behavior. To later allow usage with USB4 controllers as well,
> > > rename this to `is_tunneled`.
> > 
> > This doesn't seem to make sense.  is_thunderbolt indicates that a device
> > is part of a Thunderbolt controller.  See the code comment:
> > 
> > > -	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> > 
> > A Thunderbolt controller is not necessarily tunneled.  The PCIe switch,
> > NHI and XHCI of the Thunderbolt host controller are not tunneled at all.
> 
> I could really use some clarification which PCIe devices actually contain
> the Intel VSEC.
> 
> Is it in all 3 of those PCIe devices and not just the switch?

Yes, I've just double-checked Light Ridge, Cactus Ridge, Alpine Ridge.

Thanks,

Lukas

