Return-Path: <linux-acpi+bounces-12084-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED5DA5C099
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 13:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0D6189A583
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE38125A2C9;
	Tue, 11 Mar 2025 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eh2YWVF/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E42566DA;
	Tue, 11 Mar 2025 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694758; cv=none; b=c+OyHVJ0e1RqHE4GUcdftwLa2oYHzmfMeOeQpJbe3nFaeDGU+Edqbs2wUmWZgwoGQbPq3geylhab8ytcaE2m7w4if7eYAWyRd4jKxN7OIjwqHR7BE08leRrtUoLuj2F92EJcvqZ3+EGxbdpSepGV4qANNkMLPeDTKp33q2hvWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694758; c=relaxed/simple;
	bh=0cWb21nqnB2z8EJJlmAU3Y6DZrRZsqCDg8wtqbR+R74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpzgfX/HMLbEsEEM88vtxzcEi5F2/mJrX2/d3gdGQ5b0RQ9cpWe3fWN0u2J92rjN/lRQOmiCYjj6XTPY9fWafTb9T8+EnkrvXwYygjelR1CnkrBKZM3fKc9vSnGKR0vN+LLgVYbgV1CXnP5XgrKhh4pihykkGGFQGKRjHo1WGfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eh2YWVF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC1AC4CEE9;
	Tue, 11 Mar 2025 12:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741694758;
	bh=0cWb21nqnB2z8EJJlmAU3Y6DZrRZsqCDg8wtqbR+R74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eh2YWVF/LRUQN9pp79HQAyBs/+OdziLshIcq5UGoEN4qDij1LMwlLrR1dSaz4Pywv
	 nlfJZ6GjiUge8nTzmukbaUS097jz3/5Uy8OajQ+YGQ517Q1M2Vk62TrEqm2pCDznux
	 9sWIc3Va5HwLqeQCWqzOz6smPCdtP5c2cPexbdl8=
Date: Tue, 11 Mar 2025 13:05:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jakob Riepler <jakob+lkml@paranoidlabs.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 1/4] device property: Split fwnode_get_child_node_count()
Message-ID: <2025031151-camcorder-sandstone-bd1c@gregkh>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
 <20250310150835.3139322-2-andriy.shevchenko@linux.intel.com>
 <bf26ba74-ff44-4642-864e-2c54d49ead74@web.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf26ba74-ff44-4642-864e-2c54d49ead74@web.de>

On Tue, Mar 11, 2025 at 01:00:16PM +0100, Markus Elfring wrote:
> > The new helper is introduced to allow counting the child firmware nodes
> > of their parent without requiring a device to be passed. …
> 
> See also:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14-rc6#n94
> 
> Regards,
> Markus
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

