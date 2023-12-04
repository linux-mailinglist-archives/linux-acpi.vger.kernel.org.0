Return-Path: <linux-acpi+bounces-2102-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 109B1802D26
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 09:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8601F20F1F
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 08:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B61F17998
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jROt4+AA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BfloaVnh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95309AC;
	Sun,  3 Dec 2023 23:58:26 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701676704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=olLQmfouF3da3Ez0MZE8XTk1beuCISuKI3rPjmx3/hc=;
	b=jROt4+AA2gHCjQQejTIJ4vx61px4E4T6n7je/BoGancpAFJzJip5U7lrImJxKWIqbbMRtq
	6m5nmG8i3VblkEIRlbtxchdeGxnLTRgHOfbPcp6e1doolQTYPM3nQxS48f+2396sY04H3K
	AQa/bymq0fZit98BLuQWFsktYiAx9A2kt/HaXVoWxeU0DbC+m7maUCeeHta7XD7bkH33+G
	Y4l9w4vk77GVv6YHcaiXBxkFEPjXcRomvw0tdn/apFOqCVUrMU/FjOHXztPcy2fZIeQZN+
	lUF9etwZ2a5wpRp3KdgjkdImnU2gAeMF5oRpJDHp9RxgARd5oA3G8KaBaQunow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701676704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=olLQmfouF3da3Ez0MZE8XTk1beuCISuKI3rPjmx3/hc=;
	b=BfloaVnhH1keEIYiuj2GPUgURfGHFRALvHxjv42XRmGBcfK9HphTyelqVddlgAlKPMoJTx
	zZ5jWZZYCHljWXBw==
To: Jiqian Chen <Jiqian.Chen@amd.com>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Roger Pau =?utf-8?Q?Monn=C3=A9?=
 <roger.pau@citrix.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
Cc: Stefano Stabellini <stefano.stabellini@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>, Christian Koenig <Christian.Koenig@amd.com>,
 Stewart Hildebrand <Stewart.Hildebrand@amd.com>, Xenia Ragiadakou
 <xenia.ragiadakou@amd.com>, Honglei Huang <Honglei1.Huang@amd.com>, Julia
 Zhang <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
 <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 1/3] xen/pci: Add xen_reset_device_state
 function
In-Reply-To: <20231124103123.3263471-2-Jiqian.Chen@amd.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-2-Jiqian.Chen@amd.com>
Date: Mon, 04 Dec 2023 08:58:22 +0100
Message-ID: <87edg2xuu9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 24 2023 at 18:31, Jiqian Chen wrote:
> When device on dom0 side has been reset, the vpci on Xen side
> won't get notification, so that the cached state in vpci is
> all out of date with the real device state.
> To solve that problem, this patch add a function to clear all

Please get rid of 'this patch' all over the series.

# grep -r 'This patch' Documentation/process/

> vpci device state when device is reset on dom0 side.
>
> And call that function in pcistub_init_device. Because when
> we use "pci-assignable-add" to assign a passthrough device in
> Xen, it will reset passthrough device and the vpci state will
> out of date, and then device will fail to restore bar state.
>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

This Signed-off-by chain is incorrect.

Documentation/process/submitting-patches.rst has a full chapter about
S-O-B and the correct usage.

Thanks,

        tglx

