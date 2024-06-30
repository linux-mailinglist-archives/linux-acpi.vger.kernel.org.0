Return-Path: <linux-acpi+bounces-6679-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEBC91D175
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 13:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E408281EFC
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0212C13B7AF;
	Sun, 30 Jun 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyigFXNP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF6374D1;
	Sun, 30 Jun 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719747727; cv=none; b=Bffh1gDjABDAnGzvXSPdhrAvFcAXrykSqJResguuSM6YFMxIA75OtiD8CpamR2OtEEMr+9EF3qrJbt74hqxsAaHwIhHshshKGeDrrjBeCXMB9t0vtVCmdZkBZmWFIe3psdJfWalgk+HgUnZgzPGGew8pJjJNK4sA/KVgpV6uits=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719747727; c=relaxed/simple;
	bh=Wr9YU7QH4kFYCtMsLVkZVjG1ysibb7bqSYIXB/NkZ9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUQqaUUHw1OHWUl+wGugMWFTJSxrflbZSo6PRPtAWIrazqeHnt7QvWWVVn3rjCfOFlb/IEXSZnYAhfN2MIVnsV/ZOPgtxDTzOh8on2+s8rz9kcoDI0RnvZW9dClwgcT6ECST5mWexAjh4RiNjH/OZOE2rzsH4+HvHiHn20IYoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyigFXNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912B9C2BD10;
	Sun, 30 Jun 2024 11:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719747727;
	bh=Wr9YU7QH4kFYCtMsLVkZVjG1ysibb7bqSYIXB/NkZ9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IyigFXNPSsQwaus0q13F56fpvlAIyYBJqRffqCVbc7CnVItuR1wQd4GkxdrxTrWdl
	 cCBN+A1vNszzZc213/Y2wHNsxqTCWeIa/8B1QwYi+5apUbxpIKnrxVP6Bvx6z9N9de
	 nEiLpcVNua55QazzwO6hROs7gAzndsXxnk7JRBJy2kagOB/aALIoA05Dswl7hVJc7G
	 bFkFXX7PIWEIp//r3kOi2HDNUj3eS7SM7+iaN6OWBCCYj2GQtN/8LhnBI7ycfKUJI2
	 vr7aU5gKO0wHkph72QNLeqolZz966xpbePy8VfL3i2yjSgn03vDy/vTk1WajH9ZpMp
	 tSm4Gv1N4vMjQ==
Date: Sun, 30 Jun 2024 12:41:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Guenter
 Roeck <linux@roeck-us.net>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: (ltc2992) Use
 fwnode_for_each_available_child_node_scoped()
Message-ID: <20240630124157.07bf97d9@jic23-huawei>
In-Reply-To: <3a16dc06-81df-4493-bac6-216e9c6ea16e@gmail.com>
References: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
	<20240523-fwnode_for_each_available_child_node_scoped-v2-3-701f3a03f2fb@gmail.com>
	<20240526144851.493dd3f2@jic23-huawei>
	<3a16dc06-81df-4493-bac6-216e9c6ea16e@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 23:45:42 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 26/05/2024 15:48, Jonathan Cameron wrote:
> > On Thu, 23 May 2024 17:47:16 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >   
> >> The scoped version of the fwnode_for_each_available_child_node() macro
> >> automates object recfount decrement, avoiding possible memory leaks
> >> in new error paths inside the loop like it happened when
> >> commit '10b029020487 ("hwmon: (ltc2992) Avoid division by zero")'
> >> was added.
> >>
> >> The new macro removes the need to manually call fwnode_handle_put() in
> >> the existing error paths and in any future addition. It also removes the
> >> need for the current child node declaration as well, as it is internally
> >> declared.
> >>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> > 
> > This looks like another instances of the lack of clarify about 
> > what device_for_each_child_node[_scoped]() guarantees about node availability.
> > On DT it guarantees the node is available as ultimately calls
> > of_get_next_available_child()
> > 
> > On ACPI it doesn't (I think).
> > For swnode, there isn't an obvious concept of available.
> > 
> > It would be much better if we reached some agreement on this and
> > hence could avoid using the fwnode variants just to get the _available_ form
> > as done here.  Or just add the device_for_each_available_child_node[_scoped]()
> > and call that in almost all cases.
> > 
> > In generic code, do we ever want to walk unavailable child nodes?
> > 
> > Jonathan
> >   
> 
> Hi,
> 
> if I did not miss anything, the discussion about the convenience of the
> fwnode_for_each_available_child_node_scoped() macro stalled without a
> clear outcome.
> 
> At this point there are multiple users of both
> fwnode_for_each_child_node() and fwnode_for_each_available_child_node(),
> and I wonder how many of them use the non-scoped version for a different
> reason than not having/knowing the _available_ variant back then.
> 
> Maybe touching that now could turn into regressions if someone is just
> ignoring that some nodes are actually disabled. Their bad, but still
> painful. But maybe there is a better reason to have both macros I don't
> know.
> 
> As I am still interested in this matter for new users that only want to
> iterate over available nodes, and I want to have a scoped solution, I
> would like to revive this discussion.

Straw man for people to shoot at:

I think where possible rely on device_for_each_child_node[_scoped]()
actually meaning the available nodes.  In cases where it applies that
is normally cleaner anyway.

If you find cases where there is no relevant device (I'm sure there are some)
just provide fwnode_for_each_available_child_node() and not the non-available
one.  If that means switching some drivers to use the available form as
part of cleanups, at that point we consider if there is a special reason
it actually wants the non available modes.

Ideally we also add documentation to say the device_for_each_child_node()
will (at least mostly) not consider non available nodes.  It might
be always, I'm still personally not sure on that!

Jonathan

> 
> Thanks and best regards,
> Javier Carrasco


