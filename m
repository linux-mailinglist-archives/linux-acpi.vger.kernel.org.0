Return-Path: <linux-acpi+bounces-2132-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2618041C0
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 23:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079A71F212FC
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 22:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E9C3BB21
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu51sE3v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512B0364A9
	for <linux-acpi@vger.kernel.org>; Mon,  4 Dec 2023 21:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87769C433C8;
	Mon,  4 Dec 2023 21:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701725491;
	bh=jZE8WhQFFk5OHFb1w+ll7JB5KoaZRmBWaeDlAuQbU04=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Yu51sE3vS37G/VqsMHOxqKss2H9lLc4fVXXc5Sswc7TWVZjCgeKTO9ir8aGro4AeS
	 K+Mdx7AbXDvIaTiNM7EJLY6Kz13WkF/5sEcmT2/1rFAokfwoKLWJKZstos9WHut7bE
	 JUZ8TcEAGE9K+XFxplS2TnChfCNABEy0P3SsvlGMr6qu5da3hWCuc9PiDaees+tkhp
	 7dV2Ee3diB7OkvxVY3U043mJCUsBP7aejaGnpmqJ7SAF4M0ZuZgbdwi/xNEgdLu73w
	 cgXGTviVpjT7CtDCU3eeWQ1JePKAjfPB5FI2JU+ySDBuAobRBAcQ46WkQzOwDXXi8q
	 g5naLxareX1NQ==
Date: Mon, 4 Dec 2023 13:31:27 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
    "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
    "Stabellini, Stefano" <stefano.stabellini@amd.com>, 
    "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
    "Koenig, Christian" <Christian.Koenig@amd.com>, 
    "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>, 
    "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>, 
    "Huang, Honglei1" <Honglei1.Huang@amd.com>, 
    "Zhang, Julia" <Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 1/3] xen/pci: Add xen_reset_device_state
 function
In-Reply-To: <BL1PR12MB5849F2E24E00BF7B20A0B4A6E786A@BL1PR12MB5849.namprd12.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2312041331210.110490@ubuntu-linux-20-04-desktop>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com> <20231124103123.3263471-2-Jiqian.Chen@amd.com> <87edg2xuu9.ffs@tglx> <BL1PR12MB5849F2E24E00BF7B20A0B4A6E786A@BL1PR12MB5849.namprd12.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Dec 2023, Chen, Jiqian wrote:
> >> vpci device state when device is reset on dom0 side.
> >>
> >> And call that function in pcistub_init_device. Because when
> >> we use "pci-assignable-add" to assign a passthrough device in
> >> Xen, it will reset passthrough device and the vpci state will
> >> out of date, and then device will fail to restore bar state.
> >>
> >> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >> Signed-off-by: Huang Rui <ray.huang@amd.com>
> > 
> > This Signed-off-by chain is incorrect.
> > 
> > Documentation/process/submitting-patches.rst has a full chapter about
> > S-O-B and the correct usage.
> I am the author of this series of patches, and Huang Rui transported the v1 to upstream. And now I transport v2. I am not aware that the SOB chain is incorrect.
> Do you have any suggestions?

I think he means that your Signed-off-by should be the second one of the
two as you are the one submitting the patch to the LKML

