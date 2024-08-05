Return-Path: <linux-acpi+bounces-7290-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF3D947CDD
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 16:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC26E1C21CCD
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D851A139CFA;
	Mon,  5 Aug 2024 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzlXgWfD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F15039FE5;
	Mon,  5 Aug 2024 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868336; cv=none; b=CjkfFdxA5s6RKY/kKjgZ16MPW5TUHRpgHXRoyhChLxL8B9Lt225HC5Q0KqpypUEgwpNc9jhOl+uBDUVmNc+/VzQrwv1sP8ziI77ZsmDjiKuYMxwazMyGgfCL/zhIUmr+cRy3gutgZdHX+n++AwWDA2NKbXayf8V316R4fl94p90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868336; c=relaxed/simple;
	bh=A5ue+yCilPqmpcUkXKUIlSXfp1UDbKq7c6OJAyt/IxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac87dc36jDT1eVbllNlP+XM2UxHueiAZ5KwY+7lH/28ks2Oo2PKeE1gurUheONVMCae6IYv1kvB16sXDmtchl3kKdbXSZ4a2HvXpQ5p32hwet1ftVcWLivIpnxQAfbIc/aD0PVmMixPeOkCiFkAf0Dqkx/7sh5dHe6GCrE+Sg6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzlXgWfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66DCC4AF0B;
	Mon,  5 Aug 2024 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722868336;
	bh=A5ue+yCilPqmpcUkXKUIlSXfp1UDbKq7c6OJAyt/IxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AzlXgWfDA40/focwBNArbzP+1EcISYM/b5inPWkExxg1BtCqNEahAw1N/4d6oFelR
	 k6Nr1GNjWBto+DeDtDx9ZFtKR1Cy2LEU5bZ2lWUk323HIVukNv4LylC2wImndA5Izc
	 Yq1QHmRQG71X7N4DiDq6ME7H/80cQdkPmWiGlueR6pNx/UJ69QMlv25wo0pVNyMkYb
	 hZBSdQk3K6GkKYOQhUMalWaDjRkq9uU0GnfkOWENzNGlS9OOFhA6cmbdLEq+kxt3or
	 gEzxH0I54PwrVyzBsMrf6l1hp2WN3H7rBnrZa9vKTBcA7aSFGdERgkV1cX7V9mwnlO
	 BFCXfF2wErArw==
Date: Mon, 5 Aug 2024 15:32:07 +0100
From: Lee Jones <lee@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andreas Kemnade <andreas@kemnade.info>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-leds@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: (subset) [PATCH v2 0/6] use device_for_each_child_node() to
 access device child nodes
Message-ID: <20240805143207.GE1019230@google.com>
References: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
 <172192488125.1053789.17350723750885690064.b4-ty@kernel.org>
 <094c7d7f-749f-4d8f-9254-f661090e4350@gmail.com>
 <20240801123901.GC6756@google.com>
 <9083938c-c2df-4429-904d-700e5021331c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9083938c-c2df-4429-904d-700e5021331c@gmail.com>

On Fri, 02 Aug 2024, Javier Carrasco wrote:

> On 01/08/2024 14:39, Lee Jones wrote:
> > On Mon, 29 Jul 2024, Javier Carrasco wrote:
> > 
> >> On 25/07/2024 18:28, Lee Jones wrote:
> >>> On Sun, 21 Jul 2024 17:19:00 +0200, Javier Carrasco wrote:
> >>>> This series aims to clarify the use cases of:
> >>>>
> >>>> - device_for_each_child_node[_scoped]()
> >>>> - fwnode_for_each_available_child_node[_scoped]()
> >>>>
> >>>> to access firmware nodes.
> >>>>
> >>>> [...]
> >>>
> >>> Applied, thanks!
> >>>
> >>> [3/6] leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
> >>>       commit: 75d2a77327c4917bb66163eea0374bb749428e9c
> >>> [4/6] leds: is31fl319x: use device_for_each_child_node_scoped() to access child nodes
> >>>       commit: 0f5a3feb60aba5d74f0b655cdff9c35aca03e81b
> >>> [5/6] leds: pca995x: use device_for_each_child_node() to access device child nodes
> >>>       (no commit info)
> >>>
> >>> --
> >>> Lee Jones [李琼斯]
> >>>
> >>
> >> Hi Lee,
> >>
> >> could you please tell me where you applied them? I rebased onto
> >> linux-next to prepare for v3, and these patches are still added on top
> >> of it. Can I find them in some leds/ branch? Thank you.
> > 
> > Sorry, I was side-tracked before pushing.
> > 
> > Pushed now.  They should be in -next tomorrow.
> > 
> 
> Thanks, I see
> 
> [3/6] leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
> 
> [4/6] leds: is31fl319x: use device_for_each_child_node_scoped() to
> access child nodes
> 
> applied to -next, but
> 
> [5/6] leds: pca995x: use device_for_each_child_node() to access device
> child nodes
> 
> has not been applied yet.

Yep, looks like b4 didn't like that one:

[3/6] leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
      commit: 75d2a77327c4917bb66163eea0374bb749428e9c
[4/6] leds: is31fl319x: use device_for_each_child_node_scoped() to access child nodes
      commit: 0f5a3feb60aba5d74f0b655cdff9c35aca03e81b
[5/6] leds: pca995x: use device_for_each_child_node() to access device child nodes
      (no commit info)

I'll try again and see if it can be pulled in.

If not you'll have to resubmit it.

-- 
Lee Jones [李琼斯]

