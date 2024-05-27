Return-Path: <linux-acpi+bounces-6008-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF158D05A9
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 17:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8862884FC
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C930216EBE5;
	Mon, 27 May 2024 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tutg1n3c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902A115F30F;
	Mon, 27 May 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821851; cv=none; b=BffvnzxLRjsmMWG1lhzi+bYLo1WZZeEBQZGKv3uANukEbxG2cJPinzCxqnfSkHZ/ShTOl0bRWlf5BTXeQEwV1IM0nHoVFdmGSF5G6+CHTPgHluYzRzmgSJKK68tO4+s1E1dZ26147qrJVY5ORVF7AxQoUnGh1/ac9qCI/NyUBq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821851; c=relaxed/simple;
	bh=TPj1Ua3MXLPcEqd+42ujWJSzWinRENwbYJnUHrLZ/64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpW6gEDKe9UM6mUNMmod1S4ykIURFtlPXx49JZ5j3XeofRWbF2t7nLNzby3rhzUZoRz8sGY19V0QRxM45VIG05MtJr5G6XFahZqAQgjLkjj3x7Fdya3dworZ4L6vPdL0AYhMLScql5asxBeGF/gm31s6D7p16NevkgoJhoXNx1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tutg1n3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2C1C2BBFC;
	Mon, 27 May 2024 14:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716821850;
	bh=TPj1Ua3MXLPcEqd+42ujWJSzWinRENwbYJnUHrLZ/64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tutg1n3cW99Gf9udjFbpM6/iRV4wVDFisFeoqKaOCXPbaZ13Pi3oxi5ZeWdmPGHSf
	 MVrKQiOqhVmxCg7nd4nIjojJAiCSKj0tKxqILXaFAPH7ZxNly3lDsZA/gFkzgxesAI
	 1Vhuq/Zoua4NmUmCveOXlkBp8s5QWrrAoPlQl+FKUQIcre0W2N0kNq1rAuVEqd1XZZ
	 mObSxfsldL1eBZAaMOeO3yg0uhv6aztch2dVVDTeHnHJzodsuA6g57zCFVgr1QeyVS
	 G9a5NzKofDDpdoQVcb9RnXaHspVl9K0FMi/CsQ5hO62JGQpLFCWDMeNVgaiYWKHQlG
	 QnTcRagqL9ENg==
Date: Mon, 27 May 2024 15:57:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally
 <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, Rob Herring
 <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: (ltc2992) Use
 fwnode_for_each_available_child_node_scoped()
Message-ID: <20240527155717.58292509@jic23-huawei>
In-Reply-To: <ZlSY8tjYm5g9bEJ_@surfacebook.localdomain>
References: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
	<20240523-fwnode_for_each_available_child_node_scoped-v2-3-701f3a03f2fb@gmail.com>
	<20240526144851.493dd3f2@jic23-huawei>
	<ZlSY8tjYm5g9bEJ_@surfacebook.localdomain>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 17:30:10 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Sun, May 26, 2024 at 02:48:51PM +0100, Jonathan Cameron kirjoitti:
> > On Thu, 23 May 2024 17:47:16 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >   
> > > The scoped version of the fwnode_for_each_available_child_node() macro
> > > automates object recfount decrement, avoiding possible memory leaks
> > > in new error paths inside the loop like it happened when
> > > commit '10b029020487 ("hwmon: (ltc2992) Avoid division by zero")'
> > > was added.
> > > 
> > > The new macro removes the need to manually call fwnode_handle_put() in
> > > the existing error paths and in any future addition. It also removes the
> > > need for the current child node declaration as well, as it is internally
> > > declared.
> > > 
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
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
> > as done here.  
> 
> > Or just add the device_for_each_available_child_node[_scoped]()
> > and call that in almost all cases.  
> 
> device_for_each*() _implies_ availability. You need to talk to Rob about all
> this. The design of the device_for_each*() was exactly done in accordance with
> his suggestions...
> 

Does it imply that for ACPI? I can't find a query of _STA in the callbacks
(which is there for the for fwnode_*available calls.
Mind you it wouldn't be the first time I've missed something in the ACPI parsing
code, so maybe it is there indirectly.

I know from previous discussions that the DT version was intentional, but
I'm nervous that the same assumptions don't apply to ACPI.

> > In generic code, do we ever want to walk unavailable child nodes?  
> 
> ...which are most likely like your question here, i.e. why we ever need to
> traverse over unavailable nodes.
> 

Jonathan


