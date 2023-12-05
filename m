Return-Path: <linux-acpi+bounces-2158-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AC4805D6C
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 19:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A2DAB20F8D
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1312675B8
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gBs2xU/8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ycX4aADB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5561B6;
	Tue,  5 Dec 2023 09:02:57 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701795775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tKj/G59HmDBT/RcKJNhjfacQG0y6lbGXbN5/YyhoGFQ=;
	b=gBs2xU/8H+BYBNLyCeYcxWGK2DZm4IabnOmpFdODKMdgkBPuxusYpkJuD8d5nh/R3KLnbv
	x5HOmiKZACda/7MqInA95GLLoSjFc6ZbPAHItZhCLbXpNfG3vEP8PEeAv0Dyhl0ZN/i5p4
	D36nAXuQqr6TgdWMOQNCHWsCvy69bXXMfTa4MjCEVvmGElsCn7OmsxHPtkilqKWMZmCn8s
	WgGntur+yfvv0BQdbGoMsjQqWyqyXeiiJ0BlpPUYpuPujZWY1I4IA7ixlnPTzRjMbnL3E9
	ql34epQy/+k5Z+geYL3XccPv8qe8KR/gW2//csS7+XQIbeTKK4sr4lXiM6fONw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701795775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tKj/G59HmDBT/RcKJNhjfacQG0y6lbGXbN5/YyhoGFQ=;
	b=ycX4aADBX6fBhOk+amfiCNFdHlR2j22kpskGtkhiZY8tFpmyEFOH2YLz4yXuMW8J2h7zyH
	rHbpCWNVp2OWgABA==
To: Stefano Stabellini <sstabellini@kernel.org>, "Chen, Jiqian"
 <Jiqian.Chen@amd.com>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Roger
 Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
 "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "Stabellini, Stefano"
 <stefano.stabellini@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
 <Stewart.Hildebrand@amd.com>, "Ragiadakou, Xenia"
 <Xenia.Ragiadakou@amd.com>, "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 1/3] xen/pci: Add xen_reset_device_state
 function
In-Reply-To: <alpine.DEB.2.22.394.2312041331210.110490@ubuntu-linux-20-04-desktop>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-2-Jiqian.Chen@amd.com> <87edg2xuu9.ffs@tglx>
 <BL1PR12MB5849F2E24E00BF7B20A0B4A6E786A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <alpine.DEB.2.22.394.2312041331210.110490@ubuntu-linux-20-04-desktop>
Date: Tue, 05 Dec 2023 18:02:54 +0100
Message-ID: <87fs0gwpj5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Dec 04 2023 at 13:31, Stefano Stabellini wrote:
> On Mon, 3 Dec 2023, Chen, Jiqian wrote:
>> >> vpci device state when device is reset on dom0 side.
>> >>
>> >> And call that function in pcistub_init_device. Because when
>> >> we use "pci-assignable-add" to assign a passthrough device in
>> >> Xen, it will reset passthrough device and the vpci state will
>> >> out of date, and then device will fail to restore bar state.
>> >>
>> >> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
>> >> Signed-off-by: Huang Rui <ray.huang@amd.com>
>> > 
>> > This Signed-off-by chain is incorrect.
>> > 
>> > Documentation/process/submitting-patches.rst has a full chapter about
>> > S-O-B and the correct usage.
>> I am the author of this series of patches, and Huang Rui transported the v1 to upstream. And now I transport v2. I am not aware that the SOB chain is incorrect.
>> Do you have any suggestions?
>
> I think he means that your Signed-off-by should be the second one of the
> two as you are the one submitting the patch to the LKML

No.

   Mailfrom: Jiqian Chen <Jiqian.Chen@amd.com>
   <body>

   Changelog-text

   Signed-off-by: Huang Rui <ray.huang@amd.com>
   Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

is equally wrong because that would end up with Chen as author and Huang
as first S-O-B which is required to be the author's S-O-B

To make the above correct this would require:

   Mailfrom: Jiqian Chen <Jiqian.Chen@amd.com>
   <body>

   From: Huang Rui <ray.huang@amd.com>

   Changelog-text

   Signed-off-by: Huang Rui <ray.huang@amd.com>
   Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

   which tells that Huang is the author and Chen is the 'transporter',
   which unfortunately does not reflect reality.

Or:

   Mailfrom: Jiqian Chen <Jiqian.Chen@amd.com>
   <body>

   Changelog-text

   Co-developed-by: Huang Rui <ray.huang@amd.com>
   Signed-off-by: Huang Rui <ray.huang@amd.com>
   Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

   which tells that Checn is the author and Huang co-developed the
   patch, which might be true or not.


V1 which was sent by Huang has the ordering is correct:

   Mailfrom: Huang Rui <ray.huang@amd.com>
   <body>

   From: Jiqian Chen <Jiqian.Chen@amd.com>

   Changelog-text

   Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
   Signed-off-by: Huang Rui <ray.huang@amd.com>

   i.e. Chen authored and Huang transported

Now this V2 has not really much to do with V1 and is a new
implementation to solve the problem, which was authored by Chen, so
Huang is not involved at all if I understand correctly.

So what does his S-O-B mean here? Nothing...

It's very well documented how the whole S-O-B business works and it's
not really rocket science to get it straight.

It has a meaning and is not just for decoration purposes.

Thanks,

        tglx

