Return-Path: <linux-acpi+bounces-19776-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D98ACD5FE9
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 13:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA25E300D4E9
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 12:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4148729ACF0;
	Mon, 22 Dec 2025 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXy/XoJ+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F1299A8F;
	Mon, 22 Dec 2025 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766406984; cv=none; b=dLiDebhokhBq+Ngqu2d3hwW+lNDO9u+cZaqj30OtbWXRanLNi8/L7IoL2UWagfBjPNRV/EavpiUfOhh02Q6p4Wh+ZI3jk+4wXsxdV3hmvFvuLW9SSONcC8dRF+RbEocjOdFH0rKPhFMp1H9UmsJHZsW4WZ2XI2GjpAwAUgQrpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766406984; c=relaxed/simple;
	bh=tbFYKxUOSlA0KToS4kDg9XSdqJ8YSku4CvdxiBN4Dd8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qlxlG7g4yvDjyb8vSL7rYE7jghQi+/Od0emHbkoHxX9A1lNxjOxlLBDc+qXFDNK8ed8GprLxKp7mZvdmYaiLa0talI2S2tTqeGk/bzHx7Iuz97Mlb6NZZQWzKLZvw9z9MAHlbIJUV2mUb/NnSWns+NztOSqMLkXx918VjQJi1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXy/XoJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D0AC4CEF1;
	Mon, 22 Dec 2025 12:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766406983;
	bh=tbFYKxUOSlA0KToS4kDg9XSdqJ8YSku4CvdxiBN4Dd8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=AXy/XoJ+Xt3NubyEeDjxq+LMg37YqXHFUNX9FEBvBdgUFa1bEFD+p0iqfwjiN8hrm
	 G20MJmQaXY5Qx4YhqJgmg+ctFVB2c3wPCH1klpr57rqWI60kbmOiLPSsI3FNmWZmxr
	 w3DRJNMnj8AYMkKDGhG3WTc981IW/kYivwKG2rf/jzjaoafrrbkACqs7sv43UvtvMT
	 6MJE4cRXpgYHj4JaW4HxLA2gtBWf7NWN8hgoJHJe8XNGWvKkI8XmOaeGryJKgMrWyz
	 h9vcA3+Qolz31eb/+8a6PWF5kKoVTi2PESqrm65bkubwkCQWaToGSc/qHU3llzf18m
	 oOYQVEFr5e2mw==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Dec 2025 13:36:18 +0100
Message-Id: <DF4R0JL2BCZ7.1J4OBNCK8S1M3@kernel.org>
Subject: Re: [PATCH 1/1] software node: Also support referencing
 non-constant software nodes
Cc: <linux-kernel@vger.kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, "Daniel Scally"
 <djrscally@gmail.com>, "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Linus Walleij" <linus.walleij@linaro.org>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Charles Keepax" <ckeepax@opensource.cirrus.com>,
 <linux-acpi@vger.kernel.org>, "Kenneth Crudup" <kenny@panix.com>,
 <linux-media@vger.kernel.org>, <johannes.goede@oss.qualcomm.com>, "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>
To: "Sakari Ailus" <sakari.ailus@linux.intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <af773b82-bef2-4209-baaf-526d4661b7fc@panix.com>
 <20251219083638.2454138-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20251219083638.2454138-1-sakari.ailus@linux.intel.com>

On Fri Dec 19, 2025 at 9:36 AM CET, Sakari Ailus wrote:
> Fwnode references are be implemented differently if referenced node is a
> software node. _Generic() is used to differentiate between the two cases
> but only const software nodes were present in the selection. Also add
> non-const software nodes.
>
> Reported-by: Kenneth Crudup <kenny@panix.com>
> Closes: https://lore.kernel.org/all/af773b82-bef2-4209-baaf-526d4661b7fc@=
panix.com/
> Fixes: d7cdbbc93c56 ("software node: allow referencing firmware nodes")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Applied to driver-core-linus, thanks!

