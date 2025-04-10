Return-Path: <linux-acpi+bounces-12940-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72916A83E5A
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 11:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E861B632A2
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 09:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FA820C47B;
	Thu, 10 Apr 2025 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvqQU49W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6291EB1B7;
	Thu, 10 Apr 2025 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276427; cv=none; b=G1g6bKQrhe8Dyvd8zQ7y1pLvDpQAl2+UUf0FicuKyV5ipqDb7BVVnsQEdiIWJ951usglWAZEVmPEvSYhTXfsS9FimTMLoAN+JcAgCzSsJr4+mi7P2xVRg5gr1TJswS4EejeBs2YfHJB3uyuZ06biwTcuoP2kb1uaMymBs2j/Rq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276427; c=relaxed/simple;
	bh=681O8sdOuewrF/ZEpCXK9dKabn6LqO1Rw/i41eLk9SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBUKUPgtmWXoBIZ9K9VtfSxGTlZwEUowAiRQRY9TOGuuZElGpO7HcozcX8jkKKgaUS46ONKZDndJyOPBtdfrs+3Gi/aVByWaXNHSYmmPKEK5HXnIMeLfPnxvmy+5aiuIcPi5icREx1QPtKbRQ8Jn0RwCJDBaHh5OxXeaypZGmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvqQU49W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB69C4CEDD;
	Thu, 10 Apr 2025 09:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744276426;
	bh=681O8sdOuewrF/ZEpCXK9dKabn6LqO1Rw/i41eLk9SE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvqQU49WtB9Ol4BwllJdPabwF/KLI/eBMXqot/RA/zx1BHGfUzg+b1OgYPUBe6uF7
	 IvF0q4J3zQ6CNv9VbGoC+GpdRRz1MKZrsmXPVD+QmFxLLEhZt1TyCqBsGycQQHmiVV
	 M50NILJLN7G2AIlvmqcdWEKTGIHZSBkJve7DxtrIc72/xnmJf6l572iZ3xJgxOQGC+
	 sClhQSxHJ3ONh5dn9AjLZYwnseAixz++J7CqrZAY1N22H7XUInbYqZ6SJqMCctmMMP
	 amlLLExIZC8qgm1doL06cmPryEhiFTj4bers4sB7cU8BFNcyRvRQtiUX+zmHb8haZ/
	 vr+1jUhpoFZqA==
Date: Thu, 10 Apr 2025 10:13:40 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Jakob Riepler <jakob+lkml@paranoidlabs.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-usb@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 0/4] leds: Introduce and use
 fwnode_get_child_node_count()
Message-ID: <20250410091340.GQ372032@google.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
 <20250321110315.GH1750245@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321110315.GH1750245@google.com>

On Fri, 21 Mar 2025, Lee Jones wrote:

> On Mon, 10 Mar 2025, Andy Shevchenko wrote:
> 
> > This series was inspired during review of "Support ROHM BD79124 ADC" [1].
> > The three conversion patches are the examples of the new API in use.
> > 
> > Since the first two examples of LEDS, in case of posotove response it may
> > be routed via that tree and immutable branch/tag shared with others, e.g.,
> > IIO which Matti's series is targeting and might be dependent on. The USB
> > patch can be applied later separately, up to the respective maintainers.
> > 
> > Link: https://lore.kernel.org/r/cover.1741610847.git.mazziesaccount@gmail.com> [1]
> > 
> > Andy Shevchenko (4):
> >   device property: Split fwnode_get_child_node_count()
> >   leds: pwm-multicolor: Use fwnode_get_child_node_count()
> >   leds: ncp5623: Use fwnode_get_child_node_count()
> >   usb: typec: tcpm: Use fwnode_get_child_node_count()
> > 
> >  drivers/base/property.c                | 12 ++++++------
> >  drivers/leds/rgb/leds-ncp5623.c        |  5 ++---
> >  drivers/leds/rgb/leds-pwm-multicolor.c |  7 +++----
> >  drivers/usb/typec/tcpm/tcpm.c          |  6 ++----
> >  include/linux/property.h               |  7 ++++++-
> >  5 files changed, 19 insertions(+), 18 deletions(-)
> 
> Note to self: This has everything we need.  Merge it for v6.16.

Submitted for build testing.  Will provide a PR once finished.

Note to self: ib-leds-base-usb-6.16

-- 
Lee Jones [李琼斯]

