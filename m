Return-Path: <linux-acpi+bounces-6004-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6838D0512
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 17:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2A9283CD1
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 15:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F8116C440;
	Mon, 27 May 2024 14:31:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33115FD1B
	for <linux-acpi@vger.kernel.org>; Mon, 27 May 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716820284; cv=none; b=Q+nEOaqddeNcbuX168axxtsM0CAGT1rGYUryTvSiv0RaD7aNT2wUvbSodc7F2rUeTB+MHcpDkmX+LGijnomQyc3bnQp15CQtB3gwTDvOG9BSJr7lb8PnhqFE11syJtRz++kWukhOQ2xwb/oB+JAa4dx7YR8c8L189RbKEolpnL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716820284; c=relaxed/simple;
	bh=zQPbdgs7RCJg4Qq0wbiVF+3cbUHM+UsGXZAKlfdrC84=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYwnXbs76dBzO6MwzB+Pcr8j+mk3ZfLs1U0Zu/VmoTK0olZpofI4ktvjnQNrAtm4Sahkv5DaBJGlM6Ll1fJmubSRJrLdSZVY5fm+xuZC4+qurJKLgKtHU5HpPI3OJysofBqV9NaLxkn9xFHbf9nyEwowRIzLLMY+Cs6UxFF2EHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 9f91693c-1c35-11ef-80bb-005056bdfda7;
	Mon, 27 May 2024 17:30:11 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 27 May 2024 17:30:10 +0300
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: (ltc2992) Use
 fwnode_for_each_available_child_node_scoped()
Message-ID: <ZlSY8tjYm5g9bEJ_@surfacebook.localdomain>
References: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
 <20240523-fwnode_for_each_available_child_node_scoped-v2-3-701f3a03f2fb@gmail.com>
 <20240526144851.493dd3f2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526144851.493dd3f2@jic23-huawei>

Sun, May 26, 2024 at 02:48:51PM +0100, Jonathan Cameron kirjoitti:
> On Thu, 23 May 2024 17:47:16 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
> > The scoped version of the fwnode_for_each_available_child_node() macro
> > automates object recfount decrement, avoiding possible memory leaks
> > in new error paths inside the loop like it happened when
> > commit '10b029020487 ("hwmon: (ltc2992) Avoid division by zero")'
> > was added.
> > 
> > The new macro removes the need to manually call fwnode_handle_put() in
> > the existing error paths and in any future addition. It also removes the
> > need for the current child node declaration as well, as it is internally
> > declared.
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> This looks like another instances of the lack of clarify about 
> what device_for_each_child_node[_scoped]() guarantees about node availability.
> On DT it guarantees the node is available as ultimately calls
> of_get_next_available_child()
> 
> On ACPI it doesn't (I think).
> For swnode, there isn't an obvious concept of available.
> 
> It would be much better if we reached some agreement on this and
> hence could avoid using the fwnode variants just to get the _available_ form
> as done here.

> Or just add the device_for_each_available_child_node[_scoped]()
> and call that in almost all cases.

device_for_each*() _implies_ availability. You need to talk to Rob about all
this. The design of the device_for_each*() was exactly done in accordance with
his suggestions...

> In generic code, do we ever want to walk unavailable child nodes?

...which are most likely like your question here, i.e. why we ever need to
traverse over unavailable nodes.


-- 
With Best Regards,
Andy Shevchenko



