Return-Path: <linux-acpi+bounces-1450-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ABD7E9EE2
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 15:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DD9280D7D
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA8D210F6
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wtwGKzvb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA41E51D;
	Mon, 13 Nov 2023 14:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9C5C433C9;
	Mon, 13 Nov 2023 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699885981;
	bh=xKfu53wQ8/LQR0nMpoegFALzSedEPyi+HMxBb8IOTeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wtwGKzvb9Mrg1vBVKcwaN+rsoO70M0O+zIv5MygBaloyGkO0yX3cRF6fJx8zo7Hid
	 hHBlW5iMIEH9bAlBCoGufQFyzsnIQzIz1NmkzK7Y+B1llWJg8uLSMo5OOHZRonFfsL
	 x92TgoGC+FVUBkdo3B1XjC8wDAR7rXJbws9qiksY=
Date: Mon, 13 Nov 2023 09:32:57 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	"Owen T . Heisler" <writer@owenh.net>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI: PM: Add acpi_device_fix_up_power_children()
 function
Message-ID: <2023111349-outward-rectify-cb4e@gregkh>
References: <20231112203627.34059-1-hdegoede@redhat.com>
 <20231112203627.34059-2-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112203627.34059-2-hdegoede@redhat.com>

On Sun, Nov 12, 2023 at 09:36:26PM +0100, Hans de Goede wrote:
> In some cases it is necessary to fix-up the power-state of an ACPI
> device's children without touching the ACPI device itself add
> a new acpi_device_fix_up_power_children() function for this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/device_pm.c | 13 +++++++++++++
>  include/acpi/acpi_bus.h  |  1 +
>  2 files changed, 14 insertions(+)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

