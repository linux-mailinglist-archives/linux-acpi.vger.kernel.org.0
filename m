Return-Path: <linux-acpi+bounces-12355-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D8BA6945D
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Mar 2025 17:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABDD4617C1
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Mar 2025 16:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706331DF996;
	Wed, 19 Mar 2025 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpFeec+x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457121DE89C;
	Wed, 19 Mar 2025 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400459; cv=none; b=IyqN47YnucwcuVcZTrmeR8CMO+H1OcY1gM6+bVmd1kjg3a2dOv/Is7OB8qc6O8QP5ChKH6BKqas8TJN3Lina1wkANtj+BkXpfTTHH2g+NqujRL3g9QJIj7lxGT0Y/SJ6qwFz3xDIJbzq4ErcWfdogprDgmxB8hH4RepVmwIybCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400459; c=relaxed/simple;
	bh=aGHM62jgLSXEa+F+Tgt8kWVrUa52H5ydgZvLecuXoto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmiVN3u4nr/MfIXYywTWWPIZ+EseyqihEy+dm92a957t1UUSwQ2gRFGlUG7RDIvPkTLc18etVRw/ON4Uh4B7KDQ481q+OnR8dFqp8KGl9NfHsRoELqMWXzDR3Ob41v8gG0XB5H6vHbs1K69I52ZMWoqCfCRdwp6UO11XWPZZ3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpFeec+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE30C4CEE8;
	Wed, 19 Mar 2025 16:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742400458;
	bh=aGHM62jgLSXEa+F+Tgt8kWVrUa52H5ydgZvLecuXoto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GpFeec+xj+3wBwxXkPqA1K1IPZZ3UadT8dSCWfg5GzCniZCZKAGLXS8kiv1dCqoIq
	 HjHIM0XpqFzgSPx8lO6PYqyXFdygaShscQXpjzbiK3xbJKHiIPYlVWkLrE+107wkgI
	 PFndQHpCSx1V7NHnsheGmW5bLh4IMOdm8xFJJ/TPuAjJHGVyZD78kj6sLSvqO3J2wj
	 3wEP+6OCEomu8MfmWmwLzc5juMUtLi8PwvWZiItibRE5VBNAEFs3TI6Oo38kXgTU4s
	 z9fzg8D2LOfCf4fT9zJIXXNMRMt8FcJjvEHxyXyTRyMmXKyesbVJ+XejT/w1brIkdu
	 HawLUyhU3zgOA==
Date: Wed, 19 Mar 2025 16:07:28 +0000
From: Simon Horman <horms@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 09/10] net: gianfar: Use
 device_get_child_node_count_named()
Message-ID: <20250319160728.GA776230@kernel.org>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
 <95b6015cd5f6fcce535982118543d47504ed609f.1742225817.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95b6015cd5f6fcce535982118543d47504ed609f.1742225817.git.mazziesaccount@gmail.com>

On Mon, Mar 17, 2025 at 05:52:25PM +0200, Matti Vaittinen wrote:
> We can avoid open-coding the loop construct which counts firmware child
> nodes with a specific name by using the newly added
> device_get_child_node_count_named().
> 
> The gianfar driver has such open-coded loop. Replace it with the
> device_get_child_node_count_named().
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch looks good to me.
But I think it would be best to resubmit it,
as a standalone patch for net-next, once
it's dependencies are present in net-next.

-- 
pw-bot: defer



